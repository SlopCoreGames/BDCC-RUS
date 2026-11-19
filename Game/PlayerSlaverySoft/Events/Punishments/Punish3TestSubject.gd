extends NpcOwnerEventBase

func _init():
	id = "Punish3TestSubject"
	reactsToTags = [E_PUNISH_GET_RID_OF]

func getSubEventScore(_event, _tag:String, _args:Array) -> float:
	return 1.0

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(!npcOwner):
		return false
	return true
	
func start():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	sayPretext()
	saynn("Твой хозяин с силой защелкивает поводок на твоем ошейнике и начинает его дергать.")
	talk(C_OWNER, "Ты идешь со мной, {npc.npcSlave}.")
	saynn("{npc.He} звучит довольно разъяренно..")
	
	addContinue("goToEliza")

func start_do(_id:String, _args:Array):
	if(_id == "goToEliza"):
		involveCharID(C_EXTRA1, "eliza")
		setLocation(LOC_MED_COUNTER)
		setState("nearEliza")
	
func nearEliza():
	playAnimation(StageScene.Duo, "stand", {pc=getOwnerID(), npc="eliza"})
	
	saynn("Вскоре вы прибываете.. в медицинский блок. {npc.name} подходит к стойке.. и привлекает внимание кошки, сидящей по ту сторону.")
	talk(C_EXTRA1, "На связи доктор Куинн. Чем могу помочь?")
	talk(C_OWNER, "Мне кажется, я нашел идеальный подопытный экземпляр для твоих исследований.")
	saynn("Кошка приподнимает бровь и заглядывает через плечо твоего хозяина.")
	talk(C_EXTRA1, "Да неужели? Звучит просто супер.")
	talk(C_OWNER, "Да, {pc.he} немного капризничает. Честно говоря, меня это уже достало. Может, ты сможешь найти {pc.him} лучшее применение.")
	saynn("Кошка-врач улыбается и встает.")
	talk(C_EXTRA1, "Хорошо, что науке плевать на капризы~. И да, новых подопытных нам никогда не бывает много.")
	saynn("Она выходит из-за стойки и подходит к тебе.")
	talk(C_OWNER, "Вот поводок. Иногда, возможно, придётся хорошенько дёрнуть. Наручники тоже не помешают.")
	talk(C_EXTRA1, "Не волнуйся, у нас есть самые подходящие инструменты, чтобы наши научные проекты шли как по маслу~.")
	saynn("Кошка берет поводок.. и приглашает тебя следовать за ней.")
	saynn("Твой хозяин.. бывший хозяин.. разворачивается и просто направляется к лифту.")
	
	addContinue("setState", ["elizaTalk"])

func elizaTalk():
	playStand(true, C_EXTRA1, C_PC)
	setLocation("medical_near_pccell")
	
	saynn("Кошка-врач ведет тебя куда-то..")
	talk(C_EXTRA1, "Интересно, что же ты натворил, раз заслужил такое наказание.")
	saynn("Внезапно ты чувствуешь укол в шею.. Девушка что-то тебе вколола.")
	talk(C_EXTRA1, "Не особо важно~. Я исправлю тебя и твоё капризное поведение.")
	saynn("И скоро.. холодная поверхность пола встретится с твоим сонным лицом..")
	addContinue("startTheThing")

func elizaTalk_do(_id:String, _args:Array):
	var npcOwner := getNpcOwner()
	if(npcOwner):
		npcOwner.endSlavery()
	endEvent()
	stopRunner()
	
	GlobalRegistry.getModule("MedicalModule").preparePCForMentalWard()
	GM.main.startNewDay()
	GM.main.runScene("MentalWardScene")
