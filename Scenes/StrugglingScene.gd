extends "res://Scenes/SceneBase.gd"
var unlockedRestraintID = ""
var actionText = ""
var struggleText = ""
var additionalStruggleText = ""
var canKeepTheRestraint = false
var keptRestraintID = ""
var keyGameTries: int = 3
var keyGameValue: int = 50
var keyText = ""
var fightMode = false
var restraintID = ""
var shouldPlayAnimations = true

#var minigameScene = preload("res://Game/Minigames/Struggling/StrugglingGame.tscn")
var minigameScene = preload("res://Game/Minigames/ClickAtTheRightTime/ClickAtTheRightTime.tscn")

func _init():
	sceneID = "StrugglingScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		fightMode = _args[0]
	if(_args.size() > 1):
		shouldPlayAnimations = _args[1]
	
	var allItems = GM.pc.getInventory().getAllEquippedItems()
	for itemSlot in allItems:
		var item: ItemBase = allItems[itemSlot]
		if(item.isRestraint()):
			item.getRestraintData().resetOnNewTry()

func hasAnythingToInspect() -> bool:
	for item in GM.pc.getInventory().getEquppedRestraints():
		var restraintData: RestraintData = item.getRestraintData()
		if(restraintData.hasSmartLock()):
			return true
		if(!restraintData.canStruggleFinal()):
			continue
		return true
	return false

