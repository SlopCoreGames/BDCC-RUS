extends SceneBase

var donateText:String = ""
var recallMode:bool = false

func _init():
	sceneID = "NurseryBountyBoardScene"

func _initScene(_args = []):
	if(_args.size() > 0 && _args[0]):
		recallMode = true

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		var nurseryTasks:Array = GM.main.SCI.getNurseryTasks() if !recallMode else GM.main.SCI.peekNurseryTasks()
		
		if(!recallMode):
			saynn("Вы стоите перед голографической доской заказов. Она сканирует ваш ошейник... и выводит список доступных задач:")
		
		if(nurseryTasks.empty()):
			if(recallMode):
				if(GM.main.SCI.didGenerateNurseryTasksToday()):
					saynn("Вы не можете вспомнить ни одного незавершенного заказа... Пожалуй, стоит заглянуть на доску завтра.")
				else:
					saynn("Вы понятия не имеете, какие заказы сейчас на доске. Сходите-ка в детский сад и проверьте там!")
			else:
				saynn("- Задач больше нет, возвращайтесь завтра, зек!")
		else:
			for taskA in nurseryTasks:
				var task:NurseryTaskBase = taskA
				
				sayn("- "+task.getName())
				sayn(task.getDescription())
				var compString:String = task.getCompletionString()
				if(compString != ""):
					sayn(compString)
				sayn("Награда: "+task.getRewardString())
				saynn(task.getDeadlineString())
		
		if(getFlag("ElizaModule.s1hap", false) && GM.main.SCI.didGenerateNurseryTasksToday()):
			sayn("- ОСОБЫЙ ЗАКАЗ")
			var charIDWithDrug:String = GM.main.SCI.getRandomNpcIDForStrangeDrug()
			if(charIDWithDrug == "" || getCharacter(charIDWithDrug) == null):
				saynn("Сбор данных продолжается. Возвращайтесь завтра.")
			else:
				var theCharacter:BaseCharacter = getCharacter(charIDWithDrug)
				sayn(theCharacter.getName()+" известно, что у них есть опасная контрабанда. Убедите их сдать её.")
				sayn(NurseryTaskBase.getCharDescription(charIDWithDrug))
				sayn("Награда: Более безопасная обстановка для всех")
				saynn("Последний день до истечения срока выполнения")
		
		if(recallMode):
			addButton("Назад", "Хватит воспоминаний", "endthescene")
		else:
			saynn("Рядом с доской стоит автомат, принимающий любую емкость с жидкостью. В записке сказано, что контейнер будет полностью опустошен, а затем возвращен вам.")
			
			addButton("Пожертвовать", "Выберите емкость с жидкостью, которую хотите пожертвовать", "choose_donate")
			addButtonWithChecks("Пересдача (1 кредит)", "Заплатите 1 кредит, чтобы обновить все награды", "do_reroll", [], [[ButtonChecks.HasCredits, 1]])
			addButton("Уйти", "Пора идти", "endthescene")
	
	if(state == "do_reroll"):
		saynn("Вы нажимаете на кнопку, и все задания исчезают... точь-в-точь как один кредит с вашего счета заключенного.")

		saynn("Доска гудит, пытаясь придумать новые награды...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")

	if(state == "choose_donate"):
		saynn("Выберите емкость, которую хотите использовать для пожертвования.")
		
		saynn("Контейнер будет полностью опустошен и возвращен вам.")
		
		saynn("В объявлении утверждается, что 30% пожертвованной жидкости пойдет на разработку новых медицинских препаратов.")
		
		addButton("Назад", "Вы передумали", "")
		var equippedItems = GM.pc.getInventory().getAllEquippedItems()
		for slot in equippedItems:
			var equippedItem:ItemBase = equippedItems[slot]
			
			if(equippedItem.getFluids() != null):
				addButton(equippedItem.getStackName(), equippedItem.getVisisbleDescription(), "pickDonate", [equippedItem])
		for theitem in GM.pc.getInventory().getItems():
			if(theitem.getFluids() != null):
				if(theitem.getFluids().isEmpty()):
					addDisabledButton(theitem.getStackName(), "(Этот предмет пуст)\n\n"+theitem.getVisisbleDescription())
				else:
					addButton(theitem.getStackName(), theitem.getVisisbleDescription(), "pickDonate", [theitem])
	
	if(state == "pickDonate"):
		saynn("Вы вставляете свой "+donateText+" в донорский аппарат и позволяете ему делать свое дело.")
		
		saynn("Вскоре аппарат издает звуковой сигнал и возвращает вам ваш предмет.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "do_reroll"):
		GM.pc.addCredits(-1)
		GM.main.SCI.rerollTasks()
		
	if(_action == "pickDonate"):
		var item:ItemBase = _args[0]
		donateText = item.getVisibleName()
		
		var fluids:Fluids = item.getFluids()
		
		var fluidAmmounts:Dictionary = fluids.getFluidAmountByType()
		
		for fluidID in fluidAmmounts:
			var fluidAmount:float = fluidAmmounts[fluidID]
			
			GM.main.SCI.handleBountyFluid(fluidID, fluidAmount)
			GM.main.SCI.addFluid(fluidID, fluidAmount*0.3)
		fluids.clear()

	setState(_action)

func getDebugActions():
	var fluidValues:Array = []
	for fluidID in GlobalRegistry.getFluids():
		fluidValues.append([fluidID, fluidID])
	var tfValues:Array = []
	for tfID in GlobalRegistry.getTransformationRefs():
		var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
		tfValues.append([tfID, tf.getPillName()+" ("+tf.getName()+")"])
	
	return [
	{
		"id": "completeTasks",
		"name": "Complete all tasks",
		"args": [
		],
	},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "completeTasks"):
		while(!GM.main.SCI.peekNurseryTasks().empty()):
			var task = GM.main.SCI.peekNurseryTasks()[0]
			task.completeSelf()

func saveData():
	var data = .saveData()

	data["donateText"] = donateText
	data["recallMode"] = recallMode

	return data

func loadData(data):
	.loadData(data)

	donateText = SAVE.loadVar(data, "donateText", "")
	recallMode = SAVE.loadVar(data, "recallMode", false)
