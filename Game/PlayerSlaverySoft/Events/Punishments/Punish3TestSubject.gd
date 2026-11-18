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
	talk(C_OWNER, "You are going with me, {npc.npcSlave}.")
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
	talk(C_EXTRA1, "Dr. Quinn here, how can I help?")
	talk(C_OWNER, "I think I found a perfect test subject for your studies.")
	saynn("Кошка приподнимает бровь и заглядывает через плечо твоего хозяина.")
	talk(C_EXTRA1, "Did you? That sounds great.")
	talk(C_OWNER, "Yeah, {pc.he} {pc.isAre} a bit bratty. I'm kinda sick of {pc.him} to be honest. Maybe you will be able to make better use of {pc.him}.")
	saynn("Кошка-врач улыбается и встает.")
	talk(C_EXTRA1, "It's a good thing that science doesn't care about brattiness~. And yes, we could always use more test subjects.")
	saynn("Она выходит из-за стойки и подходит к тебе.")
	talk(C_OWNER, "Here is the leash. You might have to give it a hard pull occasionally. Cuffs will help too.")
	talk(C_EXTRA1, "Don't worry, we have just the right tools to make sure our science projects go smooth~.")
	saynn("Кошка берет поводок.. и приглашает тебя следовать за ней.")
	saynn("Твой хозяин.. бывший хозяин.. разворачивается и просто направляется к лифту.")
	
	addContinue("setState", ["elizaTalk"])

func elizaTalk():
	playStand(true, C_EXTRA1, C_PC)
	setLocation("medical_near_pccell")
	
	saynn("Кошка-врач ведет тебя куда-то..")
	talk(C_EXTRA1, "Wonder what you did to earn such a punishment.")
	saynn("Внезапно ты чувствуешь укол в шею.. Девушка что-то тебе вколола.")
	talk(C_EXTRA1, "Doesn't matter much~. I will fix you and your bratty behaviour.")
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