func _run():
	if(state == ""):
		if(shouldPlayAnimations):
			playAnimation(StageScene.Solo, "stand")
		
		var isBlind = GM.pc.isBlindfolded()
		saynn("Выбери средство фиксации, на котором хочешь сосредоточиться. Учти, что некоторые из них будет сложнее снять в зависимости от того, что на тебе надето.")
		
		if(GM.pc.getInventory().hasItemID("restraintkey")):
			addButtonAt(13, "Использовать ключ", "Использовать один из ваших ключей от оков, чтобы что-то отпереть", "usekey")
		else:
			addDisabledButtonAt(13, "Использовать ключ", "У вас нет ключей от оков")
		addButtonAt(14, "Назад", "Перестать барахтаться", "endthescenedidnothing")
		
		for item in GM.pc.getInventory().getEquppedRestraints():
			var restraintData: RestraintData = item.getRestraintData()
			
			
			#sayn("- Прочность: "+restraintData.getVisibleDurability())
			if(!restraintData.hasSmartLock()):
				sayn(item.getVisibleName()+", уровень фиксации: "+restraintData.getVisibleLevel(isBlind))
				saynn("- Тугость: "+restraintData.getVisibleTightness()+" ("+restraintData.getTightnessPercentString()+")")
			else:
				sayn(item.getVisibleName()+", С УМНЫМ ЗАМКОМ")
				var smartLock:SmartLockBase = restraintData.getSmartLock()
				var canBeSimplyRemoved = smartLock.canBeSimpleRemoved()
				saynn("- "+smartLock.getName()+": "+smartLock.getUnlockDescription()+(("\nОТКРЫТО. Можно снять") if canBeSimplyRemoved else ""))
				if(canBeSimplyRemoved):
					var minigameResult = MinigameResult.new()
					minigameResult.score = 1.0
					minigameResult.instantUnlock = true
					addButton(item.getVisibleName(), "Снять эту фиксацию", "struggleAgainst", [item.getUniqueID(), minigameResult])
				elif(smartLock.id == SmartLock.TightLock):
					addButton(item.getVisibleName(), "Посмотреть, какой предмет поможет открыть замок", "tightlock", [item.getUniqueID()])
				continue
			
			if(!restraintData.canStruggleFinal()):
				continue
			
			if(GM.pc.getStamina() > 0):
				addButton(item.getVisibleName(), "Сосредоточиться на этой фиксации", "startStruggleAgainst", [item.getUniqueID()])
			else:
				addDisabledButton(item.getVisibleName(), "Выносливость закончилась")

		
		#generateActions()
		
	if(state == "tightlock"):
		var item:ItemBase = GM.pc.getInventory().getItemByUniqueID(restraintID)
		var restraintData: RestraintData = item.getRestraintData()
		var requiredItemID:String = restraintData.getTightLockRequiredItemID()
		var reqItem:ItemBase = GlobalRegistry.getItemRef(requiredItemID)
		if(reqItem == null):
			saynn("Что-то пошло не так :(")
			addButton("Продолжить", "Ну и ладно", "endthescene")
		
		saynn("На "+item.getVisibleName()+" , которое на тебе надето, установлен тугой замок.")
		
		saynn("Чтобы открыть его, нужно использовать этот предмет: "+reqItem.getVisibleName())
		
		saynn("Предмет будет израсходован, а фиксация — разрушена.")
		
		saynn("Какой предмет хочешь использовать?")
		
		addButton("Отмена", "Вы передумали", "")
		for invitem in GM.pc.getInventory().getItems():
			if(invitem.id == requiredItemID):
				addButton(invitem.getVisibleName(), invitem.getVisibleDescription(), "tightlock_unlockwith", [invitem])
	
	if(state == "tightlock_unlocked"):
		saynn(actionText)
		
		addButton("Продолжить", "Смотреть, что будет дальше", "checkifokay")
		
	if(state == "usekey"):
		var keyAmount = GM.pc.getInventory().getAmountOf("restraintkey")
		saynn("У тебя есть "+str(keyAmount)+" "+Util.multipleOrSingularEnding(keyAmount, "key")+". Каждый может открыть один элемент снаряжения (если на нем нет смарт-замка).")
		saynn("Какое средство фиксации хочешь разблокировать?")

		for item in GM.pc.getInventory().getEquppedRestraints():
			var restraintData: RestraintData = item.getRestraintData()
			if(restraintData.hasSmartLock()):
				var smartLock:SmartLockBase = restraintData.getSmartLock()
				
				if(!smartLock.canBeUnlockedWithKeys()):
					addDisabledButton(item.getVisibleName(), "Смарт-замок на этом креплении нельзя открыть обычными ключами...")
					continue
				
				var howManyKeysToUnlock = smartLock.getKeysAmountToUnlock()
				if(keyAmount >= howManyKeysToUnlock):
					addButton(item.getVisibleName(), "Нужно ключей для разблокировки: "+str(howManyKeysToUnlock), "dounlock", [item.getUniqueID()])
				else:
					addDisabledButton(item.getVisibleName(), "Нужно ключей для разблокировки: "+str(howManyKeysToUnlock))
				continue
			
			if(!restraintData.canUnlockWithKey()):
				addDisabledButton(item.getVisibleName(), "Похоже, в этом креплении нет замочной скважины")
				continue
			addButton(item.getVisibleName(), item.getVisisbleDescription(), "dounlock", [item.getUniqueID()])
		addButton("Назад", "Ты не хочешь ничего разблокировать", "")

	if(state == "keyminigame"):
		saynn("Так как пальцы не слушаются, тебе приходится осторожно балансировать ключом между ладонями, направляя его к замку.")
		
		saynn("Чтобы успешно разблокировать крепление, нужно угадать число от 1 до 15. У тебя есть "+str(keyGameTries)+" "+Util.multipleOrSingularEnding(keyGameTries, "try", "tries")+" left")

		if(keyText != ""):
			saynn(keyText)

		#addTextbox("key_number")
		
		#addButton("Угадать", "Попробуй угадать это число", "key_guess")
		for _i in range(1, 16):
			addButton(str(_i), "Попробуй это число", "key_guess", [_i])

	if(state == "keyminigameFailed"):
		saynn("Ой, ты выронил ключ, и он сломался. Вот тебе и всё.")
		
		addButton("Продолжить", "Черт", "checkifokay")

	if(state == "startStruggleAgainst"):
		var item = GM.pc.getInventory().getItemByUniqueID(restraintID)
		var restraintData: RestraintData = item.getRestraintData()
		
		if(shouldPlayAnimations):
			var animToPlay = restraintData.getResistAnimation()
			if(animToPlay != null && animToPlay != ""):
				playAnimation(StageScene.Solo, animToPlay)
		
		var game = minigameScene.instance()
		GM.ui.addFullScreenCustomControl("minigame", game)
		#GM.ui.addCustomControl("minigame", game)
		if(OPTIONS.isHardStruggleEnabled()):
			game.setHardStruggleEnabled(true)
		if(GM.pc.hasPerk(Perk.BDSMInstantEscape) && game.has_method("instantEscapePerk")):
			game.instantEscapePerk()
		if(GM.pc.isBlindfolded() && game.has_method("setIsBlindfolded")):
			game.setIsBlindfolded(true)
		if(GM.pc.hasPerk(Perk.BDSMPerfectStreak) && game.has_method("setHasAdvancedPerk")):
			game.setHasAdvancedPerk(true)
		
		game.setDifficulty(restraintData.getLevel())
		game.connect("minigameCompleted", self, "onMinigameCompleted")
		addButton("Сдаться", "Прекратить борьбу и потерять 10 выносливости", "giveupstruggle")

	if(state == "struggleAgainst"):
		saynn(struggleText)
		
		if(additionalStruggleText != ""):
			saynn(additionalStruggleText)
		
		if(canKeepTheRestraint):
			saynn("Хочешь оставить это себе?")
			
			addButton("Оставить", "Оставить путы в инвентаре", "checkifokay")
			addButton("No", "Выбросить их", "getridandcheckifokay")
		else:
			addButton("Продолжить", "Окей", "checkifokay")
		

	if(state == "orgasm"):
		saynn("Это слишком... ты выгибаешься в спине и громко стонешь, кончая. Ты была настолько громкой, что кто-то мог тебя услышать. (Временный текст)")
		
		addButton("Продолжить", "О нет", "spottedcheck")

	if(state == "notspotted"):
		saynn("Похоже, никто тебя не видел и не слышал. Фух")
		
		if(GM.pc.getPain() >= GM.pc.painThreshold()):
			saynn("Но ты не можешь продолжать, боль слишком сильная")
			
			addButton("Продолжить", "Aw", "endthescene")
		else:
			addButton("Продолжить", "Хорошо", "")
		
	if(state == "toolusty"):
		saynn("Ты слишком возбуждена, чтобы вырваться из пут")
		
		addButton("Продолжить", "О нет", "endthescene")#"spottedcheck")
		
	if(state == "toopainful"):
		saynn("Это слишком больно! Ты издаешь отчаянный крик. Ты была настолько громкой, что кто-то мог тебя услышать. (Временный текст)")

		addButton("Продолжить", "О нет", "endthescene")
		
	if(state == "unlockedGear"):
		saynn("Вы успешно отперли фиксатор. Ключ переламывается пополам, становясь бесполезным")
		
		addButton("Продолжить", "Хорошо", "checkifokay")

