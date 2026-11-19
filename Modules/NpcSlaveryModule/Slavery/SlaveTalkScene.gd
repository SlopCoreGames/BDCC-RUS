extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter
var resultText = ""

var savedWantedToDo = ""
var savedWantedToDoName = ""
var savedWantedToDoArgs = []
var savedButtonChecks = []
var slaveResistedSuc = false
var activeResistType = ""

var lastActionID = ""

func _init():
	sceneID = "SlaveTalkScene"

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)
	
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		aimCameraAndSetLocName(GM.pc.getLocation())
		addCharacter(npcID)
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery == null):
			saynn("Что-то пошло не так")
			addButton("Назад", "Взаимодействий достаточно", "endthescene")
			return
		npcSlavery.checklevelUp()
		
		if(npcSlavery.isDoingActivity()):
			var activity:SlaveActivityBase = npcSlavery.getActivity()
			
			var animInfo = activity.getCustomInteractAnimInfo()
			if(animInfo != null):
				playAnimation(animInfo[0], animInfo[1], animInfo[2])
			else:
				playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
			
			if(activity.preventsNormalInteractions()):
				addButtonAt(14, "Back", "Enough interactions", "endthescene")

				saynn(activity.getActivityText())
				
				addActivityButtons()
				return
		elif(GM.main.IS.hasPawn(npc.getID())):
			playAnimation(StageScene.Solo, "stand")
			
			saynn("{npc.name} бродит где-то по тюрьме... Подожди, пока {npc.he} {npc.verb('return')}.")
			addButtonAt(14, "Back", "Enough interactions", "endthescene")
			return
		else:
			playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		
		saynn(npc.getName()+" — это уровень "+str(npcSlavery.slaveLevel)+" {npc.slave} ("+npcSlavery.getExperienceStr()+" опыта)")
		#saynn("{npc.He} {npc.isAre} стоит неподвижно, {npc.his} ошейник привязан к полу.")
		saynn(npcSlavery.getPerfectIdleMessage())
		
		if(!npcSlavery.isMindBroken()):
			if(npcSlavery.getDespair() > 0.5):
				saynn("{npc.name} в депрессии. Идеально, чтобы сломить дух {npc.his}, но если продолжать в том же духе, это может привести к тому, что {npc.him} сорвется.")
			elif(npcSlavery.getDespair() > 0.8):
				saynn("[b]{npc.name} выглядит крайне подавленным.[/b] {npc.He} {npc.isAre} на грани срыва.")
			
			if(npcSlavery.getWorkEfficiency() < 0.2):
				saynn("{npc.name} выглядит очень уставшим.")
			
			if(npcSlavery.getObedience() < 0.9 && npc.getInventory().hasRemovableRestraints()):
				var restraintAmount = npc.getInventory().getEquppedRemovableRestraints().size()
				if(restraintAmount > 0):
					if(npcSlavery.getAwareness() < 0.8):
						saynn("{npc.He} {npc.isAre} носит "+str(restraintAmount)+" restraint"+("s" if restraintAmount != 1 else "")+" что поможет {npc.him} осознать свое место рядом с {npc.his}.")
					else:
						saynn("{npc.He} {npc.isAre} носит "+str(restraintAmount)+" restraint"+("s" if restraintAmount != 1 else "")+" что помогает напоминать {npc.him} о {npc.his} месте.")
			
			saynn("{npc.name} "+npcSlavery.getRewardBalanceString())
		
		if(getFlag("NpcSlaveryModule.debugSlaveInfo", false)):
			sayn("[b]ИНФОРМАЦИЯ ДЛЯ ОТЛАДКИ:[/b]")
			saynn(npcSlavery.getDebugInfo())
		elif(npc.getInventory().hasEquippedItemWithTag(ItemTag.Hypnovisor)):
			sayn("Гипновизор позволяет читать мысли {npc.name}!")
			sayn("[b]Инфо о гипновизоре:[/b]")
			saynn(npcSlavery.getMindreaderInfo())
			
