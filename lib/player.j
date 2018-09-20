
globals
	
	hPlayer hplayer
	hashtable hash_player = null
	integer hp_isComputer = 10001
	integer hp_apm = 10002
	integer hp_battle_status = 10003
	integer hp_damage = 10005
	integer hp_bedamage = 10006
	integer hp_kill = 10007
	integer hp_selection = 10008
	integer hp_gold = 10009
	integer hp_gold_cost = 10010
	integer hp_lumber = 10011
	integer hp_lumber_cost = 10012
	integer hp_gold_ratio = 10013
	integer hp_lumber_ratio = 10014
	integer hp_exp_ratio = 10015
	integer hp_sell_ratio = 10016
	integer hp_life_source_ratio = 10017
	integer hp_mana_source_ratio = 10017

	integer player_max_qty = 12
	integer player_current_qty = 0
	player array players
	player player_passive = Player(PLAYER_NEUTRAL_PASSIVE)			//中立友好
	player player_aggressive = Player(PLAYER_NEUTRAL_AGGRESSIVE)	//中立敌对
endglobals

struct hPlayer

	static string default_status_gaming = "游戏中"
	static string default_status_nil = "无参与"
	static string default_status_leave = "已离开"

	public static method create takes nothing returns hPlayer
		local hRect x = 0
        set x = hPlayer.allocate()
	    return x
	endmethod

	//index
	public static method index takes player whichPlayer returns integer
		return GetConvertedPlayerId(whichPlayer) 
	endmethod

	//getDandomUnit
	public static method getDandomUnit takes nothing returns unit
		local player p = null
		local integer i = 0
		local integer j = 0
		local player array rannum
		set i = 1
		loop
			exitwhen i>player_max_qty
				if(thistype.getStatus(players[i]) == default_status_gaming)then
					set j = j+1
					set rannum[j] = players[i]
				endif
			set i=i+1
		endloop
		set p = rannum[GetRandomInt(1,j)]
		if(p==null)then
			return null
		endif
		return hhero.getPlayerUnit(p,GetRandomInt(1,hhero.getPlayerUnitQty(p)))
	endmethod

	//apm
	private static method setApm takes player whichPlayer , integer apm returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_apm, apm)
	endmethod
	public static method getApm takes player whichPlayer returns integer
		if(htime.count() > 60) then
			return R2I( I2R(LoadInteger(hash_player, GetHandleId(whichPlayer), hp_apm))  / ( I2R(htime.count()) / 60.00 ))
	    else
	        return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_apm)
	    endif
	endmethod
	private static method addApm takes player whichPlayer returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_apm , LoadInteger(hash_player, GetHandleId(whichPlayer), hp_apm)+1)
	endmethod
	private static method triggerApmActions takes nothing returns nothing
		call addApm(GetTriggerPlayer())
	endmethod
	private static method triggerApmUnitActions takes nothing returns nothing
		call addApm(GetOwningPlayer(GetTriggerUnit()))
	endmethod

	//selection
	private static method triggerSelectionUnitActions takes nothing returns nothing
		call setSelection(hevt.getTriggerPlayer(),hevt.getTriggerUnit())
	endmethod
	private static method triggerDeSelectionUnitActions takes nothing returns nothing
		call setSelection(GetTriggerPlayer(),null)
	endmethod
	private static method setSelection takes player whichPlayer,unit whichUnit returns nothing
		if(whichPlayer!=null)then
			call SaveUnitHandle(hash_player, GetHandleId(whichPlayer), hp_selection, whichUnit)
		endif
	endmethod
	public static method getSelection takes player whichPlayer returns unit
		local unit u = LoadUnitHandle(hash_player, GetHandleId(whichPlayer), hp_selection)
		if(his.death(u))then
			set u = null
			call SaveUnitHandle(hash_player, GetHandleId(whichPlayer), hp_selection, null)
		endif
		return u
	endmethod

	//设置玩家状态
	public static method setStatus takes player whichPlayer,string status returns nothing
		call SaveStr(hash_player, GetHandleId(whichPlayer), hp_battle_status, status)
	endmethod
	//获取玩家状态
	public static method getStatus takes player whichPlayer returns string
		return LoadStr(hash_player, GetHandleId(whichPlayer), hp_battle_status)
	endmethod

	//设置失败
	public static method defeat takes player whichPlayer,string tips returns nothing
		local hFilter filter
		local group g = null
		local unit u = null
		set filter = hFilter.create()
		call filter.isOwnerPlayer(true,whichPlayer)
		set g = hgroup.createByRect(GetEntireMapRect(),function hFilter.get)
		call filter.destroy()
		loop
			exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit( g , u )
	            call RemoveUnit(u)
		endloop
		call GroupClear(g)
		call DestroyGroup(g)
		set g = null
		set u = null
		if(tips == "" or tips == null)then
			set tips = "失败"
		endif
		call CustomDefeatBJ( whichPlayer, tips )
	endmethod

	//设置胜利
	public static method victory takes player whichPlayer returns nothing
		call CustomVictoryBJ( whichPlayer, true, true )
	endmethod

	//获取玩家造成的总伤害
	public static method getDamage takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_damage)
	endmethod
	//增加玩家造成的总伤害
	public static method addDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hash_player, GetHandleId(whichPlayer), hp_damage, getDamage(whichPlayer)+val)
	endmethod

	//获取玩家受到的总伤害
	public static method getBeDamage takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_bedamage)
	endmethod
	//增加玩家受到的总伤害
	public static method addBeDamage takes player whichPlayer,real val returns nothing
		call SaveReal(hash_player, GetHandleId(whichPlayer), hp_bedamage, getBeDamage(whichPlayer)+val)
	endmethod

	//获取玩家杀敌数
	public static method getKill takes player whichPlayer returns integer
		return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_kill)
	endmethod
	//增加玩家杀敌数
	public static method addKill takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_kill, getKill(whichPlayer)+val)
	endmethod


	//获取玩家生命源设定百分比
	public static method getLifeSourceRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_life_source_ratio)
	endmethod
	//设置玩家生命源设定百分比
	public static method setLifeSourceRatio takes player whichPlayer,real val returns nothing
		call SaveReal(hash_player, GetHandleId(whichPlayer), hp_life_source_ratio, val)
	endmethod
	private static method triggerLSRDialog takes nothing returns nothing
		local dialog d = GetClickedDialog()
		local button b = GetClickedButton()
		local player p = LoadPlayerHandle(hash_player,GetHandleId(d),666)
		local real radio = LoadReal(hash_player,GetHandleId(b),666)
		call hmsg.echoTo(p,"已设定生命源触发比例为：|cffffff80"+I2S(R2I(radio))+"%|r",0)
		call setLifeSourceRatio(p,radio)
		call DialogClear( d )
		call DialogDestroy( d )
		call DisableTrigger(GetTriggeringTrigger())
		call DestroyTrigger(GetTriggeringTrigger())
		set p = null
		set d = null
	endmethod
	private static method triggerLSRActions takes nothing returns nothing
		local player p = GetTriggerPlayer()
		local dialog d = null
		local button b = null
		local integer i = 100
		local trigger dtg = null
		set d = DialogCreate()
		call DialogSetMessage( d, "设定少于比例触发生命源恢复" )
		call SavePlayerHandle(hash_player,GetHandleId(d),666,p)
		loop
			exitwhen i<10
				set b = DialogAddButton(d,I2S(i)+"%",0)
				call SaveReal(hash_player,GetHandleId(b),666,I2R(i))
			set i = i-10
		endloop
		set dtg = CreateTrigger()
		call TriggerAddAction(dtg, function thistype.triggerLSRDialog)
		call TriggerRegisterDialogEvent( dtg , d )
		call DialogDisplay( p,d, true )
	endmethod
	//获取玩家魔法源设定百分比
	public static method getManaSourceRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_mana_source_ratio)
	endmethod
	//设置玩家魔法源设定百分比
	public static method setManaSourceRatio takes player whichPlayer,real val returns nothing
		call SaveReal(hash_player, GetHandleId(whichPlayer), hp_mana_source_ratio, val)
	endmethod
	private static method triggerMSRDialog takes nothing returns nothing
		local dialog d = GetClickedDialog()
		local button b = GetClickedButton()
		local player p = LoadPlayerHandle(hash_player,GetHandleId(d),667)
		local real radio = LoadReal(hash_player,GetHandleId(b),667)
		call hmsg.echoTo(p,"已设定魔法源触发比例为：|cffffff80"+I2S(R2I(radio))+"%|r",0)
		call setManaSourceRatio(p,radio)
		call DialogClear( d )
		call DialogDestroy( d )
		call DisableTrigger(GetTriggeringTrigger())
		call DestroyTrigger(GetTriggeringTrigger())
		set p = null
		set d = null
	endmethod
	private static method triggerMSRActions takes nothing returns nothing
		local player p = GetTriggerPlayer()
		local dialog d = null
		local button b = null
		local integer i = 100
		local trigger dtg = null
		set d = DialogCreate()
		call DialogSetMessage( d, "设定少于比例触发魔法源恢复" )
		call SavePlayerHandle(hash_player,GetHandleId(d),667,p)
		loop
			exitwhen i<10
				set b = DialogAddButton(d,I2S(i)+"%",0)
				call SaveReal(hash_player,GetHandleId(b),667,I2R(i))
			set i = i-10
		endloop
		set dtg = CreateTrigger()
		call TriggerAddAction(dtg, function thistype.triggerMSRDialog)
		call TriggerRegisterDialogEvent( dtg , d )
		call DialogDisplay( p,d, true )
	endmethod


	//黄金比率
	private static method diffGoldRatioCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer pid = htime.getInteger(t,1)
		local real diff = htime.getReal(t,1)
		local real old = LoadReal(hash_player, pid, hp_gold_ratio)
		call htime.delTimer(t)
		if(diff!=0)then
			call SaveReal(hash_player, pid, hp_gold_ratio, old+diff)
		endif
	endmethod
	private static method diffGoldRatio takes player whichPlayer,real diff,real during returns nothing
		local integer pid = GetHandleId(whichPlayer)
		local real old = LoadReal(hash_player, pid, hp_gold_ratio)
		local timer t = null
		if(diff!=0)then
			call SaveReal(hash_player, GetHandleId(whichPlayer), hp_gold_ratio, old+diff)
			if(during>0)then
				set t = htime.setTimeout(during,function thistype.diffGoldRatioCall)
				call htime.setInteger(t,1,pid)
				call htime.setReal(t,1,diff)
			endif
		endif
	endmethod
	public static method getGoldRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_gold_ratio)
	endmethod
	public static method setGoldRatio takes player whichPlayer,real val,real during returns nothing
		call diffGoldRatio(whichPlayer,val-getGoldRatio(whichPlayer),during)
	endmethod
	public static method addGoldRatio takes player whichPlayer,real val,real during returns nothing
		call diffGoldRatio(whichPlayer,val,during)
	endmethod
	public static method subGoldRatio takes player whichPlayer,real val,real during returns nothing
		call diffGoldRatio(whichPlayer,-val,during)
	endmethod

	//木头比率
	private static method diffLumberRatioCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer pid = htime.getInteger(t,1)
		local real diff = htime.getReal(t,1)
		local real old = LoadReal(hash_player, pid, hp_lumber_ratio)
		call htime.delTimer(t)
		if(diff!=0)then
			call SaveReal(hash_player, pid, hp_lumber_ratio, old+diff)
		endif
	endmethod
	private static method diffLumberRatio takes player whichPlayer,real diff,real during returns nothing
		local integer pid = GetHandleId(whichPlayer)
		local real old = LoadReal(hash_player, pid, hp_lumber_ratio)
		local timer t = null
		if(diff!=0)then
			call SaveReal(hash_player, GetHandleId(whichPlayer), hp_lumber_ratio, old+diff)
			if(during>0)then
				set t = htime.setTimeout(during,function thistype.diffLumberRatioCall)
				call htime.setInteger(t,1,pid)
				call htime.setReal(t,1,diff)
			endif
		endif
	endmethod
	public static method getLumberRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_lumber_ratio)
	endmethod
	public static method setLumberRatio takes player whichPlayer,real val,real during returns nothing
		call diffLumberRatio(whichPlayer,val-getLumberRatio(whichPlayer),during)
	endmethod
	public static method addLumberRatio takes player whichPlayer,real val,real during returns nothing
		call diffLumberRatio(whichPlayer,val,during)
	endmethod
	public static method subLumberRatio takes player whichPlayer,real val,real during returns nothing
		call diffLumberRatio(whichPlayer,-val,during)
	endmethod


	//经验比率
	private static method diffExpRatioCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer pid = htime.getInteger(t,1)
		local real diff = htime.getReal(t,1)
		local real old = LoadReal(hash_player, pid, hp_exp_ratio)
		call htime.delTimer(t)
		if(diff!=0)then
			call SaveReal(hash_player, pid, hp_exp_ratio, old+diff)
		endif
	endmethod
	private static method diffExpRatio takes player whichPlayer,real diff,real during returns nothing
		local integer pid = GetHandleId(whichPlayer)
		local real old = LoadReal(hash_player, pid, hp_exp_ratio)
		local timer t = null
		if(diff!=0)then
			call SaveReal(hash_player, GetHandleId(whichPlayer), hp_exp_ratio, old+diff)
			if(during>0)then
				set t = htime.setTimeout(during,function thistype.diffExpRatioCall)
				call htime.setInteger(t,1,pid)
				call htime.setReal(t,1,diff)
			endif
		endif
	endmethod
	public static method getExpRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_exp_ratio)
	endmethod
	public static method setExpRatio takes player whichPlayer,real val,real during returns nothing
		call diffExpRatio(whichPlayer,val-getExpRatio(whichPlayer),during)
	endmethod
	public static method addExpRatio takes player whichPlayer,real val,real during returns nothing
		call diffExpRatio(whichPlayer,val,during)
	endmethod
	public static method subExpRatio takes player whichPlayer,real val,real during returns nothing
		call diffExpRatio(whichPlayer,-val,during)
	endmethod


	//物品售卖比率
	private static method diffSellRatioCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer pid = htime.getInteger(t,1)
		local real diff = htime.getReal(t,1)
		local real old = LoadReal(hash_player, pid, hp_sell_ratio)
		call htime.delTimer(t)
		if(diff!=0)then
			call SaveReal(hash_player, pid, hp_sell_ratio, old+diff)
		endif
	endmethod
	private static method diffSellRatio takes player whichPlayer,real diff,real during returns nothing
		local integer pid = GetHandleId(whichPlayer)
		local real old = LoadReal(hash_player, pid, hp_sell_ratio)
		local timer t = null
		if(diff!=0)then
			call SaveReal(hash_player, GetHandleId(whichPlayer), hp_sell_ratio, old+diff)
			if(during>0)then
				set t = htime.setTimeout(during,function thistype.diffSellRatioCall)
				call htime.setInteger(t,1,pid)
				call htime.setReal(t,1,diff)
			endif
		endif
	endmethod
	public static method getSellRatio takes player whichPlayer returns real
		return LoadReal(hash_player, GetHandleId(whichPlayer), hp_sell_ratio)
	endmethod
	public static method setSellRatio takes player whichPlayer,real val,real during returns nothing
		call diffSellRatio(whichPlayer,val-getSellRatio(whichPlayer),during)
	endmethod
	public static method addSellRatio takes player whichPlayer,real val,real during returns nothing
		call diffSellRatio(whichPlayer,val,during)
	endmethod
	public static method subSellRatio takes player whichPlayer,real val,real during returns nothing
		call diffSellRatio(whichPlayer,-val,during)
	endmethod





	//获取玩家金钱
	public static method getGold takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
	endmethod
	//设置玩家金钱
	public static method setGold takes player whichPlayer,integer gold returns nothing
		local integer old = getGold(whichPlayer)
		if(gold-old >=0)then
			call addTotalGold(whichPlayer,gold-old)
		else
			call addTotalGoldCost(whichPlayer,old-gold)
		endif
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold )
	endmethod
	//增加玩家金钱
	public static method addGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	    if(gold>=0)then
	    	call addTotalGold(whichPlayer,gold)
	    else
	    	call addTotalGoldCost(whichPlayer,-gold)
	    endif
	endmethod
	//减少玩家金钱
	public static method subGold takes player whichPlayer,integer gold returns nothing
	    call AdjustPlayerStateBJ(-gold, whichPlayer , PLAYER_STATE_RESOURCE_GOLD )
	    if(gold<=0)then
	    	call addTotalGold(whichPlayer,-gold)
	    else
	    	call addTotalGoldCost(whichPlayer,gold)
	    endif
	endmethod

	//获取玩家总获金量
	public static method getTotalGold takes player whichPlayer returns integer
		return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_gold)
	endmethod
	//增加玩家总获金量
	public static method addTotalGold takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_gold, getTotalGold(whichPlayer)+val)
	endmethod
	//获取玩家总耗金量
	public static method getTotalGoldCost takes player whichPlayer returns integer
		return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_gold_cost)
	endmethod
	//增加玩家总耗金量
	public static method addTotalGoldCost takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_gold_cost, getTotalGoldCost(whichPlayer)+val)
	endmethod





	//获取玩家木材
	public static method getLumber takes player whichPlayer returns integer
	    return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
	endmethod
	//设置玩家木材
	public static method setLumber takes player whichPlayer,integer lumber returns nothing
		local integer old = getLumber(whichPlayer)
		if(lumber-old >=0)then
			call addTotalLumber(whichPlayer,lumber-old)
		else
			call addTotalLumberCost(whichPlayer,old-lumber)
		endif
	    call SetPlayerStateBJ( whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber )
	endmethod
	//增加玩家木材
	public static method addLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	    if(lumber>=0)then
	    	call addTotalLumber(whichPlayer,lumber)
	    else
	    	call addTotalLumberCost(whichPlayer,-lumber)
	    endif
	endmethod
	//减少玩家木材
	public static method subLumber takes player whichPlayer,integer lumber returns nothing
	    call AdjustPlayerStateBJ(-lumber, whichPlayer , PLAYER_STATE_RESOURCE_LUMBER )
	    if(lumber<=0)then
	    	call addTotalLumber(whichPlayer,-lumber)
	    else
	    	call addTotalLumberCost(whichPlayer,lumber)
	    endif
	endmethod

	//获取玩家总获木量
	public static method getTotalLumber takes player whichPlayer returns integer
		return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_lumber)
	endmethod
	//增加玩家总获木量
	public static method addTotalLumber takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_lumber, getTotalLumber(whichPlayer)+val)
	endmethod
	//获取玩家总耗木量
	public static method getTotalLumberCost takes player whichPlayer returns integer
		return LoadInteger(hash_player, GetHandleId(whichPlayer), hp_lumber_cost)
	endmethod
	//增加玩家总耗木量
	public static method addTotalLumberCost takes player whichPlayer,integer val returns nothing
		call SaveInteger(hash_player, GetHandleId(whichPlayer), hp_lumber_cost, getTotalLumberCost(whichPlayer)+val)
	endmethod




	//初始化
	public static method initSet takes nothing returns nothing
		local integer i = 1
		local integer pid = 0
		local trigger triggerApm = CreateTrigger()
		local trigger triggerApmUnit = CreateTrigger()
		local trigger triggerDeSelection = CreateTrigger()
		local trigger triggerLSR = CreateTrigger()
		local trigger triggerMSR = CreateTrigger()
		call TriggerAddAction(triggerApm , function thistype.triggerApmActions)
		call TriggerAddAction(triggerApmUnit , function thistype.triggerApmUnitActions)
		call TriggerAddAction(triggerDeSelection , function thistype.triggerDeSelectionUnitActions)
		call TriggerAddAction(triggerLSR , function thistype.triggerLSRActions)
		call TriggerAddAction(triggerMSR , function thistype.triggerMSRActions)
		loop
			exitwhen i > 16
				set players[i] = Player(i-1)
				set pid = GetHandleId(players[i])
				call SetPlayerHandicapXP( players[i] , 0 )
				call setGoldRatio( players[i],100,0)
				call setLumberRatio( players[i],100,0)
				call setExpRatio( players[i],100,0)
				call setSellRatio( players[i],50,0)
				call setLifeSourceRatio( players[i],50.0)
				call setManaSourceRatio( players[i],50.0)
				call setApm(players[i],0)
				if((GetPlayerController(players[i]) == MAP_CONTROL_USER) and (GetPlayerSlotState(players[i]) == PLAYER_SLOT_STATE_PLAYING)) then
					set player_current_qty = player_current_qty + 1
					call SaveBoolean(hash_player, pid, hp_isComputer, false)
					call SaveStr(hash_player, pid, hp_battle_status, default_status_gaming)
	                call TriggerRegisterPlayerSelectionEventBJ( triggerApm , players[i] , true )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_RIGHT )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_DOWN )
		            call TriggerRegisterPlayerKeyEventBJ( triggerApm , players[i] , bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_UP )
		            call TriggerRegisterPlayerUnitEvent(triggerDeSelection, players[i], EVENT_PLAYER_UNIT_DESELECTED, null)
					call TriggerRegisterPlayerChatEvent( triggerLSR , players[i] , "-lsr" , true)
					call TriggerRegisterPlayerChatEvent( triggerMSR , players[i] , "-msr" , true)
	            else
	            	call SaveBoolean(hash_player, pid, hp_isComputer, true)
	            	call SaveStr(hash_player, pid, hp_battle_status, default_status_nil)
	            endif
			set i = i + 1
		endloop
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
	    call TriggerRegisterAnyUnitEventBJ( triggerApmUnit, EVENT_PLAYER_UNIT_ISSUED_ORDER )
	    call TriggerAddAction( triggerApmUnit, function thistype.triggerApmUnitActions )
		call hevt.onSelectionTriple(null,function thistype.triggerSelectionUnitActions)
	endmethod


endstruct
