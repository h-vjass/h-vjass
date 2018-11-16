//算法
globals
	hashtable hash_hlogic = null
    hLogic hlogic
    hXY hxy
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
		local string objname = GetObjectName('A038')
		local string str = ""
        set x = hLogic.allocate()
		call SaveStr(hash_hlogic,HASH_KEY_CHAR,0,"")
		call SaveInteger(hash_hlogic,HASH_KEY_CHARNUM,StringHash(str),0)
		loop
			exitwhen i>255
			set str = SubString(objname,i-1,i)
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
		local string s = ""
		if(value>100000000)then
			set s = R2SW(value/100000000, 1, 3)+"Y"
		elseif(value>10000)then
			set s = R2SW(value/10000, 1, 3)+"W"
		else
			set s = R2S(value)
		endif
		return s
	endmethod

	//整型格式化
	public static method integerformat takes integer value returns string
		local string s = ""
		if(value>100000000)then
			set s = I2S(value/100000000)+"Y"
		elseif(value>10000)then
			set s = I2S(value/10000)+"W"
		else
			set s = I2S(value)
		endif
		return s
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
	public static method getDegBetweenUnit takes unit u1,unit u2 returns real
		local location l1 = null
		local location l2 = null
		local real deg = 0
		if( u1 == null or u2 == null ) then
            return 0
        endif
		set l1 = GetUnitLoc(u1)
		set l2 = GetUnitLoc(u2)
		set deg = thistype.getDegBetweenLoc(l1, l2)
		call RemoveLocation(l1)
		call RemoveLocation(l2)
		return deg
	endmethod

	/**
     *  获取两个单位间距离，如果其中一个单位为空 返回0
     */
    public static method getDistanceBetweenUnit takes unit u1,unit u2 returns real
        local location loc1 = null
        local location loc2 = null
        local real distance = 0
        if( u1 == null or u2 == null ) then
            return 0
        endif
        set loc1 = GetUnitLoc(u1)
        set loc2 = GetUnitLoc(u2)
        set distance = DistanceBetweenPoints(loc1, loc2)
        call RemoveLocation( loc1 )
        call RemoveLocation( loc2 )
        set loc1 = null
        set loc2 = null
        return distance
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
		local string s = ""
		local integer n = StringLength(map)
		loop
			exitwhen i == 0
			set s = thistype.substr.evaluate(map, ModuloInteger(i, n), 1) + s
			set i = i / n
		endloop
		return s
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
		local integer chinaQty = LoadInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s))
		local integer i = 0   
		local integer l = 0
		local string ss = null
		local string Echar = null
		if(chinaQty<=0)then
		    set chinaQty = 0
			set ss = LoadStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s))
			if(ss == null)then
				set l = StringLength(s)
				loop
					exitwhen i >= l
					set Echar = thistype.int2strByMap.evaluate(thistype.asc(thistype.substr(s,i,1)),hexcharmap)
					set ss = ss + Echar
					if(Echar == "E1" or Echar == "E2" or Echar == "E3" or Echar == "E4" or Echar == "E5" or Echar == "E6" or Echar == "E7" or Echar == "E8" or Echar == "E9")then
						set chinaQty = chinaQty + 1
					endif
					set i = i+1
				endloop
				call SaveInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s),chinaQty)
				call SaveStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s),ss)
			endif
		endif
		return chinaQty
	endmethod

	public static method hex2str takes string s returns string 
		local integer i = 0   
		local integer l = 0
		local string ss = LoadStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s))
		local string Echar = null
		local integer chinaQty = 0
		if(ss == null)then
			set l = StringLength(s)
			loop
				exitwhen i >= l
				set Echar = thistype.int2strByMap(thistype.asc(thistype.substr(s,i,1)),hexcharmap)
				set ss = ss + Echar
				if(Echar == "E1" or Echar == "E2" or Echar == "E3" or Echar == "E4" or Echar == "E5" or Echar == "E6" or Echar == "E7" or Echar == "E8" or Echar == "E9")then
					set chinaQty = chinaQty + 1
				endif
				set i = i+1
			endloop
			call SaveInteger(hash_hlogic,HASH_KEY_CHINA_QTY_CACHE,StringHash(s),chinaQty)
			call SaveStr(hash_hlogic,HASH_KEY_HEX2STR_CACHE,StringHash(s),ss)
		endif
		return ss
	endmethod

	public static method str2hex takes string s returns string
		local integer i = 0   
		local integer l = StringLength(s)
		local string ss = LoadStr(hash_hlogic,HASH_KEY_STR2HEX_CACHE,StringHash(s))
		if(ss == null)then
			set l = StringLength(s)
			loop
				exitwhen i >= l        
				set ss = ss + thistype.chr(thistype.str2intByMap(thistype.substr(s,i,2),hexcharmap))
				set i = i + 2
			endloop
			call SaveStr(hash_hlogic,HASH_KEY_STR2HEX_CACHE,StringHash(s),ss)
		endif
		return ss
	endmethod

