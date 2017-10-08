/* 属性系统 */
library hAttr initializer init needs hEvent

	globals
	    private real ATTRIBUTE_DEFAULT_HERO_ATTACKSPEED = 150		//默认攻击速度，除以100等于各个英雄的初始速度，用于计算攻击速度显示文本
	    private real ATTRIBUTE_DEFAULT_CHANGING_CD = 1.00			//默认属性切换冷却时间，避免过度计算引起性能下降
	    private hashtable hash = null
	    private integer ATTR_FLAG_UNIT = 1
	    private integer ATTR_FLAG_CD = 2
	    private integer ATTR_FLAG_LIFE = 3
	    private integer ATTR_FLAG_LIFE_BACK = 4
	    private integer ATTR_FLAG_LIFE_SOURCE = 5
	    private integer ATTR_FLAG_MANA = 6
	    private integer ATTR_FLAG_MANA_BACK = 7
	    private integer ATTR_FLAG_MANA_SOURCE = 8
	    private integer ATTR_FLAG_MOVE = 9
	    private integer ATTR_FLAG_DEFEND = 10
	    private integer ATTR_FLAG_RESISTANCE = 11
	    private integer ATTR_FLAG_ATTACK_SPEED = 12
	    private integer ATTR_FLAG_ATTACK_PHYSICAL = 13
	    private integer ATTR_FLAG_ATTACK_MAGIC = 14
	    private integer ATTR_FLAG_STR = 15
	    private integer ATTR_FLAG_AGI = 16
	    private integer ATTR_FLAG_INT = 17
	    private integer ATTR_FLAG_STR_WHITE = 18
	    private integer ATTR_FLAG_AGI_WHITE = 19
	    private integer ATTR_FLAG_INT_WHITE = 20
	    private integer ATTR_FLAG_TOUGHNESS = 21
	    private integer ATTR_FLAG_AVOID = 22
	    private integer ATTR_FLAG_AIM = 23
	    private integer ATTR_FLAG_KNOCKING = 24
	    private integer ATTR_FLAG_VIOLENCE = 25
	    private integer ATTR_FLAG_MORTAL_OPPOSE = 26
	    private integer ATTR_FLAG_PUNISH = 27
	    private integer ATTR_FLAG_MEDITATIVE = 28
	    private integer ATTR_FLAG_HELP = 29
	    private integer ATTR_FLAG_HEMOPHAGIA = 30
	    private integer ATTR_FLAG_HEMOPHAGIA_SKILL = 31
	    private integer ATTR_FLAG_SPLIT = 32
	    private integer ATTR_FLAG_GOLD_RATIO = 33
	    private integer ATTR_FLAG_LUMBER_RATIO = 34
	    private integer ATTR_FLAG_EXP_RATIO = 35
	    private integer ATTR_FLAG_SWIM = 36
	    private integer ATTR_FLAG_SWIM_OPPOSE = 37
	    private integer ATTR_FLAG_LUCK = 38
	    private integer ATTR_FLAG_INVINCIBLE = 39
	    private integer ATTR_FLAG_WEIGHT = 40
	    private integer ATTR_FLAG_HUNT_AMPLITUDE = 41
	    private integer ATTR_FLAG_HUNT_REBOUND = 42
	    private integer ATTR_FLAG_CURE = 43
	    private integer ATTR_FLAG_LIFE_SOURCE_CURRENT = 100
	    private integer ATTR_FLAG_MANA_SOURCE_CURRENT = 101
	    private integer ATTR_FLAG_PUNISH_CURRENT = 102
	    private integer ATTR_FLAG_WEIGHT_CURRENT = 103
		//护甲 1
		private integer Attr_Ability_defend_1 = 'A01J'
		//护甲 10
		private integer Attr_Ability_defend_10 = 'A07I'
		//护甲 100
		private integer Attr_Ability_defend_100 = 'A07M'
		//护甲 1000
		private integer Attr_Ability_defend_1000 = 'A0FC'
		//物理攻击力 1
		private integer Attr_Ability_attack_physical_1 = 'A01T'
		//物理攻击力 10
		private integer Attr_Ability_attack_physical_10 = 'A01R'
		//物理攻击力 100
		private integer Attr_Ability_attack_physical_100 = 'A01U'
		//物理攻击力 1000
		private integer Attr_Ability_attack_physical_1000 =  'A025'
		//物理攻击力 10000
		private integer Attr_Ability_attack_physical_10000 =  'A029'
		//物理攻击力书 1
		private integer Attr_Ability_attack_physical_item_1 = 'I00M'
		//物理攻击力书 10
		private integer Attr_Ability_attack_physical_item_10 = 'I00N'
		//物理攻击力书 100
		private integer Attr_Ability_attack_physical_item_100 = 'I00O'
		//物理攻击力书 1000
		private integer Attr_Ability_attack_physical_item_1000 =  'I00P'
		//物理攻击力书 10000
		private integer Attr_Ability_attack_physical_item_10000 =  'I00Q'
		//魔法攻击力 1
		private integer Attr_Ability_attack_magic_1 = 'A01K'
		//魔法攻击力 10
		private integer Attr_Ability_attack_magic_10 = 'A01V'
		//魔法攻击力 100
		private integer Attr_Ability_attack_magic_100 = 'A07H'
		//魔法攻击力 1000
		private integer Attr_Ability_attack_magic_1000 =  'A07N'
		//魔法攻击力 10000
		private integer Attr_Ability_attack_magic_10000 =  'A03D'
		//攻击速度% 1
		private integer Attr_Ability_attackSpeed_1 = 'A01M'
		//攻击速度% 10
		private integer Attr_Ability_attackSpeed_10 = 'A01P'
		//攻击速度% 100
		private integer Attr_Ability_attackSpeed_100 = 'A01Q'
		//力量 1
		private integer Attr_Ability_str_1 = 'A015'
		//力量 10
		private integer Attr_Ability_str_10 =  'A018'
		//力量 100
		private integer Attr_Ability_str_100 =  'A00P'
		//力量 1000
		private integer Attr_Ability_str_1000 = 'A00Q'
		//敏捷 1
		private integer Attr_Ability_agi_1 = 'A00U'
		//敏捷 10
		private integer Attr_Ability_agi_10 = 'A00V'
		//敏捷 100
		private integer Attr_Ability_agi_100 = 'A00X'
		//敏捷 1000
		private integer Attr_Ability_agi_1000 = 'A00Y'
		//智力 1
		private integer Attr_Ability_int_1 = 'A00Z'
		//智力 10
		private integer Attr_Ability_int_10 = 'A010'
		//智力 100
		private integer Attr_Ability_int_100 =  'A012'
		//智力 1000
		private integer Attr_Ability_int_1000 = 'A011'
		//生命 1
		private integer Attr_Ability_life_1 = 'A0F2'
		//生命 10
		private integer Attr_Ability_life_10 = 'A0F4'
		//生命 100
		private integer Attr_Ability_life_100 = 'A0F5'
		//生命 1000
		private integer Attr_Ability_life_1000 = 'A0F6'
		//生命 10000
		private integer Attr_Ability_life_10000 = 'A0F7'
		//魔法 1
		private integer Attr_Ability_mana_1 = 'A0F3'
		//魔法 10
		private integer Attr_Ability_mana_10 = 'A0F8'
		//魔法 100
		private integer Attr_Ability_mana_100 = 'A0F9'
		//魔法 1000
		private integer Attr_Ability_mana_1000 = 'A0FA'
		//魔法 10000
		private integer Attr_Ability_mana_10000 = 'A0FB'
		//******************正负分割线******************//
		//-护甲 1
		private integer Attr_Ability_defend_FU_1 = 'A01B'
		//-护甲 10
		private integer Attr_Ability_defend_FU_10 = 'A01C'
		//-护甲 100
		private integer Attr_Ability_defend_FU_100 = 'A01D'
		//-护甲 1000
		private integer Attr_Ability_defend_FU_1000 = 'A0FD'
		//物理攻击力 1
		private integer Attr_Ability_attack_physical_FU_1 = 'A02J'
		//物理攻击力 10
		private integer Attr_Ability_attack_physical_FU_10 = 'A02I'
		//物理攻击力 100
		private integer Attr_Ability_attack_physical_FU_100 = 'A02H'
		//物理攻击力 1000
		private integer Attr_Ability_attack_physical_FU_1000 =  'A02E'
		//物理攻击力 10000
		private integer Attr_Ability_attack_physical_FU_10000 =  'A02A'
		//物理攻击力书 1
		private integer Attr_Ability_attack_physical_FU_item_1 = 'I00R'
		//物理攻击力书 10
		private integer Attr_Ability_attack_physical_FU_item_10 = 'I00V'
		//物理攻击力书 100
		private integer Attr_Ability_attack_physical_FU_item_100 = 'I00U'
		//物理攻击力书 1000
		private integer Attr_Ability_attack_physical_FU_item_1000 =  'I00T'
		//物理攻击力书 10000
		private integer Attr_Ability_attack_physical_FU_item_10000 =  'I00S'
		//-魔法攻击力 1
		private integer Attr_Ability_attack_magic_FU_1 = 'A01G'
		//-魔法攻击力 10
		private integer Attr_Ability_attack_magic_FU_10 = 'A01L'
		//-魔法攻击力 100
		private integer Attr_Ability_attack_magic_FU_100 = 'A01O'
		//-魔法攻击力 1000
		private integer Attr_Ability_attack_magic_FU_1000 =  'A01S'
		//-魔法攻击力 10000
		private integer Attr_Ability_attack_magic_FU_10000 =  'A03E'
		//-攻击速度% 1
		private integer Attr_Ability_attackSpeed_FU_1 = 'A01W'
		//-攻击速度% 10
		private integer Attr_Ability_attackSpeed_FU_10 = 'A021'
		//-攻击速度% 100
		private integer Attr_Ability_attackSpeed_FU_100 = 'A020'
		//-力量 1
		private integer Attr_Ability_str_FU_1 = 'A022'
		//-力量 10
		private integer Attr_Ability_str_FU_10 =  'A024'
		//-力量 100
		private integer Attr_Ability_str_FU_100 =  'A023'
		//-力量 1000
		private integer Attr_Ability_str_FU_1000 = 'A02B'
		//-敏捷 1
		private integer Attr_Ability_agi_FU_1 = 'A02C'
		//-敏捷 10
		private integer Attr_Ability_agi_FU_10 = 'A02D'
		//-敏捷 100
		private integer Attr_Ability_agi_FU_100 = 'A02Y'
		//-敏捷 1000
		private integer Attr_Ability_agi_FU_1000 = 'A02K'
		//-智力 1
		private integer Attr_Ability_int_FU_1 = 'A03X'
		//-智力 10
		private integer Attr_Ability_int_FU_10 = 'A04L'
		//-智力 100
		private integer Attr_Ability_int_FU_100 =  'A04V'
		//-智力 1000
		private integer Attr_Ability_int_FU_1000 = 'A04N'
		//-生命 1
		private integer Attr_Ability_life_FU_1 = 'A0FE'
		//-生命 10
		private integer Attr_Ability_life_FU_10 = 'A0FF'
		//-生命 100
		private integer Attr_Ability_life_FU_100 = 'A0FG'
		//-生命 1000
		private integer Attr_Ability_life_FU_1000 = 'A0FH'
		//-生命 10000
		private integer Attr_Ability_life_FU_10000 = 'A0FI'
		//-魔法 1
		private integer Attr_Ability_mana_FU_1 = 'A0FJ'
		//-魔法 10
		private integer Attr_Ability_mana_FU_10 = 'A0FK'
		//-魔法 100
		private integer Attr_Ability_mana_FU_100 = 'A0FL'
		//-魔法 1000
		private integer Attr_Ability_mana_FU_1000 = 'A0FM'
		//-魔法 10000
		private integer Attr_Ability_mana_FU_10000 = 'A0FN'
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
	//攻速 		下限：-80% 上限：无（实际上有大概400%）
    //活力 魔法	下限：1 上限：100000
    //硬直    	下限：1
    //物暴 术暴 分裂 回避 移动力 力量 敏捷 智力 冥想力 救助力 吸血 负重 各率 下限：0
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
				if( futureVal >= 100000 ) then
					if( currentVal >= 100000 ) then
						set diff = 0
					else
						set diff = 100000 - currentVal
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
				if( futureVal >= 100000 ) then
					if( currentVal >= 100000 ) then
						set diff = 0
					else
						set diff = 100000 - currentVal
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
				elseif( futureVal >522 ) then
					call SetUnitMoveSpeed( whichUnit , 522 )
				else
					call SetUnitMoveSpeed( whichUnit , R2I(futureVal) )
				endif
			elseif( flag == ATTR_FLAG_DEFEND ) then
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1 ) <1 )then
					call UnitAddAbility( whichUnit , Attr_Ability_defend_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_1000)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1000)
				endif
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
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1 ) <1 )then
					call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_100)
				endif
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
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1 ) <1 )then
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
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_str_1 ) <1 )then
					call UnitAddAbility( whichUnit , Attr_Ability_str_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_1000)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1000)
				endif
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_AGI ) then
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1 ) <1 )then
					call UnitAddAbility( whichUnit , Attr_Ability_agi_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_1000)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1000)
				endif
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_INT ) then
				if( GetUnitAbilityLevel( whichUnit , Attr_Ability_int_1 ) <1 )then
					call UnitAddAbility( whichUnit , Attr_Ability_int_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_1000)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_100)
			        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1000)
				endif
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
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
			elseif( flag == ATTR_FLAG_PUNISH ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( currentVal > 0 ) then
					set tempPercent = futureVal / currentVal
					call SaveReal( hash , uhid , ATTR_FLAG_PUNISH_CURRENT , tempPercent*LoadReal( hash , uhid , ATTR_FLAG_PUNISH_CURRENT ) )
				else
					call SaveReal( hash , uhid , ATTR_FLAG_PUNISH_CURRENT , futureVal )
				endif
			elseif( flag == ATTR_FLAG_PUNISH_CURRENT ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				if( futureVal > LoadReal( hash , uhid , ATTR_FLAG_PUNISH ) ) then
					set futureVal = LoadReal( hash , uhid , ATTR_FLAG_PUNISH )
				endif
				call SaveReal( hash , uhid , flag , futureVal )
			else
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
			endif
		endif//diff
	endfunction

	private function setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = time.getInteger(t,1)
		local unit whichUnit = time.getUnit(t,2)
		local real diff = time.getReal(t,3)
		call time.delTimer( t , null )
		call setAttrDo( flag , whichUnit , diff )
	endfunction

	/* 验证单位是否初始化过参数 */
	public function initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash , uhid , ATTR_FLAG_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
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
			//
			call SaveInteger( hash , uhid , ATTR_FLAG_UNIT , uhid )
			//todo 变量初始化
			call SaveBoolean( hash , uhid , ATTR_FLAG_CD , false )
			call SaveReal( hash , uhid , ATTR_FLAG_LIFE , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit) )
			call SaveReal( hash , uhid , ATTR_FLAG_LIFE_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_LIFE_SOURCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_LIFE_SOURCE_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MANA , GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit) )
			call SaveReal( hash , uhid , ATTR_FLAG_MANA_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MANA_SOURCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MANA_SOURCE_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MOVE , GetUnitDefaultMoveSpeed(whichUnit) )
			call SaveReal( hash , uhid , ATTR_FLAG_DEFEND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_RESISTANCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_SPEED , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_ATTACK_MAGIC , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_STR , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AGI , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_INT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_STR_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AGI_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_INT_WHITE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_TOUGHNESS , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AVOID , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_AIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_KNOCKING , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_VIOLENCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MORTAL_OPPOSE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_PUNISH , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_PUNISH_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_MEDITATIVE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_HELP , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_HEMOPHAGIA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_SPLIT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_GOLD_RATIO , 100 )
			call SaveReal( hash , uhid , ATTR_FLAG_LUMBER_RATIO , 100 )
			call SaveReal( hash , uhid , ATTR_FLAG_EXP_RATIO , 100 )
			call SaveReal( hash , uhid , ATTR_FLAG_SWIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_SWIM_OPPOSE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_LUCK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_INVINCIBLE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_WEIGHT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_WEIGHT_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_HUNT_REBOUND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_CURE , 0 )
			//todo 设定默认值
			if( is.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_STR_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*1 )
				call setAttrDo( ATTR_FLAG_LIFE , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_FLAG_TOUGHNESS , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_KNOCKING , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_FLAG_PUNISH , whichUnit , tempReal*10 )
				call setAttrDo( ATTR_FLAG_SWIM , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_FLAG_SWIM_OPPOSE , whichUnit , tempReal*3 )
				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_AGI_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*2 )
				call setAttrDo( ATTR_FLAG_ATTACK_SPEED , whichUnit , tempReal*0.05 )
				call setAttrDo( ATTR_FLAG_KNOCKING , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_FLAG_AVOID , whichUnit , tempReal*5 )
				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call SaveReal( hash , uhid , ATTR_FLAG_INT_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_FLAG_MANA , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_FLAG_MANA_BACK , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_VIOLENCE , whichUnit , tempReal*10 )
				call setAttrDo( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , tempReal*0.02 )
				//救助力
				call setAttrDo( ATTR_FLAG_HELP , whichUnit , 100 + 2 * I2R(GetHeroLevel(whichUnit)-1) )
				//负重
				call setAttrDo( ATTR_FLAG_WEIGHT , whichUnit , 10.00 + 0.25 * I2R(GetHeroLevel(whichUnit)-1) )
				//源
				call setAttrDo( ATTR_FLAG_LIFE_SOURCE , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_LIFE_SOURCE_CURRENT , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_MANA_SOURCE , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_MANA_SOURCE_CURRENT , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
			else
				call SaveReal( hash , uhid , ATTR_FLAG_PUNISH , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)*2 )
				call SaveReal( hash , uhid , ATTR_FLAG_PUNISH_CURRENT , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)*2 )
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

	/* 生命恢复 ------------------------------------------------------------ */
	public function getLifeBack takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE_BACK , whichUnit )
	endfunction
	public function addLifeBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_BACK , whichUnit , value , during )
	endfunction
	public function subLifeBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_BACK , whichUnit , -value , during )
	endfunction
	public function setLifeBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endfunction

	/* 生命源 ------------------------------------------------------------ */
	public function getLifeSource takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE_SOURCE , whichUnit )
	endfunction
	public function addLifeSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE , whichUnit , value , during )
	endfunction
	public function subLifeSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE , whichUnit , -value , during )
	endfunction
	public function setLifeSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE , whichUnit , value - getLifeSource(whichUnit) , during )
	endfunction

	/* 生命源(当前) ------------------------------------------------------------ */
	public function getLifeSourceCurrent takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE_SOURCE_CURRENT , whichUnit )
	endfunction
	public function addLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE_CURRENT , whichUnit , value , during )
	endfunction
	public function subLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE_CURRENT , whichUnit , -value , during )
	endfunction
	public function setLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE_SOURCE_CURRENT , whichUnit , value - getLifeSourceCurrent(whichUnit) , during )
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

	/* 魔法恢复 ------------------------------------------------------------ */
	public function getManaBack takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MANA_BACK , whichUnit )
	endfunction
	public function addManaBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_BACK , whichUnit , value , during )
	endfunction
	public function subManaBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_BACK , whichUnit , -value , during )
	endfunction
	public function setManaBack takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endfunction

	/* 魔法源 ------------------------------------------------------------ */
	public function getManaSource takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MANA_SOURCE , whichUnit )
	endfunction
	public function addManaSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE , whichUnit , value , during )
	endfunction
	public function subManaSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE , whichUnit , -value , during )
	endfunction
	public function setManaSource takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE , whichUnit , value - getManaSource(whichUnit) , during )
	endfunction

	/* 魔法源(当前) ------------------------------------------------------------ */
	public function getManaSourceCurrent takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MANA_SOURCE_CURRENT , whichUnit )
	endfunction
	public function addManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE_CURRENT , whichUnit , value , during )
	endfunction
	public function subManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE_CURRENT , whichUnit , -value , during )
	endfunction
	public function setManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA_SOURCE_CURRENT , whichUnit , value - getManaSourceCurrent(whichUnit) , during )
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

	/* 魔抗 ------------------------------------------------------------ */
	public function getResistance takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_RESISTANCE , whichUnit )
	endfunction
	public function addResistance takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_RESISTANCE , whichUnit , value , during )
	endfunction
	public function subResistance takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_RESISTANCE , whichUnit , -value , during )
	endfunction
	public function setResistance takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_RESISTANCE , whichUnit , value - getResistance(whichUnit) , during )
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
		local real swim = value*3
		local real swimOppose = value*3
		local real avoid = value*-2
		local real violence = value*-3
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call setAttr( ATTR_FLAG_TOUGHNESS , whichUnit , toughness , during )
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , punish , during )
		call setAttr( ATTR_FLAG_SWIM , whichUnit , swim , during )
		call setAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit , swimOppose , during )
		call setAttr( ATTR_FLAG_AVOID , whichUnit , avoid , during )
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , violence , during )
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
		local real avoid = value*3
		local real punish = -value*2
		local real violence = -value*1
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_AVOID , whichUnit , avoid , during )
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , punish , during )
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , violence , during )
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
		call setAttr( ATTR_FLAG_MANA_BACK , whichUnit , manaback , during )
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , violence , during )
		call setAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , hemophagiaSkill , during )
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
		local real swim = value*5
		local real swimOppose = value*5
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call setAttr( ATTR_FLAG_TOUGHNESS , whichUnit , toughness , during )
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , punish , during )
		call setAttr( ATTR_FLAG_SWIM , whichUnit , swim , during )
		call setAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit , swimOppose , during )
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
		local real avoid = value*5
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_AVOID , whichUnit , avoid , during )
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
		call setAttr( ATTR_FLAG_MANA_BACK , whichUnit , manaback , during )
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , violence , during )
		call setAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , hemophagiaSkill , during )
	endfunction
	public function addIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)+value , during )
	endfunction
	public function subIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)-value , during )
	endfunction

	/* 韧性 ------------------------------------------------------------ */
	public function getToughness takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_TOUGHNESS , whichUnit )
	endfunction
	public function addToughness takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_TOUGHNESS , whichUnit , value , during )
	endfunction
	public function subToughness takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_TOUGHNESS , whichUnit , -value , during )
	endfunction
	public function setToughness takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_TOUGHNESS , whichUnit , value - getToughness(whichUnit) , during )
	endfunction

	/* 回避 ------------------------------------------------------------ */
	public function getAvoid takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AVOID , whichUnit )
	endfunction
	public function addAvoid takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AVOID , whichUnit , value , during )
	endfunction
	public function subAvoid takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AVOID , whichUnit , -value , during )
	endfunction
	public function setAvoid takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AVOID , whichUnit , value - getAvoid(whichUnit) , during )
	endfunction

	/* 命中 ------------------------------------------------------------ */
	public function getAim takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AIM , whichUnit )
	endfunction
	public function addAim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AIM , whichUnit , value , during )
	endfunction
	public function subAim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AIM , whichUnit , -value , during )
	endfunction
	public function setAim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_AIM , whichUnit , value - getAim(whichUnit) , during )
	endfunction

	/* 物理暴击 ------------------------------------------------------------ */
	public function getKnocking takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_KNOCKING , whichUnit )
	endfunction
	public function addKnocking takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , value , during )
	endfunction
	public function subKnocking takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , -value , during )
	endfunction
	public function setKnocking takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endfunction

	/* 魔法暴击 ------------------------------------------------------------ */
	public function getViolence takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_VIOLENCE , whichUnit )
	endfunction
	public function addViolence takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , value , during )
	endfunction
	public function subViolence takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , -value , during )
	endfunction
	public function setViolence takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endfunction

	/* 致命抵抗 ------------------------------------------------------------ */
	public function getMortalOppose takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MORTAL_OPPOSE , whichUnit )
	endfunction
	public function addMortalOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MORTAL_OPPOSE , whichUnit , value , during )
	endfunction
	public function subMortalOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MORTAL_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setMortalOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MORTAL_OPPOSE , whichUnit , value - getMortalOppose(whichUnit) , during )
	endfunction

	/* 硬直 ------------------------------------------------------------ */
	public function getPunish takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_PUNISH , whichUnit )
	endfunction
	public function addPunish takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , value , during )
	endfunction
	public function subPunish takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , -value , during )
	endfunction
	public function setPunish takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH , whichUnit , value - getPunish(whichUnit) , during )
	endfunction

	/* 硬直（当前） ------------------------------------------------------------ */
	public function getPunishCurrent takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_PUNISH_CURRENT , whichUnit )
	endfunction
	public function addPunishCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH_CURRENT , whichUnit , value , during )
	endfunction
	public function subPunishCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH_CURRENT , whichUnit , -value , during )
	endfunction
	public function setPunishCurrent takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_PUNISH_CURRENT , whichUnit , value - getPunishCurrent(whichUnit) , during )
	endfunction

	/* 冥想力 ------------------------------------------------------------ */
	public function getMeditative takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MEDITATIVE , whichUnit )
	endfunction
	public function addMeditative takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MEDITATIVE , whichUnit , value , during )
	endfunction
	public function subMeditative takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MEDITATIVE , whichUnit , -value , during )
	endfunction
	public function setMeditative takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MEDITATIVE , whichUnit , value - getMeditative(whichUnit) , during )
	endfunction

	/* 救助力 ------------------------------------------------------------ */
	public function getHelp takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_HELP , whichUnit )
	endfunction
	public function addHelp takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HELP , whichUnit , value , during )
	endfunction
	public function subHelp takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HELP , whichUnit , -value , during )
	endfunction
	public function setHelp takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HELP , whichUnit , value - getHelp(whichUnit) , during )
	endfunction

	/* 吸血 ------------------------------------------------------------ */
	public function getHemophagia takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_HEMOPHAGIA , whichUnit )
	endfunction
	public function addHemophagia takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA , whichUnit , value , during )
	endfunction
	public function subHemophagia takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA , whichUnit , -value , during )
	endfunction
	public function setHemophagia takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endfunction

	/* 技能吸血 ------------------------------------------------------------ */
	public function getHemophagiaSkill takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit )
	endfunction
	public function addHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , value , during )
	endfunction
	public function subHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , -value , during )
	endfunction
	public function setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endfunction

	/* 分裂 ------------------------------------------------------------ */
	public function getSplit takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_SPLIT , whichUnit )
	endfunction
	public function addSplit takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SPLIT , whichUnit , value , during )
	endfunction
	public function subSplit takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SPLIT , whichUnit , -value , during )
	endfunction
	public function setSplit takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endfunction

	/* 黄金率 ------------------------------------------------------------ */
	public function getGoldRatio takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_GOLD_RATIO , whichUnit )
	endfunction
	public function addGoldRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_GOLD_RATIO , whichUnit , value , during )
	endfunction
	public function subGoldRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_GOLD_RATIO , whichUnit , -value , during )
	endfunction
	public function setGoldRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_GOLD_RATIO , whichUnit , value - getGoldRatio(whichUnit) , during )
	endfunction

	/* 木头率 ------------------------------------------------------------ */
	public function getLumberRatio takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LUMBER_RATIO , whichUnit )
	endfunction
	public function addLumberRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUMBER_RATIO , whichUnit , value , during )
	endfunction
	public function subLumberRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUMBER_RATIO , whichUnit , -value , during )
	endfunction
	public function setLumberRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUMBER_RATIO , whichUnit , value - getLumberRatio(whichUnit) , during )
	endfunction

	/* 经验率 ------------------------------------------------------------ */
	public function getExpRatio takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_EXP_RATIO , whichUnit )
	endfunction
	public function addExpRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_EXP_RATIO , whichUnit , value , during )
	endfunction
	public function subExpRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_EXP_RATIO , whichUnit , -value , during )
	endfunction
	public function setExpRatio takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_EXP_RATIO , whichUnit , value - getExpRatio(whichUnit) , during )
	endfunction

	/* 眩晕 ------------------------------------------------------------ */
	public function getSwim takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_SWIM , whichUnit )
	endfunction
	public function addSwim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM , whichUnit , value , during )
	endfunction
	public function subSwim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM , whichUnit , -value , during )
	endfunction
	public function setSwim takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM , whichUnit , value - getSwim(whichUnit) , during )
	endfunction

	/* 眩晕抵抗 ------------------------------------------------------------ */
	public function getSwimOppose takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit )
	endfunction
	public function addSwimOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit , value , during )
	endfunction
	public function subSwimOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setSwimOppose takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SWIM_OPPOSE , whichUnit , value - getSwimOppose(whichUnit) , during )
	endfunction

	/* 运气 ------------------------------------------------------------ */
	public function getLuck takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LUCK , whichUnit )
	endfunction
	public function addLuck takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUCK , whichUnit , value , during )
	endfunction
	public function subLuck takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUCK , whichUnit , -value , during )
	endfunction
	public function setLuck takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endfunction

	/* 无敌 ------------------------------------------------------------ */
	public function getInvincible takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INVINCIBLE , whichUnit )
	endfunction
	public function addInvincible takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_INVINCIBLE , whichUnit , value , during )
	endfunction
	public function subInvincible takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_INVINCIBLE , whichUnit , -value , during )
	endfunction
	public function setInvincible takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_INVINCIBLE , whichUnit , value - getInvincible(whichUnit) , during )
	endfunction

	/* 负重 ------------------------------------------------------------ */
	public function getWeight takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_WEIGHT , whichUnit )
	endfunction
	public function addWeight takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_WEIGHT , whichUnit , value , 0 )
	endfunction
	public function subWeight takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_WEIGHT , whichUnit , -value , 0 )
	endfunction
	public function setWeight takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_WEIGHT , whichUnit , value - getWeight(whichUnit) , 0 )
	endfunction

	/* 当前负重 ------------------------------------------------------------ */
	public function getWeightCurrent takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_WEIGHT_CURRENT , whichUnit )
	endfunction
	public function setWeightCurrent takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_WEIGHT_CURRENT , whichUnit , value - getWeightCurrent(whichUnit) , 0 )
	endfunction

	/* 伤害增幅 ------------------------------------------------------------ */
	public function getHuntAmplitude takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_HUNT_AMPLITUDE , whichUnit )
	endfunction
	public function addHuntAmplitude takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HUNT_AMPLITUDE , whichUnit , value , during )
	endfunction
	public function subHuntAmplitude takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HUNT_AMPLITUDE , whichUnit , -value , during )
	endfunction
	public function setHuntAmplitude takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , 0 )
	endfunction

	/* 伤害反射 ------------------------------------------------------------ */
	public function getHuntRebound takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_HUNT_REBOUND , whichUnit )
	endfunction
	public function addHuntRebound takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HUNT_REBOUND , whichUnit , value , during )
	endfunction
	public function subHuntRebound takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_HUNT_REBOUND , whichUnit , -value , during )
	endfunction
	public function setHuntRebound takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_HUNT_REBOUND , whichUnit , value - getHuntRebound(whichUnit) , 0 )
	endfunction

	/* 治疗 ------------------------------------------------------------ */
	public function getCure takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_CURE , whichUnit )
	endfunction
	public function addCure takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_CURE , whichUnit , value , during )
	endfunction
	public function subCure takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_CURE , whichUnit , -value , during )
	endfunction
	public function setCure takes unit whichUnit , real value returns nothing
		call setAttr( ATTR_FLAG_CURE , whichUnit , value - getCure(whichUnit) , 0 )
	endfunction

	/**
     * 打印某个单位的属性到桌面
     */
    public function showAttr takes unit whichUnit returns nothing
		call hMsg_print("生命："+R2S(getLife(whichUnit)))
		call hMsg_print("生命恢复："+R2S(getLifeBack(whichUnit)))
		call hMsg_print("生命源："+R2S(getLifeSource(whichUnit)))
		call hMsg_print("生命源（Current）："+R2S(getLifeSourceCurrent(whichUnit)))
        call hMsg_print("魔法："+R2S(getMana(whichUnit)))
        call hMsg_print("魔法恢复："+R2S(getManaBack(whichUnit)))
        call hMsg_print("魔法源："+R2S(getManaSource(whichUnit)))
		call hMsg_print("魔法源（Current）："+R2S(getManaSourceCurrent(whichUnit)))
		call hMsg_print("移动力："+R2S(getMove(whichUnit)))
		call hMsg_print("防御："+R2S(getDefend(whichUnit)))
		call hMsg_print("魔抗："+R2S(getResistance(whichUnit)))
		call hMsg_print("攻击速度："+R2S(getAttackSpeed(whichUnit)))
		call hMsg_print("物理攻击力："+R2S(getAttackPhysical(whichUnit)))
		call hMsg_print("魔法攻击力："+R2S(getAttackMagic(whichUnit)))
		call hMsg_print("体质："+R2S(getStr(whichUnit)))
		call hMsg_print("身法："+R2S(getAgi(whichUnit)))
		call hMsg_print("技巧："+R2S(getInt(whichUnit)))
		call hMsg_print("体质(白)："+R2S(getStrWhite(whichUnit)))
		call hMsg_print("身法(白)："+R2S(getAgiWhite(whichUnit)))
		call hMsg_print("技巧(白)："+R2S(getIntWhite(whichUnit)))
		call hMsg_print("韧性："+R2S(getToughness(whichUnit)))
		call hMsg_print("回避："+R2S(getAvoid(whichUnit)))
		call hMsg_print("命中："+R2S(getAim(whichUnit)))
		call hMsg_print("物暴："+R2S(getKnocking(whichUnit)))
        call hMsg_print("术暴："+R2S(getViolence(whichUnit)))
        call hMsg_print("致命抵抗："+R2S(getMortalOppose(whichUnit)))
		call hMsg_print("硬直："+R2S(getPunish(whichUnit)))
		call hMsg_print("硬直当前："+R2S(getPunishCurrent(whichUnit)))
		call hMsg_print("冥想力："+R2S(getMeditative(whichUnit)))
		call hMsg_print("救助力："+R2S(getHelp(whichUnit)))
		call hMsg_print("吸血："+R2S(getHemophagia(whichUnit)))
		call hMsg_print("技能吸血："+R2S(getHemophagiaSkill(whichUnit)))
		call hMsg_print("分裂："+R2S(getSplit(whichUnit)))
		call hMsg_print("金钱获得比例："+R2S(getGoldRatio(whichUnit)))
        call hMsg_print("木头获得比例："+R2S(getLumberRatio(whichUnit)))
        call hMsg_print("经验获得比例："+R2S(getExpRatio(whichUnit)))
		call hMsg_print("眩晕："+R2S(getSwim(whichUnit)))
		call hMsg_print("眩晕抵抗："+R2S(getSwimOppose(whichUnit)))
		call hMsg_print("运气："+R2S(getLuck(whichUnit)))
		call hMsg_print("无敌："+R2S(getInvincible(whichUnit)))
        call hMsg_print("负重："+R2S(getWeight(whichUnit)))
        call hMsg_print("负重当前："+R2S(getWeightCurrent(whichUnit)))
        call hMsg_print("伤害增幅："+R2S(getHuntAmplitude(whichUnit)))
    endfunction

    private function init takes nothing returns nothing
    	set hash = InitHashtable()
    endfunction

endlibrary
