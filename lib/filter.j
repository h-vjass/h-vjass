//判定过滤器
struct hFilter

	private static unit thisUnit = null
	private static integer ownItemId = 0
	private static unit isWhichUnit = null

	private static integer is_enemy = 0
	private static integer is_ally = 0
	private static integer is_death = 0
	private static integer is_alive = 0
	private static integer is_invincible = 0
	private static integer is_hero = 0
	private static integer is_building = 0
	private static integer is_illusion = 0
	private static integer is_ground = 0
	private static integer is_flying = 0
	private static integer is_melee = 0
	private static integer is_ranged = 0
	private static integer is_summoned = 0
	private static integer is_mechanical = 0
	private static integer is_ancient = 0
	private static integer is_water = 0
	private static integer is_floor = 0
	private static integer is_ownItem = 0

	static method create takes nothing returns hFilter
		local hFilter s = 0
		set s = hFilter.allocate()
		
		set s.is_enemy = 0
		set s.is_ally = 0
		set s.is_death = 0
		set s.is_alive = 0
		set s.is_invincible = 0
		set s.is_hero = 0
		set s.is_building = 0
		set s.is_illusion = 0
		set s.is_ground = 0
		set s.is_flying = 0
		set s.is_melee = 0
		set s.is_ranged = 0
		set s.is_summoned = 0
		set s.is_mechanical = 0
		set s.is_ancient = 0
		set s.is_water = 0
		set s.is_floor = 0
		set s.is_ownItem = 0

		return s
	endmethod
	method destroy takes nothing returns nothing
		set thisUnit = null
		set ownItemId = 0
		set isWhichUnit = null
		set is_enemy = 0
		set is_ally = 0
		set is_death = 0
		set is_alive = 0
		set is_invincible = 0
		set is_hero = 0
		set is_building = 0
		set is_illusion = 0
		set is_ground = 0
		set is_flying = 0
		set is_melee = 0
		set is_ranged = 0
		set is_summoned = 0
		set is_mechanical = 0
		set is_ancient = 0
		set is_water = 0
		set is_floor = 0
		set is_ownItem = 0
	endmethod

	//
	public method setUnit takes unit u returns nothing
		set thisUnit = u
	endmethod
	//
	public method setOwnItemId takes integer itemId returns nothing
        set ownItemId = itemId
	endmethod

	//-COPY
	public method isEnemy takes boolean status returns nothing
	    if(status==true)then
	        set is_enemy = 1
	    else
	        set is_enemy =-1
	    endif
	endmethod
	public method isAlly takes boolean status returns nothing
	    if(status==true)then
	        set is_ally = 1
	    else
	        set is_ally =-1
	    endif
	endmethod
	public method isDeath takes boolean status returns nothing
	    if(status==true)then
	        set is_death = 1
	    else
	        set is_death =-1
	    endif
	endmethod
	public method isAlive takes boolean status returns nothing
	    if(status==true)then
	        set is_alive = 1
	    else
	        set is_alive =-1
	    endif
	endmethod
	public method isInvincible takes boolean status returns nothing
	    if(status==true)then
	        set is_invincible = 1
	    else
	        set is_invincible =-1
	    endif
	endmethod
	public method isHero takes boolean status returns nothing
	    if(status==true)then
	        set is_hero = 1
	    else
	        set is_hero =-1
	    endif
	endmethod
	public method isBuilding takes boolean status returns nothing
	    if(status==true)then
	        set is_building = 1
	    else
	        set is_building =-1
	    endif
	endmethod
	public method isIllusion takes boolean status returns nothing
	    if(status==true)then
	        set is_illusion = 1
	    else
	        set is_illusion =-1
	    endif
	endmethod
	public method isGround takes boolean status returns nothing
	    if(status==true)then
	        set is_ground = 1
	    else
	        set is_ground =-1
	    endif
	endmethod
	public method isFlying takes boolean status returns nothing
	    if(status==true)then
	        set is_flying = 1
	    else
	        set is_flying =-1
	    endif
	endmethod
	public method isMelee takes boolean status returns nothing
	    if(status==true)then
	        set is_melee = 1
	    else
	        set is_melee =-1
	    endif
	endmethod
	public method isRanged takes boolean status returns nothing
	    if(status==true)then
	        set is_ranged = 1
	    else
	        set is_ranged =-1
	    endif
	endmethod
	public method isSummoned takes boolean status returns nothing
	    if(status==true)then
	        set is_summoned = 1
	    else
	        set is_summoned =-1
	    endif
	endmethod
	public method isMechanical takes boolean status returns nothing
	    if(status==true)then
	        set is_mechanical = 1
	    else
	        set is_mechanical =-1
	    endif
	endmethod
	public method isAncient takes boolean status returns nothing
	    if(status==true)then
	        set is_ancient = 1
	    else
	        set is_ancient =-1
	    endif
	endmethod
	public method isWater takes boolean status returns nothing
	    if(status==true)then
	        set is_water = 1
	    else
	        set is_water =-1
	    endif
	endmethod
	public method isFloor takes boolean status returns nothing
	    if(status==true)then
	        set is_floor = 1
	    else
	        set is_floor =-1
	    endif
	endmethod
	public method isOwnItem takes boolean status returns nothing
	    if(status==true)then
	        set is_ownItem = 1
	    else
	        set is_ownItem =-1
	    endif
	endmethod

	public static method get takes nothing returns boolean
		local unit filterUnit = GetFilterUnit()
		local boolean status = true
		if(is_ownItem == 1 and ownItemId!=0 and his.ownItem(filterUnit,ownItemId)==false)then
			set status = false
		endif
		if(is_ownItem == -1 and ownItemId!=0 and his.ownItem(filterUnit,ownItemId)==true)then
			set status = false
		endif
		if(is_enemy == 1 and his.enemy(filterUnit,thisUnit)==false)then
			set status = false
		endif
		if(is_enemy == -1 and his.enemy(filterUnit,thisUnit)==true)then
			set status = false
		endif
		if(is_ally == 1 and his.ally(filterUnit,thisUnit)==false)then
			set status = false
		endif
		if(is_ally == -1 and his.ally(filterUnit,thisUnit)==true)then
			set status = false
		endif
		if(is_death == 1 and his.death(filterUnit)==false)then
			set status = false
		endif
		if(is_death == -1 and his.death(filterUnit)==true)then
			set status = false
		endif
		if(is_alive == 1 and his.alive(filterUnit)==false)then
			set status = false
		endif
		if(is_alive == -1 and his.alive(filterUnit)==true)then
			set status = false
		endif
		if(is_invincible == 1 and his.invincible(filterUnit)==false)then
			set status = false
		endif
		if(is_invincible == -1 and his.invincible(filterUnit)==true)then
			set status = false
		endif
		if(is_hero == 1 and his.hero(filterUnit)==false)then
			set status = false
		endif
		if(is_hero == -1 and his.hero(filterUnit)==true)then
			set status = false
		endif
		if(is_building == 1 and his.building(filterUnit)==false)then
			set status = false
		endif
		if(is_building == -1 and his.building(filterUnit)==true)then
			set status = false
		endif
		if(is_illusion == 1 and his.illusion(filterUnit)==false)then
			set status = false
		endif
		if(is_illusion == -1 and his.illusion(filterUnit)==true)then
			set status = false
		endif
		if(is_ground == 1 and his.ground(filterUnit)==false)then
			set status = false
		endif
		if(is_ground == -1 and his.ground(filterUnit)==true)then
			set status = false
		endif
		if(is_flying == 1 and his.flying(filterUnit)==false)then
			set status = false
		endif
		if(is_flying == -1 and his.flying(filterUnit)==true)then
			set status = false
		endif
		if(is_melee == 1 and his.melee(filterUnit)==false)then
			set status = false
		endif
		if(is_melee == -1 and his.melee(filterUnit)==true)then
			set status = false
		endif
		if(is_ranged == 1 and his.ranged(filterUnit)==false)then
			set status = false
		endif
		if(is_ranged == -1 and his.ranged(filterUnit)==true)then
			set status = false
		endif
		if(is_summoned == 1 and his.summoned(filterUnit)==false)then
			set status = false
		endif
		if(is_summoned == -1 and his.summoned(filterUnit)==true)then
			set status = false
		endif
		if(is_ancient == 1 and his.ancient(filterUnit)==false)then
			set status = false
		endif
		if(is_ancient == -1 and his.ancient(filterUnit)==true)then
			set status = false
		endif
		if(is_water == 1 and his.water(filterUnit)==false)then
			set status = false
		endif
		if(is_water == -1 and his.water(filterUnit)==true)then
			set status = false
		endif
		if(is_floor == 1 and his.floor(filterUnit)==false)then
			set status = false
		endif
		if(is_floor == -1 and his.floor(filterUnit)==true)then
			set status = false
		endif
		return status
	endmethod

endstruct
