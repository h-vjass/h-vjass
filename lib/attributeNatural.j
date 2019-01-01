/** 
 自然属性 
 */
globals
	hAttrNatural hattrNatural
	hashtable hash_attr_natural = null
endglobals

struct hAttrNatural

	private static integer AF_EFFECT_NATURAL_UNIT = 1000
	
	private static integer AF_FIRE = 7001
	private static integer AF_SOIL = 7002
	private static integer AF_WATER = 7003
	private static integer AF_ICE = 7004
	private static integer AF_WIND = 7005
	private static integer AF_LIGHT = 7006
	private static integer AF_DARK = 7007
	private static integer AF_WOOD = 7008
	private static integer AF_THUNDER = 7009
	private static integer AF_POISON = 7010
	private static integer AF_GHOST = 7011
	private static integer AF_METAL = 7012
	private static integer AF_DRAGON = 7013
	private static integer AF_FIRE_OPPOSE = 7014
	private static integer AF_SOIL_OPPOSE = 7015
	private static integer AF_WATER_OPPOSE = 7016
	private static integer AF_ICE_OPPOSE = 7017
	private static integer AF_WIND_OPPOSE = 7018
	private static integer AF_LIGHT_OPPOSE = 7019
	private static integer AF_DARK_OPPOSE = 7020
	private static integer AF_WOOD_OPPOSE = 7021
	private static integer AF_THUNDER_OPPOSE = 7022
	private static integer AF_POISON_OPPOSE = 7023
	private static integer AF_GHOST_OPPOSE = 7024
	private static integer AF_METAL_OPPOSE = 7025
	private static integer AF_DRAGON_OPPOSE = 7026

	static method create takes nothing returns hAttrNatural
        local hAttrNatural x = 0
        set x = hAttrNatural.allocate()
        return x
    endmethod

	//验证单位是否初始化过参数
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr_natural , uhid , AF_EFFECT_NATURAL_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash_attr_natural , uhid , AF_EFFECT_NATURAL_UNIT , uhid )

				call SaveReal( hash_attr_natural , uhid , AF_FIRE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_SOIL , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WATER , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_ICE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WIND , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_LIGHT , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_DARK , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WOOD , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_THUNDER , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_POISON , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_GHOST , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_METAL , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_DRAGON , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_FIRE_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_SOIL_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WATER_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_ICE_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WIND_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_LIGHT_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_DARK_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_WOOD_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_THUNDER_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_POISON_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_GHOST_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_METAL_OPPOSE , 0 )
				call SaveReal( hash_attr_natural , uhid , AF_DRAGON_OPPOSE , 0 )

			return true
		endif
		return false
	endmethod

	//设定属性(即时/计时)
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if(diff != 0)then
			call SaveReal( hash_attr_natural , uhid , flag , LoadReal( hash_attr_natural , uhid , flag ) + diff )
		endif
	endmethod

	private static method setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag =  htime.getInteger(t,1)
		local unit whichUnit =  htime.getUnit(t,2)
		local real diff =  htime.getReal(t,3)
		call htime.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
		set t = null
		set whichUnit = null
	endmethod

	private static method setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t =  htime.setTimeout( during , function thistype.setAttrDuring )
			call htime.setInteger(t,1,flag)
			call htime.setUnit(t,2,whichUnit)
			call htime.setReal(t,3, -diff )
			set t = null
		endif
	endmethod

	private static method getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash_attr_natural , GetHandleId(whichUnit) , flag )
	endmethod




	// 自然属性[fire]
	public static method getFire takes unit whichUnit returns real
	return getAttr( AF_FIRE , whichUnit )
	endmethod
	public static method addFire takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE , whichUnit , value , during )
	endmethod
	public static method subFire takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE , whichUnit , -value , during )
	endmethod
	public static method setFire takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE , whichUnit , value - getFire(whichUnit) , during )
	endmethod
	// 自然属性[soil]
	public static method getSoil takes unit whichUnit returns real
	return getAttr( AF_SOIL , whichUnit )
	endmethod
	public static method addSoil takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL , whichUnit , value , during )
	endmethod
	public static method subSoil takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL , whichUnit , -value , during )
	endmethod
	public static method setSoil takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL , whichUnit , value - getSoil(whichUnit) , during )
	endmethod
	// 自然属性[water]
	public static method getWater takes unit whichUnit returns real
	return getAttr( AF_WATER , whichUnit )
	endmethod
	public static method addWater takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER , whichUnit , value , during )
	endmethod
	public static method subWater takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER , whichUnit , -value , during )
	endmethod
	public static method setWater takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER , whichUnit , value - getWater(whichUnit) , during )
	endmethod
	// 自然属性[ice]
	public static method getIce takes unit whichUnit returns real
	return getAttr( AF_ICE , whichUnit )
	endmethod
	public static method addIce takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE , whichUnit , value , during )
	endmethod
	public static method subIce takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE , whichUnit , -value , during )
	endmethod
	public static method setIce takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE , whichUnit , value - getIce(whichUnit) , during )
	endmethod
	// 自然属性[wind]
	public static method getWind takes unit whichUnit returns real
	return getAttr( AF_WIND , whichUnit )
	endmethod
	public static method addWind takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND , whichUnit , value , during )
	endmethod
	public static method subWind takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND , whichUnit , -value , during )
	endmethod
	public static method setWind takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND , whichUnit , value - getWind(whichUnit) , during )
	endmethod
	// 自然属性[light]
	public static method getLight takes unit whichUnit returns real
	return getAttr( AF_LIGHT , whichUnit )
	endmethod
	public static method addLight takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT , whichUnit , value , during )
	endmethod
	public static method subLight takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT , whichUnit , -value , during )
	endmethod
	public static method setLight takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT , whichUnit , value - getLight(whichUnit) , during )
	endmethod
	// 自然属性[dark]
	public static method getDark takes unit whichUnit returns real
	return getAttr( AF_DARK , whichUnit )
	endmethod
	public static method addDark takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK , whichUnit , value , during )
	endmethod
	public static method subDark takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK , whichUnit , -value , during )
	endmethod
	public static method setDark takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK , whichUnit , value - getDark(whichUnit) , during )
	endmethod
	// 自然属性[wood]
	public static method getWood takes unit whichUnit returns real
	return getAttr( AF_WOOD , whichUnit )
	endmethod
	public static method addWood takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD , whichUnit , value , during )
	endmethod
	public static method subWood takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD , whichUnit , -value , during )
	endmethod
	public static method setWood takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD , whichUnit , value - getWood(whichUnit) , during )
	endmethod
	// 自然属性[thunder]
	public static method getThunder takes unit whichUnit returns real
	return getAttr( AF_THUNDER , whichUnit )
	endmethod
	public static method addThunder takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER , whichUnit , value , during )
	endmethod
	public static method subThunder takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER , whichUnit , -value , during )
	endmethod
	public static method setThunder takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER , whichUnit , value - getThunder(whichUnit) , during )
	endmethod
	// 自然属性[poison]
	public static method getPoison takes unit whichUnit returns real
	return getAttr( AF_POISON , whichUnit )
	endmethod
	public static method addPoison takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON , whichUnit , value , during )
	endmethod
	public static method subPoison takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON , whichUnit , -value , during )
	endmethod
	public static method setPoison takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON , whichUnit , value - getPoison(whichUnit) , during )
	endmethod
	// 自然属性[ghost]
	public static method getGhost takes unit whichUnit returns real
	return getAttr( AF_GHOST , whichUnit )
	endmethod
	public static method addGhost takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST , whichUnit , value , during )
	endmethod
	public static method subGhost takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST , whichUnit , -value , during )
	endmethod
	public static method setGhost takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST , whichUnit , value - getGhost(whichUnit) , during )
	endmethod
	// 自然属性[metal]
	public static method getMetal takes unit whichUnit returns real
	return getAttr( AF_METAL , whichUnit )
	endmethod
	public static method addMetal takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL , whichUnit , value , during )
	endmethod
	public static method subMetal takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL , whichUnit , -value , during )
	endmethod
	public static method setMetal takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL , whichUnit , value - getMetal(whichUnit) , during )
	endmethod
	// 自然属性[dragon]
	public static method getDragon takes unit whichUnit returns real
	return getAttr( AF_DRAGON , whichUnit )
	endmethod
	public static method addDragon takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON , whichUnit , value , during )
	endmethod
	public static method subDragon takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON , whichUnit , -value , during )
	endmethod
	public static method setDragon takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON , whichUnit , value - getDragon(whichUnit) , during )
	endmethod
	// 自然属性[fire_oppose]
	public static method getFireOppose takes unit whichUnit returns real
	return getAttr( AF_FIRE_OPPOSE , whichUnit )
	endmethod
	public static method addFireOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subFireOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setFireOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_FIRE_OPPOSE , whichUnit , value - getFireOppose(whichUnit) , during )
	endmethod
	// 自然属性[soil_oppose]
	public static method getSoilOppose takes unit whichUnit returns real
	return getAttr( AF_SOIL_OPPOSE , whichUnit )
	endmethod
	public static method addSoilOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subSoilOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setSoilOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_SOIL_OPPOSE , whichUnit , value - getSoilOppose(whichUnit) , during )
	endmethod
	// 自然属性[water_oppose]
	public static method getWaterOppose takes unit whichUnit returns real
	return getAttr( AF_WATER_OPPOSE , whichUnit )
	endmethod
	public static method addWaterOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subWaterOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setWaterOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WATER_OPPOSE , whichUnit , value - getWaterOppose(whichUnit) , during )
	endmethod
	// 自然属性[ice_oppose]
	public static method getIceOppose takes unit whichUnit returns real
	return getAttr( AF_ICE_OPPOSE , whichUnit )
	endmethod
	public static method addIceOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subIceOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setIceOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_ICE_OPPOSE , whichUnit , value - getIceOppose(whichUnit) , during )
	endmethod
	// 自然属性[wind_oppose]
	public static method getWindOppose takes unit whichUnit returns real
	return getAttr( AF_WIND_OPPOSE , whichUnit )
	endmethod
	public static method addWindOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subWindOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setWindOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WIND_OPPOSE , whichUnit , value - getWindOppose(whichUnit) , during )
	endmethod
	// 自然属性[light_oppose]
	public static method getLightOppose takes unit whichUnit returns real
	return getAttr( AF_LIGHT_OPPOSE , whichUnit )
	endmethod
	public static method addLightOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subLightOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setLightOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_LIGHT_OPPOSE , whichUnit , value - getLightOppose(whichUnit) , during )
	endmethod
	// 自然属性[dark_oppose]
	public static method getDarkOppose takes unit whichUnit returns real
	return getAttr( AF_DARK_OPPOSE , whichUnit )
	endmethod
	public static method addDarkOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subDarkOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setDarkOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DARK_OPPOSE , whichUnit , value - getDarkOppose(whichUnit) , during )
	endmethod
	// 自然属性[wood_oppose]
	public static method getWoodOppose takes unit whichUnit returns real
	return getAttr( AF_WOOD_OPPOSE , whichUnit )
	endmethod
	public static method addWoodOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subWoodOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setWoodOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_WOOD_OPPOSE , whichUnit , value - getWoodOppose(whichUnit) , during )
	endmethod
	// 自然属性[thunder_oppose]
	public static method getThunderOppose takes unit whichUnit returns real
	return getAttr( AF_THUNDER_OPPOSE , whichUnit )
	endmethod
	public static method addThunderOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subThunderOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setThunderOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_THUNDER_OPPOSE , whichUnit , value - getThunderOppose(whichUnit) , during )
	endmethod
	// 自然属性[poison_oppose]
	public static method getPoisonOppose takes unit whichUnit returns real
	return getAttr( AF_POISON_OPPOSE , whichUnit )
	endmethod
	public static method addPoisonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subPoisonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setPoisonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_POISON_OPPOSE , whichUnit , value - getPoisonOppose(whichUnit) , during )
	endmethod
	// 自然属性[ghost_oppose]
	public static method getGhostOppose takes unit whichUnit returns real
	return getAttr( AF_GHOST_OPPOSE , whichUnit )
	endmethod
	public static method addGhostOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subGhostOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setGhostOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_GHOST_OPPOSE , whichUnit , value - getGhostOppose(whichUnit) , during )
	endmethod
	// 自然属性[metal_oppose]
	public static method getMetalOppose takes unit whichUnit returns real
	return getAttr( AF_METAL_OPPOSE , whichUnit )
	endmethod
	public static method addMetalOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subMetalOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setMetalOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_METAL_OPPOSE , whichUnit , value - getMetalOppose(whichUnit) , during )
	endmethod
	// 自然属性[dragon_oppose]
	public static method getDragonOppose takes unit whichUnit returns real
	return getAttr( AF_DRAGON_OPPOSE , whichUnit )
	endmethod
	public static method addDragonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subDragonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setDragonOppose takes unit whichUnit , real value , real during returns nothing
	call setAttr( AF_DRAGON_OPPOSE , whichUnit , value - getDragonOppose(whichUnit) , during )
	endmethod

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public static method showAttr takes unit whichUnit returns nothing
		call hconsole.info("自然属性#fire："+R2S(getFire(whichUnit)))
		call hconsole.info("自然属性#soil："+R2S(getSoil(whichUnit)))
		call hconsole.info("自然属性#water："+R2S(getWater(whichUnit)))
		call hconsole.info("自然属性#ice："+R2S(getIce(whichUnit)))
		call hconsole.info("自然属性#wind："+R2S(getWind(whichUnit)))
		call hconsole.info("自然属性#light："+R2S(getLight(whichUnit)))
		call hconsole.info("自然属性#dark："+R2S(getDark(whichUnit)))
		call hconsole.info("自然属性#wood："+R2S(getWood(whichUnit)))
		call hconsole.info("自然属性#thunder："+R2S(getThunder(whichUnit)))
		call hconsole.info("自然属性#poison："+R2S(getPoison(whichUnit)))
		call hconsole.info("自然属性#ghost"+R2S(getGhost(whichUnit)))
		call hconsole.info("自然属性#metal"+R2S(getMetal(whichUnit)))
		call hconsole.info("自然属性#dragon"+R2S(getDragon(whichUnit)))
		call hconsole.info("自然属性#fire_oppose："+R2S(getFireOppose(whichUnit)))
		call hconsole.info("自然属性#soil_oppose："+R2S(getSoilOppose(whichUnit)))
		call hconsole.info("自然属性#water_oppose："+R2S(getWaterOppose(whichUnit)))
		call hconsole.info("自然属性#ice_oppose："+R2S(getIceOppose(whichUnit)))
		call hconsole.info("自然属性#wind_oppose："+R2S(getWindOppose(whichUnit)))
		call hconsole.info("自然属性#light_oppose："+R2S(getLightOppose(whichUnit)))
		call hconsole.info("自然属性#dark_oppose："+R2S(getDarkOppose(whichUnit)))
		call hconsole.info("自然属性#wood_oppose："+R2S(getWoodOppose(whichUnit)))
		call hconsole.info("自然属性#thunder_oppose："+R2S(getThunderOppose(whichUnit)))
		call hconsole.info("自然属性#poison_oppose："+R2S(getPoisonOppose(whichUnit)))
		call hconsole.info("自然属性#ghost_oppose"+R2S(getGhostOppose(whichUnit)))
		call hconsole.info("自然属性#metal_oppose"+R2S(getMetalOppose(whichUnit)))
		call hconsole.info("自然属性#dragon_oppose"+R2S(getDragonOppose(whichUnit)))
    endmethod

endstruct
