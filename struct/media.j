/* 单位组 */
globals
hMedia media = 0
endglobals

type MediaDialogue extends string array[10] //电影对白最大支持10句

struct hMedia

	/**
	 * 绑定单位音效
	 */
	public static method sound2Unit takes sound s,unit u returns nothing
	    call PlaySoundOnUnitBJ( s, 100, u )
	endmethod

	/**
	 * 对势力播放电影
	 */
	public static method moive2force takes force whichForce,unit speaker,MediaDialogue dia returns nothing
		local integer i = 0
		local real during = 0
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
	endmethod

	/**
	 * 对玩家播放电影
	 */
	public static method moive2Player takes player whichPlayer,unit speaker,MediaDialogue dia returns nothing
		local integer i = 0
		local real during = 0
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
	endmethod
	
endstruct
