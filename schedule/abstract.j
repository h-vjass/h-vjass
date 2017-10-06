globals
	/* APM */
	trigger Trigger_Apm = null
	trigger Trigger_SuccessFlag = null
	trigger Trigger_FailFlag = null
	trigger Trigger_BeAttacked = null

	/* 游戏模式 */
	integer GameModelMaxLv = 0
	timer GameModelTimer = null
	timerdialog GameModelTimerDialog = null
	button array GameModelButtons
	string array GameModelTitle

	integer CurrentGameModel = 0
	string CurrentGameTitle = ""
	integer CurrentGameModelMoney = 0
	integer CurrentGameModelLumber = 0
	real CurrentGameModelCycle = 0
endglobals

/* 管理器：管理所有模式的初始化和进度 */
library schedule requires hAward
	
	/* your code */
	private function mySchedule takes nothing returns nothing

	endfunction

	/* Model */
	private function selectGameModel takes integer model returns nothing
		local integer i = 0
		local integer array GameModelMoneys
		local integer array GameModelLumbers
		local real array GameModelCycles

	    set GameModelMoneys[1] = 150
	    set GameModelMoneys[2] = 150
	    set GameModelMoneys[3] = 150

	    set GameModelLumbers[1] = 0
	    set GameModelLumbers[2] = 0
	    set GameModelLumbers[3] = 0

	    set GameModelCycles[1] = 40
	    set GameModelCycles[2] = 60
	    set GameModelCycles[3] = 30

		set CurrentGameModel = model
		set CurrentGameTitle = GameModelTitle[CurrentGameModel]
		set CurrentGameModelMoney = GameModelMoneys[CurrentGameModel]
		set CurrentGameModelCycle = GameModelCycles[CurrentGameModel]
		//提示开始
        call hMsg_print("|cffffff00" + CurrentGameTitle + "！开始！|r")
        //删除对话框
        call hTimer_delTimer( GameModelTimer , GameModelTimerDialog )
        //初始资源
        set i = 1
        loop
            exitwhen i > player_max_qty
            	call SetPlayerHandicapXP( players[i] , 0 )
	            if (hPlayer_isComputer(players[i]) == false) then
	                call SetPlayerStateBJ( players[i], PLAYER_STATE_RESOURCE_GOLD,  GameModelMoneys[CurrentGameModel] )
	                call SetPlayerStateBJ( players[i], PLAYER_STATE_RESOURCE_LUMBER,  GameModelLumbers[CurrentGameModel] )
	            else
	            	call SetPlayerStateBJ( players[i], PLAYER_STATE_RESOURCE_GOLD,  GameModelMoneys[CurrentGameModel]*2 )
	            	call SetPlayerStateBJ( players[i], PLAYER_STATE_RESOURCE_LUMBER,  GameModelLumbers[CurrentGameModel]*2 )
	            endif
            set i = i + 1
        endloop
		//模式开始
		call mySchedule()
	endfunction

	private function TriggerGameModelActions takes nothing returns nothing
	    local integer i = 1
	    loop
	        exitwhen i > GameModelMaxLv
	        if (GetClickedButtonBJ() == GameModelButtons[i]) then
		        call selectGameModel(i)
	            call DoNothing() YDNL exitwhen true//(  )
	        endif
	        set i = i + 1
	    endloop
	endfunction

	private function scheduleAbortLose takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > player_max_qty
            	call hPlayer_defeat(players[i])
            set i = i + 1
        endloop
    endfunction
	public function scheduleAbort takes nothing returns nothing
        call CinematicModeBJ( true,  GetPlayersAll() )
        call ForceCinematicSubtitles( true )
        call TransmissionFromUnitWithNameBJ(  GetPlayersAll() , null, "游戏终止" , null, "没有选择模式，游戏已结束！" , bj_TIMETYPE_SET, 5.00, false )
        call hTimer_setTimeout(3.00,function scheduleAbortLose)
    endfunction

	public function start takes nothing returns nothing
		local integer i
		local trigger triggerGameModel = CreateTrigger()
		local dialog dialogGameModel = DialogCreate()

		//游戏模式
		set GameModelMaxLv = 1
		set GameModelTitle[1] = "模式1"

		if( GameModelMaxLv == 1 )then	//如果只有一种模式，立刻开始
        	call selectGameModel(1)
	    elseif( GameModelMaxLv > 1 )then	//如果多种模式，选择模式
	    	call hMsg_print(" |cffffff00第 1 位玩家开始选择游戏模式...|r")
	    	call DialogSetMessage( dialogGameModel , "游戏模式" )
		    call TriggerRegisterDialogEvent( triggerGameModel, dialogGameModel )
		    call TriggerAddAction(triggerGameModel, function TriggerGameModelActions)
	        //游戏模式
	    	set i = 1
		    loop
		        exitwhen i > GameModelMaxLv
		        call DialogAddButtonBJ( dialogGameModel , GameModelTitle[i] )
		        set GameModelButtons[i] = GetLastCreatedButtonBJ()
		        set i = i + 1
		    endloop
		    set i = 1
		    loop
		        exitwhen i > player_max_qty
		        if(hPlayer_isComputer(players[i]) == false) then
		            call DialogDisplayBJ( true, dialogGameModel , players[i] )
		            call DoNothing() YDNL exitwhen true//(  )
		        else
		        endif
		        set i = i + 1
		    endloop
		    set GameModelTimer = hTimer_setTimeout( 20.00, function scheduleAbort )
		    set GameModelTimerDialog = hTimer_setDialog( GameModelTimer , "正在选择游戏模式" )
	    endif

	endfunction

endlibrary
