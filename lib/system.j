
library hSys initializer init

	globals

		private boolean log_status = false
		private string log_color = ""
 
 		private integer clock_h = 0
 		private integer clock_m = 0
 		private integer clock_i = 0
		private integer clock_count = 0

	endglobals

	//配置log
	public function open takes boolean status returns nothing
		set log_status = status
		if(status == true)then
			call DisplayTextToForce( GetPlayersAll(), "[hJass]系统log已于hSys(lib/system.j)开启" )
		endif
	endfunction
	//设置log颜色
	public function setColor takes string color returns nothing
		set log_color = color
	endfunction
	//打印log
	public function log takes string msg returns nothing
		if(log_status) then
			set msg = "[log]"+msg
			if(StringLength(log_color)==6)then
				set msg = "|cff"+log_color+msg+"|r"
			endif
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endfunction

	//系统时间
	private function clock takes nothing returns nothing
		set clock_count = clock_count + 1
	    set clock_i = clock_i + 1
	    if (clock_i >= 60) then
	        set clock_m = clock_m + 1
	        set clock_i = 0
	        if (clock_m >= 60) then
	            set clock_h = clock_h + 1
	            set clock_m = 0
	        endif
	    endif
	endfunction
	//获取时
	public function hour takes nothing returns integer
		return clock_h
	endfunction
	//获取分
	public function min takes nothing returns integer
		return clock_m
	endfunction
	//获取秒
	public function sec takes nothing returns integer
		return clock_i
	endfunction
	//获取累计秒
	public function count takes nothing returns integer
		return clock_count
	endfunction

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
	 * 设定中心点（X,Y）创建一个长width宽height的矩形区域
	 */
	public function createRect takes real locX , real locY , real width , real height returns rect
		local real startX = locX-(width * 0.5)
		local real startY = locY-(height * 0.5)
		local real endX = locX+(width * 0.5)
		local real endY = locY+(height * 0.5)
		return Rect( startX , startY , endX , endY )
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
		//设置log为true后自动打印所有log方法
		call open(true)
		call setColor("ff0000")
		call TimerStart( CreateTimer() , 1.00 , true, function clock )
	endfunction

endlibrary
