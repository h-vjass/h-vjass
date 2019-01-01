//消息
globals
    hMark hmark
    hashtable hash_hmark = null
endglobals
struct hMark

    static method create takes nothing returns hMark
        local hMark x = 0
        set x = hMark.allocate()
        return x
    endmethod

    // 显示
    public static method show takes player whichPlayer returns nothing
        if(whichPlayer == null)then
            call DisplayCineFilter(true)
        elseif(whichPlayer == GetLocalPlayer())then
            call DisplayCineFilter(true)
        endif
    endmethod

    // 隐藏
    public static method hide takes player whichPlayer returns nothing
        if(whichPlayer == null)then
            call DisplayCineFilter(false)
        elseif(whichPlayer == GetLocalPlayer())then
            call DisplayCineFilter(false)
        endif
    endmethod

    private static method displayCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call thistype.hide(htime.getPlayer(t,1))
        call htime.delTimer(t)
        set t = null
    endmethod
    // 展示
    public static method display takes player whichPlayer,string path,real through,real during,real startPercent,real endPercent returns nothing
        local timer t = null
        if(whichPlayer == null)then
            call CinematicFilterGenericBJ(through, BLEND_MODE_ADDITIVE,path, startPercent, startPercent, startPercent, 90.00, endPercent, endPercent, endPercent, 0.00 )
        elseif(whichPlayer == GetLocalPlayer())then
            call CinematicFilterGenericBJ(through, BLEND_MODE_ADDITIVE,path, startPercent, startPercent, startPercent, 90.00, endPercent, endPercent, endPercent, 0.00 )
        endif
        if(during < through + 1)then
            set during = through + 1
        endif
        set t = htime.setTimeout(during,function thistype.displayCall)
        call htime.setPlayer(t,1,whichPlayer)
        set t = null
    endmethod

endstruct
