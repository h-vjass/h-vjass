/* 奖励 */
library hAward requires hAttrUnit

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

        if(exp > 0 and hIs_hero(whichUnit)) then
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
    public function forGroup takes group whichGroup,integer exp,integer gold,integer lumber returns nothing
        local unit u = null
        local integer groupCount = CountUnitsInGroup( whichGroup )
        local integer cutExp = R2I(I2R(exp) / I2R(groupCount))
        local integer cutGold = R2I(I2R(gold) / I2R(groupCount))
        local integer cutLumber = R2I(I2R(lumber) / I2R(groupCount))
        if( groupCount <=0 ) then
            return
        endif
        loop
            exitwhen(IsUnitGroupEmptyBJ(whichGroup) == true)
                //must do
                set u = FirstOfGroup(whichGroup)
                call GroupRemoveUnit( whichGroup , u )
                //
                call forUnit(u,cutExp,cutGold,cutLumber)
        endloop
    endfunction

endlibrary
