extends SceneBase

var ambushPlace:String = "" # normal, shower, canteen, cell
var ambushType:String = "" # showeritems, normalshiv, normaldrugged_stamina, canteendrugged_lust, cellbondage
var npcMain:String = ""
var npcExtra1:String = ""
var npcExtra2:String = ""
var nemesisReason:int = NemesisReason.Generic
var willSoftSlavery:bool = false

func _initScene(_args = []):
	ambushPlace = _args[0]
	npcMain = _args[1]
	npcExtra1 = _args[2]
	npcExtra2 = _args[3]

func _reactInit():
	var theNemesis:SpecialRelationshipBase = GM.main.RS.getSpecialRelationship(npcMain)
	if(theNemesis && theNemesis.id == "Nemesis"):
		nemesisReason = theNemesis.getReason()
	
	#if(getCharacter(npcMain).hasEnslaveQuest()):
	getCharacter(npcMain).setEnslaveQuest(null)
	
	GM.main.IS.deletePawn(npcMain)
	GM.main.IS.deletePawn(npcExtra1)
	GM.main.IS.deletePawn(npcExtra2)
	
	if(ambushPlace == "shower"):
		ambushType = RNG.pick(["showeritems"])
	elif(ambushPlace == "canteen"):
		ambushType = RNG.pick(["canteendrugged_lust"])
	elif(ambushPlace == "cell"):
		ambushType = RNG.pick(["cellbondage"])
	else:
		ambushType = RNG.pick(["normalshiv", "normaldrugged_stamina"])
	
	if(ambushType == "showeritems"):
		transferAllEquippedItems(GM.pc, getCharacter("TempAmbushStash"))
		transferHelpfulItems(GM.pc, getCharacter("TempAmbushStash"))
		GM.pc.afterTakingAShower()
	if(ambushType == "canteendrugged_lust"):
		GM.pc.addLust(GM.pc.lustThreshold())
		GM.pc.forceIntoHeat()
		addMessage("You feel VERY lusty..")
	if(ambushType == "normaldrugged_stamina"):
		GM.pc.addStamina(-GM.pc.getMaxStamina())
		addMessage("You feel VERY weak..")
	if(ambushType == "normalshiv"):
		GM.pc.addPain(30)
		GM.pc.doWound(npcMain)
	if(ambushType == "cellbondage"):
		transferHelpfulItems(GM.pc, getCharacter("TempAmbushStash"))
		var possibleRestraints:Array = ["basketmuzzle", "blindfold", "bondagemittens", "inmateanklecuffs", "inmatewristcuffs"]
		possibleRestraints.shuffle()
		var addedList := GM.pc.getInventory().forceRestraintsList(possibleRestraints, 2)
		if(addedList.empty()):
			addMessage("Looks like they didn't really manage to add more bondage gear onto you..")
		elif(addedList.size() == 1):
			addMessage("Looks like they only managed to add one piece of bondage gear onto you..")
		else:
			addMessage("You got some bondage gear forced onto you..")
	
	willSoftSlavery = RNG.chance(75)
	
	setState(ambushType)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcMain
	if(_charID == "npc1"):
		return npcExtra1
	if(_charID == "npc2"):
		return npcExtra2

