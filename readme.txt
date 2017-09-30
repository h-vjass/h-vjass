/**
 * author hunzsig
 * version v2.03
 * date 2017-09-25
 **/

提醒：
#hJass参考文档：https://www.hunzsig.org/home/war3/hJass_dom
#调用hJass需要支持vJass的编辑器，如YDWE等
#如果保存报错，请关闭YDWE——YDWE配置——智能判断注入代码，或者自行寻找冲突代码，修改解决
#本套代码免费提供给熟悉jass的作者使用，如果不熟悉jass请使用T来制作地图或自行学习，此处不提供jass教学

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

#在文本区顶部include hJass的根目录文件hJass.j,注意相对路径要正确，以你的【YDWE.exe】相对的目录为准（不建议路径存在有中文）

	#include "[YOUR_DIR]/hJass/hJass.j"

#如果此时你已经完成上述步骤
那么文本区内现在应该是这样的：

	#include "[YOUR_DIR]/hJass/hJass.j"


#保存地图查看是否出错，如果没有出错则hJjass库添加成功

注意：
hJass库开源，不定时更新，可访问 https://www.hunzsig.org 查看下载最新版
hJass库仅仅提供一些功能函数协助做图作者更加轻松制作地图
hJass库不保证完全正确，效率问题，所以如有需要，请自行修改源码进行游戏制作
hJass库中funcs-attribute系列方法是一套属性系统，如不使用请关闭，如果使用，请根据演示demo地图查看对应的属性设置方法
hJass建议直接使用demo.w3x作为模板开发您的地图，当然你也可以自己建立

常见问题
*初始化的触发绝对不能勾选中【地图初始化时运行】否则游戏流程不会顺利执行
*如果你在大地图面板上放置了【固定的单位】，又希望在jass文件中调用他,请创建编辑器默认的全局变量记录并调用,否则可能无法调用
*如果你在大地图面板上放置了【矩形区域】，又希望在jass文件中调用他,请创建编辑器默认的全局变量记录并调用,否则可能无法调用

