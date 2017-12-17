/* 单位组 */
globals
hGroup hgroup = 0
endglobals

struct hGroup

	/**
	 * 单位组
	 * 以loc点为中心radius距离
	 * filter 条件适配器
	 */
	public static method createByLoc takes location loc,real radius,code filter returns group
	    local group g = null
	    local boolexpr bx = Condition(filter)
	    set g = CreateGroup()
	    call GroupEnumUnitsInRangeOfLoc(g, loc , radius, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return g
	endmethod

	/**
	 * 单位组
	 * 以某个单位为中心radius距离
	 * filter 条件适配器
	 */
	public static method createByUnit takes unit u,real radius,code filter returns group
	    local location loc = GetUnitLoc( u )
	    local group g = createByLoc(loc,radius,filter)
	    call RemoveLocation( loc )
	    set loc = null
	    return g
	endmethod
	
	 /**
	 * 单位组
	 * 以区域为范围选择
	 * filter 条件适配器
	 */
	public static method createByRect takes rect r,code filter returns group
	    local group g = null
	    local boolexpr bx = Condition(filter)
	    set g = CreateGroup()
	    call GroupEnumUnitsInRect(g, r, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return g
	endmethod

	/**
	 * 瞬间移动单位组
	 */
	public static method move takes group whichGroup,location loc,string meffect,boolean isFollow returns nothing
	    local boolean canMove = false
	    local group g = CreateGroup()
	    local unit u = null
	    call GroupAddGroup(g, whichGroup)
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set canMove = true
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit( g , u )
	            call SetUnitPositionLoc( u , loc )
	            if(isFollow == true)then
	                call PanCameraToTimedLocForPlayer( GetOwningPlayer(u), loc, 0.00 )
	            endif
	    endloop
	    if(meffect != null) then
	        call heffect.toLoc(meffect,loc,0)
	    endif
	    set u = null
	    call GroupClear(g)
	    call DestroyGroup(g)
	    set g = null
	endmethod

	/**
	  * 指挥单位组所有单位做动作
	  */
	public static method animate takes group whichGroup,string animateno returns nothing
	    local boolean canAction = false
	    local group g = CreateGroup()
	    local unit u = null
	    call GroupAddGroup(g, whichGroup)
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set canAction = true
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit( g , u )
	            if( IsUnitDeadBJ(u) ) then
	                set canAction = false
	            endif
	            if( canAction == true ) then
	                call SetUnitAnimation( u , animateno )
	            endif
	    endloop
	    set u = null
	    call GroupClear(g)
	    call DestroyGroup(g)
	    set g = null
	endmethod
	
endstruct
