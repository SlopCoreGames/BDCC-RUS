extends PawnInteractionBase

var punisherID:String = ""
var struggleText:String = ""
var savedHow:String = ""
var saveTryCount:int = 0
var shoutedForHelpCount:int = 0
var immediatelyLeft:bool = false
var inmateOfferedSelf:bool = false
var saverCooldowns:Dictionary = {}

var saverCooldownSeconds:int = 2*60*60

var slutwallMode:bool = false

func _init():
	id = "InStocks"

# Ehhhh
func stocksSlutwallText(_stocksText:String, _slutwallText:String) -> String:
	if(slutwallMode):
		return _slutwallText
	return _stocksText

func doEquipLockedRestraintOnStart():
	getCharByRole("inmate").getInventory().forceEquipRemoveOther(GlobalRegistry.createItem("StocksStatic"))

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("inmate", _pawns["inmate"])
	setState("", "inmate")
	doEquipLockedRestraintOnStart()

	if( _args.has("punisherID") ):
		punisherID = _args["punisherID"]

func showStuckText():
	saynn("{inmate.You} {inmate.youAre} застряла в стойках, и мало что {inmate.youHe} может поделать: движения {inmate.yourHis} головы и рук скованы гигантской металлической рамой с тремя отверстиями, а из-за её наклона {inmate.youHim} вынуждена постоянно стоять, наклонившись вперёд, подставляя {inmate.yourHis} задницу; {inmate.yourHis} лодыжки скованы цепями, так что {inmate.youHe} почти не может ими шевелить. {inmate.YouHe} {inmate.youAreHeIs} совершенно беспомощна.")

func canEscapeThisInteraction() -> bool:
	return !getCharByRole("inmate").getInventory().hasLockedStaticRestraints()

func init_text():
	showStuckText()
	
	var thePawn = getRolePawn("inmate")
	if(!thePawn.isPlayer()):
		saynn("У {inmate.name} осталось "+str(getRoleChar("inmate").getStamina())+" выносливости.")
	var npc = getRoleChar("inmate")
	if(npc.hasEffect(StatusEffect.HasTallyMarks)):
		var tallyMarks = npc.getEffect(StatusEffect.HasTallyMarks)
		var tallyAmount = tallyMarks.totalAmount
		if(tallyAmount > 0):
			saynn("На теле {inmate.YourHis} "+str(tallyAmount)+" tallymark"+("s" if tallyAmount != 1 else "")+" отметины, а это значит, что {inmate.youHe} использовали грубо столько-то раз.")
	if(thePawn.isSlaveToPlayer()):
		var npcSlave:NpcSlave = thePawn.getNpcSlavery()
		if(npcSlave.getWorkEfficiency() <= 0.1):
			saynn("Твоя рабыня очень устала. Если использовать {inmate.him} сейчас, это сделает {inmate.him} ещё более подавленной.")
		if(npcSlave.getDespair() >= 0.8):
			saynn("{inmate.He} выглядит очень подавленной, разум {inmate.his} может сорваться в любой момент.")
		elif(npcSlave.getDespair() >= 0.5):
			if(npcSlave.getBrokenSpirit() >= 0.9):
				saynn("{inmate.He} выглядит подавленной. Но {inmate.he} к тому же совсем не сопротивляется — похоже, {inmate.his} дух уже сломлен!")
			elif(npcSlave.getBrokenSpirit() > 0.5):
				saynn("{inmate.He} выглядит подавленной. Но {inmate.he} тоже не особо сопротивляется, что говорит о надломленном {inmate.his} духе.")
			else:
				saynn("{inmate.He} выглядит подавленной. Но {inmate.he} время от времени всё же пытается вырваться, так что {inmate.his} дух явно ещё крепок.")
		else:
			if(npcSlave.getBrokenSpirit() >= 0.9):
				saynn("{inmate.He} совсем не сопротивляется, похоже, дух {inmate.his} уже окончательно сломлен!")
			elif(npcSlave.getBrokenSpirit() > 0.5):
				saynn("{inmate.He} почти не сопротивляется — признак того, что дух {inmate.his} ломается.")

	addAction("rest", "Rest", "Stay quiet and try to get some rest", "default", 0.1, 1800, {})
	addAction("shout", "Shout", "Try to get some attention..", "default", (0.1 + scorePersonality("inmate", {PersonalityStat.Naive:0.1})), 30, {})
	if(getRoleChar("inmate").getStamina() > 0):
		addAction("struggle", "Struggle", "Maybe you can escape somehow", "default", 10.0, 300, {})
	else:
		addDisabledAction("Struggle", "You are completely out of stamina and can't struggle")
	if(canEscapeThisInteraction()):
		addAction("escape", "Escape", "Sweet freedom!", "default", 1000.0, 0, {})
	else:
		addDisabledAction("Escape", "You can't escape while you are still locked..")

