enemy

> 调用：henemy.method()

---

* **setEnemyName**
```
设置敌人的名称
```

* **getEnemyName**
```
获取敌人的名称
```

* **setIsShareView**
```
设置玩家是否共享敌军的视野
```

* **setEnemyPlayer**
```
将某个玩家位置设定为敌人，同时将他名字设定为全局的enemyName
颜色调节为黑色ConvertPlayerColor(12)
自动分配单位数，优化大数量单位指令集
```

* **getEnemyPlayer**
```
获取一个创建单位最少的敌人玩家
```

* **createUnit**
```
在某点创建1个敌军单位
```

* **createUnitXY**
```
在XY创建1个敌军单位
```

* **createUnithXY**
```
在hXY创建1个敌军单位
hXY是一个结构体，包含一个x以及一个y数据，可理解为{x = ?,y = ?}
```

* **createUnitLookAt**
```
在某点创建1个面向某点敌军单位
```

* **createUnitXYFacing**
```
在XY创建1个面向角度为facing的敌军单位
```

* **createUnitFacing**
```
在某点创建1个面向角度为facing的敌军单位
```

* **createUnitAttackToLoc**
```
在某点创建1个面向某点敌军单位,并对点发动攻击
```

* **createUnitAttackToUnit**
```
在某点创建1个面向某点敌军单位,并对某个单位发动攻击
```

* **createUnits**
```
在某点创建敌军单位组
```

* **createUnitsXYFacing**
```
在XY创建敌军单位组，面向facing
```

* **createUnitsLookAt**
```
在某点创建敌军单位组，面向点
```

* **createUnitsAttackToLoc**
```
在某点创建敌军单位组，并对点发动攻击
```

* **createUnitsAttackToUnit**
```
在某点创建敌军单位组，并对某个单位发动攻击
```

