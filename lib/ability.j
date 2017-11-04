/* 基础能力 */
library hAbility initializer init needs hSys

	globals

		//超级马甲
		public integer ABILITY_TOKEN = 'h00J'
		//马甲技能
		public integer ABILITY_BREAK 	= 'A09R'
		public integer ABILITY_SWIM = 'A09Q'

		private hashtable hash = null
		//硬直
		private integer PAUSE_TYPE_black = 1
		private integer PAUSE_TYPE_blue = 2	

	endglobals

	/**
	 * 打断
	 * ! 注意这个方法对中立被动无效
	 */
	public function break takes unit u returns nothing
	    local location loc = GetUnitLoc( u )
	    local unit cu = hunit.createUnit( Player(PLAYER_NEUTRAL_PASSIVE) , ABILITY_TOKEN , loc)
	    call RemoveLocation( loc )
	    set loc = null
	    call UnitAddAbility( cu, ABILITY_BREAK)
	    call SetUnitAbilityLevel( cu , ABILITY_BREAK , 1 )
	    call IssueTargetOrder( cu , "thunderbolt", u )
	    call hunit.delUnit(cu,0.3)
	endfunction

	/**
	 * 眩晕回调
	 */
	private function swimCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		call UnitRemoveAbility(time.getUnit(t,1), 'BPSE' )
		call time.delTimer(t)
	endfunction

	/**
	 * 眩晕
	 * ! 注意这个方法对中立被动无效
	 */
	public function swim takes unit u,real during returns nothing
	    local location loc = null
	    local unit cu = null
	    local timer t = LoadTimerHandle(hash, GetHandleId(u), 5241)
	    if(t!=null and TimerGetRemaining(t)>0)then
	    	if(during <= TimerGetRemaining(t))then
				return
			else
				call time.delTimer(t)
				call hmsg.style(hmsg.ttg2Unit(u,"劲眩",6.00,"64e3f2",10,1.00,10.00)  ,"scale",0,0.05)
	    	endif
	    endif
	    set loc = GetUnitLoc( u )
	    set cu = hunit.createUnit( Player(PLAYER_NEUTRAL_PASSIVE) , ABILITY_TOKEN , loc)
	    call RemoveLocation( loc )
	    set loc = null
	    call UnitAddAbility( cu, ABILITY_SWIM)
	    call SetUnitAbilityLevel( cu , ABILITY_SWIM , 1 )
	    call IssueTargetOrder( cu , "thunderbolt", u )
	    call hunit.delUnit(cu,0.4)
	    set t = time.setTimeout(during,function swimCall)
	    call time.setUnit(t,1,u)
	    call SaveTimerHandle(hash, GetHandleId(u), 5241, t)
	endfunction

	/**
	 * 回避回调
	 */
	private function avoidCallBack takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = time.getUnit(t,1)
	    call SetUnitInvulnerable( whichUnit , false )
	    call time.delTimer(t)
	endfunction
	/**
	 * 回避
	 */
	public function avoid takes unit whichUnit returns nothing
	    local timer t
	    if(whichUnit==null) then
	        return
	    endif
	    call SetUnitInvulnerable( whichUnit, true )
	    set t = time.setTimeout( 0.00 ,function avoidCallBack)
	    call time.setUnit(t,1,whichUnit)
	endfunction

	/**
	 * 无敌回调
	 */
	private function invulnerableCallBack takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = time.getUnit(t,1)
	    call SetUnitInvulnerable( whichUnit , false )
	    call time.delTimer(t)
	endfunction
	/**
	 * 无敌
	 */
	public function invulnerable takes unit whichUnit,real during returns nothing
	    local timer t = null
	    if(whichUnit==null) then
	        return
	    endif
	    if( during == null ) then
	        set during = 0.00       //如果没有设置持续时间，则0秒无敌，跟回避效果相同
	    endif
	    call SetUnitInvulnerable( whichUnit, true )
	    set t = time.setTimeout( during ,function invulnerableCallBack)
	    call time.setUnit(t,1,whichUnit)
	endfunction

	/**
	 * 群体无敌回调1
	 */
	private function invulnerableGroupCallBack1 takes nothing returns nothing
	    call SetUnitInvulnerable( GetEnumUnit() , true )
	endfunction
	/**
	 * 群体无敌回调2
	 */
	private function invulnerableGroupCallBack2 takes nothing returns nothing
	    call SetUnitInvulnerable( GetEnumUnit() , false )
	endfunction
	 /**
	 * 群体无敌回调T
	 */
	private function invulnerableGroupCallBackT takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local group whichGroup = time.getGroup( t,1 )
	    call ForGroup(whichGroup, function invulnerableGroupCallBack2)
	    call GroupClear(whichGroup)
	    call DestroyGroup(whichGroup)
	endfunction

	/**
	 * 群体无敌
	 */
	public function invulnerableGroup takes group whichGroup ,real during returns nothing
	    local timer t = null
	    if( whichGroup == null ) then
	        return
	    endif
	    call ForGroup(whichGroup, function invulnerableGroupCallBack1)
	    set t = time.setTimeout( during ,function invulnerableGroupCallBackT)
	    call time.setGroup(t,1,whichGroup)
	endfunction

	/**
	 * 暂停效果回调
	 */
	public function pauseCall takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = time.getUnit(t,1)
	    local integer pauseType = time.getInteger(t,2)
	    call PauseUnit( whichUnit , false )
	    if( pauseType > 0 ) then
	        call SetUnitVertexColorBJ( whichUnit , 100, 100, 100, 0 )
	    endif
	    call SetUnitTimeScalePercent( whichUnit , 100.00 )
	    call time.delTimer(t)
	endfunction
	/**
	 * 暂停效果
	 */
	public function pause takes unit whichUnit,real during,integer pauseType returns nothing
	    local timer t = null
	    local timer prevTimer = null
	    local real prevTimeRemaining = 0
	    if(whichUnit==null) then
	        return
	    endif
	    if( during == null ) then
	        set during = 0.01   //假如没有设置时间，默认打断效果
	    endif
	    set prevTimer = LoadTimerHandle( hash , GetHandleId(whichUnit) , 3 )
	    set prevTimeRemaining = TimerGetRemaining(prevTimer)
	    if( prevTimeRemaining > 0 )then
	        call time.delTimer( prevTimer )
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
	    set t = time.setTimeout( (during+prevTimeRemaining) ,function pauseCall )
	    call time.setUnit(t,1,whichUnit)
	    call time.setInteger(t,2, pauseType )
	    call SaveTimerHandle( hash , GetHandleId(whichUnit) , 3 , t )
	endfunction

	 /**
	 * 通用闪电链
	 * attackUnit 攻击单位
	 * beUnit 被攻击单位
	 * skillId 技能ID
	 */
	public function thunderLink takes unit attackUnit,unit beUnit,integer skillId returns nothing
	    local location point = GetUnitLoc( attackUnit )
	    local player owner = GetOwningPlayer(attackUnit)
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN,point,bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueTargetOrder( token, "chainlightning",  beUnit )
	    call UnitApplyTimedLifeBJ( 1.00, 'BTLF', token )
	    call RemoveLocation(  point )
	endfunction

	//为单位添加效果只限技能类一段时间 回调
	private function addAbilityEffectCall takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local unit whichUnit = time.getUnit(t,1)
	    local integer whichAbility = time.getInteger(t,2)
	    call UnitRemoveAbility(whichUnit, whichAbility)
	    call time.delTimer(t)
	endfunction
	//为单位添加效果只限技能类一段时间
	public function addAbilityEffect takes unit whichUnit,integer whichAbility,integer abilityLevel,real during returns nothing
	    local timer t = null
	    if( whichUnit!=null and whichAbility!=null and during >0 )then
	        call UnitAddAbility( whichUnit, whichAbility)
	        call UnitMakeAbilityPermanent( whichUnit, true, whichAbility)
	        if( abilityLevel>0 ) then
	            call SetUnitAbilityLevel( whichUnit, whichAbility, abilityLevel )
	        endif
	        set t = time.setTimeout( during,function addAbilityEffectCall )
	        call time.setUnit(t,1,whichUnit)
	        call time.setInteger(t,2,whichAbility)
	    endif
	endfunction

	/**
	 * 自定义技能 - 对点
	 * skillId 技能ID
	 */
	public function diy2loc takes player owner,location loc,location targetLoc, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssuePointOrderLoc( token , orderString , targetLoc )
	    call hunit.delUnit(token,2.00)
	endfunction

	/**
	 * 自定义技能 - 立即
	 * skillId 技能ID
	 */
	public function diy2once takes player owner,location loc, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueImmediateOrder( token , orderString )
	    call hunit.delUnit(token,2.00)
	endfunction

	/**
	 * 自定义技能 - 对单位
	 * skillId 技能ID
	 */
	public function diy2unit takes player owner,location loc, unit targetUnit, integer skillId,string orderString returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueTargetOrder( token , orderString , targetUnit )
	    call hunit.delUnit(token,2.00)
	endfunction

	/**
	 * 自定义技能 - 对单位ByID
	 * skillId 技能ID
	 */
	public function diy2unitById takes player owner,location loc, unit targetUnit, integer skillId,integer orderId returns nothing
	    local unit token = CreateUnitAtLoc(owner,ABILITY_TOKEN , loc , bj_UNIT_FACING)
	    call UnitAddAbility( token, skillId)
	    call IssueTargetOrderById( token , orderId , targetUnit )
	    call hunit.delUnit(token,2.00)
	endfunction	

	private function init takes nothing returns nothing
		set hash = InitHashtable()
	endfunction

endlibrary