func onEscapeLockedRestraints():
	pass

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "rest"):
		setState("after_rest", "inmate")
		checkSleep()
		getCharByRole("inmate").addStamina(50)
	if(_id == "shout"):
		shoutedForHelpCount += 1
		setState("about_to_shout", "inmate")
	if(_id == "struggle"):
		if(getRolePawn("inmate").isPlayer()):
			runScene("StrugglingScene", [false, false])
		else:
			setState("about_to_struggle", "inmate")
	if(_id == "escape"):
		onEscapeLockedRestraints()
		stopMe()


func after_rest_text():
	if(!slutwallMode):
		saynn("{inmate.You} {inmate.youVerb('decide')} молчать. {inmate.YouHe} {inmate.youAreHeIs} вынужден(а) стоять в неудобной позе; это унизительно, но зато {inmate.youHe} {inmate.youHeVerb('get')} немного отдохнуть.")
	else:
		saynn("{inmate.You} {inmate.youVerb('decide')} помалкивать и просто немного отдохнуть.")

	addAction("continue", "Continue", "See what happens next", "default", 1.0, 0, {})

func after_rest_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "inmate")


func about_to_struggle_text():
	saynn("{inmate.name} пытается вырваться!")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func about_to_struggle_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var inmate = getRoleChar("inmate")
		var struggleData:Dictionary = inmate.doStruggleOutOfRestraints()
		if(struggleData.empty()):
			return
		struggleText = struggleData["text"]
		setState("after_struggle", "inmate")


func after_struggle_text():
	saynn(struggleText)

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func after_struggle_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "inmate")


func about_to_use_text():
	if(inmateOfferedSelf):
		saynn("{user.You} {user.youVerb('agree')}, чтобы использовать {inmate.you}..")
		sayLine("user", "TalkSexOfferSelfAccept", {main="user", target="inmate"})
	else:
		saynn("{user.You} {user.youVerb('approach', 'approaches')} в колодках, и вот-вот применят {inmate.you}...")

	addAction("continue", "Continue", "Start the sex!", "default", 1.0, 600, {start_sex=["user", "inmate", SexType.StocksSex],})

func about_to_use_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var _sexResult:SexEngineResult = getSexResult(_args)
		sendSlaveryActivityEvent("inmate", "stocksUsed", {sex=_sexResult})
		doRepEvent("inmate", "befuckedstocks")
		setState("after_use", "user")


func after_use_text():
	saynn("{user.name} закончила использовать {inmate.you}..")

	addAction("leave", "Leave", "Time to go", "default", 1.0, 60, {})

func after_use_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		doRemoveRole("user")
		setState("", "inmate")


