
library hSys initializer init

	/**
	 * 绑定单位音效
	 */
	public function soundPlay takes sound s,unit u returns nothing
	    call PlaySoundOnUnitBJ( s, 100, u )
	endfunction

	/**
	 * 创建天气
	 */
	public function createWeather takes rect whichRect , integer whichWeather returns weathereffect
		local weathereffect w = AddWeatherEffectSaveLast( whichRect , whichWeather )
		call EnableWeatherEffect( w , true )
		return w
	endfunction

	/**
	 * 对玩家组播放电影
	 */
	public function moive takes unit speaker,force toForce returns nothing
		/*
		local integer i = 0
		local real during = 0
		set i = 1
	    loop
	        exitwhen i > Moive_Msg_Length
	        	if( Moive_Msg[i] == "" ) then
					call DoNothing() YDNL exitwhen true
	        	else
		        	set during = I2R(StringLength(Moive_Msg[i]))*0.03 + 3.00
	    			call TransmissionFromUnitWithNameBJ( toForce , speaker , GetUnitName(speaker) , null , Moive_Msg[i] , bj_TIMETYPE_SET, during , true )
	        	endif
	        set i = i + 1
	    endloop
	    */
	endfunction

	/**
	 * 发布任务（左边）
	 */
	public function setMissionLeft takes string tit,string con,string icon returns nothing
		if( tit=="" or con=="" or icon=="" )then
			return
		endif
		call CreateQuestBJ( bj_QUESTTYPE_REQ_DISCOVERED,tit,con,icon)
		call FlashQuestDialogButton()
	endfunction

	/**
	 * 发布任务（右边）
	 */
	public function setMissionRight takes string tit,string con,string icon returns nothing
		if( tit=="" or con=="" or icon=="" )then
			return
		endif
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED,tit,con,icon)
		call FlashQuestDialogButton()
	endfunction

	private function init takes nothing returns nothing
		//struct
		set is = hIs.create()
		set time = hTime.create()
		set heffect = hEffect.create()
		set math = hMath.create()
		set console = hConsole.create()
		set hrect = hRect.create()
	endfunction

endlibrary
