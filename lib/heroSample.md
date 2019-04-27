hero例子

---

* **将英雄类型写进酒馆，并生成选英雄**
```
local real chooseTime = 60.0
local integer i = g_hero_count
loop
    exitwhen i<=0
        call hhero.push(g_hero[i])
    set i=i-1
endloop
call hhero.setDrunkeryID('n003')
call hhero.setBornXY(GetLocationX(Loc_JiuGuanBorn),GetLocationY(Loc_JiuGuanBorn))
call hhero.setBuildXY(GetLocationX(Loc_JiuGuan),GetLocationY(Loc_JiuGuan))
call hhero.setBuildDistance(200.00)
call hhero.buildDrunkery(chooseTime)
```