func about_to_save_text():
	if(saveTryCount == 0):
		saynn("{saver.You} {saver.youVerb('approach', 'approaches')} {inmate.you}!")
	else:
		saynn("{saver.You} {saver.youVerb('stand')} рядом с {inmate.you}.")

	saynn("{saver.YouHe} может либо потратить немного {saver.yourHis} выносливости, чтобы помочь {inmate.you} выбраться из "+stocksSlutwallText("stocks", "the slutwall")+".. либо использовать ключ, чтобы отпереть их.")

	if(getRoleChar("saver").getStamina() > 0):
		addAction("help", "Help", "Spend some stamina and help them", "default", 1.0, 180, {})
	else:
		addDisabledAction("Help", "You don't have any stamina left..")
	if(getRoleChar("saver").getInventory().hasItemID("restraintkey")):
		addAction("key", "Restraint key", "Use a restraint key to unlock the "+stocksSlutwallText("stocks", "slutwall"), "help", 0.2, 60, {})
	addAction("leave", "Leave", "", "justleave", 1.0 + (saveTryCount*saveTryCount*0.1), 30, {})

func about_to_save_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "help"):
		if(saveTryCount == 0):
			setState("refusable_save_using_stamina", "inmate")
		else:
			saveUsingStamina()
	if(_id == "key"):
		if(saveTryCount == 0):
			setState("refusable_save_using_key", "inmate")
		else:
			saveUsingKey()
	if(_id == "leave"):
		if(saveTryCount == 0):
			immediatelyLeft = true
		setState("canceled_save", "saver")


func refusable_save_using_stamina_text():
	saynn("{saver.You} {saver.youAre} собирается помочь {inmate.you} выбраться из "+stocksSlutwallText("stocks", "the slutwall")+".")

	var acceptHelpProbability = getInmateAcceptHelpProbability()
	var refuseHelpProbability = 1.0 - acceptHelpProbability
	addAction("accept", "Accept", "Allow them to help you", "default", acceptHelpProbability, 60, {})
	addAction("refuse", "Refuse", "You'd rather stay locked", "default", refuseHelpProbability, 60, {})
	addAction("offer_self", "Offer self", "Invite them to fuck you instead", "sexSub", 0.5, 60, {})

func refusable_save_using_stamina_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "accept"):
		saveUsingStamina()
	if(_id == "refuse"):
		setState("refused_save", "saver")
	if(_id == "offer_self"):
		inmateOfferedSelf = true
		setState("refused_save_offered_self", "saver")


func refusable_save_using_key_text():
	saynn("{saver.You} {saver.youAre} собирается использовать ключ от наручников, чтобы отпереть "+stocksSlutwallText("the stocks", "the slutwall")+".")

	var acceptHelpProbability = getInmateAcceptHelpProbability()
	var refuseHelpProbability = 1.0 - acceptHelpProbability
	addAction("accept", "Accept", "Allow them to unlock you", "default", acceptHelpProbability, 60, {})
	addAction("refuse", "Refuse", "You'd rather stay locked", "default", refuseHelpProbability, 60, {})

func refusable_save_using_key_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "accept"):
		saveUsingKey()
	if(_id == "refuse"):
		setState("refused_save", "saver")


func refused_save_text():
	saynn("{inmate.You} {inmate.youVerb('refuse', 'refused')} {saver.your} на помощь.")
	sayLine("inmate", "HelpStocksSlutwallRefuse", {main="inmate", target="saver"})

	addAction("leave", "Leave", "Time to go", "default", 1.0, 60, {})

func refused_save_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		setState("canceled_save", "saver")


func refused_save_offered_self_text():
	saynn("{inmate.You} {inmate.youVerb('refuse', 'refused')} {saver.your} на помощь.")
	sayLine("inmate", "HelpStocksSlutwallRefuse", {main="inmate", target="saver"})

	var saverIsMean:bool = getRolePawn("saver").scorePersonalityMax({ PersonalityStat.Mean: 1.0 }) > 0.4
	var responses:Array = [
		"Alright.",
		"Don't be shouting my name when you change your mind~." if !slutwallMode else "Wouldn't be called slutwall without you in it~.",
		"If that's how you want it.",
		"Mmmh..",
		"Oki.",
		"Your choice.",
	]
	if(!getRoleChar("saver").isBlindfolded()):
		responses.append_array([
			"Good. Your butt looks better in the stocks~." if !slutwallMode else "Good. Your butt looks better in the slutwall~.",
			"I do enjoy seeing you bent over like this.." if !slutwallMode else "I do enjoy seeing you like this..",
		])
	if(saverIsMean):
		responses.append_array([
			"Suit yourself.",
			"Whatever.",
			"Why did I even bother.",
		])
	saynn("[say=saver]"+RNG.pick(responses)+"[/say]")

	saynn("\nНо {inmate.youHe} {inmate.youDontHeDoesnt} хочет, чтобы {saver.youHim} пока не уходил(а)..")
	sayLine("inmate", "TalkSexOfferSelf", {main="inmate", target="saver"})

	addAction("agree", "Agree", "Agree to fuck them", "agreeSexAsDom", 1.0, 60, {})
	addAction("deny", "Deny", "You'd rather not..", "default", 0.2, 60, {})

