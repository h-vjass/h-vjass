
library share requires items

    /**
     * 奖励单位（经验黄金木头）
     */
    public function awardUnit takes integer exp,integer gold,integer lumber,unit whichUnit returns nothing
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
        //set realGold 	= realGold + R2I( I2R(gold) * Attr_GoldRatio[index] / 100.00 )
        //set realLumber	= realLumber + R2I( I2R(lumber) * Attr_LumberRatio[index] / 100.00 )
        //set realExp		= realExp + R2I( I2R(exp) * Attr_ExpRatio[index] / 100.00 )

        if(exp > 0) then
            call AddHeroXPSwapped( realExp , whichUnit , true )
            set floatStr = floatStr + "|cffc4c4ff+" + I2S(realExp) + "Exp|r "
        endif
        if(gold > 0) then
            call funcs_addGold( GetOwningPlayer( whichUnit ) , realGold )
            set floatStr = floatStr + "|cffffcc00+" + I2S(realGold) + "G|r "
        endif
        if(lumber > 0) then
            call funcs_addLumber( GetOwningPlayer( whichUnit ) , realLumber )
            set floatStr = floatStr + "|cff80ff80+" + I2S(realLumber) + "L|r "
        endif
        call funcs_floatMsg( floatStr , whichUnit)

    endfunction

    /**
     * 平分奖励单位组（经验黄金木头）
     */
    public function awardGroup takes integer exp,integer gold,integer lumber,group whichGroup returns nothing
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
                call awardUnit(cutExp,cutGold,cutLumber,u)
        endloop
    endfunction

endlibrary
