local L = LibStub('AceLocale-3.0'):NewLocale('ChoreTracker', 'zhCN')
if not L then return end

L['key_binding:toggle'] = '切换 ChoreTracker 窗口'

L['option:appearance'] = '外观'
L['option:appearance:backgroundColor'] = '背景颜色'
L['option:appearance:borderColor'] = '边框颜色'
L['option:appearance:strata'] = '框体层级'

L['option:bulkActions'] = '批量操作'
L['option:bulkActions:dragonflightDisable'] = '禁用巨龙时代的所有任务事项'
L['option:bulkActions:dragonflightEnable'] = '启用巨龙时代的所有任务事项'

L['option:display'] = '显示'
L['option:display:awakenedTimers'] = '仅显示正在进行中的计时器'
L['option:display:showCompletedSections'] = '显示已完成的分类'
L['option:display:showCompleted'] = '显示完成的任务事项'
L['option:display:showObjectives'] = '显示任务目标'
L['option:display:statusIcons'] = '使用状态图示'

L['option:text'] = '文本'
L['option:text:font'] = '字体'
L['option:text:fontSize'] = '字体大小'
L['option:text:fontStyle'] = '字体样式'

L['section:chores'] = '任务事项'
L['section:drops'] = '掉落'
L['section:events'] = '事件'
L['section:professions'] = '专业'
L['section:quests'] = '任务'
L['section:timers'] = '时间'

L['category:catchAndRelease'] = '捉放鱼'
L['category:dailies'] = '日常任务'
L['category:event'] = '事件'
L['category:holidays'] = '假日活動'
L['category:holidays2'] = '節日'
L['category:limited'] = '限时活动'
L['category:patch_10_0_0'] = 'Patch 10.0.0'
L['category:patch_10_0_5'] = 'Patch 10.0.5'
L['category:patch_10_0_7'] = 'Patch 10.0.7'
L['category:patch_10_1_0'] = 'Patch 10.1.0'
L['category:patch_10_1_5'] = 'Patch 10.1.5'
L['category:patch_10_1_7'] = 'Patch 10.1.7'
L['category:patch_10_2_0'] = 'Patch 10.2.0'
L['category:patch_10_2_5'] = 'Patch 10.2.5'
L['category:patch_11_0_0'] = 'Patch 11.0.0'
L['category:pvpBrawls'] = 'PvP 乱斗'
L['category:worldBosses'] = '世界首领'

L['chore:warWithin:patch_11_0_0:quests:awakeningTheMachine'] = '主机觉醒'
L['chore:warWithin:patch_11_0_0:quests:delveKeys'] = '地下堡钥匙'
L['chore:warWithin:patch_11_0_0:quests:dungeon'] = '地下城'
L['chore:warWithin:patch_11_0_0:quests:rollinDown'] = '滚滚深邃都是蜡'
L['chore:warWithin:patch_11_0_0:quests:sparksOfWar'] = '战争火花'
L['chore:warWithin:patch_11_0_0:quests:spiderPact'] = '蜘蛛合约'
L['chore:warWithin:patch_11_0_0:quests:spiderWeekly'] = '蜘蛛周常'
L['chore:warWithin:patch_11_0_0:quests:spreadingTheLight'] = '散布圣光'
L['chore:warWithin:patch_11_0_0:quests:theaterTroupe'] = '剧场巡演'
L['chore:warWithin:patch_11_0_0:quests:worldsoul'] = '世界之魂'

L['chore:dragonflight:catchAndRelease:quests:releaseAileron'] = '副翼海蛾鱼'
L['chore:dragonflight:catchAndRelease:quests:releaseCerulean'] = '天蓝刺皮鱼'
L['chore:dragonflight:catchAndRelease:quests:releaseIslefin'] = '岛鳍剑鱼'
L['chore:dragonflight:catchAndRelease:quests:releaseScalebelly'] = '鳞腹鲭鱼'
L['chore:dragonflight:catchAndRelease:quests:releaseTemporal'] = '时光龙头鱼'
L['chore:dragonflight:catchAndRelease:quests:releaseThousandbite'] = '千噬水虎鱼'

L['chore:dragonflight:patch_10_2_5:quests:bigDig'] = '盛大挖掘'

L['chore:dragonflight:patch_10_2_0:quests:aWorthyAlly'] = '强大的盟友'
L['chore:dragonflight:patch_10_2_0:quests:bloomingDreamseeds'] = '种值种子'
L['chore:dragonflight:patch_10_2_0:quests:superbloom'] = '超然盛放'
L['chore:dragonflight:patch_10_2_0:quests:shipments1'] = '运送 x1'
L['chore:dragonflight:patch_10_2_0:quests:shipments5'] = '运送 x5'

L['chore:dragonflight:patch_10_1_7:quests:dreamsurge'] = '塑造梦涌'

L['chore:dragonflight:patch_10_1_5:quests:timeRift'] = '时光裂隙'
L['chore:dragonflight:patch_10_1_5:quests:timeRiftAccount'] = '时光裂隙（帐号） '

L['chore:dragonflight:patch_10_1_0:drops:sniffenseeking'] = '嗅味探寻'
L['chore:dragonflight:patch_10_1_0:quests:aWorthyAlly'] = '强大的盟友'
L['chore:dragonflight:patch_10_1_0:quests:barter'] = '交易'
L['chore:dragonflight:patch_10_1_0:quests:fyrakkAssault'] = '菲莱克：突袭'
L['chore:dragonflight:patch_10_1_0:quests:fyrakkDisciple'] = '菲莱克：首领'
L['chore:dragonflight:patch_10_1_0:quests:fyrakkShipment'] = '菲莱克：宝箱'