#		if(false):
#			sayn("[b]Личность:[/b]")
#			var personality: Personality = npc.getPersonality()
#			if(personality != null):
#				var texts = []
#				for statID in PersonalityStat.getAll():
#					var value = personality.getStat(statID)
#					var statName = PersonalityStat.getVisibleName(statID)
#					var statValue = PersonalityStat.getVisibleDesc(statID, value)
#
#					texts.append(statName+": "+statValue)
#				saynn(Util.join(texts, "\n"))
		
		sayn("[b]Навыки:[/b]")
		for skillID in npcSlavery.slaveSpecializations:
			var slaveType:SlaveTypeBase = GlobalRegistry.getSlaveType(skillID)
			if(slaveType == null):
				continue
			var gradeLetter = npcSlavery.rankToLetter(npcSlavery.slaveSpecializations[skillID])
			
			sayn(""+slaveType.getVisibleName()+": "+gradeLetter)
		sayn("")
		
		if(npcSlavery.isReadyToBeLeveledUp()):
			sayn("Чтобы повысить уровень {npc.name} до уровня рабыни "+str(npcSlavery.getLevel()+1)+", заставьте {npc.him} испытать следующее:")
			sayn(npcSlavery.getLevelUpHintText())
			saynn("Повышение уровня рабыни облегчает тренировки {npc.him} и открывает новые действия.")
		
		addButtonAt(12, "Leash", "Leash your slave and see what you can with them around the station", "start_walkies")
		addButtonWithChecksAt(13, "Forced sex" if npcSlavery.isActivelyResisting() else "Sex", "Start sex with your slave", "do_forced_sex", [], [ButtonChecks.CanStartSex])
		addButtonAt(14, "Back", "Enough interactions", "endthescene")
		
		addButton("Поговорить", "Сказать что-нибудь своей рабыне", "talk_menu")
		addButtonWithChecks("Тренировать", "Дрессировать рабыню", "do_train", [], [[ButtonChecks.NotLate], [ButtonChecks.NotGagged], [ButtonChecks.NotBlindfolded]])
		addButton("Награда", "Список наград", "rewards_menu")
		addButton("Наказать", "Список наказаний", "punishments_menu")
		addButton("Занятия", "Что еще можно сделать с этой рабыней", "actions_menu")
		
		if(npcSlavery.isDoingActivity()):
			var activity:SlaveActivityBase = npcSlavery.getActivity()
			
			if(!activity.preventsNormalInteractions()):
				var theText = activity.getActivityText()
				if(theText != ""):
					saynn(theText)
				addActivityButtons()
		
	if(state == "actions_menu"):
		saynn("Что вы хотите сделать со своей рабыней?")
		
		addButtonsForActionsOfType(SlaveActionBase.Action)
		addButton("Назад", "Ты передумал!", "")

	if(state == "talk_menu"):
		saynn("Что вы хотите сказать своей рабыне?")
		
		addButtonsForActionsOfType(SlaveActionBase.Talk)
		addButton("Назад", "Ты передумал!", "")

	if(state == "rewards_menu"):
		saynn("Как вы хотите наградить свою рабыню?")
		
		addButtonsForActionsOfType(SlaveActionBase.Reward)
		addButton("Назад", "Ты передумал!", "")

	if(state == "punishments_menu"):
		saynn("Как вы хотите наказать свою рабыню?")
		
		addButtonsForActionsOfType(SlaveActionBase.Punishment)
		addButton("Назад", "Ты передумал!", "")

	if(state == "do_action"):
		saynn(resultText)
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")

		var theAction:SlaveActionBase = GlobalRegistry.getSlaveAction(lastActionID)
		if(theAction != null):
			var extraActions = theAction.getExtraActions(npcID, {})
			for actionInfo in extraActions:
				var args = []
				if(actionInfo.has("args")):
					args = actionInfo["args"]
				var buttonChecks = []
				if(actionInfo.has("buttonChecks")):
					buttonChecks = actionInfo["buttonChecks"]
				addButtonWithChecks(actionInfo["name"], actionInfo["desc"], "do_extra_action", [theAction, actionInfo, args], buttonChecks)

	if(state == "do_train"):
		saynn(resultText)
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")
	
	if(state == "resisting_action"):
		saynn("Ваша рабыня отказывается подчиняться вашим приказам!")
		
		saynn("Ты всё ещё можешь заставить {npc.him}, но {npc.he}, очевидно, это не понравится.")
		
		saynn("Если хочешь, ты также можешь попытаться вбить покорность в {npc.him} с помощью побоев. Боль рождает страх. А страх — отличный мотиватор.")
		
		saynn("Или же ты можешь просто отменить то, что собирался сделать, и получить повод наказать {npc.him} вместо этого!")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		var cowardness = npcSlavery.personalityScore({PersonalityStat.Coward:1.0}) - 0.25
		var fightChance = 0.0
		if(cowardness >= 0.5):
			fightChance = 0.0
		elif(cowardness <= -0.5):
			fightChance = 15.0
		else:
			fightChance = Util.remapValue(cowardness, -0.5, 0.5, 15.0, 0.0)
		if(npc.hasBoundArms() || npc.hasBlockedHands() || npc.isBitingBlocked()):
			fightChance *= 0.3
		if(RNG.chance(fightChance)):
			addButtonWithChecks("Заставить", "Заставить их делать то, что тебе нужно, без насилия", "resist_hastofight", [], savedButtonChecks)
		else:
			addButtonWithChecks("Заставить", "Заставить их делать то, что тебе нужно, без насилия", "do_force_action", [savedWantedToDo, savedWantedToDoArgs], savedButtonChecks)
		addButton("Избить", "Заставить силой (через драку)", "resisting_start_fight")
		addButton("Отмена", "Твой раб только что заслужил наказание!", "forced_sex_let_resist", [false])
	
	if(state == "resisting_actively"):
		if(activeResistType == "resist_kick"):
			if(slaveResistedSuc):
				playAnimation(StageScene.Duo, "hurt", {npc=npcID, npcAction="kick", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб сопротивляется, когда ты пытаешься что-то сделать с {npc.him}!"+(" Might be worth it to cuff {npc.his} ankles to prevent that from happening." if RNG.chance(30) else ""))
			else:
				playAnimation(StageScene.Duo, "dodge", {npc=npcID, npcAction="kick", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб попытался пнуть тебя, но оковы {npc.his} помогли избежать удара. Тем не менее, твой раб активно сопротивляется любым твоим действиям с {npc.him}!")
		elif(activeResistType == "resist_shove"):
			if(slaveResistedSuc):
				playAnimation(StageScene.Duo, "hurt", {npc=npcID, npcAction="shove", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб отталкивает тебя, когда ты пытаешься что-то сделать с {npc.him}!"+(" Might be worth it to cuff {npc.his} wrists to prevent that from happening." if RNG.chance(30) else ""))
			else:
				playAnimation(StageScene.Duo, "dodge", {npc=npcID, npcAction="shove", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб попытался оттолкнуть тебя, но {npc.his} удерживают его от этого. Тем не менее, раб активно сопротивляется любым твоим действиям с {npc.him}!")
		elif(activeResistType == "resist_scratch"):
			if(slaveResistedSuc):
				playAnimation(StageScene.Duo, "hurt", {npc=npcID, npcAction="punch", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб царапает тебя, когда ты пытаешься что-то сделать с {npc.him}!"+(" Might be worth it to block {npc.his} hands to prevent that from happening." if RNG.chance(30) else ""))
			else:
				playAnimation(StageScene.Duo, "dodge", {npc=npcID, npcAction="punch", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб попытался поцарапать тебя, но {npc.his} помогли избежать этого. Тем не менее, раб активно сопротивляется любым твоим действиям с {npc.him}!")
		elif(activeResistType == "resist_bite"):
			if(slaveResistedSuc):
				playAnimation(StageScene.Duo, "hurt", {npc=npcID, npcAction="bite", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб кусает тебя за руку, когда ты пытаешься что-то сделать с {npc.him}!"+(" Might be worth it to gag or muzzle {npc.him} to prevent that from happening." if RNG.chance(30) else ""))
			else:
				playAnimation(StageScene.Duo, "dodge", {npc=npcID, npcAction="bite", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
				saynn("Твой раб попытался укусить тебя, но {npc.his} слишком коротки, чтобы {npc.him} мог до тебя дотянуться. Тем не менее, раб активно сопротивляется любым твоим действиям с {npc.him}!")
		else:
			saynn("Твой раб активно сопротивляется любым твоим действиям с {npc.him}!")
		
		saynn("Если хочешь, можешь попытаться вбить покорность в {npc.him} силой. Боль рождает страх. А страх — отличный мотиватор. Но {npc.he} явно будет давать отпор...")
		
		saynn("Или же ты можешь просто отменить задуманное и получить отличный повод, чтобы наказать {npc.him} вместо этого!")
		
		addDisabledButton("Заставить", "Нельзя заставить раба, если он активно сопротивляется")
		addButton("Избить", "Заставить силой (через драку)", "resisting_start_fight")
		addButton("Отмена", "Твой раб только что заслужил наказание!", "forced_sex_let_resist", [true])
	
	if(state == "resist_hastofight"):
		saynn("Стоит тебе только возложить руку на свою рабыню, как {npc.he} отталкивает тебя!")
		
		saynn("Похоже, тебе придется побить свою рабыню.")
		
		addButton("Драться", "Начать бой", "start_fight_with_slave")
	
	if(state == "resist_autobeatup"):
		playAnimation(StageScene.SexFeetPlay, "pin", {pc="pc", npc=npcID, npcBodyState={leashedBy = "pc"}})
		
		saynn("Разъяренный непослушанием {npc.his}, ты обрушиваешь на нее поток беспощадных, грубых ударов. Уже после первого попадания {npc.he} перестает сопротивляться... но тебе нужно донести смысл до конца, с силой впечатав колено в живот {npc.his}.")
		
		saynn("Каждый удар отзывается тошнотворным глухим звуком; по кровоточащему, избитому телу {npc.his} расплываются синяки и ссадины.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.personalityScore({PersonalityStat.Mean: 1.0}) > 0.3):
			saynn("[say=npc]"+RNG.pick([
				"Grr.. Fucker..",
				"Fuck.. Stupid.. it hurts..",
				"Stop it, you fuck..",
				"Ugh.. Fuck.."
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Ow.. Hah.. Using pain.. smart.. ugh..",
				"You can't beat the dominant out of me..",
				"It hurts.. Hope you're happy..",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) >= 0.5):
			saynn("[say=npc]"+RNG.pick([
				"Ow.. I'm sorry!.. Agh..",
				"I'm really sorry, please!.. Argh..",
				"Sorry.. Ow.. argh.. it hurts..",
				"I will do anything, please.. Argh..",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Fuck.. Argh..",
				"Stop it already, it hurts..",
				"Hope you're fucking happy..",
				"Grr.. argh.. ugh..",
			])+"[/say]")
		
		saynn("Ты по крупицам дробишь ее дух, подавляя сопротивление {npc.his} до тех пор, пока не останется ничего, кроме страха.")
		
		saynn("Ты останавливаешься только тогда, когда {npc.he} падает на пол. Ты прижимаешь {npc.him} своей ногой, показывая, насколько поверженной и {npc.isAre} является {npc.he}.")
		
		saynn("Похоже, {npc.he} {npc.isAre} готова ко всему.")
		
		addAfterForceButton()
		addButton("Отмена", "Она должна была сопротивляться хотя бы чуть меньше", "")
	
	if(state == "won_resistaction"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcAction="defeat", npcBodyState={leashedBy="pc"}})
		
		saynn("Ты победил! Избиение рабыни заставило {npc.him} бояться тебя еще сильнее.")
		
		saynn("Ты хватаешь {npc.his} за цепь, а значит, {npc.he} не сбежит от того, что ты сделаешь с {npc.him}.")
		
		addAfterForceButton()
		addButton("Отмена", "Она должна была сопротивляться хотя бы чуть меньше", "")
	
	if(state == "lost_forcedsex"):
		playAnimation(StageScene.Duo, "defeat", {npc=npcID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]] } })
		saynn("Ты проиграл. Оу... И, похоже, твоя рабыня не планирует просто так отпускать тебя на свободу после такого...")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.personalityScore({PersonalityStat.Mean: 1.0}) > 0.3):
			saynn("[say=npc]"+RNG.pick([
				"You suck! I will make sure you do!",
				"No-no-no, don't crawl away, slut. Get over here.",
				"Get over here, stupid whore of an owner.",
				"Time for me to have some fun with you, stupid whore!",
				"I'm so fucking mad, get your ass over here."
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Let me show it how it's done.",
				"Don't worry, I will be gentle. As long as you obey.",
				"Time to punish you.",
				"My turn to punish.",
				"My turn to be an owner.",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) >= 0.5):
			saynn("[say=npc]"+RNG.pick([
				"Um.. I will try to be gentle..",
				"Can I?.. I think I can.. Please?",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"My turn. Don't resist.",
				"Don't get up.",
				"I'm gonna fuck you for this!",
				"My turn to have som fun.",
			])+"[/say]")
		
		saynn("Это заслуживает [b]наказания[/b]... определенно заслуживает...")
		
		addButton("Получи по полной", "Смотри, что они с тобой сделают", "start_sex_as_sub")
	
	if(state == "lost_removedrestraints"):
		playAnimation(StageScene.Duo, "defeat", {npc=npcID, npcAction="struggle", npcBodyState={chains=[["normal", "neck", "scene", "floor"]] } })

		saynn("Ты рухнул на пол, не в силах продолжать бой.")
		
		saynn("Пока ты пытаешься прийти в себя, у твоей рабыни хватает времени, чтобы ослабить часть {npc.his}оков! К счастью, цепь помешала {npc.him} сбежать.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.personalityScore({PersonalityStat.Mean: 1.0}) > 0.3):
			saynn("[say=npc]"+RNG.pick([
				"Fuck your shit! It won't keep me from escaping for long.",
				"See? You can't keep me here! Just fucking let me go already, you stupid bitch.",
				"I'm so close! Watch me, soon I won't even be here!",
				"Stupid cunt, I will break you, just like I broke your toys.",
				"So? Happy now? Want more? I have more!",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Nice toys. Mine are better.",
				"Your toys can't hold me forever.",
				"Hah. That was easy.",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) >= 0.5):
			saynn("[say=npc]"+RNG.pick([
				"I broke something.. sorry..",
				"Oops.. I broke a few things.. sorry..",
				"I hope you mind.. I broke a few things..",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"These can't hold me for long.",
				"I will escape.. You can't stop me.",
				"Just let me go already, you clearly can't handle me.",
				"You're too weak. Just let me go.",
				"Think I will respect you after this?",
			])+"[/say]")
		
		saynn("Это определенно заслуживает наказания.")
		
		addButton("Продолжить", "Это было жестко", "")
	
	if(state == "lost_noaction"):
		playAnimation(StageScene.Duo, "defeat", {npc=npcID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]] } })

		saynn("Ты рухнул на пол, не в силах продолжать бой.")
		
		saynn("Пока ты пытаешься прийти в себя, твоя рабыня... не совсем понимает, что делать. {npc.He} слегка дергает за цепи... но те не поддаются.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.personalityScore({PersonalityStat.Mean: 1.0}) > 0.3):
			saynn("[say=npc]"+RNG.pick([
				"You suck!",
				"Why do you suck so much?",
				"If I had more time, I wouldn't be here by now!",
				"Wow, you punch like a slut.",
				"Beating me up? That was a stupid idea. Almost as dumb as enslaving me in the first place.",
				"Easy, pal. Don't make me finish you off.",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Nice try. But I think it's you who should be the slave here.",
				"If I had more time.. You'd be kissing my feet by now.. and loving it.",
				"Damn chains. I love them.. but not when they're on me!",
				"Call me the owner now, I'm clearly stronger.",
			])+"[/say]")
		elif(npcSlavery.personalityScore({PersonalityStat.Subby: 1.0}) >= 0.5):
			saynn("[say=npc]"+RNG.pick([
				"Um.. sorry..",
				"Sorry.. I didn't mean to win.. I mean.. Never mind..",
				"You will be okay, right?..",
				"I just wanted to protect myself.. sorry..",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Maybe you should listen when I say that I don't want to do something?",
				"I just wanted to protect myself.",
				"Easy, pal. Don't make me finish you off.",
				"So? Gonna listen to me better now?",
			])+"[/say]")
		
		saynn("Твоя рабыня избила тебя в честном бою... но это все равно заслуживает небольшого наказания.")
		
		addButton("Продолжить", "Это было жестко", "")

func addActivityButtons():
	var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
	if(npcSlavery.isDoingActivity()):
		var activity:SlaveActivityBase = npcSlavery.getActivity()
	
		var extraActions = activity.getInteractActions()
		for actionInfo in extraActions:
			var args = []
			if(actionInfo.has("args")):
				args = actionInfo["args"]
			var buttonChecks = []
			if(actionInfo.has("buttonChecks")):
				buttonChecks = actionInfo["buttonChecks"]
			addButtonWithChecks(actionInfo["name"], actionInfo["desc"], "do_activity_action", [activity, actionInfo, args], buttonChecks)


static func sortSlaveActions(a, b):
	if a.buttonPriority > b.buttonPriority:
		return true
	return false
		
func addButtonsForActionsOfType(actionsType):
	var theActionIDs = GlobalRegistry.getSlaveActionIDsOfType(actionsType)
	var actionsSorted = []
	for theActionID in theActionIDs:
		var theAction:SlaveActionBase = GlobalRegistry.getSlaveAction(theActionID)
		if(theAction == null):
			continue
		actionsSorted.append(theAction)
	actionsSorted.sort_custom(self, "sortSlaveActions")
	
	for theAction in actionsSorted:
		#var theAction:SlaveActionBase = GlobalRegistry.getSlaveAction(actionID)
		if(!theAction.isActionVisibleFinal(npcID)):
			continue
		
		if(theAction.extraSlaves.empty()):
			var canDoInfo = theAction.checkCanDoFinal(npcID)
			if(canDoInfo[0]):
				addButton(theAction.getVisibleName(), theAction.getFinalVisibleDesc(), "do_action", [theAction.id])
			elif(canDoInfo.size() > 1):
				addDisabledButton(theAction.getVisibleName(), "[color=red]"+canDoInfo[1]+"[/color]\n\n"+theAction.getFinalVisibleDesc())
		else:
			addButton(theAction.getVisibleName(), theAction.getFinalVisibleDesc(), "do_action", [theAction.id])

func addAfterForceButton():
	addButtonWithChecks(savedWantedToDoName, "Делай то, что хотел", savedWantedToDo, savedWantedToDoArgs, savedButtonChecks)

func checkSlaveResist(resistChance, onlyActiveResist = false):
	var npcSlavery:NpcSlave = npc.getNpcSlavery()
	slaveResistedSuc = true
	if(onlyActiveResist && RNG.chance(resistChance) && npcSlavery.isResistingSuperActively()):
		var possibleResists = []
		var resistSuccessChance = 100
		if(npc.isBlindfolded()):
			resistSuccessChance *= 0.5
		if(npc.hasBoundLegs()):
			resistSuccessChance *= 0.6
		else:
			possibleResists.append("resist_kick")
		if(npc.hasBlockedHands()):
			resistSuccessChance *= 0.8
		else:
			possibleResists.append("resist_scratch")
		if(npc.hasBoundArms()):
			resistSuccessChance *= 0.7
		else:
			possibleResists.append("resist_shove")
		if(npc.isBitingBlocked()):
			resistSuccessChance *= 0.95
		else:
			possibleResists.append("resist_bite")
		
		if(!RNG.chance(resistSuccessChance)):
			slaveResistedSuc = false
		
		if(possibleResists.size() > 0):
			var randomResist = RNG.pick(possibleResists)
			# Do add pain
			if(slaveResistedSuc):
				GM.pc.addPain(RNG.randi_range(3, 6))
			activeResistType = randomResist
			setState("resisting_actively")
			return true
	
	if(npcSlavery.isActivelyResisting() && RNG.chance(resistChance) && !onlyActiveResist):
		setState("resisting_action")
		return true
	
	return false
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "do_action"):
		var theAction:SlaveActionBase = GlobalRegistry.getSlaveAction(_args[0])
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		# Resisting!
		if(checkSlaveResist(theAction.slaveResistChanceMult * 100.0, theAction.slaveOnlyActiveResist)):
			savedWantedToDo = "do_action_noresist"
			savedWantedToDoName = theAction.getVisibleName()
			savedWantedToDoArgs = [_args[0]]
			savedButtonChecks = []
			return
		
	if(_action == "do_action" || _action == "do_action_noresist"):
		var theAction:SlaveActionBase = GlobalRegistry.getSlaveAction(_args[0])
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		# Multi-slave action
		if(!theAction.extraSlaves.empty()):
			runScene("SlaveStartActionScene", [theAction.id, npcID], "slaveStartAction")
			setState("")
			return
		
		# Action that launches a scene
		if(theAction.sceneID != ""):
			runScene("SlaveActionWrapperScene", [theAction.id, npcID, {}])
			if(theAction.endsTalkScene):
				endScene()
				return
			setState("")
			return
		# Simple action
		var result = theAction.doActionSimpleFinal(npcID)
		if(result.has("text")):
			resultText = result["text"]
		else:
			resultText = "An action happened!"
		lastActionID = theAction.id
		#theAction.playAnimation(npcID, {})
		setState("do_action")
		return

	if(_action == "do_train"):
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		#var resistChance = max(80.0*float(npcSlavery.isResistingSuperActively()), 30.0*float(npcSlavery.isActivelyResisting()))
		#if(RNG.chance(resistChance)):
		if(checkSlaveResist(80.0)):
			savedWantedToDo = "do_train_noresist"
			savedWantedToDoName = "Train"
			savedWantedToDoArgs = []
			savedButtonChecks = []
			return
		
	if(_action == "do_train" || _action == "do_train_noresist"):
		processTime(30*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		var result = npcSlavery.doTrain()
		resultText = Util.join(result["texts"], "\n\n")
		
		setState("do_train")
		return

	if(_action == "do_activity_action"):
		#var action:SlaveActivityBase = _args[0]
		var actionInfo = _args[1]
		var theArgs = _args[2]
		
		endScene()
		runScene(actionInfo["sceneID"], [npcID, {}, theArgs])
		return

	if(_action == "do_extra_action"):
		#var action:SlaveActionBase = _args[0]
		var actionInfo = _args[1]
		var theArgs = _args[2]
		
		endScene()
		runScene(actionInfo["sceneID"], [npcID, {}, theArgs])
		return

	if(_action == "resisting_start_fight"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		var cowardness = npcSlavery.personalityScore({PersonalityStat.Coward:1.0})
		
		var fightChance = 0.0
		if(cowardness >= 0.5):
			fightChance = 0.0
		elif(cowardness <= -0.5):
			fightChance = 100.0
		else:
			fightChance = Util.remapValue(cowardness, -0.5, 0.5, 100.0, 0.0)
		
		if(RNG.chance(fightChance)):
			setState("resist_hastofight")
		else:
			npcSlavery.afterBeatenUp()
			setState("resist_autobeatup")
		return
	
	if(_action == "start_fight_with_slave"):
		runScene("FightScene", [npcID], "antiresistancefight")
		return

	if(_action == "start_walkies"):
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		#if(npcSlavery.isResistingSuperActively() || (RNG.chance(40) && npcSlavery.isActivelyResisting())):
		if(checkSlaveResist(100.0)):
			savedWantedToDo = "start_walkies_forced"
			savedWantedToDoName = "Leash slave"
			savedWantedToDoArgs = []
			savedButtonChecks = []
		else:
			runScene("SlaveryWalkiesGrabScene", [npcID])
			endScene()
		return

	if(_action == "start_walkies_forced"):
		runScene("SlaveryWalkiesGrabScene", [npcID])
		endScene()
		return

	if(_action == "do_forced_sex"):
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		#if(npcSlavery.isResistingSuperActively() || (RNG.chance(40) && npcSlavery.isActivelyResisting())):
		if(checkSlaveResist(100.0)):
			savedWantedToDo = "start_forced_sex_forced"
			savedWantedToDoName = "Forced sex"
			savedWantedToDoArgs = []
			savedButtonChecks = [[ButtonChecks.CanStartSex]]
		else:
			startSex()
		return
	
	if(_action == "start_forced_sex_forced"):
		startSex(true)
		return
		
	if(_action == "forced_sex_let_resist"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		# Raise the spirit here?
		if(_args.size() > 0 && _args[0]):
			npcSlavery.addBrokenSpirit(-0.02)
			npcSlavery.addAwareness(-0.02)
			npcSlavery.deservesPunishment(2)
		else:
			npcSlavery.addBrokenSpirit(-0.01)
			npcSlavery.addAwareness(-0.01)
			npcSlavery.deservesPunishment(1)
		setState("")
		return
	
	if(_action == "start_sex_as_sub"):
		runScene("GenericSexScene", [npcID, "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "fucked_by_angry_slave")
		setState("")
		return
		
	if(_action == "do_force_action"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getTrust() <= 0.0):
			npcSlavery.addDespair(0.03)
		else:
			npcSlavery.addTrust(-0.02)
			npcSlavery.addLove(-0.02)
		npcSlavery.addAwareness(0.01)
		
		return _react(_args[0], _args[1]) # Might break one day, don't hurt me

	setState(_action)

func startSex(isResisting = false):
	if(isResisting):
		npc.addEffect("SexActivelyResisting")
	runScene("GenericSexScene", ["pc", npcID], "sex_with_slave")

func _react_scene_end(_tag, _result):
	if(_tag == "slaveStartAction"):
		if(_result is Array && _result.size() > 0 && _result[0]):
			endScene()
			return
			
	if(_tag in ["sex_with_slave"]):
		setState("")
	
	if(_tag == "antiresistancefight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_resistaction")
			addExperienceToPlayer(10)
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			npcSlavery.afterBeatenUp()
			npcSlavery.deservesPunishment(2)
			#npcSlavery.handlePunishment(2)
		else:
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			
			var canSex = true
			var shouldSex = false
			if(npc.hasBlockedHands() || npc.hasBoundArms() || npc.isOralBlocked() || npc.isBlindfolded()):
				canSex = false
			else:
				var fuckChance = 75 + npcSlavery.personalityScore({PersonalityStat.Subby:1.0, PersonalityStat.Mean:1.0, PersonalityStat.Coward:-1.0})*25.0
				if(RNG.chance(fuckChance)):
					shouldSex = true
				
			var removeChanceMult = 1.0 + npcSlavery.personalityScore({PersonalityStat.Brat:-0.5}) + npcSlavery.fetishScore({Fetish.Bondage: -0.5})
			var howMuchRestraintsRemoved = npc.getInventory().removeRandomRestraints(100.0*clamp(removeChanceMult, 0.1, 5.0))
			
			npcSlavery.addBrokenSpirit(-0.2)
			npcSlavery.addObedience(-0.2)
			npcSlavery.addDespair(-0.2)
			npcSlavery.addTired(1.0)
			
			if(howMuchRestraintsRemoved > 0):
				setState("lost_removedrestraints")
				npcSlavery.deservesPunishment(2)
			else:
				if(canSex && shouldSex):
					setState("lost_forcedsex")
					npcSlavery.deservesPunishment(3)
				else:
					setState("lost_noaction")
					npcSlavery.deservesPunishment(1)
			
			

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["resultText"] = resultText
	data["savedWantedToDo"] = savedWantedToDo
	data["savedWantedToDoName"] = savedWantedToDoName
	data["savedWantedToDoArgs"] = savedWantedToDoArgs
	data["lastActionID"] = lastActionID
	data["savedButtonChecks"] = savedButtonChecks
	data["slaveResistedSuc"] = slaveResistedSuc
	data["activeResistType"] = activeResistType
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)

	resultText = SAVE.loadVar(data, "resultText", "")
	savedWantedToDo = SAVE.loadVar(data, "savedWantedToDo", "")
	savedWantedToDoName = SAVE.loadVar(data, "savedWantedToDoName", "")
	savedWantedToDoArgs = SAVE.loadVar(data, "savedWantedToDoArgs", null)
	lastActionID = SAVE.loadVar(data, "lastActionID", "")
	savedButtonChecks = SAVE.loadVar(data, "savedButtonChecks", [])
	slaveResistedSuc = SAVE.loadVar(data, "slaveResistedSuc", false)
	activeResistType = SAVE.loadVar(data, "activeResistType", "")

func getDebugActions():
	return [
		{
			"id": "levelUP",
			"name": "Slave levelup",
			"args": [
			],
		},
		{
			"id": "skillLevelup",
			"name": "Skill levelup",
			"args": [
			],
		},
		{
			"id": "addExp",
			"name": "Add exp",
			"args": [
				{
					"id": "amount",
					"name": "Amount",
					"type": "number",
					"value": 1000,
				},
			],
		},
		{
			"id": "toggleDebug",
			"name": "Toggle Debug Info",
			"args": [
			],
		},
		{
			"id": "setObedience",
			"name": "Set obedience",
			"args": [
				{
					"id": "amount",
					"name": "Amount (%)",
					"type": "number",
					"value": 100.0,
				},
			],
		},
		{
			"id": "setLove",
			"name": "Set love",
			"args": [
				{
					"id": "amount",
					"name": "Amount (%)",
					"type": "number",
					"value": 100.0,
				},
			],
		},
		{
			"id": "setBrokenSpirit",
			"name": "Set broken spirit",
			"args": [
				{
					"id": "amount",
					"name": "Amount (%)",
					"type": "number",
					"value": 100.0,
				},
			],
		},
	]

func doDebugAction(_id, _args = {}):
	var npcSlavery:NpcSlave = npc.getNpcSlavery()
	if(_id == "levelUP"):
		npcSlavery.doLevelup()
	if(_id == "skillLevelup"):
		npcSlavery.levelupCurrentSpecialization()
	if(_id == "toggleDebug"):
		setFlag("NpcSlaveryModule.debugSlaveInfo", !getFlag("NpcSlaveryModule.debugSlaveInfo", false))
	if(_id == "addExp"):
		npcSlavery.addExperience(_args["amount"])
	if(_id == "setObedience"):
		npcSlavery.obedience = clamp(_args["amount"] / 100.0, 0.0, 1.0)
	if(_id == "setLove"):
		npcSlavery.love = clamp(_args["amount"] / 100.0, 0.0, 1.0)
	if(_id == "setBrokenSpirit"):
		npcSlavery.brokenspirit = clamp(_args["amount"] / 100.0, 0.0, 1.0)
