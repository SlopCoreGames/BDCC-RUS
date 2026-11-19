extends "res://Modules/DrugDenModule/DrugDen/DrugDenEncounterTemplateScene.gd"

var offerItemID:String = ""

func _init():
	sceneID = "DrugDenEventWhoreScene"

func _reactInit():
	npcID = generateJunkieNPCID()
	addCharacter(npcID)
	#startFightWithNPC()
	
	var theLoot = {
		"appleitem": 1.0,
		"painkillers": 0.5,
		"AnaphrodisiacPill": 1.0,
		"EnergyDrink": 1.0,
		"restraintkey": 1.0,
		"TFPill": 0.5,
		"BreederPill": 0.1,
		"HeatPill": 0.1,
		"StunBaton": 0.05,
		"Shiv": 0.3,
	}
	if(GM.pc.getPainLevel() > 0.6):
		theLoot["appleitem"] *= 4.0
		theLoot["painkillers"] *= 4.0
		theLoot["Shiv"] *= 4.0
	if(GM.pc.getStaminaLevel() < 0.3):
		theLoot["EnergyDrink"] *= 4.0
		theLoot["Shiv"] *= 4.0
	if(GM.pc.hasActiveTransformations()):
		theLoot["TFUndoPill"] = 4.0
	if(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.BDSMRestraint).size() > 0):
		theLoot["restraintkey"] *= 4.0
	offerItemID = RNG.pickWeightedDict(theLoot)

func _run():
	encounter_run()
	
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		var itemRef:ItemBase = GlobalRegistry.getItemRef(offerItemID)
		var itemName:String = "какой-то неизвестный предмет"
		if(itemRef != null):
			itemName = itemRef.getAStackName()
		
		saynn("Когда ты идешь по тускло освещенным туннелям, тебе попадается торчок. Этот вроде не настроен на агрессию, а?")
		
		saynn("[say=npc]"+RNG.pick([
			"Ну надо же... гляньте-ка. Нечасто к нам сюда свежее мясо забредает. У меня есть для тебя предложение.",
			"А жопка у тебя что надо. Есть для тебя предложение.",
			"А ну стоять, новенькая. У меня есть небольшое предложение для такой шлюхи, как ты.",
			"От тебя не несет той же гнилью, что и от остальных. У меня есть для тебя предложение.",
		])+"[/say]")
		
		saynn("Торчок показывает тебе [b]"+itemName+"[/b] в {npc.his} руке.")
		
		saynn("[say=npc]"+RNG.pick([
			"Что-то я сегодня щедрая. Отдам тебе это, если ты сейчас же нагнёшься передо мной.",
			"Хочешь это? А ну раздвинь ноги.",
			"Если хочешь это, тебе придется раздвинуть ноги.",
		])+"[/say]")
		
		saynn("Похоже, {npc.he} хочет трахнуть тебя...")
		
		addButton("Согласиться (быть подстилкой)", "Можно и развлечься", "agree_sex")
		addButton("Атаковать", "Сразиться с ними", "startFight")
		addButton("Свалить", "Сказать им, чтобы проваливали", "say_get_lost")
	
	if(state == "sexSatisfied"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		var itemRef:ItemBase = GlobalRegistry.getItemRef(offerItemID)
		var itemName:String = "какой-то неизвестный предмет"
		if(itemRef != null):
			itemName = itemRef.getAStackName()
		
		saynn("После секса торчок дает тебе "+itemName+"!")
		
		saynn("[say=npc]"+RNG.pick([
			"Неплохо для дешёвой шлюхи.",
			"Вот твой приз, маленькая шлюшка.",
			"Ты это заслужила, маленькая шлюшка.",
			"Надеюсь, мы еще встретимся, маленькая шлюшка.",
			"Хорошая сучка. Вот, держи.",
		])+"[/say]")
		
		addButton("Продолжить", "Пора идти", "endthescene")
	
	if(state == "sexNotSatisfied"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Наркоман отказывается отдавать тебе предмет!")
		
		saynn("[say=npc]"+RNG.pick([
			"Ну и дрянь же ты! Пошла нахуй, проваливай.",
			"Ты такая плохая шлюха, с чего бы мне тебе что-то давать?",
			"Отъебись, из тебя никудышная шлюха.",
		])+"[/say]")
		
		
		addButton("Уйти", "Ну и ладно", "endthescene")
		addButton("Атаковать", "Сразиться с ними", "startFight")
	
	if(state == "say_get_lost"):
		saynn("Ты посылаешь {npc.him} куда подальше и идешь дальше.")
		
		addButton("Уйти", "Пора идти", "endthescene")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "startFight"):
		startFightWithNPC("DrugDenWhoreAttack")
		return
	if(_action == "agree_sex"):
		runScene("GenericSexScene", [npcID, "pc", SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}], "prostitutionSex")
		return
	if(encounter_react(_action, _args)):
		return
	
	setState(_action)

func _react_scene_end(_tag, _result):
	._react_scene_end(_tag, _result)
	
	if(_tag == "prostitutionSex"):
		var sexResult:SexEngineResult = _result[0]
		var domSatisfaciton:float = sexResult.getDomSatisfaction(npcID)
		var gotUncon:bool = sexResult.isSubUnconscious("pc")
		
		if(gotUncon):
			setState("encounter_fully_rekt")
			return
		
		if(domSatisfaciton >= 0.9):
			setState("sexSatisfied")
			
			GM.pc.getInventory().addItem(GlobalRegistry.createItem(offerItemID))
		else:
			setState("sexNotSatisfied")
		
		
func saveData():
	var data = .saveData()
	
	data["offerItemID"] = offerItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	offerItemID = SAVE.loadVar(data, "offerItemID", "")
