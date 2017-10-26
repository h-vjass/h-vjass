/* 属性系统 */

globals
	
	//系统最大移动速度
	real MAX_MOVE_SPEED = 522

	//护甲 1
	integer Attr_Ability_defend_1 = 'A01J'
	//护甲 10
	integer Attr_Ability_defend_10 = 'A07I'
	//护甲 100
	integer Attr_Ability_defend_100 = 'A07M'
	//护甲 1000
	integer Attr_Ability_defend_1000 = 'A0FC'
	//物理攻击力 1
	integer Attr_Ability_attack_physical_1 = 'A01T'
	//物理攻击力 10
	integer Attr_Ability_attack_physical_10 = 'A01R'
	//物理攻击力 100
	integer Attr_Ability_attack_physical_100 = 'A01U'
	//物理攻击力 1000
	integer Attr_Ability_attack_physical_1000 =  'A025'
	//物理攻击力 10000
	integer Attr_Ability_attack_physical_10000 =  'A029'
	//物理攻击力书 1
	integer Attr_Ability_attack_physical_item_1 = 'I00M'
	//物理攻击力书 10
	integer Attr_Ability_attack_physical_item_10 = 'I00N'
	//物理攻击力书 100
	integer Attr_Ability_attack_physical_item_100 = 'I00O'
	//物理攻击力书 1000
	integer Attr_Ability_attack_physical_item_1000 =  'I00P'
	//物理攻击力书 10000
	integer Attr_Ability_attack_physical_item_10000 =  'I00Q'
	//魔法攻击力 1
	integer Attr_Ability_attack_magic_1 = 'A01K'
	//魔法攻击力 10
	integer Attr_Ability_attack_magic_10 = 'A01V'
	//魔法攻击力 100
	integer Attr_Ability_attack_magic_100 = 'A07H'
	//魔法攻击力 1000
	integer Attr_Ability_attack_magic_1000 =  'A07N'
	//魔法攻击力 10000
	integer Attr_Ability_attack_magic_10000 =  'A03D'
	//攻击速度% 1
	integer Attr_Ability_attackSpeed_1 = 'A01M'
	//攻击速度% 10
	integer Attr_Ability_attackSpeed_10 = 'A01P'
	//攻击速度% 100
	integer Attr_Ability_attackSpeed_100 = 'A01Q'
	//力量 1
	integer Attr_Ability_str_1 = 'A015'
	//力量 10
	integer Attr_Ability_str_10 =  'A018'
	//力量 100
	integer Attr_Ability_str_100 =  'A00P'
	//力量 1000
	integer Attr_Ability_str_1000 = 'A00Q'
	//力量 1000
	integer Attr_Ability_str_10000 = 'A000'
	//敏捷 1
	integer Attr_Ability_agi_1 = 'A00U'
	//敏捷 10
	integer Attr_Ability_agi_10 = 'A00V'
	//敏捷 100
	integer Attr_Ability_agi_100 = 'A00X'
	//敏捷 1000
	integer Attr_Ability_agi_1000 = 'A00Y'
	//敏捷 10000
	integer Attr_Ability_agi_10000 = 'A001'
	//智力 1
	integer Attr_Ability_int_1 = 'A00Z'
	//智力 10
	integer Attr_Ability_int_10 = 'A010'
	//智力 100
	integer Attr_Ability_int_100 =  'A012'
	//智力 1000
	integer Attr_Ability_int_1000 = 'A011'
	//智力 10000
	integer Attr_Ability_int_10000 = 'A002'
	//生命 1
	integer Attr_Ability_life_1 = 'A0F2'
	//生命 10
	integer Attr_Ability_life_10 = 'A0F4'
	//生命 100
	integer Attr_Ability_life_100 = 'A0F5'
	//生命 1000
	integer Attr_Ability_life_1000 = 'A0F6'
	//生命 10000
	integer Attr_Ability_life_10000 = 'A0F7'
	//生命 100000
	integer Attr_Ability_life_100000 = 'A006'
	//魔法 1
	integer Attr_Ability_mana_1 = 'A0F3'
	//魔法 10
	integer Attr_Ability_mana_10 = 'A0F8'
	//魔法 100
	integer Attr_Ability_mana_100 = 'A0F9'
	//魔法 1000
	integer Attr_Ability_mana_1000 = 'A0FA'
	//魔法 10000
	integer Attr_Ability_mana_10000 = 'A0FB'
	//魔法 100000
	integer Attr_Ability_mana_100000 = 'A007'
	//******************正负分割线******************//
	//-护甲 1
	integer Attr_Ability_defend_FU_1 = 'A01B'
	//-护甲 10
	integer Attr_Ability_defend_FU_10 = 'A01C'
	//-护甲 100
	integer Attr_Ability_defend_FU_100 = 'A01D'
	//-护甲 1000
	integer Attr_Ability_defend_FU_1000 = 'A0FD'
	//物理攻击力 1
	integer Attr_Ability_attack_physical_FU_1 = 'A02J'
	//物理攻击力 10
	integer Attr_Ability_attack_physical_FU_10 = 'A02I'
	//物理攻击力 100
	integer Attr_Ability_attack_physical_FU_100 = 'A02H'
	//物理攻击力 1000
	integer Attr_Ability_attack_physical_FU_1000 =  'A02E'
	//物理攻击力 10000
	integer Attr_Ability_attack_physical_FU_10000 =  'A02A'
	//物理攻击力书 1
	integer Attr_Ability_attack_physical_FU_item_1 = 'I00R'
	//物理攻击力书 10
	integer Attr_Ability_attack_physical_FU_item_10 = 'I00V'
	//物理攻击力书 100
	integer Attr_Ability_attack_physical_FU_item_100 = 'I00U'
	//物理攻击力书 1000
	integer Attr_Ability_attack_physical_FU_item_1000 =  'I00T'
	//物理攻击力书 10000
	integer Attr_Ability_attack_physical_FU_item_10000 =  'I00S'
	//-魔法攻击力 1
	integer Attr_Ability_attack_magic_FU_1 = 'A01G'
	//-魔法攻击力 10
	integer Attr_Ability_attack_magic_FU_10 = 'A01L'
	//-魔法攻击力 100
	integer Attr_Ability_attack_magic_FU_100 = 'A01O'
	//-魔法攻击力 1000
	integer Attr_Ability_attack_magic_FU_1000 =  'A01S'
	//-魔法攻击力 10000
	integer Attr_Ability_attack_magic_FU_10000 =  'A03E'
	//-攻击速度% 1
	integer Attr_Ability_attackSpeed_FU_1 = 'A01W'
	//-攻击速度% 10
	integer Attr_Ability_attackSpeed_FU_10 = 'A021'
	//-攻击速度% 100
	integer Attr_Ability_attackSpeed_FU_100 = 'A020'
	//-力量 1
	integer Attr_Ability_str_FU_1 = 'A022'
	//-力量 10
	integer Attr_Ability_str_FU_10 =  'A024'
	//-力量 100
	integer Attr_Ability_str_FU_100 =  'A023'
	//-力量 1000
	integer Attr_Ability_str_FU_1000 = 'A02B'
	//-力量 10000
	integer Attr_Ability_str_FU_10000 = 'A003'
	//-敏捷 1
	integer Attr_Ability_agi_FU_1 = 'A02C'
	//-敏捷 10
	integer Attr_Ability_agi_FU_10 = 'A02D'
	//-敏捷 100
	integer Attr_Ability_agi_FU_100 = 'A02Y'
	//-敏捷 1000
	integer Attr_Ability_agi_FU_1000 = 'A02K'
	//-敏捷 10000
	integer Attr_Ability_agi_FU_10000 = 'A004'
	//-智力 1
	integer Attr_Ability_int_FU_1 = 'A03X'
	//-智力 10
	integer Attr_Ability_int_FU_10 = 'A04L'
	//-智力 100
	integer Attr_Ability_int_FU_100 =  'A04V'
	//-智力 1000
	integer Attr_Ability_int_FU_1000 = 'A04N'
	//-智力 10000
	integer Attr_Ability_int_FU_10000 = 'A005'
	//-生命 1
	integer Attr_Ability_life_FU_1 = 'A0FE'
	//-生命 10
	integer Attr_Ability_life_FU_10 = 'A0FF'
	//-生命 100
	integer Attr_Ability_life_FU_100 = 'A0FG'
	//-生命 1000
	integer Attr_Ability_life_FU_1000 = 'A0FH'
	//-生命 10000
	integer Attr_Ability_life_FU_10000 = 'A0FI'
	//-生命 100000
	integer Attr_Ability_life_FU_100000 = 'A008'
	//-魔法 1
	integer Attr_Ability_mana_FU_1 = 'A0FJ'
	//-魔法 10
	integer Attr_Ability_mana_FU_10 = 'A0FK'
	//-魔法 100
	integer Attr_Ability_mana_FU_100 = 'A0FL'
	//-魔法 1000
	integer Attr_Ability_mana_FU_1000 = 'A0FM'
	//-魔法 10000
	integer Attr_Ability_mana_FU_10000 = 'A0FN'
	//-魔法 100000
	integer Attr_Ability_mana_FU_100000 = 'A009'
