//判定过滤器
struct hFilter

	private static player array is_owner_player
	private static integer is_owner_player_qty = 0
	private static player array is_not_owner_player
	private static integer is_not_owner_player_qty = 0

	private static integer is_enemy = 0
	private static unit is_enemy_unit = null
	private static integer is_ally = 0
	private static unit is_ally_unit = null
	private static integer is_detected = 0
	private static player is_detected_player = null
	private static integer is_has_slot = 0
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
	private static integer is_ownItem_id = 0

	static method create takes nothing returns hFilter
		local hFilter s = 0
		set s = hFilter.allocate()
		set s.is_owner_player_qty = 0
		set s.is_not_owner_player_qty = 0
		set s.is_enemy = 0
		set s.is_enemy_unit = null
		set s.is_ally = 0
		set s.is_ally_unit = null
		set s.is_detected = 0
		set s.is_detected_player = null
		set s.is_has_slot = 0
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
		set s.is_ownItem_id = 0

		return s
	endmethod
	method destroy takes nothing returns nothing
		set is_owner_player_qty = 0
		set is_not_owner_player_qty = 0
		set is_enemy = 0
		set is_ally = 0
		set is_detected = 0
		set is_detected_player = null
		set is_has_slot = 0
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
		set is_ownItem_id = 0
	endmethod

	public method isEnemy takes boolean status,unit whichunit returns nothing
	    if(status==true)then
	        set is_enemy = 1
			set is_enemy_unit = whichunit
	    else
	        set is_enemy =-1
			set is_enemy_unit = whichunit
	    endif
	endmethod
	public method isAlly takes boolean status,unit whichunit returns nothing
	    if(status==true)then
	        set is_ally = 1
			set is_ally_unit = whichunit
	    else
	        set is_ally =-1
			set is_ally_unit = whichunit
	    endif
	endmethod
	public method isDetected takes boolean status,player whichplayer returns nothing
	    if(status==true)then
	        set is_detected = 1
			set is_detected_player = whichplayer
	    else
	        set is_detected =-1
			set is_detected_player = whichplayer
	    endif
	endmethod
	public method isHasSlot takes boolean status returns nothing
	    if(status==true)then
	        set is_has_slot = 1
	    else
	        set is_has_slot =-1
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
	public method isOwnItem takes boolean status,integer itemid returns nothing
	    if(status==true)then
	        set is_ownItem = 1
	        set is_ownItem_id = itemid
	    else
	        set is_ownItem =-1
			set is_ownItem_id = itemid
	    endif
	endmethod
	public method isOwnerPlayer takes boolean status,player p returns nothing
		if(status==true)then
	        set is_owner_player_qty = is_owner_player_qty+1
			set is_owner_player[is_owner_player_qty] = p
	    else
	        set is_not_owner_player_qty = is_not_owner_player_qty+1
			set is_not_owner_player[is_not_owner_player_qty] = p
	    endif
	endmethod

	public static method get takes nothing returns boolean
		local unit filterUnit = GetFilterUnit()
		local boolean status = true
		local integer i = 0
		if(is_owner_player_qty > 0 and status==true )then
			set i = is_owner_player_qty
			loop
				exitwhen i<=0 or status==false
					if(GetOwningPlayer(filterUnit)!=is_owner_player[i])then
						set status = false
					endif
				set i = i-1
			endloop
		endif
		if(is_not_owner_player_qty > 0 and status==true )then
			set i = is_not_owner_player_qty
			loop
				exitwhen i<=0 or status==false
					if(GetOwningPlayer(filterUnit)==is_not_owner_player[i])then
						set status = false
					endif
				set i = i-1
			endloop
		endif
		if(is_enemy == 1 and his.enemy(filterUnit,is_enemy_unit)==false)then
			set status = false
		endif
		if(is_enemy == -1 and his.enemy(filterUnit,is_enemy_unit)==true)then
			set status = false
		endif
		if(is_ally == 1 and his.ally(filterUnit,is_ally_unit)==false)then
			set status = false
		endif
		if(is_ally == -1 and his.ally(filterUnit,is_ally_unit)==true)then
			set status = false
		endif
		if(is_detected_player != null and is_detected == 1 and his.detected(filterUnit,is_detected_player)==false)then
			set status = false
		endif
		if(is_detected_player != null and is_detected == -1 and his.detected(filterUnit,is_detected_player)==true)then
			set status = false
		endif
		if(is_has_slot == 1 and his.hasSlot(filterUnit)==false)then
			set status = false
		endif
		if(is_has_slot == -1 and his.hasSlot(filterUnit)==true)then
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
		if(is_ownItem == 1 and is_ownItem_id!=0 and his.ownItem(filterUnit,is_ownItem_id)==false)then
			set status = false
		endif
		if(is_ownItem == -1 and is_ownItem_id!=0 and his.ownItem(filterUnit,is_ownItem_id)==true)then
			set status = false
		endif
		return status
	endmethod

endstruct
