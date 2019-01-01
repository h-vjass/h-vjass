/* 
 * 单位组 
 */
globals
hGroup hgroup
group hjass_global_group = null
endglobals

struct hGroup

	/**
	 * 统计单位组当前单位数
	 */
	public static method count takes group whichGroup returns integer
		if(whichGroup == null)then
			return -1
		endif
		return CountUnitsInGroup(whichGroup)
	endmethod

	/**
	 * 判断单位是否在单位组内
	 */
	public static method isIn takes unit whichUnit,group whichGroup returns boolean
		if(whichGroup == null)then
			return false
		endif
		return IsUnitInGroup(whichUnit, whichGroup)
	endmethod

	/**
	 * 判断单位组是否为空
	 */
	public static method isEmpty takes group whichGroup returns boolean
		if(whichGroup == null)then
			return true
		endif
		return IsUnitGroupEmptyBJ(whichGroup)
	endmethod

	/**
	 * 把单位加进单位组内
	 */
	public static method in takes unit whichUnit,group whichGroup returns nothing
		if(isIn(whichUnit, whichGroup) == false) then
			call GroupAddUnit(whichGroup, whichUnit)
		endif
	endmethod
	
	/**
	 * 把单位移出单位组
	 */
	public static method out takes unit whichUnit,group whichGroup returns nothing
		if(isIn(whichUnit, whichGroup) == true) then
			call GroupRemoveUnit(whichGroup, whichUnit)
		endif
	endmethod

	/**
	 * 单位组
	 * 以loc点为中心radius距离
	 * filter 条件适配器
	 */
	public static method createByLoc takes location loc,real radius,code filter returns group
		local boolexpr bx = Condition(filter)
		//镜头放大模式下，范围缩小一半
		if(hcamera.model=="zoomin")then
			set radius = radius * 0.5
		endif
		set bx = Condition(filter)
	    set hjass_global_group = CreateGroup()
	    call GroupEnumUnitsInRangeOfLoc(hjass_global_group, loc , radius, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return hjass_global_group
	endmethod

	/**
	 * 单位组
	 * 以某个单位为中心radius距离
	 * filter 条件适配器
	 */
	public static method createByUnit takes unit u,real radius,code filter returns group
	    local location loc = GetUnitLoc( u )
	    set hjass_global_group = createByLoc(loc,radius,filter)
	    call RemoveLocation(loc)
	    set loc = null
	    return hjass_global_group
	endmethod
	
	 /**
	 * 单位组
	 * 以区域为范围选择
	 * filter 条件适配器
	 */
	public static method createByRect takes rect r,code filter returns group
		local boolexpr bx = Condition(filter)
	    set hjass_global_group = CreateGroup()
	    call GroupEnumUnitsInRect(hjass_global_group, r, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return hjass_global_group
	endmethod

	/**
	 * 瞬间移动单位组
	 */
	public static method move takes group whichGroup,location loc,string meffect,boolean isFollow returns nothing
		local group g = null
		local unit u = null
		if(whichGroup == null or loc == null)then
			return
		endif
		set g = CreateGroup()
	    call GroupAddGroup(g, whichGroup)
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit(g,u)
	            call SetUnitPositionLoc(u,loc)
	            if(isFollow == true)then
	                call PanCameraToTimedLocForPlayer(GetOwningPlayer(u), loc, 0.00)
	            endif
				set u = null
	    endloop
	    if(meffect != null) then
	        call heffect.toLoc(meffect,loc,0)
	    endif
	    call GroupClear(g)
	    call DestroyGroup(g)
	    set g = null
	endmethod

	/**
	  * 指挥单位组所有单位做动作
	  */
	public static method animate takes group whichGroup,string animateno returns nothing
		local group g = null
		local unit u = null
		if(whichGroup == null or animateno == null or animateno == "")then
			return
		endif
		set g = CreateGroup()
	    call GroupAddGroup(g, whichGroup)
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit(g,u)
	            if(IsUnitDeadBJ(u) == false) then
	                call SetUnitAnimation(u, animateno)
	            endif
				set u = null
	    endloop
	    call GroupClear(g)
	    call DestroyGroup(g)
	    set g = null
	endmethod

	/**
	  * 清空单位组
	  * isDestroy 是否同时删除单位组
	  * isDestroyUnit 是否同时删除单位组里面的单位
	  */
	public static method clear takes group whichGroup,boolean isDestroy,boolean isDestroyUnit returns nothing
		local unit u = null
		if (whichGroup == null) then
			return
		endif
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(whichGroup) == true)
	            set u = FirstOfGroup(whichGroup)
	            call GroupRemoveUnit(whichGroup,u)
	            if( isDestroyUnit == true ) then
	                call RemoveUnit(u)
	            endif
				set u = null
	    endloop
		if(isDestroy == true)then
			call DestroyGroup(whichGroup)
	    	set whichGroup = null
		endif
	endmethod
	
endstruct