func refused_save_offered_self_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "agree"):
		var saverCharID = getRolePawn("saver").charID
		doRemoveRole("saver")
		doInvolvePawn("user", saverCharID)
		setState("about_to_use", "user")
	if(_id == "deny"):
		setState("offered_self_deny", "inmate")


func offered_self_deny_text():
	sayLine("saver", "TalkSexOfferSelfDeny", {main="saver", target="inmate"})
	saynn("{saver.You} {saver.youVerb('walk')} уходит, оставляя {inmate.you} на растерзание кому-то другому..")

	addAction("continue", "Continue", "Aww..", "default", 1.0, 60, {})

func offered_self_deny_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("saver")
		setState("", "inmate")


func canceled_save_text():
	if(immediatelyLeft):
		saynn("{saver.You} {saver.youVerb('walk')} уходит, оставляя {inmate.you} на произвол {inmate.yourHis}..")
	else:
		saynn("{saver.You} {saver.youVerb('leave')}, больше не пытаясь спасти {inmate.you}..")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 30, {})

func canceled_save_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("saver")
		setState("", "inmate")


func save_saved_text():
	if(savedHow=="help"):
		saynn("{saver.name} удается отпереть "+stocksSlutwallText("stocks", "slutwall")+" используя лишь {saver.his} грубую силу.")
	else:
		saynn("{saver.name} отпирает "+stocksSlutwallText("stocks", "slutwall")+" с ключом от наручников!")

	addAction("leave", "Free!", "You're free!", "default", 1.0, 60, {})

func save_saved_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func save_after_help_text():
	saynn(struggleText)

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 30, {})
	addAction("stop", "Stop them", "Wiggle them off", "default", 0.0, 60, {})

func save_after_help_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("about_to_save", "saver")
	if(_id == "stop"):
		setState("canceled_save", "saver")


func about_to_shout_text():
	if(getRoleChar("inmate").isGagged()):
		saynn("{inmate.You} {inmate.youAre} кляп, но {inmate.youHe} всё ещё пытается {inmate.youHeVerb('try', 'tries')} привлечь к себе внимание, дрыгая {inmate.yourHis} телом..")
	else:
		saynn("{inmate.You} {inmate.youVerb('try', 'tries')} пытается кричать, чтобы привлечь чьё-нибудь внимание..")
		sayLine("inmate", "StocksShout", {main="inmate"})

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 180, {})

func about_to_shout_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getCharByRole("inmate").addStamina(20)
		
		if(isPlayersTurn() && triggerRandomStocksEvent(10.0, 10.0, 10.0, 100.0)):
			setState("", "inmate")
			return

		var ignoreList:Array = []
		for charID in saverCooldowns:
			ignoreList.append(charID)
		if(!shoutForInterruptions("inmate", 3, 2, 0.5, "You hear begging coming from "+getCharByRole("inmate").getName()+" who is stuck in stocks at the punishment platform..", ignoreList)):
			setState("after_shout", "inmate")
			checkSleep()


func after_shout_text():
	saynn("После {inmate.your} попыток никто так и не пришёл.. По крайней мере, {inmate.youHe} удалось немного отдохнуть..")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 30, {})

func after_shout_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "inmate")


