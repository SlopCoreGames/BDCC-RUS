extends DrugDenEventBase

const sellList = {
	"painkillers": {
		costMin = 5,
		costMax = 10,
		buyLines = [
			"Это поможет тебе продержаться подольше, дорогуша!",
			"Поможет немного снять напряжение.",
			"Только не глотай слишком много за раз, милочка.",
		],
	},
	"appleitem": {
		costMin = 2,
		costMax = 7,
		buyLines = [
			"Свеженькие и сочные!",
			"Хороший выбор, любовь моя. Нечасто здесь встретишь настоящие фрукты!",
			"Это уж точно лучше, чем ковырять какую-нибудь странную пасту!",
		],
	},
	"AnaphrodisiacPill": {
		costMin = 3,
		costMax = 15,
		buyLines = [
			"Нужна светлая голова, а? Это как раз то, что доктор прописал, крошка.",
			"Хватай быстрее, пока кто-нибудь здесь не устроил... лишних проблем.",
			"Лучше держать умы острыми, а? Чтобы ни на что не отвлекаться.",
		],
	},
	"EnergyDrink": {
		costMin = 2,
		costMax = 10,
		buyLines = [
			"Для моего вкуса здесь маловато алкоголя.",
			"Немного бодрости на случай, если в туннелях станет совсем хреново. Не тормози, дорогуша!",
			"Этого хватит, чтобы тебя штырило еще какое-то время. Только постарайся не биться головой о стены.",
		],
	},
	"restraintkey": {
		costMin = 5,
		costMax = 20,
		buyLines = [
			"Спорим, ты рад это получить, а? Никогда не знаешь, когда приспичит.",
			"Теперь это твоё!",
			"Эта штука может спасти твою задницу!",
		],
	},
	"TFPill": {
		costMin = 5,
		costMax = 10,
		buyLines = [
			"Решила стать смелее, а? Удачи, милочка. Надеюсь, сюрпризы тебе по душе!",
			"О-о, любопытствуешь? С этой дрянью никогда не знаешь, что выкинет.",
			"Только потом не говори, что я тебя не предупреждала!",
		],
	},
	"BreederPill": {
		costMin = 2,
		costMax = 5,
		buyLines = [
			"Захотелось развлечься, а? Осторожнее, крошка. Эта штука меняет правила игры.",
			"Прими это, и ты будешь готова... ну, ко всему.",
			"Надеюсь, ты готова к тому, что это с тобой сделает, дорогуша. Возврата не будет.",
		],
	},
	"HeatPill": {
		costMin = 2,
		costMax = 5,
		buyLines = [
			"Ух ты, кто-то явно настроен на очень славное времяпровождение, а?",
			"Закинься этим и смотри, как мир становится... куда жарче~.",
			"Только будь наготове. Как только вштырит, тебя начнет неистово тянуть на что-нибудь~.",
		],
	},
	"StunBaton": {
		costMin = 10,
		costMax = 15,
		buyLines = [
			"Шокируй их до беспамятства, милочка! Лучшего способа держать торчков в узде не найти!",
			"Смотри, куда машешь этой штукой, солнце. Можно и зубы кому-нибудь выбить.",
			"Бззз-бззз! Эй, жахни их там слегка за меня, ладно?",
		],
	},
	"Shiv": {
		costMin = 10,
		costMax = 15,
		buyLines = [
			"Вплотную, да? Прямо как настоящий профи~.",
			"Просто, но смертоносно. Как раз то, что нужно в этой дыре.",
			"Достаточно остро, чтобы заставить любого призадуматься. Держи наготове, любовь моя!",
		],
	},
}

const weightList = {
	"painkillers": 0.3,
	"appleitem": 2.0,
	"AnaphrodisiacPill": 1.0,
	"EnergyDrink": 0.3,
	"restraintkey": 0.1,
	"TFPill": 0.3,
	"BreederPill": 0.2,
	"HeatPill": 0.2,
	"StunBaton": 0.1,
	"Shiv": 0.1,
}

