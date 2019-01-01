
//载入 hJass
#include "hJass.j"//实际路径以本地为准，此处例子为同一目录

//test hunzsig的测试脚本
#include "hTest.j"

//载入 房间音乐
function hBgm takes string s returns nothing
	local string uri = "Sound\\Music\\mp3Music\\SadMystery.mp3"	//这个路径你可以播放默认的音乐（在F5）也可以播放F12导入的音乐
	call SetMapDescription(s)
	call PlayMusic(uri)
endfunction
#define SetMapDescription(s) hBgm(s)

library Main initializer init needs hJass

	//预读
	private function preread takes nothing returns nothing
	    local integer i = 0
	    local integer total = 3
	    local integer array prereads
	    local unit array prereadUnits

	    set prereads[1] = 'H00B'
	    set prereads[2] = 'n00F'
	    set prereads[3] = 'E000'
	    
	    set i = 1
	    loop
	        exitwhen i>total
	            set prereadUnits[i] = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), prereads[i], GetRectCenter(GetPlayableMapRect()), bj_UNIT_FACING)
	            call hattr.regAllAttrSkill(prereadUnits[i])
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
		
		call hTest.run()

	endfunction

	private function init takes nothing returns nothing
		local trigger startTrigger = null
		//预读
		call preread()
		//镜头模式
		call hcamera.setModel("zoomin")
		//属性 - 硬直条
		call hattrUnit.punishTtgIsOpen(false)
		call hattrUnit.punishTtgIsOnlyHero(false)
		call hattrUnit.punishTtgHeight(250.00)
		//迷雾
		call FogEnable( true )
		//阴影
		call FogMaskEnable( true )
		//开启日志
		call hconsole.open(true)
		//开始触发
		set startTrigger = CreateTrigger()
	    call TriggerRegisterTimerEventSingle( startTrigger, 0.01 )
	    call TriggerAddAction(startTrigger, function start)
		set startTrigger = null
    endfunction

endlibrary
//最后一行必须留空请勿修改
