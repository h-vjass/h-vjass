hero

> 调用：hhero.method()

---

* **setHeroPrevLevel**
```
设置英雄之前的等级
```

* **getHeroPrevLevel**
```
获取英雄之前的等级
```

* **setBuildXY**
```
设置生成选择位置坐标XY
```

* **setBuildDistance**
```
设置生成选择位置的间隔距离
```

* **push**
```
保存单位
1.酒馆模式下，这些单位会在buildDrunkery时自动写进酒馆
1.双击模式下，这些单位会在buildDoubleClick时在地上排列单位
会增加 1 英雄种类数
```

* **getQty**
```
获取游戏英雄单位种类数
```

* **setPlayerAllowQty**
```
设置玩家最大英雄单位数量,支持1～10
```

* **getPlayerAllowQty**
```
获取玩家最大英雄单位数量
```

* **getPlayerUnitQty**
```
获取玩家现有单位数量
```

* **itIs**
```
设定某个单位为英雄类别
 ！请不要乱设置[一般单位]为[英雄]，以致于力量敏捷智力等不属于一般单位的属性引起崩溃报错
 ！设定后 his.hero 方法会认为单位为英雄，同时属性系统才会认定它为英雄，从而生效
```

* **setHeroType**
```
设置英雄的类型（力str 敏agi 智int）
```

* **getHeroTypeLabel**
```
获取英雄的类型名称（力str 敏agi 智int）
```

* **getHeroType**
```
获取英雄的类型（力str 敏agi 智int）
```

* **setDrunkeryAllowQty**
```
设置每个酒馆允许的最大单位数量
 ！只允许1～11
```

* **setDrunkeryPerRow**
```
设置每行生成酒馆最大，自动换行
```

* **setDrunkeryID**
```
设置生成酒馆ID
```

* **buildDrunkery**
```
开始建立酒馆
同时开启random指令
同时开启repick指令
```

* **buildDoubleClick**
```
开始建立单位给玩家双击
同时开启random指令
同时开启repick指令
```
