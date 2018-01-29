
//载入 lib
#include "lib/abstract.j"

library hJass initializer init

	private function init takes nothing returns nothing
		//系统初始化,请勿在不了解的情况下轻易修改
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
    endfunction

endlibrary
//最后一行必须留空请勿修改
