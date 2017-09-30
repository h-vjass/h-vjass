globals
	boolean isInitGroupForAttack = false
    group array Group_Attack_Fake
    group array Group_BeAttack_Fake
    integer Skill_BeAttack_AttackUnit = 776
    integer Skill_BeAttack_BeAttackUnit = 777
    integer Skill_BeAttack_Index = 778
endglobals

//动态事件注册类
library eventRegist requires funcs

    //--------------DEFAULT-------------

    //单位受伤
    public function unitDamaged takes trigger t,unit u returns nothing
        if(t == null or u == null)then
            return
        endif
        call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DAMAGED )
    endfunction

    //单位死亡
    public function unitDeath takes trigger t,unit u returns nothing
        if(t == null or u == null)then
            return
        endif
        call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    endfunction

    //单位被攻击
    public function unitBeAttack takes trigger t,unit u returns nothing
        if(t == null or u == null)then
            return
        endif
        call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_ATTACKED )
    endfunction

    //玩家输入
    //exactMatchOnly 是否完全匹配 true=是
    public function playerInput takes trigger t , player whichPlayer,string content,boolean exactMatchOnly returns nothing
    	local integer i = 0
    	if( whichPlayer == null ) then
	    	loop
		    	exitwhen i >= 12
		    		call TriggerRegisterPlayerChatEvent( t, Player(i) , content , exactMatchOnly )
		    	set i = i+1
	    	endloop
		else
			call TriggerRegisterPlayerChatEvent( t, whichPlayer , content , exactMatchOnly )
    	endif
    endfunction

    //--------------HUNZSIG-------------
    private function removeBeAttack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit beAttacker = funcs_getTimerParams_Unit( t , Skill_BeAttack_BeAttackUnit  )
        local integer index = funcs_getTimerParams_Integer( t , Skill_BeAttack_Index  )
        call GroupRemoveUnit( Group_BeAttack_Fake[index] , beAttacker )
        call funcs_delTimer(t,null)
    endfunction

    private function removeAttack takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit attacker = funcs_getTimerParams_Unit( t , Skill_BeAttack_AttackUnit  )
        local integer index = GetConvertedPlayerId(GetOwningPlayer(attacker))
        call GroupRemoveUnit( Group_Attack_Fake[index] , attacker )
        call funcs_delTimer(t,null)
    endfunction

    public function registerBeAttack takes unit attacker,unit beAttacker returns nothing
        local integer attackerIndex = GetConvertedPlayerId(GetOwningPlayer(attacker))
        local integer beAttackerIndex = GetConvertedPlayerId(GetOwningPlayer(beAttacker))
        local real beforeAction = 0
        local real afterAction = 0
        local real arrowSpeed = 0
        local real arrowDuring = 0
        local real attackTime = 0
        local integer i = 0
        local real prevTimeRemaining = 0
		local timer timer_attack = null
        local timer timer_beAttack = null
        //初始化单位组
        if(isInitGroupForAttack == false) then
	        set isInitGroupForAttack = true
			set i = 1
	        loop
	            exitwhen i > 20
                set Group_Attack_Fake[i] = CreateGroup()
                set Group_BeAttack_Fake[i] = CreateGroup()
	            set i = i + 1
	        endloop
        endif
        //计算攻击时间
	    set attackTime= 1 //非英雄固定1

		//TODO 将被攻击的单位加入到伪被攻击组
		set prevTimeRemaining = 0
		set timer_beAttack = LoadTimerHandle( HASH_Player , GetHandleId(beAttacker) , Skill_BeAttack_BeAttackUnit )
		if( timer_beAttack != null)then
			set prevTimeRemaining = TimerGetRemaining(timer_beAttack)
	        if( prevTimeRemaining > 0 )then
	            call GroupRemoveUnit( Group_BeAttack_Fake[attackerIndex] , beAttacker )
	            call funcs_delTimer( timer_beAttack ,null )
	            set timer_beAttack = null
	        else
	            set prevTimeRemaining = 0
	        endif
		endif
        if( IsUnitInGroup( beAttacker , Group_BeAttack_Fake[attackerIndex] ) == false ) then
            call GroupAddUnit( Group_BeAttack_Fake[attackerIndex] , beAttacker )
            set timer_beAttack = funcs_setTimeout( attackTime+prevTimeRemaining , function removeBeAttack )
            call SaveTimerHandle( HASH_Player , GetHandleId(beAttacker) , Skill_BeAttack_BeAttackUnit , timer_beAttack )
            call funcs_setTimerParams_Unit( timer_beAttack , Skill_BeAttack_BeAttackUnit , beAttacker )
            call funcs_setTimerParams_Integer( timer_beAttack , Skill_BeAttack_Index , attackerIndex  )
        endif

		//TODO 将攻击的单位加入到伪攻击组
		set prevTimeRemaining = 0
		set timer_attack = LoadTimerHandle( HASH_Player , GetHandleId(attacker) , Skill_BeAttack_AttackUnit )
		if( timer_attack != null)then
			set prevTimeRemaining = TimerGetRemaining(timer_attack)
	        if( prevTimeRemaining > 0 )then
	            call GroupRemoveUnit( Group_Attack_Fake[attackerIndex] , attacker )
	            call funcs_delTimer( timer_attack ,null )
	            set timer_attack = null
	        else
	            set prevTimeRemaining = 0
	        endif
		endif
		if( IsUnitInGroup( attacker , Group_Attack_Fake[attackerIndex] ) == false ) then
            call GroupAddUnit( Group_Attack_Fake[attackerIndex] , attacker )
            set timer_attack = funcs_setTimeout( attackTime+prevTimeRemaining , function removeAttack )
            call SaveTimerHandle( HASH_Player , GetHandleId(attacker) , Skill_BeAttack_AttackUnit , timer_attack )
            call funcs_setTimerParams_Unit( timer_attack , Skill_BeAttack_AttackUnit , attacker )
        endif
    endfunction

endlibrary