func about_to_sleep_text():
	if(!slutwallMode):
		saynn("Кажется, уже очень поздно.. все расходятся по камерам и комнатам..")
	else:
		saynn("Становится тихо.. Должно быть, из-за того, что наступила ночь..")
	saynn("Неужели они просто.. оставят тебя в таком виде?")
	saynn("Ну что ж, пора устроиться поудобнее..")

	addAction("sleep", "Sleep", "Try and sleep like this..", "default", 1.0, 60, {})

func about_to_sleep_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sleep"):
		GM.main.startNewDay()
		getRoleChar("inmate").addStamina(50)
		setState("after_sleep", "inmate")


func after_sleep_text():
	saynn("Ты открываешь глаза.. и понимаешь, что всё ещё "+stocksSlutwallText("bound in stocks", "stuck in a slutwall")+".. Ага, это не сон, всё происходит на самом деле..")
	saynn("Добро пожаловать в "+str(GM.main.getDays())+" день твоего срока.")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func after_sleep_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "inmate")


func free_slave_text():
	saynn("Запасов достаточно. Освобождай {inmate.name}, а затем заказывай {inmate.him}, чтобы она вернулась в камеру.")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func free_slave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func getInterruptActions(_pawn:CharacterPawn) -> Array:
	var result:Array = []
	if(getPawnAmount() == 1):
		result.append({
			id = "use",
			name = "Использовать",
			desc = "Use them while they are stuck in "+stocksSlutwallText("stocks", "the slutwall"),
			score = 1.0,
			scoreType = "sexUse",
			scoreRole = "inmate",
			args = {},
		})
	if(getPawnAmount() == 1):
		var helpScore:float = -0.01 if(saverCooldowns.has(_pawn.charID)) else 1.0
		result.append({
			id = "free",
			name = "Освободить",
			desc = "Try to free them!",
			score = helpScore,
			scoreType = "help",
			scoreRole = "inmate",
			args = {},
		})
	if(getPawnAmount() == 1 && getRolePawn("inmate").isSlaveToPlayer()):
		result.append({
			id = "free_slave",
			name = "Разблокировать рабыню",
			desc = "Let your slave return back to your cell..",
			score = 0.0,
			scoreType = "default",
			scoreRole = "inmate",
			args = {},
		})
	return result

func doInterruptAction(_pawn:CharacterPawn, _id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "use"):
		inmateOfferedSelf = false
		doInvolvePawn("user", _pawn)
		setState("about_to_use", "user")
	if(_id == "free"):
		saveTryCount = 0
		immediatelyLeft = false
		inmateOfferedSelf = false
		saverCooldowns[_pawn.charID] = saverCooldownSeconds
		doInvolvePawn("saver", _pawn)
		setState("about_to_save", "saver")
	if(_id == "free_slave"):
		doInvolvePawn("saver", _pawn)
		setState("free_slave", "inmate")


func getAnimData() -> Array:
	if(getState() in ["save_saved", "free_slave"]):
		return [StageScene.Duo, "stand", {pc="inmate", npc="saver"}]
	if(getState() in ["about_to_save", "refusable_save_using_stamina", "refusable_save_using_key", "refused_save", "refused_save_offered_self", "save_after_help"]):
		return [StageScene.StocksSexOral, "tease", {pc="inmate", npc="saver"}]
	if(getState() in ["about_to_use", "after_use"]):
		return [StageScene.StocksSexOral, "tease", {pc="inmate", npc="user"}]
	return [StageScene.Stocks, "idle", {pc="inmate"}]

func processTime(_howMuch:int):
	if(saverCooldowns.empty() || _howMuch <= 0):
		return
	var newSaverCooldowns:Dictionary = {}
	for charID in saverCooldowns:
		saverCooldowns[charID] -= _howMuch
		if(saverCooldowns[charID] > 0):
			newSaverCooldowns[charID] = saverCooldowns[charID]
	saverCooldowns = newSaverCooldowns

