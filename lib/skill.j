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
        local group repeatGroup = htime.getGroup(t,100)
        local group g = null
        local unit u = null
        local integer qty = htime.getInteger(t,2)
        local real reduce = htime.getReal(t,3)
        local real damage = htime.getReal(t,4)
        local hAttrHuntBean bean
        local hFilter filter
        set filter = hFilter.create()
        call filter.isEnemy(true,htime.getUnit(t,99))
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
                    if(repeatGroup==null or hgroup.isIn(u,repeatGroup)==false)then
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
            call hlightning.unit2unit(htime.getString(t,97),prevUnit,nextUnit,0.2*qty)
            set bean = hAttrHuntBean.create()
            set bean.fromUnit = htime.getUnit(t,99)
            set bean.toUnit = prevUnit
            set bean.damage = damage
            set bean.huntEff = htime.getString(t,98)
            set bean.huntKind = htime.getString(t,5)
            set bean.huntType = htime.getString(t,6)
            call hattrHunt.huntUnit(bean)
            call bean.destroy()
        endif
        set qty = qty-1
        set damage = damage*(1.00+reduce*0.01)
        call htime.setInteger(t,2,qty)
        call htime.setReal(t,4,damage)
        if(nextUnit==null or qty<=0 or damage<=2)then
            set repeatGroup = null
            set prevUnit = null
            set nextUnit = null
            call htime.delTimer(t)
            set t = null
            return
        endif
        set repeatGroup = null
        set prevUnit = null
        set nextUnit = null
        set t = null
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
            set t = null
        endif
	endmethod

	/**
	 * 变身回调
	 */
    private static method shapeshiftCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = htime.getUnit(t,1)
		call heffect.toUnitLoc( htime.getString(t,3) , u , 1.5 )
    	call UnitAddAbility( u , htime.getInteger(t,2) )
		call UnitRemoveAbility( u , htime.getInteger(t,2) )
        call hAttr.resetSkill(u)
        call htime.delTimer(t)
        set t = null
        set u = null
    endmethod
	/**
	 * 变身[参考 hJass变身技能模板]
     * modelFrom 技能模板 参考 'A00D'
     * modelTo 技能模板 参考 'A00E'
	 */
    public static method shapeshift takes unit u, real during, integer modelFrom,integer modelTo,string eff,hAttrBean bean returns nothing
    	local integer index = GetConvertedPlayerId(GetOwningPlayer(u))
        local timer t = null
		call heffect.toUnitLoc( eff , u , 1.5 )
    	call UnitAddAbility( u , modelTo )
		call UnitRemoveAbility( u , modelTo )
        call hAttr.resetSkill(u)
		set t = htime.setTimeout( during , function thistype.shapeshiftCall )
	    call htime.setUnit( t , 1 , u )
	    call htime.setInteger( t , 2 , modelFrom )
	    call htime.setString( t , 3 , eff )
        set t = null
        //根据bean影响属性
        call hAttrUnit.modifyAttrByBean(u,bean,during)
    endmethod

    /**
	 * 击飞回调
	 */
    private static method crackFlyCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit fromUnit = htime.getUnit(t, 2 )
        local unit toUnit = htime.getUnit(t, 1)
        local real cost = htime.getReal( t , 0 )
	    local real distance = htime.getReal( t , 3 )
	    local real high = htime.getReal( t , 4 )
	    local real damage = htime.getReal( t , 5 )
        local real during = htime.getReal( t , 13 )
        local real originHigh = htime.getReal( t , 14 )
        local real originFacing = htime.getReal( t , 15 )
        local real originDeg = htime.getReal( t , 16 )
        local real xy = 0
        local real z = 0
        local real timerSetTime = htime.getSetTime(t)
        local hAttrHuntBean bean
        if(cost>during)then
            set bean = hAttrHuntBean.create()
            set bean.fromUnit = fromUnit
            set bean.toUnit = toUnit
            set bean.damage = damage
            set bean.huntEff = htime.getString(t, 12)
            set bean.huntKind = htime.getString(t, 10)
            set bean.huntType = htime.getString(t, 11)
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
            call htime.delTimer(t)
            set fromUnit = null
            set toUnit = null
            set t = null
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
        set fromUnit = null
        set toUnit = null
        set t = null
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
        set t = null
    endmethod

    //剃回调
    public static method leapCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real duringInc = htime.getReal(t,1)
        local real speed = htime.getReal(t,2)
        local real range = htime.getReal(t,3)
        local unit u = htime.getUnit(t,4)
        local location loc = GetUnitLoc(u)
        local location targetLoc = htime.getLoc(t,6)
        local unit fromUnit = htime.getUnit(t,8)
        local group g = null
        local real damage = htime.getReal(t,10)
        local real distance = 0
        local hFilter hf = 0
        local hAttrHuntBean bean
        call htime.setReal(t,1,duringInc+TimerGetTimeout(t))
        set hxy.x = GetLocationX(loc)
        set hxy.y = GetLocationY(loc)
        set hxy = hlogic.polarProjection(hxy, speed, hlogic.getDegBetweenLoc(loc, targetLoc))
        call SetUnitPosition( u, hxy.x, hxy.y )
        if(htime.getString(t,5) != null)then
            call heffect.toLoc(htime.getString(t,5),loc,0.5)
        endif
        if(damage > 0) then
            set hf = hFilter.create()
            call hf.isAlive(true)
            call hf.isBuilding(false)
            call hf.isEnemy(true,fromUnit)
            set g = hgroup.createByLoc(loc,range,function hFilter.get)
            call hf.destroy()
            set bean = hAttrHuntBean.create()
            set bean.whichGroup = g
            set bean.whichGroupRepeat = htime.getGroup(t,7)
            set bean.damage = damage
            set bean.fromUnit = fromUnit
            set bean.huntEff = htime.getString(t,9)
            set bean.huntKind = htime.getString(t,11)
            set bean.huntType = htime.getString(t,12)
            set bean.isBreak = htime.getString(t,13)
            set bean.isNoAvoid = htime.getBoolean(t,14)
            call hattrHunt.huntGroup(bean)
            call bean.destroy()
            call GroupClear(g)
            call DestroyGroup(g)
            set g = null
        endif
        set distance = hlogic.getDistanceBetweenLoc(loc, targetLoc)
        call RemoveLocation(loc)
        if(distance<speed or distance<=0 or speed<=0 or IsUnitDeadBJ(u)==true or duringInc>5) then
            call SetUnitInvulnerable( u, false )
            call SetUnitPathing( u, true )
            call SetUnitPositionLoc( u, targetLoc)
            call SetUnitVertexColorBJ( u, 100, 100, 100, 0 )
            call GroupClear(htime.getGroup(t,7))
            call DestroyGroup(htime.getGroup(t,7))
            call RemoveLocation(targetLoc)
            call htime.delTimer(t)
        endif
        set t = null
        set u = null
        set fromUnit = null
        set loc = null
        set targetLoc = null
    endmethod

    //剃
    public static method leap takes unit mover,location targetLoc,real speed,string Meffect,real range,boolean isRepeat,hAttrHuntBean bean returns nothing
        local real lock_var_period = 0.02
        local timer t = null
        local group g = null
        if(mover==null or targetLoc==null) then
            return
        endif
        if( isRepeat == false ) then
            set g = CreateGroup()
        else
            set g = null
        endif
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call SetUnitInvulnerable( mover, true )
        call SetUnitPathing( mover, false )
        set t = htime.setInterval(lock_var_period,function thistype.leapCall)
        call htime.setReal(t,1,0)
        call htime.setReal(t,2,speed)
        call htime.setReal(t,3,range)
        call htime.setUnit(t,4,mover)
        call htime.setString(t,5,Meffect)
        call htime.setLoc(t,6,targetLoc)
        call htime.setGroup(t,7,g)
        call htime.setUnit(t,8,bean.fromUnit)
        call htime.setString(t,9,bean.huntEff)
        call htime.setReal(t,10,bean.damage)
        call htime.setString(t,11,bean.huntKind)
        call htime.setString(t,12,bean.huntType)
        call htime.setString(t,13,bean.isBreak)
        call htime.setBoolean(t,14,bean.isNoAvoid)
        set t = null
        set g = null
    endmethod

    //穿梭回调
    private static method shuttleCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer during = htime.getInteger( t , 1 )
        local unit shutter = htime.getUnit( t , 2  )
        local group g = htime.getGroup(t, 3 )
        local integer times = htime.getInteger( t , 4 )
        local real speed = htime.getReal( t , 5  )
        local real speedPlus = htime.getReal( t , 6 )
        local real offsetDistance = htime.getReal( t , 7 )
        local integer skillModel = htime.getInteger( t , 10  )
        local real damage = htime.getReal(t,12)
        local unit targetUnit = htime.getUnit(t, 17 )
        local location targetLoc = htime.getLoc(t, 18 )
        //--------------------
        local integer playerIndex = GetConvertedPlayerId(GetOwningPlayer(shutter))
        local real distance = 0
        local location loc = null
        local location loc2 = null
        local unit u = null
        local integer i = 0
        local hAttrHuntBean bean
        if( shutter !=null and IsUnitAliveBJ(shutter) == true and CountUnitsInGroup(g)>0 ) then
            if( during <1 ) then
                call UnitAddAbility( shutter, htime.getInteger(t, 10) )
            endif
            //TODO
            set loc = GetUnitLoc(shutter)
            //向一个单位进行目标穿梭,如果没有，从单位组取一个(需要进行缓存)
            if( targetUnit == null ) then
                set targetUnit = GroupPickRandomUnit(g)
                call htime.setUnit( t , 17 , targetUnit ) //save
            endif
            if(targetLoc==null)then
                set loc2 = GetUnitLoc(targetUnit)
                set targetLoc = PolarProjectionBJ( loc , offsetDistance , hlogic.getDegBetweenLoc(loc, loc2) )
                call RemoveLocation(loc2)
                set loc2 = null
                call htime.setLoc( t , 18 , targetLoc ) //save
            endif
            //移动
            call SetUnitFacing(shutter, hlogic.getDegBetweenLoc(loc, targetLoc))
            set loc2 = PolarProjectionBJ(loc, speed, hlogic.getDegBetweenLoc(loc, targetLoc))
            call SetUnitPositionLoc( shutter, loc2 )
            call RemoveLocation(loc2)
            set loc2 = null
            //移动特效
            if( htime.getString(t, 8 ) != null )then
                call heffect.toLoc( htime.getString(t, 8 ) , loc, 0.5 )
            endif
            //计算单轮距离是否到终点
            set distance = hlogic.getDistanceBetweenLoc( loc, targetLoc )
            call RemoveLocation(loc)
            set loc = null
            //
            call hconsole.log("distance="+R2S(distance))
            call hconsole.log("speed="+R2S(speed))
            if( distance < speed*1.5 ) then //单轮结束
                call SetUnitPositionLoc( shutter, targetLoc )
                call RemoveLocation(targetLoc)
                set targetLoc = null
                call SetUnitAnimation( shutter, htime.getString(t,9) )
                //伤害
                if( IsUnitAliveBJ(targetUnit) == true and damage > 0 ) then
                    set bean = hAttrHuntBean.create()
                    set bean.damage = damage
                    set bean.fromUnit = shutter
                    set bean.toUnit = targetUnit
                    set bean.huntEff = htime.getString(t,11)
                    set bean.huntKind = htime.getString(t,13)
                    set bean.huntType = htime.getString(t,14)
                    set bean.isBreak = htime.getString(t,15)
                    set bean.isNoAvoid = htime.getBoolean(t,16)
                    call hattrHunt.huntUnit(bean)
                    call bean.destroy()
                endif
                if( during+1 >= times ) then
                    call htime.delTimer( t )
                    set t = null
                    if(skillModel!=null) then
                        call UnitRemoveAbility( shutter, skillModel)
                    endif
                    call SetUnitTimeScale( shutter, 1 )
                    call SetUnitInvulnerable( shutter, false )
                    call SetUnitPathing( shutter, true )
                    call SetUnitVertexColorBJ( shutter, 100, 100, 100, 0.00 )
                    call GroupClear(g)
                    call DestroyGroup(g)
                    set g = null
                else
                    //选定下一个
                    set i = 1
                    set u = GroupPickRandomUnit(g)
                    loop
                        exitwhen( (IsUnitAliveBJ(targetUnit) ==true and u != targetUnit) or i>5 )
                        set u = GroupPickRandomUnit(g)
                        set i = i + 1
                    endloop
                    call htime.setInteger( t , 1 ,(during + 1))
                    call htime.setUnit( t , 17 , u )
                    call htime.setLoc( t , 18 , null )
                    call htime.setReal( t , 5 , speed+speedPlus )
                    set u = null
                endif
            endif
        else
            call htime.delTimer( t )
            set t = null
            if(shutter !=null ) then
                if(skillModel!=null) then
                    call UnitRemoveAbility( shutter, skillModel)
                endif
                call SetUnitTimeScale( shutter, 1 )
                call SetUnitInvulnerable( shutter, false )
                call SetUnitPathing( shutter, true )
                call SetUnitVertexColorBJ( shutter, 100, 100, 100, 0.00 )
            endif
            call GroupClear(g)
            call DestroyGroup(g)
            set g = null
        endif
        set t = null
        set loc = null
        set loc2 = null
        set targetLoc = null
        set shutter = null
    endmethod

    /**
     *  穿梭选定单位组
     * shuttlePeriod 穿梭周期
     * times 穿梭次数
     * isAttack 是否触发普通攻击判定
     */
    public static method shuttleToGroup takes unit shutter,group whichGroup,integer times,real speed,real speedPlus,real offsetDistance,string JEffect,string animate,integer skillModel,hAttrHuntBean bean returns nothing
        local real shuttlePeriod = 0.03
        local timer t = null
        call SetUnitTimeScale( shutter, 10 )
        call SetUnitInvulnerable( shutter, true )
        call SetUnitPathing( shutter, false )
        set t = htime.setInterval( shuttlePeriod ,function thistype.shuttleCall )
        call htime.setInteger( t , 1 , 0 )
        call htime.setUnit( t , 2 , shutter )
        call htime.setGroup( t , 3 , whichGroup )
        call htime.setInteger( t , 4 , times )
        call htime.setReal( t , 5 , speed )
        call htime.setReal( t , 6 , speedPlus )
        call htime.setReal( t , 7 , offsetDistance )
        call htime.setString( t , 8 , JEffect )
        call htime.setString( t , 9 , animate )
        call htime.setInteger( t , 10 , skillModel )
        call htime.setString(t,11,bean.huntEff)
        call htime.setReal(t,12,bean.damage)
        call htime.setString(t,13,bean.huntKind)
        call htime.setString(t,14,bean.huntType)
        call htime.setString(t,15,bean.isBreak)
        call htime.setBoolean(t,16,bean.isNoAvoid)
        set t = null
    endmethod

    /**
     *  穿梭指定单位
     * shuttlePeriod 穿梭周期
     * times 穿梭次数
     * isAttack 是否触发普通攻击判定
     */
    public static method shuttleToUnit takes unit shutter,unit whichUnit,real range,integer times,real speed,real speedPlus,real offsetDistance,string JEffect,string animate,integer skillModel,hAttrHuntBean bean returns nothing
        local hFilter hf
        local group g = null
        set hf = hFilter.create()
        call hf.isAlive(true)
        call hf.isBuilding(false)
        call hf.isEnemy(true,shutter)
        set g = hgroup.createByUnit(whichUnit,range,function hFilter.get)
        call thistype.shuttleToGroup(shutter,g,times,speed,speedPlus,offsetDistance,JEffect,animate,skillModel,bean)
        call hf.destroy()
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
            set deg = AngleBetweenlocs(triggerLoc, loc)
            set facing = AngleBetweenlocs(loc, triggerLoc)
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
                    set deg = AngleBetweenlocs(triggerLoc, loc)
                    set facing = AngleBetweenlocs(loc, triggerLoc)
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

    //冲锋回调
    public method chargeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed = htime.getReal(t,Key_Skill_Speed)
        local real range = htime.getReal(t,Key_Skill_Range)
        local real facing = htime.getReal(t,Key_Skill_Facing)
        local string chargeType = htime.getString(t,Key_Skill_Type)
        local string MEffect = htime.getString(t,Key_Skill_MEffect)
        local unit mover = htime.getUnit(t,Key_Skill_Unit)
        local location targetLoc = htime.getLoc(t,Key_Skill_targetLoc)
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
        local location loc = null
        local location loc2 = null
        local group tmp_group = null

        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set loc =  GetUnitLoc(mover)
        set loc2 = PolarProjectionBJ(loc, speed, AngleBetweenlocs(loc, targetLoc))
        call SetUnitPositionLoc( mover, loc2 )
        set distance = DistanceBetweenlocs( loc2, targetLoc)

        //如果强制设定移动特效，则显示设定的否则自动判断地形产生特效
        if(MEffect != null)then
            call funcs_effectLoc(MEffect,loc2)
        else
            if( funcs_isWater(loc) == true ) then
                //如果是水面，创建水花
                call funcs_effectLoc(Effect_CrushingWaveDamage,loc2)
            else
                //如果是地面，创建沙尘
                call funcs_effectLoc(Effect_ImpaleTargetDust,loc2)
            endif
        endif

        call RemoveLocation(loc2)
        call RemoveLocation(loc)
        if(damage > 0) then
            set loc =  GetUnitLoc(mover)
            set tmp_group = funcs_getGroupByLoc( loc,range,method filter_live_disbuild )
            call attributeHunt_huntGroup(tmp_group,remove_group,null,null,fromUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            call DestroyGroup(tmp_group)
            call RemoveLocation(loc)
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
            set loc = GetUnitLoc(mover)
            set loc2 = PolarProjectionBJ(loc, 135.00, facing)
            set tmp_group = funcs_getGroupByLoc(loc,100.00,method filter_live_disbuild_ground)
            call funcs_moveGroup(mover,tmp_group,loc2,null,true,FILTER_ENEMY)
            call DestroyGroup(tmp_group)
            call RemoveLocation(loc2)
            call RemoveLocation(loc)
        endif

        if(distance<speed or distance<=0 or speed <=0 or IsUnitDeadBJ(mover) == true or duringInc > 5) then
            //停止
            call funcs_delTimer(t,null)
            call SetUnitPositionLoc( mover, targetLoc)
            call SetUnitPathing( mover, true )
            call PauseUnitBJ( false, mover )
            call SetUnitTimeScalePercent( mover, 100 )
            call SetUnitVertexColorBJ( mover, 100, 100, 100, 0.00 )
            call ResetUnitAnimation(  mover ) //恢复动画
            call RemoveLocation(targetLoc)
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
        local location loc
        local location targetLoc
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

        set loc = GetUnitLoc(mover)
        set targetLoc = PolarProjectionBJ(loc, distance, facing)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(loc)
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
        call funcs_setTimerParams_Loc(t,Key_Skill_targetLoc,targetLoc)
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
        local location targetLoc = htime.getLoc(t,Key_Skill_targetLoc)
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
        local location loc = null
        local location loc2 = null
        local group tmp_group = null

        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set loc =  GetUnitLoc(mover)
        set distance = DistanceBetweenlocs(loc, targetLoc)
        if((GetLocationX(targetLoc)==0 and GetLocationX(targetLoc)==0) or distance<speed) then
            call SetUnitPositionLoc( mover, targetLoc)
            call RemoveLocation(targetLoc)
        else
            set loc2 = PolarProjectionBJ(loc, speed, AngleBetweenlocs(loc, targetLoc))
            call SetUnitPositionLoc( mover, loc2 )
            if(MEffect != null)then
                call funcs_effectLoc(MEffect,loc2)
            endif
            call RemoveLocation(loc2)
        endif
        call RemoveLocation(loc)

        if(damage > 0 and ModuloReal( duringInc , TimerGetTimeout(t)*10 ) == TimerGetTimeout(t) ) then
            set loc =  GetUnitLoc(mover)
            set tmp_group = funcs_getGroupByLoc(loc,range,method filter_live_disbuild)
            call attributeHunt_huntGroup(tmp_group,remove_group,null,null,fromUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            call GroupClear(tmp_group)
            call DestroyGroup(tmp_group)
            set tmp_group = null
            call RemoveLocation(loc)
            set loc = null
        endif

        if(duringInc >= during or IsUnitDeadBJ(mover) == TRUE) then
            call funcs_delTimer(t,null)
            call SetUnitVertexColorBJ( mover, 100, 100, 100, 0.00 )
        endif

    endmethod

    //前进
    public method forward takes unit mover,location targetLoc,real speed,string Meffect,real range,boolean isRepeat,real during,unit fromUnit,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location loc = null
        local timer t = null
        local group remove_group = null

        //debug
        if(mover==null or targetLoc==null or during==null) then
            return
        endif

        //重复判定
        if( isRepeat == false ) then
            set remove_group = CreateGroup()
        else
            set remove_group = null
        endif

        set loc = GetUnitLoc(mover)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(loc)
        set loc = null
        call SetUnitInvulnerable( mover, true )
        call SetUnitPathing( mover, false )
        set t = funcs_setInterval(lock_var_period,method forwardCall)
        call funcs_setTimerParams_Real(t,Key_Skill_Speed,speed)
        call funcs_setTimerParams_Real(t,Key_Skill_Range,range)
        call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,0)
        call funcs_setTimerParams_Real(t,Key_Skill_During,during)
        call funcs_setTimerParams_Unit(t,Key_Skill_Unit,mover)
        call funcs_setTimerParams_String(t,Key_Skill_MEffect,Meffect)
        call funcs_setTimerParams_Loc(t,Key_Skill_targetLoc,targetLoc)
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
        local location loc = null
        local location loc2 = null
        local location targetLoc = GetUnitLoc(targetUnit)

		call funcs_setTimerParams_Real(t,Key_Skill_DuringInc,duringInc+TimerGetTimeout(t))

        set loc =  GetUnitLoc(jumper)
        set loc2 = PolarProjectionBJ(loc, speed, AngleBetweenlocs(loc, targetLoc))
        call SetUnitPositionLoc( jumper, loc2 )
        call RemoveLocation(loc2)
        call RemoveLocation(loc)

        set loc =  GetUnitLoc(jumper)
        if(JEffect != null)then
            call funcs_effectLoc(JEffect,loc)
        endif
        set distance = DistanceBetweenlocs(loc, targetLoc)
        call funcs_console("distance:"+R2S(distance))
        call funcs_console("speed:"+R2S(speed))
        call RemoveLocation(loc)

        if(distance<speed or IsUnitDeadBJ(jumper) or IsUnitDeadBJ(targetUnit) or duringInc > 10) then
            call funcs_console("handle:jumpCallBack END")
            call funcs_delTimer(t,null)
            call SetUnitInvulnerable( jumper, false )
            call SetUnitPathing( jumper, true )
            call SetUnitPositionLoc( jumper, targetLoc)
            call SetUnitVertexColorBJ( jumper, 100, 100, 100, 0.00 )
            if(damage > 0) then
                call attributeHunt_huntUnit(jumper,targetUnit,heffect,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
            endif
            call RemoveLocation(targetLoc)
        endif
    endmethod
    //跳跃(向某单位)
    public method jump takes unit jumper,unit targetUnit,real speed,string Jeffect,string heffect,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
        local real lock_var_period = 0.02
        local location loc = null
        local location targetLoc = null
        local timer t = null
        local real distance = 0
        //local group remove_group = CreateGroup()
        //debug
        if(jumper==null or targetUnit==null) then
            return
        endif

        set loc = GetUnitLoc(jumper)
        set targetLoc = GetUnitLoc(targetUnit)
        set distance = DistanceBetweenlocs(loc, targetLoc)
        if(speed>150) then
            set speed = 150   //最大速度
        elseif(speed<=1) then
            set speed = 1   //最小速度
        endif
        call RemoveLocation(loc)
        call RemoveLocation(targetLoc)
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

    */

endstruct
