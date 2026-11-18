extends NpcOwnerEventBase

var isWilling:bool = false

func _init():
	id = "Intro"

func onStart(_args:Array):
	if(_args.size() > 0 && _args[0] == "willing"):
		isWilling = true
	setState("start")

func start():
	playAnimation(StageScene.HangingDuo, "stand", {npc=getOwnerID()})
	
	if(isOwnerStaff()):
		setLocation(LOC_SOLITARY)
		
		if(!isWilling):
			saynn("Ты просыпаешься.. подвешенным над полом за запястья.. в маленькой темной камере..")
			saynn("Одна из стен.. сделана из толстого стекла. За ней.. чей-то силуэт.")
			talkModularOwnerToPC("SoftSlaveryIntro1") # You're up? Good.
			saynn("Выглядит не очень хорошо..")
			saynn("Фигура входит в камеру и приближается к тебе. Это {npc.name}.")
			talkModularOwnerToPC("SoftSlaveryIntro2") # You are now my slave. Undestand?
			saynn("Точно.. Ты не совсем понимаешь, как на это реагировать.")
			talkModularOwnerToPC("SoftSlaveryIntro3") # You will do as I say or we will have a problem
			saynn("Похоже, выбора у тебя немного..")
		else:
			saynn("Тебя притаскивают в зону одиночных камер.. {npc.name} хватает тебя за запястья и заковывает их высоко над головой..")
			talkModularOwnerToPC("SoftSlaveryIntro1Willing") # Now let's talk.
			saynn("Это волнующе..")
			saynn("{npc.name} берет тебя за подбородок, заставляя смотреть на {npc.him}.")
			talkModularOwnerToPC("SoftSlaveryIntro2") # You are now my slave. Undestand?
			saynn("Ты киваешь.")
			talkModularOwnerToPC("SoftSlaveryIntro3") # You will do as I say or we will have a problem
			saynn("Похоже, выбора у тебя немного.. и это хорошо.")
	else:
		setLocation(getOwnerHomeLoc())
		
		if(!isWilling):
			saynn("Ты просыпаешься.. подвешенным к потолку за запястья.. в какой-то камере..")
			saynn("Чем дольше ты всматриваешься.. тем отчетливее понимаешь.. это не твоя камера.")
			saynn("Кто-то входит..")
			talkModularOwnerToPC("SoftSlaveryIntro1") # You're up? Good.
			saynn("Выглядит не очень хорошо..")
			saynn("Фигура приближается к тебе. Это {npc.name}.")
			talkModularOwnerToPC("SoftSlaveryIntro2") # You are now my slave. Undestand?
			saynn("Точно.. Ты не совсем понимаешь, как на это реагировать.")
			talkModularOwnerToPC("SoftSlaveryIntro3") # You will do as I say or we will have a problem
			saynn("Похоже, выбора у тебя немного..")
		else:
			saynn("Тебя затаскивают в тесную камеру.. {npc.name} хватает тебя за запястья и заковывает их высоко над головой..")
			talkModularOwnerToPC("SoftSlaveryIntro1Willing") # Now let's talk.
			saynn("Это волнующе..")
			saynn("{npc.name} берет тебя за подбородок, заставляя смотреть на {npc.him}.")
			talkModularOwnerToPC("SoftSlaveryIntro2") # You are now my slave. Undestand?
			saynn("Ты киваешь.")
			talkModularOwnerToPC("SoftSlaveryIntro3") # You will do as I say or we will have a problem
			saynn("Похоже, выбора у тебя немного.. и это хорошо.")
	
	addContinue("setState", ["nearcellblock"])
	
func nearcellblock():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	setLocation(LOC_CELLBLOCK_MIDDLE)
	
	saynn("После краткого.. знакомства.. твой новый хозяин пристегивает поводок к твоему ошейнику и ведет тебя обратно в блок камер.")
	talkModularOwnerToPC("SoftSlaveryIntroEND")# I will be checking on you ever so often. Don't forget who you belong to.
	saynn("Похоже, {npc.he} {npc.is}не собирается держать тебя в {npc.his} {npc.cell} весь день напролет.. всё равно из этого места просто так не сбежать.")
	if(onlyOnce()):
		var theNpcOwner := getNpcOwner()
		if(theNpcOwner):
			theNpcOwner.checkNextApproachDay()
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["isWilling"] = isWilling
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	isWilling = SAVE.loadVar(_data, "isWilling", false)
