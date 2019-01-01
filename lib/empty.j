/**
 * 敌人模块
 */
globals
hEmpty hempty
endglobals

struct hEmpty

    private static integer emptyPlayerQty = 0
    private static player array emptyPlayer
    private static group array emptyGroup
    private static string emptyName = "敌人"

    // 设置敌人的名称
    public static method setEmptyName takes string name returns nothing
        set emptyName = name
    endmethod

    // 获取敌人的名称
    public static method getEmptyName takes nothing returns string
        return emptyName
    endmethod

    // 将某个玩家位置设定为敌人，同时将他名字设定为全局的emptyName，颜色调节为黑色ConvertPlayerColor(12)
    public static method setEmptyPlayer takes player whichPlayer returns nothing
        set emptyPlayerQty = emptyPlayerQty+1
        set emptyPlayer[emptyPlayerQty] = whichPlayer
        set emptyGroup[emptyPlayerQty] = CreateGroup()
        call SetPlayerName(whichPlayer,emptyName)
        call SetPlayerColor(whichPlayer,ConvertPlayerColor(12) )
    endmethod

    // 获取一个创建单位最少的敌人玩家
    public static method getEmptyPlayer takes nothing returns player
        local integer i = 0
        local integer temp = 99999
        local integer count = 0
        local integer whichi = 1
        set i = emptyPlayerQty
        loop
            exitwhen i<=0
                set count = hgroup.count(emptyGroup[i])
                if(temp > count)then
                    set whichi = i
                    set temp = count
                endif
            set i = i-1
        endloop
        return emptyPlayer[whichi]
    endmethod

    /**
     * 创建1敌军单位面向点
     * @return 最后创建单位
     */
    public static method createUnit takes integer unitid, location loc returns unit
        return hunit.createUnit(getEmptyPlayer(), unitid, loc)
    endmethod

    /**
     * 创建1敌军单位XY
     * @return 最后创建单位
     */
    public static method createUnitXY takes integer unitid, real x,real y returns unit
        return hunit.createUnitXY(getEmptyPlayer(), unitid, x, y)
    endmethod

    /**
     * 创建1敌军单位hXY
     * @return 最后创建单位
     */
    public static method createUnithXY takes integer unitid, hXY xy returns unit
        return hunit.createUnithXY(getEmptyPlayer(), unitid, xy)
    endmethod

    /**
     * 创建1敌军单位面向点
     * @return 最后创建单位
     */
    public static method createUnitLookAt takes integer unitid, location loc, location lookAt returns unit
        return hunit.createUnitLookAt(getEmptyPlayer(), unitid, loc, lookAt)
    endmethod

    /**
     * 创建1敌军单位XY
     * @return 最后创建单位
     */
    public static method createUnitXYFacing takes integer unitid, real x,real y, real facing returns unit
        return hunit.createUnitXYFacing(getEmptyPlayer(), unitid, x, y , facing)
    endmethod

    /**
     * 创建1敌军单位面向角度
     * @return 最后创建单位
     */
    public static method createUnitFacing takes integer unitid, location loc, real facing returns unit
        return hunit.createUnitFacing(getEmptyPlayer(), unitid, loc, facing)
    endmethod

    /**
     * 创建1敌军单位面向点移动到某点
     * @return 最后创建单位
     */
    public static method createUnitAttackToLoc takes integer unitid, location loc, location attackLoc returns unit
        return hunit.createUnitAttackToLoc(getEmptyPlayer(), unitid, loc, attackLoc)
    endmethod

    /**
     * 创建1单位攻击某单位
     * @return 最后创建单位
     */
    public static method createUnitAttackToUnit takes integer unitid, location loc, unit targetUnit returns unit
        return hunit.createUnitAttackToUnit(getEmptyPlayer(), unitid, loc, targetUnit)
    endmethod


    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public static method createUnits takes integer unitid, integer qty, location loc returns group
        return hunit.createUnits(getEmptyPlayer(), unitid, qty, loc)
    endmethod
    
    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public static method createUnitsXYFacing takes integer unitid, integer qty, real x,real y returns group
        return hunit.createUnitsXYFacing(getEmptyPlayer(), unitid, qty, x, y)
    endmethod

    /**
     * 创建单位组面向点
     * @return 最后创建单位组
     */
    public static method createUnitsLookAt takes integer unitid,integer qty, location loc, location lookAt returns group
        return hunit.createUnitsLookAt(getEmptyPlayer(), unitid, qty, loc, lookAt)
    endmethod

    /**
     * 创建单位组攻击移动到某点
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToLoc takes integer unitid,integer qty, location loc, location attackLoc returns group
        return hunit.createUnitsAttackToLoc(getEmptyPlayer(), unitid, qty, loc, attackLoc)
    endmethod

    /**
     * 创建单位组攻击某单位
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToUnit takes integer unitid,integer qty, location loc, unit targetUnit returns group
        return hunit.createUnitsAttackToUnit(getEmptyPlayer(), unitid, qty, loc, targetUnit)
    endmethod

endstruct
