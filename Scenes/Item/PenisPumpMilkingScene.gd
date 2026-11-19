extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""
var temporaryAdded = false
var oldWornItemID = ""

func _init():
	sceneID = "PenisPumpMilkingScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]
	
func _reactInit():
	if(uniqueItemID == null || uniqueItemID == ""):
		return
		
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	if(item == null):
		return
	
	if(!GM.pc.hasPenis()):
		setState("nopenis")
		return

	if(!item.isWornByWearer()):
		if(!GM.pc.hasReachablePenis()):
			setState("noreachpenis")
			return

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
	GM.pc.addSkillExperience(Skill.Breeder, 20, "penis_pump")

	
	var howMuchTransferred = GM.pc.getBodypart(BodypartSlot.Penis).getFluids().transferTo(item, 1.0)
	addMessage("Насос собрал "+str(Util.roundF(howMuchTransferred))+" мл твоего {pc.cum}")
	GM.pc.orgasmFrom("pc")

func _run():
	if(state == ""):
		playAnimation(StageScene.Sybian, "ride", {nosybian=true,bodyState={exposedCrotch=true}})
		
		saynn("При нажатии кнопки воздух наполняется мягким гулом — включается насос для члена, создавая стимулирующее всасывание.")
		
		saynn("С каждым качком ты чувствуешь, как возбуждение нарастает, а твой член отзывается пульсацией и подергиваниями, пока мягкое кольцо начинает ласкать его.")
		
		saynn("Из твоих уст начинают вырываться тихие стоны, сливающиеся с механическим звуком насоса.")
		
		saynn("Вскоре ты приближаешься к пику. Твое тело извивается, пока ритмичные толчки и всасывание мягко подталкивают тебя к самому краю.")
		
		saynn("С пылким стоном твой {pc.penis} начинает пульсировать и извергать густые струи {pc.cum}, которые насос тут же собирает.")
		
		saynn("После этого... ты выключаешь устройство.")
		
		addButton("Продолжить", "Аккуратно", "endthescene")

	if(state == "restraintequipped"):
		saynn("Ты не можешь надеть насос, потому что твой член что-то блокирует.")
		
		addButton("Продолжить", "О-о-о...", "endthescene")

	if(state == "blockedhands"):
		saynn("Ты изо всех сил пытаешься надеть насос, но скованные руки мешают тебе это сделать.")
		
		addButton("Продолжить", "О-о-о...", "endthescene")
	
	if(state == "nopenis"):
		saynn("Ты пытаешься надеть насос... но тут до тебя доходит, что у тебя нет члена... О нет...")
		
		saynn("Ты перепроверяешь еще раз... нет, точно нет..."+str(" У тебя есть только киска... Ты пытаешься накачать свою киску насосом... но этот конкретный аппарат работает за счет фрикций, а не создания отрицательного давления... так что ты с треском проваливаешься..." if GM.pc.hasReachableVagina() else ""))
		
		addButton("Продолжить", "О-о-о...", "endthescene")
	
	if(state == "noreachpenis"):
		saynn("Ты не можешь дотянуться до своего члена... так что не можешь надеть на него помпу...")
		
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
