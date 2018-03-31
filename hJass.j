
//载入 lib
#include "lib/abstract.j"

library hJass initializer init

	private function init takes nothing returns nothing
		//*请勿在不了解的情况下轻易修改
		//哈希表初始化
		call FlushParentHashtable( hash_ability )
		call FlushParentHashtable( hash_skill )
		call FlushParentHashtable( hash_attr )
		call FlushParentHashtable( hash_attr_effect)
		call FlushParentHashtable( hash_attr_natural )
		call FlushParentHashtable( hash_attr_unit )
		call FlushParentHashtable( hash_trigger_register )
		call FlushParentHashtable( hash_trigger )
		call FlushParentHashtable( hash_item )
		call FlushParentHashtable( hash_hmsg )
		call FlushParentHashtable( hash_player )
		call FlushParentHashtable( hash_hrect )
		call FlushParentHashtable( hash_unit )
		call FlushParentHashtable( hash_time )
		call FlushParentHashtable( hash_weather )
		set hash_ability = InitHashtable()
		set hash_skill = InitHashtable()
		set hash_attr = InitHashtable()
		set hash_attr_effect = InitHashtable()
		set hash_attr_natural = InitHashtable()
		set hash_attr_unit = InitHashtable()
		set hash_trigger_register = InitHashtable()
		set hash_trigger = InitHashtable()
		set hash_item = InitHashtable()
		set hash_hmsg = InitHashtable()
		set hash_player = InitHashtable()
		set hash_hrect = InitHashtable()
		set hash_unit = InitHashtable()
		set hash_time = InitHashtable()
		set hash_weather = InitHashtable()
		//系统初始化
		set his = hIs.create()
		set htime = hTime.create()
		set hmath = hMath.create()
		set hxy = hXY.create()
		set hconsole = hConsole.create()
		set hmedia = hMedia.create()
		set hcamera = hCamera.create()
		set haward = hAward.create()
		set hevt = hEvt.create()
		set hattr = hAttr.create()
		set hattrEffect = hAttrEffect.create()
		set hattrNatural = hAttrNatural.create()
		set hattrHunt = hAttrHunt.create()
		set hattrUnit = hAttrUnit.create()
		set hmb = hMultiboard.create()
		set heffect = hEffect.create()
		set hlightning = hLightning.create()
		set hrect = hRect.create()
		set hunit = hUnit.create()
		set hgroup = hGroup.create()
		set hmsg = hMsg.create()
		set hplayer = hPlayer.create()
		set hweather = hWeather.create()
		set hability = hAbility.create()
		set hskill = hSkill.create()
		set hitem = hItem.create()
		//initset
		call hattrUnit.initSet()
		call hmb.initSet()
    endfunction

endlibrary
//最后一行必须留空请勿修改
