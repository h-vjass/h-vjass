event

> 调用：hevt.method()

---

* **getLastDamageUnit**
```
获取最后一位伤害某单位的伤害来源
```

* **set/get**
```
事件get/set方法，用于触发事件时获取触发对象
setTriggerUnit / getTriggerUnit
setTriggerEnterUnit / getTriggerEnterUnit
setTriggerRect / getTriggerRect
setTriggerItem / getTriggerItem
setTriggerPlayer / getTriggerPlayer
setTriggerString / getTriggerString
setTriggerStringMatched / getTriggerStringMatched
setTriggerSkill / getTriggerSkill
setSourceUnit / getSourceUnit
setTargetUnit / getTargetUnit
setTargetLoc / getTargetLoc
setAttacker / getAttacker
setKiller / getKiller
setDamage / getDamage
setRealDamage / getRealDamage
setId / getId
setRange / getRange
setValue / getValue
setValue2 / getValue2
setValue3 / getValue3
setDuring / getDuring
setDamageKind / getDamageKind
setDamageType / getDamageType
setBreakType / getBreakType
setType / getType
setIsNoAvoid / getIsNoAvoid
```

* **onAttackDetect**
```
on - 注意到攻击目标
@getTriggerUnit 获取触发单位
@getTargetUnit 获取被注意/目标单位
```

* **onAttackGetTarget**
```
on - 获取攻击目标
@getTriggerUnit 获取触发单位
@getTargetUnit 获取被获取/目标单位
```

* **onAttackReady**
```
on - 准备攻击
@getTriggerUnit 获取攻击单位
@getTargetUnit 获取被攻击单位
@getAttacker 获取攻击单位
```

* **onBeAttackReady**
```
on - 准备被攻击
@getTriggerUnit 获取被攻击单位
@getTargetUnit 获取攻击单位
@getAttacker 获取攻击单位
```

* **onAttack**
```
on - 造成攻击
@getTriggerUnit 获取攻击来源
@getTargetUnit 获取被攻击单位
@getAttacker 获取攻击来源
@getDamage 获取初始伤害
@getRealDamage 获取实际伤害
@getDamageKind 获取伤害方式
@getDamageType 获取伤害类型
```

* **onBeAttack**
```
on - 承受攻击
@getTriggerUnit 获取被攻击单位
@getAttacker 获取攻击来源
@getDamage 获取初始伤害
@getRealDamage 获取实际伤害
@getDamageKind 获取伤害方式
@getDamageType 获取伤害类型
```

* **onSkillStudy**
```
on - 学习技能
@getTriggerUnit 获取学习单位
@getTriggerSkill 获取学习技能ID
```

* **onSkillReady**
```
on - 准备施放技能
@getTriggerUnit 获取施放单位
@getTargetUnit 获取目标单位(只对对目标施放有效)
@getTriggerSkill 获取施放技能ID
@getTargetLoc 获取施放目标点
```

* **onSkillStart**
```
on - 开始施放技能
@getTriggerUnit 获取施放单位
@getTargetUnit 获取目标单位(只对对目标施放有效)
@getTriggerSkill 获取施放技能ID
@getTargetLoc 获取施放目标点
```

* **onSkillStop**
```
on - 停止施放技能
@getTriggerUnit 获取施放单位
@getTriggerSkill 获取施放技能ID
```

* **onSkillHappen**
```
on - 发动技能效果
@getTriggerUnit 获取施放单位
@getTargetUnit 获取目标单位(只对对目标施放有效)
@getTriggerSkill 获取施放技能ID
@getTargetLoc 获取施放目标点
```

* **onSkillOver**
```
on - 施放技能结束
@getTriggerUnit 获取施放单位
@getTriggerSkill 获取施放技能ID
```

* **onItemUsed**
```
on - 单位使用物品
@getTriggerUnit 获取触发单位
@getTriggerItem 获取触发物品
```

* **onItemSell**
```
on - 出售物品(商店卖给玩家)
@getTriggerUnit 获取触发单位
@getTriggerItem 获取触发物品
```

* **onItemDrop**
```
on - 丢弃物品
@getTriggerUnit 获取触发/出售单位
@targetUnit 获取购买单位
@getTriggerItem 获取触发/出售物品
```

* **onItemGet**
```
on - 获得物品
@getTriggerUnit 获取触发单位
@getTriggerItem 获取触发物品
```

