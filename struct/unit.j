/* 单位 */
globals
hUnit hunit = 0
endglobals

struct hUnit

    /**
     * 获取单位的最大生命
     */
    public static method getMaxLife takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MAX_LIFE)
    endmethod

    /**
     * 获取单位的当前生命
     */
    public static method getLife takes unit u returns real
        return GetUnitState(u, UNIT_STATE_LIFE)
    endmethod

    /**
     * 设置单位的当前生命
     */
    public static method setLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, val)
    endmethod

    /**
     * 增加单位的当前生命
     */
    public static method addLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, getLife(u)+val)
    endmethod

    /**
     * 减少单位的当前生命
     */
    public static method subLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, getLife(u)-val)
    endmethod

    /**
     * 获取单位的最大魔法
     */
    public static method getMaxMana takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MAX_MANA)
    endmethod

    /**
     * 获取单位的当前魔法
     */
    public static method getMana takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MANA)
    endmethod

    /**
     * 设置单位的当前魔法
     */
    public static method setMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, val)
    endmethod

    /**
     * 增加单位的当前魔法
     */
    public static method addMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, getMana(u)+val)
    endmethod

    /**
     * 减少单位的当前魔法
     */
    public static method subMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, getMana(u)-val)
    endmethod


    /**
     * 设置单位百分比生命
     */
    public static method setLifePercent takes unit u,real percent returns nothing
        call SetUnitLifePercentBJ( u, percent )
    endmethod

    /**
     * 设置单位百分比魔法
     */
    public static method setManaPercent takes unit u,real percent returns nothing
        call SetUnitManaPercentBJ( u, percent )
    endmethod

    /**
     * 设置单位的生命周期
     */
    public static method setPeriod takes unit u,real life returns nothing
        call UnitApplyTimedLifeBJ(life, 'BTLF', u)
    endmethod

    /**
     * 删除单位回调
     */
    private static method delUnitCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit targetUnit = time.getUnit( t, -1 )
        if( targetUnit != null ) then
            call RemoveUnit( targetUnit )
            set targetUnit = null
        endif
        call time.delTimer(t)
    endmethod

    /**
     * 删除单位，可延时
     */
    public static method delUnit takes unit targetUnit , real during returns nothing
        local timer t = null
        if( during <= 0 ) then
            call RemoveUnit( targetUnit )
            set targetUnit = null
        else
            set t = time.setTimeout( during , function hUnit.delUnitCall)
            call time.setUnit( t, -1 ,targetUnit )
        endif
    endmethod

    /**
     *  获取两个单位间距离，如果其中一个单位为空 返回0
     */
    public static method getDistanceBetween takes unit u1,unit u2 returns real
        local location loc1 = null
        local location loc2 = null
        local real distance = 0
        if( u1 == null or u2 == null ) then
            return 0
        endif
        set loc1 = GetUnitLoc(u1)
        set loc2 = GetUnitLoc(u2)
        set distance = DistanceBetweenPoints(loc1, loc2)
        call RemoveLocation( loc1 )
        call RemoveLocation( loc2 )
        set loc1 = null
        set loc2 = null
        return distance
    endmethod

    /**
     * 获取单位面向角度
     */
    public static method getFacing takes unit u returns real
        return GetUnitFacing(u)
    endmethod

    /**
     *  获取两个单位间面向角度，如果其中一个单位为空 返回0
     */
    public static method getFacingBetween takes unit u1,unit u2 returns real
        local location loc1 = null
        local location loc2 = null
        local real facing = 0
        if( u1 == null or u2 == null ) then
            return 0
        endif
        set loc1 = GetUnitLoc(u1)
        set loc2 = GetUnitLoc(u2)
        set facing = AngleBetweenPoints(loc1, loc2)
        call RemoveLocation( loc1 )
        call RemoveLocation( loc2 )
        set loc1 = null
        set loc2 = null
        return facing
    endmethod

    /**
     * 设置单位可飞，用于设置单位飞行高度之前
     */
    public static method setUnitFly takes unit u returns nothing
        local integer Storm = 'Arav'    //风暴之鸦
        call UnitAddAbility( u , Storm )
        call UnitRemoveAbility( u , Storm )
    endmethod

    /**
     * 创建1单位面向点
     * @return 最后创建单位
     */
    public static method createUnit takes player whichPlayer, integer unitid, location loc returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, bj_UNIT_FACING)
    endmethod

    /**
     * 创建1单位面向点
     * @return 最后创建单位
     */
    public static method createUnitLookAt takes player whichPlayer, integer unitid, location loc, location lookAt returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, AngleBetweenPoints(loc, lookAt))
    endmethod

    /**
     * 创建1单位面向角度
     * @return 最后创建单位
     */
    public static method createUnitFacing takes player whichPlayer, integer unitid, location loc, real facing returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, facing)
    endmethod

    /**
     * 创建1单位面向点移动到某点
     * @return 最后创建单位
     */
    public static method createUnitAttackToLoc takes integer unitid ,player whichPlayer, location loc, location attackLoc returns unit
        local unit u = createUnitLookAt( whichPlayer , unitid , loc , attackLoc)
        call  IssuePointOrderLoc( u, "attack", attackLoc )
        return u
    endmethod

    /**
     * 创建1单位攻击某单位
     * @return 最后创建单位
     */
    public static method createUnitAttackToUnit takes integer unitid ,player whichPlayer, location loc, unit targetUnit returns unit
        local location lookat = GetUnitLoc(targetUnit)
        local unit u = createUnitLookAt( whichPlayer , unitid , loc , lookat)
        call IssueTargetOrder( u , "attack", targetUnit )
        call RemoveLocation(lookat)
        set lookat = null
        return u
    endmethod


    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public static method createUnits takes integer qty , player whichPlayer, integer unitid, location loc returns group
        local group g = CreateGroup()
        loop
            set qty = qty - 1
            exitwhen qty < 0
                call CreateUnitAtLocSaveLast(whichPlayer, unitid, loc, bj_UNIT_FACING)
                call GroupAddUnit(g, bj_lastCreatedUnit)
        endloop
        return g
    endmethod

    /**
     * 创建单位组面向点
     * @return 最后创建单位组
     */
    public static method createUnitsLookAt takes integer qty , player whichPlayer, integer unitid, location loc, location lookAt returns group
        local group g = CreateGroup()
        loop
            set qty = qty - 1
            exitwhen qty < 0
                call CreateUnitAtLocSaveLast(whichPlayer, unitid, loc, AngleBetweenPoints(loc, lookAt))
                call GroupAddUnit(g, bj_lastCreatedUnit)
        endloop
        return g
    endmethod

    /**
     * 创建单位组攻击移动到某点
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToLoc takes  integer qty, integer unitid ,player whichPlayer, location loc, location attackLoc returns group
        local group g = createUnitsLookAt( qty , whichPlayer , unitid , loc , attackLoc )
        call GroupPointOrderLoc( g , "attack", attackLoc )
        return g
    endmethod

    /**
     * 创建单位组攻击某单位
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToUnit takes  integer qty, integer unitid ,player whichPlayer, location loc, unit targetUnit returns group
        local location lookat = GetUnitLoc(targetUnit)
        local group g = createUnitsLookAt( qty , whichPlayer , unitid , loc , lookat )
        call GroupTargetOrder( g , "attack", targetUnit )
        call RemoveLocation(lookat)
        set lookat = null
        return g
    endmethod


endstruct








