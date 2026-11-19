extends EventBase

func _init():
	id = "SlaveryWalkiesInteractionEvents"

var peeSpots = ["yard_eastCorridor", "yard_northCorridor", "yard_westCorridor"]
var playSpots = ["yard_deadend1", "yard_deadend2", "yard_waterfall", "yard_vaulthere"]

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_bathroom1")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_bathroom2")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_dressing1")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_dressing2")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_punishment_spot")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "fight_slutwall")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "medical_nursery")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "hall_canteen")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "main_laundry")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "med_lobbymain")
	es.addTrigger(self, Trigger.EnteringRoomWithSlave, "med_researchlab")
	for theSpot in peeSpots:
		es.addTrigger(self, Trigger.EnteringRoomWithSlave, theSpot)
	for theSpot in playSpots:
		es.addTrigger(self, Trigger.EnteringRoomWithSlave, theSpot)

func run(_triggerID, _args):
	var locName = _args[0]
	var npcID = _args[1]
	var walkiesType = ""
	if(_args.size() > 2):
		walkiesType = _args[2]
	var theChar:DynamicCharacter = GlobalRegistry.getCharacter(npcID)
	var npcSlavery:NpcSlave = theChar.getNpcSlavery()
	
	if(locName in ["hall_canteen"]):
		if(walkiesType == "walkies"):
			if(npcSlavery.getActivityID() == "Walkies" && npcSlavery.getActivity().petWants == "food"):
				addButton("Столовая (Питомец)", "Покорми своего щеночка!", "start_pet_canteen", [npcID])
			else:
				addDisabledButton("Столовая (Питомец)", "Твой щеночек не голоден")
	
	if(locName in ["main_laundry"]):
		if(theChar.canRepairClothes()):
			addButtonWithChecks("Починить одежду (Рабыня)", "Потратить 5 кредитов, чтобы починить одежду своей рабыни", "do_repair_clothes", [theChar], [[ButtonChecks.HasCredits, 5]])
		else:
			addDisabledButton("Починить одежду (Рабыня)", "Одежда твоей рабыни выглядит вполне прилично")
		
	if(locName in ["main_bathroom1", "main_bathroom2"]):
		if(npcSlavery.getLevel() >= 3):
			addButton("Зеркало (Рабыня)", "Изменить прическу рабыни", "starthair", [npcID])
		else:
			addDisabledButton("Зеркало (Рабыня)", "Требуется уровень рабыни 3+")
		
		if(npcSlavery.getActivityID() == "Walkies" && npcSlavery.getActivity().petWants == "pee"):
			addButton("Писсуары (Питомцы)", "Помочь своему щеночку справить нужду", "start_pee", [npcID])

	if(locName in peeSpots):
		if(npcSlavery.getActivityID() == "Walkies" && npcSlavery.getActivity().petWants == "pee"):
			addButton("Кусты (Питомцы)", "Помочь своему щеночку справить нужду", "start_pee", [npcID])

	if(locName in playSpots):
		if(npcSlavery.getActivityID() == "Walkies" && npcSlavery.getActivity().petWants == "play"):
			addButton("Играть (Питомцы)", "Похоже, это отличное место, чтобы поиграть со своим питомцем", "start_play", [npcID])
		if(npcSlavery.getActivityID() == "Walkies" && npcSlavery.getActivity().petWants == "train"):
			addButton("Дрессировка (Питомцы)", "Похоже, это отличное место, чтобы обучить питомца новым трюкам", "start_train", [npcID])


	if(locName in ["main_dressing1", "main_dressing2"]):
		addButton("Душ (Рабыни)", "Заставить рабыню принять душ", "startshower", [npcID, walkiesType])

	if(locName in ["main_punishment_spot"]):
		addButton("Колодки (Рабыня)", "Посадить рабыню в колодки", "startstocks", [npcID])

	if(locName in ["fight_slutwall"]):
		addButton("Стена шлюх (Рабыня)", "Загнать рабыню в стену шлюх", "startslutwall", [npcID])

	if(locName in ["medical_nursery"]):
		if(theChar.isReadyToGiveBirth()):
			addButton("Роды (Рабыня)", "Заставить рабыню рожать", "givebirth", [npcID])
		else:
			addDisabledButton("Роды (Рабыня)", "Рабыня не беременна или еще не готова к родам")
	
	if(locName == "med_lobbymain"):
		if(theChar.hasEffect(StatusEffect.Wounded) || theChar.hasEffect(StatusEffect.StretchedPainfullyAnus) || theChar.hasEffect(StatusEffect.StretchedPainfullyPussy)):
			addButton("Лечить", "Попросить врачей вылечить твою рабыню", "doHeal", [theChar])
	
	if(locName == "med_researchlab"):
		if(GM.main.SCI.hasUpgrade("shower1")):
			var hasCumOnBody:bool = theChar.hasEffect(StatusEffect.CoveredInCum)
			var hasCumInside:bool = theChar.hasEffect(StatusEffect.HasCumInsideAnus) || theChar.hasEffect(StatusEffect.HasCumInsideVagina) || theChar.hasEffect(StatusEffect.HasCumInsideMouth)
			
			if(hasCumOnBody):
				addButton("Душ в биолаборатории", "Заставить рабыню принять особый душ для сбора жидкостей", "doBioShower", [theChar])
			if(GM.main.SCI.hasUpgrade("shower2") && hasCumInside):
				addButton("Душ в биолаборатории (+внутри)", "Заставить рабыню принять особый душ для сбора жидкостей. Включая жидкости из её дырочек", "doBioShowerInside", [theChar])
	
func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "doBioShower"):
		GM.main.SCI.doNPCShower(_args[0])
	if(_method == "doBioShowerInside"):
		GM.main.SCI.doNPCShower(_args[0])
		GM.main.SCI.doNPCShowerInside(_args[0])
	if(_method == "do_repair_clothes"):
		GM.pc.addCredits(-5)
		_args[0].repairAllClothes()
		addMessage("Одежда вашей рабыни отремонтирована!")
		GM.main.reRun()
	if(_method == "doHeal"):
		var theChar:BaseCharacter = _args[0]
		theChar.removeEffect(StatusEffect.Wounded)
		theChar.removeEffect(StatusEffect.StretchedPainfullyAnus)
		theChar.removeEffect(StatusEffect.StretchedPainfullyPussy)
		addMessage("Ваша рабыня исцелена!")
		GM.main.reRun()
	if(_method == "starthair"):
		runScene("ActionSlaveryHaircut", [_args[0]])
	if(_method == "startshower"):
		if(_args[1] == "walkies"):
			runScene("SlaveryPetWalkiesShower", [_args[0]])
		else:
			runScene("ActionSlaveryShower", [_args[0]])
	if(_method == "startstocks"):
		GM.main.endCurrentScene()
		runScene("PunishSlaveryLeaveInStocks", [_args[0]])
	if(_method == "startslutwall"):
		GM.main.endCurrentScene()
		runScene("PunishSlaveryLeaveInSlutwall", [_args[0]])
	if(_method == "givebirth"):
		runScene("SlaveryHelpGiveBirth", [_args[0]])
	if(_method == "start_pet_canteen"):
		runScene("SlaveryPetWalkiesCanteen", [_args[0]])
	if(_method == "start_pee"):
		runScene("SlaveryPetWalkiesPee", [_args[0]])
	if(_method == "start_play"):
		runScene("SlaveryPetWalkiesPlay", [_args[0]])
	if(_method == "start_train"):
		runScene("SlaveryPetWalkiesTrain", [_args[0]])
