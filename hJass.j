
//载入 lib
#include "lib/abstract.j"

//test
#include "hTest.j"

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
	            call attr.regAllAttrSkill(prereadUnits[i])
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
		//系统初始化
		set is = hIs.create()
		set time = hTime.create()
		set math = hMath.create()
		set console = hConsole.create()
		set media = hMedia.create()
		set camera = hCamera.create()
		set award = hAward.create()
		set evt = hEvt.create()
		set attr = hAttr.create()
		set attrExt = hAttrExt.create()
		set attrEffect = hAttrEffect.create()
		set attrNatural = hAttrNatural.create()
		set attrHunt = hAttrHunt.create()
		set attrUnit = hAttrUnit.create()
		set hmb = hMultiboard.create()

		set heffect = hEffect.create()
		set hrect = hRect.create()
		set hunit = hUnit.create()
		set hgroup = hGroup.create()
		set hmsg = hMsg.create()
		set hplayer = hPlayer.create()
		set hweather = hWeather.create()
		set hability = hAbility.create()
		//initset
		call attrUnit.initSet()
		call hmb.initSet()

		//预读
		call preread()
		//镜头模式
		call camera.setModel("zoomin")
		//属性 - 硬直条
		call attrUnit.punishTtgIsOpen(false)
		call attrUnit.punishTtgIsOnlyHero(false)
		call attrUnit.punishTtgHeight(250.00)
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
