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
		var itemName:String = "an unknown item"
		if(itemRef != null):
			itemName = itemRef.getAStackName()
		
		saynn("Когда ты идешь по тускло освещенным туннелям, тебе попадается торчок. Этот вроде не настроен на агрессию, а?")
		
		saynn("[say=npc]"+RNG.pick([
			"Well, well.. look at this. Ain’t often we get fresh meat down here. I got an offer for you.",
			"That's a nice ass you got there. I got an offer for you.",
			"Stop right there, fresh blood. I got a little offer for a slut like you.",
			"You don't let off the same rotten scent that everyone else does. I got an offer for you.",
		])+"[/say]")
		
		saynn("Торчок показывает тебе [b]"+itemName+"[/b] в {npc.his} руке.")
		
		saynn("[say=npc]"+RNG.pick([
			"I’m feeling generous. I will give you this if you bend over for me.",
			"Do you want this? Spread your legs for me.",
			"If you want this, you will have to spread your legs for me.",
		])+"[/say]")
		
		saynn("Похоже, {npc.he} хочет трахнуть тебя...")
		
		addButton("Согласиться (быть подстилкой)", "Можно и развлечься", "agree_sex")
		addButton("Атаковать", "Сразиться с ними", "startFight")
		addButton("Свалить", "Сказать им, чтобы проваливали", "say_get_lost")
	
	if(state == "sexSatisfied"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		var itemRef:ItemBase = GlobalRegistry.getItemRef(offerItemID)
		var itemName:String = "an unknown item"
		if(itemRef != null):
			itemName = itemRef.getAStackName()
		
		saynn("После секса торчок дает тебе "+itemName+"!")
		
		saynn("[say=npc]"+RNG.pick([
			"Not bad for a cheap whore.",
			"Here is your prize, little whore.",
			"You earned it, little whore.",
			"I hope I will run into you again, little slut.",
			"Good slut. Here you go.",
		])+"[/say]")
		
		addButton("Продолжить", "Пора идти", "endthescene")
	
	if(state == "sexNotSatisfied"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Наркоман отказывается отдавать тебе предмет!")
		
		saynn("[say=npc]"+RNG.pick([
			"That sucked! Fuck you, go away.",
			"You're such a bad whore, why would I give you anything.",
			"Fuck off, you suck as a whore.",
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
