/* 判定过滤器 */

globals
	hashtable hashfilter = null
	integer hashKey = 951753
endglobals

library hFilter initializer init needs hIs

	public function setUnit takes unit u returns nothing
		call SaveUnitHandle(hashfilter, hashKey , 1, u)
	endfunction
	private function getUnit takes nothing returns unit
	    return LoadUnitHandle(hashfilter, hashKey , 1)
	endfunction
	//
	public function format takes nothing returns nothing
		call SaveInteger(hashfilter, hashKey , 100,0)
		call SaveInteger(hashfilter, hashKey , 101,0)
		call SaveInteger(hashfilter, hashKey , 102,0)
		call SaveInteger(hashfilter, hashKey , 103,0)
		call SaveInteger(hashfilter, hashKey , 104,0)
		call SaveInteger(hashfilter, hashKey , 105,0)
		call SaveInteger(hashfilter, hashKey , 106,0)
		call SaveInteger(hashfilter, hashKey , 107,0)
		call SaveInteger(hashfilter, hashKey , 108,0)
		call SaveInteger(hashfilter, hashKey , 109,0)
		call SaveInteger(hashfilter, hashKey , 1010,0)
		call SaveInteger(hashfilter, hashKey , 1011,0)
		call SaveInteger(hashfilter, hashKey , 1012,0)
		call SaveInteger(hashfilter, hashKey , 1013,0)
		call SaveInteger(hashfilter, hashKey , 1014,0)
		call SaveInteger(hashfilter, hashKey , 1015,0)
		call SaveInteger(hashfilter, hashKey , 1016,0)
		call SaveInteger(hashfilter, hashKey , 1017,0)
		call SaveInteger(hashfilter, hashKey , 2017,0)
	endfunction
	//
	public function isEnemy takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 100, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 100, -1)
	    endif
	endfunction
	private function getIsEnemy takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 100)
	endfunction
	public function isAlly takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 101, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 101, -1)
	    endif
	endfunction
	private function getIsAlly takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 101)
	endfunction
	public function isDeath takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 102, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 102, -1)
	    endif
	endfunction
	private function getIsDeath takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 102)
	endfunction
	public function isAlive takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 103, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 103, -1)
	    endif
	endfunction
	private function getIsAlive takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 103)
	endfunction
	public function isInvincible takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 104, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 104, -1)
	    endif
	endfunction
	private function getIsInvincible takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 104)
	endfunction
	public function isHero takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 105, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 105, -1)
	    endif
	endfunction
	private function getIsHero takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 105)
	endfunction
	public function isBuilding takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 106, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 106, -1)
	    endif
	endfunction
	private function getIsBuilding takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 106)
	endfunction
	public function isIllusion takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 107, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 107, -1)
	    endif
	endfunction
	private function getIsIllusion takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 107)
	endfunction
	public function isGround takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 108, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 108, -1)
	    endif
	endfunction
	private function getIsGround takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 108)
	endfunction
	public function isFlying takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 109, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 109, -1)
	    endif
	endfunction
	private function getIsFlying takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 109)
	endfunction
	public function isMelee takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1010, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1010, -1)
	    endif
	endfunction
	private function getIsMelee takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1010)
	endfunction
	public function isRanged takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1011, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1011, -1)
	    endif
	endfunction
	private function getIsRanged takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1011)
	endfunction
	public function isSummoned takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1012, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1012, -1)
	    endif
	endfunction
	private function getIsSummoned takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1012)
	endfunction
	public function isMechanical takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1013, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1013, -1)
	    endif
	endfunction
	private function getIsMechanical takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1013)
	endfunction
	public function isAncient takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1014, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1014, -1)
	    endif
	endfunction
	private function getIsAncient takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1014)
	endfunction
	public function isWater takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1015, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1015, -1)
	    endif
	endfunction
	private function getIsWater takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1015)
	endfunction
	public function isFloor takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1016, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1016, -1)
	    endif
	endfunction
	private function getIsFloor takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1016)
	endfunction
	public function isOwnItem takes boolean status returns nothing
	    if(status==true)then
	        call SaveInteger(hashfilter, hashKey , 1017, 1)
	    else
	        call SaveInteger(hashfilter, hashKey , 1017, -1)
	    endif
	endfunction
	private function getIsOwnItem takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 1017)
	endfunction


	//----------------------------------------

	public function setIsOwnItemId takes integer itemId returns nothing
        call SaveInteger(hashfilter, hashKey , 2017, itemId)
	endfunction
	private function getIsOwnItemId takes nothing returns integer
	    return LoadInteger(hashfilter, hashKey , 2017)
	endfunction

	public function get takes nothing returns boolean
		local unit filterUnit = GetFilterUnit()
		local unit u = getUnit()
		local boolean status = true
		if(getIsEnemy() == 1 and hIs_enemy(filterUnit,u)==false)then
			set status = false
		endif
		if(getIsEnemy() == -1 and hIs_enemy(filterUnit,u)==true)then
			set status = false
		endif
		if(getIsAlly() == 1 and hIs_ally(filterUnit,u)==false)then
			set status = false
		endif
		if(getIsAlly() == -1 and hIs_ally(filterUnit,u)==true)then
			set status = false
		endif
		if(getIsDeath() == 1 and hIs_death(filterUnit)==false)then
			set status = false
		endif
		if(getIsDeath() == -1 and hIs_death(filterUnit)==true)then
			set status = false
		endif
		if(getIsAlive() == 1 and hIs_alive(filterUnit)==false)then
			set status = false
		endif
		if(getIsAlive() == -1 and hIs_alive(filterUnit)==true)then
			set status = false
		endif
		if(getIsInvincible() == 1 and hIs_invincible(filterUnit)==false)then
			set status = false
		endif
		if(getIsInvincible() == -1 and hIs_invincible(filterUnit)==true)then
			set status = false
		endif
		if(getIsHero() == 1 and hIs_hero(filterUnit)==false)then
			set status = false
		endif
		if(getIsHero() == -1 and hIs_hero(filterUnit)==true)then
			set status = false
		endif
		if(getIsBuilding() == 1 and hIs_building(filterUnit)==false)then
			set status = false
		endif
		if(getIsBuilding() == -1 and hIs_building(filterUnit)==true)then
			set status = false
		endif
		if(getIsIllusion() == 1 and hIs_illusion(filterUnit)==false)then
			set status = false
		endif
		if(getIsIllusion() == -1 and hIs_illusion(filterUnit)==true)then
			set status = false
		endif
		if(getIsGround() == 1 and hIs_ground(filterUnit)==false)then
			set status = false
		endif
		if(getIsGround() == -1 and hIs_ground(filterUnit)==true)then
			set status = false
		endif
		if(getIsFlying() == 1 and hIs_flying(filterUnit)==false)then
			set status = false
		endif
		if(getIsFlying() == -1 and hIs_flying(filterUnit)==true)then
			set status = false
		endif
		if(getIsMelee() == 1 and hIs_melee(filterUnit)==false)then
			set status = false
		endif
		if(getIsMelee() == -1 and hIs_melee(filterUnit)==true)then
			set status = false
		endif
		if(getIsRanged() == 1 and hIs_ranged(filterUnit)==false)then
			set status = false
		endif
		if(getIsRanged() == -1 and hIs_ranged(filterUnit)==true)then
			set status = false
		endif
		if(getIsSummoned() == 1 and hIs_summoned(filterUnit)==false)then
			set status = false
		endif
		if(getIsSummoned() == -1 and hIs_summoned(filterUnit)==true)then
			set status = false
		endif
		if(getIsAncient() == 1 and hIs_ancient(filterUnit)==false)then
			set status = false
		endif
		if(getIsAncient() == -1 and hIs_ancient(filterUnit)==true)then
			set status = false
		endif
		if(getIsWater() == 1 and hIs_water(filterUnit)==false)then
			set status = false
		endif
		if(getIsWater() == -1 and hIs_water(filterUnit)==true)then
			set status = false
		endif
		if(getIsFloor() == 1 and hIs_floor(filterUnit)==false)then
			set status = false
		endif
		if(getIsFloor() == -1 and hIs_floor(filterUnit)==true)then
			set status = false
		endif
		if(getIsOwnItem() == 1 and getIsOwnItemId()!=0 and hIs_ownItem(filterUnit,getIsOwnItemId())==false)then
			set status = false
		endif
		if(getIsOwnItem() == -1 and getIsOwnItemId()!=0 and hIs_ownItem(filterUnit,getIsOwnItemId())==true)then
			set status = false
		endif
		return status
	endfunction

	private function init takes nothing returns nothing
		set hashfilter = InitHashtable()
		call format()
	endfunction

endlibrary

