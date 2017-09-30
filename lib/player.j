globals

	hashtable hash_player = null
	integer player_qty = 12
	player array players
	constant integer hplayer_isComputer = 10001
	constant integer hplayer_apm = 10002
	constant integer hplayer_battle_status = 10003

endglobals

library hPlayer initializer init needs hSys

	//是否电脑
	public function isComputer takes player whichPlayer returns nothing
		call LoadBoolean(hash_player, GetHandleId(whichPlayer), hplayer_isComputer)
	endfunction

	//设置玩家战斗状态
	public function setBattleStatus takes player whichPlayer,string status returns nothing
		call SaveStr(hash_player, GetHandleId(whichPlayer), hplayer_battle_status, status)
	endfunction
	//获取玩家战斗状态
	public function getBattleStatus takes player whichPlayer returns string
		return LoadStr(hash_player, GetHandleId(whichPlayer), hplayer_battle_status)
	endfunction

	//获取玩家金钱
	public function getGold takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
	endfunction
	//设置玩家金钱
	public function setGold takes player whichPlayer,integer gold returns nothing
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold )
	endfunction
	//增加玩家金钱
	public function addGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	endfunction
	//减少玩家金钱
	public function subGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(-gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	endfunction

	//设置玩家木材
	public function setLumber takes player whichPlayer,integer lumber returns nothing
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber )
	endfunction
	//获取玩家木材
	public function getLumber takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
	endfunction
	//增加玩家木材
	public function addLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	endfunction
	//减少玩家木材
	public function subLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(-lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	endfunction

	//apm
	private function setApm takes player whichPlayer , integer apm returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hplayer_apm, apm)
	endfunction
	public function getApm takes player whichPlayer returns integer
		if(h_clock_count > 60) then
			return R2I( I2R(LoadInteger(hash_player, GetHandleId(whichPlayer), hplayer_apm))  / ( I2R(h_clock_count) / 60.00 ))
	    else
	        return LoadInteger(hash_player, GetHandleId(whichPlayer), hplayer_apm)
	    endif
	endfunction
	private function addApm takes player whichPlayer returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hplayer_apm , LoadInteger(hash_player, GetHandleId(whichPlayer), hplayer_apm)+1)
	endfunction
	private function triggerApmActions takes nothing returns nothing
		call addApm(GetTriggerPlayer())
	endfunction
	private function triggerApmUnitActions takes nothing returns nothing
		call addApm(GetOwningPlayer(GetTriggerUnit()))
	endfunction

	private function init takes nothing returns nothing
		local integer i = 1
		local integer pid = 0
		local trigger triggerApm = CreateTrigger()
		local trigger triggerApmUnit = CreateTrigger()
		set hash_player = InitHashtable()
		call TriggerAddAction(triggerApm , function triggerApmActions)
		call TriggerAddAction(triggerApmUnit , function triggerApmUnitActions)
		loop
			exitwhen i>player_qty
				set players[i] = Player(i-1)
				set pid = GetHandleId(players[i])
				call SetPlayerHandicapXP( players[i] , 0 )
				call setApm(players[i],0)
				if((GetPlayerController(players[i]) == MAP_CONTROL_USER) and (GetPlayerSlotState(players[i]) == PLAYER_SLOT_STATE_PLAYING)) then
					call SaveBoolean(hash_player, pid, hplayer_isComputer, false)
					call SaveStr(hash_player, pid, hplayer_battle_status, "游戏中")
	                call TriggerRegisterPlayerSelectionEventBJ( triggerApm , players[i] , true )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_RIGHT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_DOWN )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_UP )
	            else
	            	call SaveBoolean(hash_player, pid, hplayer_isComputer, true)
	            endif
			set i = i + 1
		endloop
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_ORDER )
	    call TriggerAddAction( triggerApmUnit, function triggerApmUnitActions )
	endfunction

endlibrary
