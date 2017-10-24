
globals
	
	hPlayer hplayer = 0
	hashtable hp_hash = null
	integer hp_isComputer = 10001
	integer hp_apm = 10002
	integer hp_battle_status = 10003
	integer hp_hero = 10004
	integer hp_damage = 10005
	integer hp_bedamage = 10006
	integer hp_kill = 10007

	integer player_max_qty = 12
	integer player_current_qty = 0
	player array players
endglobals

struct hPlayer

	static string default_status_gaming = "游戏中"
	static string default_status_nil = "无参与"
	static string default_status_leave = "已离开"

	//apm
	private static method setApm takes player whichPlayer , integer apm returns nothing
		call SaveInteger(hp_hash, GetHandleId(whichPlayer), hp_apm, apm)
	endmethod
	public static method getApm takes player whichPlayer returns integer
		if(time.count() > 60) then
			return R2I( I2R(LoadInteger(hp_hash, GetHandleId(whichPlayer), hp_apm))  / ( I2R(time.count()) / 60.00 ))
	    else
	        return LoadInteger(hp_hash, GetHandleId(whichPlayer), hp_apm)
	    endif
	endmethod
	private static method addApm takes player whichPlayer returns nothing
		call SaveInteger(hp_hash, GetHandleId(whichPlayer), hp_apm , LoadInteger(hp_hash, GetHandleId(whichPlayer), hp_apm)+1)
	endmethod
	private static method triggerApmActions takes nothing returns nothing
		call addApm(GetTriggerPlayer())
	endmethod
	private static method triggerApmUnitActions takes nothing returns nothing
		call addApm(GetOwningPlayer(GetTriggerUnit()))
	endmethod

	public static method create takes nothing returns hPlayer
		local hRect x = 0
		local integer i = 1
		local integer pid = 0
		local trigger triggerApm = CreateTrigger()
		local trigger triggerApmUnit = CreateTrigger()
        set x = hPlayer.allocate()
        if(hp_hash==null)then
        	set hp_hash = InitHashtable()
        endif
		call TriggerAddAction(triggerApm , function hPlayer.triggerApmActions)
		call TriggerAddAction(triggerApmUnit , function hPlayer.triggerApmUnitActions)
		loop
			exitwhen i>player_max_qty
				set players[i] = Player(i-1)
				set pid = GetHandleId(players[i])
				call SetPlayerHandicapXP( players[i] , 0 )
				call setApm(players[i],0)
				if((GetPlayerController(players[i]) == MAP_CONTROL_USER) and (GetPlayerSlotState(players[i]) == PLAYER_SLOT_STATE_PLAYING)) then
					set player_current_qty = player_current_qty + 1
					call SaveBoolean(hp_hash, pid, hp_isComputer, false)
					call SaveStr(hp_hash, pid, hp_battle_status, default_status_gaming)
	                call TriggerRegisterPlayerSelectionEventBJ( triggerApm , players[i] , true )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_RIGHT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_DOWN )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_UP )
	            else
	            	call SaveBoolean(hp_hash, pid, hp_isComputer, true)
	            	call SaveStr(hp_hash, pid, hp_battle_status, default_status_nil)
	            endif
			set i = i + 1
		endloop
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_ORDER )
	    call TriggerAddAction( triggerApmUnit, function hPlayer.triggerApmUnitActions )
	    return x
	endmethod
	method onDestroy takes nothing returns nothing
    endmethod

	//是否电脑
	public static method isComputer takes player whichPlayer returns boolean
		return LoadBoolean(hp_hash, GetHandleId(whichPlayer), hp_isComputer)
	endmethod

	//设置玩家战斗状态
	public static method setBattleStatus takes player whichPlayer,string status returns nothing
		call SaveStr(hp_hash, GetHandleId(whichPlayer), hp_battle_status, status)
	endmethod
	//获取玩家战斗状态
	public static method getBattleStatus takes player whichPlayer returns string
		return LoadStr(hp_hash, GetHandleId(whichPlayer), hp_battle_status)
	endmethod

	//设置失败
	public static method defeat takes player whichPlayer returns nothing
		call CustomDefeatBJ( whichPlayer, "失败" )
	endmethod

	//设置胜利
	public static method victory takes player whichPlayer returns nothing
		call CustomVictoryBJ( whichPlayer, true, true )
	endmethod

	//设置玩家英雄
	public static method setHero takes player whichPlayer,unit hero returns nothing
		call console.log("playerhero="+GetUnitName(hero))
		call SaveUnitHandle(hp_hash, GetHandleId(whichPlayer), hp_hero, hero)
	endmethod
	//获取玩家英雄
	public static method getHero takes player whichPlayer returns unit
		return LoadUnitHandle(hp_hash, GetHandleId(whichPlayer), hp_hero)
	endmethod

	//获取玩家造成的总伤害
	public static method getDamage takes player whichPlayer returns real
		return LoadReal(hp_hash, GetHandleId(whichPlayer), hp_damage)
	endmethod
	//增加玩家造成的总伤害
	public static method addDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hp_hash, GetHandleId(whichPlayer), hp_damage, getDamage(whichPlayer)+val)
	endmethod

	//获取玩家是受到的总伤害
	public static method getBeDamage takes player whichPlayer returns real
		return LoadReal(hp_hash, GetHandleId(whichPlayer), hp_bedamage)
	endmethod
	//增加玩家受到的总伤害
	public static method addBeDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hp_hash, GetHandleId(whichPlayer), hp_bedamage, getBeDamage(whichPlayer)+val)
	endmethod

	//获取玩家杀敌数
	public static method getKill takes player whichPlayer returns integer
		return LoadInteger(hp_hash, GetHandleId(whichPlayer), hp_kill)
	endmethod
	//增加玩家杀敌数
	public static method addKill takes player whichPlayer,integer val returns nothing
		call SaveInteger(hp_hash, GetHandleId(whichPlayer), hp_kill, getKill(whichPlayer)+val)
	endmethod

	//获取玩家金钱
	public static method getGold takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
	endmethod
	//设置玩家金钱
	public static method setGold takes player whichPlayer,integer gold returns nothing
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold )
	endmethod
	//增加玩家金钱
	public static method addGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	endmethod
	//减少玩家金钱
	public static method subGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(-gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	endmethod

	//设置玩家木材
	public static method setLumber takes player whichPlayer,integer lumber returns nothing
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber )
	endmethod
	//获取玩家木材
	public static method getLumber takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
	endmethod
	//增加玩家木材
	public static method addLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	endmethod
	//减少玩家木材
	public static method subLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(-lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	endmethod

endstruct