func getActivityIconForRole(_role:String):
	if(_role == "inmate"):
		return RoomStuff.PawnActivity.Stocks
	else:
		return RoomStuff.PawnActivity.Chat
	#return .getActivityIconForRole(_role)

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "inmate"):
		if(getState() in ["about_to_use", "after_use"]):
			return "{inmate.name} is being used by {user.name}.."
		if(getState() in ["about_to_save", "refusable_save_using_stamina", "refusable_save_using_key", "save_after_help"]):
			return "{inmate.name} is being saved by {saver.name}.."
		return "{inmate.name} is stuck in stocks.."
	if(_role == "user"):
		return "{user.name} is using {inmate.name}."
	if(_role == "saver"):
		return "{saver.name} is trying to free {inmate.name} from stocks."
	return .getPreviewLineForRole(_role)

func checkSleep():
	if(GM.main.isVeryLate() && getRolePawn("inmate").isPlayer()):
		setState("about_to_sleep", "inmate")

func onStopped():
	if(hasRoleChar("inmate")):
		getRoleChar("inmate").getInventory().clearStaticRestraints()

func getInmateAcceptHelpProbability() -> float:
	var acceptHelpProbability:float = 1.0

	if(shoutedForHelpCount > 0):
		acceptHelpProbability = 1.0
		return acceptHelpProbability

	var inmateDommyness:float = getRolePawn("inmate").scorePersonalityMax({PersonalityStat.Subby: -1.0})
	var saverDommyness:float = getRolePawn("saver").scorePersonalityMax({PersonalityStat.Subby: -1.0})
	var dommynessDisadvantageRatio:float = max(saverDommyness - inmateDommyness, 0.0) / 2.0

	acceptHelpProbability = clamp(1.0 - getRolePawn("inmate").scoreFetishMax({ Fetish.Bondage: 0.4 }) + 0.3 * dommynessDisadvantageRatio, 0.0, 1.0)
	return acceptHelpProbability

func saveUsingStamina() -> void:
	saveTryCount += 1
	var inmate = getRoleChar("inmate")
	var struggleData:Dictionary = inmate.doStruggleOutOfRestraints(false, true, getRoleChar("saver"), 2.0)
	if(struggleData.empty()):
		struggleText = "Something happened.."
	else:
		struggleText = struggleData["text"]
	
	if(inmate.getInventory().hasItemIDEquipped("StocksStatic" if !slutwallMode else "SlutwallStatic")):
		setState("save_after_help", "inmate")
	else:
		savedHow = "help"
		setState("save_saved", "inmate")
		affectAffectionOnSave()

func saveUsingKey() -> void:
	savedHow = "key"
	setState("save_saved", "inmate")
	affectAffectionOnSave()
	getRoleChar("saver").getInventory().removeXOfOrDestroy("restraintkey", 1)
	getRoleChar("inmate").getInventory().clearStaticRestraints()

func affectAffectionOnSave() -> void:
	var affectionGain:float = 0.05 if(getRoleChar("saver").getID() == punisherID) else 0.2
	affectAffection("inmate", "saver", affectionGain)

func saveData():
	var data = .saveData()

	data["punisherID"] = punisherID
	data["struggleText"] = struggleText
	data["savedHow"] = savedHow
	data["saveTryCount"] = saveTryCount
	data["shoutedForHelpCount"] = shoutedForHelpCount
	data["immediatelyLeft"] = immediatelyLeft
	data["inmateOfferedSelf"] = inmateOfferedSelf
	data["saverCooldowns"] = saverCooldowns
	return data

func loadData(_data):
	.loadData(_data)

	punisherID = SAVE.loadVar(_data, "punisherID", "")
	struggleText = SAVE.loadVar(_data, "struggleText", "")
	savedHow = SAVE.loadVar(_data, "savedHow", "")
	saveTryCount = SAVE.loadVar(_data, "saveTryCount", 0)
	shoutedForHelpCount = SAVE.loadVar(_data, "shoutedForHelpCount", 0)
	immediatelyLeft = SAVE.loadVar(_data, "immediatelyLeft", false)
	inmateOfferedSelf = SAVE.loadVar(_data, "inmateOfferedSelf", false)
	saverCooldowns = SAVE.loadVar(_data, "saverCooldowns", {})

