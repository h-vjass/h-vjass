
library hItem initializer init requires hAttrItem

    globals
        private hashtable hash = null
        private integer hsah_reelid = 1
        private integer hsah_itemid = 2
        private integer hsah_overlay = 3
        private integer hsah_level = 4
        private integer hsah_gold = 5
        private integer hsah_lumber = 6
        private integer hsah_weight = 7
    endglobals

	/**
     * 删除物品回调
     */
    private function delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local item it = time.getItem( t, 1 )
        call time.delTimer(t)
        if( it != null ) then
	        call RemoveItem( it )
            set it = null
    	endif
    endfunction
	/**
	 * 删除物品，可延时
	 */
	public function delItem takes item it,real during returns nothing
		local timer t = null
        if( during <= 0 ) then
            call RemoveItem( it )
            set it = null
        else
            set t = time.setTimeout( during , function delCall)
            call time.setItem( t, 1 ,it )
        endif
	endfunction

    //绑定物品到系统
    private function bind takes integer itemID,integer reelID,integer overlay,integer level,integer gold,integer lumber,real weight returns nothing
        call SaveInteger(hash, itemID, hsah_reelid, reelID)
        call SaveInteger(hash, itemID, hsah_overlay, overlay)
        call SaveInteger(hash, itemID, hsah_level, level)
        call SaveInteger(hash, itemID, hsah_gold, gold)
        call SaveInteger(hash, itemID, hsah_lumber, lumber)
        call SaveReal(hash, itemID, hsah_weight, weight)
        //--
        call SaveInteger(hash, reelID, hsah_itemid, itemID)
        call SaveInteger(hash, reelID, hsah_overlay, overlay)
        call SaveInteger(hash, reelID, hsah_level, level)
        call SaveInteger(hash, reelID, hsah_gold, gold)
        call SaveInteger(hash, reelID, hsah_lumber, lumber)
        call SaveReal(hash, reelID, hsah_weight, weight)
    endfunction

    //绑定合成到系统
    private function bindMix takes integer mixItemID,integer item1,integer qty1,integer item2,integer qty2,integer item3,integer qty3,integer item4,integer qty4,integer item5,integer qty5,integer item6,integer qty6 returns nothing
        set ITEM_MIX_INDEX = ITEM_MIX_INDEX+10
        set ITEM_MIX[ITEM_MIX_INDEX] = targetItemId
        set ITEM_MIX[ITEM_MIX_INDEX+1] = item1
        set ITEM_MIX[ITEM_MIX_INDEX+2] = item2
        set ITEM_MIX[ITEM_MIX_INDEX+3] = item3
        set ITEM_MIX[ITEM_MIX_INDEX+4] = item4
        set ITEM_MIX[ITEM_MIX_INDEX+5] = item5
        set ITEM_MIX[ITEM_MIX_INDEX+6] = item6
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+1] = qty1
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+2] = qty2
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+3] = qty3
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+4] = qty4
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+5] = qty5
        set ITEM_MIX_QTY[ITEM_MIX_INDEX+6] = qty6
    endfunction

    /**
     * 根据tag获取属性
     * 3最大叠加数 4等级 5金额 6木头
     */
    private function getAttrByItemId takes integer itemId,integer tag returns integer
        local integer i = 0
        local integer attr = 0
        //debug
        if( tag < 2 or tag > 6)then
            return 0
        endif
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( itemId == ITEM[(i+2)] ) then
                    set attr = ITEM[(i+tag)]
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return attr
    endfunction

    /**
     * 根据ItemId获取重量
     */
    public function getWeightByItemId takes integer itemId returns real
        local integer i = 0
        local real attr = 0
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( itemId == ITEM[(i+2)] ) then
                    set attr = ITEM_WEIGHT[i]
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return attr
    endfunction

    /**
     * 根据Item获取重量(包含数量)
     */
    public function getWeightByItem takes item it returns real
        local integer i = 0
        local real attr = 0
        local integer itemId = GetItemTypeId(it)
        if( it == null)then
            return 0.00
        endif
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( itemId == ITEM[(i+2)] ) then
                    set attr = ITEM_WEIGHT[i] * GetItemCharges(it)
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return attr
    endfunction

    /**
     * 根据物品ID获取金额
     */
    public function getGoldByItemId takes integer itemId returns integer
        return getAttrByItemId( itemId , 5 )
    endfunction

    /**
     * 根据物品ID获取木头
     */
    public function getLumberByItemId takes integer itemId returns integer
        return getAttrByItemId( itemId , 6 )
    endfunction

    /**
     * 根据卷轴ID获得真实物品ID
     */
    public function getItemIdByReelId takes integer reelId returns integer
        local integer i = 0
        local integer itemId = 0
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( reelId == ITEM[(i+1)] ) then
                    set itemId = ITEM[(i+2)]
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return itemId
    endfunction

    /**
     * 根据真实物品ID获得卷轴ID
     */
    public function getReelIdByItemId takes integer itemId returns integer
        local integer i = 0
        local integer reelId = 0
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( itemId == ITEM[(i+2)] ) then
                    set reelId = ITEM[(i+1)]
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return reelId
    endfunction

	/**
	 * 根据卷轴ID检查物品是否合成品
	 */
    public function isMixByReelId takes integer reelId returns boolean
    	local integer i = 0
    	local boolean isMix = false
    	set i = 10
        loop
            exitwhen i > Max_Item_num
                if( reelId == ITEM_MIX[i] ) then
                    set isMix = true
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop
        return isMix
    endfunction

    /**
	 * 根据每页多少个来 获取合成品的页数
	 */
    public function getMixPageNum takes integer perPage returns integer
    	local integer i = 0
    	local integer j = 0
    	local integer totalPage = 1
    	set i = 10
    	set j = 1
        loop
            exitwhen ITEM_MIX[i] <= 0
                if( j >= perPage ) then
	                set totalPage = totalPage + 1
	                set j = 0
            	endif
            set i = i + 10
            set j = j + 1
        endloop
        return totalPage
    endfunction

    /**
    *
    */
    private function check_slot takes unit u,integer target_index,integer reelId,item realIt returns boolean
        local integer i
        local integer j
        local integer slot_index
        local integer slot_charges = 0
        local item it = null        //临时变量
        local integer array itemsCharges     //临时变量(次数)
        local integer array needQty //依照合成公式的需要材料数量
        local boolean isEnough      //是否足够材料
        //debug
        if(ITEM_MIX_QTY[(target_index+1)]==0 and ITEM_MIX_QTY[(target_index+2)]==0 and ITEM_MIX_QTY[(target_index+3)]==0 and ITEM_MIX_QTY[(target_index+4)]==0 and ITEM_MIX_QTY[(target_index+5)]==0 and ITEM_MIX_QTY[(target_index+6)]==0) then
            return FALSE
        endif
        //第一步：合计符合条件的物品数
        set i = 1
        loop
            exitwhen i > 6
                //如需要合成物品i，则去合计单位身上的此类物品数
                set needQty[(target_index+i)] =  ITEM_MIX_QTY[(target_index+i)]
                if( needQty[(target_index+i)] > 0) then
                    set itemsCharges[(target_index+i)] = 0
                    set j = 1
                    loop
                        exitwhen j > 6
                            set it = UnitItemInSlot(u, j-1)
                            if ( it!=null and ITEM_MIX[ (target_index+i) ] == GetItemTypeId(it)) then
                                set itemsCharges[(target_index+i)] = itemsCharges[(target_index+i)] + GetItemCharges(it)
                            endif
                        set j = j + 1
                    endloop
                    //如果有第七件
                    if(GetItemCharges(realIt)>0) then
                        if ( ITEM_MIX[ (target_index+i) ] == GetItemTypeId(realIt)) then
                            set itemsCharges[(target_index+i)] = itemsCharges[(target_index+i)] + GetItemCharges(realIt)
                        endif
                    endif
                //
                endif
            set i = i + 1
        endloop
        //第二步，判断是否有足够的材料
        set isEnough = TRUE
        set i = 1
        loop
            exitwhen i > 6
                if(needQty[(target_index+i)]>0 and itemsCharges[(target_index+i)] < needQty[(target_index+i)]) then
                    set isEnough = FALSE
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 1
        endloop
        //假设足够材料，删除单位身上的物品
        if(isEnough == TRUE) then
            set i = 1
            loop
                exitwhen i > 6
                    set slot_index = GetInventoryIndexOfItemTypeBJ(u, ITEM_MIX[(target_index+i)])
                    set it = UnitItemInSlot(u, slot_index-1)
                    set slot_charges = GetItemCharges(it) - needQty[(target_index+i)]
                    if( slot_index!=0 and needQty[(target_index+i)]>0) then
                        if(slot_charges>0) then
                            call SetItemCharges(it,slot_charges)
                            set needQty[(target_index+i)] = 0
                        elseif(slot_charges==0) then
                            call RemoveItem(it)
                            set needQty[(target_index+i)] = 0
                        else
                            call RemoveItem(it)
                            set needQty[(target_index+i)] = 0-slot_charges
                        endif
                    endif
                    //如果一格不够数并且有第七件物品且类型符合
                    //则计算
                    if(needQty[(target_index+i)] > 0 and GetItemCharges(realIt)>0 and GetItemTypeId(realIt) == ITEM_MIX[(target_index+i)]) then
                        set slot_charges = GetItemCharges(realIt) - needQty[(target_index+i)]
                        if(slot_charges>0) then
                            call SetItemCharges(realIt,slot_charges)
                            set needQty[(target_index+i)] = 0
                        elseif(slot_charges==0) then
                            call SetItemCharges(realIt,0)
                            set needQty[(target_index+i)] = 0
                        else
                            call SetItemCharges(realIt,0)
                            set needQty[(target_index+i)] = 0-slot_charges
                        endif
                    endif
                    //如果还是不够数，则i不加1继续扣除身上物品
                    if(needQty[(target_index+i)] == 0) then
                        set i = i + 1
                    endif
            endloop
            //计算完毕后如果获取的realIt还有剩次数，则创建一个卷轴（同次数）给英雄
            if(GetItemCharges(realIt)>0) then
                set it = CreateItem(reelId, GetUnitX(u), GetUnitY(u))
                call SetItemCharges(it,GetItemCharges(realIt))
                call UnitAddItem(u, it)
            endif
            call RemoveItem(realIt)
            set realIt = null
            return TRUE
        endif
        return FALSE
    endfunction
    /**
     * 检测某单位的6格物品栏 + 第七件 是否形成合成
     */
    private function check_mix takes unit u,integer reelId, item realIt returns boolean
        local integer i
        local integer j
        local boolean isMix = FALSE
        local integer realId = GetItemTypeId(realIt)
        local boolean checkNewItem = true
        local item mix_it = null
        //debug
        if( realId == null) then
            return FALSE
        endif
        //
        set i = 10
        loop
            exitwhen i > Max_Item_mix_num
            //如果得到的物品是这个合成公式的其中之一
            if( realId == ITEM_MIX[i+1] or realId == ITEM_MIX[i+2] or realId == ITEM_MIX[i+3] or realId == ITEM_MIX[i+4] or realId == ITEM_MIX[i+5] or realId == ITEM_MIX[i+6]) then
                set isMix = check_slot(u,i,reelId,realIt)
                if(isMix == TRUE) then
                    set mix_it = CreateItem(ITEM_MIX[i], GetUnitX(u), GetUnitY(u))
                    call SetItemPlayer( mix_it , GetOwningPlayer(u), false )    //改变归属
                    call UnitAddItem(u, mix_it)
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            endif
            set i = i + 10
        endloop
        //
        if(GetItemCharges(realIt)<=0) then
            call RemoveItem(realIt)
        endif
        return isMix
    endfunction

    //物品叠加
    public function addItem takes integer reelId,integer reel_charges,unit u returns nothing
    	local integer i = 0
        local item it                            	//背包物品临时变量
        local item it_get                            //获得的卷轴
        local item it_real                    		//获得的卷轴对应的物品
        local integer it_charges = 1      			//获得的物品的使用次数
        local integer item_limit_num        		//叠加限制,0无限制
        local integer new_charges         			//新使用次数
        local boolean is_recursion = false			//是否递归（当遇到合成使得物品减少时置为TRUE）
        local integer playerIndex = GetConvertedPlayerId(GetOwningPlayer(u))
        local real weight = 0.00
        local integer tempGold = 0
        local integer tempLumber = 0
        set it_get = CreateItem(reelId, GetUnitX(u), GetUnitY(u))
        call SetItemCharges(it_get,reel_charges)

        //找出对应的物品，找出此物品类的叠加极限值
        set item_limit_num = 0      //debug
        set i = 10
        loop
            exitwhen i > Max_Item_num
                if( reelId == ITEM[(i+1)] ) then
                    set item_limit_num = ITEM[(i+3)]
                    set it_real = CreateItem(ITEM[(i+2)], GetUnitX(u), GetUnitY(u))
                    call SetItemCharges(it_real,reel_charges)
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            set i = i + 10
        endloop

        //检查负重
        /*
        set weight = items_getWeightByItem( it_real )
        if( attribute_getWeightCurrent(u) + weight > attribute_getWeight(u) ) then
			//set tempGold = items_getGoldByItemId( GetItemTypeId(it_real) ) * GetItemCharges( it_real )
			//set tempLumber = items_getLumberByItemId( GetItemTypeId(it_real) ) * GetItemCharges( it_real )
			//call funcs_addGold( Players[playerIndex] , tempGold )
    		//call funcs_addLumber( Players[playerIndex] , tempLumber )
            call funcs_floatMsg("|cffffcc00背包不够大装不下了~|r"  ,u)
            //call RemoveItem(it_get)
            //call RemoveItem(it_real)
            return
        endif
        */

        set i = 1
        loop
            exitwhen i > 6
            set it = UnitItemInSlot(u, i-1)
            if ( it!=null and GetItemTypeId(it_real) == GetItemTypeId(it)) then
                //如果第i格物品和获得的一致
                //如果有极限值 并且原有的物品未达上限
                if(item_limit_num !=0 and GetItemCharges(it) != item_limit_num) then
                    if((reel_charges+GetItemCharges(it))<= item_limit_num) then
                        //条件：如果新物品加旧物品使用次数不大于极限值
                        //使旧物品使用次数增加，删除获得的物品it_get
                        call SetItemCharges(it,GetItemCharges(it)+reel_charges)
                        call RemoveItem(it_get)
                        set it_get = null
                        call SetItemCharges(it_real,0)
                    else
                        //否则，如果使用次数大于极限值
                        set new_charges = item_limit_num - (item_limit_num - GetItemCharges(it))
                        call SetItemCharges(it,item_limit_num)
                        call SetItemCharges(it_get,new_charges)
                        call SetItemCharges(it_real,new_charges)
                    endif
                    call DoNothing() YDNL exitwhen true//(  )
                elseif(item_limit_num==0) then      //如果没有极限值，直接叠加数量
                    call SetItemCharges(it,GetItemCharges(it)+reel_charges)
                    call RemoveItem(it_get)
                    set it_get = null
                    call SetItemCharges(it_real,0)
                    call DoNothing() YDNL exitwhen true//(  )
                else
                    //继续循环
                endif
            endif
            set i = i + 1
        endloop

        if(it_get == null) then //如果是叠加或无极限的情况
            //检查合成
            call check_mix(u,reelId,it_real)
            call RemoveItem(it_real)
            set it_real = null
        elseif( (UnitItemInSlot(u, 0) == null) or (UnitItemInSlot(u, 1) == null) or (UnitItemInSlot(u, 2) == null) or (UnitItemInSlot(u, 3) == null) or (UnitItemInSlot(u, 4) == null) or (UnitItemInSlot(u, 5) == null) ) then
            //如果单位有任意一格还没有物品，则直接给它物品,然后把卷轴删掉
            call funcs_console("Items addItem - get new item")
            set it = CreateItem(GetItemTypeId(it_real), GetUnitX(u), GetUnitY(u))
            call SetItemCharges(it,GetItemCharges(it_real))
            call SetItemPlayer( it , GetOwningPlayer(u), false )    //改变归属
            call UnitAddItem(u, it)
            call SetItemCharges(it_real,0)
            set it = null
            call RemoveItem(it_get)
            set it_get = null
            //合成
            call check_mix(u,reelId,it_real)
        else
            //满格的话 检测是否有合成，如果返回TRUE，递归获得物品
            //如果获得的物品还没有为空
            if(it_get != null and it_real != null) then
                //检测是否有合成,如果合成存在则返回TRUE
                set is_recursion = check_mix(u,reelId,it_real)
                if( is_recursion==TRUE ) then
                    call RemoveItem(it_get)
                else
                    //不可，则将卷轴建在地上
                    //默认创建就在英雄XY轴上，所以此处不必再次创建
                    call funcs_floatMsg("|cffffcc00物品栏满出来啦~|r"  ,u)
                    call funcs_console("Items addItem - take reel on floor" )
                endif
                set it_get = null
            endif
            //满格的话  不管怎样，真实的物品最后如果未删都必须删掉
            if(it_real != null) then
                call RemoveItem(it_real)
                set it_real = null
            endif
        endif
    endfunction

    /**
     * 获取某单位身上某种物品的使用总次数
     */
    public function getTotalCharges takes unit u,integer itemId returns integer
        local integer i
        local integer charges = 0
        local item it = null
        set i = 0
        loop
            exitwhen i > 5
            set it = UnitItemInSlot(u, i)
            if(it != null and GetItemTypeId(it) == itemId and GetItemCharges(it) > 0) then
                set charges = charges + GetItemCharges(it)
            endif
            set i=i+1
        endloop
        set it = null
        return charges
    endfunction

    /* 创建物品给英雄 */
    public function toHero takes integer itemId,unit hero,integer charges returns item
        local location loc = GetUnitLoc(hero)
        local real x = GetLocationX(loc)
        local real y = GetLocationY(loc)
        local item it = CreateItem(itemId , x, y )
        call SetItemCharges( it , charges )
        call UnitAddItem(hero, it )
        call RemoveLocation(loc)
        set loc = null
        return it
    endfunction

    private function init takes nothing returns nothing
        set hash = InitHashtable()
    endfunction

endlibrary
