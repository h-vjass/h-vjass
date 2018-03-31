//算法
globals
    hMath hmath
    hXY hxy
endglobals
struct hXY
	public real x = 0
	public real y = 0
endstruct
struct hMath

	//绝对值
	public method rabs takes real value returns real
		return RAbsBJ(value)
	endmethod

	//两整型相除得到real
	public method II2R takes integer i1,integer i2 returns real
	    return ( I2R(i1) / I2R(i2) )
	endmethod

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
	public method integerformat takes integer value returns string
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

	//字符串截取
	public method substr takes string haystack,integer start,integer len returns string
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
	public method strpos takes string haystack,string needle returns integer
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
