
globals
    hConsole hconsole = 0
endglobals

struct hConsole
	
	private boolean status = false
	private string color_log = "ffffff"
	private string color_error = "e04240"
	private string color_info = "98f5ff"
	private string color_warning = "ffff00"

	//配置log
	public method open takes boolean s returns nothing
		set this.status = s
		if(status == true)then
			call DisplayTextToForce( GetPlayersAll(), "[hJass]系统log已于hSys(lib/system.j)开启" )
		endif
	endmethod
	//设置log颜色
	public method setColor takes string log,string info,string warning,string error returns nothing
		if(StringLength(log)==6)then
			set this.color_log = log
		endif
		if(StringLength(info)==6)then
			set this.color_info = info
		endif
		if(StringLength(warning)==6)then
			set this.color_warning = warning
		endif
		if(StringLength(error)==6)then
			set this.color_error = error
		endif
	endmethod

	//! textmacro hConsoleEcho takes FNAME
	public method $FNAME$ takes string msg returns nothing
		if(this.status) then
			set msg = "|cff"+this.color_$FNAME$+"[log]"+msg+"|r"
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endmethod
	//! endtextmacro

	//! runtextmacro hConsoleEcho("log")
	//! runtextmacro hConsoleEcho("info")
	//! runtextmacro hConsoleEcho("warning")
	//! runtextmacro hConsoleEcho("error")

endstruct
