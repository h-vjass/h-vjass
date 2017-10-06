
library attributeItem requires attributeHunt

	globals

	endglobals

	//物品缓存
	private function setItemCacheAttr takes integer flag , unit whichUnit , real value returns nothing
		call attribute_initAttr( whichUnit )
		call SaveReal( HASH_Attribute_ItemCache , GetHandleId(whichUnit) , flag , value )
	endfunction

	private function getItemCacheAttr takes integer flag , unit whichUnit returns real
		call attribute_initAttr( whichUnit )
		return LoadReal( HASH_Attribute_ItemCache , GetHandleId(whichUnit) , flag )
	endfunction

	private function setItemCacheCD takes unit whichUnit , boolean status returns nothing
		call attribute_initAttr( whichUnit )
		call SaveBoolean( HASH_Attribute_ItemCache , GetHandleId(whichUnit) , ATTR_FLAG_CD , status )
	endfunction

	private function getItemCacheCD takes unit whichUnit returns boolean
		call attribute_initAttr( whichUnit )
		return LoadBoolean( HASH_Attribute_ItemCache , GetHandleId(whichUnit) , ATTR_FLAG_CD )
	endfunction

	/* ------------------------------------------------- 计算物品栏属性 ------------------------------------------------------------ */
	//物品加成
    //物品的全局判断计算
    //注意需要计算次数
	private function calculateItemDo takes unit whichUnit returns nothing
		local integer uhid = GetHandleId(whichUnit)
        local integer i = 1
        local item it = null
        local integer itId = 0
        local integer itCharges = 0
		//------------------
		local real temp_life = 0
	    local real temp_life_back = 0
	    local real temp_life_source = 0
	    local real temp_life_source_current = 0
	    local real temp_mana = 0
	    local real temp_mana_back = 0
	    local real temp_mana_source = 0
	    local real temp_mana_source_current = 0
	    local real temp_move = 0
	    local real temp_defend = 0
	    local real temp_resistance = 0
	    local real temp_attack_speed = 0
	    local real temp_attack_physical = 0
	    local real temp_attack_magic = 0
	    local real temp_str = 0
	    local real temp_agi = 0
	    local real temp_int = 0
	    local real temp_str_white = 0
	    local real temp_agi_white = 0
	    local real temp_int_white = 0
	    local real temp_toughness = 0
	    local real temp_avoid = 0
	    local real temp_aim = 0
	    local real temp_knocking = 0
	    local real temp_violence = 0
	    local real temp_mortal_oppose = 0
	    local real temp_punish = 0
	    local real temp_punish_current = 0
	    local real temp_meditative = 0
	    local real temp_help = 0
	    local real temp_hemophagia = 0
	    local real temp_hemophagia_skill = 0
	    local real temp_gold_ratio = 0
	    local real temp_lumber_ratio = 0
	    local real temp_exp_ratio = 0
	    local real temp_split = 0
	    local real temp_swim = 0
	    local real temp_swim_oppose = 0
	    local real temp_luck = 0
	    local real temp_invincible = 0
	    local real temp_weight =0
	    local real temp_weight_current = 0
	    local real temp_hunt_amplitude = 0
	    local real temp_hunt_rebound = 0
	    local real temp_cure = 0
        //获取物品上一次哈希值
		local real preHash_life 				= attribute_getLife(whichUnit)
		local real preHash_life_back 			= attribute_getLifeBack(whichUnit)
		local real preHash_life_source 			= attribute_getLifeSource(whichUnit)
		local real preHash_life_source_current 	= attribute_getLifeSourceCurrent(whichUnit)
		local real preHash_mana 				= attribute_getMana(whichUnit)
		local real preHash_mana_back 			= attribute_getManaBack(whichUnit)
		local real preHash_mana_source 			= attribute_getManaSource(whichUnit)
		local real preHash_mana_source_current 	= attribute_getManaSourceCurrent(whichUnit)
		local real preHash_move 				= attribute_getMove(whichUnit)
		local real preHash_defend 				= attribute_getDefend(whichUnit)
		local real preHash_resistance 			= attribute_getResistance(whichUnit)
		local real preHash_attack_speed 		= attribute_getAttackSpeed(whichUnit)
		local real preHash_attack_physical 		= attribute_getAttackPhysical(whichUnit)
		local real preHash_attack_magic			= attribute_getAttackMagic(whichUnit)
		local real preHash_str 					= attribute_getStr(whichUnit)
		local real preHash_agi 					= attribute_getAgi(whichUnit)
		local real preHash_int 					= attribute_getInt(whichUnit)
		local real preHash_str_white 			= attribute_getStrWhite(whichUnit)
		local real preHash_agi_white 			= attribute_getAgiWhite(whichUnit)
		local real preHash_int_white 			= attribute_getIntWhite(whichUnit)
		local real preHash_toughness 			= attribute_getToughness(whichUnit)
		local real preHash_avoid 				= attribute_getAvoid(whichUnit)
		local real preHash_aim 					= attribute_getAim(whichUnit)
		local real preHash_knocking 			= attribute_getKnocking(whichUnit)
		local real preHash_violence 			= attribute_getViolence(whichUnit)
		local real preHash_mortal_oppose 		= attribute_getMortalOppose(whichUnit)
		local real preHash_punish 				= attribute_getPunish(whichUnit)
		local real preHash_punish_current 		= attribute_getPunishCurrent(whichUnit)
		local real preHash_meditative 			= attribute_getMeditative(whichUnit)
		local real preHash_help 				= attribute_getHelp(whichUnit)
		local real preHash_hemophagia 			= attribute_getHemophagia(whichUnit)
		local real preHash_hemophagia_skill 	= attribute_getHemophagia(whichUnit)
		local real preHash_split 				= attribute_getSplit(whichUnit)
		local real preHash_gold_ratio 			= attribute_getGoldRatio(whichUnit)
		local real preHash_lumber_ratio 		= attribute_getLumberRatio(whichUnit)
		local real preHash_exp_ratio 			= attribute_getExpRatio(whichUnit)
		local real preHash_swim 				= attribute_getSwim(whichUnit)
		local real preHash_swim_oppose 			= attribute_getSwimOppose(whichUnit)
		local real preHash_luck	 				= attribute_getLuck(whichUnit)
		local real preHash_invincible 			= attribute_getInvincible(whichUnit)
		local real preHash_weight 				= attribute_getWeight(whichUnit)
		local real preHash_weight_current 		= attribute_getWeightCurrent(whichUnit)
		local real preHash_hunt_amplitude 		= attribute_getHuntAmplitude(whichUnit)
		local real preHash_hunt_rebound 		= attribute_getHuntRebound(whichUnit)
		local real preHash_cure 				= attribute_getCure(whichUnit)
        loop
            exitwhen i > 6  //6格物品栏
                set it = UnitItemInSlot(whichUnit, i-1)
                if( it != null ) then
	                set itId = GetItemTypeId(it)
	                set itCharges = GetItemCharges(it)
	                //负重
	                set temp_weight_current = temp_weight_current + items_getWeightByItemId( itId ) * I2R(itCharges)
					/*--------------------------------COPY--------------------------------*/






					/*----------------------------END COPY------------------------------*/
                endif
            set i = i + 1
        endloop
        set it = null
        //计算差异性
        set temp_life = temp_life - preHash_life
	    set temp_life_back = temp_life_back - preHash_life_back
	    set temp_life_source = temp_life_source - preHash_life_source
	    set temp_life_source_current = temp_life_source_current - preHash_life_source_current
	    set temp_mana = temp_mana - preHash_mana
	    set temp_mana_back = temp_mana_back - preHash_mana_back
	    set temp_mana_source = temp_mana_source - preHash_mana_source
	    set temp_mana_source_current = temp_mana_source_current - preHash_mana_source_current
	    set temp_move = temp_move - preHash_move
	    set temp_defend = temp_defend - preHash_defend
	    set temp_resistance = temp_resistance - preHash_resistance
	    set temp_attack_speed = temp_attack_speed - preHash_attack_speed
	    set temp_attack_physical = temp_attack_physical - preHash_attack_physical
	    set temp_attack_magic = temp_attack_magic - preHash_attack_magic
	    set temp_str = temp_str - preHash_str
	    set temp_agi = temp_agi - preHash_agi
	    set temp_int = temp_int - preHash_int
	    set temp_str_white = temp_str_white - preHash_str_white
	    set temp_agi_white = temp_agi_white - preHash_agi_white
	    set temp_int_white = temp_int_white - preHash_int_white
	    set temp_toughness = temp_toughness - preHash_toughness
	    set temp_avoid = temp_avoid - preHash_avoid
	    set temp_aim = temp_aim - preHash_aim
	    set temp_knocking = temp_knocking - preHash_knocking
	    set temp_violence = temp_violence - preHash_violence
	    set temp_mortal_oppose = temp_mortal_oppose - preHash_mortal_oppose
	    set temp_punish = temp_punish - preHash_punish
	    set temp_punish_current = temp_punish_current - preHash_punish_current
	    set temp_meditative = temp_meditative - preHash_meditative
	    set temp_help = temp_help - preHash_help
	    set temp_hemophagia = temp_hemophagia - preHash_hemophagia
	    set temp_hemophagia_skill = temp_hemophagia_skill - preHash_hemophagia_skill
	    set temp_split = temp_split - preHash_split
	    set temp_gold_ratio = temp_gold_ratio - preHash_gold_ratio
	    set temp_lumber_ratio = temp_lumber_ratio - preHash_lumber_ratio
	    set temp_exp_ratio = temp_exp_ratio - preHash_exp_ratio
	    set temp_swim = temp_swim - preHash_swim
	    set temp_swim_oppose = temp_swim_oppose - preHash_swim_oppose
	    set temp_luck = temp_luck - preHash_luck
	    set temp_invincible = temp_invincible - preHash_invincible
	    set temp_weight = temp_weight - preHash_weight
	    set temp_weight_current = temp_weight_current - preHash_weight_current
	    set temp_hunt_amplitude = temp_hunt_amplitude - preHash_hunt_amplitude
	    set temp_hunt_rebound = temp_hunt_rebound - preHash_hunt_rebound
	    set temp_cure = temp_cure - preHash_cure
        //todo SET
        call attribute_setWeightCurrent(whichUnit,temp_weight_current)
	endfunction
	private function calculateItemCD takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit whichUnit = funcs_getTimerParams_Unit( t , Key_Skill_Unit )
		local integer uhid = GetHandleId(whichUnit)
		call funcs_delTimer( t , null )
		call SaveBoolean( HASH_Attribute_ItemCache , ATTR_FLAG_CD , uhid , false )
		call calculateItemDo( whichUnit )
	endfunction
	public function calculateItem takes unit whichUnit returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local boolean isCDing = false
		local timer t = null
		set isCDing = LoadBoolean( HASH_Attribute_ItemCache , ATTR_FLAG_CD , uhid )
		if( isCDing == true) then
			set t = funcs_setTimeout( 0.5 , function calculateItemCD )
			call funcs_setTimerParams_Unit( t , Key_Skill_Unit , whichUnit )
		else
			call SaveBoolean( HASH_Attribute_ItemCache , ATTR_FLAG_CD , uhid , true )
			call calculateItemDo(whichUnit)
		endif
	endfunction

endlibrary
