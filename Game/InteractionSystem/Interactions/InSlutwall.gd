extends "res://Game/InteractionSystem/Interactions/InStocks.gd"

var useCount:int = 0
var tips:int = 0

func _init():
	id = "InSlutwall"
	slutwallMode = true

func doEquipLockedRestraintOnStart():
	getCharByRole("inmate").getInventory().forceEquipRemoveOther(GlobalRegistry.createItem("SlutwallStatic"))

func showStuckText():
	saynn("{inmate.You} {inmate.youAre} застряла в шлюзовой стене. {inmate.YouHe} {inmate.youAreHeIs} совершенно беспомощная, её {inmate.yourHis} {inmate.thick} {butt} торчит наружу, готовая к любому траху..")
	saynn("В чаевых сейчас "+getTipsAmountString()+".. Есть автоматический механизм, который разблокирует {inmate.youHim} за 10 кредитов..")

func canEscapeThisInteraction() -> bool:
	return !getCharByRole("inmate").getInventory().hasLockedStaticRestraints() || (tips >= 10)

func onEscapeLockedRestraints():
	if(tips > 0):
		if(getRolePawn("inmate").isPlayer()):
			GM.pc.addCredits(int(tips))
			addMessage("Получено: "+getTipsAmountString()+" из чаевых! Красава!")
		elif(getRolePawn("inmate").isSlaveToPlayer()):
			GM.pc.addCredits(int(tips))
			addMessage("Твоя рабыня "+getRoleChar("inmate").getName()+" заработала тебе "+getTipsAmountString()+" за то, что торчит в шлюх-стене! Красава!")
	getRoleChar("inmate").getInventory().clearStaticRestraints()

func about_to_use_text():
	if(inmateOfferedSelf):
		saynn("{user.You} {user.youVerb('agree')}, чтобы использовать {inmate.you}..")
		sayLine("user", "TalkSexOfferSelfAccept", {main="user", target="inmate"})
	else:
		saynn("{user.You} {user.youVerb('approach', 'approaches')} в шлюзовой стене, собираясь использовать {inmate.you}..")

	addAction("continue", "Продолжить", "Начать секс!", "default", 1.0, 600, {start_sex=["user", "inmate", SexType.SlutwallSex, {SexMod.DisableDynamicJoiners: true}],})

func about_to_use_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var _sexResult:SexEngineResult = getSexResult(_args)
		sendSlaveryActivityEvent("inmate", "slutwallUsed", {sex=_sexResult})
		doRepEvent("inmate", "befuckedslutwall")
		setState("after_use", "user")


func after_use_text():
	saynn("{user.name} закончила использовать {inmate.you}..")
	saynn("В чаевых сейчас.. "+getTipsAmountString()+" в копилке. {inmate.name} сможет сбежать, когда наберется 10 кредитов..")

	addAction("leave", "Уйти", "Пора идти", "default", 1.0, 60, {})
	if(!getRolePawn("user").isPlayer() || GM.pc.getCredits() > 0):
		addAction("leave_a_tip", "Оставить чаевые", "Оставить всего 1 кредит", "help", 2.0, 60, {})
	if(!getRolePawn("user").isPlayer() || GM.pc.getCredits() >= 5):
		addAction("leave_a_big_tip", "Оставить щедрые чаевые", "Оставить целых 5 кредитов!", "help", 0.4, 60, {})
	if(tips > 0):
		addAction("steal_tips", "Стибрить чаевые", "Загребай все кредиты себе! Они будут не в восторге...", "punishMean", (0.1+(0.1*(tips-9)) if tips >= 9 else 0.05), 60, {})