func onMinigameCompleted(result:MinigameResult):
	GM.main.pickOption("struggleAgainst", [restraintID, result])
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "endthescenedidnothing"):
		endScene([false])
		return
		
	if(_action == "giveupstruggle"):
		GM.pc.addStamina(-10)
		restraintID = ""
		setState("")
		return
		
	if(_action == "tightlock"):
		restraintID = _args[0]
		
	if(_action == "startStruggleAgainst"):
		var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
		var restraintData: RestraintData = item.getRestraintData()
		
		if(!restraintData.shouldDoStruggleMinigame(GM.pc)):
			_action = "struggleAgainst"
		else:
			restraintID = _args[0]

	if(_action == "struggleAgainst"):
		var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
		var restraintData: RestraintData = item.getRestraintData()
		
		var minigameResult:MinigameResult
		if(_args.size() > 1):
			minigameResult = _args[1]
			
			if(minigameResult.score >= 1.0 && GM.pc.hasPerk(Perk.BDSMBetterStruggling)):
				minigameResult.score *= 2.0
		else:
			minigameResult = MinigameResult.new()
			minigameResult.score = 1.0
		
		var minigameScore:float = minigameResult.score
		var instantUnlock:bool = minigameResult.instantUnlock
		var fatallFail:bool = minigameResult.failedHard
		
		var damage = 0.0
		var addLust = 0
		var addPain = 0
		var addStamina = 0

		var struggleData = restraintData.doStruggle(GM.pc, minigameResult)
		
		if(struggleData.has("damage")):
			damage = struggleData["damage"]
			if(damage > 0.0 && instantUnlock):
				damage = 1.0
		if(struggleData.has("lust") && struggleData["lust"] > 0):
			addLust = struggleData["lust"]
		if(struggleData.has("pain") && struggleData["pain"] > 0):
			addPain = struggleData["pain"]
		if(struggleData.has("stamina") && struggleData["stamina"] != 0):
			addStamina = struggleData["stamina"]
		
		struggleText = struggleData["text"]
		
		if(!fightMode):
			var turnData = GM.pc.processStruggleTurn(true)
			damage += turnData["damage"]
			addLust += turnData["lust"]
			addPain += turnData["pain"]
			addStamina += turnData["stamina"]
			additionalStruggleText = turnData["text"]
			
		# less xp without progression more in combat
		if(!instantUnlock && damage > 0.0 && damage < 1.0):
			var mult = 4
			if fightMode:
				mult = 5
			GM.pc.addSkillExperience(Skill.BDSM, restraintData.getLevel() * mult)
			
		if(fatallFail):
			addMessage("Вы очень старались, но потерпели полный провал.")
		if(damage < 0.0):
			restraintData.takeDamage(damage)
			addMessage("Ты проиграл "+str(Util.roundF(-damage*100.0, 1))+"% oпрогресса")
		if(damage > 0.0):
			restraintData.takeDamage(damage)
			addMessage("Вы совершили "+str(Util.roundF(damage*100.0, 1))+"% oпрогресса ("+str(Util.roundF(minigameScore*100.0, 1))+"% efficiency)")
		if(addLust != 0):
			addLust = GM.pc.receiveDamage(DamageType.Lust, addLust)
			addMessage("Вы получили "+str(addLust)+" lust")
		if(addPain != 0):
			addPain = GM.pc.receiveDamage(DamageType.Physical, addPain)
			addMessage("Вы получили "+str(addPain)+" pain")
		if(addStamina != 0):
			GM.pc.addStamina(-addStamina)
			
			if(addStamina < 0):
				addMessage("Вы получили "+str(-addStamina)+" stamina")
			else:
				addMessage("Вы использовали "+str(addStamina)+" stamina")
		
		canKeepTheRestraint = false
		if(restraintData.shouldBeRemoved()):
			struggleText += "\n[b]"+restraintData.getRemoveMessage()+"[/b]"
			restraintData.onStruggleRemoval()
			GM.pc.getInventory().removeEquippedItem(item)
			
			if(!restraintData.alwaysBreaksWhenStruggledOutOf() && (GM.pc.hasPerk(Perk.BDSMCollector) || restraintData.alwaysSavedWhenStruggledOutOf())):
				canKeepTheRestraint = true
			
				GM.pc.getInventory().addItem(item)
				keptRestraintID = item.getUniqueID()
		
		processTime(1*60)
		
	if(_action == "getridandcheckifokay"):
		var item = GM.pc.getInventory().getItemByUniqueID(keptRestraintID)
		if(item != null):
			GM.pc.getInventory().removeItem(item)
		
	if(_action == "checkifokay" || _action == "getridandcheckifokay"):
		if(fightMode):
			endScene()
			return
		
		#if(GM.pc.getLust() >= GM.pc.lustThreshold()):
		#	setState("toolusty")
			#setState("orgasm")
			#GM.pc.orgasmFrom("pc")
		#	return
		#if(GM.pc.getPain() >= GM.pc.painThreshold()):
		#	setState("toopainful")
		#	return
		if(hasAnythingToInspect()):
			setState("")
		else:
			endScene()
		return
		
	if(_action == "spottedcheck"):
		setState("notspotted")
		return
		
	if(_action == "dounlock"):
		unlockedRestraintID = _args[0]
		var item = GM.pc.getInventory().getItemByUniqueID(unlockedRestraintID)
		var restraintData: RestraintData = item.getRestraintData()
		
		var howManyKeysToRemove:int = 1
		if(restraintData.hasSmartLock()):
			howManyKeysToRemove = restraintData.getSmartLock().getKeysAmountToUnlock()
		
		GM.pc.getInventory().removeXOfOrDestroy("restraintkey", howManyKeysToRemove)
		if(!GM.pc.hasBlockedHands() && !GM.pc.hasBoundArms()):
			if(restraintData == null || restraintData.alwaysBreaksWhenStruggledOutOf()):
				GM.pc.getInventory().removeEquippedItem(item)
			else:
				GM.pc.getInventory().unequipItem(item)
			setState("unlockedGear")
		else:
			keyGameTries = 3
			if(GM.pc.hasPerk(Perk.BDSMBetterKeys)):
				keyGameTries += 2
			keyGameValue = RNG.randi_range(1, 15)
			keyText = ""
			setState("keyminigame")
		return
	
	if(_action == "tightlock_unlockwith"):
		var item = GM.pc.getInventory().getItemByUniqueID(restraintID)
		var restraintData: RestraintData = item.getRestraintData()
		GM.pc.getInventory().removeEquippedItem(item)
		GM.pc.getInventory().removeItem(_args[0])
		actionText = restraintData.getTightLockUnlockMessage()
		setState("tightlock_unlocked")
		return
	
	if(_action == "key_guess"):
		
