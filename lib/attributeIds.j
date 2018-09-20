/** 
 * 属性系统默认的技能及物品ID
 */
globals

	integer ATTR_MAX_LIFE = 999999999
    integer ATTR_MAX_MANA = 999999999
    integer ATTR_MIN_LIFE = 1
    integer ATTR_MIN_MANA = 1
    integer ATTR_MAX_DEFEND = 999999
    integer ATTR_MAX_ATTACK_PHYSICAL = 999999999
    integer ATTR_MAX_ATTACK_MAGIC = 999999999
    integer ATTR_MAX_ATTACK_SPEED = 9999
    integer ATTR_MIN_ATTACK_SPEED = -80
    integer ATTR_MAX_STR_GREEN = 99999999
    integer ATTR_MAX_AGI_GREEN = 99999999
    integer ATTR_MAX_INT_GREEN = 99999999
    integer ATTR_MAX_SIGHT = 2050
	
	//护甲 1
	integer Attr_Ability_defend_1 = 'A01J'
	//护甲 10
	integer Attr_Ability_defend_10 = 'A07I'
	//护甲 100
	integer Attr_Ability_defend_100 = 'A07M'
	//护甲 1000
	integer Attr_Ability_defend_1000 = 'A0FC'
	//护甲 10000
	integer Attr_Ability_defend_10000 = 'A019'
	//护甲 100000
	integer Attr_Ability_defend_100000 = 'A01E'
	//护甲 1000000
	integer Attr_Ability_defend_1000000 = 'A036'
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
	//物理攻击力 100000
	integer Attr_Ability_attack_physical_100000 =  'A01H'
	//物理攻击力 1000000
	integer Attr_Ability_attack_physical_1000000 =  'A01N'
	//物理攻击力 10000000
	integer Attr_Ability_attack_physical_10000000 =  'A01X'
	//物理攻击力 100000000
	integer Attr_Ability_attack_physical_100000000 =  'A01Y'
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
	//物理攻击力书 100000
	integer Attr_Ability_attack_physical_item_100000 =  'I004'
	//物理攻击力书 1000000
	integer Attr_Ability_attack_physical_item_1000000 =  'I003'
	//物理攻击力书 10000000
	integer Attr_Ability_attack_physical_item_10000000 =  'I005'
	//物理攻击力书 100000000
	integer Attr_Ability_attack_physical_item_100000000 =  'I006'
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
	//魔法攻击力 100000
	integer Attr_Ability_attack_magic_100000 =  'A02G'
	//魔法攻击力 1000000
	integer Attr_Ability_attack_magic_1000000 =  'A02L'
	//魔法攻击力 10000000
	integer Attr_Ability_attack_magic_10000000 =  'A02M'
	//魔法攻击力 100000000
	integer Attr_Ability_attack_magic_100000000 =  'A02N'
	//攻击速度% 1
	integer Attr_Ability_attackSpeed_1 = 'A01M'
	//攻击速度% 10
	integer Attr_Ability_attackSpeed_10 = 'A01P'
	//攻击速度% 100
	integer Attr_Ability_attackSpeed_100 = 'A01Q'
	//攻击速度% 1000
	integer Attr_Ability_attackSpeed_1000 = 'A02S'
	//力量 1
	integer Attr_Ability_str_1 = 'A015'
	//力量 10
	integer Attr_Ability_str_10 =  'A018'
	//力量 100
	integer Attr_Ability_str_100 =  'A00P'
	//力量 1000
	integer Attr_Ability_str_1000 = 'A00Q'
	//力量 10000
	integer Attr_Ability_str_10000 = 'A000'
	//力量 100000
	integer Attr_Ability_str_100000 = 'A00F'
	//力量 1000000
	integer Attr_Ability_str_1000000 = 'A00G'
	//力量 10000000
	integer Attr_Ability_str_10000000 = 'A00H'
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
	//敏捷 100000
	integer Attr_Ability_agi_100000 = 'A00I'
	//敏捷 1000000
	integer Attr_Ability_agi_1000000 = 'A00J'
	//敏捷 10000000
	integer Attr_Ability_agi_10000000 = 'A00K'
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
	//智力 100000
	integer Attr_Ability_int_100000 = 'A00L'
	//智力 1000000
	integer Attr_Ability_int_1000000 = 'A00M'
	//智力 10000000
	integer Attr_Ability_int_10000000 = 'A00N'
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
	//生命 1000000
	integer Attr_Ability_life_1000000 = 'A02U'
	//生命 10000000
	integer Attr_Ability_life_10000000 = 'A02V'
	//生命 100000000
	integer Attr_Ability_life_100000000 = 'A02W'
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
	//魔法 1000000
	integer Attr_Ability_mana_1000000 = 'A02F'
	//魔法 10000000
	integer Attr_Ability_mana_10000000 = 'A02X'
	//魔法 100000000
	integer Attr_Ability_mana_100000000 = 'A02Z'
	//视野 50
	integer Attr_Ability_sight_50 = 'A03S'
	//视野 100
	integer Attr_Ability_sight_100 = 'A03C'
	//视野 200
	integer Attr_Ability_sight_200 = 'A03F'
	//视野 300
	integer Attr_Ability_sight_300 = 'A03G'
	//视野 400
	integer Attr_Ability_sight_400 = 'A03J'
	//视野 1000
	integer Attr_Ability_sight_1000 = 'A03R'
	//******************正负分割线******************//
	//-护甲 1
	integer Attr_Ability_defend_FU_1 = 'A01B'
	//-护甲 10
	integer Attr_Ability_defend_FU_10 = 'A01C'
	//-护甲 100
	integer Attr_Ability_defend_FU_100 = 'A01D'
	//-护甲 1000
	integer Attr_Ability_defend_FU_1000 = 'A0FD'
	//-护甲 10000
	integer Attr_Ability_defend_FU_10000 = 'A01A'
	//-护甲 100000
	integer Attr_Ability_defend_FU_100000 = 'A01F'
	//-护甲 1000000
	integer Attr_Ability_defend_FU_1000000 = 'A037'
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
	//物理攻击力 100000
	integer Attr_Ability_attack_physical_FU_100000 =  'A01Z'
	//物理攻击力 1000000
	integer Attr_Ability_attack_physical_FU_1000000 =  'A026'
	//物理攻击力 10000000
	integer Attr_Ability_attack_physical_FU_10000000 =  'A027'
	//物理攻击力 100000000
	integer Attr_Ability_attack_physical_FU_100000000 =  'A028'
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
	//物理攻击力书 100000
	integer Attr_Ability_attack_physical_FU_item_100000 =  'I007'
	//物理攻击力书 1000000
	integer Attr_Ability_attack_physical_FU_item_1000000 =  'I008'
	//物理攻击力书 10000000
	integer Attr_Ability_attack_physical_FU_item_10000000 =  'I009'
	//物理攻击力书 100000000
	integer Attr_Ability_attack_physical_FU_item_100000000 =  'I00A'
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
	//-魔法攻击力 100000
	integer Attr_Ability_attack_magic_FU_100000 =  'A02O'
	//-魔法攻击力 1000000
	integer Attr_Ability_attack_magic_FU_1000000 =  'A02P'
	//-魔法攻击力 10000000
	integer Attr_Ability_attack_magic_FU_10000000 =  'A02Q'
	//-魔法攻击力 100000000
	integer Attr_Ability_attack_magic_FU_100000000 =  'A02R'
	//-攻击速度% 1
	integer Attr_Ability_attackSpeed_FU_1 = 'A01W'
	//-攻击速度% 10
	integer Attr_Ability_attackSpeed_FU_10 = 'A021'
	//-攻击速度% 100
	integer Attr_Ability_attackSpeed_FU_100 = 'A020'
	//-攻击速度% 1000
	integer Attr_Ability_attackSpeed_FU_1000 = 'A02T'
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
	//-力量 100000
	integer Attr_Ability_str_FU_100000 = 'A00O'
	//-力量 1000000
	integer Attr_Ability_str_FU_1000000 = 'A00R'
	//-力量 10000000
	integer Attr_Ability_str_FU_10000000 = 'A00S'
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
	//-敏捷 100000
	integer Attr_Ability_agi_FU_100000 = 'A00T'
	//-敏捷 1000000
	integer Attr_Ability_agi_FU_1000000 = 'A00W'
	//-敏捷 10000000
	integer Attr_Ability_agi_FU_10000000 = 'A013'
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
	//-智力 100000
	integer Attr_Ability_int_FU_100000 = 'A013'
	//-智力 1000000
	integer Attr_Ability_int_FU_1000000 = 'A016'
	//-智力 10000000
	integer Attr_Ability_int_FU_10000000 = 'A017'
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
	//-生命 1000000
	integer Attr_Ability_life_FU_1000000 = 'A030'
	//-生命 10000000
	integer Attr_Ability_life_FU_10000000 = 'A031'
	//-生命 100000000
	integer Attr_Ability_life_FU_100000000 = 'A032'
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
	//-魔法 1000000
	integer Attr_Ability_mana_FU_1000000 = 'A033'
	//-魔法 10000000
	integer Attr_Ability_mana_FU_10000000 = 'A034'
	//-魔法 100000000
	integer Attr_Ability_mana_FU_100000000 = 'A035'
	//-视野 50
	integer Attr_Ability_sight_FU_50 = 'A03I'
	//-视野 100
	integer Attr_Ability_sight_FU_100 = 'A03H'
	//-视野 200
	integer Attr_Ability_sight_FU_200 = 'A03K'
	//-视野 300
	integer Attr_Ability_sight_FU_300 = 'A03L'
	//-视野 400
	integer Attr_Ability_sight_FU_400 = 'A03M'
	//-视野 1000
	integer Attr_Ability_sight_FU_1000 = 'A03N'
endglobals