L['chore:dragonflight:patch_10_0_5:quests:primalistFuture'] = '拜荒者的未来'

L['chore:dragonflight:patch_10_0_0:quests:communityFeast'] = '社区盛宴'
L['chore:dragonflight:patch_10_0_0:quests:dragonAllegiance'] = '忠诚为一'
L['chore:dragonflight:patch_10_0_0:quests:dragonKey'] = '合成钥匙'
L['chore:dragonflight:patch_10_0_0:quests:dragonbaneKeep'] = '灭龙要塞'
L['chore:dragonflight:patch_10_0_0:quests:grandHuntUncommon'] = '洪荒狩猎：优秀'
L['chore:dragonflight:patch_10_0_0:quests:grandHuntRare'] = '洪荒狩猎：精良'
L['chore:dragonflight:patch_10_0_0:quests:grandHuntEpic'] = '洪荒狩猎：史诗'
L['chore:dragonflight:patch_10_0_0:quests:heroicDungeons'] = '英雄地下城'
L['chore:dragonflight:patch_10_0_0:quests:showYourMettle'] = '勇气之证'

L['chore:events:holidays:quests:arenaSkirmishes'] = '竞技场练习赛'
L['chore:events:holidays:quests:battlegrounds'] = '战场'
L['chore:events:holidays:quests:mythicDungeons'] = '史诗地下城'
L['chore:events:holidays:quests:pvpPetBattles'] = '宠物战斗 PvP'
L['chore:events:holidays:quests:timewalkingDungeons'] = '时空漫游地下城'
L['chore:events:holidays:quests:timewalkingRaids'] = '时空漫游团队'
L['chore:events:holidays:quests:timewalkingTurnIn'] = '时空漫游任务'
L['chore:events:holidays:quests:worldQuests'] = '世界任务'

L['chore:events:holidays2:dungeons:corenDirebrew'] = '科林・烈酒'
L['chore:events:holidays2:dungeons:crownChemicalCo'] = '王皇冠药剂公司'
L['chore:events:holidays2:dungeons:headlessHorseman'] = '无头骑士'
L['chore:events:holidays2:dungeons:frostLordAhune'] = '冰霜之王埃霍恩'
L['chore:events:holidays2:quests:meanOne'] = '被偷走的礼品'

L['chore:events:pvpBrawls:quests:arathiBlizzard'] = '阿拉希暴风雪'
L['chore:events:pvpBrawls:quests:classicAshran'] = '经典阿什兰'
L['chore:events:pvpBrawls:quests:compStomp'] = '阿拉希人机对决'
L['chore:events:pvpBrawls:quests:cookingImpossible'] = '碟中碟'
L['chore:events:pvpBrawls:quests:deepSix'] = '六人战'
L['chore:events:pvpBrawls:quests:deepwindDunk'] = '深风大灌篮'
L['chore:events:pvpBrawls:quests:gravityLapse'] = '引力失效'
L['chore:events:pvpBrawls:quests:packedHouse'] = '爆棚乱战'
L['chore:events:pvpBrawls:quests:shadoPanShowdown'] = '决战影踪派'
L['chore:events:pvpBrawls:quests:southshoreVsTarrenMill'] = '南海镇VS塔伦米尔'
L['chore:events:pvpBrawls:quests:templeOfHotmogu'] = '魔古接力'
L['chore:events:pvpBrawls:quests:warsongScramble'] = '战歌争夺战'

L['chore:professions:warWithin:drops:gather'] = '采集'
L['chore:professions:warWithin:drops:mob/treasure'] = '怪物/宝藏'

L['chore:professions:warWithin:quests:orders'] = '订单'
L['chore:professions:warWithin:quests:task'] = '工作'
L['chore:professions:warWithin:quests:treatise'] = '论述'

L['chore:professions:dragonflight:drops:forbiddenReach'] = '禁忌离岛'
L['chore:professions:dragonflight:drops:gather'] = '採集'
L['chore:professions:dragonflight:drops:mob'] = '怪物'
L['chore:professions:dragonflight:drops:treasure'] = '寶藏'

L['chore:professions:dragonflight:quests:orders'] = '订单'
L['chore:professions:dragonflight:quests:provide'] = '供应'
L['chore:professions:dragonflight:quests:task'] = '工作'
L['chore:professions:dragonflight:quests:treatise'] = '论述'

L['chore:professions:dragonflight:quests:skinMagmaCobra'] = 'Skin Magma Cobra'
L['chore:professions:dragonflight:quests:skinVerdantGladewarden'] = 'Skin Verdant Gladewarden'

L['chore:professions:event:quests:darkmoonFaire'] = '暗月马戏团'

L['timer:beledarsShadow'] = "贝雷达尔之影"
L['timer:theaterTroupe'] = '剧场巡演'

L['timer:bigDig'] = '盛大挖掘'
L['timer:communityFeast'] = '社区盛宴'
L['timer:dragonbaneKeep'] = '灭龙要赛'
L['timer:dreamsurge'] = '梦涌'
L['timer:researchersUnderFire'] = '研究员遇袭'
L['timer:superbloom'] = '超然盛放'
L['timer:timeRift'] = '时空裂隙'

L['objective:defeat_x'] = '击败 %s'

L['choose_quest'] = '选择一个任务！'

L['questName:80544'] = '纺丝者'
L['questName:80545'] = '将军'
L['questName:80546'] = '宰相'

L['missing_skill_level'] = '|cFFFF00FF开启专业窗口！|r'