func after_use_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		doRemoveRole("user")
		setState("", "inmate")
	if(_id == "leave_a_tip"):
		if(getRolePawn("user").isPlayer()):
			addMessage("Ты оставил чаевые!")
			GM.pc.addCredits(-1)
		setState("after_tip", "inmate")
		tips += 1
		if(getRolePawn("inmate").isPlayer()):
			addMessage("Тебе дали чаевые!")
		affectAffection("user", "inmate", 0.05)
	if(_id == "leave_a_big_tip"):
		if(getRolePawn("user").isPlayer()):
			addMessage("Ты отвалил просто охеренные чаевые!")
			GM.pc.addCredits(-5)
		setState("after_tip", "inmate")
		tips += 5
		if(getRolePawn("inmate").isPlayer()):
			addMessage("Тебе отвалили просто охеренные чаевые!")
		affectAffection("user", "inmate", 0.1)
	if(_id == "steal_tips"):
		if(getRolePawn("user").isPlayer()):
			addMessage("Ты сожрал все чаевые!")
			GM.pc.addCredits(tips)
		setState("after_steal_tips", "inmate")
		tips = 0
		if(getRolePawn("inmate").isPlayer()):
			addMessage("Твои чаевые украли!")
		affectAffection("inmate", "user", -0.2)



func about_to_shout_text():
	saynn("{inmate.You} {inmate.youVerb('wiggle')} своё {inmate.yourHis} тело и {inmate.thick} задницу, пытаясь привлечь чье-нибудь внимание..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 180, {})

func about_to_shout_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getCharByRole("inmate").addStamina(20)
		var ignoreList:Array = []
		for charID in saverCooldowns:
			ignoreList.append(charID)
		if(!shoutForInterruptions("inmate", 4, 4, 0.5, "You notice "+getCharByRole("inmate").getName()+" wiggling their ass in the slutwall..", ignoreList)):
			setState("after_shout", "inmate")
			checkSleep()


func after_tip_text():
	saynn("Перед самым уходом {user.name} решает подкинуть денег в чаевые..")
	sayLine("user", "SlutwallAddTip", {main="user", target="inmate"})
	saynn("В коробке для чаевых теперь.. "+getTipsAmountString()+" {inmate.name} сможет забрать "+("it" if(tips == 1) else "им")+".. после того как освободит {inmate.himself}..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func after_tip_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("user")
		setState("", "inmate")


func after_steal_tips_text():
	saynn("{user.name} решает вскрыть коробку для чаевых и заграбастать всё подчистую!")
	sayLine("user", "SlutwallStealCredits", {main="user", target="inmate"})
	saynn("Ого..")

	addAction("continue", "Продолжить", "Ого... На, держи свои кредиты...", "default", 1.0, 60, {})

func after_steal_tips_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("user")
		setState("", "inmate")


func getAnimData() -> Array:
	if(getState() in ["save_saved", "free_slave"]):
		return [StageScene.Duo, "stand", {pc="inmate", npc="saver"}]
	if(getState() in ["about_to_save", "refusable_save_using_stamina", "refusable_save_using_key", "refused_save", "refused_save_offered_self", "save_after_help"]):
		return [StageScene.SlutwallSex, "tease", {pc="inmate", npc="saver"}]
	if(getState() in ["about_to_use", "after_use", "after_tip"]):
		return [StageScene.SlutwallSex, "tease", {pc="inmate", npc="user"}]
	return [StageScene.Slutwall, "idle", {pc="inmate"}]

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "inmate"):
		if(getState() in ["about_to_use", "after_use"]):
			return "{inmate.name} is being used by {user.name}.."
		if(getState() in ["about_to_save", "refusable_save_using_stamina", "refusable_save_using_key", "save_after_help"]):
			return "{inmate.name} is being saved by {saver.name}.."
		return "{inmate.name} is stuck in a slutwall.."
	if(_role == "user"):
		return "{user.name} is using {inmate.name}."
	if(_role == "saver"):
		return "{saver.name} is trying to free {inmate.name} from the slutwall."
	return .getPreviewLineForRole(_role)

func getTipsAmountString() -> String:
	return (str(tips)+" credit"+("" if(tips == 1) else "s"))

func saveData():
	var data = .saveData()

	data["useCount"] = useCount
	data["tips"] = tips
	return data

func loadData(_data):
	.loadData(_data)

	useCount = SAVE.loadVar(_data, "useCount", 0)
	tips = SAVE.loadVar(_data, "tips", 0)

