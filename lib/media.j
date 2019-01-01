//单位组
globals
hMedia hmedia
endglobals

struct hMedia

	private static real bgmDelay = 3.00
	public static string array bgmCurrent

	//播放音效
	public static method soundPlay takes sound s returns nothing
	    if (s != null) then
	        call StartSound(s)
	    endif
	endmethod

	//播放音效对某个玩家
	public static method soundPlay2Player takes sound s,player whichPlayer returns nothing
	    if (s != null and GetLocalPlayer()==whichPlayer) then
	        call StartSound(s)
	    endif
	endmethod

	//绑定单位音效
	public static method soundPlay2Unit takes sound s,unit u returns nothing
	    call PlaySoundOnUnitBJ( s, 100, u )
	endmethod

	//绑定点音效
	public static method soundPlay2Loc takes sound s,real x,real y,real z returns nothing
	    call SetSoundPosition( s, x, y, z )
	endmethod

	private static method bgmCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local string txt = htime.getString(t,1)
		local integer i = 0
		call PlayMusic(txt)
		call htime.delTimer(t)
		set t = null
		set i = player_max_qty
		loop
			exitwhen i<=0
				set bgmCurrent[i] = txt
			set i = i-1
		endloop
		set txt = null
	endmethod
	//播放音乐，如果背景音乐无法循环播放，尝试格式工厂转wav再转回mp3
	public static method bgm takes string musicFileName returns nothing
		local timer t = null
		if(musicFileName!=null and musicFileName!="")then
			call StopMusic( true )
			set t = htime.setTimeout(bgmDelay,function thistype.bgmCall)
			call htime.setString(t,1,musicFileName)
			set t = null
		endif
	endmethod

	private static method bgm2PlayerCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local string txt = htime.getString(t,1)
		local player p = htime.getPlayer(t,2)
		if(GetLocalPlayer() == p)then
			set bgmCurrent[GetConvertedPlayerId(p)] = txt
			call PlayMusic(txt)
		endif
		call htime.delTimer(t)
		set t = null
		set txt = null
		set p = null
	endmethod
	//对玩家播放音乐
	public static method bgm2Player takes string musicFileName,player whichPlayer returns nothing
		local timer t = GetExpiredTimer()
		if(musicFileName!=null and musicFileName!="" and whichPlayer != null)then
			if(GetLocalPlayer() == whichPlayer)then
				call StopMusic( true )
				set t = htime.setTimeout(bgmDelay,function thistype.bgm2PlayerCall)
				call htime.setString(t,1,musicFileName)
				call htime.setPlayer(t,2,whichPlayer)
				set t = null
			endif
		endif
	endmethod

	// 停止BGM
	public static method bgmStop takes nothing returns nothing
		call StopMusic( true )
	endmethod
	public static method bgmStop2Player takes player whichPlayer returns nothing
		if(GetLocalPlayer() == whichPlayer)then
			call StopMusic( true )
		endif
	endmethod

endstruct
