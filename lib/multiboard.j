
library hmb initializer init needs hWeather

    globals

        private multiboard mb_allPlayer = null
        private multiboard mb_simple = null
        private multiboard mb_value = null
        private string array mb_show

        /* 多面板 */
        //多面板检查，用来检查此用户是否已经显示在上面
        //用来跳过那些非玩家 无玩家的玩家列
        //这样3个玩家就只会显示3个，而不需要多余的列来显示null
        private boolean array MultiboardCheck

    endglobals

	/**
     * 创建多面板
     */
    private function buildCall takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local string array nameStr
        local string array apmStr //APM字符
        local integer mbrow = 1
        set i = 1
        loop
            exitwhen i > player_max_qty
				if( hPlayer_getBattleStatus(players[i]) == player_default_status_nil )then
					//nothing
				else
                    set mbrow = mbrow+1
				endif
            set i = i + 1
        endloop
        if(mb_allPlayer == null) then
            set mb_allPlayer = CreateMultiboard()
            call MultiboardSetRowCount(mb_allPlayer, mbrow)
            call MultiboardSetColumnCount(mb_allPlayer, 9)
            call MultiboardSetItemWidthBJ( mb_allPlayer, 0, 0, 3.50 )
            call MultiboardSetItemStyleBJ( mb_allPlayer, 0, 0, true, false )
            call MultiboardSetItemValueBJ( mb_allPlayer, 1, 1, "玩家名称" )
            call MultiboardSetItemWidthBJ( mb_allPlayer, 1, 0, 5.00 )
            call MultiboardSetItemValueBJ( mb_allPlayer, 2, 1, "英雄" )
            call MultiboardSetItemWidthBJ( mb_allPlayer, 2, 0, 7.00 )
            call MultiboardSetItemStyleBJ( mb_allPlayer, 2, 0, true, true )//显示图标
            call MultiboardSetItemValueBJ( mb_allPlayer, 3, 1, "黄金" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 4, 1, "木头" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 5, 1, "杀敌数" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 6, 1, "造成伤害" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 7, 1, "承受伤害" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 8, 1, "状态" )
            call MultiboardSetItemValueBJ( mb_allPlayer, 9, 1, "APM" )
        endif
        if(mb_simple == null) then
            set mb_simple = CreateMultiboard()
            call MultiboardSetRowCount(mb_simple, 20)
            call MultiboardSetColumnCount(mb_simple, 12)
            call MultiboardSetItemWidthBJ( mb_simple, 0, 0, 4.50 )
            call MultiboardSetItemStyleBJ( mb_simple, 0, 0, true, false )
        endif
        if(mb_value == null) then
            set mb_value = CreateMultiboard()
            call MultiboardSetRowCount(mb_value, 8)
            call MultiboardSetColumnCount(mb_value, 3)
            call MultiboardSetItemStyleBJ( mb_value, 0, 0, true, false )
        endif
        call MultiboardSetTitleText(mb_allPlayer, "全玩家情报 - "+time.his())
        call MultiboardSetTitleText(mb_simple, "个人情报 - "+time.his())
        call MultiboardSetTitleText(mb_value, "实时情报 - "+time.his())
        set i = 1
        set j = 1
        loop
            exitwhen i > player_max_qty
            if ( hPlayer_getBattleStatus(players[i]) != player_default_status_nil ) then
                if(GetLocalPlayer()==players[i] and mb_show[i] == "allPlayer")then
                    set j = j + 1
                    call MultiboardSetItemValueBJ( mb_allPlayer, 1, j, GetPlayerName(players[i]) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 2, j, "Lv "+I2S(GetUnitLevel(hPlayer_getHero(players[i])))+"."+GetUnitName(hPlayer_getHero(players[i])) )
                    call MultiboardSetItemIconBJ( mb_allPlayer,  2, j, "ReplaceableTextures\\CommandButtons\\BTNNecromancer.blp" )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 3, j, I2S(hPlayer_getGold(players[i])) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 4, j, I2S(hPlayer_getLumber(players[i])) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 5, j, I2S(hPlayer_getKill(players[i])) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 6, j, math.realformat(hPlayer_getDamage(players[i])) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 7, j, math.realformat(hPlayer_getBeDamage(players[i])) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 8, j, hPlayer_getBattleStatus(players[i]) )
                    call MultiboardSetItemValueBJ( mb_allPlayer, 9, j, I2S(hPlayer_getApm(players[i])) )
                    call MultiboardDisplay(mb_allPlayer, true)
                elseif(GetLocalPlayer()==players[i] and mb_show[i] == "simple")then
                    call MultiboardSetItemWidthBJ( mb_simple, 2, 0, 5.00 )
                    call MultiboardSetItemWidthBJ( mb_simple, 4, 0, 7.00 )
                    call MultiboardSetItemWidthBJ( mb_simple, 6, 0, 7.00 )
                    call MultiboardSetItemWidthBJ( mb_simple, 8, 0, 5.00 )
                    call MultiboardSetItemWidthBJ( mb_simple,10, 0, 5.00 )

                    call MultiboardSetItemValueBJ( mb_simple, 1, 1, "你的名字" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 2, "黄金" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 3, "木头" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 4, "黄金率" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 5, "木头率" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 6, "经验率" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 7, "杀敌数" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 8, "造成伤害" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 9, "承受伤害" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 10, "状态" )
                    call MultiboardSetItemValueBJ( mb_simple, 1, 11, "APM" )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 1, GetPlayerName(players[i]) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 2, I2S(hPlayer_getGold(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 3, I2S(hPlayer_getLumber(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 4, R2S(hAttrExt_getGoldRatio(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 5, R2S(hAttrExt_getLumberRatio(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 6, R2S(hAttrExt_getExpRatio(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 7, I2S(hPlayer_getKill(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 8, math.realformat(hPlayer_getDamage(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 9, math.realformat(hPlayer_getBeDamage(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 10, hPlayer_getBattleStatus(players[i]) )
                    call MultiboardSetItemValueBJ( mb_simple, 2, 11, I2S(hPlayer_getApm(players[i])) )
                    
                    call MultiboardSetItemValueBJ( mb_simple, 3, 1, "英雄名称" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 2, "英雄等级" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 3, "英雄类型" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 4, "生命" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 5, "魔法" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 6, "生命源" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 7, "魔法源" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 8, "生命恢复" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 9, "魔法恢复" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 10, "物理攻击" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 11, "魔法攻击" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 12, "攻击速度" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 13, "力量" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 14, "敏捷" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 15, "智力" )
                    call MultiboardSetItemValueBJ( mb_simple, 3, 16, "移动力" )
                    call MultiboardSetItemStyleBJ( mb_simple, 4, 1, true, true )//显示图标
                    call MultiboardSetItemIconBJ(  mb_simple, 4, 1, "ReplaceableTextures\\CommandButtons\\BTNNecromancer.blp" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 1, GetUnitName(hPlayer_getHero(players[i])) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 2, "Lv "+I2S(GetUnitLevel(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 3, "type" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 4, I2S(R2I(hAttr_getLife(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 5, I2S(R2I(hAttr_getMana(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 6, I2S(R2I(hAttrExt_getLifeSourceCurrent(hPlayer_getHero(players[i]))))+"/"+I2S(R2I(hAttrExt_getLifeSource(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 7, I2S(R2I(hAttrExt_getManaSourceCurrent(hPlayer_getHero(players[i]))))+"/"+I2S(R2I(hAttrExt_getManaSource(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 8, R2S(hAttrExt_getLifeBack(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 9, R2S(hAttrExt_getManaBack(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 10, I2S(R2I(hAttr_getAttackPhysical(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 11, I2S(R2I(hAttr_getAttackMagic(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 12, I2S(R2I(hAttr_getAttackSpeed(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 13, I2S(R2I(hAttr_getStrWhite(hPlayer_getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hAttr_getStr(hPlayer_getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 14, I2S(R2I(hAttr_getAgiWhite(hPlayer_getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hAttr_getAgi(hPlayer_getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 15, I2S(R2I(hAttr_getIntWhite(hPlayer_getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hAttr_getInt(hPlayer_getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 4, 16, I2S(R2I(hAttr_getMove(hPlayer_getHero(players[i])))) )

                    call MultiboardSetItemValueBJ( mb_simple, 5, 1, "护甲" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 2, "魔抗" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 3, "回避" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 4, "命中" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 5, "韧性" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 6, "物理暴击" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 7, "魔法暴击" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 8, "致命抵抗" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 9, "分裂" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 10, "吸血" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 11, "技能吸血" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 12, "眩晕抵抗" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 13, "救助力" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 14, "运气" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 15, "无敌" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 16, "伤害增幅" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 17, "伤害反射" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 18, "治疗" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 19, "硬直" )
                    call MultiboardSetItemValueBJ( mb_simple, 5, 20, "负重" )
                    
                    call MultiboardSetItemValueBJ( mb_simple, 6, 1, I2S(R2I(hAttr_getDefend(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 2, R2S(hAttrExt_getResistance(hPlayer_getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 3, R2S(hAttrExt_getAvoid(hPlayer_getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 4, R2S(hAttrExt_getAim(hPlayer_getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 5, R2S(hAttrExt_getToughness(hPlayer_getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 6, I2S(R2I(hAttrExt_getKnocking(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 7, I2S(R2I(hAttrExt_getViolence(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 8, I2S(R2I(hAttrExt_getMortalOppose(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 9, I2S(R2I(hAttrExt_getSplit(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 10, I2S(R2I(hAttrExt_getHemophagia(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 11, I2S(R2I(hAttrExt_getHemophagiaSkill(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 12, R2S(hAttrExt_getSwimOppose(hPlayer_getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 13, I2S(R2I(hAttrExt_getHelp(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 14, I2S(R2I(hAttrExt_getLuck(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 15, I2S(R2I(hAttrExt_getInvincible(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 16, I2S(R2I(hAttrExt_getHuntAmplitude(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 17, I2S(R2I(hAttrExt_getHuntRebound(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 18, I2S(R2I(hAttrExt_getCure(hPlayer_getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 19, I2S(R2I(hAttrExt_getPunishCurrent(hPlayer_getHero(players[i]))))+"/"+I2S(R2I(hAttrExt_getPunish(hPlayer_getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( mb_simple, 6, 20, I2S(R2I(hAttrExt_getWeightCurrent(hPlayer_getHero(players[i]))))+"/"+I2S(R2I(hAttrExt_getWeight(hPlayer_getHero(players[i])))) )

                    call MultiboardSetItemValueBJ( mb_simple, 7, 1, "攻增:生命恢复" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 2, "攻增:魔法恢复" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 3, "攻增:攻击速度" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 4, "攻增:物理攻击" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 5, "攻增:魔法攻击" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 6, "攻增:移动力" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 7, "攻增:力量" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 8, "攻增:敏捷" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 9, "攻增:智力" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 10, "攻增:物理暴击" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 11, "攻增:魔法暴击" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 12, "攻增:命中" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 13, "攻增:分裂" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 14, "攻增:吸血" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 15, "攻增:技能吸血" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 16, "攻增:运气" )
                    call MultiboardSetItemValueBJ( mb_simple, 7, 17, "攻增:伤害增幅" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 1, I2S(R2I(hAttrEffect_getLifeBack(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getLifeBackDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 2, I2S(R2I(hAttrEffect_getManaBack(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getManaBackDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 3, I2S(R2I(hAttrEffect_getAttackSpeed(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getAttackSpeedDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 4, I2S(R2I(hAttrEffect_getAttackPhysical(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getAttackPhysicalDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 5, I2S(R2I(hAttrEffect_getAttackMagic(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getAttackMagicDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 6, I2S(R2I(hAttrEffect_getMove(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getMoveDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 7, I2S(R2I(hAttrEffect_getStr(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getStrDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 8, I2S(R2I(hAttrEffect_getAgi(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getAgiDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 9, I2S(R2I(hAttrEffect_getInt(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getIntDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 10, I2S(R2I(hAttrEffect_getKnocking(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getKnockingDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 11, I2S(R2I(hAttrEffect_getViolence(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getViolenceDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 12, I2S(R2I(hAttrEffect_getAim(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getAimDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 13, I2S(R2I(hAttrEffect_getSplit(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getSplitDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 14, I2S(R2I(hAttrEffect_getHemophagia(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getHemophagiaDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 15, I2S(R2I(hAttrEffect_getHemophagiaSkill(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getHemophagiaSkillDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 16, I2S(R2I(hAttrEffect_getLuck(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getLuckDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple, 8, 17, I2S(R2I(hAttrEffect_getHuntAmplitude(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getHuntAmplitudeDuring(hPlayer_getHero(players[i])))+"秒)|r" )

                    call MultiboardSetItemValueBJ( mb_simple, 9, 1, "特效:中毒" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 2, "特效:枯竭" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 3, "特效:冻结" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 4, "特效:寒冷" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 5, "特效:迟钝" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 6, "特效:腐蚀" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 7, "特效:混乱" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 8, "特效:缠绕" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 9, "特效:致盲" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 10, "特效:剧痛" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 11, "特效:乏力" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 12, "特效:束缚" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 13, "特效:愚蠢" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 14, "特效:懒惰" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 15, "特效:眩晕" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 16, "特效:沉重" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 17, "特效:打断" )
                    call MultiboardSetItemValueBJ( mb_simple, 9, 18, "特效:倒霉" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 1, I2S(R2I(hAttrEffect_getPoison(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getPoisonDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 2, I2S(R2I(hAttrEffect_getDry(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getDryDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 3, I2S(R2I(hAttrEffect_getFreeze(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getFreezeDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 4, I2S(R2I(hAttrEffect_getCold(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getColdDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 5, I2S(R2I(hAttrEffect_getBlunt(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getBluntDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 6, I2S(R2I(hAttrEffect_getCorrosion(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getCorrosionDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 7, I2S(R2I(hAttrEffect_getChaos(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getChaosDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 8, I2S(R2I(hAttrEffect_getTwine(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getTwineDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 9, I2S(R2I(hAttrEffect_getBlind(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getBlindDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 10, I2S(R2I(hAttrEffect_getTortua(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getTortuaDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 11, I2S(R2I(hAttrEffect_getWeak(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getWeakDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 12, I2S(R2I(hAttrEffect_getBound(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getBoundDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 13, I2S(R2I(hAttrEffect_getFoolish(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getFoolishDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 14, I2S(R2I(hAttrEffect_getLazy(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getLazyDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 15, I2S(R2I(hAttrEffect_getSwim(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getSwimDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 16, I2S(R2I(hAttrEffect_getHeavy(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getHeavyDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 17, I2S(R2I(hAttrEffect_getBreak(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getBreakDuring(hPlayer_getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( mb_simple,10, 18, I2S(R2I(hAttrEffect_getUnluck(hPlayer_getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(hAttrEffect_getUnluckDuring(hPlayer_getHero(players[i])))+"秒)|r" )

                    call MultiboardSetItemValueBJ( mb_simple,11, 1, "火攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 2, "土攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 3, "水攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 4, "风攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 5, "光攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 6, "暗攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 7, "木攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 8, "雷攻击" )
                    call MultiboardSetItemValueBJ( mb_simple,11, 9, "火抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,10, "土抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,11, "水抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,12, "风抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,13, "光抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,14, "暗抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,15, "木抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,11,16, "雷抗性" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 1, I2S(R2I(hAttrNatural_getFire(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 2, I2S(R2I(hAttrNatural_getSoil(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 3, I2S(R2I(hAttrNatural_getWater(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 4, I2S(R2I(hAttrNatural_getWind(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 5, I2S(R2I(hAttrNatural_getLight(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 6, I2S(R2I(hAttrNatural_getDark(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 7, I2S(R2I(hAttrNatural_getWood(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 8, I2S(R2I(hAttrNatural_getThunder(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12, 9, I2S(R2I(hAttrNatural_getFireOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,10, I2S(R2I(hAttrNatural_getSoilOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,11, I2S(R2I(hAttrNatural_getWaterOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,12, I2S(R2I(hAttrNatural_getWindOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,13, I2S(R2I(hAttrNatural_getLightOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,14, I2S(R2I(hAttrNatural_getDarkOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,15, I2S(R2I(hAttrNatural_getWoodOppose(hPlayer_getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( mb_simple,12,16, I2S(R2I(hAttrNatural_getThunderOppose(hPlayer_getHero(players[i])))) +"%" )

                    call MultiboardDisplay(mb_simple, true)
                elseif(GetLocalPlayer()==players[i] and mb_show[i] == "value")then
                    call MultiboardSetItemWidthBJ( mb_value, 1, 0, 3.00 )
                    call MultiboardSetItemWidthBJ( mb_value, 2, 0, 10.00 )
                    call MultiboardSetItemWidthBJ( mb_value, 3, 0, 6.00 )
                    call MultiboardSetItemValueBJ( mb_value, 1, 1, "" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 2, "生命量" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 3, "生命源" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 4, "魔法量" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 5, "魔法源" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 6, "移动力" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 7, "僵直度" )
                    call MultiboardSetItemValueBJ( mb_value, 1, 8, "负重量" )
                    call MultiboardSetItemValueBJ( mb_value, 2, 1, "" )
                    call MultiboardSetItemValueBJ( mb_value, 2, 2, hAttrUnit_createBlockText(hunit.getLife(hPlayer_getHero(players[i])),hunit.getMaxLife(hPlayer_getHero(players[i])),30,"4bf14f","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 3, hAttrUnit_createBlockText(hAttrExt_getLifeSourceCurrent(hPlayer_getHero(players[i])),hAttrExt_getLifeSource(hPlayer_getHero(players[i])),30,"92f693","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 4, hAttrUnit_createBlockText(hunit.getMana(hPlayer_getHero(players[i])),hunit.getMaxMana(hPlayer_getHero(players[i])),30,"3192ed","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 5, hAttrUnit_createBlockText(hAttrExt_getManaSourceCurrent(hPlayer_getHero(players[i])),hAttrExt_getManaSource(hPlayer_getHero(players[i])),30,"90c4f3","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 6, hAttrUnit_createBlockText(hAttr_getMove(hPlayer_getHero(players[i])),522,30,"f36dc4","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 7, hAttrUnit_createBlockText(hAttrExt_getPunishCurrent(hPlayer_getHero(players[i])),hAttrExt_getPunish(hPlayer_getHero(players[i])),30,"f8f5ec","4f4f4a") )
                    call MultiboardSetItemValueBJ( mb_value, 2, 8, hAttrUnit_createBlockText(hAttrExt_getWeightCurrent(hPlayer_getHero(players[i])),hAttrExt_getWeight(hPlayer_getHero(players[i])),30,"f3eb90","f2e121") )
                    call MultiboardSetItemValueBJ( mb_value, 3, 1, "数值" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 2, "|cff4bf14f"+R2S(hunit.getLife(hPlayer_getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxLife(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 3, "|cff92f693"+R2S(hAttrExt_getLifeSourceCurrent(hPlayer_getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hAttrExt_getLifeSource(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 4, "|cff3192ed"+R2S(hunit.getMana(hPlayer_getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxMana(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 5, "|cff90c4f3"+R2S(hAttrExt_getManaSourceCurrent(hPlayer_getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hAttrExt_getManaSource(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 6, "|cff4f4f4a"+R2S(hAttr_getMove(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 7, "|cfff8f5ec"+R2S(hAttrExt_getPunishCurrent(hPlayer_getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hAttrExt_getPunish(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( mb_value, 3, 8, "|cfff3eb90"+R2S(hAttrExt_getWeightCurrent(hPlayer_getHero(players[i])))+"|r / |cfff2e121"+R2S(hAttrExt_getWeight(hPlayer_getHero(players[i])))+"|r" )
                    call MultiboardDisplay(mb_value, true)
                endif
            endif
            set i = i + 1
        endloop
    endfunction
    public function build takes nothing returns nothing
        call time.setInterval(0.5,function buildCall)
    endfunction

    private function start takes nothing returns nothing
        call build()
    endfunction

    private function mbap takes nothing returns nothing
        set mb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "allPlayer"
    endfunction
    private function mbs takes nothing returns nothing
        set mb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "simple"
    endfunction
    private function mbv takes nothing returns nothing
        set mb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "value"
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0
        local trigger startTrigger = null
        local trigger mbapTrigger = null
        local trigger mbsTrigger = null
        local trigger mbvTrigger = null

        set startTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle( startTrigger, 0.00 )
        call TriggerAddAction(startTrigger, function start)

        set mbapTrigger = CreateTrigger()
        set mbsTrigger = CreateTrigger()
        set mbvTrigger = CreateTrigger()

        set i = 1
        loop
            exitwhen i > player_max_qty
                call TriggerRegisterPlayerChatEvent( mbapTrigger, players[i], "-mbap", true )
                call TriggerAddAction(mbapTrigger, function mbap)
                call TriggerRegisterPlayerChatEvent( mbsTrigger, players[i], "-mbs", true )
                call TriggerAddAction(mbsTrigger, function mbs)
                call TriggerRegisterPlayerChatEvent( mbvTrigger, players[i], "-mbv", true )
                call TriggerAddAction(mbvTrigger, function mbv)
                if( mb_show[i] == null)then
                    set mb_show[i] = "allPlayer"
                endif
            set i = i + 1
        endloop
    endfunction

endlibrary