* **onItemPawn**
```
on - 抵押物品（玩家把物品扔给商店）
@getTriggerUnit 获取触发单位
@getTriggerItem 获取触发物品
```

* **onItemDestroy**
```
on - 物品被破坏
@getTriggerUnit 获取触发单位
@getTriggerItem 获取触发物品
```

* **onItemMix**
```
on - 合成物品
@getTriggerUnit 获取触发单位
@getTriggerItem 获取合成的物品
```

* **onItemSeparate**
```
on - 拆分物品
@getTriggerUnit 获取触发单位
@getId 获取拆分的物品ID
@getType 获取拆分的类型
    simple 单件拆分
    mixed 合成品拆分
```


* **onDamage**
```
on - 造成伤害
@getTriggerUnit 获取伤害来源
@getTargetUnit 获取被伤害单位
@getSourceUnit 获取伤害来源
@getDamage 获取初始伤害
@getRealDamage 获取实际伤害
@getDamageKind 获取伤害方式
@getDamageType 获取伤害类型
```

* **onBeDamage**
```
on - 承受伤害
@getTriggerUnit 获取被伤害单位
@getSourceUnit 获取伤害来源
@getDamage 获取初始伤害
@getRealDamage 获取实际伤害
@getDamageKind 获取伤害方式
```

* **onAvoid**
```
on - 攻击被回避
@getTriggerUnit 获取攻击单位
@getAttacker 获取攻击单位
@getTargetUnit 获取回避的单位
```

* **onBreakDefend**
```
on - 无视护甲成功
@getBreakType 获取无视类型
@getTriggerUnit 获取破甲单位
@getTargetUnit 获取目标单位
@getValue 获取破甲的数值
```

* **onBeBreakDefend**
```
on - 被无视护甲
@getBreakType 获取无视类型
@getTriggerUnit 获取被破甲单位
@getSourceUnit 获取来源单位
@getValue 获取破甲的数值
```

* **onBreakResistance**
```
on - 无视魔抗成功
@getBreakType 获取无视类型
@getTriggerUnit 获取破抗单位
@getTargetUnit 获取目标单位
@getValue 获取破抗的百分比
```

* **onBeBreakResistance**
```
on - 被无视魔抗
@getBreakType 获取无视类型
@getTriggerUnit 获取被破抗单位
@getSourceUnit 获取来源单位
@getValue 获取破抗的百分比
```

* **onBreakDefendAndResistance**
```
on - 无视护甲和魔抗同时成功
@getBreakType 获取无视类型
@getTriggerUnit 获取破甲/抗单位
@getTargetUnit 获取目标单位
@getValue 获取破甲的数值
@getValue2 获取破抗的百分比
```

* **onBeBreakDefendAndResistance**
```
on - 被同时无视护甲和魔抗
@getBreakType 获取无视类型
@getTriggerUnit 获取被破甲/抗单位
@getSourceUnit 获取来源单位
@getValue 获取破甲的数值
@getValue2 获取破抗的百分比
```

* **onSwim**
```
on - 眩晕成功
@getTriggerUnit 获取触发单位
@getTargetUnit 获取被眩晕单位
@getValue 获取眩晕几率百分比
@getDuring 获取眩晕时间（秒）
```

* **onBeSwim**
```
on - 被眩晕
@getTriggerUnit 获取被眩晕单位
@getSourceUnit 获取来源单位
@getValue 获取眩晕几率百分比
@getDuring 获取眩晕时间（秒）
```

* **onRebound**
```
on - 反伤时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取反伤伤害
```

* **onNoAvoid**
```
on - 造成无法回避的伤害时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取伤害值
```

* **onBeNoAvoid**
```
on - 被造成无法回避的伤害时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取暴击伤害值
```

* **onKnocking**
```
on - 物理暴击时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取暴击伤害值
@getValue 获取暴击几率百分比
@getValue2 获取暴击增幅百分比
```

* **onBeKnocking**
```
on - 承受物理暴击时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取暴击伤害值
@getValue 获取暴击几率百分比
@getValue2 获取暴击增幅百分比
```

* **onViolence**
```
on - 魔法暴击时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取暴击伤害值
@getValue 获取暴击几率百分比
@getValue2 获取暴击增幅百分比
```

* **onBeViolence**
```
on - 承受魔法暴击时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取暴击伤害值
@getValue 获取暴击几率百分比
@getValue2 获取暴击增幅百分比
```

* **onSpilt**
```
on - 分裂时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取分裂伤害值
@getRange 获取分裂范围(px)
@getValue 获取分裂百分比
```

