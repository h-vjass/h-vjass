/* 自然属性 */
library hAttrNatural initializer init needs hAttrEffect

	globals
		private hashtable hash = null
		private integer AF_EFFECT_UNIT = 1000
	    private integer AF_EFFECT_CD = 1001
	    //--
		private integer AF_FIRE = 7001
		private integer AF_SOIL = 7002
		private integer AF_WATER = 7003
		private integer AF_WIND = 7004
		private integer AF_LIGHT = 7005
		private integer AF_DARK = 7006
		private integer AF_WOOD = 7007
		private integer AF_THUNDER = 7008
		private integer AF_FIRE_OPPOSE = 7009
		private integer AF_SOIL_OPPOSE = 7010
		private integer AF_WATER_OPPOSE = 7011
		private integer AF_WIND_OPPOSE = 7012
		private integer AF_LIGHT_OPPOSE = 7013
		private integer AF_DARK_OPPOSE = 7014
		private integer AF_WOOD_OPPOSE = 7015
		private integer AF_THUNDER_OPPOSE = 7016
	endglobals

	/* 验证单位是否初始化过参数 */
	public function initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash , uhid , AF_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash , uhid , AF_EFFECT_UNIT , uhid )

			call SaveReal( hash , uhid , AF_FIRE , 0 )
			call SaveReal( hash , uhid , AF_SOIL , 0 )
			call SaveReal( hash , uhid , AF_WATER , 0 )
			call SaveReal( hash , uhid , AF_WIND , 0 )
			call SaveReal( hash , uhid , AF_LIGHT , 0 )
			call SaveReal( hash , uhid , AF_DARK , 0 )
			call SaveReal( hash , uhid , AF_WOOD , 0 )
			call SaveReal( hash , uhid , AF_THUNDER , 0 )
			call SaveReal( hash , uhid , AF_FIRE_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_SOIL_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_WATER_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_WIND_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_LIGHT_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_DARK_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_WOOD_OPPOSE , 0 )
			call SaveReal( hash , uhid , AF_THUNDER_OPPOSE , 0 )
			return true
		endif
		return false
	endfunction

	/* 设定属性(即时/计时) */
	private function setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if(diff != 0)then
			call SaveReal( hash , uhid , flag , LoadReal( hash , uhid , flag ) + diff )
		endif
	endfunction

	private function setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = time.getInteger(t,1)
		local unit whichUnit = time.getUnit(t,2)
		local real diff = time.getReal(t,3)
		call time.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
	endfunction

	private function setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = time.setTimeout( during , function setAttrDuring )
			call time.setInteger(t,1,flag)
			call time.setUnit(t,2,whichUnit)
			call time.setReal(t,3, -diff )
		endif
	endfunction

	private function getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash , GetHandleId(whichUnit) , flag )
	endfunction




	/* 自然属性[fire] ------------------------------------------------------------ */
	public function getFire takes unit whichUnit returns real
	   return getAttr( AF_FIRE , whichUnit )
	endfunction
	public function addFire takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE , whichUnit , value , during )
	endfunction
	public function subFire takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE , whichUnit , -value , during )
	endfunction
	public function setFire takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE , whichUnit , value - getFire(whichUnit) , during )
	endfunction
	/* 自然属性[soil] ------------------------------------------------------------ */
	public function getSoil takes unit whichUnit returns real
	   return getAttr( AF_SOIL , whichUnit )
	endfunction
	public function addSoil takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL , whichUnit , value , during )
	endfunction
	public function subSoil takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL , whichUnit , -value , during )
	endfunction
	public function setSoil takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL , whichUnit , value - getSoil(whichUnit) , during )
	endfunction
	/* 自然属性[water] ------------------------------------------------------------ */
	public function getWater takes unit whichUnit returns real
	   return getAttr( AF_WATER , whichUnit )
	endfunction
	public function addWater takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER , whichUnit , value , during )
	endfunction
	public function subWater takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER , whichUnit , -value , during )
	endfunction
	public function setWater takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER , whichUnit , value - getWater(whichUnit) , during )
	endfunction
	/* 自然属性[wind] ------------------------------------------------------------ */
	public function getWind takes unit whichUnit returns real
	   return getAttr( AF_WIND , whichUnit )
	endfunction
	public function addWind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND , whichUnit , value , during )
	endfunction
	public function subWind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND , whichUnit , -value , during )
	endfunction
	public function setWind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND , whichUnit , value - getWind(whichUnit) , during )
	endfunction
	/* 自然属性[light] ------------------------------------------------------------ */
	public function getLight takes unit whichUnit returns real
	   return getAttr( AF_LIGHT , whichUnit )
	endfunction
	public function addLight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT , whichUnit , value , during )
	endfunction
	public function subLight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT , whichUnit , -value , during )
	endfunction
	public function setLight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT , whichUnit , value - getLight(whichUnit) , during )
	endfunction
	/* 自然属性[dark] ------------------------------------------------------------ */
	public function getDark takes unit whichUnit returns real
	   return getAttr( AF_DARK , whichUnit )
	endfunction
	public function addDark takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK , whichUnit , value , during )
	endfunction
	public function subDark takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK , whichUnit , -value , during )
	endfunction
	public function setDark takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK , whichUnit , value - getDark(whichUnit) , during )
	endfunction
	/* 自然属性[wood] ------------------------------------------------------------ */
	public function getWood takes unit whichUnit returns real
	   return getAttr( AF_WOOD , whichUnit )
	endfunction
	public function addWood takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD , whichUnit , value , during )
	endfunction
	public function subWood takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD , whichUnit , -value , during )
	endfunction
	public function setWood takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD , whichUnit , value - getWood(whichUnit) , during )
	endfunction
	/* 自然属性[thunder] ------------------------------------------------------------ */
	public function getThunder takes unit whichUnit returns real
	   return getAttr( AF_THUNDER , whichUnit )
	endfunction
	public function addThunder takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER , whichUnit , value , during )
	endfunction
	public function subThunder takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER , whichUnit , -value , during )
	endfunction
	public function setThunder takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER , whichUnit , value - getThunder(whichUnit) , during )
	endfunction
	/* 自然属性[fire_oppose] ------------------------------------------------------------ */
	public function getFireOppose takes unit whichUnit returns real
	   return getAttr( AF_FIRE_OPPOSE , whichUnit )
	endfunction
	public function addFireOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE_OPPOSE , whichUnit , value , during )
	endfunction
	public function subFireOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setFireOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_FIRE_OPPOSE , whichUnit , value - getFireOppose(whichUnit) , during )
	endfunction
	/* 自然属性[soil_oppose] ------------------------------------------------------------ */
	public function getSoilOppose takes unit whichUnit returns real
	   return getAttr( AF_SOIL_OPPOSE , whichUnit )
	endfunction
	public function addSoilOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL_OPPOSE , whichUnit , value , during )
	endfunction
	public function subSoilOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setSoilOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_SOIL_OPPOSE , whichUnit , value - getSoilOppose(whichUnit) , during )
	endfunction
	/* 自然属性[water_oppose] ------------------------------------------------------------ */
	public function getWaterOppose takes unit whichUnit returns real
	   return getAttr( AF_WATER_OPPOSE , whichUnit )
	endfunction
	public function addWaterOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER_OPPOSE , whichUnit , value , during )
	endfunction
	public function subWaterOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setWaterOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WATER_OPPOSE , whichUnit , value - getWaterOppose(whichUnit) , during )
	endfunction
	/* 自然属性[wind_oppose] ------------------------------------------------------------ */
	public function getWindOppose takes unit whichUnit returns real
	   return getAttr( AF_WIND_OPPOSE , whichUnit )
	endfunction
	public function addWindOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND_OPPOSE , whichUnit , value , during )
	endfunction
	public function subWindOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setWindOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WIND_OPPOSE , whichUnit , value - getWindOppose(whichUnit) , during )
	endfunction
	/* 自然属性[light_oppose] ------------------------------------------------------------ */
	public function getLightOppose takes unit whichUnit returns real
	   return getAttr( AF_LIGHT_OPPOSE , whichUnit )
	endfunction
	public function addLightOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT_OPPOSE , whichUnit , value , during )
	endfunction
	public function subLightOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setLightOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_LIGHT_OPPOSE , whichUnit , value - getLightOppose(whichUnit) , during )
	endfunction
	/* 自然属性[dark_oppose] ------------------------------------------------------------ */
	public function getDarkOppose takes unit whichUnit returns real
	   return getAttr( AF_DARK_OPPOSE , whichUnit )
	endfunction
	public function addDarkOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK_OPPOSE , whichUnit , value , during )
	endfunction
	public function subDarkOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setDarkOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_DARK_OPPOSE , whichUnit , value - getDarkOppose(whichUnit) , during )
	endfunction
	/* 自然属性[wood_oppose] ------------------------------------------------------------ */
	public function getWoodOppose takes unit whichUnit returns real
	   return getAttr( AF_WOOD_OPPOSE , whichUnit )
	endfunction
	public function addWoodOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD_OPPOSE , whichUnit , value , during )
	endfunction
	public function subWoodOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setWoodOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_WOOD_OPPOSE , whichUnit , value - getWoodOppose(whichUnit) , during )
	endfunction
	/* 自然属性[thunder_oppose] ------------------------------------------------------------ */
	public function getThunderOppose takes unit whichUnit returns real
	   return getAttr( AF_THUNDER_OPPOSE , whichUnit )
	endfunction
	public function addThunderOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER_OPPOSE , whichUnit , value , during )
	endfunction
	public function subThunderOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setThunderOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( AF_THUNDER_OPPOSE , whichUnit , value - getThunderOppose(whichUnit) , during )
	endfunction

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public function showAttr takes unit whichUnit returns nothing
		call console.info("自然属性#fire："+R2S(getFire(whichUnit)))
		call console.info("自然属性#soil："+R2S(getSoil(whichUnit)))
		call console.info("自然属性#water："+R2S(getWater(whichUnit)))
		call console.info("自然属性#wind："+R2S(getWind(whichUnit)))
		call console.info("自然属性#light："+R2S(getLight(whichUnit)))
		call console.info("自然属性#dark："+R2S(getDark(whichUnit)))
		call console.info("自然属性#wood："+R2S(getWood(whichUnit)))
		call console.info("自然属性#thunder："+R2S(getThunder(whichUnit)))
		call console.info("自然属性#fire_oppose："+R2S(getFireOppose(whichUnit)))
		call console.info("自然属性#soil_oppose："+R2S(getSoilOppose(whichUnit)))
		call console.info("自然属性#water_oppose："+R2S(getWaterOppose(whichUnit)))
		call console.info("自然属性#wind_oppose："+R2S(getWindOppose(whichUnit)))
		call console.info("自然属性#light_oppose："+R2S(getLightOppose(whichUnit)))
		call console.info("自然属性#dark_oppose："+R2S(getDarkOppose(whichUnit)))
		call console.info("自然属性#wood_oppose："+R2S(getWoodOppose(whichUnit)))
		call console.info("自然属性#thunder_oppose："+R2S(getThunderOppose(whichUnit)))
    endfunction

    private function init takes nothing returns nothing
    	set hash = InitHashtable()
    endfunction


endlibrary
