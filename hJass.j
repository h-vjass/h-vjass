
//载入 struct
#include "struct/abstract.j"

//载入 lib
#include "lib/abstract.j"

//载入 主游戏流程
//#include "schedule/abstract.j"

//载入 房间音乐
function hBgm takes string s returns nothing
	local string uri = "Sound\\Music\\mp3Music\\SadMystery.mp3"	//这个路径你可以播放默认的音乐（在F5）也可以播放F12导入的音乐
	call SetMapDescription(s)
	call PlayMusic(uri)
endfunction
#define SetMapDescription(s) hBgm(s)

library hJass initializer init needs hmb //hmb | schedule

	//预读
	private function preread takes nothing returns nothing
	    local integer i = 0
	    local integer total = 1
	    local integer array prereads
	    local unit array prereadUnits

	    set prereads[1] = 'H00B'
	    set prereads[2] = 'n00F'
	    
	    set i = 1
	    loop
	        exitwhen i>total
	            set prereadUnits[i] = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), prereads[i], GetRectCenter(GetPlayableMapRect()), bj_UNIT_FACING)
	            call hAttrUnit_regAllAttrSkill(prereadUnits[i])
	        set i = i+1
	    endloop
	    call PolledWait(0.00)
	    set i = 1
	    loop
	        exitwhen i>total
	            call RemoveUnit(prereadUnits[i])
	        set i = i+1
	    endloop
	endfunction

	//游戏开始0秒
	private function start takes nothing returns nothing
		local unit u = null
		local unit u2 = null
		local rect r = hrect.createInLoc(0,0,3000,1500)
		//TODO TEST
		set u = hunit.createUnit(players[1],'H00B',Location(0,0))
		call hAttrExt_addHemophagia(u,25,0)
		call hAttrExt_addSplit(u,50,0)
		call hAttrExt_addHuntRebound(u,50,0)
		call hAttrExt_addCure(u,50,0)
		call hAttrExt_addAvoid(u,80,30)
		call hPlayer_setHero(players[1],u)

		set u2 = hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call SetUnitVertexColor( u2, 100, 45, 50, 255 )

		/*
		call hunit.createUnits(10,Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,900))
		call PanCameraToTimedLocForPlayer( players[1] , Location(0,0), 0 )
		*/

		call hAttrExt_addAvoid(u2,50,0)
		call hAttrExt_addAim(u2,100,15)

		//rect
		//call hrect.lockByRect(r,"square",0)
		call hrect.lockByUnit(u2,"circle",500,500,0)
	endfunction

	private function init takes nothing returns nothing
		local trigger startTrigger = null
		//预读
		call preread()
		//属性 - 硬直条
		call hAttrUnit_punishTtgIsOpen(true)
		call hAttrUnit_punishTtgIsOnlyHero(false)
		call hAttrUnit_punishTtgHeight(250.00)
		//迷雾
		call FogEnable( true )
		//阴影
		call FogMaskEnable( true )
		//开启日志
		call console.open(true)
		//开始触发
		set startTrigger = CreateTrigger()
	    call TriggerRegisterTimerEventSingle( startTrigger, 0.00 )
	    call TriggerAddAction(startTrigger, function start)
    endfunction

endlibrary
//最后一行必须留空请勿修改
