/* 奖励 */

globals
    hAward award = 0
    real hAwardRange = 500.00
endglobals

struct hAward

    /**
     * 设置共享范围
     */
    public method setRange takes real range returns nothing
        set hAwardRange = range
    endmethod

    /**
     * 奖励单位（经验黄金木头）
     */
    public method forUnit takes unit whichUnit,integer exp,integer gold,integer lumber returns nothing
        local string floatStr = ""
        local integer realExp = exp
        local integer realGold = gold
        local integer realLumber = lumber
        local integer charges = 0
        local integer index = 0

        if( whichUnit == null ) then
            return
        endif
        set index = GetConvertedPlayerId(GetOwningPlayer( whichUnit ))

        //TODO 增益
        set realGold 	= realGold + R2I( I2R(gold) * attrExt.getGoldRatio(whichUnit) / 100.00 )
        set realLumber	= realLumber + R2I( I2R(lumber) * attrExt.getLumberRatio(whichUnit) / 100.00 )
        set realExp		= realExp + R2I( I2R(exp) * attrExt.getExpRatio(whichUnit) / 100.00 )

        if(exp > 0 and is.hero(whichUnit)) then
            call AddHeroXPSwapped( realExp , whichUnit , true )
            call hmsg.style(hmsg.ttg2Unit(whichUnit,I2S(realExp)+"Exp",12.00,"c4c4ff",0,2.00,50.00),"toggle",0,20)
        endif
        if(gold > 0) then
            call hplayer.addGold( GetOwningPlayer( whichUnit ) , realGold )
            call hmsg.style(hmsg.ttg2Unit(whichUnit,I2S(realGold)+"G",12.00,"ffcc00",0,2.00,50.00),"toggle",0,20)
        endif
        if(lumber > 0) then
            call hplayer.addLumber( GetOwningPlayer( whichUnit ) , realLumber )
            call hmsg.style(hmsg.ttg2Unit(whichUnit,I2S(realLumber)+"L",12.00,"80ff80",0,2.00,50.00),"toggle",0,20)
        endif
    endmethod

    /**
     * 平分奖励单位组（经验黄金木头）
     */
    public method forGroup takes unit whichUnit,integer exp,integer gold,integer lumber returns nothing
        local unit u = null
        local group g = null
        local integer gCount = 0
        local integer cutExp = 0
        local integer cutGold = 0
        local integer cutLumber = 0
        local hFilter filter = 0
        set filter = hFilter.create()
        call filter.isHero(true)
        call filter.isAlly(true)
        call filter.isAlive(true)
        call filter.isBuilding(false)
        set g = hgroup.createByUnit(whichUnit,hAwardRange,function hFilter.get)
        call filter.destroy()
        set gCount = CountUnitsInGroup( g )
        if( gCount <=0 ) then
            return
        endif
        set cutExp = R2I(I2R(exp) / I2R(gCount))
        set cutGold = R2I(I2R(gold) / I2R(gCount))
        set cutLumber = R2I(I2R(lumber) / I2R(gCount))
        loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                //must do
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                //
                call forUnit(u,cutExp,cutGold,cutLumber)
        endloop
        call GroupClear(g)
        call DestroyGroup(g)
        set g = null
    endmethod

endstruct
