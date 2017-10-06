

library hMultiboard requires funcs

    globals

        /* 多面板 */
        //多面板检查，用来检查此用户是否已经显示在上面
        //用来跳过那些非玩家 无玩家的玩家列
        //这样3个玩家就只会显示3个，而不需要多余的列来显示null
        private boolean array MultiboardCheck

    endglobals

	/**
     * 创建信息多面板
     */
    public function create takes nothing returns nothing
        local integer i
        local integer j
        local multiboard mb = GetLastCreatedMultiboard()
        local string array nameStr
        local string array apmStr //APM字符
        set i = 1
        loop
            exitwhen i > Max_Player_num
                set MultiboardCheck[i] = false
                //计算APM
                if (System_time_count > 60) then
                    set apmStr[i] = "|cffffff00"+I2S(R2I( I2R(Apm[i])  / ( I2R(System_time_count) / 60.00 ))) + "|r"
                else
                    set apmStr[i] = "|cffffff00"+I2S(Apm[i]) +"|r"
                endif
              	//目标
				if( Player_status[i] != "谋掠中" )then
					set nameStr[i] = "退场"
				else
					set nameStr[i] = Player_names[Player_Target[i]]
				endif
            set i = i + 1
        endloop

        //如果有旧的多面板则删除
        if(mb != null) then
            call DestroyMultiboard( GetLastCreatedMultiboard() )
        endif

        //建一个当前（玩家数+1）的多面板
        call CreateMultiboardBJ( 10, ( Start_Player_num + 1 ), "战况 - "+CurrentGameTitle )
        call MultiboardSetItemWidthBJ( GetLastCreatedMultiboard(), 0, 0, 3.20 )
        call MultiboardSetItemStyleBJ( GetLastCreatedMultiboard(), 0, 0, true, false )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 1, 1, "玩家名称" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 2, 1, "英雄等级" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 3, 1, "部队容纳" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 4, 1, "部队数目" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 5, 1, "堡垒被攻击次数" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 6, 1, "当前目标" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 7, 1, "状态" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 8, 1, "APM" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 9, 1, "金币" )
        call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 10, 1, "战略点" )
        set i = 1
        set j = 1
        loop
            exitwhen j > Max_Player_num
            //if ( (GetPlayerController(Players[j]) == MAP_CONTROL_USER) and Player_names[j] != "没有玩家" ) then
                set i = i + 1
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 1, i, Player_names[j] )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 2, i, I2S(GetUnitLevel(Player_heros[j])) )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 3, i, I2S(LoadInteger( HASH_Player , j , 3413 )) )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 4, i, I2S(LoadInteger( HASH_Player , j , 3414 )) )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 5, i, I2S(Player_city_beHunt[j]))
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 6, i, nameStr[j] )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 7, i, Player_status[j])
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 8, i, apmStr[j] )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 9, i, I2S(funcs_getGold(Players[j])) )
                call MultiboardSetItemValueBJ( GetLastCreatedMultiboard(), 10, i, I2S(funcs_getLumber(Players[j])) )
            //endif
            set j = j + 1
        endloop
        call MultiboardSetItemWidthBJ( GetLastCreatedMultiboard(), 1, 0, 6.00 )
        call MultiboardSetItemWidthBJ( GetLastCreatedMultiboard(), 5, 0, 6.00 )
        call MultiboardDisplayBJ( true, GetLastCreatedMultiboard() )
    endfunction

endlibrary
