
library hSys initializer init

	private function init takes nothing returns nothing
		//struct
		set is = hIs.create()
		set time = hTime.create()
		set math = hMath.create()
		set console = hConsole.create()
		set media = hMedia.create()
		set camera = hCamera.create()
		set heffect = hEffect.create()
		set hrect = hRect.create()
		set hunit = hUnit.create()
		set hgroup = hGroup.create()
		set hmsg = hMsg.create()
		set hplayer = hPlayer.create()
	endfunction

endlibrary
