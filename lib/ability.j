// 基础能力

globals

    hAbility hability

	hashtable hash_ability = null

	//超级马甲
	integer ABILITY_TOKEN = 'h00J'
	//马甲技能
	integer ABILITY_BREAK 	= 'A09R'
	integer ABILITY_SWIM = 'A09Q'

	//硬直
	integer PAUSE_TYPE_black = 1
	integer PAUSE_TYPE_blue = 2	

	//回避生命
	integer ABILITY_AVOID_PLUS = 'A00B'
	integer ABILITY_AVOID_MIUNS = 'A00C'

	// 
	trigger ABILITY_UNARM_TRG = null
	group ABILITY_UNARM_GROUP = CreateGroup()
	trigger ABILITY_SILENT_TRG = null
	group ABILITY_SILENT_GROUP = CreateGroup()

endglobals

struct hAbility

	static method create takes nothing returns hAbility
        local hAbility x = 0
        set x = hAbility.allocate()
        return x
    endmethod

	/**
	 * 打断
	 * ! 注意这个方法对中立被动无效
	 */
	public static method break takes unit u returns nothing
	    local location loc = GetUnitLoc( u )
	    local unit cu = hunit.createUnit( Player(PLAYER_NEUTRAL_PASSIVE) , ABILITY_TOKEN , loc)
	    call RemoveLocation( loc )
	    set loc = null
	    call UnitAddAbility( cu, ABILITY_BREAK)
	    call SetUnitAbilityLevel( cu , ABILITY_BREAK , 1 )
	    call IssueTargetOrder( cu , "thunderbolt", u )
	    call hunit.del(cu,0.3)
		set cu = null
	endmethod

	/**
	 * 眩晕回调
	 */
	private static method swimCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		call UnitRemoveAbility(htime.getUnit(t,1), 'BPSE' )
		call htime.delTimer(t)
		set t = null
	endmethod

	/**
	 * 眩晕
	 * ! 注意这个方法对中立被动无效
	 */
	public static method swim takes unit u,real during returns nothing
	    local location loc = null
	    local unit cu = null
	    local timer t = LoadTimerHandle(hash_ability, GetHandleId(u), 5241)
	    if(t!=null and TimerGetRemaining(t)>0)then
	    	if(during <= TimerGetRemaining(t))then
				return
			else
				call htime.delTimer(t)
				call UnitRemoveAbility(u, 'BPSE' )
				call hmsg.style(hmsg.ttg2Unit(u,"劲眩",6.00,"64e3f2",10,1.00,10.00)  ,"scale",0,0.05)
	    	endif
	    endif
	    set loc = GetUnitLoc( u )
	    set cu = hunit.createUnit( Player(PLAYER_NEUTRAL_PASSIVE) , ABILITY_TOKEN , loc)
	    call RemoveLocation( loc )
	    call UnitAddAbility( cu, ABILITY_SWIM)
	    call SetUnitAbilityLevel( cu , ABILITY_SWIM , 1 )
	    call IssueTargetOrder( cu , "thunderbolt", u )
	    call hunit.del(cu,0.4)
	    set t = htime.setTimeout(during,function thistype.swimCall)
	    call htime.setUnit(t,1,u)
	    call SaveTimerHandle(hash_ability, GetHandleId(u), 5241, t)
		set loc = null
		set cu = null
		set t = null
	endmethod

	/**
	 * 沉默回调
	 */
	private static method silentCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit u = htime.getUnit(t,1)
		local integer uid = GetHandleId(u)
		local integer level = LoadInteger(hash_ability,uid, 54550)
		set level = level-1
		call SaveInteger(hash_ability,uid, 54550,level)
		if(level <= 0)then
			call heffect.del(LoadEffectHandle(hash_ability,uid, 54551))
			if(IsUnitInGroup(u, ABILITY_SILENT_GROUP) == true)then
				call GroupRemoveUnit(ABILITY_SILENT_GROUP,u)
			endif
		endif
		call htime.delTimer(t)
		set t = null
		set u = null
	endmethod
	/**
	 * 沉默执行
	 */
	private static method silentDo takes nothing returns nothing
		local unit u = GetTriggerUnit()
		if(IsUnitInGroup(u, ABILITY_SILENT_GROUP) == true)then
			call IssueImmediateOrder( u , "stop" )
		endif
		set u = null
	endmethod
	/**
	 * 沉默
	 */
	public static method silent takes unit u,real during returns nothing
	    local timer t = null
		local effect eff = null
		local integer level = LoadInteger(hash_ability, GetHandleId(u), 54550)
		if(ABILITY_SILENT_TRG == null)then
			set ABILITY_SILENT_TRG = CreateTrigger()
			call TriggerRegisterAnyUnitEventBJ( ABILITY_SILENT_TRG, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
			call TriggerAddAction(ABILITY_SILENT_TRG, function thistype.silentDo)
		endif
		set level = level+1
		if(level <= 1)then
			call hmsg.style(hmsg.ttg2Unit(u,"沉默",6.00,"ee82ee",10,1.00,10.00)  ,"scale",0,0.2)
		else
			call hmsg.style(hmsg.ttg2Unit(u,I2S(level)+"重沉默",6.00,"ee82ee",10,1.00,10.00)  ,"scale",0,0.2)
		endif
		call SaveInteger(hash_ability, GetHandleId(u), 54550, level)
		if(IsUnitInGroup(u, ABILITY_SILENT_GROUP) == false)then
			call GroupAddUnit(ABILITY_SILENT_GROUP,u)
			set eff = heffect.toUnit("Abilities\\Spells\\Other\\Silence\\SilenceTarget.mdl",u,"head",-1)
			call SaveEffectHandle(hash_ability, GetHandleId(u), 54551, eff)
		endif
	    set t = htime.setTimeout(during,function thistype.silentCall)
	    call htime.setUnit(t,1,u)
		set t = null
		set eff = null
	endmethod

	/**
	 * 缴械回调
	 */
	private static method unarmCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit u = htime.getUnit(t,1)
		local integer uid = GetHandleId(u)
		local effect eff = null
		local integer level = LoadInteger(hash_ability,uid, 55550)
		set level = level-1
		call SaveInteger(hash_ability,uid, 55550,level)
		if(level <= 0)then
			call heffect.del(LoadEffectHandle(hash_ability,uid, 55551))
			if(IsUnitInGroup(u, ABILITY_UNARM_GROUP) == true)then
				call GroupRemoveUnit(ABILITY_UNARM_GROUP,u)
			endif
		endif
		call htime.delTimer(t)
		set t = null
		set u = null
		set eff = null
	endmethod
	/**
	 * 缴械执行
	 */
	private static method unarmDo takes nothing returns nothing
		local unit u = GetAttacker()
		if(IsUnitInGroup(u, ABILITY_UNARM_GROUP) == true)then
			call IssueImmediateOrder( u , "stop" )
		endif
		set u = null
	endmethod
	/**
	 * 缴械
	 */
	public static method unarm takes unit u,real during returns nothing
	    local timer t = null
		local effect eff = null
		local integer level = LoadInteger(hash_ability, GetHandleId(u), 55550)
		if(ABILITY_UNARM_TRG == null)then
			set ABILITY_UNARM_TRG = CreateTrigger()
			call TriggerRegisterAnyUnitEventBJ( ABILITY_UNARM_TRG, EVENT_PLAYER_UNIT_ATTACKED )
			call TriggerAddAction(ABILITY_UNARM_TRG, function thistype.unarmDo)
		endif
		set level = level+1
		if(level <= 1)then
			call hmsg.style(hmsg.ttg2Unit(u,"缴械",6.00,"ffe4e1",10,1.00,10.00)  ,"scale",0,0.2)
		else
			call hmsg.style(hmsg.ttg2Unit(u,I2S(level)+"重缴械",6.00,"ffe4e1",10,1.00,10.00)  ,"scale",0,0.2)
		endif
		call SaveInteger(hash_ability, GetHandleId(u), 55550, level)
		if(IsUnitInGroup(u, ABILITY_UNARM_GROUP) == false)then
			call GroupAddUnit(ABILITY_UNARM_GROUP,u)
			set eff = heffect.toUnit("Abilities\\Spells\\Other\\Silence\\SilenceTarget.mdl",u,"weapon",-1)
			call SaveEffectHandle(hash_ability, GetHandleId(u), 55551, eff)
		endif
	    set t = htime.setTimeout(during,function thistype.unarmCall)
	    call htime.setUnit(t,1,u)
		set t = null
		set eff = null
	endmethod

	/**
	 * 回避回调
	 */
	private static method avoidCallBack takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = htime.getUnit(t,1)
	    call UnitAddAbility( whichUnit, ABILITY_AVOID_MIUNS )
		call SetUnitAbilityLevel( whichUnit, ABILITY_AVOID_MIUNS, 2 )
		call UnitRemoveAbility( whichUnit, ABILITY_AVOID_MIUNS )
	    call htime.delTimer(t)
		set t = null
		set whichUnit = null
	endmethod
	/**
	 * 回避
	 */
	public static method avoid takes unit whichUnit returns nothing
	    local timer t = null
	    if(whichUnit==null) then
	        return
	    endif
	    call UnitAddAbility( whichUnit, ABILITY_AVOID_PLUS )
		call SetUnitAbilityLevel( whichUnit, ABILITY_AVOID_PLUS, 2 )
		call UnitRemoveAbility( whichUnit, ABILITY_AVOID_PLUS )
	    set t = htime.setTimeout( 0.00 ,function thistype.avoidCallBack)
	    call htime.setUnit(t,1,whichUnit)
		set t = null
	endmethod

	/**
	 * 0秒无敌回调
	 */
	private static method zeroInvulnerableCallBack takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = htime.getUnit(t,1)
	    call SetUnitInvulnerable( whichUnit , false )
	    call htime.delTimer(t)
		set t = null
	endmethod
	/**
	 * 0秒无敌
	 */
	public static method zeroInvulnerable takes unit whichUnit returns nothing
	    local timer t = null
	    if(whichUnit==null) then
	        return
	    endif
	    call SetUnitInvulnerable( whichUnit, true )
	    set t = htime.setTimeout( 0.00 ,function thistype.zeroInvulnerableCallBack)
	    call htime.setUnit(t,1,whichUnit)
		set t = null
	endmethod

	/**
	 * 无敌回调
	 */
	private static method invulnerableCallBack takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = htime.getUnit(t,1)
	    call SetUnitInvulnerable( whichUnit , false )
	    call htime.delTimer(t)
		set t = null
		set whichUnit = null
	endmethod
	/**
	 * 无敌
	 */
	public static method invulnerable takes unit whichUnit,real during returns nothing
	    local timer t = null
	    if(whichUnit==null) then
	        return
	    endif
	    if( during < 0 ) then
	        set during = 0.00       //如果设置持续时间错误，则0秒无敌，跟回避效果相同
	    endif
	    call SetUnitInvulnerable( whichUnit, true )
	    set t = htime.setTimeout( during ,function thistype.invulnerableCallBack)
	    call htime.setUnit(t,1,whichUnit)
		set t = null
	endmethod

	/**
	 * 群体无敌回调1
	 */
	private static method invulnerableGroupCallBack1 takes nothing returns nothing
	    call SetUnitInvulnerable( GetEnumUnit() , true )
	endmethod
	/**
	 * 群体无敌回调2
	 */
	private static method invulnerableGroupCallBack2 takes nothing returns nothing
	    call SetUnitInvulnerable( GetEnumUnit() , false )
	endmethod
	 /**
	 * 群体无敌回调T
	 */
	private static method invulnerableGroupCallBackT takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local group whichGroup = htime.getGroup(t,1)
		call htime.delTimer(t)
	    call ForGroup(whichGroup, function thistype.invulnerableGroupCallBack2)
	    call GroupClear(whichGroup)
	    call DestroyGroup(whichGroup)
		set t = null
		set whichGroup = null
	endmethod

	/**
	 * 群体无敌
	 */
	public static method invulnerableGroup takes group whichGroup ,real during returns nothing
	    local timer t = null
	    if( whichGroup == null ) then
	        return
	    endif
	    call ForGroup(whichGroup, function thistype.invulnerableGroupCallBack1)
	    set t = htime.setTimeout( during ,function thistype.invulnerableGroupCallBackT)
	    call htime.setGroup(t,1,whichGroup)
		set t = null
	endmethod

	/**
	 * 暂停效果回调
	 */
	private static method pauseCall takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = htime.getUnit(t,1)
	    local integer pauseType = htime.getInteger(t,2)
	    call PauseUnit( whichUnit , false )
	    if( pauseType > 0 ) then
	        call SetUnitVertexColorBJ( whichUnit , 100, 100, 100, 0 )
	    endif
	    call SetUnitTimeScalePercent( whichUnit , 100.00 )
	    call htime.delTimer(t)
		set t = null
		set whichUnit = null
	endmethod
	/**
	 * 暂停效果
	 */
	public static method pause takes unit whichUnit,real during,integer pauseType returns nothing
	    local timer t = null
	    local timer prevTimer = null
	    local real prevTimeRemaining = 0
	    if(whichUnit==null) then
	        return
	    endif
	    if( during == null ) then
	        set during = 0.01   //假如没有设置时间，默认打断效果
	    endif
	    set prevTimer = LoadTimerHandle( hash_ability , GetHandleId(whichUnit) , 3 )
	    set prevTimeRemaining = TimerGetRemaining(prevTimer)
	    if( prevTimeRemaining > 0 )then
	        call htime.delTimer( prevTimer )
	    else
	        set prevTimeRemaining = 0
	    endif
	    if( pauseType == PAUSE_TYPE_black ) then
	        call SetUnitVertexColorBJ( whichUnit , 30, 30, 30, 0 )
	    elseif( pauseType == PAUSE_TYPE_blue ) then
	        call SetUnitVertexColorBJ( whichUnit , 30, 30, 150 , 0 )
	    endif
	    call SetUnitTimeScalePercent( whichUnit, 0.00 )
	    call PauseUnit( whichUnit, true )
	    set t = htime.setTimeout( (during+prevTimeRemaining) ,function thistype.pauseCall )
	    call htime.setUnit(t,1,whichUnit)
	    call htime.setInteger(t,2, pauseType )
	    call SaveTimerHandle( hash_ability , GetHandleId(whichUnit) , 3 , t )
		set t = null
		set prevTimer = null
	endmethod

	//为单位添加效果只限技能类一段时间 回调
	private static method addAbilityEffectCall takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = htime.getUnit(t,1)
	    local integer whichAbility = htime.getInteger(t,2)
	    call UnitRemoveAbility(whichUnit, whichAbility)
	    call htime.delTimer(t)
		set t = null
		set whichUnit = null
	endmethod
	//为单位添加效果只限技能类一段时间
	public static method addAbilityEffect takes unit whichUnit,integer whichAbility,integer abilityLevel,real during returns nothing
	    local timer t = null
	    if( whichUnit!=null and whichAbility!=null and during >0 )then
	        call UnitAddAbility( whichUnit, whichAbility)
	        call UnitMakeAbilityPermanent( whichUnit, true, whichAbility)
	        if( abilityLevel>0 ) then
	            call SetUnitAbilityLevel( whichUnit, whichAbility, abilityLevel )
	        endif
	        set t = htime.setTimeout( during,function thistype.addAbilityEffectCall )
	        call htime.setUnit(t,1,whichUnit)
	        call htime.setInteger(t,2,whichAbility)
	    endif
		set t = null
	endmethod

	/**
	 * 自定义技能 - 对点
	 * skillId 技能ID
	 */
	public static method diy2loc takes player owner,location loc,location targetLoc, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssuePointOrderLoc( token , orderString , targetLoc )
	    call hunit.del(token,2.00)
		set token = null
	endmethod

	/**
	 * 自定义技能 - 立即
	 * skillId 技能ID
	 */
	public static method diy2once takes player owner,location loc, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueImmediateOrder( token , orderString )
	    call hunit.del(token,2.00)
		set token = null
	endmethod

	/**
	 * 自定义技能 - 对单位
	 * skillId 技能ID
	 */
	public static method diy2unit takes player owner,location loc, unit targetUnit, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueTargetOrder( token , orderString , targetUnit )
	    call hunit.del(token,2.00)
		set token = null
	endmethod

	/**
	 * 自定义技能 - 对单位ByID
	 * skillId 技能ID
	 */
	public static method diy2unitById takes player owner,location loc, unit targetUnit, integer skillId,integer orderId returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueTargetOrderById( token , orderId , targetUnit )
	    call hunit.del(token,2.00)
		set token = null
	endmethod

endstruct
