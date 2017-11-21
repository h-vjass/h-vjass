
//载入 struct
#include "struct/abstract.j"

//载入 lib
#include "lib/abstract.j"

//test
#include "lib/test.j"

//载入 主游戏流程
//#include "schedule/abstract.j"

//载入 房间音乐
function hBgm takes string s returns nothing
	local string uri = "Sound\\Music\\mp3Music\\SadMystery.mp3"	//这个路径你可以播放默认的音乐（在F5）也可以播放F12导入的音乐
	call SetMapDescription(s)
	call PlayMusic(uri)
endfunction
#define SetMapDescription(s) hBgm(s)

library hJass initializer init needs hTest //hTest | schedule

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
	            call hAttr_regAllAttrSkill(prereadUnits[i])
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
		
		//测试
		call hTest_run()

	endfunction

	private function init takes nothing returns nothing
		local trigger startTrigger = null
		//预读
		call preread()
		//镜头模式
		call camera.setModel("zoomin")
		//属性 - 硬直条
		call hAttrUnit_punishTtgIsOpen(false)
		//call hAttrUnit_punishTtgIsOnlyHero(false)
		//call hAttrUnit_punishTtgHeight(250.00)
		//迷雾
		call FogEnable( true )
		//阴影
		call FogMaskEnable( true )
		//开启日志
		call console.open(true)
		//开始触发
		set startTrigger = CreateTrigger()
	    call TriggerRegisterTimerEventSingle( startTrigger, 0.01 )
	    call TriggerAddAction(startTrigger, function start)
    endfunction

endlibrary
//最后一行必须留空请勿修改
