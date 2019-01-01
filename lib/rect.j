//区域
globals
    hRect hrect
	rect hjass_global_rect = null
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
	private static integer HASH_START_X = 106
	private static integer HASH_START_Y = 107
	private static integer HASH_END_X = 108
	private static integer HASH_END_Y = 109

	static method create takes nothing returns hRect
        local hRect x = 0
        set x = hRect.allocate()
        return x
    endmethod

	/**
	 * 设定中心点（X,Y）创建一个长width宽height的矩形区域
	 */
	public static method createInLoc takes real locX , real locY , real width , real height returns rect
		local real startX = locX-(width * 0.5)
		local real startY = locY-(height * 0.5)
		local real endX = locX+(width * 0.5)
		local real endY = locY+(height * 0.5)
		set hjass_global_rect = Rect( startX , startY , endX , endY )
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_WIDTH , width)
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_HEIGHT , height)
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_START_X , startX)
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_START_Y , startY)
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_END_X , endX)
		call SaveReal(hash_hrect, GetHandleId(hjass_global_rect), HASH_END_Y , endY)
		return hjass_global_rect
	endmethod

	public static method getWidth takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_WIDTH)
	endmethod

	public static method getHeight takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_HEIGHT)
	endmethod

	public static method getStartX takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_START_X)
	endmethod
	public static method getStartY takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_START_Y)
	endmethod
	public static method getEndX takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_END_X)
	endmethod
	public static method getEndY takes rect r returns real
		return LoadReal(hash_hrect, GetHandleId(r), HASH_END_Y)
	endmethod

	//设置区域名称
	public static method setName takes rect whichRect,string name returns nothing
		call SaveStr(hash_hrect, GetHandleId(whichRect),HASH_NAME,name)
	endmethod

	//获取区域名称
	public static method getName takes rect whichRect returns string
		return LoadStr(hash_hrect, GetHandleId(whichRect),HASH_NAME)
	endmethod

	//删除区域
	public static method del takes rect area returns nothing
		call FlushChildHashtable(hash_hrect,GetHandleId(area))
		call FlushChildHashtable(hash_trigger,GetHandleId(area))
		call FlushChildHashtable(hash_trigger_register,GetHandleId(area))
		call RemoveRect(area)
	endmethod

	//锁定do
	private static method lockCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local string rdo = htime.getString(t,hash_hrect_do)
		local string rtype = htime.getString(t,hash_hrect_type)
		local location loc = null
		local group g = null
		local unit u = null
		local real during = htime.getReal(t,hash_hrect_during)
		local real inc = htime.getReal(t,hash_hrect_inc)
		local rect area = null
		local real deg = 0
		local real distance = 0
		local location rectCenter = null
		local integer recthid = 0
		local real lockW = 0
		local real lockH = 0
		local real lockDegA = 0
		local real lockDegB = 0
		if(rtype!="square" and rtype!="circle")then
			call htime.delTimer(t)
			set t = null
			set rdo = null
			set rtype = null
			return
		endif
		if(inc>0 and during>0 and inc>=during)then
			call htime.delTimer(t)
			set t = null
			set rdo = null
			set rtype = null
			return
		endif
		if(rdo == "rect")then
			set area = htime.getRect(t,hash_hrect_rect)
			if(area==null)then
				call htime.delTimer(t)
				set t = null
				set rdo = null
				set rtype = null
				return
			endif
			set rectCenter = GetRectCenter(area)
			set recthid = GetHandleId(area)
			set lockW = LoadReal(hash_hrect, recthid, hRect.HASH_WIDTH)
			set lockH = LoadReal(hash_hrect, recthid, hRect.HASH_HEIGHT)
		elseif(rdo == "loc")then
			set rectCenter = htime.getLoc(t,hash_hrect_loc)
			if(rectCenter==null)then
				call htime.delTimer(t)
				set t = null
				set rdo = null
				set rtype = null
				return
			endif
			set lockW = htime.getReal(t,hash_hrect_width)
			set lockH = htime.getReal(t,hash_hrect_height)
		elseif(rdo == "unit")then
			set rectCenter = GetUnitLoc(htime.getUnit(t,hash_hrect_unit))
			if(rectCenter==null)then
				call htime.delTimer(t)
				set t = null
				set rdo = null
				set rtype = null
				return
			endif
			set lockW = htime.getReal(t,hash_hrect_width)
			set lockH = htime.getReal(t,hash_hrect_height)
		else
			call hconsole.error("lockCall hash_hrect_do error")
		endif

		set lockDegA = (180 * Atan(lockH/lockW)) / bj_PI
		set lockDegB = 90 - lockDegA
		if(lockW<=0 or lockH<=0)then
			call hconsole.error("lockCall rect worh<=0")
			call htime.delTimer(t)
			set t = null
			set rdo = null
			set rtype = null
			return
		endif

		call htime.setReal(t,hash_hrect_inc,inc+htime.getSetTime(t))

		set g = GetUnitsInRectAll(area)
		call GroupAddGroup(g, htime.getGroup(t,hash_hrect_group))
		call GroupAddGroup(htime.getGroup(t,hash_hrect_group), g)
		if(rtype == "square")then
			if(rdo == "loc" or rdo == "unit")then
				set area = Rect( GetLocationX(rectCenter)-(lockW*0.5),GetLocationY(rectCenter)-(lockH*0.5),GetLocationX(rectCenter)+(lockW*0.5),GetLocationY(rectCenter)+(lockH*0.5))
			endif
			set g = GetUnitsInRectAll(area)
		elseif(rtype == "circle")then
			set g = GetUnitsInRangeOfLocAll(RMinBJ(lockW/2, lockH/2), rectCenter)
		endif

		call GroupAddGroup(g, htime.getGroup(t,hash_hrect_group))
		call GroupAddGroup(htime.getGroup(t,hash_hrect_group), g)

		loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                set distance = 0.000
                if(rtype == "square")then
                	set loc = GetUnitLoc(u)
					if(his.borderRect(area,GetLocationX(loc),GetLocationY(loc))==true)then
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
					set loc = null
				elseif(rtype == "circle")then
					set loc = GetUnitLoc(u)
					if( DistanceBetweenPoints(rectCenter, loc) > RMinBJ(lockW/2, lockH/2) )then
						set deg = AngleBetweenPoints(rectCenter, loc)
						set distance = RMinBJ(lockW/2, lockH/2)
					endif
					set loc = null
				endif
				if(distance > 0 )then
					call RemoveLocation(loc)
					set loc = PolarProjectionBJ(rectCenter, distance, deg)
					call SetUnitPositionLoc( u , loc )
					call RemoveLocation(loc)
					set loc = null
					call heffect.toUnit( "Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl" , u , "origin" , 0.2)
					call hmsg.style(hmsg.ttg2Unit( u,"被困",10,"dde6f3",30,1,20),"shrink",0,0.2)
				endif
				set u = null
        endloop
        if(rdo == "rect" or rdo == "unit")then
        	call RemoveLocation(rectCenter)
			set rectCenter = null
        elseif(rdo == "loc" or rdo == "unit")then
        	if(area!=null)then
        		call RemoveRect(area)
				set area = null
        	endif
		endif
        call GroupClear( g )
        call DestroyGroup( g )
		set t = null
		set rdo = null
		set rtype = null
		set loc = null
		set u = null
		set g = null
	endmethod

	//锁定所有单位在某个区域无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//during 持续时间 0 则直到调用delLockByRect
	public static method lockByRect takes rect area,string ty,real during returns nothing
		local timer t = null
		if(area==null)then
			call hconsole.error("hRect.lockByRect")
			return
		endif
		set t = LoadTimerHandle(hash_hrect, GetHandleId(area), HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, GetHandleId(area), HASH_TIMER , t)
			set t = htime.setInterval(0.1,function thistype.lockCall)
			call htime.setString(t,hash_hrect_do,"rect")
			call htime.setRect(t,hash_hrect_rect,area)
			call htime.setString(t,hash_hrect_type,ty)
			call htime.setReal(t,hash_hrect_during,during)
			call htime.setReal(t,hash_hrect_inc,0)
			call htime.setGroup(t,hash_hrect_group,CreateGroup())
			set t = null
		endif
	endmethod

	//锁定所有单位在某个点附近一段距离无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//width 矩形则为长度，圆形取小的为半径
	//height 矩形则为宽度，圆形取小的为半径
	//during 持续时间 0 则直到调用delLockByLoc
	public static method lockByLoc takes location loc,string ty,real width,real height,real during returns nothing
		local timer t = null
		if(loc==null)then
			call hconsole.error("hRect.lockByLoc")
			return
		endif
		set t = LoadTimerHandle(hash_hrect, GetHandleId(loc), HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, GetHandleId(loc), HASH_TIMER , t)
			set t = htime.setInterval(0.1,function thistype.lockCall)
			call htime.setString(t,hash_hrect_do,"loc")
			call htime.setLoc(t,hash_hrect_loc,loc)
			call htime.setString(t,hash_hrect_type,ty)
			call htime.setReal(t,hash_hrect_during,during)
			call htime.setReal(t,hash_hrect_inc,0)
			call htime.setReal(t,hash_hrect_width,width)
			call htime.setReal(t,hash_hrect_height,height)
			call htime.setGroup(t,hash_hrect_group,CreateGroup())
			set t = null
		endif
	endmethod

	//锁定所有单位在某个单位附近一段距离无法离开
	//area 区域
	//ty 类型有：[square|circle][矩形|圆形]
	//width 矩形则为长度，圆形取小的为半径
	//height 矩形则为宽度，圆形取小的为半径
	//during 持续时间 0 则直到调用delLockByLoc
	public static method lockByUnit takes unit u,string ty,real width,real height,real during returns nothing
		local timer t = null
		if(u==null)then
			call hconsole.error("hRect.lockByUnit")
			return
		endif
		set t = LoadTimerHandle(hash_hrect, GetHandleId(u), HASH_TIMER)
		if(t == null)then
			call SaveTimerHandle(hash_hrect, GetHandleId(u), HASH_TIMER , t)
			set t = htime.setInterval(0.1,function thistype.lockCall)
			call htime.setString(t,hash_hrect_do,"unit")
			call htime.setUnit(t,hash_hrect_unit,u)
			call htime.setString(t,hash_hrect_type,ty)
			call htime.setReal(t,hash_hrect_during,during)
			call htime.setReal(t,hash_hrect_inc,0)
			call htime.setReal(t,hash_hrect_width,width)
			call htime.setReal(t,hash_hrect_height,height)
			call htime.setGroup(t,hash_hrect_group,CreateGroup())
			set t = null
		endif
	endmethod

	//删除锁定区域
	public static method delLockByRect takes rect area returns nothing
		local timer t = LoadTimerHandle(hash_hrect, GetHandleId(area), HASH_TIMER)
		if(t != null)then
			call htime.delTimer(t)
			set t = null
    		call SaveTimerHandle(hash_hrect, GetHandleId(area), HASH_TIMER , null)
    	endif
	endmethod
	//删除锁定点
	public static method delLockByLoc takes location loc returns nothing
		local timer t = LoadTimerHandle(hash_hrect, GetHandleId(loc), HASH_TIMER)
		if(t != null)then
			call htime.delTimer(t)
			set t = null
    		call SaveTimerHandle(hash_hrect, GetHandleId(loc), HASH_TIMER , null)
    	endif
	endmethod
	//删除锁定单位
	public static method delLockByUnit takes unit u returns nothing
		local timer t = LoadTimerHandle(hash_hrect, GetHandleId(u), HASH_TIMER)
		if(t != null)then
			call htime.delTimer(t)
			set t = null
    		call SaveTimerHandle(hash_hrect, GetHandleId(u), HASH_TIMER , null)
    	endif
	endmethod

endstruct
