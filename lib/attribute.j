/* 属性系统 */

#include "attributeIds.j" //当使用自行设定属性技能时，请注释此行

globals
	//系统最大移动速度
	real MAX_MOVE_SPEED = 522
	//默认攻速计算
	real DEFAULT_ATTACK_SPEED = 150
    integer ITEM_ABILITY = 'AInv'
endglobals

globals
	hAttr hattr = 0
	hashtable hash_attr = InitHashtable()
    real ATTRIBUTE_DEFAULT_HERO_ATTACKSPEED = 150		//默认攻击速度，除以100等于各个英雄的初始速度，用于计算攻击速度显示文本
    real ATTRIBUTE_DEFAULT_CHANGING_CD = 1.00			//默认属性切换冷却时间，避免过度计算引起性能下降
    integer ATTR_FLAG_UNIT = 1
    integer ATTR_FLAG_CD = 2
    integer ATTR_FLAG_LIFE = 3
    integer ATTR_FLAG_MANA = 6
    integer ATTR_FLAG_MOVE = 9
    integer ATTR_FLAG_DEFEND = 10
    integer ATTR_FLAG_ATTACK_SPEED = 12
    integer ATTR_FLAG_ATTACK_PHYSICAL = 13
    integer ATTR_FLAG_ATTACK_MAGIC = 14
    integer ATTR_FLAG_STR = 15
    integer ATTR_FLAG_AGI = 16
    integer ATTR_FLAG_INT = 17
    integer ATTR_FLAG_STR_WHITE = 18
    integer ATTR_FLAG_AGI_WHITE = 19
    integer ATTR_FLAG_INT_WHITE = 20

    integer ATTR_MAX_LIFE = 999999
    integer ATTR_MAX_MANA = 999999
    integer ATTR_MIN_LIFE = 1
    integer ATTR_MIN_MANA = 1
    integer ATTR_MAX_DEFEND = 9999
    integer ATTR_MAX_ATTACK_PHYSICAL = 99999
    integer ATTR_MAX_ATTACK_MAGIC = 99999
    integer ATTR_MAX_ATTACK_SPEED = 999
    integer ATTR_MIN_ATTACK_SPEED = -80
    integer ATTR_MAX_STR_GREEN = 99999
    integer ATTR_MAX_AGI_GREEN = 99999
    integer ATTR_MAX_INT_GREEN = 99999
endglobals

