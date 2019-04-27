```
|- h-vjass.j - 入口文件，你的main文件需要包含它
|- hSync.j - 同步方法，处理无法暂停的功能（结构体内不得暂停）
|- hMain.j - 一个简单例子，在F4中include这个main文件。而main需要包含h-vjass.j
|- hTest.j - 测试代码之一
|- demo.w3x - *仅供参考，最好直接拿 “ 实践时空之轮TD ” 二次开发
|- lib - 功能库
    |- abstract - 加载功能库其他功能模块
    |- ability - 基础技能
    |- attrbuteIds - 基础属性用到的物编技能ID
    |- attrbute - 基础/拓展属性系统，攻击护甲移动暴击韧性等
    |- attrbuteEffect - 伤害特效属性系统
    |- attrbuteNatural - 自然属性系统
    |- attrbuteHunt - 伤害系统
    |- attrbuteUnit - 单位与属性系统关联模块
    |- award - 奖励模块，用于控制玩家的黄金木头经验
    |- camera - 镜头模块，用于控制玩家镜头
    |- console - 简单调试打印模块
    |- dzapi - 一个重构dzapi的例子，实际上你可以直接调用Dz无需重构
    |- effect - 特效模块
    |- effectString - 一些常用不错的特效串（可以直接在effect中使用字符串而忽略这个）
    |- enemy - 敌人模块，用于设定敌人玩家，自动分配单位
    |- env - 环境模块，可随机为区域生成装饰物及地表纹理
    |- event - 事件模块，自定义事件，包括物品合成分拆/暴击，精确攻击捕捉等
    |- filter - 组过滤器，主要用于单位组条件
    |- group - 单位组
    |- hero - 英雄/选英雄模块，包含点击/酒馆选择，repick/random功能等
    |- is - 判断模块 * 常用
    |- item - 物品模块，与属性系统无缝结合，合成/分拆等功能
    |- itemMix - 物品合成子模块
    |- lightning - 闪电链
    |- logic - 逻辑模块
    |- mark - 遮罩模块
    |- media - 声音模块
    |- message - 消息/漂浮字模块
    |- multiboard - 多面板，包含自带的属性系统
    |- player - 玩家
    |- rect - 区域
    |- skill - 高级技能
    |- time - 时间/计时器 * 常用
    |- unit - 单位
    |- weather - 天气
```