func _init():
	sceneID = "NemesisAmbushScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})
		saynn("ЗАЛЕТНАЯ! НО ЭТОГО НЕ ДОЛЖНО БЫЛО СЛУЧИТЬСЯ.")

		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
	
	if(state == "normaldrugged_stamina"):
		addCharacter(npcMain)
		addCharacter(npcExtra1)
		addCharacter(npcExtra2)
		playAnimation(StageScene.Duo, "hurt", {npc=npcMain})
		
		saynn("Ты идешь себе спокойно, никого не трогая... как вдруг кто-то налетает на тебя с такой силой, что ты едва не теряешь равновесие.")

		saynn("Прежде чем ты успеваешь среагировать, чувствуешь резкий укол... игла вонзается в кожу. Странное тепло начинает разливаться по твоим венам.")
		
		saynn("И тут до тебя доходит... ты окружен тремя фигурами.")
		
		saynn("[say=npc]"+RNG.pick([
			"What's the rush. Slow down. Remember me?",
			"It's not poison, don't worry. Do you know who I am?",
			"You're not looking so hot, pal. Remember me?",
		])+"[/say]")
		
		saynn("Это {npc.him}... твой заклятый враг. Что бы ни было в этом шприце, с каждой секундой ты чувствуешь себя всё слабее и слабее.")
		
		saynn("[say=npc]"+NemesisReason.getAmbushLine(nemesisReason, getCharacter(npcMain))+"[/say]")
		
		saynn("Похоже, {npc.he} притащил с собой дружков.")
		
		saynn("[say=npc]"+RNG.pick([
			"You will do as I say. And we won't have any problems.",
			"Don't do anything stupid, please.",
			"Don't be stupid. It's three against one.",
		])+"[/say]")
		
		saynn("Что-то подсказывает тебе, что они не дадут тебе просто прилечь вздремнуть, чтобы восстановить силы...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
	
	if(state == "normalshiv"):
		addCharacter(npcMain)
		addCharacter(npcExtra1)
		addCharacter(npcExtra2)
		playAnimation(StageScene.Duo, "hurt", {npc=npcMain, npcAction="shiv"})
	
		saynn("Ты шел по своим делам, когда кто-то на полном ходу врезался тебе в плечо, едва не развернув тебя на месте.")

		saynn("Внезапная жгучая боль пронзает бок. Ты опускаешь взгляд и видишь, как на одежде расплывается тонкая струйка крови. Тебя ударили ножом...")
			
		saynn("[say=npc]"+RNG.pick([
			"Ohh. That hurt, didn't it?",
			"Remember me?",
			"Oops.",
			"You're not looking too hot, buddy.",
			"Should I do it again?",
		])+"[/say]")
		
		saynn("Это {npc.him}... твой заклятый враг... в руках у него заточка. Удар был не слишком глубоким... но рана всё равно кровоточит.")
		
		saynn("[say=npc]"+NemesisReason.getAmbushLine(nemesisReason, getCharacter(npcMain))+"[/say]")
		
		saynn("Похоже, {npc.he} притащил с собой дружков.")
		
		saynn("[say=npc]"+RNG.pick([
			"You will do as I say. And we won't have any problems.",
			"Don't do anything stupid, please.",
			"Don't be stupid. It's three against one.",
		])+"[/say]")
		
		saynn("Что-то подсказывает тебе, что бинта, чтобы остановить кровь, они тебе не дадут...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
	
	if(state == "cellbondage"):
		playAnimation(StageScene.Sleeping, "sleep")
	
		saynn("Ты ложишься на кровать и закрываешь глаза.")
		
		saynn("Пока сознание уплывает прочь... странное чувство начинает разливаться по твоему телу.")
		
		saynn("Будто что-то... касается твоих конечностей... ласкает тебя... но сейчас явно не время для этого.")
		
		saynn("Трудно сказать, в голове сплошной туман... но кажется, будто кто-то еще и шарит по твоим карманам. Лучше попытаться встать и увидеть всё своими глазами.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "cellbondage_reveal")
	
	if(state == "cellbondage_reveal"):
		addCharacter(npcMain)
		addCharacter(npcExtra1)
		addCharacter(npcExtra2)
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})
		
		saynn("Ты поднимаешься... и видишь, что тебя окружили три фигуры. Лидер делает шаг вперед.")
		
		saynn("[say=npc]"+RNG.pick([
			"You were sleeping so soundly, I didn't want to wake you up.",
			"Good morning, sunshine. Remember me?",
			"Nice cell you got here. I left you some gifts. Remember who I am?",
		])+"[/say]")
		
		saynn("Это {npc.him}... твой заклятый враг. Ты понимаешь, что часть твоих вещей пропала...")
		
		saynn("[say=npc]"+NemesisReason.getAmbushLine(nemesisReason, getCharacter(npcMain))+"[/say]")
		
		saynn("Похоже, {npc.he} притащил с собой дружков.")
		
		saynn("[say=npc]"+RNG.pick([
			"You will do as I say. And we won't have any problems.",
			"Don't do anything stupid, please.",
			"Don't be stupid. It's three against one.",
		])+"[/say]")
		
		saynn("Что-то подсказывает тебе, что они не дадут тебе времени, чтобы вырваться из твоего нового снаряжения для связывания...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
	
	if(state == "canteendrugged_lust"):
		playAnimation(StageScene.Solo, "sit")
	
		saynn("Ты занят тем, что доедаешь свою порцию...")
		
		saynn("Но пока ты ешь... ты начинаешь что-то чувствовать. В помещении внезапно стало очень жарко.")
		
		if(GM.pc.isWearingChastityCage()):
			saynn("Твой запертый член становится совсем тесным в своей маленькой клетке... Внезапно ты чувствуешь такую острую нужду.")
		elif(GM.pc.hasReachablePenis()):
			saynn("Твой член наливается твердостью и начинает сочиться... капает предэякулят... Внезапно ты чувствуешь такую острую нужду.")
		elif(GM.pc.hasReachableVagina()):
			saynn("Твоя киска становится влажной и чувствительной... ты впадаешь в течку... тебе нужно что-то с этим делать...")
		else:
			saynn("Внезапно ты чувствуешь такую острую нужду...")
		
		saynn("[say=npc]"+RNG.pick([
			"Feeling hot, huh?",
			"Enjoying the food?",
		])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "canteendrugged_lust_reveal")
		
	if(state == "canteendrugged_lust_reveal"):
		addCharacter(npcMain)
		addCharacter(npcExtra1)
		addCharacter(npcExtra2)
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})
		
		saynn("Ты поднимаешься... и видишь, что тебя окружили три фигуры. Лидер делает шаг вперед.")
		
		saynn("[say=npc]"+RNG.pick([
			"I asked the chef to make your food a little.. spicier.",
			"I asked the chef to add a little something into your meal.",
		])+"[/say]")
		
		saynn("Это {npc.him}... твой заклятый враг.")
		
		saynn("[say=npc]"+NemesisReason.getAmbushLine(nemesisReason, getCharacter(npcMain))+"[/say]")
		
		saynn("Похоже, {npc.he} притащил с собой дружков.")
		
		saynn("[say=npc]"+RNG.pick([
			"You will do as I say. And we won't have any problems.",
			"Don't do anything stupid, please.",
			"Don't be stupid. It's three against one.",
		])+"[/say]")
		
		saynn("Что-то подсказывает тебе, что они не дадут тебе времени разобраться со своим вожделением...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
		
	if(state == "showeritems"):
		playAnimation(StageScene.Showering, "head", {pc="pc", bodyState={naked=true}})
		
		saynn("Ты принимала обычный душ... мылась, позволяя воде смыть с себя всю грязь.")

		saynn("Но почему-то у тебя возникает чувство, будто за тобой [b]наблюдают[/b]...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "showeritems_reveal")
		
	if(state == "showeritems_reveal"):
		addCharacter(npcMain)
		addCharacter(npcExtra1)
		addCharacter(npcExtra2)
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})
		
		saynn("Внезапно в комнату входят три фигуры и окружают тебя. Лидер делает шаг ближе.")
		
		saynn("[say=npc]"+RNG.pick([
			"Hi. Remember me?",
			"How is the water?",
			"Hey there. Missed me?",
		])+"[/say]")
		
		saynn("Это {npc.him}... твой заклятый враг.")
		
		saynn("[say=npc]"+NemesisReason.getAmbushLine(nemesisReason, getCharacter(npcMain))+"[/say]")
		
		saynn("Похоже, {npc.he} притащил с собой дружков.")
		
		saynn("[say=npc]"+RNG.pick([
			"You will do as I say. And we won't have any problems.",
			"Don't do anything stupid, please.",
			"Don't be stupid. It's three against one.",
		])+"[/say]")
		
		saynn("Ты оставил все свои вещи в шкафчике. Что-то подсказывает тебе, что к ним тебя просто так не подпустят...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "show_others")
	
	if(state == "show_others"):
		playAnimation(StageScene.Duo, "stand", {pc=npcExtra1, npc=npcExtra2})
		
		saynn("Там есть и другие {npc.him}! Тебе придется выиграть 3 боя подряд.")
		
		saynn("Или просто позволить {npc.name} делать с тобой всё, что захочет {npc.he}. Но у тебя есть предчувствие, что для тебя это плохо кончится...")
		
		if(ambushType == "normalshiv"):
			saynn("Тебя ударили ножом... так что первый бой начнется с [color=red]сильного[/color] кровотечения.")
		if(ambushType == "showeritems"):
			saynn("На тебя напали в душевой. Тебе придется сражаться [b]голышом[/b], без оружия и полезных вещей вроде обезболивающих.")
		if(ambushType == "canteendrugged_lust"):
			saynn("Ты начнешь бой в состоянии дикого возбуждения. Если не найдешь способ утолить похоть, то проиграешь.")
		if(ambushType == "normaldrugged_stamina"):
			saynn("Из-за наркотика ты чувствуешь себя невероятно уставшим.")
		if(ambushType == "cellbondage"):
			saynn("Поскольку они обшарили твои карманы, ты не сможешь использовать большинство вещей: свое оружие и препараты.")
		
		sayOutcomeIfFail()
		
		addButton("Драться", "Лучше сражаться", "first_fight")
		addButton("Подчиниться", "Посмотреть, что будет...", "do_submit")
	
	if(state == "first_fight"):
		playAnimation(StageScene.Duo, "stand", {npc=npcExtra1})
		
		saynn("Ты готовишься дать отпор.")
		
		saynn("[say=npc]"+RNG.pick([
			"That a dumb decision.",
			"Really? You think you can win?",
			"What do you think will happen when you lose?",
			"You're only making it worse for yourself.",
		])+"[/say]")
		
		saynn("{npc.name} решает сначала дать {npc.his} друзьям тебя размять.")
		
		addButton("Драться", "Начать бой", "start_first_fight")
	
	if(state == "second_fight"):
		playAnimation(StageScene.Duo, "stand", {npc=npcExtra2})
		
		saynn("Ты победил. Первый друг уже вовсю целует пол.")
		
		saynn("Но ты всё ещё не на свободе.")
		
		saynn("{npc2.name} приближается к тебе, жаждая битвы.")
		
		addButton("Драться", "Начать бой", "start_second_fight")
	
	if(state == "third_fight"):
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})
		
		saynn("Оба друга {npc.nameS} повержены.")
		
		saynn("[say=npc]"+RNG.pick([
			"Alright. Lets dance.",
			"Alright. Lets see what you can do.",
			"Alright. Lets play.",
			"This is not over yet.",
			"How are you feeling? Maybe you should just give up already.",
			"I guess it's time to show you your place.",
		])+"[/say]")
		
		saynn("Последний бой. Твой заклятый враг.")
		
		addButton("Драться", "Начать бой", "start_third_fight")
	
	if(state == "won_all_fights"):
		playAnimation(StageScene.Duo, "stand", {npc=npcMain, npcAction="defeat"})
		
		saynn("Ты победил! Твой враг рушится на пол, не в силах продолжать бой.")
		
		saynn("[say=npc]"+RNG.pick([
			"Hey.. Listen.. Let's talk.",
			"Argh.. you.. bitch..",
			"Fuck you.. whatever..",
		])+"[/say]")
		
		addButton("Уйти", "Просто оставь их в покое", "decideLeave")
		addButton("Наказать", "Устрой с ними что-нибудь весёлое", "startPunish")
	
	if(state == "decideLeave"):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("{npc.He} {npc.isAre} не стоят твоего времени.")
		
		saynn("Преподав {npc.him} урок, вы решаете просто уйти.")
		
		saynn("Надеемся, {npc.he} больше не доставит проблем.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "lost_fight"):
		playAnimation(StageScene.Solo, "defeat")
		
		saynn("Вы проиграли. Ваш заклятый враг одержал верх.")
		
		saynn("Вы лежите на полу, пытаясь отдышаться.")
		
		saynn("[say=npc]"+RNG.pick([
			"That was dumb.",
			"Was it worth it?",
			"You tried. But you're too weak.",
			"Pathetic display.",
			"That was way too easy.",
			"Time for the fun part.",
		])+"[/say]")
		
		saynn("{npc.name} подходит к вам и быстро вонзает шприц вам в шею...")
		
		addButton("Продолжить", "Смотри, что будет дальше...", "get_knocked_out")
	
	if(state == "do_submit"):
		playAnimation(StageScene.Duo, "kneel", {npc=npcMain})
		
		saynn("Сопротивление... того не стоит. Вы решаете подчиниться.")
		
		saynn("Вы встаете на колени перед {npc.name}... и ждете следующего решения {npc.his}.")
		
		saynn("[say=npc]"+RNG.pick([
			"Good {pc.boy}. You won't regret it.",
			"Maybe you're not as dumb as I thought.",
			"Thank you. Thank you for making it easy for me.",
			"That was a smart choice. Thank you.",
		])+"[/say]")
		
		saynn("{npc.name} подходит к вам и быстро вонзает шприц вам в шею...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "get_knocked_out")
	
	if(state == "get_knocked_out"):
		removeCharacter(npcMain)
		removeCharacter(npcExtra1)
		removeCharacter(npcExtra2)
		playAnimation(StageScene.Sleeping, "sleep")
		
		saynn("Что бы это ни было... оно действует очень быстро.")
		
		saynn("Вы окончательно теряете сознание, тело перестает слушаться. Сон окутывает ваш разум всё сильнее и сильнее...")
		
		saynn("Последнее, что ты слышишь, это..")
		
		saynn("[say=npc]"+RNG.pick([
			"This is just the beginning.",
			"Enjoy your new life.",
			"Let's hope I won't see you ever again.",
			"We're almost done here. Only one last thing left.",
		])+"[/say]")
		
		saynn("А затем всё погружается во тьму..")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "start_slavery")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		transferAllItems(getCharacter("TempAmbushStash"), GM.pc)
		if(ambushType == "showeritems"):
			addMessage("All your items were returned to your inventory.")
		endScene()
		return
	if(_action == "start_first_fight"):
		runScene("FightScene", [npcExtra1], "first_fight")
		if(ambushType == "normalshiv"):
			GM.pc.addEffect(StatusEffect.Bleeding, [8])
		return
	if(_action == "start_second_fight"):
		runScene("FightScene", [npcExtra2], "second_fight")
		return
	if(_action == "start_third_fight"):
		runScene("FightScene", [npcMain], "third_fight")
		return
	if(_action == "start_slavery"):
		transferAllItems(getCharacter("TempAmbushStash"), GM.pc)
		endScene()
		GM.main.RS.stopSpecialRelationship(npcMain)
		
		if(willSoftSlavery):
			processTime(RNG.randi_range(60, 180)*60)
			GM.main.RS.startSpecialRelantionship("SoftSlavery", npcMain)
			runScene("NpcOwnerEventRunnerScene", [npcMain, "Intro", ["ambush"]])
			return
		
		runScene(getModule("PlayerSlaveryModule").getSlaveryStartScene())
		return
	if(_action == "startPunish"):
		transferAllItems(getCharacter("TempAmbushStash"), GM.pc)
		endScene()
		var thePawn = GM.main.IS.spawnPawn(npcMain)
		if(thePawn):
			thePawn.setLocation(GM.pc.getLocation())
			GM.main.IS.startInteraction("PunishInteraction", {punisher="pc", target=npcMain})
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "first_fight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		if(battlestate == "win"):
			setState("second_fight")
			
			if(ambushType == "canteendrugged_lust"):
				GM.pc.addLust(GM.pc.lustThreshold())
				GM.pc.forceIntoHeat()
				addMessage("You still feel VERY lusty..")
			if(ambushType == "normaldrugged_stamina"):
				GM.pc.addStamina(-GM.pc.getMaxStamina())
				addMessage("You still feel VERY weak..")
		else:
			setState("lost_fight")
	if(_tag == "second_fight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		if(battlestate == "win"):
			setState("third_fight")
			
			if(ambushType == "canteendrugged_lust"):
				GM.pc.addLust(GM.pc.lustThreshold())
				GM.pc.forceIntoHeat()
				addMessage("You still feel VERY lusty..")
			if(ambushType == "normaldrugged_stamina"):
				GM.pc.addStamina(-GM.pc.getMaxStamina())
				addMessage("You still feel VERY weak..")
		else:
			setState("lost_fight")
	if(_tag == "third_fight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		if(battlestate == "win"):
			GM.main.RS.stopSpecialRelationship(npcMain)
			setState("won_all_fights")
		else:
			setState("lost_fight")

func sayOutcomeIfFail():
	if(willSoftSlavery):
		saynn("Если ты проиграешь или сдашься, то, скорее всего, [b]станешь тюремной сучкой {npc.name}[/b]..")
	else:
		saynn("Если ты проиграешь или сдашься, тебя, скорее всего, [b]продадут на аукционе[/b]..")

func saveData():
	var data = .saveData()
	
	data["ambushType"] = ambushType
	data["ambushPlace"] = ambushPlace
	data["npcMain"] = npcMain
	data["npcExtra1"] = npcExtra1
	data["npcExtra2"] = npcExtra2
	data["nemesisReason"] = nemesisReason
	data["willSoftSlavery"] = willSoftSlavery
	
	return data
	
func loadData(data):
	.loadData(data)
	
	ambushType = SAVE.loadVar(data, "ambushType", "")
	ambushPlace = SAVE.loadVar(data, "ambushPlace", "")
	npcMain = SAVE.loadVar(data, "npcMain", "")
	npcExtra1 = SAVE.loadVar(data, "npcExtra1", "")
	npcExtra2 = SAVE.loadVar(data, "npcExtra2", "")
	nemesisReason = SAVE.loadVar(data, "nemesisReason", NemesisReason.Generic)
	willSoftSlavery = SAVE.loadVar(data, "willSoftSlavery", false)




func transferAllItems(_charFrom, _charTo):
	if(!_charFrom || !_charTo):
		return
	var theItems:Array = _charFrom.getInventory().getItems()
	while(!theItems.empty()):
		var theItem = theItems[0]
		
		_charFrom.getInventory().removeItem(theItem)
		_charTo.getInventory().addItem(theItem)

func transferHelpfulItems(_charFrom, _charTo):
	if(!_charFrom || !_charTo):
		return
	var theItems:Array = _charFrom.getInventory().getItems()
	var toTransfer:Array = []
	for item in theItems:
		if(item.getItemCategory() == ItemCategory.Medical || item.getItemCategory() == ItemCategory.Weapons):
			toTransfer.append(item)
	
	for theItem in toTransfer:
		_charFrom.getInventory().removeItem(theItem)
		_charTo.getInventory().addItem(theItem)

func transferAllEquippedItems(_charFrom, _charTo):
	for slot in _charFrom.getInventory().getEquippedItems():
		var theItem:ItemBase = _charFrom.getInventory().getEquippedItem(slot)
		if(theItem.isImportant() || theItem.isRestraint()):
			continue
		_charFrom.getInventory().clearSlot(slot)
		_charTo.getInventory().addItem(theItem)
