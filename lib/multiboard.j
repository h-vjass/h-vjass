
 globals

    hMultiboard hmb = 0
    multiboard hmb_allPlayer = null
    multiboard hmb_my = null
    multiboard hmb_value = null
    multiboard hmb_selection = null
    multiboard hmb_selectionEffect = null
    integer hmb_value_block = 20
    string array hmb_show

    /* 多面板 */
    //多面板检查，用来检查此用户是否已经显示在上面
    //用来跳过那些非玩家 无玩家的玩家列
    //这样3个玩家就只会显示3个，而不需要多余的列来显示null
    boolean array MultiboardCheck

endglobals

struct hMultiboard


	/**
     * 创建多面板
     */
    private static method buildCall takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local string array nameStr
        local string array apmStr //APM字符
        local integer mbrow = 1
        set i = 1
        loop
            exitwhen i > player_max_qty
				if( hplayer.getBattleStatus(players[i]) == hplayer.default_status_nil )then
					//nothing
				else
                    set mbrow = mbrow+1
				endif
            set i = i + 1
        endloop
        if(hmb_allPlayer == null) then
            set hmb_allPlayer = CreateMultiboard()
            call MultiboardSetRowCount(hmb_allPlayer, mbrow)
            call MultiboardSetColumnCount(hmb_allPlayer, 13)
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 0, 0, 3.50 )
            call MultiboardSetItemStyleBJ( hmb_allPlayer, 0, 0, true, false )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 1, 1, "玩家名称" )
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 1, 0, 5.00 )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 2, 1, "英雄" )
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 2, 0, 7.00 )
            call MultiboardSetItemStyleBJ( hmb_allPlayer, 2, 0, true, true )//显示图标
            call MultiboardSetItemValueBJ( hmb_allPlayer, 3, 1, "黄金" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 4, 1, "木头" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 5, 1, "杀敌数" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 6, 1, "造成伤害" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 7, 1, "承受伤害" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 8, 1, "获金总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 9, 1, "获木总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,10, 1, "耗金总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,11, 1, "耗木总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,12, 1, "状态" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,13, 1, "APM" )
        endif
        if(hmb_my == null) then
            set hmb_my = CreateMultiboard()
            call MultiboardSetRowCount(hmb_my, 20)
            call MultiboardSetColumnCount(hmb_my, 12)
            call MultiboardSetItemWidthBJ( hmb_my, 0, 0, 4.50 )
            call MultiboardSetItemStyleBJ( hmb_my, 0, 0, true, false )
            call MultiboardSetItemWidthBJ( hmb_my, 2, 0, 5.00 )
            call MultiboardSetItemWidthBJ( hmb_my, 4, 0, 7.00 )
            call MultiboardSetItemWidthBJ( hmb_my, 6, 0, 7.00 )
            call MultiboardSetItemWidthBJ( hmb_my, 8, 0, 5.00 )
            call MultiboardSetItemWidthBJ( hmb_my,10, 0, 5.00 )
        endif
        if(hmb_value == null) then
            set hmb_value = CreateMultiboard()
            call MultiboardSetRowCount(hmb_value, 8)
            call MultiboardSetColumnCount(hmb_value, 3)
            call MultiboardSetItemStyleBJ( hmb_value, 0, 0, true, false )
            call MultiboardSetItemWidthBJ( hmb_value, 1, 0, 3.00 )
            call MultiboardSetItemWidthBJ( hmb_value, 2, 0, 10.00 )
            call MultiboardSetItemWidthBJ( hmb_value, 3, 0, 6.00 )
        endif
        if(hmb_selection == null) then
            set hmb_selection = CreateMultiboard()
            call MultiboardSetRowCount(hmb_selection, 28)
            call MultiboardSetColumnCount(hmb_selection, 3)
            call MultiboardSetItemWidthBJ( hmb_selection, 0, 0, 4.00 )
            call MultiboardSetItemStyleBJ( hmb_selection, 0, 0, true, false )
            call MultiboardSetItemWidthBJ( hmb_selection, 2, 0, 10.00 )
            call MultiboardSetItemWidthBJ( hmb_selection, 3, 0, 6.00 )
        endif
        if(hmb_selectionEffect == null) then
            set hmb_selectionEffect = CreateMultiboard()
            call MultiboardSetRowCount(hmb_selectionEffect, 26)
            call MultiboardSetColumnCount(hmb_selectionEffect, 4)
            call MultiboardSetItemWidthBJ( hmb_selectionEffect, 0, 0, 5.00 )
            call MultiboardSetItemStyleBJ( hmb_selectionEffect, 0, 0, true, false )
        endif
        call MultiboardSetTitleText(hmb_allPlayer, "全玩家情报 - "+time.his())
        call MultiboardSetTitleText(hmb_my, "个人情报 - "+time.his())
        call MultiboardSetTitleText(hmb_value, "实时情报 - "+time.his())
        call MultiboardSetTitleText(hmb_selection, "单位情报 - "+time.his())
        call MultiboardSetTitleText(hmb_selectionEffect, "单位特效 - "+time.his())
        set i = 1
        set j = 1
        loop
            exitwhen i > player_max_qty
            if ( hplayer.getBattleStatus(players[i]) != hplayer.default_status_nil ) then
                if(GetLocalPlayer()==players[i] and hmb_show[i] == "allPlayer")then
                    set j = j + 1
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 1, j, GetPlayerName(players[i]) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 2, j, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[i])))+"."+GetUnitName(hplayer.getHero(players[i])) )
                    call MultiboardSetItemIconBJ( hmb_allPlayer,  2, j, "ReplaceableTextures\\CommandButtons\\BTNNecromancer.blp" )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 3, j, I2S(hplayer.getGold(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 4, j, I2S(hplayer.getLumber(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 5, j, I2S(hplayer.getKill(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 6, j, math.realformat(hplayer.getDamage(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 7, j, math.realformat(hplayer.getBeDamage(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 8, j, math.realformat(hplayer.getTotalGold(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer, 9, j, math.realformat(hplayer.getTotalLumber(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer,10, j, math.realformat(hplayer.getTotalGoldCost(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer,11, j, math.realformat(hplayer.getTotalLumberCost(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer,12, j, hplayer.getBattleStatus(players[i]) )
                    call MultiboardSetItemValueBJ( hmb_allPlayer,13, j, I2S(hplayer.getApm(players[i])) )
                    call MultiboardDisplay(hmb_allPlayer, true)
                elseif(GetLocalPlayer()==players[i] and hmb_show[i] == "my")then
                    call MultiboardSetItemValueBJ( hmb_my, 1, 1, "你的名字" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 2, "黄金" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 3, "木头" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 4, "黄金率" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 5, "木头率" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 6, "经验率" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 7, "杀敌数" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 8, "造成伤害" )
                    call MultiboardSetItemValueBJ( hmb_my, 1, 9, "承受伤害" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,10, "获金总量" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,11, "获木总量" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,12, "耗金总量" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,13, "耗木总量" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,14, "状态" )
                    call MultiboardSetItemValueBJ( hmb_my, 1,15, "APM" )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 1, GetPlayerName(players[i]) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 2, I2S(hplayer.getGold(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 3, I2S(hplayer.getLumber(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 4, R2S(attrExt.getGoldRatio(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 5, R2S(attrExt.getLumberRatio(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 6, R2S(attrExt.getExpRatio(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 7, I2S(hplayer.getKill(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 8, math.realformat(hplayer.getDamage(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2, 9, math.realformat(hplayer.getBeDamage(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,10, math.realformat(hplayer.getTotalGold(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,11, math.realformat(hplayer.getTotalLumber(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,12, math.realformat(hplayer.getTotalGoldCost(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,13, math.realformat(hplayer.getTotalLumberCost(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,14, hplayer.getBattleStatus(players[i]) )
                    call MultiboardSetItemValueBJ( hmb_my, 2,15, I2S(hplayer.getApm(players[i])) )
                    
                    call MultiboardSetItemValueBJ( hmb_my, 3, 1, "英雄名称" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 2, "英雄等级" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 3, "英雄类型" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 4, "生命" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 5, "魔法" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 6, "生命源" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 7, "魔法源" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 8, "生命恢复" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 9, "魔法恢复" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 10, "物理攻击" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 11, "魔法攻击" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 12, "攻击速度" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 13, "力量" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 14, "敏捷" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 15, "智力" )
                    call MultiboardSetItemValueBJ( hmb_my, 3, 16, "移动力" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 17, "救助力" )
                    call MultiboardSetItemStyleBJ( hmb_my, 4, 1, true, true )//显示图标
                    call MultiboardSetItemIconBJ(  hmb_my, 4, 1, "ReplaceableTextures\\CommandButtons\\BTNNecromancer.blp" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 1, GetUnitName(hplayer.getHero(players[i])) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 2, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 3, "type" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 4, I2S(R2I(attr.getLife(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 5, I2S(R2I(attr.getMana(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 6, I2S(R2I(attrExt.getLifeSourceCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(attrExt.getLifeSource(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 7, I2S(R2I(attrExt.getManaSourceCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(attrExt.getManaSource(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 8, R2S(attrExt.getLifeBack(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 9, R2S(attrExt.getManaBack(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 10, I2S(R2I(attr.getAttackPhysical(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 11, I2S(R2I(attr.getAttackMagic(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 12, I2S(R2I(attr.getAttackSpeed(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 13, I2S(R2I(attr.getStrWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(attr.getStr(hplayer.getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 14, I2S(R2I(attr.getAgiWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(attr.getAgi(hplayer.getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 15, I2S(R2I(attr.getIntWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(attr.getInt(hplayer.getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 16, I2S(R2I(attr.getMove(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 4, 17, I2S(R2I(attrExt.getHelp(hplayer.getHero(players[i])))) )

                    call MultiboardSetItemValueBJ( hmb_my, 5, 1, "护甲" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 2, "魔抗" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 3, "回避" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 4, "命中" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 5, "韧性" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 6, "物理暴击" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 7, "魔法暴击" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 8, "致命抵抗" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 9, "分裂" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 10, "吸血" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 11, "技能吸血" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 12, "眩晕抵抗" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 13, "运气" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 14, "无敌" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 15, "伤害增幅" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 16, "伤害反射" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 17, "治疗" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 18, "硬直" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 19, "硬直抵抗" )
                    call MultiboardSetItemValueBJ( hmb_my, 5, 20, "负重" )
                    
                    call MultiboardSetItemValueBJ( hmb_my, 6, 1, I2S(R2I(attr.getDefend(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 2, R2S(attrExt.getResistance(hplayer.getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 3, R2S(attrExt.getAvoid(hplayer.getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 4, R2S(attrExt.getAim(hplayer.getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 5, R2S(attrExt.getToughness(hplayer.getHero(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 6, I2S(R2I(attrExt.getKnocking(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 7, I2S(R2I(attrExt.getViolence(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 8, I2S(R2I(attrExt.getMortalOppose(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 9, I2S(R2I(attrExt.getSplit(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 10, I2S(R2I(attrExt.getHemophagia(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 11, I2S(R2I(attrExt.getHemophagiaSkill(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 12, R2S(attrExt.getSwimOppose(hplayer.getHero(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 13, I2S(R2I(attrExt.getLuck(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 14, I2S(R2I(attrExt.getInvincible(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 15, I2S(R2I(attrExt.getHuntAmplitude(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 16, I2S(R2I(attrExt.getHuntRebound(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 17, I2S(R2I(attrExt.getCure(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 18, I2S(R2I(attrExt.getPunishCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(attrExt.getPunish(hplayer.getHero(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 19, I2S(R2I(attrExt.getPunishOppose(hplayer.getHero(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_my, 6, 20, I2S(R2I(attrExt.getWeightCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(attrExt.getWeight(hplayer.getHero(players[i])))) )

                    call MultiboardSetItemValueBJ( hmb_my, 7, 1, "攻增:生命恢复" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 2, "攻增:魔法恢复" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 3, "攻增:攻击速度" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 4, "攻增:物理攻击" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 5, "攻增:魔法攻击" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 6, "攻增:移动力" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 7, "攻增:力量" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 8, "攻增:敏捷" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 9, "攻增:智力" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 10, "攻增:物理暴击" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 11, "攻增:魔法暴击" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 12, "攻增:命中" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 13, "攻增:分裂" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 14, "攻增:吸血" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 15, "攻增:技能吸血" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 16, "攻增:运气" )
                    call MultiboardSetItemValueBJ( hmb_my, 7, 17, "攻增:伤害增幅" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 1, I2S(R2I(attrEffect.getLifeBack(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLifeBackDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 2, I2S(R2I(attrEffect.getManaBack(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getManaBackDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 3, I2S(R2I(attrEffect.getAttackSpeed(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackSpeedDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 4, I2S(R2I(attrEffect.getAttackPhysical(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackPhysicalDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 5, I2S(R2I(attrEffect.getAttackMagic(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackMagicDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 6, I2S(R2I(attrEffect.getMove(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getMoveDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 7, I2S(R2I(attrEffect.getStr(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getStrDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 8, I2S(R2I(attrEffect.getAgi(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAgiDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 9, I2S(R2I(attrEffect.getInt(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getIntDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 10, I2S(R2I(attrEffect.getKnocking(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getKnockingDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 11, I2S(R2I(attrEffect.getViolence(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getViolenceDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 12, I2S(R2I(attrEffect.getAim(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAimDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 13, I2S(R2I(attrEffect.getSplit(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getSplitDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 14, I2S(R2I(attrEffect.getHemophagia(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHemophagiaDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 15, I2S(R2I(attrEffect.getHemophagiaSkill(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHemophagiaSkillDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 16, I2S(R2I(attrEffect.getLuck(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLuckDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my, 8, 17, I2S(R2I(attrEffect.getHuntAmplitude(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHuntAmplitudeDuring(hplayer.getHero(players[i])))+"秒)|r" )

                    call MultiboardSetItemValueBJ( hmb_my, 9, 1, "特效:中毒" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 2, "特效:枯竭" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 3, "特效:冻结" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 4, "特效:寒冷" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 5, "特效:迟钝" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 6, "特效:腐蚀" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 7, "特效:混乱" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 8, "特效:缠绕" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 9, "特效:致盲" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 10, "特效:剧痛" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 11, "特效:乏力" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 12, "特效:束缚" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 13, "特效:愚蠢" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 14, "特效:懒惰" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 15, "特效:眩晕" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 16, "特效:沉重" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 17, "特效:打断" )
                    call MultiboardSetItemValueBJ( hmb_my, 9, 18, "特效:倒霉" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 1, I2S(R2I(attrEffect.getPoison(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getPoisonDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 2, I2S(R2I(attrEffect.getDry(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getDryDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 3, I2S(R2I(attrEffect.getFreeze(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getFreezeDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 4, I2S(R2I(attrEffect.getCold(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getColdDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 5, I2S(R2I(attrEffect.getBlunt(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBluntDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 6, I2S(R2I(attrEffect.getCorrosion(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getCorrosionDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 7, I2S(R2I(attrEffect.getChaos(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getChaosDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 8, I2S(R2I(attrEffect.getTwine(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getTwineDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 9, I2S(R2I(attrEffect.getBlind(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBlindDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 10, I2S(R2I(attrEffect.getTortua(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getTortuaDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 11, I2S(R2I(attrEffect.getWeak(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getWeakDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 12, I2S(R2I(attrEffect.getBound(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBoundDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 13, I2S(R2I(attrEffect.getFoolish(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getFoolishDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 14, I2S(R2I(attrEffect.getLazy(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLazyDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 15, I2S(R2I(attrEffect.getSwim(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getSwimDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 16, I2S(R2I(attrEffect.getHeavy(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHeavyDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 17, I2S(R2I(attrEffect.getBreak(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBreakDuring(hplayer.getHero(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_my,10, 18, I2S(R2I(attrEffect.getUnluck(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getUnluckDuring(hplayer.getHero(players[i])))+"秒)|r" )

                    call MultiboardSetItemValueBJ( hmb_my,11, 1, "火攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 2, "土攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 3, "水攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 4, "风攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 5, "光攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 6, "暗攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 7, "木攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 8, "雷攻击" )
                    call MultiboardSetItemValueBJ( hmb_my,11, 9, "火抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,10, "土抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,11, "水抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,12, "风抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,13, "光抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,14, "暗抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,15, "木抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,11,16, "雷抗性" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 1, I2S(R2I(attrNatural.getFire(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 2, I2S(R2I(attrNatural.getSoil(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 3, I2S(R2I(attrNatural.getWater(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 4, I2S(R2I(attrNatural.getWind(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 5, I2S(R2I(attrNatural.getLight(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 6, I2S(R2I(attrNatural.getDark(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 7, I2S(R2I(attrNatural.getWood(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 8, I2S(R2I(attrNatural.getThunder(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12, 9, I2S(R2I(attrNatural.getFireOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,10, I2S(R2I(attrNatural.getSoilOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,11, I2S(R2I(attrNatural.getWaterOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,12, I2S(R2I(attrNatural.getWindOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,13, I2S(R2I(attrNatural.getLightOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,14, I2S(R2I(attrNatural.getDarkOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,15, I2S(R2I(attrNatural.getWoodOppose(hplayer.getHero(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_my,12,16, I2S(R2I(attrNatural.getThunderOppose(hplayer.getHero(players[i])))) +"%" )

                    call MultiboardDisplay(hmb_my, true)
                elseif(GetLocalPlayer()==players[i] and hmb_show[i] == "value")then
                    call MultiboardSetItemValueBJ( hmb_value, 1, 1, "" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 2, "生命量" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 3, "生命源" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 4, "魔法量" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 5, "魔法源" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 6, "移动力" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 7, "僵直度" )
                    call MultiboardSetItemValueBJ( hmb_value, 1, 8, "负重量" )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 1, "" )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 2, attrUnit.createBlockText(hunit.getLife(hplayer.getHero(players[i])),hunit.getMaxLife(hplayer.getHero(players[i])),hmb_value_block,"4bf14f","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 3, attrUnit.createBlockText(attrExt.getLifeSourceCurrent(hplayer.getHero(players[i])),attrExt.getLifeSource(hplayer.getHero(players[i])),hmb_value_block,"92f693","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 4, attrUnit.createBlockText(hunit.getMana(hplayer.getHero(players[i])),hunit.getMaxMana(hplayer.getHero(players[i])),hmb_value_block,"3192ed","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 5, attrUnit.createBlockText(attrExt.getManaSourceCurrent(hplayer.getHero(players[i])),attrExt.getManaSource(hplayer.getHero(players[i])),hmb_value_block,"90c4f3","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 6, attrUnit.createBlockText(attr.getMove(hplayer.getHero(players[i])),MAX_MOVE_SPEED,hmb_value_block,"f36dc4","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 7, attrUnit.createBlockText(attrExt.getPunishCurrent(hplayer.getHero(players[i])),attrExt.getPunish(hplayer.getHero(players[i])),hmb_value_block,"f8f5ec","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_value, 2, 8, attrUnit.createBlockText(attrExt.getWeightCurrent(hplayer.getHero(players[i])),attrExt.getWeight(hplayer.getHero(players[i])),hmb_value_block,"f3eb90","f2e121") )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 1, "数值" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 2, "|cff4bf14f"+R2S(hunit.getLife(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxLife(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 3, "|cff92f693"+R2S(attrExt.getLifeSourceCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(attrExt.getLifeSource(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 4, "|cff3192ed"+R2S(hunit.getMana(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxMana(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 5, "|cff90c4f3"+R2S(attrExt.getManaSourceCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(attrExt.getManaSource(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 6, "|cfff36dc4"+I2S(R2I(attr.getMove(hplayer.getHero(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 7, "|cfff8f5ec"+R2S(attrExt.getPunishCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(attrExt.getPunish(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_value, 3, 8, "|cfff3eb90"+R2S(attrExt.getWeightCurrent(hplayer.getHero(players[i])))+"|r / |cfff2e121"+R2S(attrExt.getWeight(hplayer.getHero(players[i])))+"|r" )
                    call MultiboardDisplay(hmb_value, true)
                elseif(GetLocalPlayer()==players[i] and hmb_show[i] == "selection")then
                    if(hplayer.getSelection(players[i])!=null)then
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 1, "单位名称" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 2, "硬直" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 3, "生命" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 4, "魔法" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 5, "移动力" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 6, "生命恢复" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 7, "魔法恢复" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 8, "物理攻击" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1, 9, "魔法攻击" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,10, "攻击速度" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,11, "护甲" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,12, "魔抗" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,13, "回避" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,14, "命中" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,15, "韧性" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,16, "物理暴击" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,17, "魔法暴击" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,18, "致命抵抗" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,19, "分裂" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,20, "吸血" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,21, "技能吸血" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,22, "眩晕抵抗" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,23, "硬直抵抗" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,24, "运气" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,25, "无敌" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,26, "伤害增幅" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,27, "伤害反射" )
                        call MultiboardSetItemValueBJ( hmb_selection, 1,28, "治疗" )

                        call MultiboardSetItemValueBJ( hmb_selection, 2, 1, GetUnitName(hplayer.getSelection(players[i])) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 2, attrUnit.createBlockText(attrExt.getPunishCurrent(hplayer.getSelection(players[i])),attrExt.getPunish(hplayer.getSelection(players[i])),hmb_value_block,"f8f5ec","4f4f4a") )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 3, attrUnit.createBlockText(hunit.getLife(hplayer.getSelection(players[i])),hunit.getMaxLife(hplayer.getSelection(players[i])),hmb_value_block,"4bf14f","4f4f4a") )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 4, attrUnit.createBlockText(hunit.getMana(hplayer.getSelection(players[i])),hunit.getMaxMana(hplayer.getSelection(players[i])),hmb_value_block,"3192ed","4f4f4a") )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 5, attrUnit.createBlockText(attr.getMove(hplayer.getSelection(players[i])),MAX_MOVE_SPEED,hmb_value_block,"f36dc4","4f4f4a") )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 6, R2S(attrExt.getLifeBack(hplayer.getSelection(players[i]))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 7, R2S(attrExt.getManaBack(hplayer.getSelection(players[i]))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 8, I2S(R2I(attr.getAttackPhysical(hplayer.getSelection(players[i])))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2, 9, I2S(R2I(attr.getAttackMagic(hplayer.getSelection(players[i])))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,10, I2S(R2I(attr.getAttackSpeed(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,11, I2S(R2I(attr.getDefend(hplayer.getSelection(players[i])))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,12, R2S(attrExt.getResistance(hplayer.getSelection(players[i])))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,13, R2S(attrExt.getAvoid(hplayer.getSelection(players[i])))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,14, R2S(attrExt.getAim(hplayer.getSelection(players[i])))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,15, R2S(attrExt.getToughness(hplayer.getSelection(players[i]))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,16, I2S(R2I(attrExt.getKnocking(hplayer.getSelection(players[i])))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,17, I2S(R2I(attrExt.getViolence(hplayer.getSelection(players[i])))) )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,18, I2S(R2I(attrExt.getMortalOppose(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,19, I2S(R2I(attrExt.getSplit(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,20, I2S(R2I(attrExt.getHemophagia(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,21, I2S(R2I(attrExt.getHemophagiaSkill(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,22, R2S(attrExt.getSwimOppose(hplayer.getSelection(players[i])))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,23, R2S(attrExt.getPunishOppose(hplayer.getSelection(players[i])))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,24, I2S(R2I(attrExt.getLuck(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,25, I2S(R2I(attrExt.getInvincible(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,26, I2S(R2I(attrExt.getHuntAmplitude(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,27, I2S(R2I(attrExt.getHuntRebound(hplayer.getSelection(players[i]))))+"%" )
                        call MultiboardSetItemValueBJ( hmb_selection, 2,28, I2S(R2I(attrExt.getCure(hplayer.getSelection(players[i]))))+"%" )

                        call MultiboardSetItemValueBJ( hmb_selection, 3, 2, "|cfff8f5ec"+R2S(attrExt.getPunishCurrent(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(attrExt.getPunish(hplayer.getSelection(players[i])))+"|r" )
                        call MultiboardSetItemValueBJ( hmb_selection, 3, 3, "|cff4bf14f"+R2S(hunit.getLife(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxLife(hplayer.getSelection(players[i])))+"|r" )
                        call MultiboardSetItemValueBJ( hmb_selection, 3, 4, "|cff3192ed"+R2S(hunit.getMana(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxMana(hplayer.getSelection(players[i])))+"|r" )
                        call MultiboardSetItemValueBJ( hmb_selection, 3, 5, "|cfff36dc4"+I2S(R2I(attr.getMove(hplayer.getSelection(players[i]))))+"|r" )
                        call MultiboardSetItemValueBJ( hmb_selection, 3,10, R2S(DEFAULT_ATTACK_SPEED / (100+attr.getAttackSpeed(hplayer.getSelection(players[i]))))+"击每秒")
                        call MultiboardDisplay(hmb_selection, true)
                    else
                        call MultiboardDisplay(hmb_selection, false)
                    endif
                elseif(GetLocalPlayer()==players[i] and hmb_show[i] == "selectionEffect")then
                    if(hplayer.getSelection(players[i])!=null)then
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 1, "单位名称" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 2, "攻增:生命恢复" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 3, "攻增:魔法恢复" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 4, "攻增:攻击速度" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 5, "攻增:物理攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 6, "攻增:魔法攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 7, "攻增:移动力" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 8, "攻增:力量" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1, 9, "攻增:敏捷" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,10, "攻增:智力" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,11, "攻增:物理暴击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,12, "攻增:魔法暴击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,13, "攻增:命中" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,14, "攻增:分裂" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,15, "攻增:吸血" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,16, "攻增:技能吸血" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,17, "攻增:运气" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,18, "攻增:伤害增幅" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,19, "火攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,20, "土攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,21, "水攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,22, "风攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,23, "光攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,24, "暗攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,25, "木攻击" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 1,26, "雷攻击" )

                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 1, GetUnitName(hplayer.getSelection(players[i])) )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 2, I2S(R2I(attrEffect.getLifeBack(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLifeBackDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 3, I2S(R2I(attrEffect.getManaBack(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getManaBackDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 4, I2S(R2I(attrEffect.getAttackSpeed(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackSpeedDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 5, I2S(R2I(attrEffect.getAttackPhysical(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackPhysicalDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 6, I2S(R2I(attrEffect.getAttackMagic(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAttackMagicDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 7, I2S(R2I(attrEffect.getMove(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getMoveDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 8, I2S(R2I(attrEffect.getStr(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getStrDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 9, I2S(R2I(attrEffect.getAgi(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAgiDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 10, I2S(R2I(attrEffect.getInt(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getIntDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 11, I2S(R2I(attrEffect.getKnocking(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getKnockingDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 12, I2S(R2I(attrEffect.getViolence(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getViolenceDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 13, I2S(R2I(attrEffect.getAim(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getAimDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 14, I2S(R2I(attrEffect.getSplit(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getSplitDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 15, I2S(R2I(attrEffect.getHemophagia(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHemophagiaDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 16, I2S(R2I(attrEffect.getHemophagiaSkill(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHemophagiaSkillDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 17, I2S(R2I(attrEffect.getLuck(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLuckDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 18, I2S(R2I(attrEffect.getHuntAmplitude(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHuntAmplitudeDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 19, I2S(R2I(attrNatural.getFire(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 20, I2S(R2I(attrNatural.getSoil(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 21, I2S(R2I(attrNatural.getWater(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 22, I2S(R2I(attrNatural.getWind(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 23, I2S(R2I(attrNatural.getLight(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 24, I2S(R2I(attrNatural.getDark(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 25, I2S(R2I(attrNatural.getWood(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 2, 26, I2S(R2I(attrNatural.getThunder(hplayer.getSelection(players[i])))) +"%" )

                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 1, "特效:中毒" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 2, "特效:枯竭" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 3, "特效:冻结" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 4, "特效:寒冷" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 5, "特效:迟钝" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 6, "特效:腐蚀" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 7, "特效:混乱" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 8, "特效:缠绕" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 9, "特效:致盲" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 10, "特效:剧痛" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 11, "特效:乏力" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 12, "特效:束缚" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 13, "特效:愚蠢" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 14, "特效:懒惰" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 15, "特效:眩晕" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 16, "特效:沉重" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 17, "特效:打断" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 18, "特效:倒霉" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 19, "火抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 20, "土抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 21, "水抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 22, "风抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 23, "光抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 24, "暗抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 25, "木抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 3, 26, "雷抗性" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 1, I2S(R2I(attrEffect.getPoison(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getPoisonDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 2, I2S(R2I(attrEffect.getDry(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getDryDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 3, I2S(R2I(attrEffect.getFreeze(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getFreezeDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 4, I2S(R2I(attrEffect.getCold(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getColdDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 5, I2S(R2I(attrEffect.getBlunt(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBluntDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 6, I2S(R2I(attrEffect.getCorrosion(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getCorrosionDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 7, I2S(R2I(attrEffect.getChaos(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getChaosDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 8, I2S(R2I(attrEffect.getTwine(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getTwineDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 9, I2S(R2I(attrEffect.getBlind(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBlindDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 10, I2S(R2I(attrEffect.getTortua(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getTortuaDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 11, I2S(R2I(attrEffect.getWeak(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getWeakDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 12, I2S(R2I(attrEffect.getBound(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBoundDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 13, I2S(R2I(attrEffect.getFoolish(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getFoolishDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 14, I2S(R2I(attrEffect.getLazy(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getLazyDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 15, I2S(R2I(attrEffect.getSwim(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getSwimDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 16, I2S(R2I(attrEffect.getHeavy(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getHeavyDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 17, I2S(R2I(attrEffect.getBreak(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getBreakDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 18, I2S(R2I(attrEffect.getUnluck(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ math.realformat(attrEffect.getUnluckDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 19, I2S(R2I(attrNatural.getFireOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 20, I2S(R2I(attrNatural.getSoilOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 21, I2S(R2I(attrNatural.getWaterOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 22, I2S(R2I(attrNatural.getWindOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 23, I2S(R2I(attrNatural.getLightOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 24, I2S(R2I(attrNatural.getDarkOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 25, I2S(R2I(attrNatural.getWoodOppose(hplayer.getSelection(players[i])))) +"%" )
                        call MultiboardSetItemValueBJ( hmb_selectionEffect, 4, 26, I2S(R2I(attrNatural.getThunderOppose(hplayer.getSelection(players[i])))) +"%" )

                        call MultiboardDisplay(hmb_selectionEffect, true)
                    else
                        call MultiboardDisplay(hmb_selectionEffect, false)
                    endif
                endif
            endif   
            set i = i + 1
        endloop
    endmethod
    public static method build takes nothing returns nothing
        call time.setInterval(0.5,function thistype.buildCall)
    endmethod

    private static method start takes nothing returns nothing
        call build()
    endmethod

    private static method mbap takes nothing returns nothing
        set hmb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "allPlayer"
    endmethod
    private static method mby takes nothing returns nothing
        set hmb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "my"
    endmethod
    private static method mbv takes nothing returns nothing
        set hmb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "value"
    endmethod
    private static method mbs takes nothing returns nothing
        set hmb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "selection"
    endmethod
    private static method mbse takes nothing returns nothing
        set hmb_show[GetConvertedPlayerId(GetTriggerPlayer())] = "selectionEffect"
    endmethod

    public static method initSet takes nothing returns nothing
        local integer i = 0
        local trigger startTrigger = null
        local trigger mbapTrigger = null
        local trigger mbyTrigger = null
        local trigger mbvTrigger = null
        local trigger mbsTrigger = null
        local trigger mbseTrigger = null

        set startTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle( startTrigger, 0.00 )
        call TriggerAddAction(startTrigger, function thistype.start)

        set mbapTrigger = CreateTrigger()
        set mbyTrigger = CreateTrigger()
        set mbvTrigger = CreateTrigger()
        set mbsTrigger = CreateTrigger()
        set mbseTrigger = CreateTrigger()

        set i = 1
        loop
            exitwhen i > player_max_qty
                call TriggerRegisterPlayerChatEvent( mbapTrigger, players[i], "-mbap", true )
                call TriggerAddAction(mbapTrigger, function thistype.mbap)
                call TriggerRegisterPlayerChatEvent( mbyTrigger, players[i], "-mby", true )
                call TriggerAddAction(mbyTrigger, function thistype.mby)
                call TriggerRegisterPlayerChatEvent( mbvTrigger, players[i], "-mbv", true )
                call TriggerAddAction(mbvTrigger, function thistype.mbv)
                call TriggerRegisterPlayerChatEvent( mbsTrigger, players[i], "-mbs", true )
                call TriggerAddAction(mbsTrigger, function thistype.mbs)
                call TriggerRegisterPlayerChatEvent( mbseTrigger, players[i], "-mbse", true )
                call TriggerAddAction(mbseTrigger, function thistype.mbse)
                if( hmb_show[i] == null)then
                    set hmb_show[i] = "allPlayer"
                endif
            set i = i + 1
        endloop
    endmethod

endstruct
