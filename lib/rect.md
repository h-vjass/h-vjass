rect
> 调用：hrect.method()

---

* **createInLoc**
```
设定中心点（X,Y）创建一个长width宽height的矩形区域
```

* **getWidth**
```
获取区域的宽
```

* **getHeight**
```
获取区域的高
```

* **getStartX**
```
获取区域的开始点坐标X
```

* **getStartY**
```
获取区域的开始点坐标Y
```

* **getEndX**
```
获取区域的结束点坐标X
```

* **getEndY**
```
获取区域的结束点坐标Y
```

* **setName**
```
设置区域名称
```

* **getName**
```
获取区域名称
```

* **del**
```
删除区域
```

* **lockByRect**
```
锁定所有单位在某个区域无法离开
area 区域
ty 类型有：[square|circle][矩形|圆形]
during 持续时间 0 则直到调用delLockByRect
```

* **lockByLoc**
```
锁定所有单位在某个点附近一段距离无法离开
area 区域
ty 类型有：[square|circle][矩形|圆形]
width 矩形则为长度，圆形取小的为半径
height 矩形则为宽度，圆形取小的为半径
during 持续时间 0 则直到调用delLockByLoc
```

* **lockByUnit**
```
锁定所有单位在某个单位附近一段距离无法离开
area 区域
ty 类型有：[square|circle][矩形|圆形]
width 矩形则为长度，圆形取小的为半径
height 矩形则为宽度，圆形取小的为半径
during 持续时间 0 则直到调用delLockByLoc
```

* **delLockByRect**
```
删除锁定区域
```

* **delLockByLoc**
```
删除锁定点
```

* **delLockByUnit**
```
删除锁定单位
```
