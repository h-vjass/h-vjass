/*
 * 同步library，所有需要等待这一个方法的函数，都要写在，这里
 * 等待 不能写在 struct 内，会使进程强行结束
 * 已下函数只允许写在hMain的 function 内
 */

type MovieDialogue extends string array[10] //电影对白 不算上0下标 最大支持10句

library hSync initializer init

    /**
	 * 对势力播放电影
	 */
	public function moive2force takes force whichForce,unit speaker,MovieDialogue dia returns nothing
		local integer i = 0
		local real during = 0
        call CinematicModeBJ( true, whichForce )
		call ForceCinematicSubtitles( true )
		set i = 1
	    loop
	        exitwhen i > 10
	        	if( dia[i] == null or dia[i] == "" ) then
					call DoNothing() YDNL exitwhen true
	        	else
		        	set during = I2R(StringLength(dia[i]))*0.03 + 3.00
	    			call TransmissionFromUnitWithNameBJ( whichForce , speaker , GetUnitName(speaker) , null , dia[i] , bj_TIMETYPE_SET, during , true )
	        	endif
	        set i = i + 1
	    endloop
        call CinematicModeBJ( false, whichForce )
	endfunction

	/**
	 * 对玩家播放电影
	 */
	public function moive2Player takes player whichPlayer,unit speaker,MovieDialogue dia returns nothing
		local integer i = 0
		local real during = 0
		call CinematicModeBJ( true, bj_FORCE_PLAYER[GetPlayerId(whichPlayer)] )
		call ForceCinematicSubtitles( true )
		set i = 1
	    loop
	        exitwhen i > 10
	        	if( dia[i] == null or dia[i] == "" ) then
					call DoNothing() YDNL exitwhen true
	        	else
		        	set during = I2R(StringLength(dia[i]))*0.03 + 3.00
	    			call TransmissionFromUnitWithNameBJ( bj_FORCE_PLAYER[GetPlayerId(whichPlayer)] , speaker , GetUnitName(speaker) , null , dia[i] , bj_TIMETYPE_SET, during , true )
	        	endif
	        set i = i + 1
	    endloop
		call CinematicModeBJ( false, bj_FORCE_PLAYER[GetPlayerId(whichPlayer)] )
	endfunction

	private function init takes nothing returns nothing
		//
	endfunction
    
endlibrary
//最后一行必须留空请勿修改
