/* 奖励 */

globals
    hAward haward = 0
    real hAwardRange = 2000.00
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
        local integer index = 0
        local integer ttgColorLen = 0
        local texttag ttg = null

        if( whichUnit == null ) then
            return
        endif
        set index = GetConvertedPlayerId(GetOwningPlayer( whichUnit ))

        //TODO 增益
        set realGold 	= realGold + R2I( I2R(gold) * hattrExt.getGoldRatio(whichUnit) / 100.00 )
        set realLumber	= realLumber + R2I( I2R(lumber) * hattrExt.getLumberRatio(whichUnit) / 100.00 )
        set realExp		= realExp + R2I( I2R(exp) * hattrExt.getExpRatio(whichUnit) / 100.00 )

        if(exp > 0 and his.hero(whichUnit)) then
            call AddHeroXPSwapped( realExp , whichUnit , true )
            set floatStr = floatStr + "|cffc4c4ff" + I2S(realExp)+"Exp" + "|r"
            set ttgColorLen = ttgColorLen + 12
        endif
        if(gold > 0) then
            call hplayer.addGold( GetOwningPlayer( whichUnit ) , realGold )
            set floatStr = floatStr + " |cffffcc00" + I2S(realGold)+"G" + "|r"
            set ttgColorLen = ttgColorLen + 13
        endif
        if(lumber > 0) then
            call hplayer.addLumber( GetOwningPlayer( whichUnit ) , realLumber )
            set floatStr = floatStr + " |cff80ff80" + I2S(realLumber)+"L" + "|r"
            set ttgColorLen = ttgColorLen + 13
        endif
        set ttg = hmsg.ttg2Unit(whichUnit,floatStr,11,"",0,2.00,50.00)
        call SetTextTagPos( ttg , GetUnitX(whichUnit)-I2R(StringLength(floatStr)-ttgColorLen)*11*0.5 , GetUnitY(whichUnit) , 50 )
        call hmsg.style(ttg,"shrink",0,0.15)
    endmethod

    /**
     * 平分奖励英雄组（经验黄金木头）
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
        call filter.setUnit(whichUnit)
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
