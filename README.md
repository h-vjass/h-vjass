 * [gitlab网址](https://github.com/hunzsig/h-vjass)
 * [最佳实践：时空之轮TD](https://github.com/hunzsig/h-war3/tree/master/w3xMaps/hyperSpaceTD)
 * [h-vjass技术文档](http://hvjass.book.hunzsig.org)
 * author hunzsig
 * version v20190406

# 使用优势？
v-vjass拥有优秀的demo，在开源的同时引导您学习的更多。
v-vjass完全独立，不依赖任何游戏平台（如JAPI）
包含多样丰富的属性系统，可以轻松做出平时难以甚至不能做出的地图效果。
内置多达50种以上的自定义事件，轻松实现神奇的主动和被动效果。
多达12格的物品合成，免去自行编写的困惑。丰富的自定义技能模板！
镜头、单位组、过滤器、背景音乐、天气等也应有尽有。
#### 框架结构如下：
```
    ├── h-vjass.j - 入口文件，你的main文件需要包含它
    ├── hSync.j - 同步方法，处理无法暂停的功能（结构体内不得暂停）
    ├── hMain.j - 一个简单例子，在F4中include这个main文件。而main需要包含h-vjass.j
    ├── hTest.j - 测试代码之一
    ├── demo.w3x - *仅供参考，最好直接拿 “ 实践时空之轮TD ” 二次开发
    └── lib
        ├── abstract - 加载其他功能模块
        ├── ability - 基础技能
        ├── attrbuteIds - 基础属性用到的物编技能ID
        ├── attrbute - 基础/拓展属性系统，攻击护甲移动暴击韧性等
        ├── attrbuteEffect - 伤害特效属性系统
        ├── attrbuteNatural - 自然属性系统
        ├── attrbuteHunt - 伤害系统
        ├── attrbuteUnit - 单位与属性系统关联模块
        ├── award - 奖励模块，用于控制玩家的黄金木头经验
        ├── camera - 镜头模块，用于控制玩家镜头
        ├── console - 简单调试打印模块
        ├── dzapi - 一个重构dzapi的例子，实际上你可以直接调用Dz无需重构
        ├── effect - 特效模块
        ├── effectString - 一些常用不错的特效串（可以直接在effect中使用字符串而忽略这个）
        ├── enemy - 敌人模块，用于设定敌人玩家，自动分配单位
        ├── env - 环境模块，可随机为区域生成装饰物及地表纹理
        ├── event - 事件模块，自定义事件，包括物品合成分拆/暴击，精确攻击捕捉等
        ├── filter - 组过滤器，主要用于单位组条件
        ├── group - 单位组
        ├── hero - 英雄/选英雄模块，包含点击/酒馆选择，repick/random功能等
        ├── is - 判断模块 * 常用
        ├── item - 物品模块，与属性系统无缝结合，合成/分拆等功能
        ├── itemMix - 物品合成子模块
        ├── lightning - 闪电链
        ├── logic - 逻辑模块
        ├── mark - 遮罩模块
        ├── media - 声音模块
        ├── message - 消息/漂浮字模块
        ├── multiboard - 多面板，包含自带的属性系统
        ├── player - 玩家
        ├── rect - 区域
        ├── skill - 高级技能
        ├── time - 时间/计时器 * 常用
        ├── unit - 单位
        └── weather - 天气
```

提醒：
### 本套代码免费提供给了解Jass/vJass的作者试用，如果不了解Jass/vJass请使用T来制作地图或自行学习，此处不提供jass教学
### 当然即使你完全不懂jass也可以去 [vJass教程](https://github.com/hunzsig/h-war3/tree/master/learn/vJass%E7%B3%BB%E5%88%97%E6%95%99%E7%A8%8B) 学习

> 以下教程以YDWE为例
## 前期准备：
### 关闭YWDE的 逆天触发 
> 会使得某些原生方法胡乱添加YDWE前缀

## 好了，让我们开始接入：
### 打开YDWE 打开地图 按F4打开触发编辑器
### 在最上方第一的位置添加一个【新触发】
### 选中新建的触发点击菜单【编辑】将他转为自定义文本，如下：
```
function Trig_[YOUR_TRIGGER]_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_[YOUR_TRIGGER] takes nothing returns nothing
set gg_trg_[YOUR_TRIGGER] = CreateTrigger(  )
call TriggerAddAction( gg_trg_[YOUR_TRIGGER], function Trig_[YOUR_TRIGGER]_Actions )
endfunction
```

### 这些默认的function都是没有用的，将他们全部删除，留下一个[空白的文本区]
### 在文本区顶部 *include* h-vjass的根目录文件h-vjass.j,注意相对路径要正确，以你的【YDWE.exe】相对的目录为准
##### （不建议路径存在有中文）
### 如果此时你已经完成上述步骤，那么文本区内现在应该是这样的：
```
include "[relatively_path]/h-vjass/h-vjass.j"
```


# 保存地图查看是否出错，如果没有出错则v-vjass库添加成功

以上仅为添加v-vjass，而在制作地图的实践中，你应该是建立自己的main文件来引用v-vjass（如可参考目录中的hMain.j）
那么文本区内现在应该改为这样的：
```
include "[relatively_path]/h-vjass/hMain.j"
```

```
注意：
h-vjass库开源，不定时更新，可访问 https://www.hunzsig.org 查看下载最新版
h-vjass库仅仅提供一些功能函数协助做图作者更加轻松制作地图
h-vjass库不保证完全正确无bug，高效率，所以如有需要，请自行修改源码进行游戏制作，这里不过是给出一种方式
h-vjass库中lib/attribute*系列方法是一套属性系统，如不使用请关闭，如果使用，请根据演示demo地图查看对应的属性设置方法
建议直接使用demo.w3x作为模板开发您的地图，当然你也可以自己建立，但要注意的事，你需要在F12引入ui文件夹的所有文件，并修改好路径如下：
文件 -> 自定义路径
boold2.blp -> boold2.blp
CommandFunc.txt -> units\CommandFunc.txt 
war3mapMisc.txt -> war3mapMisc.txt
war3mapskin.txt -> war3mapskin.txt
同时你必须创建系统所需要的所有技能及物品模板，详情请查看demo，由于自主过程十分繁琐，强烈建议使用demo.w3x进行二次开发
```

