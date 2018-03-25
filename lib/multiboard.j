
 globals

    hMultiboard hmb
    multiboard hmb_allPlayer = null
    integer hmb_allPlayer_prev_row = -1
    multiboard array hmb_my
    multiboard array hmb_value
    multiboard array hmb_selection
    multiboard array hmb_selectionEffect
    integer hmb_value_block = 20

    //多面板
    //多面板检查，用来检查此用户是否已经显示在上面
    //用来跳过那些非玩家 无玩家的玩家列
    //这样3个玩家就只会显示3个，而不需要多余的列来显示null
    boolean array MultiboardCheck

endglobals

struct hMultiboard

    private static method buildCall_allPlayer takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local integer k = 0
        local integer mbrow = 1
        set i = 1
        loop
            exitwhen i > player_max_qty
                if( hplayer.getStatus(players[i]) == hplayer.default_status_nil )then
                    //nothing
                else
                    set mbrow = mbrow+1
                endif
            set i = i + 1
        endloop
        if(hmb_allPlayer == null) then
            set hmb_allPlayer = CreateMultiboard()
        endif
        if(mbrow != hmb_allPlayer_prev_row )then
            set hmb_allPlayer_prev_row = mbrow
            call MultiboardSetRowCount(hmb_allPlayer, mbrow)
            call MultiboardSetColumnCount(hmb_allPlayer, 14)
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 0, 0, 3.50 )
            call MultiboardSetItemStyleBJ( hmb_allPlayer, 0, 0, true, false )
            call MultiboardSetItemStyleBJ( hmb_allPlayer, 0, 1, true, true )//第一行显示图标
            call MultiboardSetItemValueBJ( hmb_allPlayer, 1, 1, "玩家名称" )
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 1, 0, 5.00 )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 2, 1, "英雄" )
            call MultiboardSetItemWidthBJ( hmb_allPlayer, 2, 0, 7.00 )
            call MultiboardSetItemStyleBJ( hmb_allPlayer, 2, 0, true, true )//显示图标
            call MultiboardSetItemValueBJ( hmb_allPlayer, 3, 1, "黄金" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 4, 1, "木头" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 5, 1, "杀敌数" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 6, 1, "建筑数" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 7, 1, "造成伤害" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 8, 1, "承受伤害" )
            call MultiboardSetItemValueBJ( hmb_allPlayer, 9, 1, "获金总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,10, 1, "获木总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,11, 1, "耗金总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,12, 1, "耗木总量" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,13, 1, "状态" )
            call MultiboardSetItemValueBJ( hmb_allPlayer,14, 1, "APM" )
        endif
        call MultiboardSetTitleText(hmb_allPlayer, "所有玩家情报("+I2S(player_current_qty)+"名)")
        set j = 2
        set k = 1
        loop
            exitwhen k > player_max_qty
            if ( hplayer.getStatus(players[k]) != hplayer.default_status_nil ) then
                call MultiboardSetItemValueBJ( hmb_allPlayer, 1, j, GetPlayerName(players[k]) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 2, j, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[k])))+"."+hplayer.getHeroName(players[k]) )
                call MultiboardSetItemIconBJ( hmb_allPlayer,  2, j, hplayer.getHeroAvatar(players[k]) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 3, j, I2S(hplayer.getGold(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 4, j, I2S(hplayer.getLumber(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 5, j, I2S(hplayer.getKill(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 6, j, I2S(GetPlayerStructureCount(players[k], false))+"/"+I2S(GetPlayerStructureCount(players[k], true) ))
                call MultiboardSetItemValueBJ( hmb_allPlayer, 7, j, hmath.realformat(hplayer.getDamage(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 8, j, hmath.realformat(hplayer.getBeDamage(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer, 9, j, hmath.realformat(hplayer.getTotalGold(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer,10, j, hmath.realformat(hplayer.getTotalLumber(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer,11, j, hmath.realformat(hplayer.getTotalGoldCost(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer,12, j, hmath.realformat(hplayer.getTotalLumberCost(players[k])) )
                call MultiboardSetItemValueBJ( hmb_allPlayer,13, j, hplayer.getStatus(players[k]) )
                call MultiboardSetItemValueBJ( hmb_allPlayer,14, j, I2S(hplayer.getApm(players[k])) )
                set j = j + 1
            endif
            set k = k + 1
        endloop
    endmethod

    private static method buildCall_my takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > player_max_qty
            if( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                if(hmb_my[i] == null) then
                    set hmb_my[i] = CreateMultiboard()
                    call MultiboardSetRowCount(hmb_my[i], 20)
                    call MultiboardSetColumnCount(hmb_my[i], 14)
                    call MultiboardSetItemWidthBJ( hmb_my[i], 0, 0, 4.20 )
                    call MultiboardSetItemStyleBJ( hmb_my[i], 0, 0, true, false )
                    call MultiboardSetItemWidthBJ( hmb_my[i], 2, 0, 4.80 )
                    call MultiboardSetItemWidthBJ( hmb_my[i], 4, 0, 6.00 )
                    call MultiboardSetItemWidthBJ( hmb_my[i], 7, 0, 6.00 )
                    call MultiboardSetItemWidthBJ( hmb_my[i], 9, 0, 4.80 )
                    call MultiboardSetItemWidthBJ( hmb_my[i],11, 0, 4.80 )
                endif
                call MultiboardSetTitleText(hmb_my[i], "你的个人状态("+GetPlayerName(players[i])+"人)")
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 1, "黄金" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 2, "木头" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 3, "黄金率" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 4, "木头率" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 5, "经验率" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 6, "杀敌数" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 7, "造成伤害" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 8, "承受伤害" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1, 9, "获金总量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1,10, "获木总量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1,11, "耗金总量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1,12, "耗木总量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1,13, "状态" )
                call MultiboardSetItemValueBJ( hmb_my[i], 1,14, "APM" )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 1, I2S(hplayer.getGold(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 2, I2S(hplayer.getLumber(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 3, R2S(hattr.getGoldRatio(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 4, R2S(hattr.getLumberRatio(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 5, R2S(hattr.getExpRatio(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 6, I2S(hplayer.getKill(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 7, hmath.realformat(hplayer.getDamage(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 8, hmath.realformat(hplayer.getBeDamage(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2, 9, hmath.realformat(hplayer.getTotalGold(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2,10, hmath.realformat(hplayer.getTotalLumber(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2,11, hmath.realformat(hplayer.getTotalGoldCost(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2,12, hmath.realformat(hplayer.getTotalLumberCost(players[i])) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2,13, hplayer.getStatus(players[i]) )
                call MultiboardSetItemValueBJ( hmb_my[i], 2,14, I2S(hplayer.getApm(players[i])) )
                
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 1, "英雄名称" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 2, "英雄等级" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 3, "英雄类型" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 4, "生命" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 5, "魔法" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 6, "生命源" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 7, "魔法源" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 8, "生命恢复" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 9, "魔法恢复" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 10, "物理攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 11, "魔法攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 12, "攻击速度" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 13, "力量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 14, "敏捷" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 15, "智力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 3, 16, "移动力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 17, "救助力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 18, "负重" )
                call MultiboardSetItemIconBJ(  hmb_my[i], 4, 1, hplayer.getHeroAvatar(players[i]) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 1, hplayer.getHeroName(players[i]) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 2, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 3, "type" )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 4, I2S(R2I(hattr.getLife(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 5, I2S(R2I(hattr.getMana(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 6, I2S(R2I(hattr.getLifeSourceCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(hattr.getLifeSource(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 7, I2S(R2I(hattr.getManaSourceCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(hattr.getManaSource(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 8, R2S(hattr.getLifeBack(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 9, R2S(hattr.getManaBack(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 10, I2S(R2I(hattr.getAttackPhysical(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 11, I2S(R2I(hattr.getAttackMagic(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 12, I2S(R2I(hattr.getAttackSpeed(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 13, I2S(R2I(hattr.getStrWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hattr.getStr(hplayer.getHero(players[i]))))+"|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 14, I2S(R2I(hattr.getAgiWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hattr.getAgi(hplayer.getHero(players[i]))))+"|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 15, I2S(R2I(hattr.getIntWhite(hplayer.getHero(players[i]))))+"+|cff11e449"+I2S(R2I(hattr.getInt(hplayer.getHero(players[i]))))+"|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 16, I2S(R2I(hattr.getMove(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 17, I2S(R2I(hattr.getHelp(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 4, 18, I2S(R2I(hattr.getWeightCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(hattr.getWeight(hplayer.getHero(players[i])))) )

                call MultiboardSetItemValueBJ( hmb_my[i], 5, 1, "护甲" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 2, "魔抗" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 3, "回避" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 4, "命中" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 5, "韧性" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 6, "物理暴击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 7, "魔法暴击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 8, "致命抵抗" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 9, "分裂" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 10, "吸血" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 11, "技能吸血" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 12, "眩晕抵抗" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 13, "运气" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 14, "无敌" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 15, "伤害增幅" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 16, "伤害反射" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 17, "治疗" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 18, "硬直" )
                call MultiboardSetItemValueBJ( hmb_my[i], 5, 19, "硬直抵抗" )
                
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 1, I2S(R2I(hattr.getDefend(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 2, R2S(hattr.getResistance(hplayer.getHero(players[i])))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 3, R2S(hattr.getAvoid(hplayer.getHero(players[i])))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 4, R2S(hattr.getAim(hplayer.getHero(players[i])))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 5, R2S(hattr.getToughness(hplayer.getHero(players[i]))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 6, I2S(R2I(hattr.getKnocking(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 7, I2S(R2I(hattr.getViolence(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 8, I2S(R2I(hattr.getMortalOppose(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 9, I2S(R2I(hattr.getSplit(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 10, I2S(R2I(hattr.getHemophagia(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 11, I2S(R2I(hattr.getHemophagiaSkill(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 12, R2S(hattr.getSwimOppose(hplayer.getHero(players[i])))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 13, I2S(R2I(hattr.getLuck(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 14, I2S(R2I(hattr.getInvincible(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 15, I2S(R2I(hattr.getHuntAmplitude(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 16, I2S(R2I(hattr.getHuntRebound(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 17, I2S(R2I(hattr.getCure(hplayer.getHero(players[i]))))+"%" )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 18, I2S(R2I(hattr.getPunishCurrent(hplayer.getHero(players[i]))))+"/"+I2S(R2I(hattr.getPunish(hplayer.getHero(players[i])))) )
                call MultiboardSetItemValueBJ( hmb_my[i], 6, 19, I2S(R2I(hattr.getPunishOppose(hplayer.getHero(players[i]))))+"%" )

                call MultiboardSetItemValueBJ( hmb_my[i], 7, 1, "特效:生命恢复" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 2, "特效:魔法恢复" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 3, "特效:攻击速度" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 4, "特效:物理攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 5, "特效:魔法攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 6, "特效:移动力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 7, "特效:力量" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 8, "特效:敏捷" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 9, "特效:智力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 10, "特效:物理暴击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 11, "特效:魔法暴击" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 12, "特效:命中" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 13, "特效:分裂" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 14, "特效:吸血" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 15, "特效:技能吸血" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 16, "特效:运气" )
                call MultiboardSetItemValueBJ( hmb_my[i], 7, 17, "特效:伤害增幅" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 1, I2S(R2I(hattrEffect.getLifeBackVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getLifeBackDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 2, I2S(R2I(hattrEffect.getManaBackVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getManaBackDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 3, I2S(R2I(hattrEffect.getAttackSpeedVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackSpeedDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 4, I2S(R2I(hattrEffect.getAttackPhysicalVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackPhysicalDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 5, I2S(R2I(hattrEffect.getAttackMagicVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackMagicDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 6, I2S(R2I(hattrEffect.getMoveVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getMoveDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 7, I2S(R2I(hattrEffect.getStrVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getStrDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 8, I2S(R2I(hattrEffect.getAgiVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAgiDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 9, I2S(R2I(hattrEffect.getIntVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getIntDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 10, I2S(R2I(hattrEffect.getKnockingVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getKnockingDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 11, I2S(R2I(hattrEffect.getViolenceVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getViolenceDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 12, I2S(R2I(hattrEffect.getAimVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAimDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 13, I2S(R2I(hattrEffect.getSplitVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getSplitDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 14, I2S(R2I(hattrEffect.getHemophagiaVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHemophagiaDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 15, I2S(R2I(hattrEffect.getHemophagiaSkillVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHemophagiaSkillDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 16, I2S(R2I(hattrEffect.getLuckVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getLuckDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i], 8, 17, I2S(R2I(hattrEffect.getHuntAmplitudeVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHuntAmplitudeDuring(hplayer.getHero(players[i])))+"秒)|r" )

                call MultiboardSetItemValueBJ( hmb_my[i], 9, 1, "特效:中毒" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 2, "特效:灼烧" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 3, "特效:枯竭" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 4, "特效:冻结" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 5, "特效:寒冷" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 6, "特效:迟钝" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 7, "特效:麻瓜" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 8, "特效:腐蚀" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9, 9, "特效:混乱" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,10, "特效:缠绕" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,11, "特效:致盲" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,12, "特效:剧痛" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,13, "特效:乏力" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,14, "特效:束缚" )
                call MultiboardSetItemValueBJ( hmb_my[i], 9,15, "特效:愚蠢" )
                
                call MultiboardSetItemValueBJ( hmb_my[i],10, 1, I2S(R2I(hattrEffect.getPoisonVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getPoisonDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 2, I2S(R2I(hattrEffect.getFireVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFireDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 3, I2S(R2I(hattrEffect.getDryVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDryDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 4, I2S(R2I(hattrEffect.getFreezeVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFreezeDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 5, I2S(R2I(hattrEffect.getColdVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getColdDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 6, I2S(R2I(hattrEffect.getBluntVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBluntDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 7, I2S(R2I(hattrEffect.getMuggleVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getMuggleDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 8, I2S(R2I(hattrEffect.getCorrosionVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getCorrosionDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 9, I2S(R2I(hattrEffect.getChaosVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getChaosDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 10, I2S(R2I(hattrEffect.getTwineVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getTwineDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 11, I2S(R2I(hattrEffect.getBlindVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBlindDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 12, I2S(R2I(hattrEffect.getTortuaVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getTortuaDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 13, I2S(R2I(hattrEffect.getWeakVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getWeakDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 14, I2S(R2I(hattrEffect.getAstrictVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAstrictDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],10, 15, I2S(R2I(hattrEffect.getFoolishVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFoolishDuring(hplayer.getHero(players[i])))+"秒)|r" )

                call MultiboardSetItemValueBJ( hmb_my[i],11,  1, "特效:粗钝" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  2, "特效:尘迹" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  3, "特效:眩晕" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  4, "特效:沉重" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  5, "特效:打断" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  6, "特效:倒霉" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  7, "特效:沉默" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  8, "特效:缴械" )
                call MultiboardSetItemValueBJ( hmb_my[i],11,  9, "特效:脚镣" )
                call MultiboardSetItemValueBJ( hmb_my[i],11, 10, "特效:爆破" )
                call MultiboardSetItemValueBJ( hmb_my[i],11, 11, "特效:闪电链" )
                call MultiboardSetItemValueBJ( hmb_my[i],11, 12, "特效:击飞" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  1, I2S(R2I(hattrEffect.getDullVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDullDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  2, I2S(R2I(hattrEffect.getDirtVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDirtDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  3, I2S(R2I(hattrEffect.getSwimOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getSwimDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  4, I2S(R2I(hattrEffect.getHeavyOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getHeavyVal(hplayer.getHero(players[i])))+"%)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  5, I2S(R2I(hattrEffect.getBreakOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getBreakDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  6, I2S(R2I(hattrEffect.getUnluckVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getUnluckDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  7, I2S(R2I(hattrEffect.getSilentOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getSilentDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  8, I2S(R2I(hattrEffect.getUnarmOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getUnarmDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12,  9, I2S(R2I(hattrEffect.getFetterOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getFetterDuring(hplayer.getHero(players[i])))+"秒)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12, 10, I2S(R2I(hattrEffect.getBombVal(hplayer.getHero(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBombRange(hplayer.getHero(players[i])))+"PX)|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12, 11, I2S(R2I(hattrEffect.getLightningChainOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd["+ hmath.realformat(hattrEffect.getLightningChainVal(hplayer.getHero(players[i])))+"伤害]["+ hmath.realformat(hattrEffect.getLightningChainQty(hplayer.getHero(players[i])))+"单位]|r" )
                call MultiboardSetItemValueBJ( hmb_my[i],12, 12, I2S(R2I(hattrEffect.getCrackFlyOdds(hplayer.getHero(players[i])))) +"%|cff7cfcfd["+ hmath.realformat(hattrEffect.getCrackFlyVal(hplayer.getHero(players[i])))+"伤害]|r" )

                call MultiboardSetItemValueBJ( hmb_my[i],13, 1, "火攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 2, "土攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 3, "水攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 4, "冰攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 5, "风攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 6, "光攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 7, "暗攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 8, "木攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13, 9, "雷攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,10, "毒攻击" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,11, "火抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,12, "土抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,13, "水抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,14, "冰抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,15, "风抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,16, "光抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,17, "暗抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,18, "木抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,19, "雷抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],13,20, "毒抗性" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 1, I2S(R2I(hattrNatural.getFire(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 2, I2S(R2I(hattrNatural.getSoil(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 3, I2S(R2I(hattrNatural.getWater(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 4, I2S(R2I(hattrNatural.getIce(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 5, I2S(R2I(hattrNatural.getWind(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 6, I2S(R2I(hattrNatural.getLight(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 7, I2S(R2I(hattrNatural.getDark(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 8, I2S(R2I(hattrNatural.getWood(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14, 9, I2S(R2I(hattrNatural.getThunder(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,10, I2S(R2I(hattrNatural.getPoison(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,11, I2S(R2I(hattrNatural.getFireOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,12, I2S(R2I(hattrNatural.getSoilOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,13, I2S(R2I(hattrNatural.getWaterOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,14, I2S(R2I(hattrNatural.getIceOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,15, I2S(R2I(hattrNatural.getWindOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,16, I2S(R2I(hattrNatural.getLightOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,17, I2S(R2I(hattrNatural.getDarkOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,18, I2S(R2I(hattrNatural.getWoodOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,19, I2S(R2I(hattrNatural.getThunderOppose(hplayer.getHero(players[i])))) +"%" )
                call MultiboardSetItemValueBJ( hmb_my[i],14,20, I2S(R2I(hattrNatural.getPoisonOppose(hplayer.getHero(players[i])))) +"%" )
            endif
        set i = i+1
        endloop
    endmethod

    private static method buildCall_value takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > player_max_qty
            if( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                if(hmb_value[i] == null) then
                    set hmb_value[i] = CreateMultiboard()
                    call MultiboardSetRowCount(hmb_value[i], 8)
                    call MultiboardSetColumnCount(hmb_value[i], 3)
                    call MultiboardSetItemStyleBJ( hmb_value[i], 0, 0, true, false )
                    call MultiboardSetItemWidthBJ( hmb_value[i], 1, 0, 3.00 )
                    call MultiboardSetItemWidthBJ( hmb_value[i], 2, 0, 10.00 )
                    call MultiboardSetItemWidthBJ( hmb_value[i], 3, 0, 6.00 )
                endif
                call MultiboardSetTitleText(hmb_value[i], "精简实时情报")
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 1, "属性" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 2, "生命量" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 3, "生命源" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 4, "魔法量" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 5, "魔法源" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 6, "移动力" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 7, "僵直度" )
                call MultiboardSetItemValueBJ( hmb_value[i], 1, 8, "负重量" )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 1, "" )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 2, hattrUnit.createBlockText(hunit.getLife(hplayer.getHero(players[i])),hunit.getMaxLife(hplayer.getHero(players[i])),hmb_value_block,"4bf14f","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 3, hattrUnit.createBlockText(hattr.getLifeSourceCurrent(hplayer.getHero(players[i])),hattr.getLifeSource(hplayer.getHero(players[i])),hmb_value_block,"92f693","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 4, hattrUnit.createBlockText(hunit.getMana(hplayer.getHero(players[i])),hunit.getMaxMana(hplayer.getHero(players[i])),hmb_value_block,"3192ed","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 5, hattrUnit.createBlockText(hattr.getManaSourceCurrent(hplayer.getHero(players[i])),hattr.getManaSource(hplayer.getHero(players[i])),hmb_value_block,"90c4f3","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 6, hattrUnit.createBlockText(hattr.getMove(hplayer.getHero(players[i])),MAX_MOVE_SPEED,hmb_value_block,"f36dc4","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 7, hattrUnit.createBlockText(hattr.getPunishCurrent(hplayer.getHero(players[i])),hattr.getPunish(hplayer.getHero(players[i])),hmb_value_block,"f8f5ec","4f4f4a") )
                call MultiboardSetItemValueBJ( hmb_value[i], 2, 8, hattrUnit.createBlockText(hattr.getWeightCurrent(hplayer.getHero(players[i])),hattr.getWeight(hplayer.getHero(players[i])),hmb_value_block,"f3eb90","f2e121") )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 1, "能力" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 2, "|cff4bf14f"+R2S(hunit.getLife(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxLife(hplayer.getHero(players[i])))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 3, "|cff92f693"+R2S(hattr.getLifeSourceCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hattr.getLifeSource(hplayer.getHero(players[i])))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 4, "|cff3192ed"+R2S(hunit.getMana(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxMana(hplayer.getHero(players[i])))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 5, "|cff90c4f3"+R2S(hattr.getManaSourceCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hattr.getManaSource(hplayer.getHero(players[i])))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 6, "|cfff36dc4"+I2S(R2I(hattr.getMove(hplayer.getHero(players[i]))))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 7, "|cfff8f5ec"+R2S(hattr.getPunishCurrent(hplayer.getHero(players[i])))+"|r / |cff4f4f4a"+R2S(hattr.getPunish(hplayer.getHero(players[i])))+"|r" )
                call MultiboardSetItemValueBJ( hmb_value[i], 3, 8, "|cfff3eb90"+R2S(hattr.getWeightCurrent(hplayer.getHero(players[i])))+"|r / |cfff2e121"+R2S(hattr.getWeight(hplayer.getHero(players[i])))+"|r" )
            endif
        set i = i+1
        endloop
    endmethod

    private static method buildCall_selection takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > player_max_qty
            if( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                if(hmb_selection[i] == null) then
                    set hmb_selection[i] = CreateMultiboard()
                endif
                if(hplayer.getSelection(players[i])!=null)then
                    call MultiboardSetRowCount(hmb_selection[i], 27)
                    call MultiboardSetColumnCount(hmb_selection[i], 3)
                    call MultiboardSetItemWidthBJ( hmb_selection[i], 0, 0, 4.00 )
                    call MultiboardSetItemStyleBJ( hmb_selection[i], 0, 0, true, false )
                    call MultiboardSetItemWidthBJ( hmb_selection[i], 2, 0, 12.00 )
                    call MultiboardSetItemWidthBJ( hmb_selection[i], 3, 0, 6.00 )
                    call MultiboardSetTitleText(hmb_selection[i], "单位状态("+GetUnitName(hplayer.getSelection(players[i]))+")")
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 1, "硬直" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 2, "生命" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 3, "魔法" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 4, "移动力" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 5, "生命恢复" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 6, "魔法恢复" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 7, "物理攻击" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 8, "魔法攻击" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 9, "攻击速度" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,10, "护甲" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,11, "魔抗" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,12, "回避" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,13, "命中" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,14, "韧性" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,15, "物理暴击" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,16, "魔法暴击" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,17, "致命抵抗" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,18, "分裂" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,19, "吸血" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,20, "技能吸血" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,21, "眩晕抵抗" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,22, "硬直抵抗" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,23, "运气" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,24, "无敌" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,25, "伤害增幅" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,26, "伤害反射" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1,27, "治疗" )

                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 1, hattrUnit.createBlockText(hattr.getPunishCurrent(hplayer.getSelection(players[i])),hattr.getPunish(hplayer.getSelection(players[i])),hmb_value_block,"f8f5ec","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 2, hattrUnit.createBlockText(hunit.getLife(hplayer.getSelection(players[i])),hunit.getMaxLife(hplayer.getSelection(players[i])),hmb_value_block,"4bf14f","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 3, hattrUnit.createBlockText(hunit.getMana(hplayer.getSelection(players[i])),hunit.getMaxMana(hplayer.getSelection(players[i])),hmb_value_block,"3192ed","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 4, hattrUnit.createBlockText(hattr.getMove(hplayer.getSelection(players[i])),MAX_MOVE_SPEED,hmb_value_block,"f36dc4","4f4f4a") )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 5, R2S(hattr.getLifeBack(hplayer.getSelection(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 6, R2S(hattr.getManaBack(hplayer.getSelection(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 7, I2S(R2I(hattr.getAttackPhysical(hplayer.getSelection(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 8, I2S(R2I(hattr.getAttackMagic(hplayer.getSelection(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2, 9, I2S(R2I(hattr.getAttackSpeed(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,10, I2S(R2I(hattr.getDefend(hplayer.getSelection(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,11, R2S(hattr.getResistance(hplayer.getSelection(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,12, R2S(hattr.getAvoid(hplayer.getSelection(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,13, R2S(hattr.getAim(hplayer.getSelection(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,14, R2S(hattr.getToughness(hplayer.getSelection(players[i]))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,15, I2S(R2I(hattr.getKnocking(hplayer.getSelection(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,16, I2S(R2I(hattr.getViolence(hplayer.getSelection(players[i])))) )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,17, I2S(R2I(hattr.getMortalOppose(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,18, I2S(R2I(hattr.getSplit(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,19, I2S(R2I(hattr.getHemophagia(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,20, I2S(R2I(hattr.getHemophagiaSkill(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,21, R2S(hattr.getSwimOppose(hplayer.getSelection(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,22, R2S(hattr.getPunishOppose(hplayer.getSelection(players[i])))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,23, I2S(R2I(hattr.getLuck(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,24, I2S(R2I(hattr.getInvincible(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,25, I2S(R2I(hattr.getHuntAmplitude(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,26, I2S(R2I(hattr.getHuntRebound(hplayer.getSelection(players[i]))))+"%" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 2,27, I2S(R2I(hattr.getCure(hplayer.getSelection(players[i]))))+"%" )

                    call MultiboardSetItemValueBJ( hmb_selection[i], 3, 1, "|cfff8f5ec"+R2S(hattr.getPunishCurrent(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(hattr.getPunish(hplayer.getSelection(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 3, 2, "|cff4bf14f"+R2S(hunit.getLife(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxLife(hplayer.getSelection(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 3, 3, "|cff3192ed"+R2S(hunit.getMana(hplayer.getSelection(players[i])))+"|r / |cff4f4f4a"+R2S(hunit.getMaxMana(hplayer.getSelection(players[i])))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 3, 4, "|cfff36dc4"+I2S(R2I(hattr.getMove(hplayer.getSelection(players[i]))))+"|r" )
                    call MultiboardSetItemValueBJ( hmb_selection[i], 3, 9, R2S(DEFAULT_ATTACK_SPEED / (100+hattr.getAttackSpeed(hplayer.getSelection(players[i]))))+"击每秒")
                else
                    call MultiboardSetRowCount(hmb_selection[i], 1)
                    call MultiboardSetColumnCount(hmb_selection[i], 1)
                    call MultiboardSetItemWidthBJ( hmb_selection[i], 0, 0, 15.00 )
                    call MultiboardSetItemStyleBJ( hmb_selection[i], 0, 0, true, false )
                    call MultiboardSetTitleText(hmb_selection[i], "单位状态(未选中单位)")
                    call MultiboardSetItemValueBJ( hmb_selection[i], 1, 1, "- 请选择单位查看常规属性 -" )
                endif
            endif
        set i = i+1
        endloop
    endmethod

    private static method buildCall_selectionEffect takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > player_max_qty
            if( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                if(hmb_selectionEffect[i] == null) then
                    set hmb_selectionEffect[i] = CreateMultiboard()
                endif
                if(hplayer.getSelection(players[i])!=null)then
                    call MultiboardSetRowCount(hmb_selectionEffect[i], 26)
                    call MultiboardSetColumnCount(hmb_selectionEffect[i], 6)
                    call MultiboardSetItemWidthBJ( hmb_selectionEffect[i], 0, 0, 5.00 )
                    call MultiboardSetItemStyleBJ( hmb_selectionEffect[i], 0, 0, true, false )
                    call MultiboardSetTitleText(hmb_selectionEffect[i], "单位特效("+GetUnitName(hplayer.getSelection(players[i]))+")")
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 1, "特效:生命恢复" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 2, "特效:魔法恢复" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 3, "特效:攻击速度" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 4, "特效:物理攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 5, "特效:魔法攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 6, "特效:移动力" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 7, "特效:力量" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 8, "特效:敏捷" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 9, "特效:智力" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,10, "特效:物理暴击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,11, "特效:魔法暴击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,12, "特效:命中" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,13, "特效:分裂" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,14, "特效:吸血" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,15, "特效:技能吸血" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,16, "特效:运气" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,17, "特效:伤害增幅" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,18, "特效:爆破" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,19, "特效:闪电链" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1,20, "特效:击飞" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 1, I2S(R2I(hattrEffect.getLifeBackVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getLifeBackDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 2, I2S(R2I(hattrEffect.getManaBackVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getManaBackDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 3, I2S(R2I(hattrEffect.getAttackSpeedVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackSpeedDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 4, I2S(R2I(hattrEffect.getAttackPhysicalVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackPhysicalDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 5, I2S(R2I(hattrEffect.getAttackMagicVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAttackMagicDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 6, I2S(R2I(hattrEffect.getMoveVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getMoveDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 7, I2S(R2I(hattrEffect.getStrVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getStrDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 8, I2S(R2I(hattrEffect.getAgiVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAgiDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 9, I2S(R2I(hattrEffect.getIntVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getIntDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 10, I2S(R2I(hattrEffect.getKnockingVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getKnockingDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 11, I2S(R2I(hattrEffect.getViolenceVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getViolenceDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 12, I2S(R2I(hattrEffect.getAimVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAimDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 13, I2S(R2I(hattrEffect.getSplitVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getSplitDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 14, I2S(R2I(hattrEffect.getHemophagiaVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHemophagiaDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 15, I2S(R2I(hattrEffect.getHemophagiaSkillVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHemophagiaSkillDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 16, I2S(R2I(hattrEffect.getLuckVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getLuckDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 17, I2S(R2I(hattrEffect.getHuntAmplitudeVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getHuntAmplitudeDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 18, I2S(R2I(hattrEffect.getBombVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBombRange(hplayer.getSelection(players[i])))+"PX)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 19, I2S(R2I(hattrEffect.getLightningChainOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd["+ hmath.realformat(hattrEffect.getLightningChainVal(hplayer.getSelection(players[i])))+"伤害]["+ hmath.realformat(hattrEffect.getLightningChainQty(hplayer.getSelection(players[i])))+"单位]|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 2, 20, I2S(R2I(hattrEffect.getCrackFlyOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd["+ hmath.realformat(hattrEffect.getCrackFlyVal(hplayer.getSelection(players[i])))+"伤害]|r" )

                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 1, "特效:中毒" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 2, "特效:灼烧" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 3, "特效:枯竭" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 4, "特效:冻结" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 5, "特效:寒冷" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 6, "特效:迟钝" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 7, "特效:麻瓜" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 8, "特效:腐蚀" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 9, "特效:混乱" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 10, "特效:缠绕" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 11, "特效:致盲" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 12, "特效:剧痛" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 13, "特效:乏力" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 14, "特效:束缚" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 15, "特效:愚蠢" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 16, "特效:粗钝" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 17, "特效:尘迹" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 18, "特效:眩晕" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 19, "特效:沉重" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 20, "特效:打断" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 21, "特效:倒霉" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 22, "特效:沉默" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 23, "特效:缴械" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 3, 24, "特效:脚镣" )

                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 1, I2S(R2I(hattrEffect.getPoisonVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getPoisonDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 2, I2S(R2I(hattrEffect.getFireVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFireDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 3, I2S(R2I(hattrEffect.getDryVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDryDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 4, I2S(R2I(hattrEffect.getFreezeVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFreezeDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 5, I2S(R2I(hattrEffect.getColdVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getColdDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 6, I2S(R2I(hattrEffect.getBluntVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBluntDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 7, I2S(R2I(hattrEffect.getMuggleVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getMuggleDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 8, I2S(R2I(hattrEffect.getCorrosionVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getCorrosionDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 9, I2S(R2I(hattrEffect.getChaosVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getChaosDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 10, I2S(R2I(hattrEffect.getTwineVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getTwineDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 11, I2S(R2I(hattrEffect.getBlindVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getBlindDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 12, I2S(R2I(hattrEffect.getTortuaVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getTortuaDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 13, I2S(R2I(hattrEffect.getWeakVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getWeakDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 14, I2S(R2I(hattrEffect.getAstrictVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getAstrictDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 15, I2S(R2I(hattrEffect.getFoolishVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getFoolishDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 16, I2S(R2I(hattrEffect.getDullVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDullDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 17, I2S(R2I(hattrEffect.getDirtVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getDirtDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 18, I2S(R2I(hattrEffect.getSwimOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getSwimDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 19, I2S(R2I(hattrEffect.getHeavyOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getHeavyVal(hplayer.getSelection(players[i])))+"%)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 20, I2S(R2I(hattrEffect.getBreakOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getBreakDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 21, I2S(R2I(hattrEffect.getUnluckVal(hplayer.getSelection(players[i])))) +"|cff7cfcfd("+ hmath.realformat(hattrEffect.getUnluckDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 22, I2S(R2I(hattrEffect.getSilentOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getSilentDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 23, I2S(R2I(hattrEffect.getUnarmOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getUnarmDuring(hplayer.getSelection(players[i])))+"秒)|r" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 4, 24, I2S(R2I(hattrEffect.getFetterOdds(hplayer.getSelection(players[i])))) +"%|cff7cfcfd("+ hmath.realformat(hattrEffect.getFetterDuring(hplayer.getSelection(players[i])))+"秒)|r" )

                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 1, "火攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 2, "土攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 3, "水攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 4, "冰攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 5, "风攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 6, "光攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 7, "暗攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 8, "木攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 9, "雷攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 10, "毒攻击" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 11, "火抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 12, "土抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 13, "水抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 14, "冰抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 15, "风抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 16, "光抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 17, "暗抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 18, "木抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 19, "雷抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 5, 20, "雷抗性" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 1, I2S(R2I(hattrNatural.getFire(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 2, I2S(R2I(hattrNatural.getSoil(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 3, I2S(R2I(hattrNatural.getWater(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 4, I2S(R2I(hattrNatural.getIce(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 5, I2S(R2I(hattrNatural.getWind(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 6, I2S(R2I(hattrNatural.getLight(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 7, I2S(R2I(hattrNatural.getDark(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 8, I2S(R2I(hattrNatural.getWood(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 9, I2S(R2I(hattrNatural.getThunder(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 10, I2S(R2I(hattrNatural.getPoison(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 11, I2S(R2I(hattrNatural.getFireOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 12, I2S(R2I(hattrNatural.getSoilOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 13, I2S(R2I(hattrNatural.getWaterOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 14, I2S(R2I(hattrNatural.getIceOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 15, I2S(R2I(hattrNatural.getWindOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 16, I2S(R2I(hattrNatural.getLightOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 17, I2S(R2I(hattrNatural.getDarkOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 18, I2S(R2I(hattrNatural.getWoodOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 19, I2S(R2I(hattrNatural.getThunderOppose(hplayer.getSelection(players[i])))) +"%" )
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 6, 20, I2S(R2I(hattrNatural.getPoisonOppose(hplayer.getSelection(players[i])))) +"%" )
                else
                    call MultiboardSetRowCount(hmb_selectionEffect[i], 1)
                    call MultiboardSetColumnCount(hmb_selectionEffect[i], 1)
                    call MultiboardSetItemWidthBJ( hmb_selectionEffect[i], 0, 0, 15.00 )
                    call MultiboardSetItemStyleBJ( hmb_selectionEffect[i], 0, 0, true, false )
                    call MultiboardSetTitleText(hmb_selectionEffect[i], "单位特效(未选中单位)")
                    call MultiboardSetItemValueBJ( hmb_selectionEffect[i], 1, 1, "- 请选择单位查看特效属性 -" )
                endif
            endif
        set i = i+1
        endloop
    endmethod

    public static method build takes nothing returns nothing
        call htime.setInterval(1.0,function thistype.buildCall_allPlayer)
        call htime.setInterval(1.0,function thistype.buildCall_my)
        call htime.setInterval(0.3,function thistype.buildCall_value)
        call htime.setInterval(0.5,function thistype.buildCall_selection)
        call htime.setInterval(0.5,function thistype.buildCall_selectionEffect)
    endmethod

    private static method start takes nothing returns nothing
        call build()
    endmethod

    private static method mbap takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_allPlayer, true)
        endif
    endmethod
    private static method mbmy takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_my[i], true)
        endif
    endmethod
    private static method mbv takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_value[i], true)
        endif
    endmethod
    private static method mbs takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_selection[i], true)
        endif
    endmethod
    private static method mbse takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_selectionEffect[i], true)
        endif
    endmethod

    public static method initSet takes nothing returns nothing
        local integer i = 0
        local trigger startTrigger = null
        local trigger mbapTrigger = null
        local trigger mbmyTrigger = null
        local trigger mbvTrigger = null
        local trigger mbsTrigger = null
        local trigger mbseTrigger = null

        set startTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle( startTrigger, 0.00 )
        call TriggerAddAction(startTrigger, function thistype.start)

        set mbapTrigger = CreateTrigger()
        set mbmyTrigger = CreateTrigger()
        set mbvTrigger = CreateTrigger()
        set mbsTrigger = CreateTrigger()
        set mbseTrigger = CreateTrigger()

        set i = 1
        loop
            exitwhen i > player_max_qty
                call TriggerRegisterPlayerChatEvent( mbapTrigger, players[i], "-mbap", true )
                call TriggerAddAction(mbapTrigger, function thistype.mbap)
                call TriggerRegisterPlayerChatEvent( mbmyTrigger, players[i], "-mbmy", true )
                call TriggerAddAction(mbmyTrigger, function thistype.mbmy)
                call TriggerRegisterPlayerChatEvent( mbvTrigger, players[i], "-mbv", true )
                call TriggerAddAction(mbvTrigger, function thistype.mbv)
                call TriggerRegisterPlayerChatEvent( mbsTrigger, players[i], "-mbs", true )
                call TriggerAddAction(mbsTrigger, function thistype.mbs)
                call TriggerRegisterPlayerChatEvent( mbseTrigger, players[i], "-mbse", true )
                call TriggerAddAction(mbseTrigger, function thistype.mbse)
            set i = i + 1
        endloop

        call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "面板信息指令", "-mbap 查看所有玩家状态|n-mbmy 查看你的个人状态|n-mbv 查看你的实时状态|n-mbs 查看选择单位的属性状态|n-mbse 查看选择单位的特效状态", "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )

    endmethod

endstruct