#		var textboxText = getTextboxData("key_number")
#		if(textboxText == "" || !textboxText.is_valid_integer()):
#			keyText = ""
#			setState("keyminigame")
#			return
		
		var number = _args[0]#int(textboxText)
		if(number == keyGameValue):
			var item = GM.pc.getInventory().getItemByUniqueID(unlockedRestraintID)
			var restraintData: RestraintData = item.getRestraintData()
			if(restraintData == null || restraintData.alwaysBreaksWhenStruggledOutOf()):
				GM.pc.getInventory().removeEquippedItem(item)
			else:
				GM.pc.getInventory().unequipItem(item)
			setState("unlockedGear")
			return
		
		var diff = abs(number - keyGameValue)
		if(number > keyGameValue):
			if(diff >= 8):
				keyText = str(number)+" даже близко нет. Ты чуть не выронил ключ прямо там"
			elif(diff >= 5):
				keyText = str(number)+" это уже чересчур"
			elif(diff >= 3):
				keyText = str(number)+" это слишком много"
			elif(diff >= 2):
				keyText = str(number)+" это многовато, но ты чувствуешь, что уже совсем рядом"
			else:
				keyText = str(number)+" очень близко."
		if(number < keyGameValue):
			if(diff >= 8):
				keyText = str(number)+" даже близко нет. Ты чуть не выронил ключ прямо там"
			elif(diff >= 5):
				keyText = str(number)+" это слишком мало"
			elif(diff >= 3):
				keyText = str(number)+" это маловато"
			elif(diff >= 2):
				keyText = str(number)+" это маловато, но ты чувствуешь, что уже совсем рядом"
			else:
				keyText = str(number)+" очень близко."
		
		keyGameTries -= 1
		if(keyGameTries <= 0):
			setState("keyminigameFailed")
		else:
			setState("keyminigame")
		return
		
	setState(_action)

