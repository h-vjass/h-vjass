
globals
	integer player_max_qty = 12
	integer player_current_qty = 0
	player array players
	string player_default_status_gaming = "游戏中"
	string player_default_status_nil = "无参与"
	string player_default_status_leave = "已离开"
endglobals

library hPlayer initializer init needs hSys

	globals

		private hashtable hash = null
		private integer hp_isComputer = 10001
		private integer hp_apm = 10002
		private integer hp_battle_status = 10003
		private integer hp_hero = 10004
		private integer hp_damage = 10005
		private integer hp_bedamage = 10006
		private integer hp_kill = 10007

	endglobals

	//是否电脑
	public function isComputer takes player whichPlayer returns boolean
		return LoadBoolean(hash, GetHandleId(whichPlayer), hp_isComputer)
	endfunction

	//设置玩家战斗状态
	public function setBattleStatus takes player whichPlayer,string status returns nothing
		call SaveStr(hash, GetHandleId(whichPlayer), hp_battle_status, status)
	endfunction
	//获取玩家战斗状态
	public function getBattleStatus takes player whichPlayer returns string
		return LoadStr(hash, GetHandleId(whichPlayer), hp_battle_status)
	endfunction

	//设置失败
	public function defeat takes player whichPlayer returns nothing
		call CustomDefeatBJ( whichPlayer, "失败" )
	endfunction

	//设置胜利
	public function victory takes player whichPlayer returns nothing
		call CustomVictoryBJ( whichPlayer, true, true )
	endfunction

	//设置玩家英雄
	public function setHero takes player whichPlayer,unit hero returns nothing
		call console.log(GetUnitName(hero))
		call SaveUnitHandle(hash, GetHandleId(whichPlayer), hp_hero, hero)
	endfunction
	//获取玩家英雄
	public function getHero takes player whichPlayer returns unit
		return LoadUnitHandle(hash, GetHandleId(whichPlayer), hp_hero)
	endfunction

	//获取玩家造成的总伤害
	public function getDamage takes player whichPlayer returns real
		return LoadReal(hash, GetHandleId(whichPlayer), hp_damage)
	endfunction
	//增加玩家造成的总伤害
	public function addDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hash, GetHandleId(whichPlayer), hp_damage, getDamage(whichPlayer)+val)
	endfunction

	//获取玩家是受到的总伤害
	public function getBeDamage takes player whichPlayer returns real
		return LoadReal(hash, GetHandleId(whichPlayer), hp_bedamage)
	endfunction
	//增加玩家受到的总伤害
	public function addBeDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hash, GetHandleId(whichPlayer), hp_bedamage, getBeDamage(whichPlayer)+val)
	endfunction

	//获取玩家杀敌数
	public function getKill takes player whichPlayer returns integer
		return LoadInteger(hash, GetHandleId(whichPlayer), hp_kill)
	endfunction
	//增加玩家杀敌数
	public function addKill takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash, GetHandleId(whichPlayer), hp_kill, getKill(whichPlayer)+val)
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
		call SaveInteger(hash, GetHandleId(whichPlayer), hp_apm, apm)
	endfunction
	public function getApm takes player whichPlayer returns integer
		if(time.count() > 60) then
			return R2I( I2R(LoadInteger(hash, GetHandleId(whichPlayer), hp_apm))  / ( I2R(time.count()) / 60.00 ))
	    else
	        return LoadInteger(hash, GetHandleId(whichPlayer), hp_apm)
	    endif
	endfunction
	private function addApm takes player whichPlayer returns nothing
		call SaveInteger(hash, GetHandleId(whichPlayer), hp_apm , LoadInteger(hash, GetHandleId(whichPlayer), hp_apm)+1)
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
		set hash = InitHashtable()
		call TriggerAddAction(triggerApm , function triggerApmActions)
		call TriggerAddAction(triggerApmUnit , function triggerApmUnitActions)
		loop
			exitwhen i>player_max_qty
				set players[i] = Player(i-1)
				set pid = GetHandleId(players[i])
				call SetPlayerHandicapXP( players[i] , 0 )
				call setApm(players[i],0)
				if((GetPlayerController(players[i]) == MAP_CONTROL_USER) and (GetPlayerSlotState(players[i]) == PLAYER_SLOT_STATE_PLAYING)) then
					set player_current_qty = player_current_qty + 1
					call SaveBoolean(hash, pid, hp_isComputer, false)
					call SaveStr(hash, pid, hp_battle_status, player_default_status_gaming)
	                call TriggerRegisterPlayerSelectionEventBJ( triggerApm , players[i] , true )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_RIGHT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_DOWN )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_UP )
	            else
	            	call SaveBoolean(hash, pid, hp_isComputer, true)
	            	call SaveStr(hash, pid, hp_battle_status, player_default_status_nil)
	            endif
			set i = i + 1
		endloop
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_ORDER )
	    call TriggerAddAction( triggerApmUnit, function triggerApmUnitActions )
	endfunction

endlibrary
