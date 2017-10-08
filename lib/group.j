
library hGroup needs hSys
	
	/**
	 * 瞬间移动单位组
	 */
	public function move takes group g,location loc,string meffect,boolean isFollow returns nothing
	    local unit u = null
	    local boolean canMove = false
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
	endfunction

	/**
	  * 指挥单位组所有单位做动作
	  * damage
	  */
	public function animate takes group g,string action returns nothing
	    local unit u = null
	    local boolean canAction = false
	    loop
	        exitwhen(IsUnitGroupEmptyBJ(g) == true)
	            set canAction = true
	            set u = FirstOfGroup(g)
	            call GroupRemoveUnit( g , u )
	            if( IsUnitDeadBJ(u) ) then
	                set canAction = false
	            endif
	            if( canAction == true ) then
	                call SetUnitAnimation( u , action )
	            endif
	    endloop
	    set u = null
	endfunction

	/**
	 * 单位组
	 * 以point点为中心radius距离
	 * filter 条件适配器
	 */
	public function createByLoc takes location loc,real radius,code filter returns group
	    local group g = null
	    local boolexpr bx = Condition(filter)
	    set g = CreateGroup()
	    call GroupEnumUnitsInRangeOfLoc(g, loc , radius, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return g
	endfunction

	/**
	 * 单位组
	 * 以某个单位为中心radius距离
	 * filter 条件适配器
	 */
	public function createByUnit takes unit u,real radius,code filter returns group
	    local group g = null
	    local boolexpr bx = Condition(filter)
	    local location loc = GetUnitLoc( u )
	    set g = CreateGroup()
	    call GroupEnumUnitsInRangeOfLoc(g,loc, radius, bx)
	    call DestroyBoolExpr(bx)
	    call RemoveLocation( loc )
	    set loc = null
	    set bx = null
	    return g
	endfunction
	
	 /**
	 * 单位组
	 * 以区域为范围选择
	 * filter 条件适配器
	 */
	public function createByRect takes rect r,code filter returns group
	    local group g = null
	    local boolexpr bx = Condition(filter)
	    set g = CreateGroup()
	    call GroupEnumUnitsInRect(g, r, bx)
	    call DestroyBoolExpr(bx)
	    set bx = null
	    return g
	endfunction


	
endlibrary
