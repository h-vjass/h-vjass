<a target="_blank" href="https://github.com/hunzsig/hJass"><h3><u>hJass（下载）</u></h3></a>
<a target="_blank" href="https://www.hunzsig.org/home/download/dom"><h3><u>vJass教程（下载）</u></h3></a>
<pre>

 * author hunzsig
 * version v2.18

*使用hJass的优势？
hJass拥有优秀的demo，在开源的同时引导您学习的更多。
hJass完全独立，不依赖任何游戏平台（如JAPI）
包含多样丰富的属性系统，可以轻松做出平时难以甚至不能做出的地图效果。
内置多达50种以上的自定义事件，轻松实现神奇的主动和被动效果。
多达12格的物品合成，免去自行编写的困惑。丰富的自定义技能模板！
镜头、单位组、过滤器、背景音乐、天气等也应有尽有。

提醒：
#调用hJass需要支持vJass的编辑器，如YDWE等
#如果保存报错，请关闭YDWE>YDWE配置>智能判断注入代码，或者自行寻找冲突代码，修改解决
#如果hevt无法获取数据，请关闭YDWE>YDWE配置>脚本优化，由于部分YDWE版本采用外嵌触发的方式来解决内联问题，可能会引起错误
#本套代码免费提供给了解Jass/vJass的作者试用，如果不了解Jass/vJass请使用T来制作地图或自行学习，此处不提供jass教学
#当然即使你完全不懂jass也可以去https://www.hunzsig.org学习

*以下教程以YDWE为例*
好了，让我们开始接入：
#打开YDWE 打开地图 按F4打开触发编辑器
#在最上方第一的位置添加一个【新触发】
#选中新建的触发点击菜单【编辑】将他转为自定义文本

如下

function Trig_[YOUR_TRIGGER]_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_[YOUR_TRIGGER] takes nothing returns nothing
set gg_trg_[YOUR_TRIGGER] = CreateTrigger(  )
call TriggerAddAction( gg_trg_[YOUR_TRIGGER], function Trig_[YOUR_TRIGGER]_Actions )
endfunction

#这些默认的function都是没有用的，将他们全部删除，留下一个[空白的文本区]

#在文本区顶部include hJass的根目录文件hJass.j,注意相对路径要正确，以你的【YDWE.exe】相对的目录为准
    （不建议路径存在有中文）

#include "[YOUR_DIR]/hJass/hJass.j"

#如果此时你已经完成上述步骤
那么文本区内现在应该是这样的：

#include "[YOUR_DIR]/hJass/hJass.j"


#保存地图查看是否出错，如果没有出错则hJass库添加成功

以上仅为添加hJass，而在制作地图的实践中，你应该是建立自己的main文件来引用hJass（如可参考目录中的hMain.j）
那么文本区内现在应该改为这样的：

#include "[YOUR_DIR]/hJass/hMain.j"

注意：
hJass库开源，不定时更新，可访问 https://www.hunzsig.org 查看下载最新版
hJass库仅仅提供一些功能函数协助做图作者更加轻松制作地图
hJass库不保证完全正确无bug，高效率，所以如有需要，请自行修改源码进行游戏制作，这里不过是给出一种方式
hJass库中lib-attribute*系列方法是一套属性系统，如不使用请关闭，如果使用，请根据演示demo地图查看对应的属性设置方法
hJass建议直接使用demo.w3x作为模板开发您的地图，当然你也可以自己建立，但要注意的事，你需要在F12引入ui文件夹的所有文件，并修改好路径如下：
文件 -> 自定义路径
boold2.blp -> boold2.blp
CommandFunc.txt -> units\CommandFunc.txt 
war3mapMisc.txt -> war3mapMisc.txt
war3mapskin.txt -> war3mapskin.txt
同时你必须创建系统所需要的所有技能及物品模板，详情请查看hJass.demo，由于自主过程十分繁琐，强烈建议使用demo.w3x进行二次开发

常见问题
*初始化的触发绝对不能勾选中【地图初始化时运行】否则游戏流程不会顺利执行
*如果你在大地图面板上放置了【固定的单位】，又希望在jass文件中调用他,请创建编辑器默认的全局变量记录并调用,否则可能无法调用
*如果你在大地图面板上放置了【矩形区域】，又希望在jass文件中调用他,请创建编辑器默认的全局变量记录并调用,否则可能无法调用
*默认采用了镜头缩放的方式来实现移动速度翻倍，可以在hJass.j文件中自行决定是否使用，如果使用请注意设定模型大小为原来50%，如果不使用，则移动速度不翻倍与平衡常数一致
</pre>