extends SceneBase

var breastsMilked = false
var penisMilked = false
var vaginaMilked = false
var hasPenisPump = false
var amountCollected = 0.0
var removedItemIDs:Array = []

func _init():
	sceneID = "ElizaQuickMilkingScene"

func saveSlotToBeReequipped(_slot:String):
	var theItem:ItemBase = GM.pc.getInventory().unequipSlot(_slot)
	if(theItem && theItem.uniqueID != null):
		removedItemIDs.append(theItem.uniqueID)

func _reactInit():
	processTime(30*60)
	if(GM.pc.canBeMilked()):
		amountCollected += GM.main.SCI.processMilkPlayerBreasts()
		breastsMilked = true
		var thePump = GlobalRegistry.createItem("BreastPump")
		if(thePump):
			var theFluids = thePump.getFluids()
			if(theFluids):
				theFluids.addFluid("Milk", 400.0)

		saveSlotToBeReequipped(InventorySlot.UnderwearTop)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(thePump)
	if(GM.pc.hasReachablePenis() || GM.pc.isWearingChastityCage()):
		amountCollected += GM.main.SCI.processMilkPlayerPenis()
		penisMilked = true
	if(GM.pc.hasReachablePenis()):
		saveSlotToBeReequipped(InventorySlot.Penis)
		
		var thePump = GlobalRegistry.createItem("PenisPump")
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(thePump)
		hasPenisPump = true
	if(GM.pc.hasReachableVagina()):
		amountCollected += GM.main.SCI.processMilkPlayerVagina()
		vaginaMilked = true
	GM.pc.orgasmFrom("eliza")

func _run():
	if(state == ""):
		addCharacter("eliza")
		aimCameraAndSetLocName("med_milkingroom")
		playAnimation(StageScene.Sybian, "intense", {pc="pc", chained=true, bodyState={naked=true, hard=true}})
		saynn("Ты просишь Элизу доить тебя по полной... и твоё желание исполняется.")

		saynn("Элиза усаживает тебя на сибиан..."+str(" Пока пенисный насос ласкает твой член, а набор молокоотсосов сосет твои соски..." if (GM.pc.hasReachablePenis() && breastsMilked) else "")+""+str(" Пока пенисный насос ласкает твой член, а игрушка вибрирует у твоей простаты..." if (GM.pc.hasReachablePenis() && !breastsMilked) else "")+""+str(" Пока дилдо вибрирует у твоей простаты, а набор молокоотсосов сосет твои соски..." if (GM.pc.isWearingChastityCage() && breastsMilked) else "")+""+str(" Пока дилдо вибрирует у твоей простаты..." if (GM.pc.isWearingChastityCage() && !breastsMilked) else "")+""+str(" Пока набор молокоотсосов сосет твои соски..." if (!penisMilked && breastsMilked) else "")+"")

		saynn("Тебе не приходится долго ждать, чтобы кончить..."+str(" Твоя киска хлещет от гиперстимуляции, а твоя девичья конча стекает в воронку под решетчатой платформой..." if vaginaMilked else "")+""+str(" Твоя {pc.cum} вырывается из клетки целомудрия, а простата пульсирует..." if GM.pc.isWearingChastityCage() else "")+""+str(" Твой пульсирующий член наполняет пенисный насос мощными струями твоей {pc.cum}..." if GM.pc.hasReachablePenis() else "")+""+str(" Твоя грудь брызжет {pc.milk}..." if breastsMilked else "")+"")

		saynn("Когда всё заканчивается, Элиза отводит тебя обратно в лобби...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_removestuff")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "endthescene_removestuff"):
		var theInv := GM.pc.getInventory()
		if(hasPenisPump):
			theInv.clearSlot(InventorySlot.Penis)
		if(breastsMilked):
			theInv.clearSlot(InventorySlot.UnderwearTop)
		
		for theUniqueItemID in removedItemIDs:
			var theItem = theInv.getItemByUniqueID(theUniqueItemID)
			if(theItem):
				theInv.equipItem(theItem)
		
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		aimCameraAndSetLocName(GM.pc.getLocation())
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["breastsMilked"] = breastsMilked
	data["penisMilked"] = penisMilked
	data["vaginaMilked"] = vaginaMilked
	data["hasPenisPump"] = hasPenisPump
	data["amountCollected"] = amountCollected
	data["removedItemIDs"] = removedItemIDs

	return data

func loadData(data):
	.loadData(data)

	breastsMilked = SAVE.loadVar(data, "breastsMilked", false)
	penisMilked = SAVE.loadVar(data, "penisMilked", false)
	vaginaMilked = SAVE.loadVar(data, "vaginaMilked", false)
	hasPenisPump = SAVE.loadVar(data, "hasPenisPump", false)
	amountCollected = SAVE.loadVar(data, "amountCollected", 0.0)
	removedItemIDs = SAVE.loadVar(data, "removedItemIDs", [])
