/**
 * 单位
 */

globals
hUnit hunit
hashtable hash_unit = null
integer hashkey_unit_issilent = 76100
integer hashkey_unit_isunarm = 76101
integer hashkey_unit_crackfly = 76102
integer hashkey_unit_avatar = 76103
integer hashkey_unit_attack_speed_base_space = 76104
integer hashkey_unit_attack_range = 76105
integer hashkey_unit_isOpenPunish = 76106
integer hashkey_unit_isAutoClearAttrGroup = 76107
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
     * 获取单位百分比生命
     */
    public static method getLifePercent takes unit u returns real
        return GetUnitLifePercent(u)
    endmethod

    /**
     * 获取单位百分比魔法
     */
    public static method getManaPercent takes unit u returns real
        return GetUnitManaPercent(u)
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
     * 设置单位是否启用硬直
     */
    public static method setOpenPunish takes unit u,boolean isOpen returns nothing
        if(isOpen == true)then
            call hgroup.in(u, ATTR_GROUP_PUNISH)
        elseif (isOpen == false) then
            call hgroup.out(u, ATTR_GROUP_PUNISH)
        endif
        call SaveBoolean(hash_unit,GetHandleId(u),hashkey_unit_isOpenPunish,isOpen)
    endmethod

    /**
     * 单位是否启用硬直（系统默认不启用）
     */
    public static method isOpenPunish takes unit u returns boolean
        return LoadBoolean(hash_unit,GetHandleId(u),hashkey_unit_isOpenPunish)
    endmethod

    /**
     * 设置单位是否自动清理出属性group（不清理后期会越来越卡，设置false则可以手动清理）
     */
    public static method setAutoClearAttrGroup takes unit u,boolean isAuto returns nothing
        if(isAuto == true)then
            call SaveInteger(hash_unit,GetHandleId(u),hashkey_unit_isAutoClearAttrGroup,1)
        elseif (isAuto == false) then
            call SaveInteger(hash_unit,GetHandleId(u),hashkey_unit_isAutoClearAttrGroup,-1)
        endif
    endmethod

    /**
     * 单位是否自动清理出属性group（系统默认启用）
     */
    public static method isAutoClearAttrGroup takes unit u returns boolean
        local integer i = LoadInteger(hash_unit,GetHandleId(u),hashkey_unit_isAutoClearAttrGroup)
        return i == 1
    endmethod

    /**
     * 获取单位类型的头像
     */
    public static method getAvatar takes integer uid returns string
        local string avatar = LoadStr(hash_unit,uid,hashkey_unit_avatar)
        if(StringLength(avatar)<=0)then
            set avatar = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp"
        endif
        return avatar
    endmethod

    /**
     * 设置单位类型的头像
     */
    public static method setAvatar takes integer uid,string avatar returns nothing
        call SaveStr(hash_unit,uid,hashkey_unit_avatar,avatar)
    endmethod

    /** 
     * 获取单位类型整体的攻击速度间隔(默认2.00秒/击)
     */ 
	public static method getAttackSpeedBaseSpace takes integer uid returns real
		local real value = LoadReal(hash_unit,uid,hashkey_unit_attack_speed_base_space)
        if(value<=0)then
            set value = 2.00
        endif
        return value
	endmethod
    /** 
     * 设置单位类型整体的攻击速度间隔
     */ 
	public static method setAttackSpeedBaseSpace takes integer uid , real value returns nothing
		call SaveReal(hash_unit,uid,hashkey_unit_attack_speed_base_space,value)
	endmethod

    /** 
     * 获取单位类型整体的攻击范围
     */ 
	public static method getAttackRange takes integer uid returns real
		local real value = LoadReal(hash_unit,uid,hashkey_unit_attack_range)
        if(value<=0)then
            set value = -1
        endif
        return value
	endmethod

    /** 
     * 设置单位类型整体的攻击范围，物编的攻击距离与主动范围请调节为一致，攻击距离更改设定为最大攻击距离
     * 例如需要修改的单位在物编将[主动攻击范围][攻击范围]设为9999，然后hjass里就可以动态最大修改攻击距离为 9999
     * 主动攻击范围务必与攻击距离一致，hjass里修改攻击范围时，会自适应主动攻击范围
     */ 
	public static method setAttackRange takes integer uid , real value returns nothing
		call SaveReal(hash_unit,uid,hashkey_unit_attack_range,value)
	endmethod

    /**
     * 删除单位回调
     */
    private static method delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit targetUnit = htime.getUnit( t, -1 )
        if( targetUnit != null ) then
            call RemoveUnit( targetUnit )
            set targetUnit = null
        endif
        call htime.delTimer(t)
    endmethod

    /**
     * 删除单位，可延时
     */
    public static method del takes unit targetUnit , real during returns nothing
        local timer t = null
        if( during <= 0 ) then
            call RemoveUnit( targetUnit )
            set targetUnit = null
        else
            set t = htime.setTimeout( during , function thistype.delCall)
            call htime.setUnit( t, -1 ,targetUnit )
        endif
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
     * 在某XY坐标复活英雄
     * 只有英雄能被复活
     * 只有调用此方法会触发复活事件
     */
    private static method rebornAtXYCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = htime.getUnit(t,1)
        local real x = htime.getReal(t,2)
        local real y = htime.getReal(t,3)
        call htime.delTimer(t)
        call ReviveHero( u,x,y,true )
        //@触发复活事件
        set hevtBean = hEvtBean.create()
        set hevtBean.triggerKey = "reborn"
        set hevtBean.triggerUnit = u
        call hevt.triggerEvent(hevtBean)
        call hevtBean.destroy()
    endmethod
    public static method rebornAtXY takes unit u,real x,real y,real delay returns nothing
        local timer t = null
        if(his.hero(u))then
            if(delay<1)then
                call ReviveHero( u,x,y,true )
                //@触发复活事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "reborn"
                set hevtBean.triggerUnit = u
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
            else
                set t = htime.setTimeout(delay,function thistype.rebornAtXYCall)
                call htime.setUnit(t,1,u)
                call htime.setReal(t,2,x)
                call htime.setReal(t,3,y)
            endif
        endif
    endmethod

    /**
     * 在某点复活英雄
     * 只有英雄能被复活
     * 只有调用此方法会触发复活事件
     */
    public static method rebornAtLoc takes unit u,location loc returns nothing
        if(his.hero(u))then
            call ReviveHeroLoc( u, loc, true )
            //@触发复活事件
            set hevtBean = hEvtBean.create()
            set hevtBean.triggerKey = "reborn"
            set hevtBean.triggerUnit = u
            call hevt.triggerEvent(hevtBean)
            call hevtBean.destroy()
        endif
    endmethod

    /**
     * 创建1单位面向点
     * @return 最后创建单位
     */
    public static method createUnit takes player whichPlayer, integer unitid, location loc returns unit
        return CreateUnitAtLoc(whichPlayer, unitid, loc, bj_UNIT_FACING)
    endmethod

    /**
     * 创建1单位XY
     * @return 最后创建单位
     */
    public static method createUnitXY takes player whichPlayer, integer unitid, real x,real y returns unit
        return CreateUnit(whichPlayer, unitid, x, y, bj_UNIT_FACING)
    endmethod

    /**
     * 创建1单位XY facing
     * @return 最后创建单位
     */
    public static method createUnitXYFacing takes player whichPlayer, integer unitid, real x,real y, real facing returns unit
        return CreateUnit(whichPlayer, unitid, x, y, facing)
    endmethod

    /**
     * 创建1单位hXY
     * @return 最后创建单位
     */
    public static method createUnithXY takes player whichPlayer, integer unitid, hXY xy returns unit
        return CreateUnit(whichPlayer, unitid, xy.x, xy.y, bj_UNIT_FACING)
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
    public static method createUnitAttackToLoc takes player whichPlayer, integer unitid , location loc, location attackLoc returns unit
        local unit u = createUnitLookAt( whichPlayer , unitid , loc , attackLoc)
        call  IssuePointOrderLoc( u, "attack", attackLoc )
        return u
    endmethod

    /**
     * 创建1单位攻击某单位
     * @return 最后创建单位
     */
    public static method createUnitAttackToUnit takes player whichPlayer, integer unitid, location loc, unit targetUnit returns unit
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
    public static method createUnits takes player whichPlayer, integer unitid, integer qty, location loc returns group
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
     * 创建单位组XY
     * @return 最后创建单位组
     */
    public static method createUnitsXY takes player whichPlayer, integer unitid, integer qty, real x,real y returns group
        local group g = CreateGroup()
        local unit u = null
        loop
            set qty = qty - 1
            exitwhen qty < 0
                set u = createUnitXY(whichPlayer, unitid, x, y)
                call GroupAddUnit(g, u)
        endloop
        return g
    endmethod

    /**
     * 创建单位组XY randomFacing
     * @return 最后创建单位组
     */
    public static method createUnitsXYFacing takes player whichPlayer, integer unitid, integer qty, real x,real y returns group
        local group g = CreateGroup()
        local unit u = null
        loop
            set qty = qty - 1
            exitwhen qty < 0
                set u = createUnitXYFacing(whichPlayer, unitid, x, y, GetRandomReal(0,360))
                call GroupAddUnit(g, u)
        endloop
        return g
    endmethod

    /**
     * 创建单位组面向点
     * @return 最后创建单位组
     */
    public static method createUnitsLookAt takes player whichPlayer, integer unitid,integer qty, location loc, location lookAt returns group
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
    public static method createUnitsAttackToLoc takes player whichPlayer, integer unitid,integer qty, location loc, location attackLoc returns group
        local group g = createUnitsLookAt( whichPlayer , unitid , qty, loc , attackLoc )
        call GroupPointOrderLoc( g , "attack", attackLoc )
        return g
    endmethod

    /**
     * 创建单位组攻击某单位
     * @return 最后创建单位组
     */
    public static method createUnitsAttackToUnit takes player whichPlayer, integer unitid,integer qty, location loc, unit targetUnit returns group
        local location lookat = GetUnitLoc(targetUnit)
        local group g = createUnitsLookAt( whichPlayer , unitid , qty , loc , lookat )
        call GroupTargetOrder( g , "attack", targetUnit )
        call RemoveLocation(lookat)
        set lookat = null
        return g
    endmethod


endstruct








