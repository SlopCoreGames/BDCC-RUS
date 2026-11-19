extends DrugDenEventBase

var timesUsed:int = 0
var useCost:int = 1

func _init():
	id = "BrokenVendomat"

func onSpawn(_drugDen):
	useCost = RNG.randi_range(1, 3)

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return RNG.randi_range(2, 3)

func getStartCooldown() -> int:
	return RNG.randi_range(1, 3)

func getInteractInfo() -> Dictionary:
	return {
		text = "Ты нашел сломанный вендомат! Похоже, он все еще принимает кредиты..\n\nЦена: "+str(useCost)+"\nItem: UNKN??ERr..or??!",
		actions = [
			{
				id = "pay",
				name = "Оплатить "+str(useCost)+" credit"+("s" if useCost != 1 else ""),
				desc = "Оплатить "+str(useCost)+" credit"+("s" if useCost != 1 else "")+" и посмотрим, выйдет ли что-нибудь.",
				args = [],
				disabled = GM.pc.getCredits() < useCost,
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	GM.pc.addCredits(-useCost)
	
	timesUsed += 1
	
	var didBreak:bool = false
	if(timesUsed >= 3):
		var breakChance:float = sqrt(timesUsed)*10.0
		if(RNG.chance(breakChance)):
			didBreak = true
	
	var theText:String = "Вы позволяете вендомат забрать "+str(useCost)+" credit"+("s" if useCost != 1 else "")+" из тебя..."
	
	var theLoot = {
		"": 10.0,
		"appleitem": 1.0,
		"painkillers": 0.5,
		"AnaphrodisiacPill": 1.0,
		"EnergyDrink": 1.0,
		"restraintkey": 0.5,
		"TFPill": 0.2,
		"BreederPill": 0.1,
		"HeatPill": 0.1,
		"StunBaton": 0.2,
		"Shiv": 0.1,
	}
	
	var itemResult:String = RNG.pickWeightedDict(theLoot)
	
	if(itemResult == "" || GlobalRegistry.getItemRef(itemResult) == null):
		theText += "\n\nСпустя какое-то время вендомат выплевывает... Ничего.. Он ничего тебе не выдал."
	else:
		var theItem:ItemBase = GlobalRegistry.createItem(itemResult)
		GM.pc.getInventory().addItem(theItem)
		theText += "\n\nСпустя какое-то время вендомат выплевывает... [b]"+theItem.getAStackName()+"[/b]! Ура."
	
	if(didBreak):
		theText += "\n\nСвет внутри автомата гаснет... Кажется, он больше не работает."
	
	return {text=theText, ended=didBreak}
	

func getMapIcon():
	return RoomStuff.RoomSprite.IMPORTANT

func saveData() -> Dictionary:
	return {
		timesUsed = timesUsed,
	}

func loadData(_data:Dictionary):
	timesUsed = SAVE.loadVar(_data, "timesUsed", 0)