endstruct

/**
* IsTerrainWalkable snippet for estimating the walkability status of a co-ordinate pair, credits 
* to Anitarf and Vexorian.
* 
* API: boolean IsTerrainWalkable(real x, real y) - returns the walkability of (x,y)
*/ 
/*
library IsTerrainWalkable initializer init
    globals
    
        // this value is how far from a point the item may end up for the point to be considered pathable
        private constant real MAX_RANGE=10.
        
        // the following two variables are set to the position of the item after each pathing check
        // that way, if a point isn't pathable, these will be the coordinates of the nearest point that is
        public real X=0.
        public real Y=0.
        private rect r
        private item check
        private item array hidden
        private integer hiddenMax=0
    endglobals

    private function init takes nothing returns nothing
        set check=CreateItem('ciri',0.,0.)
        call SetItemVisible(check,false)
        set r=Rect(0.0,0.0,128.0,128.0)
    endfunction

    private function hideBothersomeItem takes nothing returns nothing
        if IsItemVisible(GetEnumItem()) then
            set hidden[hiddenMax=GetEnumItem()
            call SetItemVisible(hidden[hiddenMax,false)
            set hiddenMax=hiddenMax+1
        endif
    endfunction

    function IsTerrainWalkable takes real x, real y returns boolean
    
        // first, hide any items in the area so they don't get in the way of our item
        call MoveRectTo(r,x,y)
        call EnumItemsInRect(r,null,function hideBothersomeItem)
        
        // try to move the check item and get its coordinates
        // this unhides the item...
        call SetItemPosition(check,x,y)
        set X=GetItemX(check)
        set Y=GetItemY(check)
        
        //...so we must hide it again
        call SetItemVisible(check,false)
        
        // before returning, unhide any items that got hidden at the start
        loop
            exitwhen hiddenMax==0
            set hiddenMax=hiddenMax-1
            call SetItemVisible(hidden[hiddenMax,true)
        endloop
        
        // return pathability status
        return (x-X)*(x-X)+(y-Y)*(y-Y)<MAX_RANGE*MAX_RANGE
    endfunction
endlibrary

library gezi2 uses gezi 

	function gezig takes unit u returns nothing
		local integer a=0
		local integer xx=0
		local integer yy=0
		local integer z=z0
		local integer ii=0
		set i=0
		set x[0]=R2I(GetUnitX(u))
		set y[0]=R2I(GetUnitY(u))
		call FlushParentHashtable(BH)
		set BH=InitHashtable()
		call FlushParentHashtable(BS)
		set BS=InitHashtable()
		loop
			exitwhen z<=0
			set a=ii
			set ii=i
			loop
				exitwhen a>ii
				if LoadInteger(HT,StringHash("way"),a)<z then
					set xx=x[a]+200
					set yy=y[a]
				if LoadInteger(BH,xx,yy)==0 and IsTerrainWalkable(xx,yy) then
					set i=i+1
					set x[i]=xx
					set y[i]=yy
					call SaveInteger(BH,xx,yy,1)
					call SaveInteger(BS,xx,yy,a)
				endif
				set xx=x[a]
				set yy=y[a]+200
				if LoadInteger(BH,xx,yy)==0 and IsTerrainWalkable(xx,yy)then
					set i=i+1
					set x[i]=xx
					set y[i]=yy
					call SaveInteger(BH,xx,yy,1)
					call SaveInteger(BS,xx,yy,a)
				endif
				set xx=x[a]-200
				set yy=y[a]
				if LoadInteger(BH,xx,yy)==0 and IsTerrainWalkable(xx,yy)then
					set i=i+1
					set x[i]=xx
					set y[i]=yy
					call SaveInteger(BH,xx,yy,1)
					call SaveInteger(BS,xx,yy,a)
				endif
				set xx=x[a]
				set yy=y[a]-200
				if LoadInteger(BH,xx,yy)==0 and IsTerrainWalkable(xx,yy)then
					set i=i+1
					set x[i]=xx
					set y[i]=yy
					call SaveInteger(BH,xx,yy,1)
					call SaveInteger(BS,xx,yy,a)
				endif
				endif
				set a=a+1
			endloop
			set z=z-1
		endloop
		loop
			exitwhen i<0
			set mj=CreateUnit(Player(15),'n000',x[i],y[i],0)
			call SetUnitX(mj,x[i])
			call SetUnitY(mj,y[i])
			call GroupAddUnit(g,mj)
			call SaveInteger(HT,GetHandleId(mj),1,i)
			set i=i-1
		endloop
		call SaveGroupHandle(HT,GetHandleId(u),1,g)
	endfunction
endlibrary 
*/
