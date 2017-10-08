/* 奖励 */
library hAward requires hAttrUnit

    globals
        private real awardRange = 500.00
    endglobals

    /**
     * 设置共享范围
     */
    public function setRange takes real range returns nothing
        set awardRange = range
    endfunction

    /**
     * 奖励单位（经验黄金木头）
     */
    public function forUnit takes unit whichUnit,integer exp,integer gold,integer lumber returns nothing
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
        set realGold 	= realGold + R2I( I2R(gold) * hAttr_getGoldRatio(whichUnit) / 100.00 )
        set realLumber	= realLumber + R2I( I2R(lumber) * hAttr_getLumberRatio(whichUnit) / 100.00 )
        set realExp		= realExp + R2I( I2R(exp) * hAttr_getExpRatio(whichUnit) / 100.00 )

        if(exp > 0 and is.hero(whichUnit)) then
            call AddHeroXPSwapped( realExp , whichUnit , true )
            call hMsg_style(hMsg_ttg2Unit(whichUnit,I2S(realExp)+"Exp",12.00,"c4c4ff",0,2.00,50.00),"toggle",0,20)
        endif
        if(gold > 0) then
            call hPlayer_addGold( GetOwningPlayer( whichUnit ) , realGold )
            call hMsg_style(hMsg_ttg2Unit(whichUnit,I2S(realGold)+"G",12.00,"ffcc00",0,2.00,50.00),"toggle",0,20)
        endif
        if(lumber > 0) then
            call hPlayer_addLumber( GetOwningPlayer( whichUnit ) , realLumber )
            call hMsg_style(hMsg_ttg2Unit(whichUnit,I2S(realLumber)+"L",12.00,"80ff80",0,2.00,50.00),"toggle",0,20)
        endif
    endfunction

    /**
     * 平分奖励单位组（经验黄金木头）
     */
    public function forGroup takes unit whichUnit,integer exp,integer gold,integer lumber returns nothing
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
        set g = hGroup_createByUnit(whichUnit,awardRange,function hFilter.get)
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
    endfunction

endlibrary
