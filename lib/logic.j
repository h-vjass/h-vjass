//算法
globals
	hashtable hash_hlogic = null
    hLogic hlogic
    hXY hxy
	string hjass_global_logic_txt
endglobals
struct hXY
	public real x = 0
	public real y = 0
endstruct
struct hLogic

	private static integer HASH_KEY_CHINA_QTY_CACHE = 21
	private static integer HASH_KEY_HEX2STR_CACHE = 31
	private static integer HASH_KEY_STR2HEX_CACHE = 32
	private static integer HASH_KEY_CHAR = 44
	private static integer HASH_KEY_CHARNUM = 45
	private static string bincharmap  ="01"
    private static string octcharmap = "012345678"
    private static string hexcharmap = "0123456789ABCDEF"
    private static string idcharmap = ".................................!.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................."

	static method create takes nothing returns hLogic
        local hLogic x = 0
		local integer i = 1
		local string str = ""
        set x = hLogic.allocate()
		call SaveStr(hash_hlogic,HASH_KEY_CHAR,0,"")
		call SaveInteger(hash_hlogic,HASH_KEY_CHARNUM,StringHash(str),0)
		loop
			exitwhen i>255
			set str = SubString(GetObjectName('A038'),i-1,i)
			call SaveStr(hash_hlogic,HASH_KEY_CHAR,i,str)
			call SaveInteger(hash_hlogic,HASH_KEY_CHARNUM,StringHash(str),i)
			set i=i+1
		endloop
		set str = "}"
		call SaveStr(hash_hlogic,HASH_KEY_CHAR,0x7D,str)
		call SaveInteger(hash_hlogic,HASH_KEY_CHARNUM,StringHash(str),0x7D)
        return x
    endmethod
	
	//绝对值
	public method rabs takes real value returns real
		return RAbsBJ(value)
	endmethod
	//绝对值
	public method iabs takes integer value returns integer
		return IAbsBJ(value)
	endmethod

	//rmod
	public method rmod takes real value1,real value2 returns real
		if(value2 == 0)then
			return 0
		endif
		return ModuloReal(value1, value2)
	endmethod
	//imod
	public method imod takes integer value1,integer value2 returns integer
		if(value2 == 0)then
			return 0
		endif
		return ModuloInteger(value1, value2)
	endmethod

	//两整型相除得到real
	public method II2R takes integer i1,integer i2 returns real
	    return ( I2R(i1) / I2R(i2) )
	endmethod

	//极坐标位移
	public method polarProjection takes hXY xy, real dist, real angle returns hXY
		set xy.x = xy.x + dist * Cos(angle * bj_DEGTORAD)
		set xy.y = xy.y + dist * Sin(angle * bj_DEGTORAD)
		return xy
	endmethod

	//获取物品几率叠加几率
	//根据固定因子及增益因子计算几率因子
	public method oddsItem takes integer odds_stable,real odds_gain,integer timers returns real
	    return odds_stable + odds_stable*( I2R(timers-1) * odds_gain)
	endmethod

	//计算属性特效效果叠加
	public method coverAttrEffectVal takes real value1,real value2 returns real
		if(rabs(value1)>rabs(value2))then
			return value2*0.15+value1
		else
			return value1*0.15+value2
		endif
	endmethod

	//实数格式化
	public method realformat takes real value returns string
		set hjass_global_logic_txt = ""
		if(value>100000000)then
			set hjass_global_logic_txt = R2SW(value/100000000, 1, 3)+"Y"
		elseif(value>10000)then
			set hjass_global_logic_txt = R2SW(value/10000, 1, 3)+"W"
		else
			set hjass_global_logic_txt = R2S(value)
		endif
		return hjass_global_logic_txt
	endmethod

	//整型格式化
	public static method integerformat takes integer value returns string
		set hjass_global_logic_txt = ""
		if(value>100000000)then
			set hjass_global_logic_txt = I2S(value/100000000)+"Y"
		elseif(value>10000)then
			set hjass_global_logic_txt = I2S(value/10000)+"W"
		else
			set hjass_global_logic_txt = I2S(value)
		endif
		return hjass_global_logic_txt
	endmethod

	/**
	 * 获取两个点间角度，如果其中一个单位为空 返回0
	 */
	public static method getDegBetweenLoc takes location l1,location l2 returns real
		if( l1 == null or l2 == null ) then
            return 0
        endif
		return AngleBetweenPoints(l1, l2)
	endmethod
	
	/**
	 * 获取两个单位间角度，如果其中一个单位为空 返回0
	 */
	public static method getDegBetweenUnit takes unit fromUnit,unit toUnit returns real
		return bj_RADTODEG * Atan2(GetUnitY(toUnit) - GetUnitY(fromUnit), GetUnitX(toUnit) - GetUnitX(fromUnit))
	endmethod

	/**
     *  获取两个单位间距离，如果其中一个单位为空 返回0
     */
    public static method getDistanceBetweenUnit takes unit u1,unit u2 returns real
		return SquareRoot((GetUnitX(u1)-GetUnitX(u2))*(GetUnitX(u1)-GetUnitX(u2))+(GetUnitY(u1)-GetUnitY(u2))*(GetUnitY(u1)-GetUnitY(u2)))
    endmethod

	/**
     *  获取两个坐标距离
     */
    public static method getDistanceBetweenXY takes real x1,real y1,real x2,real y2 returns real
        local real dx = x2 - x1
		local real dy = y2 - y1
		return SquareRoot(dx * dx + dy * dy)
    endmethod

	/**
     *  获取两个点距离，如果其中一个点为空 返回0
     */
    public static method getDistanceBetweenLoc takes location loc1,location loc2 returns real
        if( loc1 == null or loc2 == null ) then
            return 0
        endif
        return DistanceBetweenPoints(loc1, loc2)
    endmethod

	//字符串截取
	public static method substr takes string haystack,integer start,integer len returns string
		local integer haystackLen = StringLength(haystack)
		local integer iend = start+len
		if(start>=0)then
			if(start >= haystackLen)then
				return ""
			elseif(iend >= haystackLen)then
				return SubString(haystack,start,haystackLen)
			else
				return SubString(haystack,start,iend)
			endif
		else
			return ""
		endif
	endmethod

	//找出字符串needle在haystack的位置，找不到返回-1 同php
	public static method strpos takes string haystack,string needle returns integer
		local integer i = 0
		local integer site = -1
		local integer haystackLen = StringLength(haystack)
		local integer needleLen = StringLength(needle)
		if(needleLen>0 and haystackLen >= needleLen)then
			loop
				exitwhen (haystackLen-i)<needleLen
					if( SubString(haystack,i,needleLen+i)==needle )then
						set site = i
						call DoNothing() YDNL exitwhen true
					endif
				set i = i+1
			endloop
		endif
		return site
	endmethod

	//按进制map 将字符串转换成整数
	private static method str2intByMap takes string s,string map returns integer
		local integer i = StringLength(s)
		local integer m = 0
		local integer n = StringLength(map)
		local integer f = -1
		loop
			exitwhen i == 0
			set f = thistype.strpos.evaluate(map, SubString(s, i - 1, i)) * R2I(Pow(n, I2R(StringLength(s) - i)))
			if f == -1 then
				return m
			endif
			set m = m + f
			set i = i - 1
		endloop
		return m
	endmethod

	//按进制map 将整数转换成字符串
	private static method int2strByMap takes integer m,string map returns string
		local integer i = m
		local integer n = StringLength(map)
		set hjass_global_logic_txt = ""
		loop
			exitwhen i == 0
			set hjass_global_logic_txt = thistype.substr.evaluate(map, ModuloInteger(i, n), 1) + hjass_global_logic_txt
			set i = i / n
		endloop
		return hjass_global_logic_txt
	endmethod

	private static method asc takes string s returns integer
		if(s==null or s=="")then
			return 0
		endif
		if(StringLength(s)>1)then
			return -1
		endif
		return LoadInteger(hash_hlogic,HASH_KEY_CHARNUM,StringHash(s))
	endmethod

	private static method chr takes integer i returns string
		return LoadStr(hash_hlogic,HASH_KEY_CHAR,i)
	endmethod

	public static method getChinaQty takes string s returns integer
		local string txt = null
		local string char = null
		local integer chinaQty = LoadInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s))
		local integer i = 0   
		local integer l = 0
		if(chinaQty<=0)then
		    set chinaQty = 0
			set txt = LoadStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s))
			if(txt == null)then
				set l = StringLength(s)
				loop
					exitwhen i >= l
					set char = thistype.int2strByMap.evaluate(thistype.asc(thistype.substr(s,i,1)),hexcharmap)
					set txt = txt + char
					if(char == "E1" or char == "E2" or char == "E3" or char == "E4" or char == "E5" or char == "E6" or char == "E7" or char == "E8" or char == "E9")then
						set chinaQty = chinaQty + 1
					endif
					set i = i+1
				endloop
				call SaveInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s),chinaQty)
				call SaveStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s),txt)
			endif
		endif
		return chinaQty
	endmethod

	public static method hex2str takes string s returns string
		local string char = null
		local integer i = 0   
		local integer l = 0
		local integer chinaQty = 0
		set hjass_global_logic_txt = LoadStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s))
		if(hjass_global_logic_txt == null)then
			set l = StringLength(s)
			loop
				exitwhen i >= l
				set char = thistype.int2strByMap(thistype.asc(thistype.substr(s,i,1)),hexcharmap)
				set hjass_global_logic_txt = hjass_global_logic_txt + char
				if(char == "E1" or char == "E2" or char == "E3" or char == "E4" or char == "E5" or char == "E6" or char == "E7" or char == "E8" or char == "E9")then
					set chinaQty = chinaQty + 1
				endif
				set i = i+1
			endloop
			call SaveInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s),chinaQty)
			call SaveStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s),hjass_global_logic_txt)
		endif
		return hjass_global_logic_txt
	endmethod

	public static method str2hex takes string s returns string
		local integer i = 0   
		local integer l = StringLength(s)
		set hjass_global_logic_txt = LoadStr(hash_hlogic,HASH_KEY_STR2HEX_CACHE,StringHash(s))
		if(hjass_global_logic_txt == null)then
			set l = StringLength(s)
			loop
				exitwhen i >= l        
				set hjass_global_logic_txt = hjass_global_logic_txt + thistype.chr(thistype.str2intByMap(thistype.substr(s,i,2),hexcharmap))
				set i = i + 2
			endloop
			call SaveStr(hash_hlogic,HASH_KEY_STR2HEX_CACHE,StringHash(s),hjass_global_logic_txt)
		endif
		return hjass_global_logic_txt
	endmethod

endstruct