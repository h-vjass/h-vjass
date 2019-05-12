//is.j 
globals
    hIs his
endglobals

struct hIs

    
    /**
     * 是否夜晚
     */
    public static method night takes nothing returns boolean
        return (GetTimeOfDay()<=6.00 or GetTimeOfDay()>=18.00)
    endmethod

    /**
     * 是否白天
     */
    public static method day takes nothing returns boolean
        return (GetTimeOfDay()>6.00 and GetTimeOfDay()<18.00)
    endmethod

    /*
     * 是否电脑
     */
    public static method computer takes player whichPlayer returns boolean
        local integer handleid = GetHandleId(whichPlayer)
        set whichPlayer = null
        return LoadBoolean(hash_player, handleid, hp_isComputer)
    endmethod

    /*
     * 是否玩家位置(如果位置为真实玩家或为空，则为true；而如果选择了电脑玩家补充，则为false)
     */
    public static method playerSite takes player whichPlayer returns boolean
        local boolean b = GetPlayerController(whichPlayer) == MAP_CONTROL_USER
        set whichPlayer = null
        return b
    endmethod

    /*
     * 是否正在游戏
     */
    public static method playing takes player whichPlayer returns boolean
        local boolean b = GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING
        set whichPlayer = null
        return b
    endmethod

    /*
     * 是否中立玩家（包括中立敌对 中立被动 中立受害 中立特殊）
     */
    public static method isNeutral takes player whichPlayer returns boolean
        local boolean flag = false
        if(whichPlayer == null) then
            set flag = false
        elseif(whichPlayer == Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
            set flag = true
        elseif(whichPlayer == Player(bj_PLAYER_NEUTRAL_VICTIM)) then
            set flag = true
        elseif(whichPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA)) then
            set flag = true
        elseif(whichPlayer == Player(PLAYER_NEUTRAL_PASSIVE)) then
            set flag = true
        endif
        set whichPlayer = null
        return flag
    endmethod

    /*
     * 是否在某玩家真实视野内
     */
    public static method detected takes unit whichUnit,player whichPlayer returns boolean
        local boolean flag = false
        if(whichUnit == null or whichPlayer == null) then
            set flag = false
        elseif(IsUnitDetected(whichUnit, whichPlayer) == true) then
            set flag = true
        endif
        set whichUnit = null
        set whichPlayer = null
        return flag
    endmethod

    /**
     * 是否拥有物品栏
     */
    public static method hasSlot takes unit whichUnit returns boolean
        local integer lv = GetUnitAbilityLevel(whichUnit,ITEM_ABILITY)
        set whichUnit = null
        return lv>=1
    endmethod
    /**
     * 是否死亡
     */
    public static method death takes unit whichUnit returns boolean
        local boolean b = IsUnitDeadBJ(whichUnit)
        set whichUnit = null
        return b
    endmethod
    /**
     * 是否生存
     */
    public static method alive takes unit whichUnit returns boolean
        local boolean b = not IsUnitDeadBJ(whichUnit)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否无敌
     */
    public static method invincible takes unit whichUnit returns boolean
        local integer lv = GetUnitAbilityLevel(whichUnit,'Avul')
        set whichUnit = null
        return lv>0
    endmethod
    /**
     * 是否英雄
     */
    public static method hero takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_HERO) or IsUnitInGroup(whichUnit,isHeroGroup)
        set whichUnit = null
        return b
    endmethod
    /**
     * 是否建筑
     */
    public static method building takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_STRUCTURE)
        set whichUnit = null
        return b
    endmethod
    /**
     * 是否镜像
     */
    public static method illusion takes unit whichUnit returns boolean
        local boolean b = IsUnitIllusion( whichUnit)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否地面单位
     */
    public static method ground takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_GROUND)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否空中单位
     */
    public static method flying takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_FLYING)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否近战
     */
    public static method melee takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_MELEE_ATTACKER)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否远程
     */
    public static method ranged takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_RANGED_ATTACKER)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否召唤
     */
    public static method summoned takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_SUMMONED)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否机械
     */
    public static method mechanical takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_MECHANICAL)
        set whichUnit = null
        return b
    endmethod
    /*
     * 是否古树
     */
    public static method ancient takes unit whichUnit returns boolean
        local boolean b = IsUnitType( whichUnit , UNIT_TYPE_ANCIENT)
        set whichUnit = null
        return b
    endmethod

    /*
     * 是否被硬直
     */
    public static method punish takes unit whichUnit returns boolean
        local boolean b = hattr.isPunishing(whichUnit)
        set whichUnit = null
        return b
    endmethod

    /*
     * 是否被沉默
     */
    public static method silent takes unit whichUnit returns boolean
        local boolean b = IsUnitInGroup(whichUnit, ABILITY_SILENT_GROUP)
        set whichUnit = null
        return b
    endmethod

    /*
     * 是否被缴械
     */
    public static method unarm takes unit whichUnit returns boolean
        local boolean b = IsUnitInGroup(whichUnit, ABILITY_UNARM_GROUP)
        set whichUnit = null
        return b
    endmethod

    /*
     * 是否被击飞
     */
    public static method crackfly takes unit whichUnit returns boolean
        local boolean b = LoadBoolean(hash_unit,GetHandleId(whichUnit),hashkey_unit_crackfly)
        set whichUnit = null
        return b
    endmethod

    /**
     * 是否处在水面
     */
    public static method water takes unit whichUnit returns boolean
        local boolean status = false
        local location loc = GetUnitLoc(whichUnit)
        set status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == false
        call RemoveLocation(loc)
        set loc = null
        set whichUnit = null
        return status
    endmethod
    /**
     * 是否处于地面
     */
    public static method floor takes unit whichUnit returns boolean
        local boolean status = false
        local location loc = GetUnitLoc(whichUnit)
        set status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == true
        call RemoveLocation(loc)
        set loc = null
        set whichUnit = null
        return status
    endmethod

    /**
     * 是否某个特定单位
     */
    public static method unit takes unit whichUnit,unit otherUnit returns boolean
        local boolean b = (whichUnit == otherUnit)
        set whichUnit = null
        set otherUnit = null
        return b
    endmethod

    /**
     * 是否敌人
     */
    public static method enemy takes unit whichUnit,unit otherUnit returns boolean
        local boolean b = IsUnitEnemy(whichUnit, GetOwningPlayer(otherUnit))
        set whichUnit = null
        set otherUnit = null
        return b
    endmethod
    /**
     * 是否友军
     */
    public static method ally takes unit whichUnit,unit otherUnit returns boolean
        local boolean b = IsUnitAlly(whichUnit, GetOwningPlayer(otherUnit))
        set whichUnit = null
        set otherUnit = null
        return b
    endmethod

    /**
     * 是否超出区域边界
     */
    public static method borderRect takes rect r,real x,real y returns boolean
        local boolean flag = false
        if( x >= GetRectMaxX(r) or x <= GetRectMinX(r) )then
            set flag = true
        endif
        if( y >= GetRectMaxY(r) or y <= GetRectMinY(r) )then
            set flag = true
        endif
        set r = null
        return flag
    endmethod

    /**
     * 是否超出地图边界
     */
    public static method borderMap takes real x,real y returns boolean
        return borderRect(GetPlayableMapRect(),x,y)
    endmethod

    /**
     * 单位身上是否有某物品
     */
    public static method ownItem takes unit u,integer itemId returns boolean
        local boolean b = (GetItemTypeId(GetItemOfTypeFromUnitBJ(u, itemId)) == itemId)
        set u = null
        return b
    endmethod

endstruct
