
//载入 lib
/**
 * 地形贴图 8 个白杨谷 5个城邦 3个达拉然
 * 雪地 Agrs Xbtl Xblm
 * 火炎 Yblm Ywmb
 * 城砖 Arck Alvd Ybtl
 * 荒地 Adrt Adrd
 */
#include "lib/abstract.j"
#include "hSync.j"

library hJass initializer init needs hSync

	private function init takes nothing returns nothing
		local string txt = null
		//哈希表初始化
		call FlushParentHashtable( hash_ability )
		call FlushParentHashtable( hash_skill )
		call FlushParentHashtable( hash_attr )
		call FlushParentHashtable( hash_attr_effect)
		call FlushParentHashtable( hash_attr_natural )
		call FlushParentHashtable( hash_attr_unit )
		call FlushParentHashtable( hash_trigger_register )
		call FlushParentHashtable( hash_trigger )
		call FlushParentHashtable( hash_item )
		call FlushParentHashtable( hash_item_mix )
		call FlushParentHashtable( hash_hmsg )
		call FlushParentHashtable( hash_player )
		call FlushParentHashtable( hash_hrect )
		call FlushParentHashtable( hash_unit )
		call FlushParentHashtable( hash_time )
		call FlushParentHashtable( hash_weather )
		call FlushParentHashtable( hash_hlogic )
		call FlushParentHashtable( hash_hmb )
		call FlushParentHashtable( hash_hero )
		set hash_ability = InitHashtable()
		set hash_skill = InitHashtable()
		set hash_attr = InitHashtable()
		set hash_attr_effect = InitHashtable()
		set hash_attr_natural = InitHashtable()
		set hash_attr_unit = InitHashtable()
		set hash_trigger_register = InitHashtable()
		set hash_trigger = InitHashtable()
		set hash_item = InitHashtable()
		set hash_item_mix = InitHashtable()
		set hash_hmsg = InitHashtable()
		set hash_player = InitHashtable()
		set hash_hrect = InitHashtable()
		set hash_unit = InitHashtable()
		set hash_time = InitHashtable()
		set hash_weather = InitHashtable()
		set hash_hlogic = InitHashtable()
		set hash_hmb = InitHashtable()
		set hash_hero = InitHashtable()
		//系统初始化
		set his = hIs.create()
		set htime = hTime.create()
		set hlogic = hLogic.create()
		set hxy = hXY.create()
		set hconsole = hConsole.create()
		set hmedia = hMedia.create()
		set hcamera = hCamera.create()
		set haward = hAward.create()
		set hevt = hEvt.create()
		set hattr = hAttr.create()
		set hattrEffect = hAttrEffect.create()
		set hattrNatural = hAttrNatural.create()
		set hattrHunt = hAttrHunt.create()
		set hattrUnit = hAttrUnit.create()
		set hmb = hMultiboard.create()
		set heffect = hEffect.create()
		set hlightning = hLightning.create()
		set hrect = hRect.create()
		set hunit = hUnit.create()
		set hgroup = hGroup.create()
		set hmsg = hMsg.create()
		set hmark = hMark.create()
		set hplayer = hPlayer.create()
		set hweather = hWeather.create()
		set hability = hAbility.create()
		set hskill = hSkill.create()
		set hitem = hItem.create()
		set hitemMix = hItemMix.create()
		set hhero = hHero.create()
		set hempty = hEmpty.create()
		set henv = hEnv.create()
		//initset
		call hplayer.initSet()
		call hattrUnit.initSet()
		call hmb.initSet()
		call hitem.initSet()

		//hJass 系统提醒（F9任务）
		set txt = ""
		set txt = txt + "hJass完全独立，不依赖任何游戏平台（如YDWE、JAPI、DzApi,但支持你额外使用）"
		set txt = txt + "|n包含多样丰富的属性系统，可以轻松做出平时难以甚至不能做出的地图效果"
		set txt = txt + "|n内置多达几十种以上的自定义事件，轻松实现神奇的主动和被动效果"
		set txt = txt + "|n自带物品合成，免去自行编写的困惑。丰富的自定义技能模板"
		set txt = txt + "|n镜头、单位组、过滤器、背景音乐、天气等也应有尽有"
		set txt = txt + "|n想要了解更多，官方QQ群 325338043 官网教程 hjass.hunzsig.org"
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "hJass",txt, "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
		set txt = ""
		set txt = txt + "-random 随机选择"
		set txt = txt + "|n-repick 重新选择"
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "hJass选择英雄指令",txt, "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
		set txt = ""
		set txt = txt + "-mbap 查看所有玩家统计"
		set txt = txt + "|n-mbme 查看你的个人实时状态"
		set txt = txt + "|n-mbsa 查看双击锁定单位的基本属性"
		set txt = txt + "|n-mbse 查看双击锁定单位的特效属性"
		set txt = txt + "|n-mbsn 查看双击锁定单位的自然属性"
		set txt = txt + "|n-mbsi 查看双击锁定单位的物品"
		set txt = txt + "|n-mbh 隐藏面板"
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "如何使用hJass多面板",txt, "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
		set txt = ""
		set txt = txt + "-apc 设定是否自动转换黄金为木头"
		set txt = txt + "|n获得黄金超过100万时，自动按照比率转换多余的部分为木头"
		set txt = txt + "|n如果超过时没有开启，会寄存下来，待开启再转换(上限1000万)"
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "设定自动转金为木",txt, "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
		set txt = ""
		set txt = txt + "-lsr 设定生命源"
		set txt = txt + "-msr 设定魔法源"
		set txt = txt + "|n生命、魔法源可在当前量少于设定比例时，在 10秒 内尽可能地恢复生命或者魔法"
		set txt = txt + "|n输入即可选择生命、魔法源的自动恢复触发比例 如 -lsr 10、-msr 10"
		set txt = txt + "|n当源耗尽时，可以选择物品补充，而源力本身每隔 25秒 恢复 300点 能量"
		call CreateQuestBJ( bj_QUESTTYPE_OPT_DISCOVERED, "设定生命、魔法源自动比例",txt, "ReplaceableTextures\\CommandButtons\\BTNTomeOfRetraining.blp" )
		
		set txt = null
    endfunction

endlibrary
//最后一行必须留空请勿修改