endglobals

library hAttr initializer init needs hAttrExt

	globals
	    private real ATTRIBUTE_DEFAULT_HERO_ATTACKSPEED = 150		//默认攻击速度，除以100等于各个英雄的初始速度，用于计算攻击速度显示文本
	    private real ATTRIBUTE_DEFAULT_CHANGING_CD = 1.00			//默认属性切换冷却时间，避免过度计算引起性能下降
	    private hashtable hash = null
	    private integer ATTR_FLAG_UNIT = 1
	    private integer ATTR_FLAG_CD = 2
	    private integer ATTR_FLAG_LIFE = 3
	    private integer ATTR_FLAG_MANA = 6
	    private integer ATTR_FLAG_MOVE = 9
	    private integer ATTR_FLAG_DEFEND = 10
	    private integer ATTR_FLAG_ATTACK_SPEED = 12
	    private integer ATTR_FLAG_ATTACK_PHYSICAL = 13
	    private integer ATTR_FLAG_ATTACK_MAGIC = 14
	    private integer ATTR_FLAG_STR = 15
	    private integer ATTR_FLAG_AGI = 16
	    private integer ATTR_FLAG_INT = 17
	    private integer ATTR_FLAG_STR_WHITE = 18
	    private integer ATTR_FLAG_AGI_WHITE = 19
	    private integer ATTR_FLAG_INT_WHITE = 20
	endglobals

	/**
     * 为单位添加N个同样的生命魔法技能 1级设0 2级设负 负减法（卡血牌bug）
     */
    private function setLM takes unit u,integer abilityId ,integer qty returns nothing
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
    endfunction

    /**
     * 为单位添加N个同样的攻击之书
     */
    private function setWhiteAttack takes unit u,integer itemId ,integer qty returns nothing
    	local integer i = 1
    	local item it = null
    	local integer itemBox = GetUnitAbilityLevel(u, 'AInv')
    	if( qty <= 0 )then
	    	return
		endif
		if(itemBox < 1)then
			call UnitAddAbility(u, 'AInv')
		endif
    	loop
	    	exitwhen i > qty
		    	set it = CreateItem( itemId , 0, 0)
		    	call UnitAddItem( u , it )
		    	call RemoveItem(it)
	    	set i = i+1
    	endloop
    	if(itemBox < 1)then
			call UnitRemoveAbility(u, 'AInv')
		endif
    endfunction

	/* 设定属性(即时/计时) */
	//攻速 		-999% ～ 999%<*实际上为-80% ～ 400%>
    //力敏智		～
    //力敏智(绿)	-99999 ～ 99999
    //护甲		-9999 ～ 9999
    //活力 魔法	1 ～ 999999
    //硬直    	1 ～
    //物暴 术暴 分裂 回避 移动力 力量 敏捷 智力 救助力 吸血 负重 各率 下限：0
	private function setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real currentVal = 0
		local real futureVal = 0
		local integer level = 0
		local real tempPercent = 0
		local integer tempInt = 0
		if( diff!=0 )then
			if( flag == ATTR_FLAG_LIFE ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( futureVal >= 999999 ) then
					if( currentVal >= 999999 ) then
						set diff = 0
					else
						set diff = 999999 - currentVal
					endif
				elseif( futureVal <= 1 ) then
					if( currentVal <= 1 ) then
						set diff = 0
					else
						set diff = 1 - currentVal
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( futureVal >= 999999 ) then
					if( currentVal >= 999999 ) then
						set diff = 0
					else
						set diff = 999999 - currentVal
					endif
				elseif( futureVal <= 1 ) then
					if( currentVal <= 1 ) then
						set diff = 0
					else
						set diff = 1 - currentVal
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( futureVal < 0 ) then
					call SetUnitMoveSpeed( whichUnit , 0 )
				else
					if(camera.model=="zoomin")then
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal*0.5) )
					else
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal) )
					endif
				endif
			elseif( flag == ATTR_FLAG_DEFEND ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( futureVal < -80 ) then
					set futureVal = -80
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
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
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetHeroStr( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_AGI_WHITE ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetHeroAgi( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_INT_WHITE ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetHeroInt( whichUnit , R2I(futureVal) , true )
			endif
		endif//diff
	endfunction

	private function setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = time.getInteger(t,1)
		local unit whichUnit = time.getUnit(t,2)
		local real diff = time.getReal(t,3)
		call time.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
	endfunction

	/* 验证单位是否初始化过参数 */
	public function initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash , uhid , ATTR_FLAG_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash , uhid , ATTR_FLAG_UNIT , uhid )
			//todo 变量初始化
			call SaveBoolean( hash , uhid , ATTR_FLAG_CD , false )
			call SaveReal( hash , uhid , ATTR_FLAG_LIFE , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit) )
			call SaveReal( hash , uhid , ATTR_FLAG_MANA , GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit) )
			call SaveReal( hash , uhid , ATTR_FLAG_DEFEND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_SPEED , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_MAGIC , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_STR , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AGI , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_INT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_STR_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AGI_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_INT_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MOVE , GetUnitDefaultMoveSpeed(whichUnit) )
			if(camera.model=="zoomin")then
				call SetUnitMoveSpeed( whichUnit , R2I(LoadReal( hash , uhid , ATTR_FLAG_MOVE)*0.5) )
			endif
			//todo 设定默认值
			if( is.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_STR_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_LIFE , whichUnit , tempReal*5 )
				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_AGI_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*2 )
				call setAttrDo( ATTR_FLAG_ATTACK_SPEED , whichUnit , tempReal*0.05 )
				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_INT_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_FLAG_MANA , whichUnit , tempReal*5 )
			endif
			return true
		endif
		return false
	endfunction

	private function setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = time.setTimeout( during , function setAttrDuring )
			call time.setInteger(t,1,flag)
			call time.setUnit(t,2,whichUnit)
			call time.setReal(t,3, -diff )
		endif
	endfunction

	private function getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash , GetHandleId(whichUnit) , flag )
	endfunction


	/* 生命 ------------------------------------------------------------ */
	public function getLife takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE , whichUnit )
	endfunction
	public function addLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value , during )
	endfunction
	public function subLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , -value , during )
	endfunction
	public function setLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value - getLife(whichUnit) , during )
	endfunction

	/* 魔法 ------------------------------------------------------------ */
	public function getMana takes unit whichUnit returns real
	    return getAttr( ATTR_FLAG_MANA , whichUnit )
	endfunction
	public function addMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value , during )
	endfunction
	public function subMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , -value , during )
	endfunction
	public function setMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value - getMana(whichUnit) , during )
	endfunction

	/* 移动力 ------------------------------------------------------------ */
	public function getMove takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MOVE , whichUnit )
	endfunction
	public function addMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value , during )
	endfunction
	public function subMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , -value , during )
	endfunction
	public function setMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endfunction

	/* 护甲 ------------------------------------------------------------ */
	public function getDefend takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_DEFEND , whichUnit )
	endfunction
	public function addDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value , during )
	endfunction
	public function subDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , -value , during )
	endfunction
	public function setDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value - getDefend(whichUnit) , during )
	endfunction

	/* 攻击速度 ------------------------------------------------------------ */
	public function getAttackSpeed takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit )
	endfunction
	public function addAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value , during )
	endfunction
	public function subAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , -value , during )
	endfunction
	public function setAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endfunction

	/* 物理攻击力 ------------------------------------------------------------ */
	public function getAttackPhysical takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit )
	endfunction
	public function addAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value , during )
	endfunction
	public function subAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , -value , during )
	endfunction
	public function setAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endfunction

	/* 魔法攻击力 ------------------------------------------------------------ */
	public function getAttackMagic takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit )
	endfunction
	public function addAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value , during )
	endfunction
	public function subAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , -value , during )
	endfunction
	public function setAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endfunction

	/* 力量 ------------------------------------------------------------ */
	public function getStr takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR , whichUnit )
	endfunction
	public function setStr takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStr(whichUnit)
		local real attackPhysical = value*0.5
		local real attackMagic = value*0.5
		local real life = value*3
		local real toughness = value*0.1
		local real knocking = value*3
		local real punish = value*5
		local real swimOppose = value*0.01
		local real avoid = value*2
		local real violence = value*3
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call hAttrExt_addToughness( whichUnit , toughness , during )
		call hAttrExt_addKnocking( whichUnit , knocking , during )
		call hAttrExt_addPunish( whichUnit , punish , during )
		call hAttrExt_addSwimOppose( whichUnit , swimOppose , during )
		call hAttrExt_subAvoid( whichUnit , avoid , during )
		call hAttrExt_subViolence( whichUnit , violence , during )
	endfunction
	public function addStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)+value , during )
	endfunction
	public function subStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)-value , during )
	endfunction

	/* 敏捷 ------------------------------------------------------------ */
	public function getAgi takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI , whichUnit )
	endfunction
	public function setAgi takes unit whichUnit , real valueSet , real during returns nothing
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
		call hAttrExt_addKnocking( whichUnit , knocking , during )
		call hAttrExt_addAvoid( whichUnit , avoid , during )
		call hAttrExt_subPunish( whichUnit , punish , during )
		call hAttrExt_subViolence( whichUnit , violence , during )
	endfunction
	public function addAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)+value , during )
	endfunction
	public function subAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)-value , during )
	endfunction

	/* 智力 ------------------------------------------------------------ */
	public function getInt takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT , whichUnit )
	endfunction
	public function setInt takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getInt(whichUnit)
		local real attackMagic = value*2
		local real mana = value*3
		local real manaback = value*0.1
		local real violence = value*8
		local real hemophagiaSkill = value*0.01
		call setAttr( ATTR_FLAG_INT , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call hAttrExt_addManaBack( whichUnit , manaback , during )
		call hAttrExt_addViolence( whichUnit , violence , during )
		call hAttrExt_addHemophagiaSkill( whichUnit , hemophagiaSkill , during )
	endfunction
	public function addInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)+value , during )
	endfunction
	public function subInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)-value , during )
	endfunction

	/* 力量（白字） ------------------------------------------------------------ */
	public function getStrWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR_WHITE , whichUnit )
	endfunction
	public function setStrWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStrWhite(whichUnit)
		local real attackPhysical = value*1
		local real attackMagic = value*1
		local real life = value*5
		local real toughness = value*0.2
		local real knocking = value*5
		local real punish = value*10
		local real swimOppose = value*0.03
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call hAttrExt_addToughness( whichUnit , toughness , during )
		call hAttrExt_addKnocking( whichUnit , knocking , during )
		call hAttrExt_addPunish( whichUnit , punish , during )
		call hAttrExt_addSwimOppose( whichUnit , swimOppose , during )
	endfunction
	public function addStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)+value , during )
	endfunction
	public function subStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)-value , during )
	endfunction

	/* 敏捷（白字） ------------------------------------------------------------ */
	public function getAgiWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI_WHITE , whichUnit )
	endfunction
	public function setAgiWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getAgiWhite(whichUnit)
		local real attackPhysical = value*2
		local real attackspeed = value*0.05
		local real knocking = value*3
		local real avoid = value*0.02
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call hAttrExt_addKnocking( whichUnit , knocking , during )
		call hAttrExt_addAvoid( whichUnit , avoid , during )
	endfunction
	public function addAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)+value , during )
	endfunction
	public function subAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)-value , during )
	endfunction

	/* 智力（白字） ------------------------------------------------------------ */
	public function getIntWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT_WHITE , whichUnit )
	endfunction
	public function setIntWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getIntWhite(whichUnit)
		local real attackMagic = value*3
		local real mana = value*5
		local real manaback = value*0.2
		local real violence = value*10
		local real hemophagiaSkill = value*0.02
		call setAttr( ATTR_FLAG_INT , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call hAttrExt_addManaBack( whichUnit , manaback , during )
		call hAttrExt_addViolence( whichUnit , violence , during )
		call hAttrExt_addHemophagiaSkill( whichUnit , hemophagiaSkill , during )
	endfunction
	public function addIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)+value , during )
	endfunction
	public function subIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)-value , during )
	endfunction

	/**
     * 打印某个单位的属性到桌面
     */
    public function show takes unit whichUnit returns nothing
		call console.info("生命："+R2S(getLife(whichUnit)))
        call console.info("魔法："+R2S(getMana(whichUnit)))
		call console.info("移动力："+R2S(getMove(whichUnit)))
		call console.info("防御："+R2S(getDefend(whichUnit)))
		call console.info("攻击速度："+R2S(getAttackSpeed(whichUnit)))
		call console.info("物理攻击力："+R2S(getAttackPhysical(whichUnit)))
		call console.info("魔法攻击力："+R2S(getAttackMagic(whichUnit)))
		call console.info("力量"+R2S(getStr(whichUnit)))
		call console.info("敏捷："+R2S(getAgi(whichUnit)))
		call console.info("智力："+R2S(getInt(whichUnit)))
		call console.info("力量(白)："+R2S(getStrWhite(whichUnit)))
		call console.info("敏捷(白)："+R2S(getAgiWhite(whichUnit)))
		call console.info("智力(白)："+R2S(getIntWhite(whichUnit)))
    endfunction

    private function init takes nothing returns nothing
    	set hash = InitHashtable()
    endfunction

endlibrary
