time例子

---

* **创建 1 个一次性计时器**
```
private static method testAction takes nothing returns nothing
    //这是一个5秒后执行一次计时器回调函数
    local timer t = GetExpiredTimer()
endmethod
private static method test takes nothing returns nothing
    local timer t = htime.setTimeout( 5.00 ,function thistype.timerAction )
endmethod
```

* **创建 1 个循环计时器**
```
private static method testAction takes nothing returns nothing
    //这是一个每过1秒执行一次的计时器回调函数
    local timer t = GetExpiredTimer()
endmethod
private static method test takes nothing returns nothing
    local timer t = htime.setInterval( 1.00 ,function thistype.testAction )
endmethod
```

* **计时器回调传参**
```
private static function testAction takes nothing returns nothing
    //这是一个每过 2.33 秒执行一次的计时器回调函数
    local timer t = GetExpiredTimer()
    local real paramReal = htime.getReal( t , 1 ) //10.0
    local integer paramInt = htime.getInt( t , 2 ) //50
    local string paramStr = htime.getString( t , 3 ) //字符串一个
    local unit paramUnit = htime.getUnit( t , 4 ) //实例 H001
endmethod
private static method test takes nothing returns nothing
    local real paramReal = 10.0
    local integer paramInt = 50
    local string paramStr = "字符串一个"
    local unit paramUnit = hunit.createUnit('H001')
    local timer t = htime.setInterval( 2.33 ,function thistype.testAction )
    call htime.setReal( t , 1 , paramReal)
    call htime.setInt( t , 2 , paramInt )
    call htime.setString( t , 3 , paramStr )
    call htime.setUnit( t , 4 , paramUnit )
endmethod
```

