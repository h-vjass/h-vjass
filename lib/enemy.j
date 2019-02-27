/**
 * 敌人模块
 */
globals
hEnemy henemy
endglobals

struct hEnemy

    private static integer enemyPlayerQty = 0
    private static player array enemyPlayer
    private static integer array enemyInc
    private static string enemyName = "敌人"
    private static boolean isShareView = false // 是否与玩家共享视野

    // 设置敌人的名称
    public static method setEnemyName takes string name returns nothing
        set enemyName = name
    endmethod

    // 获取敌人的名称
    public static method getEnemyName takes nothing returns string
        return enemyName
    endmethod

    // 设置是否与玩家共享视野
    public static method setIsShareView takes boolean b returns nothing
        set isShareView = b
    endmethod

    // 将某个玩家位置设定为敌人，同时将他名字设定为全局的enemyName，颜色调节为黑色ConvertPlayerColor(12)
    public static method setEnemyPlayer takes player whichPlayer returns nothing
        set enemyPlayerQty = enemyPlayerQty+1
        set enemyPlayer[enemyPlayerQty] = whichPlayer
        set enemyInc[enemyPlayerQty] = 0
        call SetPlayerName(whichPlayer,enemyName)
        //call SetPlayerColor(whichPlayer,ConvertPlayerColor(12) )
        if(isShareView==true)then
            call SetPlayerAlliance(whichPlayer, players[1], ALLIANCE_SHARED_VISION, true)
        endif
    endmethod

    // 获取一个创建单位最少的敌人玩家
    public static method getEnemyPlayer takes nothing returns player
        local integer i = 0
        local integer temp = 999999
        local integer count = 0
        local integer whichi = 1
        set i = enemyPlayerQty
        loop
            exitwhen i<=0
                set count = enemyInc[i]
                if(temp > count)then
                    set whichi = i
                    set temp = count
                endif
            set i = i-1
        endloop
        set enemyInc[whichi] = enemyInc[whichi]+1
        if(enemyInc[whichi]>=999999)then
            set i = enemyPlayerQty
            loop
                exitwhen i<=0
                    set enemyInc[i] = 0
                set i = i-1
            endloop
        endif
        return enemyPlayer[whichi]
    endmethod

    /**
     * 创建1敌军单位面向点
     * @return 最后创建单位
     */
    public static method createUnit takes integer unitid, location loc returns unit
        return hunit.createUnit(getEnemyPlayer(), unitid, loc)
    endmethod

    /**
     * 创建1敌军单位XY
     * @return 最后创建单位
     */
    public static method createUnitXY takes integer unitid, real x,real y returns unit
        return hunit.createUnitXY(getEnemyPlayer(), unitid, x, y)
    endmethod

    /**
     * 创建1敌军单位hXY
     * @return 最后创建单位
     */
    public static method createUnithXY takes integer unitid, hXY xy returns unit
        return hunit.createUnithXY(getEnemyPlayer(), unitid, xy)
    endmethod

    /**
     * 创建1敌军单位面向点
     * @return 最后创建单位
     */
    public static method createUnitLookAt takes integer unitid, location loc, location lookAt returns unit
        return hunit.createUnitLookAt(getEnemyPlayer(), unitid, loc, lookAt)
    endmethod

    /**
     * 创建1敌军单位XY
     * @return 最后创建单位
     */
    public static method createUnitXYFacing takes integer unitid, real x,real y, real facing returns unit
        return hunit.createUnitXYFacing(getEnemyPlayer(), unitid, x, y , facing)
    endmethod

    /**
     * 创建1敌军单位面向角度
     * @return 最后创建单位
     */
    public static method createUnitFacing takes integer unitid, location loc, real facing returns unit
        return hunit.createUnitFacing(getEnemyPlayer(), unitid, loc, facing)
    endmethod

    /**
     * 创建1敌军单位面向点移动到某点
     * @return 最后创建单位
     */
    public static method createUnitAttackToLoc takes integer unitid, location loc, location attackLoc returns unit
        return hunit.createUnitAttackToLoc(getEnemyPlayer(), unitid, loc, attackLoc)
    endmethod

    /**
     * 创建1单位攻击某单位
     * @return 最后创建单位
     */
    public static method createUnitAttackToUnit takes integer unitid, location loc, unit targetUnit returns unit
        return hunit.createUnitAttackToUnit(getEnemyPlayer(), unitid, loc, targetUnit)
    endmethod


    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public static method createUnits takes integer unitid, integer qty, location loc returns group
        return hunit.createUnits(getEnemyPlayer(), unitid, qty, loc)
    endmethod
    
    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public static method createUnitsXYFacing takes integer unitid, integer qty, real x,real y returns group
        return hunit.createUnitsXYFacing(getEnemyPlayer(), unitid, qty, x, y)
    endmethod

    /**
     * 创建单位组面向点
     * @return 最后创建单位组
     */
    public static method createUnitsLookAt takes integer unitid,integer qty, location loc, location lookAt returns group
        return hunit.createUnitsLookAt(getEnemyPlayer(), unitid, qty, loc, lookAt)
    endmethod

    /**
     * 创建单位组攻击移动到某点
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToLoc takes integer unitid,integer qty, location loc, location attackLoc returns group
        return hunit.createUnitsAttackToLoc(getEnemyPlayer(), unitid, qty, loc, attackLoc)
    endmethod

    /**
     * 创建单位组攻击某单位
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToUnit takes integer unitid,integer qty, location loc, unit targetUnit returns group
        return hunit.createUnitsAttackToUnit(getEnemyPlayer(), unitid, qty, loc, targetUnit)
    endmethod

endstruct
