/* 区域 */
globals
    hRect hrect = 0
    hashtable hash_hrect = null
endglobals

struct hRect

	private static integer HASH_TIMER = 101
	private static integer HASH_WIDTH = 102
	private static integer HASH_HEIGHT = 103
	private static integer HASH_GROUP = 104

	static method create takes nothing returns hRect
        local hRect x = 0
        set x = hRect.allocate()
        set hash_hrect = InitHashtable()
        return x
    endmethod
    method onDestroy takes nothing returns nothing
        set hash_hrect = null
    endmethod

	/**
	 * 设定中心点（X,Y）创建一个长width宽height的矩形区域
	 */
	public method toLoc takes real locX , real locY , real width , real height returns rect
		local real startX = locX-(width * 0.5)
		local real startY = locY-(height * 0.5)
		local real endX = locX+(width * 0.5)
		local real endY = locY+(height * 0.5)
		local rect r = Rect( startX , startY , endX , endY )
		local integer recthid = GetHandleId(r)
		call SaveReal(hash_hrect, recthid, HASH_WIDTH , width)
		call SaveReal(hash_hrect, recthid, HASH_HEIGHT , height)
		return r
	endmethod

	//删除区域
	public method del takes rect area returns nothing
		local integer recthid = GetHandleId(area)
		local timer t = LoadTimerHandle(hash_hrect, recthid, HASH_TIMER)
		if(t != null)then
			call time.delTimer(t)
    		call SaveTimerHandle(hash_hrect, GetHandleId(area), HASH_TIMER , null)
    	endif
	endmethod

	//锁定所有单位在某个区域无法离开
	//area 区域
	//whichUnit 单位
	//ty 类型有：[square|circle][矩形|圆形]
	//distance 距离
	//during 持续时间 0 则直到区域消失
	private static method lockCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local rect area = time.getRect(t,1)
		local string ty = time.getString(t,2)
		local real during = time.getReal(t,3)
		local real inc = time.getReal(t,4)
		local group baseG = time.getGroup(t,5)
		local real deg = 0
		local real distance = 0
		local location rectCenter = null
		local integer recthid = 0
		local real rectW = 0
		local real rectH = 0
		local real rectDegA = 0
		local real rectDegB = 0
		local location loc = null
		local group g = null
		local unit u = null

		if(area==null or (ty!="square" and ty!="circle"))then
			call time.delTimer(t)
			return
		endif
		if(inc>0 and inc>=during)then
			call time.delTimer(t)
			return
		endif

		set rectCenter = GetRectCenter(area)
		set recthid = GetHandleId(area)
		set rectW = LoadReal(hash_hrect, recthid, hRect.HASH_WIDTH)
		set rectH = LoadReal(hash_hrect, recthid, hRect.HASH_HEIGHT)
		set rectDegA = 180 / ( Atan(rectH/rectW)*bj_PI )
		set rectDegB = 90 - rectDegA

		if(rectW<=0 or rectH<=0)then
			call console.error("lockCall rect worh<=0")
			call time.delTimer(t)
			return
		endif

		call time.setReal(t,4,inc+time.getSetTime(t))
		set g = GetUnitsInRectAll(area)
		call GroupAddGroup(g, baseG)
		call GroupAddGroup(baseG, g)
		loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                set distance = 0.000
                if(ty == "square")then
                	set loc = GetUnitLoc(u)
					if(is.borderRect(area,GetLocationX(loc),GetLocationY(loc))==true)then
						set deg = AngleBetweenPoints(rectCenter, loc)
						if(deg==0 or deg==180 or deg==-180)then//横
							set distance = rectW
						elseif(deg==90 or deg==-90)then//竖
							set distance = rectH
						elseif(deg>0 and deg <= rectDegA)then //第1三角区间
							set distance = rectW/2/Cos(deg)
						elseif(deg>rectDegA and deg < 90)then //第2三角区间
							set distance = rectH/2/Cos(90-deg)
						elseif(deg>90 and deg <= 90+rectDegB)then //第3三角区间
							set distance = rectH/2/Cos(deg-90)
						elseif(deg>90+rectDegB and deg <180)then //第4三角区间
							set distance = rectW/2/Cos(180-deg)
						elseif(deg<0 and deg >= -rectDegA)then //第5三角区间
							set distance = rectW/2/Cos(deg)
						elseif(deg<rectDegA and deg > -90)then //第6三角区间
							set distance = rectH/2/Cos(90+deg)
						elseif(deg<-90 and deg >= -90-rectDegB)then //第7三角区间
							set distance = rectH/2/Cos(-deg-90)
						elseif(deg<-90-rectDegB and deg >-180)then //第8三角区间
							set distance = rectW/2/Cos(180+deg)
						endif
					endif
				elseif(ty == "circle")then
					set loc = GetUnitLoc(u)
					if( DistanceBetweenPoints(rectCenter, loc) > RMinBJ(rectW/2, rectH/2) )then
						set deg = AngleBetweenPoints(rectCenter, loc)
						set distance = RMinBJ(rectW/2, rectH/2)
					endif
				endif
				if(distance > 0 )then
					set distance = distance * 0.96
					call RemoveLocation(loc)
					set loc = PolarProjectionBJ(rectCenter, distance, deg)
					call SetUnitPositionLoc( u , loc )
					call heffect.toLoc( Effect_MassTeleportTarget , loc , 0)
					call hMsg_ttg2Unit( u,"被困",11,"",20,1,30)
					call RemoveLocation(loc)
				endif
        endloop
        call GroupClear( g )
        call DestroyGroup( g )
        set g = null
        set u = null
		call RemoveLocation(rectCenter)
		set rectCenter = null
		set loc = null
	endmethod
	public method lock takes rect area,string ty,real during returns nothing
		local timer t = null
		local integer recthid = 0
		if(area==null)then
			call console.error("hRect.lock")
			return
		endif
		set recthid = GetHandleId(area)
		set t = LoadTimerHandle(hash_hrect, recthid, HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, recthid, HASH_TIMER , t)
			set t = time.setInterval(0.25,function hRect.lockCall)
			call time.setRect(t,1,area)
			call time.setString(t,2,ty)
			call time.setReal(t,3,during)
			call time.setReal(t,4,0)
			call time.setGroup(t,5,CreateGroup())
		endif
	endmethod

endstruct
