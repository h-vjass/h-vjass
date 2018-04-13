/**
 * 技能
 */
globals

    hSkill hskill
	hashtable hash_skill = null

endglobals

struct hSkill

    static method create takes nothing returns hSkill
        local hSkill x = 0
        set x = hSkill.allocate()
        return x
    endmethod

    /**
	 * 闪电链循环
     */
    private static method lightningChainLoop takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit prevUnit = htime.getUnit(t,1)
        local unit nextUnit = null
        local integer qty = htime.getInteger(t,2)
        local real reduce = htime.getReal(t,3)
        local real damage = htime.getReal(t,4)
        local string huntKind = htime.getString(t,5)
        local string huntType = htime.getString(t,6)
        local string codename = htime.getString(t,97)
        local string huntEff = htime.getString(t,98)
        local unit fromUnit = htime.getUnit(t,99)
        local group repeatGroup = htime.getGroup(t,100)
        local group g = null
        local unit u = null
        local hAttrHuntBean bean
        local hFilter filter
        set filter = hFilter.create()
        call filter.setUnit(fromUnit)
        call filter.isEnemy(true)
        call filter.isBuilding(false)
        call filter.isAlive(true)
        set g = hgroup.createByUnit(prevUnit,400,function hFilter.get)
        call filter.destroy()
        if(hgroup.count(g)>0)then
            loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                if(u!=prevUnit)then
                    if(repeatGroup==null or hgroup.isin(u,repeatGroup)==false)then
                        set nextUnit = u
                        call GroupAddUnit(repeatGroup,u)
                        call DoNothing() YDNL exitwhen true//(  )
                    endif
                endif
            endloop
        endif
        call GroupClear( g )
        call DestroyGroup( g )
        set g = null
        set u = null
        if(nextUnit!=null)then
            call htime.setUnit(t,1,nextUnit)
            call hlightning.unit2unit(codename,prevUnit,nextUnit,0.2*qty)
            set bean = hAttrHuntBean.create()
            set bean.fromUnit = fromUnit
            set bean.toUnit = prevUnit
            set bean.damage = damage
            set bean.huntEff = huntEff
            set bean.huntKind = huntKind
            set bean.huntType = huntType
            call hattrHunt.huntUnit(bean)
            call bean.destroy()
        else
            call htime.delTimer(t)
            return
        endif
        set qty = qty-1
        set damage = damage*(1.00+reduce*0.01)
        if(qty<=0 or damage<=2)then
            call htime.delTimer(t)
            return
        endif
        call htime.setInteger(t,2,qty)
        call htime.setReal(t,4,damage)
    endmethod
    /**
	 * 闪电链
	 * codename 闪电效果类型 详情查看 hLightning
	 * qty 传递单位数
	 * reduce 递减率
	 * eff 击打特效
	 * isRepeat 是否允许同一个单位重复打击（临近2次不会同一个）
	 * bean 伤害bean
	 */
	public static method lightningChain takes string codename,integer qty,real reduce,boolean isRepeat,hAttrHuntBean bean returns nothing
        local timer t = null
        set qty = qty-1
        if(qty<0)then
            set qty = 0
        endif
        call hlightning.unit2unit(codename,bean.fromUnit,bean.toUnit,0.2*qty)
        call hattrHunt.huntUnit(bean)
        if(qty>0)then
            set t = htime.setInterval(0.35,function thistype.lightningChainLoop)
            call htime.setUnit(t,1,bean.toUnit)
            call htime.setInteger(t,2,qty)
            call htime.setReal(t,3,reduce)
            call htime.setReal(t,4,bean.damage)
            call htime.setString(t,5,bean.huntKind)
            call htime.setString(t,6,bean.huntType)
            call htime.setString(t,97,codename)
            call htime.setString(t,98,bean.huntEff)
            call htime.setUnit(t,99,bean.fromUnit)
            if(isRepeat == false)then
                call htime.setGroup(t,100,CreateGroup())
            else
                call htime.setGroup(t,100,null)
            endif
        endif
	endmethod

	/**
	 * 变身回调
	 */
    private static method shapeshiftCall takes nothing returns nothing
    	local timer t = GetExpiredTimer()
    	local unit u = htime.getUnit( t , 1 )
    	local integer modelFrom = htime.getInteger( t ,2 )
    	local string eff = htime.getString( t , 3 )
    	local integer index = GetConvertedPlayerId(GetOwningPlayer(u))
    	local location loc = null
		call heffect.toUnitLoc( eff , u , 1.5 )
    	call UnitAddAbility( u , modelFrom )
		call UnitRemoveAbility( u , modelFrom )
        call hAttr.resetSkill(u)
    endmethod
	/**
	 * 变身[参考 hJass变身技能模板]
     * modelFrom 技能模板 参考 'A00D'
     * modelTo 技能模板 参考 'A00E'
	 */
    public static method shapeshift takes unit u, real during, integer modelFrom,integer modelTo,string eff,hAttrBean bean returns nothing
    	local timer t = null
    	local integer index = GetConvertedPlayerId(GetOwningPlayer(u))
		call heffect.toUnitLoc( eff , u , 1.5 )
    	call UnitAddAbility( u , modelTo )
		call UnitRemoveAbility( u , modelTo )
        call hAttr.resetSkill(u)
		set t = htime.setTimeout( during , function thistype.shapeshiftCall )
	    call htime.setUnit( t , 1 , u )
	    call htime.setInteger( t , 2 , modelFrom )
	    call htime.setString( t , 3 , eff )
        //根据bean影响属性
        call hAttrUnit.modifyAttrByBean(u,bean,during)
    endmethod

    /**
	 * 击飞回调
	 */
    private static method crackFlyCall takes nothing returns nothing
    	local timer t = GetExpiredTimer()
        local real cost = htime.getReal( t , 0 )
    	local unit toUnit = htime.getUnit( t , 1 )
	    local unit fromUnit = htime.getUnit( t , 2 )
	    local real distance = htime.getReal( t , 3 )
	    local real high = htime.getReal( t , 4 )
	    local real damage = htime.getReal( t , 5 )
        local string huntKind = htime.getString(t, 10)
        local string huntType = htime.getString(t, 11)
        local string huntEff = htime.getString(t, 12)
        local real during = htime.getReal( t , 13 )
        local real originHigh = htime.getReal( t , 14 )
        local real originFacing = htime.getReal( t , 15 )
        local real originDeg = htime.getReal( t , 16 )
        local real xy = 0
        local real z = 0
        local real timerSetTime = htime.getSetTime(t)
        local hAttrHuntBean bean
        if(cost>during)then
            call htime.delTimer(t)
            set bean = hAttrHuntBean.create()
            set bean.fromUnit = fromUnit
            set bean.toUnit = toUnit
            set bean.damage = damage
            set bean.huntEff = huntEff
            set bean.huntKind = huntKind
            set bean.huntType = huntType
            call hattrHunt.huntUnit(bean)
            call bean.destroy()
            call SetUnitFlyHeight( toUnit , originHigh , 10000 )
            call SetUnitPathing( toUnit, true )
            call SaveBoolean(hash_skill,GetHandleId(toUnit),7772,false)
            if( his.water(toUnit) == true ) then                //如果是水面，创建水花
                call heffect.toUnitLoc("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl",toUnit,0)
            else                                                //如果是地面，创建沙尘
                call heffect.toUnitLoc("Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl",toUnit,0)
            endif
            return
        endif
        call htime.setReal( t , 0 , cost+timerSetTime )
        if(cost<during*0.35)then
            set xy = distance/(during*0.5/timerSetTime)
            set z = high/(during*0.35/timerSetTime)
            if(xy>0)then
                set hxy.x = GetUnitX(toUnit)
                set hxy.y = GetUnitY(toUnit)
                set hxy = hlogic.polarProjection(hxy, xy, originDeg)
                call SetUnitFacing( toUnit, originFacing )
                call SetUnitPosition( toUnit, hxy.x, hxy.y )
            endif
            if(z>0)then
                call SetUnitFlyHeight( toUnit , GetUnitFlyHeight(toUnit)+z, z/timerSetTime )
            endif
        else
            set xy = distance/(during*0.5/timerSetTime)
            set z = high/(during*0.65/timerSetTime)
            if(xy>0)then
                set hxy.x = GetUnitX(toUnit)
                set hxy.y = GetUnitY(toUnit)
                set hxy = hlogic.polarProjection(hxy, xy, originDeg)
                call SetUnitFacing( toUnit, originFacing )
                call SetUnitPosition( toUnit, hxy.x, hxy.y )
            endif
            if(z>0)then
                call SetUnitFlyHeight( toUnit , GetUnitFlyHeight(toUnit)-z, z/timerSetTime )
            endif
        endif
    endmethod
    /**
	 * 击飞
     * distance 击退距离
     * high 击飞高度
	 */
    public static method crackFly takes real distance,real high,real during,hAttrHuntBean bean returns nothing
        local timer t = null
        if(bean.fromUnit == null or bean.toUnit == null)then
            return
        endif
        if(LoadBoolean(hash_skill,GetHandleId(bean.toUnit),7772)==true)then//不二次击飞
            return
        endif
        if(during < 0.5)then
            set during = 0.5
        endif
        //镜头放大模式下，距离缩小一半
		if(hcamera.model=="zoomin")then
			set distance = distance * 0.5
			set high = high * 0.5
		endif
        call hability.unarm(bean.toUnit,during)
        call hability.silent(bean.toUnit,during)
        call hattr.subMove(bean.toUnit,1044,during)
        call SaveBoolean(hash_skill,GetHandleId(bean.toUnit),7772,true)
        call hunit.setUnitFly(bean.toUnit)
        call SetUnitPathing( bean.toUnit, false )
		set t = htime.setInterval( 0.05 , function thistype.crackFlyCall )
	    call htime.setReal( t , 0 , 0.0 )
	    call htime.setUnit( t , 1 , bean.toUnit )
	    call htime.setUnit( t , 2 , bean.fromUnit )
	    call htime.setReal( t , 3 , distance )
	    call htime.setReal( t , 4 , high )
	    call htime.setReal( t , 5 , bean.damage )
        call htime.setString(t, 10,bean.huntKind)
        call htime.setString(t, 11,bean.huntType)
        call htime.setString(t, 12,bean.huntEff)
        call htime.setReal(t, 13,during)
        call htime.setReal(t, 14,GetUnitFlyHeight(bean.toUnit))
        call htime.setReal(t, 15,hunit.getFacing(bean.toUnit))
        call htime.setReal(t, 16,hunit.getFacingBetween(bean.fromUnit,bean.toUnit))
    endmethod

    /*
    //撞退Call
    private method crashCall takes nothing returns nothing
        local timer t =GetExpiredTimer()
        local unit u = htime.getUnit( t , Key_Skill_Unit )
        local real speed = htime.getReal( t , Key_Skill_Unit )
        local real deg = htime.getReal( t , Key_Skill_DEG )
        local real facing = htime.getReal( t , Key_Skill_Facing )
        local real during = htime.getReal( t , Key_Skill_During )
        local real duringInc = htime.getReal( t , Key_Skill_DuringInc )
        local location sourceLoc = GetUnitLoc( u )
        local location targetLoc = PolarProjectionBJ(sourceLoc, speed, deg)
        call SetUnitPositionLoc( u , targetLoc )
        call SetUnitFacing( u , facing )
        if( funcs_isWater(targetLoc) == true ) then
            //如果是水面，创建水花
            call funcs_effectLoc(Effect_CrushingWaveDamage,targetLoc)
        else
            //如果是地面，创建沙尘
            call funcs_effectLoc(Effect_ImpaleTargetDust,targetLoc)
        endif
        call RemoveLocation(targetLoc)
        call RemoveLocation(sourceLoc)
        //结束
        if( IsUnitDeadBJ(u) == true)then
            call SetUnitTimeScalePercent( u, 100 )
            call funcs_delTimer( t ,null )
        elseif( duringInc >= during ) then
            call SetUnitTimeScalePercent( u, 100 )
            call ResetUnitAnimation(  u ) //恢复动画
            call funcs_delTimer( t ,null )
        endif
        call funcs_setTimerParams_Real( t , Key_Skill_DuringInc , duringInc + 1 )
    endmethod
    //撞退 - 单体
    public method crashOne takes unit source, unit targetUnit ,real speed returns nothing
        local location triggerLoc = GetUnitLoc(source)
        local location loc = null
        local real deg = 0.00
        local real facing = 0.00
        local timer t = null
        local boolean canCrash = true
        //检测是否建筑
        if( IsUnitType( targetUnit , UNIT_TYPE_STRUCTURE) == true ) then
            set canCrash = FALSE
        endif
        //检测是否敌军
        if( IsUnitEnemy( targetUnit , GetOwningPlayer(source))  == FALSE ) then
            set canCrash = FALSE
        endif
        if(canCrash == TRUE) then
            set loc = GetUnitLoc(targetUnit)
            call SetUnitTimeScalePercent( targetUnit, 150 )
            //call SetUnitAnimation( targetUnit , "death" )
            set deg = AngleBetweenPoints(triggerLoc, loc)
            set facing = AngleBetweenPoints(loc, triggerLoc)
            set t = funcs_setInterval( 0.02 , function thistype.crashCall)
            call funcs_setTimerParams_Unit( t , Key_Skill_Unit , targetUnit )
            call funcs_setTimerParams_Real( t , Key_Skill_Unit , speed )
            call funcs_setTimerParams_Real( t , Key_Skill_DEG , deg )
            call funcs_setTimerParams_Real( t , Key_Skill_Facing , facing )
            call funcs_setTimerParams_Real( t , Key_Skill_During , (250.00/speed) )
            call funcs_setTimerParams_Real( t , Key_Skill_DuringInc , 0 )
            call RemoveLocation(loc)
        endif
        call RemoveLocation(triggerLoc)
    endmethod
    //撞退
    public method crash takes unit source, real range,real speed, group remove_group returns nothing
        local location triggerLoc = GetUnitLoc(source)
        local location loc = null
        local group g = funcs_getGroupByLoc( triggerLoc , range , function thistype.filter_live_disbuild )
        local unit u = null
        local real deg = 0.00
        local real facing = 0.00
        local timer t = null
        local boolean canCrash = true
        loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                //must do
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                //
                set canCrash = TRUE
                if(remove_group != null) then
                    if( IsUnitInGroup(u, remove_group) == TRUE ) then
                        set canCrash = FALSE
                    else
                        call GroupAddUnit( remove_group , u )
                    endif
                endif
                //检测是否敌军
                if( IsUnitEnemy( u , GetOwningPlayer(source))  == FALSE ) then
                    set canCrash = FALSE
                endif

                if(canCrash == TRUE) then
                    set loc = GetUnitLoc(u)
                    call SetUnitTimeScalePercent( u, 150 )
                    //call SetUnitAnimation( u , "death" )
                    set deg = AngleBetweenPoints(triggerLoc, loc)
                    set facing = AngleBetweenPoints(loc, triggerLoc)
                    set t = funcs_setInterval( 0.02 , method crashCall)
                    call funcs_setTimerParams_Unit( t , Key_Skill_Unit , u )
                    call funcs_setTimerParams_Real( t , Key_Skill_Unit , speed )
                    call funcs_setTimerParams_Real( t , Key_Skill_DEG , deg )
                    call funcs_setTimerParams_Real( t , Key_Skill_Facing , facing )
                    call funcs_setTimerParams_Real( t , Key_Skill_During , (250.00/speed) )
                    call funcs_setTimerParams_Real( t , Key_Skill_DuringInc , 0 )
                    call RemoveLocation(loc)
                endif
        endloop
        call GroupClear( g )
        call DestroyGroup( g )
        call RemoveLocation(triggerLoc)
    endmethod

    //撞飞Call
    private method flyCall takes nothing returns nothing
        local timer t =GetExpiredTimer()
        local unit u = htime.getUnit( t , Key_Skill_Unit )
        local string FEffect = htime.getString( t , Key_Skill_FEffect )
        local real firstHeight = htime.getReal( t , Key_Skill_Distance )
        local real speed = htime.getReal( t , Key_Skill_Speed )
        local location loc = GetUnitLoc( u )
        call funcs_delTimer( t ,null )
        if( FEffect !=null ) then
            call funcs_effectLoc(FEffect,loc)
        endif
        call RemoveLocation(loc)
        call PauseUnitBJ( false, u )
        call SetUnitFlyHeight( u , firstHeight, speed * 2 )
    endmethod
    //撞飞
    public method fly takes unit source, real range,real speed, real height,group remove_group returns nothing
        local location triggerLoc = GetUnitLoc(source)
        local location loc = null
        local group g = funcs_getGroupByLoc( triggerLoc , range , method filter_live_disbuild )
        local unit u = null
        local timer t = null
        local boolean canFly
        local string FEffect = null
        local real firstHeight = 0.00
        local real flySpeed = height * 0.75
        loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                //must do
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                //
                set canFly = TRUE
                if(remove_group != null) then
                    if( IsUnitInGroup(u, remove_group) == TRUE ) then
                        set canFly = FALSE
                    else
                        call GroupAddUnit( remove_group , u )
                    endif
                endif
                //检测是否敌军
                if( IsUnitEnemy( u , GetOwningPlayer(source))  == FALSE ) then
                    set canFly = FALSE
                endif

                if(canFly == TRUE) then
                    set loc = GetUnitLoc(u)
                    set firstHeight = GetLocationZ(loc)
                    call PauseUnitBJ( true, u )
                    call SetUnitTimeScalePercent( u, 150 )
                    call SetUnitAnimation( u , "death" )
                    call funcs_setUnitFly( u )
                    call SetUnitFlyHeight( u , height, flySpeed )
                    if( funcs_isWater(loc) == true ) then
                        //如果是水面，创建水爆
                        set FEffect = Effect_CrushingWaveDamage
                        call funcs_effectLoc(Effect_CrushingWaveBrust,loc)
                    else
                        //如果是地面，创建扩张特效
                        set FEffect = Effect_ImpaleTargetDust
                        call funcs_effectLoc(Effect_CrushingWhiteRing,loc)
                    endif
                    set t = funcs_setTimeout( (height/flySpeed) , method flyCall)
                    call funcs_setTimerParams_Unit( t , Key_Skill_Unit , u )
                    call funcs_setTimerParams_String( t , Key_Skill_FEffect , FEffect )
                    call funcs_setTimerParams_Real( t , Key_Skill_Speed , flySpeed)
                    call funcs_setTimerParams_Real( t , Key_Skill_Distance , firstHeight)
                    call RemoveLocation(loc)
                endif
        endloop
        call GroupClear( g )
        call DestroyGroup( g )
        call RemoveLocation(triggerLoc)
    endmethod

    //剃回调
    public method leapCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = htime.getReal(t,Key_Skill_Speed)
        local real range = htime.getReal(t,Key_Skill_Range)
        local location targetPoint = htime.getLoc(t,Key_Skill_TargetPoint)
        local string MEffect = htime.getString(t,Key_Skill_MEffect)
        local unit mover = htime.getUnit(t,Key_Skill_Unit)
        local group remove_group = htime.getGroup(t,Key_Skill_Group)
        local real duringInc = htime.getReal(t,Key_Skill_DuringInc)

        local unit fromUnit = htime.getUnit(t,Key_Skill_FromUnit)
        local string heffect = htime.getString(t,Key_Skill_HEffect)
        local real damage = htime.getReal(t,Key_Skill_Damage)
        local string hkind = htime.getString(t,Key_Skill_Hkind)
        local string htype = htime.getString(t,Key_Skill_Htype)
        local boolean isBreak = htime.getBoolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = htime.getBoolean(t,Key_Skill_IsNoAvoid)
        local string special = htime.getString(t,Key_Skill_Special)
        local real specialVal = htime.getReal(t,Key_Skill_SpecialVal)
        local real specialDuring = htime.getReal(t,Key_Skill_SpecialDuring)

        local real distance = 0
        local location point = null
        local location point2 = null
        local group tmp_group = null
        local unit u = null

        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set point =  GetUnitLoc(mover)
        set point2 = PolarProjectionBJ(point, speed, AngleBetweenPoints(point, targetPoint))
        call SetUnitPositionLoc( mover, point2 )
        call RemoveLocation(point2)
        call RemoveLocation(point)

        set point =  GetUnitLoc(mover)
        if(MEffect != null)then
            call funcs_effectLoc(MEffect,point)
        endif
        if(damage > 0) then
            set tmp_group = funcs_getGroupByLoc(point,range,method filter_live_disbuild)
            call attributeHunt_huntGroup(tmp_group,remove_group,null,null,fromUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            call GroupClear(tmp_group)
            call DestroyGroup(tmp_group)
            set tmp_group = null
        endif
        set distance = DistanceBetweenPoints(point, targetPoint)
        call RemoveLocation(point)

        if(distance<speed or distance<=0 or speed <=0 or IsUnitDeadBJ(mover) == true or duringInc > 5) then
            call funcs_delTimer(t,null)
            call SetUnitInvulnerable( mover, false )
            call SetUnitPathing( mover, true )
            call SetUnitPositionLoc( mover, targetPoint)
            call SetUnitVertexColorBJ( mover, 100, 100, 100, 0 )
            call DestroyGroup(remove_group)
            call RemoveLocation(targetPoint)
        endif
    endmethod

    //剃
    public method leap takes unit mover,location targetPoint,real speed,string Meffect,real range,boolean isRepeat,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location point = null
        local timer t = null
        local group remove_group = null

        //debug
        if(mover==null or targetPoint==null) then
            return
        endif

        //重复判定
        if( isRepeat == false ) then
            set remove_group = CreateGroup()
        else
            set remove_group = null
        endif

        set point = GetUnitLoc(mover)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(point)
        call SetUnitInvulnerable( mover, true )
        call SetUnitPathing( mover, false )
        set t = funcs_setInterval(lock_var_period,method leapCall)
        call funcs_setTimerParams_Real(t,Key_Skill_Speed,speed)
        call funcs_setTimerParams_Real(t,Key_Skill_Range,range)
        call funcs_setTimerParams_Unit(t,Key_Skill_Unit,mover)
        call funcs_setTimerParams_String(t,Key_Skill_MEffect,Meffect)
        call funcs_setTimerParams_Loc(t,Key_Skill_TargetPoint,targetPoint)
        call funcs_setTimerParams_Group(t,Key_Skill_Group,remove_group)
        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,0)
        call funcs_setTimerParams_Unit(t,Key_Skill_FromUnit,fromUnit)
        call funcs_setTimerParams_String(t,Key_Skill_HEffect,heffect)
        call funcs_setTimerParams_Real(t,Key_Skill_Damage,damage)
        call funcs_setTimerParams_String(t,Key_Skill_Hkind,hkind)
        call funcs_setTimerParams_String(t,Key_Skill_Htype,htype)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsBreak,isBreak)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsNoAvoid,isNoAvoid)
        call funcs_setTimerParams_String(t,Key_Skill_Special,special)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialVal,specialVal)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialDuring,specialDuring)
    endmethod

    //冲锋回调
    public method chargeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = htime.getReal(t,Key_Skill_Speed)
        local real range = htime.getReal(t,Key_Skill_Range)
        local real facing = htime.getReal(t,Key_Skill_Facing)
        local string chargeType = htime.getString(t,Key_Skill_Type)
        local string MEffect = htime.getString(t,Key_Skill_MEffect)
        local unit mover = htime.getUnit(t,Key_Skill_Unit)
        local location targetPoint = htime.getLoc(t,Key_Skill_TargetPoint)
        local group remove_group = htime.getGroup(t,Key_Skill_Group)
        local group remove_group2 = htime.getGroup(t,Key_Skill_Group2)
        local real duringInc = htime.getReal(t,Key_Skill_DuringInc)
        local unit fromUnit = htime.getUnit(t,Key_Skill_FromUnit)
        local string heffect = htime.getString(t,Key_Skill_HEffect)
        local real damage = htime.getReal(t,Key_Skill_Damage)
        local string hkind = htime.getString(t,Key_Skill_Hkind)
        local string htype = htime.getString(t,Key_Skill_Htype)
        local boolean isBreak = htime.getBoolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = htime.getBoolean(t,Key_Skill_IsNoAvoid)
        local string special = htime.getString(t,Key_Skill_Special)
        local real specialVal = htime.getReal(t,Key_Skill_SpecialVal)
        local real specialDuring = htime.getReal(t,Key_Skill_SpecialDuring)
        local real distance = 0.00
        local location point = null
        local location point2 = null
        local group tmp_group = null

        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set point =  GetUnitLoc(mover)
        set point2 = PolarProjectionBJ(point, speed, AngleBetweenPoints(point, targetPoint))
        call SetUnitPositionLoc( mover, point2 )
        set distance = DistanceBetweenPoints( point2, targetPoint)

        //如果强制设定移动特效，则显示设定的否则自动判断地形产生特效
        if(MEffect != null)then
            call funcs_effectLoc(MEffect,point2)
        else
            if( funcs_isWater(point) == true ) then
                //如果是水面，创建水花
                call funcs_effectLoc(Effect_CrushingWaveDamage,point2)
            else
                //如果是地面，创建沙尘
                call funcs_effectLoc(Effect_ImpaleTargetDust,point2)
            endif
        endif

        call RemoveLocation(point2)
        call RemoveLocation(point)
        if(damage > 0) then
            set point =  GetUnitLoc(mover)
            set tmp_group = funcs_getGroupByLoc( point,range,method filter_live_disbuild )
            call attributeHunt_huntGroup(tmp_group,remove_group,null,null,fromUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            call DestroyGroup(tmp_group)
            call RemoveLocation(point)
        endif

        //冲锋特技
        if( chargeType == SKILL_CHARGE_CRASH ) then
            //撞退
            call skills_crash( mover , 75.00 , speed , remove_group2 )
        elseif( chargeType == SKILL_CHARGE_FLY ) then
            //撞飞
             call skills_fly( mover , 75.00 , speed , 500.00,remove_group2 )
        elseif( chargeType == SKILL_CHARGE_DRAG ) then
            //拖行
            set point = GetUnitLoc(mover)
            set point2 = PolarProjectionBJ(point, 135.00, facing)
            set tmp_group = funcs_getGroupByLoc(point,100.00,method filter_live_disbuild_ground)
            call funcs_moveGroup(mover,tmp_group,point2,null,true,FILTER_ENEMY)
            call DestroyGroup(tmp_group)
            call RemoveLocation(point2)
            call RemoveLocation(point)
        endif

        if(distance<speed or distance<=0 or speed <=0 or IsUnitDeadBJ(mover) == true or duringInc > 5) then
            //停止
            call funcs_delTimer(t,null)
            call SetUnitPositionLoc( mover, targetPoint)
            call SetUnitPathing( mover, true )
            call PauseUnitBJ( false, mover )
            call SetUnitTimeScalePercent( mover, 100 )
            call SetUnitVertexColorBJ( mover, 100, 100, 100, 0.00 )
            call ResetUnitAnimation(  mover ) //恢复动画
            call RemoveLocation(targetPoint)
            if(remove_group!=null)then
                call GroupClear(remove_group)
                call DestroyGroup(remove_group)
                set remove_group = null
            endif
            if(remove_group2!=null)then
                call GroupClear(remove_group2)
                call DestroyGroup(remove_group2)
                set remove_group2 = null
            endif
        endif
    endmethod

    //冲锋
    //chargeType 冲锋类型 参考global string
    //不能攻击空中单位
    public method charge takes unit mover,real facing,real distance,real speed,string chargeType,string Meffect,real range,boolean isRepeat,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location point
        local location targetPoint
        local timer t
        local group remove_group = null
        local group remove_group2 = null

        //debug
        if(mover==null) then
            return
        endif
        if(isRepeat == true)then
            set remove_group = CreateGroup()
            set remove_group2 = CreateGroup()
        endif

        set point = GetUnitLoc(mover)
        set targetPoint = PolarProjectionBJ(point, distance, facing)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(point)
        call SetUnitPathing( mover, false )
        call PauseUnitBJ( true, mover )
        call SetUnitTimeScalePercent( mover, 300 )
        set t = funcs_setInterval(lock_var_period,method chargeCall)
        call funcs_setTimerParams_Real(t,Key_Skill_Speed,speed)
        call funcs_setTimerParams_Real(t,Key_Skill_Range,range)
        call funcs_setTimerParams_Real(t,Key_Skill_Facing,facing)
        call funcs_setTimerParams_Unit(t,Key_Skill_Unit,mover)
        call funcs_setTimerParams_String(t,Key_Skill_Type,chargeType)
        call funcs_setTimerParams_String(t,Key_Skill_MEffect,Meffect)
        call funcs_setTimerParams_Loc(t,Key_Skill_TargetPoint,targetPoint)
        call funcs_setTimerParams_Group(t,Key_Skill_Group,remove_group)
        call funcs_setTimerParams_Group(t,Key_Skill_Group2,remove_group2)
        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,0)
        call funcs_setTimerParams_Unit(t,Key_Skill_FromUnit,fromUnit)
        call funcs_setTimerParams_String(t,Key_Skill_HEffect,heffect)
        call funcs_setTimerParams_Real(t,Key_Skill_Damage,damage)
        call funcs_setTimerParams_String(t,Key_Skill_Hkind,hkind)
        call funcs_setTimerParams_String(t,Key_Skill_Htype,htype)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsBreak,isBreak)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsNoAvoid,isNoAvoid)
        call funcs_setTimerParams_String(t,Key_Skill_Special,special)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialVal,specialVal)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialDuring,specialDuring)
    endmethod

    //前进回调
    public method forwardCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = htime.getReal(t,Key_Skill_Speed)
        local real range = htime.getReal(t,Key_Skill_Range)
        local real duringInc = htime.getReal(t,Key_Skill_DuringInc)
        local string MEffect = htime.getString(t,Key_Skill_MEffect)
        local unit mover = htime.getUnit(t,Key_Skill_Unit)
        local location targetPoint = htime.getLoc(t,Key_Skill_TargetPoint)
        local group remove_group = htime.getGroup(t,Key_Skill_Group)
        local real during = htime.getReal(t,Key_Skill_During)
        local unit fromUnit = htime.getUnit(t,Key_Skill_FromUnit)
        local string heffect = htime.getString(t,Key_Skill_HEffect)
        local real damage = htime.getReal(t,Key_Skill_Damage)
        local string hkind = htime.getString(t,Key_Skill_Hkind)
        local string htype = htime.getString(t,Key_Skill_Htype)
        local boolean isBreak = htime.getBoolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = htime.getBoolean(t,Key_Skill_IsNoAvoid)
        local string special = htime.getString(t,Key_Skill_Special)
        local real specialVal = htime.getReal(t,Key_Skill_SpecialVal)
        local real specialDuring = htime.getReal(t,Key_Skill_SpecialDuring)
        local real distance = 0
        local location point = null
        local location point2 = null
        local group tmp_group = null

        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set point =  GetUnitLoc(mover)
        set distance = DistanceBetweenPoints(point, targetPoint)
        if((GetLocationX(targetPoint)==0 and GetLocationX(targetPoint)==0) or distance<speed) then
            call SetUnitPositionLoc( mover, targetPoint)
            call RemoveLocation(targetPoint)
        else
            set point2 = PolarProjectionBJ(point, speed, AngleBetweenPoints(point, targetPoint))
            call SetUnitPositionLoc( mover, point2 )
            if(MEffect != null)then
                call funcs_effectLoc(MEffect,point2)
            endif
            call RemoveLocation(point2)
        endif
        call RemoveLocation(point)

        if(damage > 0 and ModuloReal( duringInc , TimerGetTimeout(t)*10 ) == TimerGetTimeout(t) ) then
            set point =  GetUnitLoc(mover)
            set tmp_group = funcs_getGroupByLoc(point,range,method filter_live_disbuild)
            call attributeHunt_huntGroup(tmp_group,remove_group,null,null,fromUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            call GroupClear(tmp_group)
            call DestroyGroup(tmp_group)
            set tmp_group = null
            call RemoveLocation(point)
            set point = null
        endif

        if(duringInc >= during or IsUnitDeadBJ(mover) == TRUE) then
            call funcs_delTimer(t,null)
            call SetUnitVertexColorBJ( mover, 100, 100, 100, 0.00 )
        endif

    endmethod

    //前进
    public method forward takes unit mover,location targetPoint,real speed,string Meffect,real range,boolean isRepeat,real during,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location point = null
        local timer t = null
        local group remove_group = null

        //debug
        if(mover==null or targetPoint==null or during==null) then
            return
        endif

        //重复判定
        if( isRepeat == false ) then
            set remove_group = CreateGroup()
        else
            set remove_group = null
        endif

        set point = GetUnitLoc(mover)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(point)
        set point = null
        call SetUnitInvulnerable( mover, true )
        call SetUnitPathing( mover, false )
        set t = funcs_setInterval(lock_var_period,method forwardCall)
        call funcs_setTimerParams_Real(t,Key_Skill_Speed,speed)
        call funcs_setTimerParams_Real(t,Key_Skill_Range,range)
        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,0)
        call funcs_setTimerParams_Real(t,Key_Skill_During,during)
        call funcs_setTimerParams_Unit(t,Key_Skill_Unit,mover)
        call funcs_setTimerParams_String(t,Key_Skill_MEffect,Meffect)
        call funcs_setTimerParams_Loc(t,Key_Skill_TargetPoint,targetPoint)
        call funcs_setTimerParams_Group(t,Key_Skill_Group,remove_group)
        call funcs_setTimerParams_Unit(t,Key_Skill_FromUnit,fromUnit)
        call funcs_setTimerParams_String(t,Key_Skill_HEffect,heffect)
        call funcs_setTimerParams_Real(t,Key_Skill_Damage,damage)
        call funcs_setTimerParams_String(t,Key_Skill_Hkind,hkind)
        call funcs_setTimerParams_String(t,Key_Skill_Htype,htype)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsBreak,isBreak)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsNoAvoid,isNoAvoid)
        call funcs_setTimerParams_String(t,Key_Skill_Special,special)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialVal,specialVal)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialDuring,specialDuring)
    endmethod


    //跳跃(向某单位)回调
    private method jumpCallBack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = htime.getReal(t,Key_Skill_Speed)
        local real duringInc = htime.getReal(t,Key_Skill_DuringInc)
        local string JEffect = htime.getString(t,Key_Skill_JEffect)
        local unit jumper = htime.getUnit(t,Key_Skill_Unit)
        local unit targetUnit = htime.getUnit(t,Key_Skill_TargetUnit)
        local string heffect = htime.getString(t,Key_Skill_HEffect)
        local real damage = htime.getReal(t,Key_Skill_Damage)
        local string hkind = htime.getString(t,Key_Skill_Hkind)
        local string htype = htime.getString(t,Key_Skill_Htype)
        local boolean isBreak = htime.getBoolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = htime.getBoolean(t,Key_Skill_IsNoAvoid)
        local string special = htime.getString(t,Key_Skill_Special)
        local real specialVal = htime.getReal(t,Key_Skill_SpecialVal)
        local real specialDuring = htime.getReal(t,Key_Skill_SpecialDuring)
        local real distance = 0
        local location point = null
        local location point2 = null
        local location targetPoint = GetUnitLoc(targetUnit)

		call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set point =  GetUnitLoc(jumper)
        set point2 = PolarProjectionBJ(point, speed, AngleBetweenPoints(point, targetPoint))
        call SetUnitPositionLoc( jumper, point2 )
        call RemoveLocation(point2)
        call RemoveLocation(point)

        set point =  GetUnitLoc(jumper)
        if(JEffect != null)then
            call funcs_effectLoc(JEffect,point)
        endif
        set distance = DistanceBetweenPoints(point, targetPoint)
        call funcs_console("distance:"+R2S(distance))
        call funcs_console("speed:"+R2S(speed))
        call RemoveLocation(point)

        if(distance<speed or IsUnitDeadBJ(jumper) or IsUnitDeadBJ(targetUnit) or duringInc > 10) then
            call funcs_console("handle:jumpCallBack END")
            call funcs_delTimer(t,null)
            call SetUnitInvulnerable( jumper, false )
            call SetUnitPathing( jumper, true )
            call SetUnitPositionLoc( jumper, targetPoint)
            call SetUnitVertexColorBJ( jumper, 100, 100, 100, 0.00 )
            if(damage > 0) then
                call attributeHunt_huntUnit(jumper,targetUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            endif
            call RemoveLocation(targetPoint)
        endif
    endmethod
    //跳跃(向某单位)
    public method jump takes unit jumper,unit targetUnit,real speed,string Jeffect,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location point = null
        local location targetPoint = null
        local timer t = null
        local real distance = 0
        //local group remove_group = CreateGroup()
        //debug
        if(jumper==null or targetUnit==null) then
            return
        endif

        set point = GetUnitLoc(jumper)
        set targetPoint = GetUnitLoc(targetUnit)
        set distance = DistanceBetweenPoints(point, targetPoint)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(point)
        call RemoveLocation(targetPoint)
        call SetUnitInvulnerable(jumper, true )
        call SetUnitPathing( jumper, false )
        set t = funcs_setInterval(lock_var_period,method jumpCallBack)
        call funcs_setTimerParams_Real(t,Key_Skill_Speed,speed)
        call funcs_setTimerParams_Unit(t,Key_Skill_Unit,jumper)
        call funcs_setTimerParams_Unit(t,Key_Skill_TargetUnit,targetUnit)
        call funcs_setTimerParams_String(t,Key_Skill_JEffect,Jeffect)
        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,0)
        call funcs_setTimerParams_String(t,Key_Skill_HEffect,heffect)
        call funcs_setTimerParams_Real(t,Key_Skill_Damage,damage)
        call funcs_setTimerParams_String(t,Key_Skill_Hkind,hkind)
        call funcs_setTimerParams_String(t,Key_Skill_Htype,htype)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsBreak,isBreak)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsNoAvoid,isNoAvoid)
        call funcs_setTimerParams_String(t,Key_Skill_Special,special)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialVal,specialVal)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialDuring,specialDuring)
    endmethod

    //穿梭回调
    private method shuttleCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer during = htime.getInteger( t , Key_Skill_During )
        local unit shutter = htime.getUnit( t , Key_Skill_Unit  )
        local group whichGroup = htime.getGroup( t , Key_Skill_Group )
        local integer times = htime.getInteger( t , Key_Skill_Times )
        local real speed = htime.getReal( t , Key_Skill_Speed  )
        local real speedPlus = htime.getReal( t , Key_Skill_SpeedPlus )
        local real offsetDistance = htime.getReal( t , Key_Skill_Distance )
        local string JEffect = htime.getString( t , Key_Skill_JEffect )
        local string animate = htime.getString( t , Key_Skill_Animate )
        local integer skillModel = htime.getInteger( t , Key_Skill_Model  )
        local unit targetUnit = htime.getUnit( t , Key_Skill_TargetUnit )
        local location targetLoc = htime.getLoc( t , Key_Skill_Loc )

        local string heffect = htime.getString(t,Key_Skill_HEffect)
        local real damage = htime.getReal(t,Key_Skill_Damage)
        local string hkind = htime.getString(t,Key_Skill_Hkind)
        local string htype = htime.getString(t,Key_Skill_Htype)
        local boolean isBreak = htime.getBoolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = htime.getBoolean(t,Key_Skill_IsNoAvoid)
        local string special = htime.getString(t,Key_Skill_Special)
        local real specialVal = htime.getReal(t,Key_Skill_SpecialVal)
        local real specialDuring = htime.getReal(t,Key_Skill_SpecialDuring)

        //--------------------
        local integer playerIndex = GetConvertedPlayerId(GetOwningPlayer(shutter))
        local real distance = 0
        local location loc = null
        local location tempLoc = null
        local integer i = 0
        local unit tempUnit = null
        local group crashGroup = null

        if( shutter !=null and IsUnitAliveBJ(shutter) == true and CountUnitsInGroup(whichGroup)>0 ) then
            if( during <1 ) then
                call UnitAddAbility( shutter, skillModel)
            endif
            //TODO
            set loc = GetUnitLoc(shutter)
            //向一个单位进行目标穿梭,如果没有，从单位组取一个(需要进行缓存)
            if( targetUnit == null ) then
                set targetUnit = GroupPickRandomUnit(whichGroup)
                set tempLoc = GetUnitLoc(targetUnit)
                set targetLoc = PolarProjectionBJ( tempLoc , offsetDistance , AngleBetweenPoints(loc, tempLoc) )
                call funcs_setTimerParams_Unit( t , Key_Skill_TargetUnit , targetUnit ) //save
                call funcs_setTimerParams_Loc( t , Key_Skill_Loc , targetLoc ) //save
                call RemoveLocation(tempLoc)
            endif
            //移动
            call SetUnitFacing(shutter, AngleBetweenPoints(loc, targetLoc))
            call SetUnitPositionLoc( shutter, PolarProjectionBJ(loc, speed, AngleBetweenPoints(loc, targetLoc)) )
            //移动特效
            if( JEffect != null )then
                call funcs_effectLoc( JEffect , loc )
            endif
            //计算单轮距离是否到终点
            set distance = DistanceBetweenPoints( loc, targetLoc )
            call RemoveLocation(loc)
            //
            if( distance < speed ) then //单轮结束
                call SetUnitAnimation( shutter, animate )
                call SetUnitPositionLoc( shutter, targetLoc)
                call RemoveLocation(targetLoc)
                //伤害
                if( IsUnitAliveBJ(targetUnit) == true and damage > 0 ) then
                    call attributeHunt_huntUnit(shutter,targetUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
                endif
                if( during+1 >= times ) then
                    call funcs_delTimer( t, null )
                    if(skillModel!=null) then
                        call UnitAddAbility( shutter, skillModel)
                    endif
                    call SetUnitPositionLoc( shutter, targetLoc)
                    call RemoveLocation(targetLoc)
                    call SetUnitTimeScale( shutter, 1 )
                    call SetUnitInvulnerable( shutter, false )
                    call SetUnitPathing( shutter, true )
                    call SetUnitVertexColorBJ( shutter, 100, 100, 100, 0.00 )
                    call GroupClear(whichGroup)
                    call DestroyGroup(whichGroup)
                else
                    //选定下一个
                    set i = 1
                    set tempUnit = GroupPickRandomUnit(whichGroup)
                    loop
                        exitwhen( (IsUnitAliveBJ(targetUnit) ==true and tempUnit != targetUnit) or i>5 )
                        set tempUnit = GroupPickRandomUnit(whichGroup)
                        set i = i + 1
                    endloop
                    set loc = GetUnitLoc(shutter)
                    set tempLoc = GetUnitLoc(tempUnit)
                    set targetLoc = PolarProjectionBJ( tempLoc , offsetDistance , AngleBetweenPoints(loc, tempLoc) )
                    call RemoveLocation(tempLoc)
                    call RemoveLocation(loc)
                    call funcs_setTimerParams_Integer( t , Key_Skill_During ,(during + 1))
                    call funcs_setTimerParams_Unit( t , Key_Skill_TargetUnit , tempUnit )
                    call funcs_setTimerParams_Loc( t , Key_Skill_Loc , targetLoc )
                    call funcs_setTimerParams_Real( t , Key_Skill_Speed , speed+speedPlus )
                endif
            endif
        else
            call funcs_delTimer( t, null )
            if(shutter !=null ) then
                if(skillModel!=null) then
                    call UnitRemoveAbility( shutter, skillModel)
                endif
                call SetUnitTimeScale( shutter, 1 )
                call SetUnitInvulnerable( shutter, false )
                call SetUnitPathing( shutter, true )
                call SetUnitVertexColorBJ( shutter, 100, 100, 100, 0.00 )
            endif
            if( targetLoc !=null )then
                call RemoveLocation(targetLoc)
            endif
            call GroupClear(whichGroup)
            call DestroyGroup(whichGroup)
        endif
    endmethod
    */

    /**
     *  穿梭选定单位组
     * shuttlePeriod 穿梭周期
     * times 穿梭次数
     * isAttack 是否触发普通攻击判定
     */
     /*
    public method shuttleForGroup takes unit shutter,group whichGroup,integer times,real speed,real speedPlus,real offsetDistance,string JEffect,string animate,integer skillModel,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local timer t = null
        local real shuttlePeriod = 0.03
        call SetUnitTimeScale( shutter, 10 )
        call SetUnitInvulnerable( shutter, true )
        call SetUnitPathing( shutter, false )
        set t = funcs_setInterval( shuttlePeriod ,method shuttleCall )
        call funcs_setTimerParams_Integer( t , Key_Skill_During , 0 )
        call funcs_setTimerParams_Unit( t , Key_Skill_Unit , shutter )
        call funcs_setTimerParams_Group( t , Key_Skill_Group , whichGroup )
        call funcs_setTimerParams_Integer( t , Key_Skill_Times , times )
        call funcs_setTimerParams_Real( t , Key_Skill_Speed , speed )
        call funcs_setTimerParams_Real( t , Key_Skill_SpeedPlus , speedPlus )
        call funcs_setTimerParams_Real( t , Key_Skill_Distance , offsetDistance )
        call funcs_setTimerParams_String( t , Key_Skill_JEffect , JEffect )
        call funcs_setTimerParams_String( t , Key_Skill_Animate , animate )
        call funcs_setTimerParams_Integer( t , Key_Skill_Model , skillModel )
        call funcs_setTimerParams_String(t,Key_Skill_HEffect,heffect)
        call funcs_setTimerParams_Real(t,Key_Skill_Damage,damage)
        call funcs_setTimerParams_String(t,Key_Skill_Hkind,hkind)
        call funcs_setTimerParams_String(t,Key_Skill_Htype,htype)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsBreak,isBreak)
        call funcs_setTimerParams_Boolean(t,Key_Skill_IsNoAvoid,isNoAvoid)
        call funcs_setTimerParams_String(t,Key_Skill_Special,special)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialVal,specialVal)
        call funcs_setTimerParams_Real(t,Key_Skill_SpecialDuring,specialDuring)
    endmethod
    */

endstruct