func resolveCustomCharacterName(_charID):
	if(_charID == "user"):
		return "pc"

func saveData():
	var data = .saveData()
	
	data["unlockedRestraintID"] = unlockedRestraintID
	data["actionText"] = actionText
	data["struggleText"] = struggleText
	data["additionalStruggleText"] = additionalStruggleText
	data["canKeepTheRestraint"] = canKeepTheRestraint
	data["keptRestraintID"] = keptRestraintID
	data["keyGameTries"] = keyGameTries
	data["keyGameValue"] = keyGameValue
	data["keyText"] = keyText
	data["fightMode"] = fightMode
	data["restraintID"] = restraintID
	data["shouldPlayAnimations"] = shouldPlayAnimations
	
	return data
	
func loadData(data):
	.loadData(data)
	
	unlockedRestraintID = SAVE.loadVar(data, "unlockedRestraintID", "")
	actionText = SAVE.loadVar(data, "actionText", "")
	struggleText = SAVE.loadVar(data, "struggleText", "")
	additionalStruggleText = SAVE.loadVar(data, "additionalStruggleText", "")
	canKeepTheRestraint = SAVE.loadVar(data, "canKeepTheRestraint", false)
	keptRestraintID = SAVE.loadVar(data, "keptRestraintID", "")
	keyGameTries = SAVE.loadVar(data, "keyGameTries", 3)
	keyGameValue = SAVE.loadVar(data, "keyGameValue", 7)
	keyText = SAVE.loadVar(data, "keyText", "")
	fightMode = SAVE.loadVar(data, "fightMode", false)
	restraintID = SAVE.loadVar(data, "restraintID", "")
	shouldPlayAnimations = SAVE.loadVar(data, "shouldPlayAnimations", true)

func supportsShowingPawns() -> bool:
	return true
