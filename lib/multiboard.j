
 globals
    hMultiboard hmb
    hashtable hash_hmb = null
    multiboard array hmb_me
    multiboard hmb_all_player = null
    multiboard array hmb_selection_attr
    multiboard array hmb_selection_effect
    multiboard array hmb_selection_natural
    string array hmb_current_type
endglobals

struct hMultiboard

    private static integer HASH_KEY_TITLE = 30001
    private static integer HASH_KEY_ROW = 40001
    private static integer HASH_KEY_COL = 50001
    private static integer HASH_KEY_WIDTH = 60001
    private static integer HASH_KEY_CONTENT = 70001
    private static integer HASH_KEY_ICON = 80001

    //设置多面板行列数（自动设置最大行列数）
    private static method setRowCol takes integer mbid,integer col,integer row returns nothing
        local integer old = 0
        if(mbid != 0)then
            if(col > 0)then
                set old = LoadInteger(hash_hmb,mbid,HASH_KEY_COL)
                if(col > old)then
                    call SaveInteger(hash_hmb,mbid,HASH_KEY_COL,col)
                endif
            endif
            if(row > 0)then
                set old = LoadInteger(hash_hmb,mbid,HASH_KEY_ROW)
                if(row > old)then
                    call SaveInteger(hash_hmb,mbid,HASH_KEY_ROW,row)
                endif
            endif
        endif
    endmethod

    //获取多面板行
    private static method getRow takes integer mbid returns integer
        return LoadInteger(hash_hmb,mbid,HASH_KEY_ROW)
    endmethod

    //获取多面板列
    private static method getCol takes integer mbid returns integer
        return LoadInteger(hash_hmb,mbid,HASH_KEY_COL)
    endmethod

    //设置多面板标题
    public static method setTitle takes integer mbid,string title returns nothing
        if(mbid != 0)then
            call SaveStr(hash_hmb, mbid ,HASH_KEY_TITLE , title )
        endif
    endmethod

    //获取多面板标题
    public static method getTitle takes integer mbid returns string
        return LoadStr(hash_hmb, mbid ,HASH_KEY_TITLE )
    endmethod

    /**
     * 设置多面板内容（自动根据内容设置宽度和样式）
     * col 列 
     * row 行
     * content 内容
     */
    public static method setContent takes integer mbid,integer col,integer row,string content returns nothing
        if(mbid != 0)then
            call SaveStr(hash_hmb,mbid,HASH_KEY_CONTENT+col*100+row,content )
            call thistype.setRowCol(mbid,col,row)
        endif
    endmethod

    /**
     * 设置多面板内容（自动根据内容设置宽度和样式）
     * col 列 
     * row 行
     * content 内容
     */
    public static method setIcon takes integer mbid,integer col,integer row,string icon returns nothing
        if(mbid != 0)then
            call SaveStr(hash_hmb,mbid,HASH_KEY_ICON+col*100+row,icon )
            call thistype.setRowCol(mbid,col,row)
        endif
    endmethod

    /**
     * 设置多面板内容图标（自动根据内容设置宽度和样式）
     * mbid 多面板handleid
     * col 列 
     * row 行
     * content 内容
     * icon 图标
     */
    public static method setContentIcon takes integer mbid,integer col,integer row,string content,string icon returns nothing
        if(mbid>0)then
            call SaveStr(hash_hmb, mbid ,HASH_KEY_CONTENT+col*100+row,content )
            call SaveStr(hash_hmb, mbid ,HASH_KEY_ICON+col*100+row,icon )
            call thistype.setRowCol(mbid,col,row)
        endif
    endmethod

    //获取多面板内容
    private static method getContent takes integer mbid,integer col,integer row returns string
        return LoadStr(hash_hmb, mbid ,HASH_KEY_CONTENT+col*100+row )
    endmethod

    //获取多面板图标
    private static method getIcon takes integer mbid,integer col,integer row returns string
        return LoadStr(hash_hmb, mbid ,HASH_KEY_ICON+col*100+row )
    endmethod

    //根据内容和图标，计算
    private static method getWidth takes string content,boolean hasIcon returns real
        local real len = LoadReal(hash_hmb,StringHash(content),6789)
        local integer chinaQty = 0
        if(len <= 0)then
            set chinaQty = hlogic.getChinaQty(content)
            set len = (I2R(StringLength(content))-I2R(chinaQty)*1.65)*0.40
            call SaveReal(hash_hmb,StringHash(content),6789,len)
        endif
        if( hasIcon )then
            set len = len + 1.76
        endif
        return len
    endmethod

    /**
     * 根据数据设定多面板
     */
    private static method build takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local multiboard mb = htime.getMultiboard(t,1)
        local integer mbid = GetHandleId(mb)
        local integer maxcol = getCol(mbid)
        local integer maxrow = getRow(mbid)
        local string content = ""
        local string icon = ""
        local integer col = 0
        local integer row = 0
        local real width = 0
        local real tempwidth = 0
        if(maxcol > 0 and maxrow>0)then
            call MultiboardSetTitleText(mb,getTitle(mbid))
            call MultiboardSetColumnCount(mb,maxcol)
            call MultiboardSetRowCount(mb,maxrow)
            set col = 1
            loop
                exitwhen col>maxcol
                set row = 1
                set width = 0
                loop
                    exitwhen row>maxrow
                        set content = getContent(mbid,col,row)
                        set icon = getIcon(mbid,col,row)
                        if(content!="" and content != null)then
                            call MultiboardSetItemValue( MultiboardGetItem(mb,row-1,col-1), content )
                        endif
                        if(icon!="" and icon != null)then
                            call MultiboardSetItemIcon( MultiboardGetItem(mb,row-1,col-1), icon )
                            call MultiboardSetItemStyle( MultiboardGetItem(mb,row-1,col-1), true, true )
                            set tempwidth = thistype.getWidth(content,true)
                        else
                            call MultiboardSetItemStyle( MultiboardGetItem(mb,row-1,col-1), true, false )
                            set tempwidth = thistype.getWidth(content,false)
                        endif
                        if(tempwidth > width)then
                            set width = tempwidth
                        endif
                    set row = row+1
                endloop
                call MultiboardSetItemWidthBJ( mb, col, 0, width )
                set col = col+1
            endloop
        endif
    endmethod

    private static method hJassDefault_allPlayer takes nothing returns nothing
        local timer t = null
        local integer mbid = 0
        local integer i = 0
        local integer j = 0
        local boolean isDo = false
        set i = 1
        loop
            exitwhen i > player_max_qty
                if ( hmb_current_type[i] == "mbap" ) then
                    set  isDo = true
                    call DoNothing() YDNL exitwhen true
                endif
            set i = i+1
        endloop
        if( isDo == true)then
            set mbid = GetHandleId(hmb_all_player)
            call setTitle( mbid , "所有玩家情报( "+I2S(player_current_qty)+" 名 )")
            set i = 1
            set j = 2
            loop
                exitwhen i > player_max_qty
                if ( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                    call setContent( mbid, 1, j, GetPlayerName(players[i]) )
                    call setContentIcon( mbid, 2, j, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[i])))+"."+hplayer.getHeroName(players[i]),hplayer.getHeroAvatar(players[i]) )
                    call setContent( mbid , 3, j, I2S(hplayer.getGold(players[i]))+"("+R2S(hplayer.getGoldRatio(players[i]))+"%)" )
                    call setContent( mbid , 4, j, I2S(hplayer.getLumber(players[i]))+"("+R2S(hplayer.getLumberRatio(players[i]))+"%)" )
                    call setContent( mbid,  5, j, R2S(hplayer.getExpRatio(players[i]))+"%" )
                    call setContent( mbid , 6, j, I2S(hplayer.getKill(players[i])) )
                    call setContent( mbid , 7, j, I2S(GetPlayerStructureCount(players[i], false))+"/"+I2S(GetPlayerStructureCount(players[i], true) ))
                    call setContent( mbid , 8, j, hlogic.realformat(hplayer.getDamage(players[i])) )
                    call setContent( mbid , 9, j, hlogic.realformat(hplayer.getBeDamage(players[i])) )
                    call setContent( mbid ,10, j, hlogic.realformat(hplayer.getTotalGold(players[i])) )
                    call setContent( mbid ,11, j, hlogic.realformat(hplayer.getTotalLumber(players[i])) )
                    call setContent( mbid ,12, j, hlogic.realformat(hplayer.getTotalGoldCost(players[i])) )
                    call setContent( mbid ,13, j, hlogic.realformat(hplayer.getTotalLumberCost(players[i])) )
                    call setContent( mbid ,14, j, hplayer.getStatus(players[i]) )
                    call setContent( mbid ,15, j, I2S(hplayer.getApm(players[i])) )
                    set j = j + 1
                endif
                set i = i + 1
            endloop
            set t = htime.setTimeout(0.3,function thistype.build)
            call htime.setMultiboard(t,1,hmb_all_player)
        endif
    endmethod

    private static method hJassDefault_me takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = htime.getInteger(t,1)
        local integer mbid = 0
        if(players[i]==null or his.playing(players[i])==false)then
            call htime.delTimer(t)
            return
        endif
        if(hmb_me[i]!=null and hmb_current_type[i] == "mbme")then
            set mbid = GetHandleId(hmb_me[i])
            call setTitle(mbid, "你的个人状态("+GetPlayerName(players[i])+")")

            call setContent( mbid, 2, 1, I2S(hplayer.getGold(players[i]))+"("+R2S(hplayer.getGoldRatio(players[i]))+"%)" )
            call setContent( mbid, 2, 2, I2S(hplayer.getLumber(players[i]))+"("+R2S(hplayer.getLumberRatio(players[i]))+"%)" )
            call setContent( mbid, 2, 3, R2S(hplayer.getExpRatio(players[i]))+"%" )
            call setContent( mbid, 2, 4, I2S(hplayer.getKill(players[i])) )
            call setContent( mbid, 2, 5, hlogic.realformat(hplayer.getDamage(players[i])) )
            call setContent( mbid, 2, 6, hlogic.realformat(hplayer.getBeDamage(players[i])) )
            call setContent( mbid, 2, 7, hlogic.realformat(hplayer.getTotalGold(players[i])) )
            call setContent( mbid, 2, 8, hlogic.realformat(hplayer.getTotalLumber(players[i])) )
            call setContent( mbid, 2, 9, hlogic.realformat(hplayer.getTotalGoldCost(players[i])) )
            call setContent( mbid, 2,10, hlogic.realformat(hplayer.getTotalLumberCost(players[i])) )
            call setContent( mbid, 2,11, hplayer.getStatus(players[i]) )
            call setContent( mbid, 2,12, I2S(hplayer.getApm(players[i])) )

            call setContentIcon( mbid, 4, 1, hplayer.getHeroName(players[i]) , hplayer.getHeroAvatar(players[i]) )
            call setContent( mbid, 4, 2, "Lv "+I2S(GetUnitLevel(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4, 3, "type" )
            call setContent( mbid, 4, 4, R2S(hunit.getLife(hplayer.getHero(players[i])))+" / "+R2S(hunit.getMaxLife(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4, 5, R2S(hattr.getLifeSourceCurrent(hplayer.getHero(players[i])))+" / "+R2S(hattr.getLifeSource(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4, 6, R2S(hunit.getMana(hplayer.getHero(players[i])))+" / "+R2S(hunit.getMaxMana(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4, 7, R2S(hattr.getManaSourceCurrent(hplayer.getHero(players[i])))+" / "+R2S(hattr.getManaSource(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4, 8, I2S(R2I(hattr.getMove(hplayer.getHero(players[i])))) )
            call setContent( mbid, 4, 9, R2S(hattr.getPunishCurrent(hplayer.getHero(players[i])))+" / "+R2S(hattr.getPunish(hplayer.getHero(players[i]))) )
            call setContent( mbid, 4,10, R2S(hattr.getWeightCurrent(hplayer.getHero(players[i])))+" / "+R2S(hattr.getWeight(hplayer.getHero(players[i]))) )

            set t = htime.setTimeout(0.3,function thistype.build)
            call htime.setMultiboard(t,1,hmb_me[i])
        endif
    endmethod

    private static method hJassDefault_selection_attr takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = htime.getInteger(t,1)
        local integer mbid = 0
        if(players[i]==null or his.playing(players[i])==false)then
            call htime.delTimer(t)
            return
        endif
        if(hmb_selection_attr[i]!=null and hmb_current_type[i] == "mbsa")then
            if(hplayer.getSelection(players[i])!=null)then
                set mbid = GetHandleId(hmb_selection_attr[i])
                call setTitle(mbid, "属性( "+GetUnitName(hplayer.getSelection(players[i]))+" )")

                call setContent( mbid, 2, 1, R2S(hunit.getLife(hplayer.getSelection(players[i])))+" / "+R2S(hunit.getMaxLife(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2, 2, R2S(hunit.getMana(hplayer.getSelection(players[i])))+" / "+R2S(hunit.getMaxMana(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2, 3, R2S(hattr.getPunishCurrent(hplayer.getSelection(players[i])))+" / "+R2S(hattr.getPunish(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2, 4, I2S(R2I(hattr.getMove(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2, 5, R2S(hattr.getLifeBack(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2, 6, R2S(hattr.getManaBack(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2, 7, I2S(R2I(hattr.getAttackPhysical(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2, 8, I2S(R2I(hattr.getAttackMagic(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2, 9, I2S(R2I(hattr.getAttackSpeed(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,10, I2S(R2I(hattr.getDefend(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2,11, R2S(hattr.getResistance(hplayer.getSelection(players[i])))+"%" )
                call setContent( mbid, 2,12, R2S(hattr.getAvoid(hplayer.getSelection(players[i])))+"%" )
                call setContent( mbid, 2,13, R2S(hattr.getAim(hplayer.getSelection(players[i])))+"%" )
                call setContent( mbid, 2,14, R2S(hattr.getToughness(hplayer.getSelection(players[i]))) )
                call setContent( mbid, 2,15, I2S(R2I(hattr.getKnocking(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2,16, I2S(R2I(hattr.getViolence(hplayer.getSelection(players[i])))) )
                call setContent( mbid, 2,17, I2S(R2I(hattr.getMortalOppose(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,18, I2S(R2I(hattr.getSplit(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,19, I2S(R2I(hattr.getHemophagia(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,20, I2S(R2I(hattr.getHemophagiaSkill(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,21, R2S(hattr.getSwimOppose(hplayer.getSelection(players[i])))+"%" )
                call setContent( mbid, 2,22, R2S(hattr.getPunishOppose(hplayer.getSelection(players[i])))+"%" )
                call setContent( mbid, 2,23, I2S(R2I(hattr.getLuck(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,24, I2S(R2I(hattr.getInvincible(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,25, I2S(R2I(hattr.getHuntAmplitude(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,26, I2S(R2I(hattr.getHuntRebound(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,27, I2S(R2I(hattr.getCure(hplayer.getSelection(players[i]))))+"%" )
                call setContent( mbid, 2,28, I2S(R2I(hattr.getHelp(hplayer.getHero(players[i])))) )

                set t = htime.setTimeout(0.3,function thistype.build)
                call htime.setMultiboard(t,1,hmb_selection_attr[i])
            else
                call MultiboardSetTitleText(hmb_selection_attr[i], "单位状态(未锁定单位)")
                call MultiboardSetItemValueBJ( hmb_selection_attr[i], 1, 1, "- 请“双击”锁定选择单位查看常规属性 -" )
                call MultiboardSetRowCount(hmb_selection_attr[i], 1)
                call MultiboardSetColumnCount(hmb_selection_attr[i], 1)
                call MultiboardSetItemWidthBJ( hmb_selection_attr[i], 0, 0, 15.00 )
                call MultiboardSetItemStyleBJ( hmb_selection_attr[i], 0, 0, true, false )
            endif
        endif
    endmethod

    private static method hJassDefault_selection_effect takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = htime.getInteger(t,1)
        local integer mbid = 0
        if(players[i]==null or his.playing(players[i])==false)then
            call htime.delTimer(t)
            return
        endif
        if(hmb_selection_effect[i]!=null and hmb_current_type[i] == "mbse")then
            if(hplayer.getSelection(players[i])!=null)then
                set mbid = GetHandleId(hmb_selection_effect[i])
                call setTitle(mbid, "攻击/伤害特效( "+GetUnitName(hplayer.getSelection(players[i]))+" )")
                call setContent(mbid, 2, 1, I2S(R2I(hattrEffect.getLifeBackVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getLifeBackDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 2, I2S(R2I(hattrEffect.getManaBackVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getManaBackDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 3, I2S(R2I(hattrEffect.getAttackSpeedVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAttackSpeedDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 4, I2S(R2I(hattrEffect.getAttackPhysicalVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAttackPhysicalDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 5, I2S(R2I(hattrEffect.getAttackMagicVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAttackMagicDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 6, I2S(R2I(hattrEffect.getMoveVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getMoveDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 7, I2S(R2I(hattrEffect.getStrVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getStrDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 8, I2S(R2I(hattrEffect.getAgiVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAgiDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 9, I2S(R2I(hattrEffect.getIntVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getIntDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 10, I2S(R2I(hattrEffect.getKnockingVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getKnockingDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 11, I2S(R2I(hattrEffect.getViolenceVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getViolenceDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 12, I2S(R2I(hattrEffect.getAimVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAimDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 13, I2S(R2I(hattrEffect.getSplitVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getSplitDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 14, I2S(R2I(hattrEffect.getHemophagiaVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getHemophagiaDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 15, I2S(R2I(hattrEffect.getHemophagiaSkillVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getHemophagiaSkillDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 16, I2S(R2I(hattrEffect.getLuckVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getLuckDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 17, I2S(R2I(hattrEffect.getHuntAmplitudeVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getHuntAmplitudeDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 18, I2S(R2I(hattrEffect.getBombVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getBombRange(hplayer.getSelection(players[i])))+"PX)" )
                call setContent(mbid, 2, 19, I2S(R2I(hattrEffect.getLightningChainOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getLightningChainVal(hplayer.getSelection(players[i])))+"伤害)("+ hlogic.realformat(hattrEffect.getLightningChainQty(hplayer.getSelection(players[i])))+"单位)" )
                call setContent(mbid, 2, 20, I2S(R2I(hattrEffect.getCrackFlyOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getCrackFlyVal(hplayer.getSelection(players[i])))+"伤害)" )
                call setContent(mbid, 2, 21, I2S(R2I(hattrEffect.getSilentOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getSilentDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 2, 22, I2S(R2I(hattrEffect.getUnarmOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getUnarmDuring(hplayer.getSelection(players[i])))+"秒)" )

                call setContent(mbid, 4, 1, I2S(R2I(hattrEffect.getPoisonVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getPoisonDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 2, I2S(R2I(hattrEffect.getFireVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getFireDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 3, I2S(R2I(hattrEffect.getDryVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getDryDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 4, I2S(R2I(hattrEffect.getFreezeVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getFreezeDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 5, I2S(R2I(hattrEffect.getColdVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getColdDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 6, I2S(R2I(hattrEffect.getBluntVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getBluntDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 7, I2S(R2I(hattrEffect.getMuggleVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getMuggleDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 8, I2S(R2I(hattrEffect.getCorrosionVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getCorrosionDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 9, I2S(R2I(hattrEffect.getChaosVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getChaosDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 10, I2S(R2I(hattrEffect.getTwineVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getTwineDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 11, I2S(R2I(hattrEffect.getBlindVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getBlindDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 12, I2S(R2I(hattrEffect.getTortuaVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getTortuaDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 13, I2S(R2I(hattrEffect.getWeakVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getWeakDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 14, I2S(R2I(hattrEffect.getAstrictVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getAstrictDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 15, I2S(R2I(hattrEffect.getFoolishVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getFoolishDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 16, I2S(R2I(hattrEffect.getDullVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getDullDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 17, I2S(R2I(hattrEffect.getDirtVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getDirtDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 18, I2S(R2I(hattrEffect.getSwimOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getSwimDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 19, I2S(R2I(hattrEffect.getHeavyOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getHeavyVal(hplayer.getSelection(players[i])))+"%)" )
                call setContent(mbid, 4, 20, I2S(R2I(hattrEffect.getBreakOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getBreakDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 21, I2S(R2I(hattrEffect.getUnluckVal(hplayer.getSelection(players[i])))) +"("+ hlogic.realformat(hattrEffect.getUnluckDuring(hplayer.getSelection(players[i])))+"秒)" )
                call setContent(mbid, 4, 22, I2S(R2I(hattrEffect.getFetterOdds(hplayer.getSelection(players[i])))) +"%("+ hlogic.realformat(hattrEffect.getFetterDuring(hplayer.getSelection(players[i])))+"秒)" )
                
                set t = htime.setTimeout(0.3,function thistype.build)
                call htime.setMultiboard(t,1,hmb_selection_effect[i])
            else
                call MultiboardSetTitleText(hmb_selection_effect[i], "单位状态(未锁定单位)")
                call MultiboardSetItemValueBJ( hmb_selection_effect[i], 1, 1, "- 请“双击”锁定选择单位查看攻击/伤害特效属性 -" )
                call MultiboardSetRowCount(hmb_selection_effect[i], 1)
                call MultiboardSetColumnCount(hmb_selection_effect[i], 1)
                call MultiboardSetItemWidthBJ( hmb_selection_effect[i], 0, 0, 15.00 )
                call MultiboardSetItemStyleBJ( hmb_selection_effect[i], 0, 0, true, false )
            endif
        endif
    endmethod

    private static method hJassDefault_selection_natural takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = htime.getInteger(t,1)
        local integer mbid = 0
        if(players[i]==null or his.playing(players[i])==false)then
            call htime.delTimer(t)
            return
        endif
        if(hmb_selection_natural[i]!=null and hmb_current_type[i] == "mbsn")then
            if(hplayer.getSelection(players[i])!=null)then
                set mbid = GetHandleId(hmb_selection_natural[i])
                call setTitle(mbid, "自然( "+GetUnitName(hplayer.getSelection(players[i]))+" )")
                call setContent(mbid, 2, 1, I2S(R2I(hattrNatural.getFire(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 2, I2S(R2I(hattrNatural.getSoil(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 3, I2S(R2I(hattrNatural.getWater(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 4, I2S(R2I(hattrNatural.getIce(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 5, I2S(R2I(hattrNatural.getWind(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 6, I2S(R2I(hattrNatural.getLight(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 7, I2S(R2I(hattrNatural.getDark(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 8, I2S(R2I(hattrNatural.getWood(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 9, I2S(R2I(hattrNatural.getThunder(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 2, 10,I2S(R2I(hattrNatural.getPoison(hplayer.getSelection(players[i])))) +"%" )

                call setContent(mbid, 4, 1, I2S(R2I(hattrNatural.getFireOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 2, I2S(R2I(hattrNatural.getSoilOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 3, I2S(R2I(hattrNatural.getWaterOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 4, I2S(R2I(hattrNatural.getIceOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 5, I2S(R2I(hattrNatural.getWindOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 6, I2S(R2I(hattrNatural.getLightOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 7, I2S(R2I(hattrNatural.getDarkOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 8, I2S(R2I(hattrNatural.getWoodOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4, 9, I2S(R2I(hattrNatural.getThunderOppose(hplayer.getSelection(players[i])))) +"%" )
                call setContent(mbid, 4,10, I2S(R2I(hattrNatural.getPoisonOppose(hplayer.getSelection(players[i])))) +"%" )

                set t = htime.setTimeout(0.3,function thistype.build)
                call htime.setMultiboard(t,1,hmb_selection_natural[i])
            else
                call MultiboardSetTitleText(hmb_selection_natural[i], "单位状态(未锁定单位)")
                call MultiboardSetItemValueBJ( hmb_selection_natural[i], 1, 1, "- 请“双击”锁定选择单位查看自然属性 -" )
                call MultiboardSetRowCount(hmb_selection_natural[i], 1)
                call MultiboardSetColumnCount(hmb_selection_natural[i], 1)
                call MultiboardSetItemWidthBJ( hmb_selection_natural[i], 0, 0, 15.00 )
                call MultiboardSetItemStyleBJ( hmb_selection_natural[i], 0, 0, true, false )
            endif
        endif
    endmethod


    private static method start takes nothing returns nothing
        local integer i = 0
        local integer mbid = 0
        local timer t = null
        if(hmb_all_player == null) then
            set hmb_all_player = CreateMultiboard()
            set mbid = GetHandleId(hmb_all_player)
            call setContentIcon( mbid , 1, 1, "玩家名称","ReplaceableTextures\\CommandButtons\\BTNVillagerMan1.blp" )
            call setContentIcon( mbid , 2, 1, "英雄","ReplaceableTextures\\CommandButtons\\BTNChaosWarlord.blp" )
            call setContentIcon( mbid , 3, 1, "黄金(率)","ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
            call setContentIcon( mbid , 4, 1, "木头(率)","ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
            call setContentIcon( mbid , 5, 1, "经验率","ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
            call setContentIcon( mbid , 6, 1, "杀敌数","ReplaceableTextures\\CommandButtons\\BTNBattleStations.blp" )
            call setContentIcon( mbid , 7, 1, "建筑数","ReplaceableTextures\\CommandButtons\\BTNHumanBuild.blp" )
            call setContentIcon( mbid , 8, 1, "造成伤害","ReplaceableTextures\\CommandButtons\\BTNHardenedSkin.blp" )
            call setContentIcon( mbid , 9, 1, "承受伤害","ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp" )
            call setContentIcon( mbid ,10, 1, "获金总量","ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
            call setContentIcon( mbid ,11, 1, "获木总量","ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
            call setContentIcon( mbid ,12, 1, "耗金总量","ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
            call setContentIcon( mbid ,13, 1, "耗木总量","ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
            call setContentIcon( mbid ,14, 1, "状态","ReplaceableTextures\\CommandButtons\\BTNPurge.blp" )
            call setContentIcon( mbid ,15, 1, "APM","ReplaceableTextures\\CommandButtons\\BTNAttackGround.blp" )
            call htime.setInterval(2.0,function thistype.hJassDefault_allPlayer)
        endif
        set i = 1
        loop
            exitwhen i > player_max_qty
            if( hplayer.getStatus(players[i]) != hplayer.default_status_nil ) then
                if(hmb_me[i] == null) then
                    set hmb_me[i] = CreateMultiboard()
                    set mbid = GetHandleId(hmb_me[i])
                    call setContentIcon( mbid, 1, 1, "黄金(率)", "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
                    call setContentIcon( mbid, 1, 2, "木头(率)", "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
                    call setContentIcon( mbid, 1, 3, "经验率", "ReplaceableTextures\\CommandButtons\\BTNTomeBrown.blp" )
                    call setContentIcon( mbid, 1, 4, "杀敌数", "ReplaceableTextures\\CommandButtons\\BTNBattleStations.blp" )
                    call setContentIcon( mbid, 1, 5, "造成伤害", "ReplaceableTextures\\CommandButtons\\BTNHardenedSkin.blp" )
                    call setContentIcon( mbid, 1, 6, "承受伤害", "ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp" )
                    call setContentIcon( mbid, 1, 7, "获金总量", "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
                    call setContentIcon( mbid, 1, 8, "获木总量", "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
                    call setContentIcon( mbid, 1, 9, "耗金总量", "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" )
                    call setContentIcon( mbid, 1,10, "耗木总量", "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" )
                    call setContentIcon( mbid, 1,11, "状态", "ReplaceableTextures\\CommandButtons\\BTNPurge.blp" )
                    call setContentIcon( mbid, 1,12, "APM", "ReplaceableTextures\\CommandButtons\\BTNAttackGround.blp" )
                    call setContentIcon( mbid, 3, 1, "英雄名称", "ReplaceableTextures\\CommandButtons\\BTNChaosWarlord.blp" )
                    call setContentIcon( mbid, 3, 2, "英雄等级", "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
                    call setContentIcon( mbid, 3, 3, "英雄类型", "ReplaceableTextures\\CommandButtons\\BTNOrcCaptureFlag.blp" )
                    call setContentIcon( mbid, 3, 4, "生命量", "ReplaceableTextures\\CommandButtons\\BTNPeriapt.blp" )
                    call setContentIcon( mbid, 3, 5, "生命源", "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp" )
                    call setContentIcon( mbid, 3, 6, "魔法量", "ReplaceableTextures\\CommandButtons\\BTNPendantOfMana.blp" )
                    call setContentIcon( mbid, 3, 7, "魔法源", "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp" )
                    call setContentIcon( mbid, 3, 8, "移动力", "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp" )
                    call setContentIcon( mbid, 3, 9, "僵直度", "ReplaceableTextures\\CommandButtons\\BTNSirenAdept.blp" )
                    call setContentIcon( mbid, 3,10, "负重量", "ReplaceableTextures\\CommandButtons\\BTNPackBeast.blp" )
                    set t = htime.setInterval(2.0,function thistype.hJassDefault_me)
                    call htime.setInteger(t,1,i)
                endif
                if(hmb_selection_attr[i] == null) then
                    set hmb_selection_attr[i] = CreateMultiboard()
                    set mbid = GetHandleId(hmb_selection_attr[i])
                    call setContentIcon( mbid, 1, 1, "生命", "ReplaceableTextures\\CommandButtons\\BTNPeriapt.blp" )
                    call setContentIcon( mbid, 1, 2, "魔法", "ReplaceableTextures\\CommandButtons\\BTNPendantOfMana.blp" )
                    call setContentIcon( mbid, 1, 3, "硬直", "ReplaceableTextures\\CommandButtons\\BTNSirenAdept.blp" )
                    call setContentIcon( mbid, 1, 4, "移动力", "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp" )
                    call setContentIcon( mbid, 1, 5, "生命恢复", "ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall.blp" )
                    call setContentIcon( mbid, 1, 6, "魔法恢复", "ReplaceableTextures\\CommandButtons\\BTNPotionOfClarity.blp" )
                    call setContentIcon( mbid, 1, 7, "物理攻击", "ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp" )
                    call setContentIcon( mbid, 1, 8, "魔法攻击", "ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp" )
                    call setContentIcon( mbid, 1, 9, "攻击速度", "ReplaceableTextures\\CommandButtons\\BTNGlove.blp" )
                    call setContentIcon( mbid, 1,10, "护甲", "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpOne.blp" )
                    call setContentIcon( mbid, 1,11, "魔抗", "ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp" )
                    call setContentIcon( mbid, 1,12, "回避", "ReplaceableTextures\\CommandButtons\\BTNInvisibility.blp" )
                    call setContentIcon( mbid, 1,13, "命中", "ReplaceableTextures\\CommandButtons\\BTNMarksmanship.blp" )
                    call setContentIcon( mbid, 1,14, "韧性", "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeTwo.blp" )
                    call setContentIcon( mbid, 1,15, "物理暴击", "ReplaceableTextures\\CommandButtons\\BTNHardenedSkin.blp" )
                    call setContentIcon( mbid, 1,16, "魔法暴击", "ReplaceableTextures\\CommandButtons\\BTNGolemThunderclap.blp" )
                    call setContentIcon( mbid, 1,17, "致命抵抗", "ReplaceableTextures\\CommandButtons\\BTNPillage.blp" )
                    call setContentIcon( mbid, 1,18, "分裂", "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp" )
                    call setContentIcon( mbid, 1,19, "吸血", "ReplaceableTextures\\CommandButtons\\BTNVampiricAura.blp" )
                    call setContentIcon( mbid, 1,20, "技能吸血", "ReplaceableTextures\\CommandButtons\\BTNHeal.blp" )
                    call setContentIcon( mbid, 1,21, "眩晕抵抗", "ReplaceableTextures\\CommandButtons\\BTNNeutralManaShield.blp" )
                    call setContentIcon( mbid, 1,22, "硬直抵抗", "ReplaceableTextures\\CommandButtons\\BTNSirenMaster.blp" )
                    call setContentIcon( mbid, 1,23, "运气", "ReplaceableTextures\\CommandButtons\\BTNUnstableConcoction.blp" )
                    call setContentIcon( mbid, 1,24, "无敌", "ReplaceableTextures\\CommandButtons\\BTNDivineIntervention.blp" )
                    call setContentIcon( mbid, 1,25, "伤害增幅", "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheWild.blp" )
                    call setContentIcon( mbid, 1,26, "伤害反射", "ReplaceableTextures\\CommandButtons\\BTNThornShield.blp" )
                    call setContentIcon( mbid, 1,27, "治疗", "ReplaceableTextures\\CommandButtons\\BTNHealingSalve.blp" )
                    call setContentIcon( mbid, 1,28, "救助力", "ReplaceableTextures\\CommandButtons\\BTNAnkh.blp" )
                    set t = htime.setInterval(2.0,function thistype.hJassDefault_selection_attr)
                    call htime.setInteger(t,1,i)
                endif
                if(hmb_selection_effect[i] == null) then
                    set hmb_selection_effect[i] = CreateMultiboard()
                    set mbid = GetHandleId(hmb_selection_effect[i])
                    call setContentIcon(mbid, 1, 1, "特效:生命恢复", "ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall.blp" )
                    call setContentIcon(mbid, 1, 2, "特效:魔法恢复", "ReplaceableTextures\\CommandButtons\\BTNPotionOfClarity.blp" )
                    call setContentIcon(mbid, 1, 3, "特效:攻击速度", "ReplaceableTextures\\CommandButtons\\BTNGlove.blp" )
                    call setContentIcon(mbid, 1, 4, "特效:物理攻击", "ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp" )
                    call setContentIcon(mbid, 1, 5, "特效:魔法攻击", "ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp" )
                    call setContentIcon(mbid, 1, 6, "特效:移动力", "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp" )
                    call setContentIcon(mbid, 1, 7, "特效:力量", "ReplaceableTextures\\CommandButtons\\BTNBelt.blp" )
                    call setContentIcon(mbid, 1, 8, "特效:敏捷", "ReplaceableTextures\\CommandButtons\\BTNBoots.blp" )
                    call setContentIcon(mbid, 1, 9, "特效:智力", "ReplaceableTextures\\CommandButtons\\BTNRobeOfTheMagi.blp" )
                    call setContentIcon(mbid, 1,10, "特效:物理暴击", "ReplaceableTextures\\CommandButtons\\BTNHardenedSkin.blp" )
                    call setContentIcon(mbid, 1,11, "特效:魔法暴击", "ReplaceableTextures\\CommandButtons\\BTNGolemThunderclap.blp" )
                    call setContentIcon(mbid, 1,12, "特效:命中", "ReplaceableTextures\\CommandButtons\\BTNMarksmanship.blp" )
                    call setContentIcon(mbid, 1,13, "特效:分裂", "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp" )
                    call setContentIcon(mbid, 1,14, "特效:吸血", "ReplaceableTextures\\CommandButtons\\BTNVampiricAura.blp" )
                    call setContentIcon(mbid, 1,15, "特效:技能吸血", "ReplaceableTextures\\CommandButtons\\BTNHeal.blp" )
                    call setContentIcon(mbid, 1,16, "特效:运气", "ReplaceableTextures\\CommandButtons\\BTNUnstableConcoction.blp" )
                    call setContentIcon(mbid, 1,17, "特效:伤害增幅", "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheWild.blp" )
                    call setContentIcon(mbid, 1,18, "特效:爆破", "ReplaceableTextures\\CommandButtons\\BTNVolcano.blp" )
                    call setContentIcon(mbid, 1,19, "特效:闪电链", "ReplaceableTextures\\CommandButtons\\BTNChainLightning.blp" )
                    call setContentIcon(mbid, 1,20, "特效:击飞", "ReplaceableTextures\\CommandButtons\\BTNNagaUnBurrow.blp" )
                    call setContentIcon(mbid, 1,21, "特效:沉默", "ReplaceableTextures\\CommandButtons\\BTNSilence.blp" )
                    call setContentIcon(mbid, 1,22, "特效:缴械", "ReplaceableTextures\\CommandButtons\\BTNPossession.blp")
                    call setContentIcon(mbid, 3, 1, "特效:中毒", "ReplaceableTextures\\CommandButtons\\BTNOrbOfVenom.blp" )
                    call setContentIcon(mbid, 3, 2, "特效:灼烧", "ReplaceableTextures\\CommandButtons\\BTNOrbOfFire.blp" )
                    call setContentIcon(mbid, 3, 3, "特效:枯竭", "ReplaceableTextures\\CommandButtons\\BTNDarkRitual.blp" )
                    call setContentIcon(mbid, 3, 4, "特效:冻结", "ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp" )
                    call setContentIcon(mbid, 3, 5, "特效:寒冷", "ReplaceableTextures\\CommandButtons\\BTNOrbOfFrost.blp" )
                    call setContentIcon(mbid, 3, 6, "特效:迟钝", "ReplaceableTextures\\CommandButtons\\BTNStasisTrap.blp" )
                    call setContentIcon(mbid, 3, 7, "特效:麻瓜", "ReplaceableTextures\\CommandButtons\\BTNAntiMagicShell.blp")
                    call setContentIcon(mbid, 3, 8, "特效:腐蚀", "ReplaceableTextures\\CommandButtons\\BTNOrbOfCorruption.blp" )
                    call setContentIcon(mbid, 3, 9, "特效:混乱", "ReplaceableTextures\\CommandButtons\\BTNDevourMagic.blp" )
                    call setContentIcon(mbid, 3,10, "特效:缠绕", "ReplaceableTextures\\CommandButtons\\BTNEntanglingRoots.blp" )
                    call setContentIcon(mbid, 3,11, "特效:致盲", "ReplaceableTextures\\CommandButtons\\BTNCharm.blp" )
                    call setContentIcon(mbid, 3,12, "特效:剧痛", "ReplaceableTextures\\CommandButtons\\BTNFanOfKnives.blp" )
                    call setContentIcon(mbid, 3,13, "特效:乏力", "ReplaceableTextures\\CommandButtons\\BTNBanish.blp" )
                    call setContentIcon(mbid, 3,14, "特效:束缚", "ReplaceableTextures\\CommandButtons\\BTNPurge.blp" )
                    call setContentIcon(mbid, 3,15, "特效:愚蠢", "ReplaceableTextures\\CommandButtons\\BTNUnsummonBuilding.blp" )
                    call setContentIcon(mbid, 3,16, "特效:粗钝", "ReplaceableTextures\\CommandButtons\\BTNEatTree.blp" )
                    call setContentIcon(mbid, 3,17, "特效:尘迹", "ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness.blp")
                    call setContentIcon(mbid, 3,18, "特效:眩晕", "ReplaceableTextures\\CommandButtons\\BTNStun.blp" )
                    call setContentIcon(mbid, 3,19, "特效:沉重", "ReplaceableTextures\\CommandButtons\\BTNDevour.blp" )
                    call setContentIcon(mbid, 3,20, "特效:打断", "ReplaceableTextures\\CommandButtons\\BTNCriticalStrike.blp" )
                    call setContentIcon(mbid, 3,21, "特效:倒霉", "ReplaceableTextures\\CommandButtons\\BTNBigBadVoodooSpell.blp" )
                    call setContentIcon(mbid, 3,22, "特效:脚镣", "ReplaceableTextures\\CommandButtons\\BTNSlow.blp")
                    set t = htime.setInterval(2.0,function thistype.hJassDefault_selection_effect)
                    call htime.setInteger(t,1,i)
                endif
                if(hmb_selection_natural[i] == null) then
                    set hmb_selection_natural[i] = CreateMultiboard()
                    set mbid = GetHandleId(hmb_selection_natural[i])
                    call setContentIcon(mbid, 1, 1, "火攻击", "ReplaceableTextures\\CommandButtons\\BTNFire.blp")
                    call setContentIcon(mbid, 1, 2, "土攻击", "ReplaceableTextures\\CommandButtons\\BTNEarthquake.blp")
                    call setContentIcon(mbid, 1, 3, "水攻击", "ReplaceableTextures\\CommandButtons\\BTNCrushingWave.blp")
                    call setContentIcon(mbid, 1, 4, "冰攻击", "ReplaceableTextures\\CommandButtons\\BTNGlacier.blp")
                    call setContentIcon(mbid, 1, 5, "风攻击", "ReplaceableTextures\\CommandButtons\\BTNCyclone.blp")
                    call setContentIcon(mbid, 1, 6, "光攻击", "ReplaceableTextures\\CommandButtons\\BTNHolyBolt.blp")
                    call setContentIcon(mbid, 1, 7, "暗攻击", "ReplaceableTextures\\CommandButtons\\BTNTheBlackArrow.blp")
                    call setContentIcon(mbid, 1, 8, "木攻击", "ReplaceableTextures\\CommandButtons\\BTNThorns.blp")
                    call setContentIcon(mbid, 1, 9, "雷攻击", "ReplaceableTextures\\CommandButtons\\BTNBanish.blp")
                    call setContentIcon(mbid, 1,10, "毒攻击", "ReplaceableTextures\\CommandButtons\\BTNCorrosiveBreath.blp")
                    call setContent(mbid, 3, 1, "火抗性")
                    call setContent(mbid, 3, 2, "土抗性")
                    call setContent(mbid, 3, 3, "水抗性")
                    call setContent(mbid, 3, 4, "冰抗性")
                    call setContent(mbid, 3, 5, "风抗性")
                    call setContent(mbid, 3, 6, "光抗性")
                    call setContent(mbid, 3, 7, "暗抗性")
                    call setContent(mbid, 3, 8, "木抗性")
                    call setContent(mbid, 3, 9, "雷抗性")
                    call setContent(mbid, 3,10, "毒抗性")
                    set t = htime.setInterval(2.0,function thistype.hJassDefault_selection_natural)
                    call htime.setInteger(t,1,i)
                endif
            endif
        endloop
    endmethod

    private static method mbap takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        set hmb_current_type[i] = "mbap"
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_all_player, true)
        endif
    endmethod
    private static method mbme takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        set hmb_current_type[i] = "mbme"
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_me[i], true)
        endif
    endmethod
    private static method mbsa takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        set hmb_current_type[i] = "mbsa"
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_selection_attr[i], true)
        endif
    endmethod
    private static method mbse takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        set hmb_current_type[i] = "mbse"
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_selection_effect[i], true)
        endif
    endmethod
    private static method mbsn takes nothing returns nothing
        local integer i = GetConvertedPlayerId(GetTriggerPlayer())
        set hmb_current_type[i] = "mbsn"
        if(GetLocalPlayer()==players[i])then
            call MultiboardDisplay(hmb_selection_natural[i], true)
        endif
    endmethod

    public static method initSet takes nothing returns nothing
        local integer i = 0
        local trigger startTrigger = null
        local trigger mbapTrigger = null
        local trigger mbmeTrigger = null
        local trigger mbsaTrigger = null
        local trigger mbseTrigger = null
        local trigger mbsnTrigger = null

        set startTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle( startTrigger, 0.5 )
        call TriggerAddAction(startTrigger, function thistype.start)

        set mbapTrigger = CreateTrigger()
        set mbmeTrigger = CreateTrigger()
        set mbsaTrigger = CreateTrigger()
        set mbseTrigger = CreateTrigger()
        set mbsnTrigger = CreateTrigger()

        set i = 1
        loop
            exitwhen i > player_max_qty
                call TriggerRegisterPlayerChatEvent( mbapTrigger, players[i], "-mbap", true )
                call TriggerAddAction(mbapTrigger, function thistype.mbap)
                call TriggerRegisterPlayerChatEvent( mbmeTrigger, players[i], "-mbme", true )
                call TriggerAddAction(mbmeTrigger, function thistype.mbme)
                call TriggerRegisterPlayerChatEvent( mbsaTrigger, players[i], "-mbsa", true )
                call TriggerAddAction(mbsaTrigger, function thistype.mbsa)
                call TriggerRegisterPlayerChatEvent( mbseTrigger, players[i], "-mbse", true )
                call TriggerAddAction(mbseTrigger, function thistype.mbse)
                call TriggerRegisterPlayerChatEvent( mbsnTrigger, players[i], "-mbsn", true )
                call TriggerAddAction(mbsnTrigger, function thistype.mbsn)
            set i = i + 1
        endloop

        call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "面板信息指令", "-mbap 查看所有玩家统计|n-mbme 查看你的个人实时状态|n-mbsa 查看三击锁定单位的基本属性|n-mbse 查看三击锁定单位的特效属性|n-mbse 查看三击锁定单位的自然属性", "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )

    endmethod

endstruct
