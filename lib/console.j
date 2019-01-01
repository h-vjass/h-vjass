
globals
    hConsole hconsole
endglobals

struct hConsole
	
	private boolean isDebug = false
	private boolean isDzapi = false
	private string color_log = "ffffff"
	private string color_error = "e04240"
	private string color_info = "98f5ff"
	private string color_warning = "ffff00"

	//是否开启debug
	public method openDebug takes boolean s returns nothing
		set this.isDebug = s
		if(isDebug == true)then
			call DisplayTextToForce( GetPlayersAll(), "[hJass]Debug已于(lib/console.j)开启" )
		endif
	endmethod
	public method isOpenDebug takes nothing returns boolean
		return this.isDebug
	endmethod

	//是否开启Dzapi
	public method openDzapi takes boolean s returns nothing
		set this.isDzapi = s
		if(isDzapi == true and this.isDebug == true)then
			call DisplayTextToForce( GetPlayersAll(), "[hJass]Dzapi已于(lib/console.j)开启" )
		endif
	endmethod
	public method isOpenDzapi takes nothing returns boolean
		return this.isDzapi
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

	public method log takes string msg returns nothing
		if(this.isDebug) then
			set msg = "|cff"+this.color_log+"[log]"+msg+"|r"
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endmethod

	public method error takes string msg returns nothing
		if(this.isDebug) then
			set msg = "|cff"+this.color_error+"[log]"+msg+"|r"
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endmethod

	public method info takes string msg returns nothing
		if(this.isDebug) then
			set msg = "|cff"+this.color_info+"[log]"+msg+"|r"
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endmethod

	public method warning takes string msg returns nothing
		if(this.isDebug) then
			set msg = "|cff"+this.color_warning+"[log]"+msg+"|r"
	    	call DisplayTextToForce( GetPlayersAll(), msg )
	    endif
	endmethod

endstruct

<?
	a=1
?>