const weightBetterList = {
	"painkillers": 1.0,
	"appleitem": 2.0,
	"AnaphrodisiacPill": 1.0,
	"EnergyDrink": 1.0,
	"restraintkey": 1.0,
	"TFPill": 0.3,
	"BreederPill": 0.2,
	"HeatPill": 0.2,
	"StunBaton": 0.5,
	"Shiv": 0.5,
}

var selling:Array = []
var hasBap:bool = false
var wasGroped:bool = false

func _init():
	id = "KidlatShop"
	eventWeight = 2.0

func onSpawn(_drugDen):
	generateItemsToSell()
	
	var itemsBoughtAmount:int = getDrugDenFlag("KidlatItemsBought", 0)
	if(itemsBoughtAmount > 0 && !getDrugDenFlag("KidlatBap", false) && RNG.chance(30) && !isKidlatBound()):
		hasBap = true

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return 2#0#RNG.randi_range(2, 10)

func getStartCooldown() -> int:
	return 1#RNG.randi_range(1, 2)

func getInteractInfo() -> Dictionary:
	return {
		text = "Вы замечаете здесь кого-то.",
		actions = [
			{
				id = "approach",
				name = "Подойти",
				desc = "Посмотреть, что там",
				args = [],
				disabled = false,
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	var scene1Hap:bool = getModuleFlag("Kidlat1Hap", false)
	
	if(!scene1Hap):
		setModuleFlag("Kidlat1Hap", true)
		return {sceneID="DrugDenKidlat1Scene"}
	
	var isFirstTimeInRun:bool = isFirstTimeThisRun()
	var isFirstTimeOnTheFloor:bool = isFirstTimeThisFloor()
	var scene2Hap:bool = getModuleFlag("Kidlat2Hap", false)
	var scene3Hap:bool = getModuleFlag("Kidlat3Hap", false)
	var itemsBoughtAmount:int = getModuleFlag("KidlatItemsBought", 0)
	var scene4Hap:bool = getModuleFlag("Kidlat4Hap", false)
	#var isLockedRandomly:bool = getModuleFlag("KidlatLockedUpRandomly", false)
	var isKidlatLocked:bool = GlobalRegistry.getModule("DrugDenModule").isKidlatBound()
	var scene5Hap:bool = getModuleFlag("Kidlat5Hap", false)
	var scene6Hap:bool = getModuleFlag("Kidlat6Hap", false)
	var scene7Hap:bool = getModuleFlag("Kidlat7Hap", false)
	
	if(!scene2Hap):
		if(isFirstTimeInRun && RNG.chance(100) && itemsBoughtAmount >= 3):
			setModuleFlag("Kidlat2Hap", true)
			return {sceneID="DrugDenKidlat2Scene"}
	
	if(scene2Hap && !scene3Hap):
		if(getDrugDenFlag("hasKidlatUniform", false)):
			setModuleFlag("Kidlat3Hap", true)
			setDrugDenFlag("hasKidlatUniform", false)
			return {sceneID="DrugDenKidlat3Scene"}
			
	if((scene3Hap && !scene4Hap)): #  || true
		if((isFirstTimeInRun && RNG.chance(100) && itemsBoughtAmount >= 6)): #  || true
			setModuleFlag("Kidlat4Hap", true)
			GlobalRegistry.getCharacter("kidlat").resetEquipment()
			return {sceneID="DrugDenKidlat4Scene"}
	
	if(scene5Hap && !scene6Hap && !isKidlatLocked):
		if(itemsBoughtAmount >= 9):
			# Kidlat6Hap flag gets set inside
			setModuleFlag("Kidlat6Knows", true)
			return {sceneID="DrugDenKidlat6Scene"}
	
	if(scene6Hap && !scene7Hap && !isKidlatLocked):
		if(isFirstTimeOnTheFloor && itemsBoughtAmount >= 12):
			# Kidlat7Hap flag gets set inside
			setModuleFlag("Kidlat7Knows", true)
			return {sceneID="DrugDenKidlat7Scene"}
	
	
	# Random locked Kidlat chance
	if((scene4Hap && isFirstTimeOnTheFloor && !isKidlatLocked)): # || true
		if(RNG.chance(5)):
			setModuleFlag("KidlatCustomShopGreet", "I triggered a trap again.. oopsie.. Welcome to my shop, whoever you are..")
			setModuleFlag("KidlatLockedUpRandomly", true)
			generateItemsToSell()
	
	GlobalRegistry.getCharacter("kidlat").resetEquipment()
	return {sceneID="DrugDenKidlatShopScene"}

func getMapIcon():
	return RoomStuff.RoomSprite.IMPORTANT

func getModuleFlag(flagID:String, default):
	return GM.main.getFlag("DrugDenModule."+flagID, default)

func setModuleFlag(flagID:String, newVal):
	return GM.main.setFlag("DrugDenModule."+flagID, newVal)

func isFirstTimeThisFloor():
	return getModuleFlag("KidlatShopFirstTimeFloor", false)

func isFirstTimeThisRun():
	return getModuleFlag("KidlatShopFirstTimeRun", false)

func isOutOfItems():
	for entry in selling:
		if(!entry["sold"]):
			return false
	return true

func addBuyButtons(_scene):
	for entry in selling:
		var itemID:String = entry["itemID"]
		var cost:int = entry["cost"]
		var wasSold:bool = entry["sold"]
		
		var itemRef:ItemBase = GlobalRegistry.getItemRef(itemID)
		
		if(itemRef == null):
			continue
		
		if(wasSold):
			_scene.addDisabledButton(itemRef.getVisibleName(), "Вы это уже покупали!\n\n"+itemRef.getVisibleDescription())
		elif(GM.pc.getCredits() < cost):
			_scene.addDisabledButton(itemRef.getVisibleName(), "Цена: "+str(cost)+" credit"+("s" if cost != 1 else "")+"\nНедостаточно кредитов!\n\n"+itemRef.getVisibleDescription())
		else:
			_scene.addButton(itemRef.getVisibleName(), "Цена: "+str(cost)+" credit"+("s" if cost != 1 else "")+"\n\n"+itemRef.getVisibleDescription(), "buyKidlatItem", [entry])
		
func doBuyItem(entry:Dictionary):
	var itemID:String = entry["itemID"]
	var cost:int = entry["cost"]
	var itemRef:ItemBase = GlobalRegistry.getItemRef(itemID)
	
	if(itemRef == null):
		return "Что-то пошло не так..."
	GM.pc.getInventory().addItem(GlobalRegistry.createItem(itemID))
	GM.pc.addCredits(-cost)
	
	GM.main.addMessage("Вы купили у "+itemRef.getAStackName()+" Кидлата!")
	entry["sold"] = true
	
	setModuleFlag("KidlatItemsBought", getModuleFlag("KidlatItemsBought", 0)+1)
	
	if(!sellList.has(itemID) || !sellList[itemID].has("buyLines")):
		return "Держи, дорогуша!"
	var sellEntry:Dictionary = sellList[itemID]
	return RNG.pick(sellEntry["buyLines"])

func doStealAll():
	for entry in selling:
		var itemID:String = entry["itemID"]
		#var cost:int = entry["cost"]
		var itemRef:ItemBase = GlobalRegistry.getItemRef(itemID)
		
		if(itemRef == null):
			continue
		GM.pc.getInventory().addItem(GlobalRegistry.createItem(itemID))
		GM.main.addMessage("Вы украли у "+itemRef.getAStackName()+" Кидлата!")
		entry["sold"] = true
		
		#setModuleFlag("KidlatItemsBought", getModuleFlag("KidlatItemsBought", 0)+1)

	return "Надеюсь, ты за это заплатила, мяу..."

func getItemsListText():
	var resultTexts:Array = []
	
	var _i:int = 1
	for entry in selling:
		var itemID:String = entry["itemID"]
		var cost:int = entry["cost"]
		var wasSold:bool = entry["sold"]
		
		var itemRef:ItemBase = GlobalRegistry.getItemRef(itemID)
		
		if(itemRef == null):
			continue
		resultTexts.append(str(_i)+") "+itemRef.getVisibleName()+". Cost: "+str(cost)+" credit"+("s" if cost != 1 else "")+(" (SOLD!)" if wasSold else ""))
		_i += 1
	
	if(hasBap && !isKidlatBound()):
		resultTexts.append(str(_i)+") Буханка хлеба. Цена: ? кредитов")
		_i += 1
		
	return Util.join(resultTexts, "\n\n")

func isBetterItems() -> bool:
	return getModuleFlag("Kidlat3Hap", false)

func isKidlatNaked() -> bool:
	return getModuleFlag("Kidlat2Hap", false) && !getModuleFlag("Kidlat3Hap", false)

func isKidlatBound() -> bool:
	return (getModuleFlag("Kidlat4Hap", false) && !getModuleFlag("Kidlat5Hap", false)) || getModuleFlag("KidlatLockedUpRandomly", false)

func getAmountOfItemsToSell() -> int:
	if(isKidlatBound()):
		return 1
	
	if(getModuleFlag("Kidlat2Hap", false) && !getModuleFlag("Kidlat3Hap", false)):
		return 2
	
	return 3

func generateItemsToSell():
	var howMany:int = getAmountOfItemsToSell()
	selling = []
	
	for _i in range(howMany):
		var nextEntryID:String = RNG.pickWeightedDict(weightList if !isBetterItems() else weightBetterList)
		
		if(!sellList.has(nextEntryID)):
			Log.printerr("MISSING ENTRY IN KIDLAT SHOP: "+str(nextEntryID))
			continue
		
		var entryInfo:Dictionary = sellList[nextEntryID]
		
		var cost:int = entryInfo["cost"] if entryInfo.has("cost") else 5
		if(entryInfo.has("costMin") && entryInfo.has("costMax")):
			cost = RNG.randi_range(entryInfo["costMin"], entryInfo["costMax"])
		
		if(getModuleFlag("Kidlat6Hap", false)):
			cost = int(round(cost*0.7))
			if(cost < 1):
				cost = 1
		
		selling.append({
			itemID = nextEntryID,
			cost = cost,
			sold = false,
		})
		

func applyVisitFlags():
	setModuleFlag("KidlatShopFirstTimeRun", false)
	setModuleFlag("KidlatShopFirstTimeFloor", false)

func onRunStart(_drugDen):
	setModuleFlag("KidlatShopFirstTimeRun", true)
	setModuleFlag("KidlatShopFirstTimeFloor", true)
	setModuleFlag("KidlatLockedUpRandomly", false)

func onRunEnd(_drugDen):
	setModuleFlag("KidlatShopFirstTimeRun", false)
	setModuleFlag("KidlatShopFirstTimeFloor", false)
	setModuleFlag("KidlatLockedUpRandomly", false)
	GlobalRegistry.getCharacter("kidlat").resetEquipment()

func onRunNextFloor(_drugDen):
	setModuleFlag("KidlatShopFirstTimeFloor", true)

func wasKidlatGroped() -> bool:
	return wasGroped

func saveData() -> Dictionary:
	return {
		selling = selling,
		hasBap = hasBap,
		wasGroped = wasGroped,
	}

func loadData(_data:Dictionary):
	selling = SAVE.loadVar(_data, "selling", [])
	hasBap = SAVE.loadVar(_data, "hasBap", false)
	wasGroped = SAVE.loadVar(_data, "wasGroped", false)
