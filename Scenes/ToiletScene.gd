extends "res://Scenes/SceneBase.gd"

var usedItemName = ""

func _init():
	sceneID = "ToiletScene"

func _run():
	if(state == ""):
		saynn("Вы находите пустую кабинку туалета и заходите в неё. Затем вы садитесь на унитаз и погружаетесь в раздумья.")
		
		addButton("Наполнить что-нибудь", "Может, вы хотите наполнить один из своих предметов?", "fillmenu")
		addButton("Уйти", "Хватит раздумий", "endthescene")
		
	if(state == "fillmenu"):
		saynn("Чем именно вы хотите наполнить?")
		
		if(GM.pc.getFluidAmount(FluidSource.Pissing) >= 100):
			if(GM.pc.isWearingPortalPanties()):
				addDisabledButton("Помочиться в...", "Ваши портальные трусики не позволяют вам мочиться прямо в контейнеры")
			elif(GM.pc.getInventory().getItemsWithTag(ItemTag.CanPeeInto).size() == 0):
				addDisabledButton("Помочиться в...", "У вас нет с собой никаких бутылок, чтобы помочиться в них")
			else:
				addButton("Помочиться в...", "Пописать в одну из своих бутылок", "peeintomenu")
		else:
			addDisabledButton("Помочиться в...", "Не особо хочется писать")
		if(GM.pc.hasEffect(StatusEffect.HasCumInsideAnus) || GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
			if(GM.pc.getInventory().getItemsWithTag(ItemTag.CanForceCumInto).size() == 0):
				addDisabledButton("Выдавить сперму...", "У тебя нет бутылок, чтобы выдавливать в них сперму")
			else:
				addButton("Выдавить сперму...", "Выдавить сперму из одного из своих отверстий", "pushcummenu")
		else:
			addDisabledButton("Выдавить сперму...", "В твоих отверстиях нет спермы")
		addButton("Назад", "Проехали", "")

	if(state == "peeintomenu"):
		saynn("Выбери, в какую емкость хочешь пописать")
		
		var items = GM.pc.getInventory().getItemsWithTag(ItemTag.CanPeeInto)
		
		for item in items:
			if(item.getFluids().isFull()):
				addDisabledButton(item.getStackName(), item.getVisisbleDescription())
			else:
				addButton(item.getStackName(), item.getVisisbleDescription(), "peeinto", [item.getUniqueID()])
		
		addButton("Назад", "Проехали", "fillmenu")
	
	if(state == "peeinto"):
		saynn("Вы держите "+usedItemName+" руками чуть выше унитаза, а затем осторожно начинаете в него мочиться.")
		
		addButton("Продолжить", "Какое облегчение!", "")
		
	if(state == "pushcummenu"):
		saynn("Из какого отверстия ты хочешь выдавить сперму?")
		
		if(GM.pc.hasReachableVagina()):
			if(GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
				addButton("Вагина", "Выбрать киску", "pushcumvaginamenu")
			else:
				addDisabledButton("Вагина", "В твоей киске нет спермы")
		else:
			addDisabledButton("Вагина", "Твоя киска находится вне зоны досягаемости")
		
		if(GM.pc.hasReachableAnus()):
			if(GM.pc.hasEffect(StatusEffect.HasCumInsideAnus)):
				addButton("В анус", "Выбрать анус", "pushcumanusmenu")
			else:
				addDisabledButton("В анус", "В твоем анусе нет спермы")
		else:
			addDisabledButton("В анус", "Твой анус недоступен")
			
		addButton("Назад", "Проехали", "fillmenu")
		
	if(state in ["pushcumvaginamenu", "pushcumanusmenu"]):
		saynn("Выбери, какой контейнер хочешь использовать")
		
		var items = GM.pc.getInventory().getItemsWithTag(ItemTag.CanForceCumInto)
		
		for item in items:
			if(item.getFluids().isFull()):
				addDisabledButton(item.getStackName(), item.getVisisbleDescription())
			else:
				addButton(item.getStackName(), item.getVisisbleDescription(), state+"do", [item.getUniqueID()])
		
		addButton("Назад", "Проехали", "fillmenu")
		
	if(state == "pushcumvaginamenudo"):
		saynn("Вы держите "+usedItemName+" терпеливо прижмись к своей киске и попытайся выдавить из себя всю жидкость, что в тебе есть.")
		
		saynn("Это медленный процесс, поэтому тебе удается выдавить лишь немного..")
		
		addButton("Продолжить", "Какое облегчение!", "")
		
	if(state == "pushcumanusmenudo"):
		saynn("Вы держите "+usedItemName+" терпеливо прижмись к своему анусу и попытайся выдавить из себя всю жидкость, что в тебе есть.")
		
		saynn("Это медленный процесс, поэтому тебе удается выдавить лишь немного..")
		
		addButton("Продолжить", "Какое облегчение!", "")
		
func _react(_action: String, _args):
	if(_action == "peeinto"):
		processTime(5*60)
		setFlag("LastTimePeed", GM.main.getTimeInGlobalSeconds())
		
		var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
		if(item != null):
			var howMuch = GM.pc.cumInItem(item, FluidSource.Pissing)
			usedItemName = item.getVisibleName()
			
			addMessage("You fill the "+usedItemName+" with "+str(Util.roundF(howMuch, 1))+" ml of your piss")
	
	if(_action == "pushcumvaginamenudo"):
		processTime(10*60)
		
		var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
		if(item != null):
			var howMuch = GM.pc.getBodypart(BodypartSlot.Vagina).getFluids().transferTo(item, RNG.randf_range(0.1, 0.3))
			usedItemName = item.getVisibleName()
			
			addMessage("You manage to fill the "+usedItemName+" with "+str(Util.roundF(howMuch, 1))+" ml of stuff")
	
	if(_action == "pushcumanusmenudo"):
		processTime(10*60)
		
		var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
		if(item != null):
			var howMuch = GM.pc.getBodypart(BodypartSlot.Anus).getFluids().transferTo(item, RNG.randf_range(0.1, 0.3))
			usedItemName = item.getVisibleName()
			
			addMessage("You manage to fill the "+usedItemName+" with "+str(Util.roundF(howMuch, 1))+" ml of stuff")
	
	
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["usedItemName"] = usedItemName
	
	return data
	
func loadData(data):
	.loadData(data)
	
	usedItemName = SAVE.loadVar(data, "usedItemName", "")
