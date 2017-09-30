//失败类
globals
    string SuccessTips = "击破！敌人首领被击杀！森林神木守护成功！赶快告诉其他人这个喜讯吧！~"
    string SuccessTitle = "Great！Boss击倒！！"
endglobals

library success requires funcs

    public function setSuccessTitle takes string title returns nothing
        set SuccessTitle = title
    endfunction

    private function getSuccessTitle takes nothing returns string
        return SuccessTitle
    endfunction

    public function setSuccessTips takes string tips returns nothing
        set SuccessTips = tips
    endfunction

    private function getSuccessTips takes nothing returns string
        return SuccessTips
    endfunction

    private function doAll takes nothing returns nothing
        local integer i = 0
        set i = 1
        loop
            exitwhen i > Max_Player_num
            call CustomVictoryBJ( Players[i], true, true )
            set i = i + 1
        endloop
    endfunction

    public function actionAll takes nothing returns nothing
        call CinematicModeBJ( true,  GetPlayersAll() )
        call ForceCinematicSubtitles( true )
        call TransmissionFromUnitWithNameBJ(  GetPlayersAll() , null, getSuccessTitle() , null, getSuccessTips() , bj_TIMETYPE_SET, 5.00, false )
        call funcs_setTimeout(3.00,function doAll)
    endfunction

endlibrary
