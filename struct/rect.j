/* 区域 */
globals
    hRect hrect = 0
    hashtable hash_hrect = null
    integer hash_hrect_do = 100
    integer hash_hrect_rect = 101
    integer hash_hrect_loc = 102
    integer hash_hrect_during = 200
    integer hash_hrect_type = 201
    integer hash_hrect_inc = 202
    integer hash_hrect_width = 203
    integer hash_hrect_height = 204
    integer hash_hrect_group = 205
    integer hash_hrect_unit = 206
endglobals

struct hRect

	private static integer HASH_TIMER = 101
	private static integer HASH_WIDTH = 102
	private static integer HASH_HEIGHT = 103
	private static integer HASH_GROUP = 104
	private static integer HASH_NAME = 105

	static method create takes nothing returns hRect
        local hRect x = 0
        set x = hRect.allocate()
        if(hash_hrect==null)then
        	set hash_hrect = InitHashtable()
        endif
        return x
    endmethod

	/**
	 * 设定中心点（X,Y）创建一个长width宽height的矩形区域
	 */
	public method createInLoc takes real locX , real locY , real width , real height returns rect
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
		call RemoveRect(area)
	endmethod

	//锁定do
	private static method lockCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local string doit = time.getString(t,hash_hrect_do)
		local string ty = time.getString(t,hash_hrect_type)
		local real during = time.getReal(t,hash_hrect_during)
		local real inc = time.getReal(t,hash_hrect_inc)
		local group baseG = time.getGroup(t,hash_hrect_group)

		local rect area = null

		local real deg = 0
		local real distance = 0
		local location rectCenter = null
		local integer recthid = 0
		local real lockW = 0
		local real lockH = 0
		local real lockDegA = 0
		local real lockDegB = 0
		local location loc = null
		local group g = null
		local unit u = null

		if(ty!="square" and ty!="circle")then
			call time.delTimer(t)
			return
		endif
		if(inc>0 and during>0 and inc>=during)then
			call time.delTimer(t)
			return
		endif
		if(doit == "rect")then
			set area = time.getRect(t,hash_hrect_rect)
			if(area==null)then
				call time.delTimer(t)
				return
			endif
			set rectCenter = GetRectCenter(area)
			set recthid = GetHandleId(area)
			set lockW = LoadReal(hash_hrect, recthid, hRect.HASH_WIDTH)
			set lockH = LoadReal(hash_hrect, recthid, hRect.HASH_HEIGHT)
		elseif(doit == "loc")then
			set rectCenter = time.getLoc(t,hash_hrect_loc)
			if(rectCenter==null)then
				call time.delTimer(t)
				return
			endif
			set lockW = time.getReal(t,hash_hrect_width)
			set lockH = time.getReal(t,hash_hrect_height)
		elseif(doit == "unit")then
			set rectCenter = GetUnitLoc(time.getUnit(t,hash_hrect_unit))
			if(rectCenter==null)then
				call time.delTimer(t)
				return
			endif
			set lockW = time.getReal(t,hash_hrect_width)
			set lockH = time.getReal(t,hash_hrect_height)
		else
			call console.error("lockCall hash_hrect_do error")
		endif

		set lockDegA = (180 * Atan(lockH/lockW)) / bj_PI
		set lockDegB = 90 - lockDegA
		if(lockW<=0 or lockH<=0)then
			call console.error("lockCall rect worh<=0")
			call time.delTimer(t)
			return
		endif

		call time.setReal(t,hash_hrect_inc,inc+time.getSetTime(t))

		set g = GetUnitsInRectAll(area)
		call GroupAddGroup(g, baseG)
		call GroupAddGroup(baseG, g)
		if(ty == "square")then
			if(doit == "loc" or doit == "unit")then
				set area = Rect( GetLocationX(rectCenter)-(lockW*0.5),GetLocationY(rectCenter)-(lockH*0.5),GetLocationX(rectCenter)+(lockW*0.5),GetLocationY(rectCenter)+(lockH*0.5))
			endif
			set g = GetUnitsInRectAll(area)
		elseif(ty == "circle")then
			set g = GetUnitsInRangeOfLocAll(RMinBJ(lockW/2, lockH/2), rectCenter)
		endif

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
							set distance = lockW
						elseif(deg==90 or deg==-90)then//竖
							set distance = lockH
						elseif(deg>0 and deg <= lockDegA)then //第1三角区间
							set distance = lockW/2/CosBJ(deg)
						elseif(deg>lockDegA and deg < 90)then //第2三角区间
							set distance = lockH/2/CosBJ(90-deg)
						elseif(deg>90 and deg <= 90+lockDegB)then //第3三角区间
							set distance = lockH/2/CosBJ(deg-90)
						elseif(deg>90+lockDegB and deg <180)then //第4三角区间
							set distance = lockW/2/CosBJ(180-deg)
						elseif(deg<0 and deg >= -lockDegA)then //第5三角区间
							set distance = lockW/2/CosBJ(deg)
						elseif(deg<lockDegA and deg > -90)then //第6三角区间
							set distance = lockH/2/CosBJ(90+deg)
						elseif(deg<-90 and deg >= -90-lockDegB)then //第7三角区间
							set distance = lockH/2/CosBJ(-deg-90)
						elseif(deg<-90-lockDegB and deg >-180)then //第8三角区间
							set distance = lockW/2/CosBJ(180+deg)
						endif
					endif
				elseif(ty == "circle")then
					set loc = GetUnitLoc(u)
					if( DistanceBetweenPoints(rectCenter, loc) > RMinBJ(lockW/2, lockH/2) )then
						set deg = AngleBetweenPoints(rectCenter, loc)
						set distance = RMinBJ(lockW/2, lockH/2)
					endif
				endif
				if(distance > 0 )then
					call RemoveLocation(loc)
					set loc = PolarProjectionBJ(rectCenter, distance, deg)
					call SetUnitPositionLoc( u , loc )
					call RemoveLocation(loc)
					call heffect.toUnit( "Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl" , u , "origin" , 0.2)
					call hmsg.style(hmsg.ttg2Unit( u,"被困",10,"dde6f3",30,1,20),"shrink",0,0.2)
				endif
        endloop

        if(doit == "rect" or doit == "unit")then
        	call RemoveLocation(rectCenter)
			set rectCenter = null
        elseif(doit == "loc" or doit == "unit")then
        	if(area!=null)then
        		call RemoveRect(area)
        	endif
		endif

        call GroupClear( g )
        call DestroyGroup( g )
        set g = null
        set u = null
		set loc = null
	endmethod

	//锁定所有单位在某个区域无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//during 持续时间 0 则直到调用delLockByRect
	public method lockByRect takes rect area,string ty,real during returns nothing
		local timer t = null
		local integer recthid = 0
		if(area==null)then
			call console.error("hRect.lockByRect")
			return
		endif
		set recthid = GetHandleId(area)
		set t = LoadTimerHandle(hash_hrect, recthid, HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, recthid, HASH_TIMER , t)
			set t = time.setInterval(0.1,function hRect.lockCall)
			call time.setString(t,hash_hrect_do,"rect")
			call time.setRect(t,hash_hrect_rect,area)
			call time.setString(t,hash_hrect_type,ty)
			call time.setReal(t,hash_hrect_during,during)
			call time.setReal(t,hash_hrect_inc,0)
			call time.setGroup(t,hash_hrect_group,CreateGroup())
		endif
	endmethod

	//锁定所有单位在某个点附近一段距离无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//width 矩形则为长度，圆形取小的为半径
	//height 矩形则为宽度，圆形取小的为半径
	//during 持续时间 0 则直到调用delLockByLoc
	public method lockByLoc takes location loc,string ty,real width,real height,real during returns nothing
		local timer t = null
		local integer locid = 0
		if(loc==null)then
			call console.error("hRect.lockByLoc")
			return
		endif
		set locid = GetHandleId(loc)
		set t = LoadTimerHandle(hash_hrect, locid, HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, locid, HASH_TIMER , t)
			set t = time.setInterval(0.1,function hRect.lockCall)
			call time.setString(t,hash_hrect_do,"loc")
			call time.setLoc(t,hash_hrect_loc,loc)
			call time.setString(t,hash_hrect_type,ty)
			call time.setReal(t,hash_hrect_during,during)
			call time.setReal(t,hash_hrect_inc,0)
			call time.setReal(t,hash_hrect_width,width)
			call time.setReal(t,hash_hrect_height,height)
			call time.setGroup(t,hash_hrect_group,CreateGroup())
		endif
	endmethod

	//锁定所有单位在某个单位附近一段距离无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//width 矩形则为长度，圆形取小的为半径
	//height 矩形则为宽度，圆形取小的为半径
	//during 持续时间 0 则直到调用delLockByLoc
	public method lockByUnit takes unit u,string ty,real width,real height,real during returns nothing
		local timer t = null
		local integer hid = 0
		if(u==null)then
			call console.error("hRect.lockByUnit")
			return
		endif
		set hid = GetHandleId(u)
		set t = LoadTimerHandle(hash_hrect, hid, HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, hid, HASH_TIMER , t)
			set t = time.setInterval(0.1,function hRect.lockCall)
			call time.setString(t,hash_hrect_do,"unit")
			call time.setUnit(t,hash_hrect_unit,u)
			call time.setString(t,hash_hrect_type,ty)
			call time.setReal(t,hash_hrect_during,during)
			call time.setReal(t,hash_hrect_inc,0)
			call time.setReal(t,hash_hrect_width,width)
			call time.setReal(t,hash_hrect_height,height)
			call time.setGroup(t,hash_hrect_group,CreateGroup())
		endif
	endmethod

	//删除锁定区域
	public method delLockByRect takes rect area returns nothing
		local integer hid = GetHandleId(area)
		local timer t = LoadTimerHandle(hash_hrect, hid, HASH_TIMER)
		if(t != null)then
			call time.delTimer(t)
    		call SaveTimerHandle(hash_hrect, hid, HASH_TIMER , null)
    	endif
	endmethod
	//删除锁定点
	public method delLockByLoc takes location loc returns nothing
		local integer hid = GetHandleId(loc)
		local timer t = LoadTimerHandle(hash_hrect, hid, HASH_TIMER)
		if(t != null)then
			call time.delTimer(t)
    		call SaveTimerHandle(hash_hrect, hid, HASH_TIMER , null)
    	endif
	endmethod
	//删除锁定单位
	public method delLockByUnit takes unit u returns nothing
		local integer hid = GetHandleId(u)
		local timer t = LoadTimerHandle(hash_hrect, hid, HASH_TIMER)
		if(t != null)then
			call time.delTimer(t)
    		call SaveTimerHandle(hash_hrect, hid, HASH_TIMER , null)
    	endif
	endmethod

	//设置区域名称
	public method setName takes rect whichRect,string name returns nothing
		call SaveStr(hash_hrect, GetHandleId(whichRect),HASH_NAME,name)
	endmethod

	//获取区域名称
	public method getName takes rect whichRect returns string
		return LoadStr(hash_hrect, GetHandleId(whichRect),HASH_NAME)
	endmethod

endstruct
