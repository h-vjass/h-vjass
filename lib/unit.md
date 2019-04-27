unit
> 调用：hunit.method()

---

* **getMaxLife**
```
获取单位的最大生命
```

* **getLife**
```
获取单位的当前生命
```

* **setLife**
```
设置单位的当前生命
```

* **addLife**
```
增加单位的当前生命
```

* **subLife**
```
减少单位的当前生命
```

* **getLifePercent**
```
获取单位百分比生命
```

* **setLifePercent**
```
设置单位百分比生命
```

* **getMaxMana**
```
获取单位的最大魔法
```

* **getMana**
```
获取单位的当前魔法
```

* **setMana**
```
设置单位的当前魔法
```

* **addMana**
```
增加单位的当前魔法
```

* **subMana**
```
减少单位的当前魔法
```

* **getManaPercent**
```
获取单位百分比魔法
```

* **setManaPercent**
```
设置单位百分比魔法
```

* **setPeriod**
```
设置单位的生命周期
```

* **setOpenPunish**
```
设置单位是否启用硬直
```

* **isOpenPunish**
```
获取单位是否启用硬直（系统默认不启用）
```

* **getAvatar**
```
获取单位类型的头像
```

* **setAvatar**
```
设置单位类型的头像
```

* **getAttackSpeedBaseSpace**
```
获取单位类型整体的攻击速度间隔(默认2.00秒/击)
```

* **setAttackSpeedBaseSpace**
```
设置单位类型整体的攻击速度间隔
```

* **getAttackRange**
```
获取单位类型整体的攻击范围
```

* **setAttackRange**
```
设置单位类型整体的攻击范围，物编的攻击距离与主动范围请调节为一致，攻击距离更改设定为最大攻击距离
例如需要修改的单位在物编将[主动攻击范围][攻击范围]设为9999，然后hjass里就可以动态最大修改攻击距离为 9999
主动攻击范围务必与攻击距离一致，hjass里修改攻击范围时，会自适应主动攻击范围
```

* **setUserData**
```
设置单位自定义值
```

* **getUserData**
```
获取单位自定义值
```

* **del**
```
删除单位，可延时
```

* **kill**
```
杀死单位，可延时
```

* **exploded**
```
爆毁单位，可延时
```

* **getFacing**
```
获取单位面向角度
```

* **getFacingBetween**
```
获取两个单位间面向角度，如果其中一个单位为空 返回0
```

* **setUnitFly**
```
设置单位可飞，用于设置单位飞行高度之前
```

* **rebornAtXY**
```
在某XY坐标复活英雄
* 只有英雄能被复活
* 只有调用此方法会触发复活事件
```

* **rebornAtLoc**
```
在某点复活英雄
* 只有英雄能被复活
* 只有调用此方法会触发复活事件
```

* **shadow**
```
创建一个单位的影子
影子是无敌蝗虫且无法行动
用于标识
```

* **createUnit**
```
在某点创建1单位
```

* **createUnitFacing**
```
在某点创建1单位,面向角度facing
```

* **createUnitLookAt**
```
在某点创建1单位,并看向某点
```

* **createUnitAttackToLoc**
```
在某点创建1单位,攻击移动到某点
```

* **createUnitAttackToUnit**
```
在某点创建1单位,攻击某单位
```

* **createUnitXY**
```
在XY创建1单位
```

* **createUnitXYFacing**
```
在XY创建1单位,面向角度facing
```

* **createUnithXY**
```
在hXY创建1单位
```

* **createUnits**
```
在某点创建单位组
```

* **createUnitsFacing**
```
在某点创建单位组,面向角度facing
```

* **createUnitsLookAt**
```
在某点创建单位组,并看向某点
```

* **createUnitsAttackToLoc**
```
在某点创建单位组,攻击移动到某点
```

* **createUnitsAttackToUnit**
```
在某点创建单位组,攻击某单位
```


* **createUnitsXY**
```
在XY创建单位组
```

* **createUnitsXYFacing**
```
在XY创建单位组,面向角度facing
```

