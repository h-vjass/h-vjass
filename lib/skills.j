library skills requires attributeHunt

	/**
	 * 变身回调
	 */
    public function shapeshiftCall takes nothing returns nothing
    	local timer t = GetExpiredTimer()
    	local unit u = funcs_getTimerParams_Unit( t , Key_Skill_Unit )
    	local integer modelFrom = funcs_getTimerParams_Integer( t , Key_Skill_i )
    	local string eff = funcs_getTimerParams_String( t , Key_Skill_FEffect )
    	local integer index = GetConvertedPlayerId(GetOwningPlayer(u))
    	local location loc = null

    	set loc = GetUnitLoc(u)
		call funcs_effectLoc( eff , loc )
	    call RemoveLocation(loc)

    	call UnitAddAbility( u , modelFrom )
		call UnitRemoveAbility( u , modelFrom )

		call PolledWait(0.10) 
        //模型变化需要一点时间，所以这里加延时,在对单位进行属性计算
	    //call attribute_calculateOne(index)
    endfunction

	/**
	 * 变身
	 */
    public function shapeshift takes unit u, real during, integer modelFrom,integer modelTo,string eff returns nothing
    	local timer t = null
    	local integer index = GetConvertedPlayerId(GetOwningPlayer(u))
    	local location loc = null

		set loc = GetUnitLoc(u)
		call funcs_effectLoc( eff , loc )
	    call RemoveLocation(loc)

    	call UnitAddAbility( u , modelTo )
		call UnitRemoveAbility( u , modelTo )

		set t = funcs_setTimeout( during , function shapeshiftCall )
	    call funcs_setTimerParams_Unit( t , Key_Skill_Unit , u )
	    call funcs_setTimerParams_Integer( t , Key_Skill_i , modelFrom )
	    call funcs_setTimerParams_String( t , Key_Skill_FEffect , eff )

	    call PolledWait(0.10) 
        //模型变化需要一点时间，所以这里加延时,在对单位进行属性计算
	    //call attribute_calculateOne(index)
    endfunction

    /**
     * 移动目标单位到某单位组内随机单位处
     * jumper 目标单位
     * whichGroup 单位组
     * isLockCamera 是否跟随镜头
     */
    public function jumpRamdomUnit takes unit jumper,group whichGroup,boolean isLockCamera returns boolean
        local unit u = GroupPickRandomUnit(whichGroup)
        local location point = GetUnitLoc(u)
        if(u == null) then
            return false
        endif
        call SetUnitPositionLoc( jumper, point )
        if(isLockCamera) then
            call PanCameraToTimedLocForPlayer( GetOwningPlayer(jumper), point, 0.30 )
        endif
        call RemoveLocation(point)
        return true
    endfunction

    //撞退Call
    private function crashCall takes nothing returns nothing
        local timer t =GetExpiredTimer()
        local unit u = funcs_getTimerParams_Unit( t , Key_Skill_Unit )
        local real speed = funcs_getTimerParams_Real( t , Key_Skill_Unit )
        local real deg = funcs_getTimerParams_Real( t , Key_Skill_DEG )
        local real facing = funcs_getTimerParams_Real( t , Key_Skill_Facing )
        local real during = funcs_getTimerParams_Real( t , Key_Skill_During )
        local real duringInc = funcs_getTimerParams_Real( t , Key_Skill_DuringInc )
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
    endfunction
    //撞退 - 单体
    public function crashOne takes unit source, unit targetUnit ,real speed returns nothing
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
            set t = funcs_setInterval( 0.02 , function crashCall)
            call funcs_setTimerParams_Unit( t , Key_Skill_Unit , targetUnit )
            call funcs_setTimerParams_Real( t , Key_Skill_Unit , speed )
            call funcs_setTimerParams_Real( t , Key_Skill_DEG , deg )
            call funcs_setTimerParams_Real( t , Key_Skill_Facing , facing )
            call funcs_setTimerParams_Real( t , Key_Skill_During , (250.00/speed) )
            call funcs_setTimerParams_Real( t , Key_Skill_DuringInc , 0 )
            call RemoveLocation(loc)
        endif
        call RemoveLocation(triggerLoc)
    endfunction
    //撞退
    public function crash takes unit source, real range,real speed, group remove_group returns nothing
        local location triggerLoc = GetUnitLoc(source)
        local location loc = null
        local group g = funcs_getGroupByLoc( triggerLoc , range , function filter_live_disbuild )
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
                    set t = funcs_setInterval( 0.02 , function crashCall)
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
    endfunction

    //撞飞Call
    private function flyCall takes nothing returns nothing
        local timer t =GetExpiredTimer()
        local unit u = funcs_getTimerParams_Unit( t , Key_Skill_Unit )
        local string FEffect = funcs_getTimerParams_String( t , Key_Skill_FEffect )
        local real firstHeight = funcs_getTimerParams_Real( t , Key_Skill_Distance )
        local real speed = funcs_getTimerParams_Real( t , Key_Skill_Speed )
        local location loc = GetUnitLoc( u )
        call funcs_delTimer( t ,null )
        if( FEffect !=null ) then
            call funcs_effectLoc(FEffect,loc)
        endif
        call RemoveLocation(loc)
        call PauseUnitBJ( false, u )
        call SetUnitFlyHeight( u , firstHeight, speed * 2 )
    endfunction
    //撞飞
    public function fly takes unit source, real range,real speed, real height,group remove_group returns nothing
        local location triggerLoc = GetUnitLoc(source)
        local location loc = null
        local group g = funcs_getGroupByLoc( triggerLoc , range , function filter_live_disbuild )
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
                    set t = funcs_setTimeout( (height/flySpeed) , function flyCall)
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
    endfunction

    //剃回调
    public function leapCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = funcs_getTimerParams_Real(t,Key_Skill_Speed)
        local real range = funcs_getTimerParams_Real(t,Key_Skill_Range)
        local location targetPoint = funcs_getTimerParams_Loc(t,Key_Skill_TargetPoint)
        local string MEffect = funcs_getTimerParams_String(t,Key_Skill_MEffect)
        local unit mover = funcs_getTimerParams_Unit(t,Key_Skill_Unit)
        local group remove_group = funcs_getTimerParams_Group(t,Key_Skill_Group)
        local real duringInc = funcs_getTimerParams_Real(t,Key_Skill_DuringInc)

        local unit fromUnit = funcs_getTimerParams_Unit(t,Key_Skill_FromUnit)
        local string heffect = funcs_getTimerParams_String(t,Key_Skill_HEffect)
        local real damage = funcs_getTimerParams_Real(t,Key_Skill_Damage)
        local string hkind = funcs_getTimerParams_String(t,Key_Skill_Hkind)
        local string htype = funcs_getTimerParams_String(t,Key_Skill_Htype)
        local boolean isBreak = funcs_getTimerParams_Boolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = funcs_getTimerParams_Boolean(t,Key_Skill_IsNoAvoid)
        local string special = funcs_getTimerParams_String(t,Key_Skill_Special)
        local real specialVal = funcs_getTimerParams_Real(t,Key_Skill_SpecialVal)
        local real specialDuring = funcs_getTimerParams_Real(t,Key_Skill_SpecialDuring)

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
            set tmp_group = funcs_getGroupByLoc(point,range,function filter_live_disbuild)
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
    endfunction

    //剃
    public function leap takes unit mover,location targetPoint,real speed,string Meffect,real range,boolean isRepeat,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
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
        set t = funcs_setInterval(lock_var_period,function leapCall)
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
    endfunction

    //冲锋回调
    public function chargeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = funcs_getTimerParams_Real(t,Key_Skill_Speed)
        local real range = funcs_getTimerParams_Real(t,Key_Skill_Range)
        local real facing = funcs_getTimerParams_Real(t,Key_Skill_Facing)
        local string chargeType = funcs_getTimerParams_String(t,Key_Skill_Type)
        local string MEffect = funcs_getTimerParams_String(t,Key_Skill_MEffect)
        local unit mover = funcs_getTimerParams_Unit(t,Key_Skill_Unit)
        local location targetPoint = funcs_getTimerParams_Loc(t,Key_Skill_TargetPoint)
        local group remove_group = funcs_getTimerParams_Group(t,Key_Skill_Group)
        local group remove_group2 = funcs_getTimerParams_Group(t,Key_Skill_Group2)
        local real duringInc = funcs_getTimerParams_Real(t,Key_Skill_DuringInc)
        local unit fromUnit = funcs_getTimerParams_Unit(t,Key_Skill_FromUnit)
        local string heffect = funcs_getTimerParams_String(t,Key_Skill_HEffect)
        local real damage = funcs_getTimerParams_Real(t,Key_Skill_Damage)
        local string hkind = funcs_getTimerParams_String(t,Key_Skill_Hkind)
        local string htype = funcs_getTimerParams_String(t,Key_Skill_Htype)
        local boolean isBreak = funcs_getTimerParams_Boolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = funcs_getTimerParams_Boolean(t,Key_Skill_IsNoAvoid)
        local string special = funcs_getTimerParams_String(t,Key_Skill_Special)
        local real specialVal = funcs_getTimerParams_Real(t,Key_Skill_SpecialVal)
        local real specialDuring = funcs_getTimerParams_Real(t,Key_Skill_SpecialDuring)
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
            set tmp_group = funcs_getGroupByLoc( point,range,function filter_live_disbuild )
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
            set tmp_group = funcs_getGroupByLoc(point,100.00,function filter_live_disbuild_ground)
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
    endfunction

    //冲锋
    //chargeType 冲锋类型 参考global string
    //不能攻击空中单位
    public function charge takes unit mover,real facing,real distance,real speed,string chargeType,string Meffect,real range,boolean isRepeat,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
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
        set t = funcs_setInterval(lock_var_period,function chargeCall)
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
    endfunction

    //前进回调
    public function forwardCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = funcs_getTimerParams_Real(t,Key_Skill_Speed)
        local real range = funcs_getTimerParams_Real(t,Key_Skill_Range)
        local real duringInc = funcs_getTimerParams_Real(t,Key_Skill_DuringInc)
        local string MEffect = funcs_getTimerParams_String(t,Key_Skill_MEffect)
        local unit mover = funcs_getTimerParams_Unit(t,Key_Skill_Unit)
        local location targetPoint = funcs_getTimerParams_Loc(t,Key_Skill_TargetPoint)
        local group remove_group = funcs_getTimerParams_Group(t,Key_Skill_Group)
        local real during = funcs_getTimerParams_Real(t,Key_Skill_During)
        local unit fromUnit = funcs_getTimerParams_Unit(t,Key_Skill_FromUnit)
        local string heffect = funcs_getTimerParams_String(t,Key_Skill_HEffect)
        local real damage = funcs_getTimerParams_Real(t,Key_Skill_Damage)
        local string hkind = funcs_getTimerParams_String(t,Key_Skill_Hkind)
        local string htype = funcs_getTimerParams_String(t,Key_Skill_Htype)
        local boolean isBreak = funcs_getTimerParams_Boolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = funcs_getTimerParams_Boolean(t,Key_Skill_IsNoAvoid)
        local string special = funcs_getTimerParams_String(t,Key_Skill_Special)
        local real specialVal = funcs_getTimerParams_Real(t,Key_Skill_SpecialVal)
        local real specialDuring = funcs_getTimerParams_Real(t,Key_Skill_SpecialDuring)
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
            set tmp_group = funcs_getGroupByLoc(point,range,function filter_live_disbuild)
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

    endfunction

    //前进
    public function forward takes unit mover,location targetPoint,real speed,string Meffect,real range,boolean isRepeat,real during,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
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
        set t = funcs_setInterval(lock_var_period,function forwardCall)
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
    endfunction


    //跳跃(向某单位)回调
    private function jumpCallBack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = funcs_getTimerParams_Real(t,Key_Skill_Speed)
        local real duringInc = funcs_getTimerParams_Real(t,Key_Skill_DuringInc)
        local string JEffect = funcs_getTimerParams_String(t,Key_Skill_JEffect)
        local unit jumper = funcs_getTimerParams_Unit(t,Key_Skill_Unit)
        local unit targetUnit = funcs_getTimerParams_Unit(t,Key_Skill_TargetUnit)
        local string heffect = funcs_getTimerParams_String(t,Key_Skill_HEffect)
        local real damage = funcs_getTimerParams_Real(t,Key_Skill_Damage)
        local string hkind = funcs_getTimerParams_String(t,Key_Skill_Hkind)
        local string htype = funcs_getTimerParams_String(t,Key_Skill_Htype)
        local boolean isBreak = funcs_getTimerParams_Boolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = funcs_getTimerParams_Boolean(t,Key_Skill_IsNoAvoid)
        local string special = funcs_getTimerParams_String(t,Key_Skill_Special)
        local real specialVal = funcs_getTimerParams_Real(t,Key_Skill_SpecialVal)
        local real specialDuring = funcs_getTimerParams_Real(t,Key_Skill_SpecialDuring)
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
    endfunction
    //跳跃(向某单位)
    public function jump takes unit jumper,unit targetUnit,real speed,string Jeffect,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
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
        set t = funcs_setInterval(lock_var_period,function jumpCallBack)
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
    endfunction

    //穿梭回调
    private function shuttleCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer during = funcs_getTimerParams_Integer( t , Key_Skill_During )
        local unit shutter = funcs_getTimerParams_Unit( t , Key_Skill_Unit  )
        local group whichGroup = funcs_getTimerParams_Group( t , Key_Skill_Group )
        local integer times = funcs_getTimerParams_Integer( t , Key_Skill_Times )
        local real speed = funcs_getTimerParams_Real( t , Key_Skill_Speed  )
        local real speedPlus = funcs_getTimerParams_Real( t , Key_Skill_SpeedPlus )
        local real offsetDistance = funcs_getTimerParams_Real( t , Key_Skill_Distance )
        local string JEffect = funcs_getTimerParams_String( t , Key_Skill_JEffect )
        local string animate = funcs_getTimerParams_String( t , Key_Skill_Animate )
        local integer skillModel = funcs_getTimerParams_Integer( t , Key_Skill_Model  )
        local unit targetUnit = funcs_getTimerParams_Unit( t , Key_Skill_TargetUnit )
        local location targetLoc = funcs_getTimerParams_Loc( t , Key_Skill_Loc )

        local string heffect = funcs_getTimerParams_String(t,Key_Skill_HEffect)
        local real damage = funcs_getTimerParams_Real(t,Key_Skill_Damage)
        local string hkind = funcs_getTimerParams_String(t,Key_Skill_Hkind)
        local string htype = funcs_getTimerParams_String(t,Key_Skill_Htype)
        local boolean isBreak = funcs_getTimerParams_Boolean(t,Key_Skill_IsBreak)
        local boolean isNoAvoid = funcs_getTimerParams_Boolean(t,Key_Skill_IsNoAvoid)
        local string special = funcs_getTimerParams_String(t,Key_Skill_Special)
        local real specialVal = funcs_getTimerParams_Real(t,Key_Skill_SpecialVal)
        local real specialDuring = funcs_getTimerParams_Real(t,Key_Skill_SpecialDuring)

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
    endfunction

    /**
     *  穿梭选定单位组
     * shuttlePeriod 穿梭周期
     * times 穿梭次数
     * isAttack 是否触发普通攻击判定
     */
    public function shuttleForGroup takes unit shutter,group whichGroup,integer times,real speed,real speedPlus,real offsetDistance,string JEffect,string animate,integer skillModel,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local timer t = null
        local real shuttlePeriod = 0.03
        call SetUnitTimeScale( shutter, 10 )
        call SetUnitInvulnerable( shutter, true )
        call SetUnitPathing( shutter, false )
        set t = funcs_setInterval( shuttlePeriod ,function shuttleCall )
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
    endfunction

    

    /*
    //囚禁Sample
	private function captivityCall takes nothing returns nothing
		//TODO 把走出去的单位拉回来
		local unit triggerUnit = GetTriggerUnit()
		local location triggerLoc = GetUnitLoc(triggerUnit)
		local real deg = AngleBetweenPoints(m1_Enemy_CurrentAreaCenter, triggerLoc)
		local real degBetween = ModuloReal(RAbsBJ(deg), 90.00)
		local real distance = 0
		local location targetLoc = null
		call RemoveLocation(triggerLoc)
		if( degBetween == 0) then
			set distance = m1_Enemy_CurrentAreaBanDistance
		elseif(degBetween>45) then
        	set distance = m1_Enemy_CurrentAreaBanDistance / (CosBJ(RAbsBJ(90-degBetween)))
        else
        	set distance = m1_Enemy_CurrentAreaBanDistance / (CosBJ(degBetween))
		endif
		set targetLoc = PolarProjectionBJ(m1_Enemy_CurrentAreaCenter, distance, deg)
		call SetUnitPositionLoc( triggerUnit , targetLoc )
		call funcs_effectLoc( Effect_MassTeleportTarget , targetLoc )
		call funcs_floatMsgWithSize( "|cffc0c0c0禁锢|r" , triggerUnit , 11)
		call RemoveLocation(targetLoc)
	endfunction
	private function captivity takes unit u,rect area returns trigger
		local trigger t = CreateTrigger()
		call TriggerRegisterLeaveRectSimple( t , area )
		call TriggerAddAction(t , function captivityCall)
		return t
	endfunction
	*/

    /**
     * 玩家镜头摇晃回调（其实这个函数应该写在funcs里，为了方便管理，才与回避硬直等放在一块）
     * 镜头源
     */
    private function cameraNoiseSetTargetCallBack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local player whichPlayer = funcs_getTimerParams_Player(t,Key_Skill_Player)
        if (GetLocalPlayer() == whichPlayer) then
            call CameraSetTargetNoise(0, 0)
        endif
        call funcs_setPlayerParams_Boolean( whichPlayer , Key_Skill_Camera , false)
        call funcs_console("handle:cameraNoiseSetTargetCallBack END")
        call funcs_delTimer(t,null)
    endfunction

    /**
     * 玩家镜头摇晃
     * @param scale 振幅 - 摇晃
     */
    public function cameraNoiseSetTarget takes player whichPlayer,real during,real scale returns nothing
        local timer t
        if(whichPlayer==null) then
            return
        endif
        if( during == null ) then
            set during = 0.10   //假如没有设置时间，默认0.10秒意思意思一下
        endif
        if( scale == null ) then
            set scale = 5.00   //假如没有振幅，默认5.00意思意思一下
        endif

        //镜头动作降噪
        if( funcs_getPlayerParams_Boolean( whichPlayer , Key_Skill_Camera ) == true ) then
            return
        else
            call funcs_setPlayerParams_Boolean( whichPlayer , Key_Skill_Camera , true)
        endif

        call CameraSetTargetNoiseForPlayer( whichPlayer , scale , 1.00 )    //0.50为速率
        set t = funcs_setTimeout( during ,function cameraNoiseSetTargetCallBack)
        call funcs_setTimerParams_Player(t,Key_Skill_Player,whichPlayer)
    endfunction

    /**
     * 玩家镜头震动回调（其实这个函数应该写在funcs里，理由同摇晃）
     */
    private function cameraNoiseSetEQCallBack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local player whichPlayer = funcs_getTimerParams_Player(t,Key_Skill_Player)
        call CameraClearNoiseForPlayer( whichPlayer )
        call funcs_setPlayerParams_Boolean( whichPlayer , Key_Skill_Camera , false)
        call funcs_console("handle:cameraNoiseSetEQCallBack END")
        call funcs_delTimer(t,null)
    endfunction

    /**
     * 玩家镜头震动
     * @param scale 振幅 - 震动
     */
    public function cameraNoiseSetEQ takes player whichPlayer,real during,real scale returns nothing
        local timer t
        if(whichPlayer==null) then
            return
        endif
        if( during == null ) then
            set during = 0.10   //假如没有设置时间，默认0.10秒意思意思一下
        endif
        if( scale == null ) then
            set scale = 5.00   //假如没有振幅，默认5.00意思意思一下
        endif

        //镜头动作降噪
        if( funcs_getPlayerParams_Boolean( whichPlayer , Key_Skill_Camera ) == true ) then
            return
        else
            call funcs_setPlayerParams_Boolean( whichPlayer , Key_Skill_Camera , true)
        endif

        call CameraSetEQNoiseForPlayer( whichPlayer , scale )
        set t = funcs_setTimeout( during ,function cameraNoiseSetEQCallBack)
        call funcs_setTimerParams_Player(t,Key_Skill_Player,whichPlayer)
    endfunction

endlibrary
