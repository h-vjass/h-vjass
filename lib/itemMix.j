globals
    hItemMix hitemMix
    hashtable hash_item_mix = null
endglobals

struct hItemMix


    private static integer MIX_MAX_FORMULA_QTY = 100 //每个 目标物品 最大支持的公式数量
    private static integer MIX_MAX_FLAG_QTY = 100 //每条 公式 最大支持的零件种类数量
    private static integer hk_mix_flag_qty = MIX_MAX_FORMULA_QTY-1

    //获取注册的合成物数量
    public static method getTotalQty takes nothing returns integer
        local integer qty = LoadInteger(hash_item_mix,0,StringHash("_TOTAL_QTY_"))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定注册的合成物数量
    public static method setTotalQty takes integer qty returns nothing
        call SaveInteger(hash_item_mix,0,StringHash("_TOTAL_QTY_"), qty)
    endmethod




    //获取某种物品的合成公式数量（一个物品有几种合成路线）
    public static method getFormulaQty takes integer itemId returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FORMULA_QTY_"))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定某种物品的合成公式数量
    public static method setFormulaQty takes integer itemId,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FORMULA_QTY_"), qty)
    endmethod


    //获取某种物品的第 x 条公式合成的最终成品物品的使用次数
    public static method getFormulaResultQty takes integer itemId,integer x returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FORMULA_RESULT_QTY_"+I2S(x)))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定某种物品的第 x 条公式合成的最终成品物品的使用次数
    public static method setFormulaResultQty takes integer itemId,integer x,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FORMULA_RESULT_QTY_"+I2S(x)), qty)
    endmethod


    //获取某种物品的第 x 条公式里面的零件种类数
    public static method getFormulaFlagmentQty takes integer itemId,integer x returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_QTY_"+I2S(x)))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定某种物品的第 x 条公式里面的零件种类数
    public static method setFormulaFlagmentQty takes integer itemId,integer x,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_QTY_"+I2S(x)), qty)
    endmethod


    //获取某种物品的第 x 条公式里面的第 y 件零件的物品类型
    public static method getFormulaFlagmentNeedType takes integer itemId,integer x,integer y returns integer
        return LoadInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_NEED_TYPE_"+I2S(x)+"_"+I2S(y)))
    endmethod
    //设定某种物品的第 x 条公式里面的第 y 件零件的物品类型
    public static method setFormulaFlagmentNeedType takes integer itemId,integer x,integer y,integer flagmentType returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_NEED_TYPE_"+I2S(x)+"_"+I2S(y)), flagmentType)
    endmethod


    //获取某种物品的第 x 条公式里面第 y 件零件的物品类型
    public static method getFormulaFlagmentNeedQty takes integer itemId,integer x,integer y returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_NEED_QTY_"+I2S(x)+"_"+I2S(y)))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定某种物品的第 x 条公式里面第 y 件零件需要的数量
    public static method setFormulaFlagmentNeedQty takes integer itemId,integer x,integer y,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FORMULA_FLAGMENT_NEED_QTY_"+I2S(x)+"_"+I2S(y)), qty)
    endmethod




    //获取某种物品作为零件的合成公式数量（一个物品可以合成几种目标物品）
    public static method getFlagmentQty takes integer itemId returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_QTY_"))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定某种物品作为零件的合成公式数量
    public static method setFlagmentQty takes integer itemId,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_QTY_"), qty)
    endmethod

    //获取零件是否存在于当前最新公式
    public static method getFlagmentIsset takes integer itemId returns boolean
        return LoadBoolean(hash_item_mix, itemId, StringHash("_FLAGMENT_ISSET_"+I2S(thistype.getTotalQty())))
    endmethod
    //设定零件已经存在于当前最新公式（默认false）
    public static method setFlagmentIsset takes integer itemId returns nothing
        call SaveBoolean(hash_item_mix, itemId, StringHash("_FLAGMENT_ISSET_"+I2S(thistype.getTotalQty())), true)
    endmethod

    //获取零件服务的第 x 索引的结果物品id
    public static method getFlagmentResult takes integer itemId,integer x returns integer
        return LoadInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_RESULT_"+I2S(x)))
    endmethod
    //设定零件服务的第 x 索引的结果物品id
    public static method setFlagmentResult takes integer itemId,integer x,integer result returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_RESULT_"+I2S(x)), result)
    endmethod

    //获取零件服务的对应目标物品的公式索引
    public static method getFlagmentFormulaIndex takes integer flagmentId,integer x returns integer
        return LoadInteger(hash_item_mix, flagmentId, StringHash("_FLAGMENT_FORMULA_INDEX_"+I2S(x)))
    endmethod
    //设定零件服务的对应目标物品的公式索引
    public static method setFlagmentFormulaIndex takes integer flagmentId,integer x,integer index returns nothing
        call SaveInteger(hash_item_mix, flagmentId, StringHash("_FLAGMENT_FORMULA_INDEX_"+I2S(x)), index)
    endmethod

    //获取零件服务的第 x 索引的需求数量
    public static method getFlagmentNeedQty takes integer itemId,integer x returns integer
        local integer qty = LoadInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_NEED_QTY_"+I2S(x)))
        if(qty<=0)then
            set qty = 0
        endif
        return qty
    endmethod
    //设定零件服务的第 x 索引的需求数量
    public static method setFlagmentNeedQty takes integer itemId,integer x,integer qty returns nothing
        call SaveInteger(hash_item_mix, itemId, StringHash("_FLAGMENT_NEED_QTY_"+I2S(x)), qty)
    endmethod









    /**
     * 设定新的合成公式,每一次newFormula代表一个新的公式
     * 后面继续调用 addFlag 设定的那条公式内的零件
     */
    public static method newFormula takes integer targetItemId,integer targetQty returns nothing
        local integer formulaIndex = 0
        if(targetQty<=0)then
            call hconsole.error("目标合成数量错误")
            return
        endif
        set formulaIndex = getFormulaQty(targetItemId) //公式数，一个物品可能有多种合成方法
        set formulaIndex = formulaIndex+1
        if( formulaIndex > MIX_MAX_FORMULA_QTY)then
            call hconsole.error("该物品已超出最大公式数")
            return
        endif
        call setTotalQty(1+getTotalQty())
        call setFormulaQty(targetItemId,formulaIndex)
        call setFormulaResultQty(targetItemId,formulaIndex,targetQty)
    endmethod

    /**
     * 为合成公式添加零件,需要紧跟startFormula使用或作为多条addFlag（多零件）使用
     */
    public static method addFlag takes integer targetItemId,integer flagmentItemId,integer flagmentItemQty returns nothing
        local integer formulaIndex = getFormulaQty(targetItemId) //公式数，一个物品可能有多种合成方法
        local integer formulaFlagmentQty = 0 //此条公式的零件种类总数，一公式可能有多种零件
        local integer i = 0
        local integer flagmentNeedQty = 0
        local integer flagmentQty = 0
        local integer flagmentIndex = 0
        if(formulaIndex<0)then
            call hconsole.error("请先new一个Formula（newFormula）")
            return
        endif
        set formulaFlagmentQty = getFormulaFlagmentQty(targetItemId,formulaIndex)
        if(formulaFlagmentQty<0)then
            set formulaFlagmentQty = 0
        endif
        set flagmentQty = getFlagmentQty(flagmentItemId)
        if(flagmentQty<0)then
            set flagmentQty = 0
        endif
        //寻找过去是否已经设定过这个零件，有就增加需求数量，没有就建立新数据
        if(getFlagmentIsset(flagmentItemId) != true)then // 判断是否新公式
            //新零件,零件服务公式数量+1
            set flagmentQty = flagmentQty+1
            call setFlagmentQty(flagmentItemId,flagmentQty) //刷新零件服务公式数
            call setFlagmentIsset(flagmentItemId)
            //新零件,公式零件数量+1
            set formulaFlagmentQty = formulaFlagmentQty+1
            if( formulaFlagmentQty > MIX_MAX_FLAG_QTY)then
                call hconsole.error("该公式已超出最大零件种类数")
                return
            endif
            call setFormulaFlagmentQty(targetItemId,formulaIndex,formulaFlagmentQty) //刷新零件种类数
            call setFormulaFlagmentNeedType(targetItemId,formulaIndex,formulaFlagmentQty,flagmentItemId) //记录公式第 formulaIndex 条的第 formulaFlagmentQty个零件的种类
            call setFormulaFlagmentNeedQty(targetItemId,formulaIndex,formulaFlagmentQty,flagmentItemQty) //记录公式第 formulaIndex 条的flagmentItemId零件的数量
            call setFlagmentResult(flagmentItemId,flagmentQty,targetItemId) //刷新零件服务公式数
            call setFlagmentNeedQty(flagmentItemId,flagmentQty,flagmentItemQty)
            call setFlagmentFormulaIndex(flagmentItemId,flagmentQty,formulaIndex)
        else
            //已存在
            set flagmentNeedQty = getFormulaFlagmentNeedQty(targetItemId,formulaIndex,formulaFlagmentQty)
            call setFormulaFlagmentNeedQty(targetItemId,formulaIndex,formulaFlagmentQty,flagmentNeedQty+flagmentItemQty)
            call setFlagmentNeedQty(flagmentItemId,flagmentQty,flagmentNeedQty+flagmentItemQty)
        endif
    endmethod

    /**
     * 执行合成 by 物品
     */
    public static method execByItem takes integer itemid,integer charges,unit whichUnit returns integer
        local item it = null
        local integer formulaQty = getFlagmentQty(itemid)
        local integer i = 0
        local integer j = 0
        local integer resultItemId = 0
        local integer resultItemCharges = 0

        local integer flagmentNeedQty = 0

        local integer formulaIndex = 0
        local integer formulaFlagmentQty = 0
        
        local integer flagmentItemId = 0
        local integer flagmentItemNeedQty = 0
        
        local integer tempCharge = 0
        local integer slot_index = 1
        local integer slot_charges = 0
        local real weight = 0
        if(formulaQty>0)then
            set i = formulaQty
            loop
                exitwhen i==0 or resultItemId!=0
                    set resultItemId = getFlagmentResult(itemid,i)
                    set flagmentNeedQty = getFlagmentNeedQty(itemid,i)
                    //判断(身上零件+临时零件数量)是否 足够 第 i 条公式里这个零件的数量
                    if(charges+hitem.getCharges(itemid,whichUnit)<flagmentNeedQty)then
                        set formulaIndex = 0
                        set resultItemId = 0
                    else
                        set formulaIndex = getFlagmentFormulaIndex(itemid,i)
                        set formulaFlagmentQty = getFormulaFlagmentQty(resultItemId,formulaIndex)
                        if(formulaFlagmentQty>0)then
                            //判断是不是所有零件都够
                            set j = formulaFlagmentQty
                            loop
                                exitwhen j==0
                                    set flagmentItemId = getFormulaFlagmentNeedType(resultItemId,formulaIndex,j)
                                    set tempCharge = hitem.getCharges(flagmentItemId,whichUnit)
                                    if(flagmentItemId == itemid and charges>0)then
                                        set tempCharge = tempCharge + charges
                                    endif
                                    //判断 j 这个零件数量够不够,不够就清掉target,并跳出 j 循环
                                    set flagmentItemNeedQty = getFormulaFlagmentNeedQty(resultItemId,formulaIndex,j)
                                    if(flagmentItemNeedQty<=0 or tempCharge<flagmentItemNeedQty)then
                                        set formulaIndex = 0
                                        set resultItemId = 0
                                        call DoNothing() YDNL exitwhen true//( j )
                                    endif
                                set j = j-1
                            endloop
                        endif
                    endif
                set i = i-1
            endloop
            //如果真的要合成了！删掉旧的物品
            if(formulaIndex >0 and resultItemId != 0)then
                set i = formulaFlagmentQty
                loop
                    exitwhen i==0
                        set flagmentItemId = getFormulaFlagmentNeedType(resultItemId,formulaIndex,i)
                        set flagmentItemNeedQty = getFormulaFlagmentNeedQty(resultItemId,formulaIndex,i)
                        //在背包中死循环寻找物品，知道需要的零件数量被完全删除
                        loop
                            exitwhen flagmentItemNeedQty<=0 or slot_index<1
                                set slot_index = GetInventoryIndexOfItemTypeBJ(whichUnit,flagmentItemId)-1
                                set it = UnitItemInSlot(whichUnit, slot_index)
                                set tempCharge = GetItemCharges(it)
                                set slot_charges = tempCharge - flagmentItemNeedQty
                                if(slot_charges > 0) then
                                    call SetItemCharges(it,slot_charges)
                                    set flagmentItemNeedQty = 0
                                    call hitem.addAttr(flagmentItemId,flagmentItemNeedQty,whichUnit,false)
                                    set weight = hattr.getWeightCurrent(whichUnit) - hitem.getWeight(flagmentItemId) * I2R(flagmentItemNeedQty)
			                        call hattr.setWeightCurrent(whichUnit,weight,0)
                                elseif(slot_charges == 0) then
                                    call hitem.del(it,0)
                                    set flagmentItemNeedQty = 0
                                    call hitem.addAttr(flagmentItemId,tempCharge,whichUnit,false)
                                    set weight = hattr.getWeightCurrent(whichUnit) - hitem.getWeight(flagmentItemId) * I2R(tempCharge)
			                        call hattr.setWeightCurrent(whichUnit,weight,0)
                                else
                                    call hitem.del(it,0)
                                    set flagmentItemNeedQty = -slot_charges
                                    call hitem.addAttr(flagmentItemId,tempCharge,whichUnit,false)
                                    set weight = hattr.getWeightCurrent(whichUnit) - hitem.getWeight(flagmentItemId) * I2R(tempCharge)
			                        call hattr.setWeightCurrent(whichUnit,weight,0)
                                endif
                                set it = null
                        endloop
                        if(flagmentItemId == itemid)then
                            if(flagmentItemNeedQty < charges)then
                                set charges = charges - flagmentItemNeedQty
                            else
                                set charges = 0
                            endif
                            set flagmentItemNeedQty = 0
                        endif
                    set i = i-1
                    set slot_index = 1
                endloop
                set resultItemCharges = getFormulaResultQty(resultItemId,formulaIndex)
                if(resultItemCharges>0)then
                    call hitem.toUnitMix(resultItemId,resultItemCharges,whichUnit)
                endif
            endif
        endif
        return charges
    endmethod

endstruct
