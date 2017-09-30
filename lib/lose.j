//失败类
globals
    string LoseTips = "胜负乃兵家常事，后面你懂的"
    string LoseTitle = "遗憾"
endglobals

library lose requires funcs

    public function setLoseTitle takes string title returns nothing
        set LoseTitle = title
    endfunction

    private function getLoseTitle takes nothing returns string
        return LoseTitle
    endfunction

    public function setLoseTips takes string tips returns nothing
        set LoseTips = tips
    endfunction

    private function getLoseTips takes nothing returns string
        return LoseTips
    endfunction

    private function doAll takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > Max_Player_num
            call CustomDefeatBJ( Players[i], "失败" )
            set i = i + 1
        endloop
    endfunction

    private function do1 takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > 3
            call CustomDefeatBJ( Players[i], "失败" )
            set i = i + 1
        endloop
    endfunction

    private function do2 takes nothing returns nothing
        local integer i = 0
        set i = 4
        loop
            exitwhen i > Max_Player_num
            call CustomDefeatBJ( Players[i], "失败" )
            set i = i + 1
        endloop
    endfunction

    public function action takes force f returns nothing
        local integer i = 0
        call CinematicModeBJ( true,  f )
        call ForceCinematicSubtitles( true )
        call TransmissionFromUnitWithNameBJ(  f , null, getLoseTitle() , null, getLoseTips() , bj_TIMETYPE_SET, 5.00, false )
        set i = 1
        loop
            exitwhen i > Player_team_num
            if(f == Player_team[i]) then
                if(i == 1) then
                    call funcs_setTimeout(3.00,function do1)
                elseif(i == 2) then
                    call funcs_setTimeout(3.00,function do2)
                endif
                call DoNothing() YDNL exitwhen true//(  )
            endif
            set i = i + 1
        endloop
    endfunction

    public function actionAll takes nothing returns nothing
        call CinematicModeBJ( true,  GetPlayersAll() )
        call ForceCinematicSubtitles( true )
        call TransmissionFromUnitWithNameBJ(  GetPlayersAll() , null, getLoseTitle() , null, getLoseTips() , bj_TIMETYPE_SET, 5.00, false )
        call funcs_setTimeout(3.00,function doAll)
    endfunction

endlibrary
