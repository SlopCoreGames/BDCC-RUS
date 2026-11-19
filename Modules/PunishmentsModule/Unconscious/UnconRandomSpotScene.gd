extends "res://Scenes/SceneBase.gd"

var pantiesStolen:bool = false

func _init():
	sceneID = "UnconRandomSpotScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})

		saynn("Пока ты... крепко спишь... кто-то подошел к тебе... и начал утаскивать куда-то прочь...")
		
		addButton("Продолжить", "Смотри, что будет дальше...", "do_drag_pc_off")
	
	if(state == "do_drag_pc_off"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		playAnimation(StageScene.GivingBirth, "idle", {pc="pc"})
		
		saynn("После довольно неуютного сна ты наконец открываешь глаза... и понимаешь, что ты уже в другом месте...")
		
		if(pantiesStolen):
			saynn("По какой-то причине твоя задница кажется еще более холодной...")
		
		addButton("Встать", "Пора идти..", "endthescene")


func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "do_drag_pc_off"):
		var possibleLocs:Array = [
			"eng_near_storage",
			"yard_vaulthere",
			"main_green_corridor11",
			"med_mental5",
		]
		GM.pc.setLocation(RNG.pick(possibleLocs))
		processTime(RNG.randi_range(120, 300)*60)
		
		if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom)):
			var panties:ItemBase = GM.pc.getInventory().getEquippedItem(InventorySlot.UnderwearBottom)
			if(!panties.isRestraint()):
				if(RNG.chance(75)):
					addMessage("Твоя "+panties.getVisibleName()+" были украдены...")
					GM.pc.getInventory().removeItemFromSlot(InventorySlot.UnderwearBottom)
					pantiesStolen = true
		if(RNG.chance(50)):
			if(GM.pc.getCredits() > 5):
				GM.pc.addCredits(RNG.randi_range(2, 5))
				addMessage("Часть твоих кредитов была украдена...")
		if(RNG.chance(50)):
			for _i in range(RNG.randi_range(2, 6)):
				GM.pc.addBodywritingRandom()
			addMessage("На твоем теле что-то нацарапано...")
		if(OPTIONS.isContentEnabled(ContentType.Watersports)):
			if(RNG.chance(10)):
				GM.pc.pissedOnBy("pc")
				addMessage("Что это за запах... мерзость...")
		if(GM.pc.canBeMilked()):
			if(RNG.chance(30)):
				GM.pc.milk()
				GM.pc.addEffect(StatusEffect.SoreNipplesAfterMilking)
				addMessage("Ты чувствуешь, что твоя грудь стала... легче...")
		if(GM.pc.canBeSeedMilked()):
			if(RNG.chance(30)):
				GM.pc.orgasmFrom("pc")
				addMessage("Ты чувствуешь себя... опустошенной...")
		if(RNG.chance(20)):
			GM.pc.doWound()
			GM.pc.addPain(10)
			addMessage("Что это за... следы от зубов...")
	
	setState(_action)


func saveData():
	var data = .saveData()

	data["pantiesStolen"] = pantiesStolen

	return data

func loadData(data):
	.loadData(data)

	pantiesStolen = SAVE.loadVar(data, "pantiesStolen", false)
