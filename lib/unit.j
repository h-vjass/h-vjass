
library hUnit needs hSys

    /**
     * 获取单位的最大生命
     */
    public function getMaxLife takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MAX_LIFE)
    endfunction

    /**
     * 获取单位的当前生命
     */
    public function getLife takes unit u returns real
        return GetUnitState(u, UNIT_STATE_LIFE)
    endfunction

    /**
     * 设置单位的当前生命
     */
    public function setLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, val)
    endfunction

    /**
     * 增加单位的当前生命
     */
    public function addLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, getLife(u)+val)
    endfunction

    /**
     * 减少单位的当前生命
     */
    public function subLife takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, getLife(u)-val)
    endfunction

    /**
     * 获取单位的最大魔法
     */
    public function getMaxMana takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MAX_MANA)
    endfunction

    /**
     * 获取单位的当前魔法
     */
    public function getMana takes unit u returns real
        return GetUnitState(u, UNIT_STATE_MANA)
    endfunction

    /**
     * 设置单位的当前魔法
     */
    public function setMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, val)
    endfunction

    /**
     * 增加单位的当前魔法
     */
    public function addMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, getMana(u)+val)
    endfunction

    /**
     * 减少单位的当前魔法
     */
    public function subMana takes unit u,real val returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, getMana(u)-val)
    endfunction


    /**
     * 设置单位百分比生命
     */
    public function setLifePercent takes unit u,real percent returns nothing
        call SetUnitLifePercentBJ( u, percent )
    endfunction

    /**
     * 设置单位百分比魔法
     */
    public function setManaPercent takes unit u,real percent returns nothing
        call SetUnitManaPercentBJ( u, percent )
    endfunction

    /**
     * 设置单位的生命周期
     */
    public function setPeriod takes unit u,real life returns nothing
        call UnitApplyTimedLifeBJ(life, 'BTLF', u)
    endfunction

    /**
     * 删除单位回调
     */
    public function delUnitCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit targetUnit = time.getUnit( t, -1 )
        if( targetUnit != null ) then
            call RemoveUnit( targetUnit )
        endif
        call time.delTimer(t)
    endfunction

    /**
     * 删除单位，可延时
     */
    public function delUnit takes unit targetUnit , real during returns nothing
        local timer t = null
        if( during <= 0 ) then
            call RemoveUnit( targetUnit )
        else
            set t = time.setTimeout( during , function delUnitCall)
            call time.setUnit( t, -1 ,targetUnit )
        endif
    endfunction

    /**
     *  获取两个单位间距离，如果其中一个单位为空 返回0
     */
    public function getDistanceBetween takes unit u1,unit u2 returns real
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
    endfunction

    /**
     * 获取单位面向角度
     */
    public function getFacing takes unit u returns real
        return GetUnitFacing(u)
    endfunction

    /**
     *  获取两个单位间面向角度，如果其中一个单位为空 返回0
     */
    public function getFacingBetween takes unit u1,unit u2 returns real
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
    endfunction

    /**
     * 设置单位可飞，用于设置单位飞行高度之前
     */
    public function setUnitFly takes unit u returns nothing
        local integer Storm = 'Arav'    //风暴之鸦
        call UnitAddAbility( u , Storm )
        call UnitRemoveAbility( u , Storm )
    endfunction

    /**
     * 创建1单位面向点
     * @return 最后创建单位
     */
    public function createUnit takes player whichPlayer, integer unitid, location loc returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, bj_UNIT_FACING)
    endfunction

    /**
     * 创建1单位面向点
     * @return 最后创建单位
     */
    public function createUnitLookAt takes player whichPlayer, integer unitid, location loc, location lookAt returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, AngleBetweenPoints(loc, lookAt))
    endfunction

    /**
     * 创建1单位面向角度
     * @return 最后创建单位
     */
    public function createUnitFacing takes player whichPlayer, integer unitid, location loc, real facing returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, facing)
    endfunction

    /**
     * 创建1单位面向点移动到某点
     * @return 最后创建单位
     */
    public function createUnitAttackToLoc takes integer unitid ,player whichPlayer, location loc, location attackLoc returns unit
        local unit u = createUnitLookAt( whichPlayer , unitid , loc , attackLoc)
        call  IssuePointOrderLoc( u, "attack", attackLoc )
        return u
    endfunction

    /**
     * 创建1单位攻击某单位
     * @return 最后创建单位
     */
    public function createUnitAttackToUnit takes integer unitid ,player whichPlayer, location loc, unit targetUnit returns unit
        local location lookat = GetUnitLoc(targetUnit)
        local unit u = createUnitLookAt( whichPlayer , unitid , loc , lookat)
        call IssueTargetOrder( u , "attack", targetUnit )
        call RemoveLocation(lookat)
        set lookat = null
        return u
    endfunction


    /**
     * 创建单位组
     * @return 最后创建单位组
     */
    public function createUnits takes integer qty , player whichPlayer, integer unitid, location loc returns group
        local group g = CreateGroup()
        loop
            set qty = qty - 1
            exitwhen qty < 0
                call CreateUnitAtLocSaveLast(whichPlayer, unitid, loc, bj_UNIT_FACING)
                call GroupAddUnit(g, bj_lastCreatedUnit)
        endloop
        return g
    endfunction

    /**
     * 创建单位组面向点
     * @return 最后创建单位组
     */
    public function createUnitsLookAt takes integer qty , player whichPlayer, integer unitid, location loc, location lookAt returns group
        local group g = CreateGroup()
        loop
            set qty = qty - 1
            exitwhen qty < 0
                call CreateUnitAtLocSaveLast(whichPlayer, unitid, loc, AngleBetweenPoints(loc, lookAt))
                call GroupAddUnit(g, bj_lastCreatedUnit)
        endloop
        return g
    endfunction

    /**
     * 创建单位组攻击移动到某点
     * @return 最后创建单位组
     */
    public function createUnitsAttackToLoc takes  integer qty, integer unitid ,player whichPlayer, location loc, location attackLoc returns group
        local group g = createUnitsLookAt( qty , whichPlayer , unitid , loc , attackLoc )
        call GroupPointOrderLoc( g , "attack", attackLoc )
        return g
    endfunction

    /**
     * 创建单位组攻击某单位
     * @return 最后创建单位组
     */
    public function createUnitsAttackToUnit takes  integer qty, integer unitid ,player whichPlayer, location loc, unit targetUnit returns group
        local location lookat = GetUnitLoc(targetUnit)
        local group g = createUnitsLookAt( qty , whichPlayer , unitid , loc , lookat )
        call GroupTargetOrder( g , "attack", targetUnit )
        call RemoveLocation(lookat)
        set lookat = null
        return g
    endfunction


endlibrary








