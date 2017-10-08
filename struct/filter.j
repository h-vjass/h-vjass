/* 判定过滤器 */

struct hFilter

	static hashtable hash = null
	static integer hashKey = 0

	private method format takes nothing returns nothing
		call SaveInteger(hash, hashKey , 100,0)
		call SaveInteger(hash, hashKey , 101,0)
		call SaveInteger(hash, hashKey , 102,0)
		call SaveInteger(hash, hashKey , 103,0)
		call SaveInteger(hash, hashKey , 104,0)
		call SaveInteger(hash, hashKey , 105,0)
		call SaveInteger(hash, hashKey , 106,0)
		call SaveInteger(hash, hashKey , 107,0)
		call SaveInteger(hash, hashKey , 108,0)
		call SaveInteger(hash, hashKey , 109,0)
		call SaveInteger(hash, hashKey , 1010,0)
		call SaveInteger(hash, hashKey , 1011,0)
		call SaveInteger(hash, hashKey , 1012,0)
		call SaveInteger(hash, hashKey , 1013,0)
		call SaveInteger(hash, hashKey , 1014,0)
		call SaveInteger(hash, hashKey , 1015,0)
		call SaveInteger(hash, hashKey , 1016,0)
		call SaveInteger(hash, hashKey , 1017,0)
		call SaveInteger(hash, hashKey , 2000,0)
	endmethod

	static method create takes nothing returns hFilter
		local hFilter s = 0
		set s = hFilter.allocate()
		set s.hash = InitHashtable()
		set s.hashKey = 951753
		call s.format()
		return s
	endmethod
	method onDestroy takes nothing returns nothing
		set hash = null
		set hashKey = 0
	endmethod

	//
	public method setUnit takes unit u returns nothing
		call SaveUnitHandle(hash, hashKey , 1, u)
	endmethod
	private static method getUnit takes nothing returns unit
	    return LoadUnitHandle(hash, hashKey , 1)
	endmethod
	//
	public method setOwnItemId takes integer itemId returns nothing
        call SaveInteger(hash, hashKey , 2000, itemId)
	endmethod
	private static method getOwnItemId takes nothing returns integer
	    return LoadInteger(hash, hashKey , 2000)
	endmethod
	//
	public method isEnemy takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 100, 1)
	    else
	        call SaveInteger(hash, hashKey , 100, -1)
	    endif
	endmethod
	public method isAlly takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 101, 1)
	    else
	        call SaveInteger(hash, hashKey , 101, -1)
	    endif
	endmethod
	public method isDeath takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 102, 1)
	    else
	        call SaveInteger(hash, hashKey , 102, -1)
	    endif
	endmethod
	public method isAlive takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 103, 1)
	    else
	        call SaveInteger(hash, hashKey , 103, -1)
	    endif
	endmethod
	public method isInvincible takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 104, 1)
	    else
	        call SaveInteger(hash, hashKey , 104, -1)
	    endif
	endmethod
	public method isHero takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 105, 1)
	    else
	        call SaveInteger(hash, hashKey , 105, -1)
	    endif
	endmethod
	public method isBuilding takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 106, 1)
	    else
	        call SaveInteger(hash, hashKey , 106, -1)
	    endif
	endmethod
	public method isIllusion takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 107, 1)
	    else
	        call SaveInteger(hash, hashKey , 107, -1)
	    endif
	endmethod
	public method isGround takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 108, 1)
	    else
	        call SaveInteger(hash, hashKey , 108, -1)
	    endif
	endmethod
	public method isFlying takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 109, 1)
	    else
	        call SaveInteger(hash, hashKey , 109, -1)
	    endif
	endmethod
	public method isMelee takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1010, 1)
	    else
	        call SaveInteger(hash, hashKey , 1010, -1)
	    endif
	endmethod
	public method isRanged takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1011, 1)
	    else
	        call SaveInteger(hash, hashKey , 1011, -1)
	    endif
	endmethod
	public method isSummoned takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1012, 1)
	    else
	        call SaveInteger(hash, hashKey , 1012, -1)
	    endif
	endmethod
	public method isMechanical takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1013, 1)
	    else
	        call SaveInteger(hash, hashKey , 1013, -1)
	    endif
	endmethod
	public method isAncient takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1014, 1)
	    else
	        call SaveInteger(hash, hashKey , 1014, -1)
	    endif
	endmethod
	public method isWater takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1015, 1)
	    else
	        call SaveInteger(hash, hashKey , 1015, -1)
	    endif
	endmethod
	public method isFloor takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1016, 1)
	    else
	        call SaveInteger(hash, hashKey , 1016, -1)
	    endif
	endmethod
	public method isOwnItem takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hash, hashKey , 1017, 1)
	    else
	        call SaveInteger(hash, hashKey , 1017, -1)
	    endif
	endmethod
	private static method getIsEnemy takes nothing returns integer
	    return LoadInteger(hash, hashKey , 100)
	endmethod
	private static method getIsAlly takes nothing returns integer
	    return LoadInteger(hash, hashKey , 101)
	endmethod
	private static method getIsDeath takes nothing returns integer
	    return LoadInteger(hash, hashKey , 102)
	endmethod
	private static method getIsAlive takes nothing returns integer
	    return LoadInteger(hash, hashKey , 103)
	endmethod
	private static method getIsInvincible takes nothing returns integer
	    return LoadInteger(hash, hashKey , 104)
	endmethod
	private static method getIsHero takes nothing returns integer
	    return LoadInteger(hash, hashKey , 105)
	endmethod
	private static method getIsBuilding takes nothing returns integer
	    return LoadInteger(hash, hashKey , 106)
	endmethod
	private static method getIsIllusion takes nothing returns integer
	    return LoadInteger(hash, hashKey , 107)
	endmethod
	private static method getIsGround takes nothing returns integer
	    return LoadInteger(hash, hashKey , 108)
	endmethod
	private static method getIsFlying takes nothing returns integer
	    return LoadInteger(hash, hashKey , 109)
	endmethod
	private static method getIsMelee takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1010)
	endmethod
	private static method getIsRanged takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1011)
	endmethod
	private static method getIsSummoned takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1012)
	endmethod
	private static method getIsMechanical takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1013)
	endmethod
	private static method getIsAncient takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1014)
	endmethod
	private static method getIsWater takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1015)
	endmethod
	private static method getIsFloor takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1016)
	endmethod
	private static method getIsOwnItem takes nothing returns integer
	    return LoadInteger(hash, hashKey , 1017)
	endmethod

	public static method get takes nothing returns boolean
		local unit filterUnit = GetFilterUnit()
		local unit u = getUnit()
		local boolean status = true
		if(getIsEnemy() == 1 and is.enemy(filterUnit,u)==false)then
			set status = false
		endif
		if(getIsEnemy() == -1 and is.enemy(filterUnit,u)==true)then
			set status = false
		endif
		if(getIsAlly() == 1 and is.ally(filterUnit,u)==false)then
			set status = false
		endif
		if(getIsAlly() == -1 and is.ally(filterUnit,u)==true)then
			set status = false
		endif
		if(getIsDeath() == 1 and is.death(filterUnit)==false)then
			set status = false
		endif
		if(getIsDeath() == -1 and is.death(filterUnit)==true)then
			set status = false
		endif
		if(getIsAlive() == 1 and is.alive(filterUnit)==false)then
			set status = false
		endif
		if(getIsAlive() == -1 and is.alive(filterUnit)==true)then
			set status = false
		endif
		if(getIsInvincible() == 1 and is.invincible(filterUnit)==false)then
			set status = false
		endif
		if(getIsInvincible() == -1 and is.invincible(filterUnit)==true)then
			set status = false
		endif
		if(getIsHero() == 1 and is.hero(filterUnit)==false)then
			set status = false
		endif
		if(getIsHero() == -1 and is.hero(filterUnit)==true)then
			set status = false
		endif
		if(getIsBuilding() == 1 and is.building(filterUnit)==false)then
			set status = false
		endif
		if(getIsBuilding() == -1 and is.building(filterUnit)==true)then
			set status = false
		endif
		if(getIsIllusion() == 1 and is.illusion(filterUnit)==false)then
			set status = false
		endif
		if(getIsIllusion() == -1 and is.illusion(filterUnit)==true)then
			set status = false
		endif
		if(getIsGround() == 1 and is.ground(filterUnit)==false)then
			set status = false
		endif
		if(getIsGround() == -1 and is.ground(filterUnit)==true)then
			set status = false
		endif
		if(getIsFlying() == 1 and is.flying(filterUnit)==false)then
			set status = false
		endif
		if(getIsFlying() == -1 and is.flying(filterUnit)==true)then
			set status = false
		endif
		if(getIsMelee() == 1 and is.melee(filterUnit)==false)then
			set status = false
		endif
		if(getIsMelee() == -1 and is.melee(filterUnit)==true)then
			set status = false
		endif
		if(getIsRanged() == 1 and is.ranged(filterUnit)==false)then
			set status = false
		endif
		if(getIsRanged() == -1 and is.ranged(filterUnit)==true)then
			set status = false
		endif
		if(getIsSummoned() == 1 and is.summoned(filterUnit)==false)then
			set status = false
		endif
		if(getIsSummoned() == -1 and is.summoned(filterUnit)==true)then
			set status = false
		endif
		if(getIsAncient() == 1 and is.ancient(filterUnit)==false)then
			set status = false
		endif
		if(getIsAncient() == -1 and is.ancient(filterUnit)==true)then
			set status = false
		endif
		if(getIsWater() == 1 and is.water(filterUnit)==false)then
			set status = false
		endif
		if(getIsWater() == -1 and is.water(filterUnit)==true)then
			set status = false
		endif
		if(getIsFloor() == 1 and is.floor(filterUnit)==false)then
			set status = false
		endif
		if(getIsFloor() == -1 and is.floor(filterUnit)==true)then
			set status = false
		endif
		if(getIsOwnItem() == 1 and getOwnItemId()!=0 and is.ownItem(filterUnit,getOwnItemId())==false)then
			set status = false
		endif
		if(getIsOwnItem() == -1 and getOwnItemId()!=0 and is.ownItem(filterUnit,getOwnItemId())==true)then
			set status = false
		endif
		return status
	endmethod

endstruct