* **onBeSpilt**
```
on - 承受分裂时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取分裂伤害值
@getRange 获取分裂范围(px)
@getValue 获取分裂百分比
```

* **onHemophagia**
```
on - 吸血时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取吸血值
@getValue 获取吸血百分比
```

* **onBeHemophagia**
```
on - 被吸血时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取吸血值
@getValue 获取吸血百分比
```

* **onSkillHemophagia**
```
on - 技能吸血时
@getTriggerUnit 获取触发单位
@getTargetUnit 获取目标单位
@getDamage 获取吸血值
@getValue 获取吸血百分比
```

* **onBeSkillHemophagia**
```
on - 被技能吸血时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getDamage 获取吸血值
@getValue 获取吸血百分比
```

* **onPunish**
```
on - 硬直时
@getTriggerUnit 获取触发单位
@getSourceUnit 获取来源单位
@getValue 获取硬直程度百分比
@getDuring 获取持续时间
```

* **onDead**
```
on - 死亡时
@getTriggerUnit 获取触发单位
@getKiller 获取凶手单位
```

* **onKill**
```
on - 击杀时
@getTriggerUnit 获取触发单位
@getKiller 获取凶手单位
@getTargetUnit 获取死亡单位
```

* **onReborn**
```
on - 复活时
@getTriggerUnit 获取触发单位
```

* **onLevelUp**
```
on - 提升升等级时
@getTriggerUnit 获取触发单位
```

* **onSummon**
```
on - 被召唤时
@getTriggerUnit 获取被召唤单位
```

* **onEnterUnitRange**
```
on - 进入某单位（whichUnit）范围内
@getTriggerUnit 获取被进入范围的中心单位
@getTriggerEnterUnit 获取进入范围的单位
@getRange 获取设定范围
```

* **onEnterRect**
```
on - 进入某区域内
@getTriggerRect 获取被进入的矩形区域
@getTriggerUnit 获取进入矩形区域的单位
```

* **onLeaveRect**
```
on - 离开某区域内
@getTriggerRect 获取被离开的矩形区域
@getTriggerUnit 获取离开矩形区域的单位
```

* **onChat**
```
on - 聊天时（全匹配）
@getTriggerPlayer 获取聊天的玩家
@getTriggerString 获取聊天的内容
@getTriggerStringMatched 获取匹配命中的内容
```

* **onChatLike**
```
on - 聊天时（模糊匹配）
@getTriggerPlayer 获取聊天的玩家
@getTriggerString 获取聊天的内容
@getTriggerStringMatched 获取匹配命中的内容
```

* **onEsc**
```
on - 按ESC
@getTriggerPlayer 获取触发玩家
```

* **onSelection**
```
on - 玩家单击选择单位
@getTriggerPlayer 获取触发玩家
@getTriggerUnit 获取触发单位
```

* **onSelectionDouble**
```
on - 玩家双击选择单位
@getTriggerPlayer 获取触发玩家
@getTriggerUnit 获取触发单位
```

* **onSelectionTriple**
```
on - 玩家三击选择单位
@getTriggerPlayer 获取触发玩家
@getTriggerUnit 获取触发单位
```

* **onUnSelection**
```
on - 玩家取消选择单位
@getTriggerPlayer 获取触发玩家
@getTriggerUnit 获取触发单位
```

* **onUpgradeStart**
```
on - 建筑升级开始时
@getTriggerUnit 获取触发单位
```

* **onUpgradeCancel**
```
on - 建筑升级取消时
@getTriggerUnit 获取触发单位
```

* **onUpgradeFinish**
```
on - 建筑升级完成时
@getTriggerUnit 获取触发单位
```

* **onConstructStart**
```
on - 任意建筑建造开始时
@使用默认的 GetTriggerUnit 获取触发单位
```

* **onConstructCancel**
```
on - 任意建筑建造取消时
@使用默认的 GetCancelledStructure 获取触发单位
```

* **onConstructFinish**
```
on - 任意建筑建造完成时
@使用默认的 GetCancelledStructure 获取触发单位
```

* **onRegister**
```
on - 任意单位注册进h-vjass系统时(注意这是全局事件)
@getTriggerUnit 获取触发单位
```

* **onPickHero**
```
on - 任意单位经过hero方法被玩家所挑选为英雄时(注意这是全局事件)
@getTriggerUnit 获取触发单位
```
