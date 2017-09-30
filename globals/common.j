/* 定义YDWE 需要用到的全局变量 */
globals

	/* 全局系统 */
	//DEBUG
	boolean isDebug = false
	//系统时间
	integer System_time = 0
	integer System_sec = 0
	integer System_min = 0
	integer System_hour = 0
	integer System_time_count = 0
	real Share_Range = 1000
	//call DoNothing() YDNL exitwhen true 退出循环为什么不是break，什么傻逼语法

	/* Apm */
    integer array Apm



	/* 电影 */
	integer Moive_Msg_Length
	string array Moive_Msg

	/* 天气 */
	integer WeatherEffect_Sun 			= 'LRaa'	//日光
    integer WeatherEffect_Moon			= 'LRma'	//月光
    integer WeatherEffect_Shield 		= 'MEds'	//紫光盾
    integer WeatherEffect_Rain			= 'RAlr'	//雨
    integer WeatherEffect_RainStorm 	= 'RAhr'	//大雨
    integer WeatherEffect_Snow 			= 'SNls'	//雪
    integer WeatherEffect_SnowStorm 	= 'SNhs'	//大雪
    integer WeatherEffect_Wind 			= 'WOlw'	//风
    integer WeatherEffect_WindStorm 	= 'WNcw'	//大风
    integer WeatherEffect_MistWhite 	= 'FDwh'	//白雾
    integer WeatherEffect_MistGreen 	= 'FDgh'	//绿雾
    integer WeatherEffect_MistBlue 		= 'FDbh'	//蓝雾
    integer WeatherEffect_MistRed 		= 'FDrh'	//红雾


	/* 玩家 */
	player array Players
	//最大玩家数
	integer Max_Player_num  = 4
	//当前玩家数
	integer Current_Player_num = 0
	//初始玩家数
	integer Start_Player_num = 0
	//最后一点技能点的英雄等级
	integer Last_skillPointsLv = 500
	//玩家势力队伍
	integer Player_team_num = 4
	force array Player_team
	//
	string array Player_names
	boolean array Player_isComputer
	integer array Player_isSelected
	integer array Player_city_beHunt
	integer array Player_tower_Qty
	unit array Player_heros
	unit array Player_city
	unit array Player_soldiers
	unit array Player_arrow
	unit array Player_casern
	unit array Player_lab
	string array Player_status
	location array Player_City_Loc
	location array Player_Arrow_Loc
	location array Player_Target_Loc
	location array Player_Soldier_Loc
	location array Player_Casern_Loc
	location array Player_Lab_Loc
	integer array Player_Target
	texttag array Player_Target_ttg
	texttag array Player_Gold_ttg

	//伤害目标筛选
	string FILTER_ALL = "FILTER_ALL"        	//全部
	string FILTER_ALLY = "FILTER_ALLY"      	//友军
	string FILTER_ENEMY = "FILTER_ENEMY"	//敌军

	//马甲们
	//超级马甲
	integer Unit_Token = 'h00J'
	//马甲技能
	integer Unit_TokenSkill_Break 	= 'A09R'
	integer Unit_TokenSkill_Swim_05 = 'A09Q'

endglobals
