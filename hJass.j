
//载入 lib功能文件
#include "lib/abstract.j"

//载入 主游戏流程文件
//#include "schedule/abstract.j"

//载入 房间音乐
function hBgm takes string s returns nothing
	local string uri = "Sound\\Music\\mp3Music\\SadMystery.mp3"	//这个路径你可以播放默认的音乐（在F5）也可以播放F12导入的音乐
	call SetMapDescription(s)
	call PlayMusic(uri)
endfunction
#define SetMapDescription(s) hBgm(s)

library hJass initializer init

	//预读
	private function preread takes nothing returns nothing
	    local integer i = 0
	    local integer total = 1
	    local integer array prereads
	    local unit array prereadUnits

	    set prereads[1] = 'H009'
	    
	    set i = 1
	    loop
	        exitwhen i>total
	            set prereadUnits[i] = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), prereads[i], GetRectCenter(GetPlayableMapRect()), bj_UNIT_FACING)
	            //call attribute_initAllSkill(prereadUnits[i])
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

	private function init takes nothing returns nothing
		//预读
		call preread()
		//迷雾
		call FogEnable( true )
		//阴影
		call FogMaskEnable( true )
	endfunction

endlibrary

//最后一行必须留空请勿修改
