extends NpcOwnerEventBase

func _init():
	id = "RelationshipInfo"

func onStart(_args:Array):
	setSubResult(SUB_CONTINUE)

func start():
	playStand()
	saynn("Информация об отношениях (рабство):")
	var theNpcOwner := getNpcOwner()
	if(theNpcOwner):
		saynn(Util.join(theNpcOwner.getRelationshipFullInfo(), "\n"))
	
	addButton("Закрыть", "Ты уже достаточно навидался", "endEvent")
	if(theNpcOwner):
		if(theNpcOwner.canChooseApproachDays()):
			addButton("Частота", "Настрой, как часто твой хозяин будет подходить к тебе", "setState", ["approachMenu"])
		else:
			addDisabledButton("Частота", "Ваши отношения еще недостаточно развиты...")
		if(theNpcOwner.canChooseToDisableSleepTogether()):
			addButton("Переспать", "Выбери, хочешь ли ты переспать со своим хозяином", "setState", ["sleepTogetherMenu"])
		else:
			addDisabledButton("Переспать", "Ваши отношения еще недостаточно развиты...")

func sleepTogetherMenu():
	saynn("Хочешь спать вместе со своим хозяином?")
	
	var curSelText:String = "Random"
	if(getNpcOwner().isSleepTogetherDisabled()):
		curSelText = "Never"
	if(getNpcOwner().isSleepTogetherAlways()):
		curSelText = "Always"
	saynn("Текущий выбор: "+curSelText)
	
	addButton("Назад", "Хватит выбирать", "setState", ["start"])
	addButton("Случайно", "Хозяин будет иногда спать с тобой", "setSleep", [0])
	addButton("Никогда", "Хозяин никогда не будет спать с тобой", "setSleep", [1])
	addButton("Всегда", "Хозяин всегда будет пытаться переспать с тобой", "setSleep", [2])

func sleepTogetherMenu_do(_id:String, _args:Array):
	if(_id == "setSleep"):
		getNpcOwner().sleepTogetherOption = _args[0]

func approachMenu():
	addButton("Назад", "Хватит выбирать", "setState", ["start"])
	var theNpcOwner := getNpcOwner()
	if(!theNpcOwner):
		return
	
	saynn("Вы можете сами выбрать, как часто {npc.name} будет подходить к вам.")
	
	var theCurrentFreq:int = theNpcOwner.nextApproachOverride
	if(theCurrentFreq <= 0):
		saynn("Сейчас частота подходов зависит от решения вашего хозяина.")
	else:
		saynn("Сейчас ваш хозяин будет подходить к вам каждые "+str(theCurrentFreq)+" day"+("s" if theCurrentFreq != 1 else "")+".")
	
	var possible:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30]
	for _days in possible:
		if(_days <= 0):
			addButton("На усмотрение хозяина", "Пусть хозяин сам решает, как часто подходить к вам", "setDays", [_days])
		else:
			addButton(str(_days)+" day"+("s" if _days != 1 else ""), "Выбрать эту частоту", "setDays", [_days])

func approachMenu_do(_id:String, _args:Array):
	if(_id == "setDays"):
		var theNpcOwner := getNpcOwner()
		if(theNpcOwner):
			theNpcOwner.nextApproachOverride = _args[0] if _args.size() > 0 else 0
			if(theNpcOwner.nextApproachOverride > 0): # Adjusting the next approach day to fit
				var newDaysApproach:int = GM.main.getDays() + theNpcOwner.nextApproachOverride
				if(theNpcOwner.nextApproachDay > newDaysApproach):
					theNpcOwner.nextApproachDay = newDaysApproach
		setState("approachMenu")
		
func howMuchTimeToPass(_actionID:String, _args:Array) -> int:
	return 0
