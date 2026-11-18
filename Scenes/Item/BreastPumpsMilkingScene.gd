extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""
var temporaryAdded = false
var oldWornItemID = ""

func _init():
	sceneID = "BreastPumpsMilkingScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	if(GM.pc.hasEffect(StatusEffect.SoreNipplesAfterMilking)):
		setState("nipplessore")
		return
		
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	if(item == null):
		return
	
	if(!item.isWornByWearer()):
		if(!GM.pc.hasBlockedHands()):
			if(GM.pc.getInventory().hasSlotEquipped(item.getClothingSlotSafe())):
				var alreadyEquipped = GM.pc.getInventory().getEquippedItem(item.getClothingSlotSafe())
				if(alreadyEquipped != item && alreadyEquipped.isRestraint()):
					setState("restraintequipped")
					return
				if(alreadyEquipped != item):
					oldWornItemID = alreadyEquipped.getUniqueID()
					GM.pc.getInventory().unequipItem(alreadyEquipped)
			
			temporaryAdded = true
			GM.pc.getInventory().removeItem(item)
			GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(item)
			
		else:
			setState("blockedhands")

	processTime(6*60)
	GM.pc.stimulateLactation()
	if(!GM.pc.hasPerk(Perk.MilkNoSoreNipples)):
		GM.pc.addEffect(StatusEffect.SoreNipplesAfterMilking)
	GM.pc.addSkillExperience(Skill.Milking, 50)

	if(!GM.pc.canBeMilked()):
		setState("pumpfail")
		return
	
	var howMuchTransferred = GM.pc.getBodypart(BodypartSlot.Breasts).getFluids().transferTo(item, 1.0)
	addMessage("You managed to milk your breasts for "+str(Util.roundF(howMuchTransferred))+" ml")

func _run():
	if(state == ""):
		saynn("Ты не спешишь, прикрепляя молокоотсосы к своей {pc.breasts}, а затем нажимаешь кнопку, запуская их работу.")
		
		saynn("Сначала они работают медленно, нежно стимулируя соски слабым ритмом откачки, давая тебе привыкнуть к ощущениям. Это приятно... Вокруг сосков уже проступают одинокие капли {pc.milk}.")
		
		saynn("Мощность насосов постепенно нарастает; создаваемое ими отрицательное давление тянет твои маленькие соски, заставляя {pc.milk} выходить наружу всё активнее. Это вызывает покалывание... Пока, наконец, не устанавливается более сильный поток. Насосы аккуратно и чисто собирают всё, что производят твои груди.")
		
		saynn("Проходит какое-то время, насосы продолжают мерно работать на твоей груди. Ты невольно издаешь тихие стоны, когда тепло от твоих лактирующих буферов разливается по всему телу.")
		
		saynn("В конце концов ты решаешь, что хватит, и выключаешь насосы. Но ощущения продолжают отзываться в твоих возбужденных сосках даже после того, как всасывание прекратилось.")
		
		addButton("Продолжить", "Аккуратно", "endthescene")

	if(state == "pumpfail"):
		saynn("Ты не спешишь, прикрепляя молокоотсосы к своей {pc.breasts}, а затем нажимаешь кнопку, запуская их работу.")

		saynn("Сначала они работают медленно, нежно стимулируя соски слабым ритмом откачки, давая тебе привыкнуть к ощущениям. Это приятно... Даже если пока ничего не идет.")
		
		saynn("Мощность насосов постепенно нарастает; создаваемое ими отрицательное давление тянет твои маленькие соски, пытаясь выжать из них молоко. Это вызывает покалывание...")
		
		saynn("Проходит некоторое время, молокоотсосы мерно работают на твоей груди. Но так как ты не кормишь грудью, ничего не вышло. По крайней мере, соски получили хорошую стимуляцию.")
		
		addButton("Продолжить", "Справедливо", "endthescene")

	if(state == "nipplessore"):
		saynn("Твои соски слишком сильно болят после прошлого доения, дай себе передышку.")
		
		addButton("Продолжить", "Справедливо", "endthescene")

	if(state == "restraintequipped"):
		saynn("Ты не можешь надеть молокоотсосы, потому что грудь скована какими-то фиксаторами")
		
		addButton("Продолжить", "О-о-о...", "endthescene")

	if(state == "blockedhands"):
		saynn("Ты изо всех сил пытаешься надеть молокоотсосы, но скованные руки мешают тебе это сделать")
		
		addButton("Продолжить", "О-о-о...", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		if(temporaryAdded):
			var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
			GM.pc.getInventory().unequipItem(item)
			
			if(oldWornItemID != ""):
				var item2: ItemBase = GM.pc.getInventory().getItemByUniqueID(oldWornItemID)
				GM.pc.getInventory().equipItem(item2)
		
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	data["temporaryAdded"] = temporaryAdded
	data["oldWornItemID"] = oldWornItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
	oldWornItemID = SAVE.loadVar(data, "oldWornItemID", "")
	temporaryAdded = SAVE.loadVar(data, "temporaryAdded", false)