struct hAttr

	static method create takes nothing returns hAttr
        local hAttr x = 0
        set x = hAttr.allocate()
        return x
    endmethod

	/* 单位注册所有属性技能 */
	public static method regAllAttrSkill takes unit whichUnit returns nothing
		//生命魔法
		call UnitAddAbility( whichUnit, Attr_Ability_life_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_10000 )

		//白字攻击
        if(GetUnitAbilityLevel(whichUnit,ITEM_ABILITY)<1)then
            call UnitAddAbility(whichUnit, ITEM_ABILITY)
            call UnitRemoveAbility(whichUnit, ITEM_ABILITY)
        endif
		//绿字攻击
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_10000)
		//绿色属性
		call UnitAddAbility( whichUnit , Attr_Ability_str_1)
        call UnitAddAbility( whichUnit , Attr_Ability_str_10)
        call UnitAddAbility( whichUnit , Attr_Ability_str_100)
        call UnitAddAbility( whichUnit , Attr_Ability_str_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_1)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_10)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_100)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_1)
        call UnitAddAbility( whichUnit , Attr_Ability_int_10)
        call UnitAddAbility( whichUnit , Attr_Ability_int_100)
        call UnitAddAbility( whichUnit , Attr_Ability_int_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10000)
        //攻击速度
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_100)
        //防御
		call UnitAddAbility( whichUnit , Attr_Ability_defend_1)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_10)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_100)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1000)

        //设定特殊技能永久性
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_1 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_10 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_1000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_10000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_1 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_10 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_1000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_10000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_100)
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_1000)

        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1,  1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10, 1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100,1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1,  1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, 1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100,1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000,     1 )

	endmethod

	/**
     * 为单位添加N个同样的生命魔法技能 1级设0 2级设负 负减法（卡血牌bug）
     */
    private static method setLM takes unit u,integer abilityId ,integer qty returns nothing
    	local integer i = 1
    	if( qty <= 0 )then
	    	return
		endif
    	loop
	    	exitwhen i > qty
	    		call UnitAddAbility( u, abilityId )
	    		call SetUnitAbilityLevel( u, abilityId, 2 )
	    		call UnitRemoveAbility( u, abilityId )
	    	set i = i+1
    	endloop
    endmethod

    /**
     * 为单位添加N个同样的攻击之书 （ITEM_ABILITY 为物品栏技能）
     */
    private static method setWhiteAttack takes unit u,integer itemId ,integer qty returns nothing
    	local integer i = 1
    	local item it = null
    	local integer itemBox = GetUnitAbilityLevel(u, ITEM_ABILITY)
    	if( qty <= 0 )then
	    	return
		endif
		if(itemBox < 1)then
			call UnitAddAbility(u, ITEM_ABILITY)
		endif
    	loop
	    	exitwhen i > qty
		    	set it = CreateItem( itemId , 0, 0)
		    	call UnitAddItem( u , it )
		    	call RemoveItem(it)
	    	set i = i+1
    	endloop
    	if(itemBox < 1)then
			call UnitRemoveAbility(u, ITEM_ABILITY)
		endif
    endmethod

	/* 设定属性(即时/计时) */
	//攻速 		-999% ～ 999%<*实际上为-80% ～ 400%>
    //力敏智		～
    //力敏智(绿)	-99999 ～ 99999
    //护甲		-9999 ～ 9999
    //活力 魔法	1 ～ 999999
    //硬直    	1 ～
    //物暴 术暴 分裂 回避 移动力 力量 敏捷 智力 救助力 吸血 负重 各率 下限：0
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real currentVal = 0
		local real futureVal = 0
		local integer level = 0
		local real tempPercent = 0
		local integer tempInt = 0
		if( diff!=0 )then
			if( flag == ATTR_FLAG_LIFE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal >= ATTR_MAX_LIFE ) then
					if( currentVal >= ATTR_MAX_LIFE ) then
						set diff = 0
					else
						set diff = ATTR_MAX_LIFE - currentVal
					endif
				elseif( futureVal <= ATTR_MIN_LIFE ) then
					if( currentVal <= ATTR_MIN_LIFE ) then
						set diff = 0
					else
						set diff = ATTR_MIN_LIFE - currentVal
					endif
				endif
				set tempInt = R2I(diff)
				if( tempInt>0 )then
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_life_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_life_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_life_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_life_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_life_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_life_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_life_FU_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_life_FU_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_life_FU_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_life_FU_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_life_FU_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_life_FU_1 , level )
				endif
			elseif( flag == ATTR_FLAG_MANA ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal >= ATTR_MAX_MANA ) then
					if( currentVal >= ATTR_MAX_MANA ) then
						set diff = 0
					else
						set diff = ATTR_MAX_MANA - currentVal
					endif
				elseif( futureVal <= ATTR_MIN_MANA ) then
					if( currentVal <= ATTR_MIN_MANA ) then
						set diff = 0
					else
						set diff = ATTR_MIN_MANA - currentVal
					endif
				endif
				set tempInt = R2I(diff)
				if( tempInt>0 )then
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_mana_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_mana_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_mana_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_mana_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_mana_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_mana_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_mana_FU_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_mana_FU_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_mana_FU_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_mana_FU_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_mana_FU_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_mana_FU_1 , level )
				endif
			elseif( flag == ATTR_FLAG_MOVE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < 0 ) then
					call SetUnitMoveSpeed( whichUnit , 0 )
				else
					if(hcamera.model=="zoomin")then
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal*0.5) )
					else
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal) )
					endif
				endif
			elseif( flag == ATTR_FLAG_DEFEND ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < -ATTR_MAX_DEFEND ) then
					set futureVal = -ATTR_MAX_DEFEND
				elseif( futureVal > ATTR_MAX_DEFEND ) then
					set futureVal = ATTR_MAX_DEFEND
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000,    1 )
		        set tempInt = R2I(futureVal)
				if(tempInt>=0)then
			        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1, tempInt+1 )
		        endif
		    elseif( flag == ATTR_FLAG_ATTACK_SPEED ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < ATTR_MIN_ATTACK_SPEED ) then
					set futureVal = ATTR_MIN_ATTACK_SPEED
				elseif( futureVal > ATTR_MAX_ATTACK_SPEED ) then
					set futureVal = ATTR_MAX_ATTACK_SPEED
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1,  1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10, 1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100,1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1,  1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, 1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100,1 )
	        	set tempInt = R2I(futureVal)
	        	if(tempInt>0)then
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100, tempInt/100+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10, tempInt/10+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1, tempInt+1 )
		        elseif(tempInt<0)then
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100, tempInt/100+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, tempInt/10+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_ATTACK_PHYSICAL ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if(futureVal > ATTR_MAX_ATTACK_PHYSICAL or futureVal < -ATTR_MAX_ATTACK_PHYSICAL)then
					set diff = 0
				endif
		        set tempInt = R2I(diff)
		        if( tempInt>0 )then
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_1 , level )
				endif
			elseif( flag == ATTR_FLAG_ATTACK_MAGIC ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_ATTACK_MAGIC) then
					set futureVal = ATTR_MAX_ATTACK_MAGIC
				elseif( futureVal < -ATTR_MAX_ATTACK_MAGIC ) then
					set futureVal = -ATTR_MAX_ATTACK_MAGIC
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000,   1 )
		        set tempInt = R2I(futureVal)
				if(tempInt>=0)then
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1, tempInt+1 )
				endif
			elseif( flag == ATTR_FLAG_STR ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_STR_GREEN) then
					set futureVal = ATTR_MAX_STR_GREEN
				elseif( futureVal < -ATTR_MAX_STR_GREEN ) then
					set futureVal = -ATTR_MAX_STR_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_AGI ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_AGI_GREEN) then
					set futureVal = ATTR_MAX_AGI_GREEN
				elseif( futureVal < -ATTR_MAX_AGI_GREEN ) then
					set futureVal = -ATTR_MAX_AGI_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_INT ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_INT_GREEN) then
					set futureVal = ATTR_MAX_INT_GREEN
				elseif( futureVal < -ATTR_MAX_INT_GREEN ) then
					set futureVal = -ATTR_MAX_INT_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_STR_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroStr( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_AGI_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroAgi( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_INT_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroInt( whichUnit , R2I(futureVal) , true )
			endif
		endif//diff
	endmethod

	private static method setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = htime.getInteger(t,1)
		local unit whichUnit = htime.getUnit(t,2)
		local real diff = htime.getReal(t,3)
		call htime.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
	endmethod

	/* 验证单位是否初始化过参数 */
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr , uhid , ATTR_FLAG_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call regAllAttrSkill(whichUnit)//注册技能
			call SaveInteger( hash_attr , uhid , ATTR_FLAG_UNIT , uhid )
			//todo 变量初始化
			call SaveBoolean( hash_attr , uhid , ATTR_FLAG_CD , false )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_LIFE , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit) )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_MANA , GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit) )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_DEFEND , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_MAGIC , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_STR , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_INT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_STR_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_INT_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_MOVE , GetUnitDefaultMoveSpeed(whichUnit) )
			if(hcamera.model=="zoomin")then
				call SetUnitMoveSpeed( whichUnit , R2I(LoadReal( hash_attr , uhid , ATTR_FLAG_MOVE)*0.5) )
			endif
			//todo 设定默认值
			if( his.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_STR_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_LIFE , whichUnit , tempReal*5 )
				call hattrExt.addToughness( whichUnit , tempReal*0.2 , 0 )
				call hattrExt.addKnocking( whichUnit , tempReal*5 , 0 )
				call hattrExt.addPunish( whichUnit , tempReal*2 , 0 )
				call hattrExt.addSwimOppose( whichUnit , tempReal*0.03 , 0 )

				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*2 )
				call setAttrDo( ATTR_FLAG_ATTACK_SPEED , whichUnit , tempReal*0.05 )
				call hattrExt.addKnocking( whichUnit , tempReal*3 , 0 )
				call hattrExt.addAvoid( whichUnit , tempReal*0.02 , 0 )

				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_INT_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_FLAG_MANA , whichUnit , tempReal*5 )
				call hattrExt.addManaBack( whichUnit , tempReal*0.2 , 0 )
				call hattrExt.addViolence( whichUnit , tempReal*10 , 0 )
				call hattrExt.addHemophagiaSkill( whichUnit , tempReal*0.02 , 0 )
			endif
			return true
		endif
		return false
	endmethod

	private static method setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = htime.setTimeout( during , function thistype.setAttrDuring )
			call htime.setInteger(t,1,flag)
			call htime.setUnit(t,2,whichUnit)
			call htime.setReal(t,3, -diff )
		endif
	endmethod

	private static method getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash_attr , GetHandleId(whichUnit) , flag )
	endmethod


	/* 生命 ------------------------------------------------------------ */
	public static method getLife takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE , whichUnit )
	endmethod
	public static method addLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value , during )
	endmethod
	public static method subLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , -value , during )
	endmethod
	public static method setLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value - getLife(whichUnit) , during )
	endmethod

	/* 魔法 ------------------------------------------------------------ */
	public static method getMana takes unit whichUnit returns real
	    return getAttr( ATTR_FLAG_MANA , whichUnit )
	endmethod
	public static method addMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value , during )
	endmethod
	public static method subMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , -value , during )
	endmethod
	public static method setMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value - getMana(whichUnit) , during )
	endmethod

	/* 移动力 ------------------------------------------------------------ */
	public static method getMove takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MOVE , whichUnit )
	endmethod
	public static method addMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value , during )
	endmethod
	public static method subMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , -value , during )
	endmethod
	public static method setMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endmethod

	/* 护甲 ------------------------------------------------------------ */
	public static method getDefend takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_DEFEND , whichUnit )
	endmethod
	public static method addDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value , during )
	endmethod
	public static method subDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , -value , during )
	endmethod
	public static method setDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value - getDefend(whichUnit) , during )
	endmethod

	/* 攻击速度 ------------------------------------------------------------ */
	public static method getAttackSpeed takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit )
	endmethod
	public static method addAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value , during )
	endmethod
	public static method subAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , -value , during )
	endmethod
	public static method setAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endmethod

	/* 物理攻击力 ------------------------------------------------------------ */
	public static method getAttackPhysical takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit )
	endmethod
	public static method addAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value , during )
	endmethod
	public static method subAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , -value , during )
	endmethod
	public static method setAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endmethod

	/* 魔法攻击力 ------------------------------------------------------------ */
	public static method getAttackMagic takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit )
	endmethod
	public static method addAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value , during )
	endmethod
	public static method subAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , -value , during )
	endmethod
	public static method setAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endmethod

	/* 力量 ------------------------------------------------------------ */
	public static method getStr takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR , whichUnit )
	endmethod
	public static method setStr takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStr(whichUnit)
		local real attackPhysical = value*0.5
		local real attackMagic = value*0.5
		local real life = value*3
		local real toughness = value*0.1
		local real knocking = value*3
		local real punish = value*1
		local real swimOppose = value*0.01
		local real avoid = value*2
		local real violence = value*3
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call hattrExt.addToughness( whichUnit , toughness , during )
		call hattrExt.addKnocking( whichUnit , knocking , during )
		call hattrExt.addPunish( whichUnit , punish , during )
		call hattrExt.addSwimOppose( whichUnit , swimOppose , during )
		call hattrExt.subAvoid( whichUnit , avoid , during )
		call hattrExt.subViolence( whichUnit , violence , during )
	endmethod
	public static method addStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)+value , during )
	endmethod
	public static method subStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)-value , during )
	endmethod

	/* 敏捷 ------------------------------------------------------------ */
	public static method getAgi takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI , whichUnit )
	endmethod
	public static method setAgi takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getAgi(whichUnit)
		local real attackPhysical = value*1
		local real attackspeed = value*0.04
		local real knocking = value*1
		local real avoid = value*0.01
		local real punish = value*2
		local real violence = value*1
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call hattrExt.addKnocking( whichUnit , knocking , during )
		call hattrExt.addAvoid( whichUnit , avoid , during )
		call hattrExt.subPunish( whichUnit , punish , during )
		call hattrExt.subViolence( whichUnit , violence , during )
	endmethod
	public static method addAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)+value , during )
	endmethod
	public static method subAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)-value , during )
	endmethod

	/* 智力 ------------------------------------------------------------ */
	public static method getInt takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT , whichUnit )
	endmethod
	public static method setInt takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getInt(whichUnit)
		local real attackMagic = value*2
		local real mana = value*3
		local real manaback = value*0.1
		local real violence = value*8
		local real hemophagiaSkill = value*0.01
		call setAttr( ATTR_FLAG_INT , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call hattrExt.addManaBack( whichUnit , manaback , during )
		call hattrExt.addViolence( whichUnit , violence , during )
		call hattrExt.addHemophagiaSkill( whichUnit , hemophagiaSkill , during )
	endmethod
	public static method addInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)+value , during )
	endmethod
	public static method subInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)-value , during )
	endmethod

	/* 力量（白字） ------------------------------------------------------------ */
	public static method getStrWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR_WHITE , whichUnit )
	endmethod
	public static method setStrWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStrWhite(whichUnit)
		local real attackPhysical = value*1
		local real attackMagic = value*1
		local real life = value*5
		local real toughness = value*0.2
		local real knocking = value*5
		local real punish = value*2
		local real swimOppose = value*0.03
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call hattrExt.addToughness( whichUnit , toughness , during )
		call hattrExt.addKnocking( whichUnit , knocking , during )
		call hattrExt.addPunish( whichUnit , punish , during )
		call hattrExt.addSwimOppose( whichUnit , swimOppose , during )
	endmethod
	public static method addStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)+value , during )
	endmethod
	public static method subStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)-value , during )
	endmethod

	/* 敏捷（白字） ------------------------------------------------------------ */
	public static method getAgiWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI_WHITE , whichUnit )
	endmethod
	public static method setAgiWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getAgiWhite(whichUnit)
		local real attackPhysical = value*2
		local real attackspeed = value*0.05
		local real knocking = value*3
		local real avoid = value*0.02
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call hattrExt.addKnocking( whichUnit , knocking , during )
		call hattrExt.addAvoid( whichUnit , avoid , during )
	endmethod
	public static method addAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)+value , during )
	endmethod
	public static method subAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)-value , during )
	endmethod

	/* 智力（白字） ------------------------------------------------------------ */
	public static method getIntWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT_WHITE , whichUnit )
	endmethod
	public static method setIntWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getIntWhite(whichUnit)
		local real attackMagic = value*3
		local real mana = value*5
		local real manaback = value*0.2
		local real violence = value*10
		local real hemophagiaSkill = value*0.02
		call setAttr( ATTR_FLAG_INT , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call hattrExt.addManaBack( whichUnit , manaback , during )
		call hattrExt.addViolence( whichUnit , violence , during )
		call hattrExt.addHemophagiaSkill( whichUnit , hemophagiaSkill , during )
	endmethod
	public static method addIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)+value , during )
	endmethod
	public static method subIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)-value , during )
	endmethod

	/**
     * 打印某个单位的属性到桌面
     */
    public static method show takes unit whichUnit returns nothing
		call hconsole.info("生命："+R2S(getLife(whichUnit)))
        call hconsole.info("魔法："+R2S(getMana(whichUnit)))
		call hconsole.info("移动力："+R2S(getMove(whichUnit)))
		call hconsole.info("防御："+R2S(getDefend(whichUnit)))
		call hconsole.info("攻击速度："+R2S(getAttackSpeed(whichUnit)))
		call hconsole.info("物理攻击力："+R2S(getAttackPhysical(whichUnit)))
		call hconsole.info("魔法攻击力："+R2S(getAttackMagic(whichUnit)))
		call hconsole.info("力量"+R2S(getStr(whichUnit)))
		call hconsole.info("敏捷："+R2S(getAgi(whichUnit)))
		call hconsole.info("智力："+R2S(getInt(whichUnit)))
		call hconsole.info("力量(白)："+R2S(getStrWhite(whichUnit)))
		call hconsole.info("敏捷(白)："+R2S(getAgiWhite(whichUnit)))
		call hconsole.info("智力(白)："+R2S(getIntWhite(whichUnit)))
    endmethod

endstruct
