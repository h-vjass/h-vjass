
//载入 lib
#include "lib/abstract.j"

library hJass initializer init

	private function init takes nothing returns nothing
		//系统初始化,请勿在不了解的情况下轻易修改
		set his = hIs.create()
		set htime = hTime.create()
		set hmath = hMath.create()
		set hconsole = hConsole.create()
		set hmedia = hMedia.create()
		set hcamera = hCamera.create()
		set haward = hAward.create()
		set hevt = hEvt.create()
		set hattr = hAttr.create()
		set hattrExt = hAttrExt.create()
		set hattrEffect = hAttrEffect.create()
		set hattrNatural = hAttrNatural.create()
		set hattrHunt = hAttrHunt.create()
		set hattrUnit = hAttrUnit.create()
		set hmb = hMultiboard.create()
		set heffect = hEffect.create()
		set hrect = hRect.create()
		set hunit = hUnit.create()
		set hgroup = hGroup.create()
		set hmsg = hMsg.create()
		set hplayer = hPlayer.create()
		set hweather = hWeather.create()
		set hability = hAbility.create()
		set hitem = hItem.create()
		//initset
		call hattrUnit.initSet()
		call hmb.initSet()
    endfunction

endlibrary
//最后一行必须留空请勿修改
