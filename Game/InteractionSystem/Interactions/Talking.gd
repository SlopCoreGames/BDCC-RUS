extends PawnInteractionBase

var chat = {}
var lust = {}
var chatAnswer = ""
var surrendered = false
var notFirst = false
var struggleText = ""
var tryCount = 0
var askCredits = 0
var didAmount = 0
var gotDenied = false
var pickedLineIndx:int = 0
var fullpickupLine:String = ""
var isLineCorrect:bool = false

func _init():
	id = "Talking"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])
	if(_args.has("grab_and_fuck") && _args["grab_and_fuck"]):
		setState("grabbed_about_to_fuck", "reacter")
	else:
		if(getRolePawn("starter").isPlayer()): # A hack-ish way to ensure that the owner npc talk event always gets executed
			var theSpecialRelationship := getRolePawn("reacter").getSpecialRelationship()
			if(theSpecialRelationship && theSpecialRelationship.id == "SoftSlavery"):
				stopMe()
				GM.main.runScene("NpcOwnerEventRunnerScene", [getRolePawn("reacter").charID, "ApproachOrTalk", []])
				return
		
		setState("", "starter")
		sendSocialEvent("starter", "reacter", SocialEventType.GotTalkedTo)

func init_text():
	var theStarter:BaseCharacter = getRoleChar("starter")
	var theReacter:BaseCharacter = getRoleChar("reacter")
	
	if(!notFirst):
		saynn("{starter.name} подходит к {reacter.you}.")
		notFirst=true
		
		if(isNemesisTo("reacter", "starter")):
			sayLine("reacter", "TalkStartNemesis", {main="reacter", target="starter"})
	else:
		saynn("{starter.name} стоит рядом с {reacter.you}.")
	saynn("Привязанность {reacter.Your} к {starter.you}: "+getAffectionString("starter", "reacter")+".\nПохоть: "+getLustString("starter", "reacter")+".")

	if(!theStarter.isGagged() && getRolePawn("reacter").canSocial()):
		if(!isNemesisTo("reacter", "starter")):
			addAction("chat", "Чат", "Поболтать о всяком", "talk", 1.0, 30, {})
		else:
			addDisabledAction("Чат", "Они тебя слишком сильно ненавидят...")
	else:
		addDisabledAction("Чат", ""+("Нельзя поболтать, если не получается связать и двух слов..." if getRolePawn("reacter").canSocial() else "Похоже, они сейчас не настроены на разговор...")+"")
	if(getRolePawn("reacter").canSocial()):
		if(!isNemesisTo("reacter", "starter")):
			addAction("flirt", "Флиртовать", "Попробуй пофлиртовать", "flirt", 1.0, 30, {})
		else:
			addDisabledAction("Флиртовать", "Они тебя слишком сильно ненавидят...")
	else:
		addDisabledAction("Флиртовать", "Похоже, они сейчас не настроены на флирт...")
	if(getRolePawn("reacter").canGrabAndFuck() && roleCanStartSex("starter")):
		addAction("grab_and_fuck", "Схватить и трахнуть", "На них столько стяжек, что их можно просто трахать...", "sexUse", 5.0, 60, {})
	addAction("attack", "Атаковать", "Заставь их пожалеть об этом!", "attack", 1.0 if (didAmount <= 0 || gotDenied) else 0.1, 30, {})
	if(roleCanStartSex("starter")):
		addAction("offersex", "Предложить секс", "Предложи им трахнуться", "sexDom", 0.2, 60, {})
	else:
		addDisabledAction("Предложить секс", "Так просто секс не начать...")
	if(roleCanStartSex("reacter")):
		addAction("offerself", "Предложить себя", "Предложи им трахнуть тебя", "sexSub", 0.2, 60, {})
	else:
		addDisabledAction("Предложить себя", "Так секс не начнется...")
	if(theStarter.getInventory().hasRemovableRestraintsNoLockedSmartlocks()):
		if(getRolePawn("starter").getAffection(getRolePawn("reacter")) >= 0.5 && getRolePawn("reacter").canSocial()):
			addAction("ask_help_restraints", "Попросить о помощи", "Попросить помочь с твоими путами...", "help", 0.0, 60, {})
		else:
			addDisabledAction("Попросить о помощи", "Чтобы просить о помощи с путами, уровень привязанности должен быть выше 50%..." if getRolePawn("reacter").canSocial() else "Очевидно, они сейчас не в настроении тебе помогать...")
	if(theReacter.getInventory().hasRemovableRestraintsNoLockedSmartlocks()):
		if(theStarter.getStamina() > 0 && !theStarter.hasBlockedHands() && !theStarter.hasBoundArms()):
			addAction("help_with_restraints", "Помочь с путами", "Помочь им с путами!", "help", 0.2, 60, {})
		else:
			addDisabledAction("Помочь с путами", "В твоем нынешнем состоянии ты не сможешь помочь им с путами...")
	if(theStarter.hasKeyholderLocksFrom(getRoleID("reacter"))):
		if(getRolePawn("reacter").canSocial()):
			addAction("ask_for_key", "Попросить ключ...", "На тебе защелкнули умный замок-фиксатор. Так что самое время попросить ключ...", "help", 1.0, 60, {})
		else:
			addDisabledAction("Попросить ключ...", "Похоже, они сейчас не настроены на разговор...")

	# npc to pc only
	if(!theStarter.isPlayer() && theReacter.isPlayer()):
		if(!GM.main.RS.hasSpecialRelationship(theStarter.getID()) && RNG.chance(20)):
			var theAffection:float = getAffection("starter", "reacter")
			var theLust:float = getLust("starter", "reacter")
			var offerEnslaveScore:float = -0.04
			if(theAffection > 0.3 || gotDenied):
				offerEnslaveScore = 0.0
			else:
				offerEnslaveScore -= theAffection*0.02
				offerEnslaveScore += theLust*0.03
				offerEnslaveScore += scoreExposed("reacter")*0.04
				offerEnslaveScore += (-scorePersonality("starter", {PersonalityStat.Subby:1.0})+1.0)*0.5*0.03
				offerEnslaveScore += (scorePersonality("starter", {PersonalityStat.Mean:1.0})+1.0)*0.5*0.01
				offerEnslaveScore += (-scorePersonality("starter", {PersonalityStat.Coward:1.0})+1.0)*0.5*0.01
				
				offerEnslaveScore = min(offerEnslaveScore, 0.05)
				offerEnslaveScore += getRolePawn("starter").getAnger()*0.02
				
				offerEnslaveScore *= 5.0 # To even out the 20% chance
				addAction("enslave_npcOwner", "Предложить рабство", "Они достаточно покорны... а ты достаточно альфа...", "default", offerEnslaveScore, 60, {})
	
	# pc to npc only
	if(theStarter.isPlayer() && !theReacter.isPlayer()):
		if(!theStarter.isSlaveTo(theReacter.getID())):
			if(getLust("starter", "reacter") >= 0.75 || getAffection("starter", "reacter") <= -0.75):
				if(getRolePawn("reacter").canSocial()):
					addAction("enslave_ask_to_be", "Попросить стать рабом", "Попросить этого персонажа [b]поработить тебя[/b]", "default", 0.0, 60, {})
				else:
					addDisabledAction("Попросить стать рабом", "Похоже, они сейчас не настроены на разговор...")
			else:
				addDisabledAction("Попросить стать рабом", "Чтобы попросить этого персонажа сделать тебя своим рабом, уровень похоти между вами должен быть выше 75% ИЛИ уровень привязанности должен быть ниже -75%.")

	addAction("leave", "Уйти", "Хватит болтать.", "default", 0.01 if didAmount <= 0 else 0.5*sqrt(float(didAmount)), 30, {})
	if(getRolePawn("starter").canEnslaveForFree(getRolePawn("reacter"))):
		addAction("enslave_free", "Поработить!", "Они достаточно покорны... а ты достаточно альфа...", "default", 0.0, 60, {})
	

	triggerTalkRunEvents("reacter")

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "chat"):
		didAmount += 1
		gotDenied = false
		setState("chat_started", "starter")
	if(_id == "flirt"):
		didAmount += 1
		gotDenied = false
		setState("about_to_flirt", "starter")
	if(_id == "grab_and_fuck"):
		setState("grabbed_about_to_fuck", "reacter")
	if(_id == "attack"):
		startInteraction("GenericAttack", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
		if(!getRolePawn("reacter").isPlayer()):
			affectAffection("reacter", "starter", -0.25)
	if(_id == "offersex"):
		didAmount += 1
		gotDenied = false
		setState("offered_sex", "reacter")
	if(_id == "offerself"):
		didAmount += 1
		gotDenied = false
		setState("offered_self", "reacter")
	if(_id == "ask_help_restraints"):
		#setState("asking_help_restraints", "reacter")
		startInteraction("HelpingWithRestraints", {reacter=getRoleID("reacter"), starter=getRoleID("starter")})
	if(_id == "help_with_restraints"):
		startInteraction("HelpingWithRestraints", {reacter=getRoleID("starter"), starter=getRoleID("reacter")}, {reacterStarted=true})
	if(_id == "ask_for_key"):
		startInteraction("AskingForKey", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
	if(_id == "leave"):
		setState("about_to_leave", "starter")
	if(_id == "enslave_free"):
		setState("about_to_kidnap", "starter")
	if(_id == "enslave_npcOwner"):
		setState("npcEnslaveOffer", "reacter")
	if(_id == "enslave_ask_to_be"):
		setState("npcEnslaveOfferFromPC", "reacter")

func npcEnslaveOfferFromPC_text():
	saynn("Вы спрашиваете {reacter.name}, не стать ли вам рабом(ой) {reacter.his}!")
	sayLine("starter", "SoftSlaveryPCOffer", {main="starter", target="reacter"})
	
	var theAffection:float = getAffection("starter", "reacter")
	var theLust:float = getLust("starter", "reacter")
	var offerEnslaveScore:float = 0.5
	
	offerEnslaveScore -= theAffection*0.3
	offerEnslaveScore += theLust*0.3
	offerEnslaveScore += scoreExposed("starter")*0.3
	offerEnslaveScore += (-scorePersonality("reacter", {PersonalityStat.Subby:1.0})+1.0)*0.5*0.2
	offerEnslaveScore += (scorePersonality("reacter", {PersonalityStat.Mean:1.0})+1.0)*0.5*0.2
	offerEnslaveScore += (-scorePersonality("reacter", {PersonalityStat.Coward:1.0})+1.0)*0.5*0.2
	offerEnslaveScore += getRolePawn("reacter").getAnger()*0.5
	
	offerEnslaveScore = max(offerEnslaveScore, 0.3)
	
	addAction("yes", "Согласиться", "Согласиться поработить их.", "default", offerEnslaveScore, 60, {})
	addAction("no", "Отказаться", "Ты не хочешь их порабощать.", "default", 1.0, 60, {})

func npcEnslaveOfferFromPC_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "yes"):
		setState("npcEnslaveOfferFromPC_yes", "starter")
	if(_id == "no"):
		setState("npcEnslaveOfferFromPC_no", "starter")

func npcEnslaveOfferFromPC_yes_text():
	saynn("{reacter.name} соглашается поработить вас!")
	sayLine("reacter", "SoftSlaveryPCOfferYes", {main="reacter", target="starter"})
	saynn("Посмотрим, что будет дальше...")
	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func npcEnslaveOfferFromPC_yes_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var theCharID:String = getRoleID("reacter")
		stopMe()
		GM.main.RS.startSpecialRelantionship("SoftSlavery", theCharID)
		runScene("NpcOwnerEventRunnerScene", [theCharID, "Intro", ["willing"]])
		pass

func npcEnslaveOfferFromPC_no_text():
	saynn("{reacter.name} отклоняет ваше предложение!")
	sayLine("reacter", "SoftSlaveryPCOfferNo", {main="reacter", target="starter"})
	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func npcEnslaveOfferFromPC_no_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getRolePawn("reacter").satisfySocial()
		setState("", "starter")

func npcEnslaveOffer_text():
	saynn("{starter.name} внезапно делает вам предложение!")
	sayLine("starter", "SoftSlaveryOffer", {main="starter", target="reacter"})
	saynn("Похоже, {starter.he} {starter.isAre} предлагает вам [b]поработить вас[/b]...")
	
	addAction("yes", "Согласиться", "Согласиться на рабство.", "default", 0.0, 60, {})
	addAction("no", "НЕТ!", "Ты не хочешь становиться рабом.", "default", 1.0, 60, {})

func npcEnslaveOffer_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "yes"):
		setState("playerAgreedToBeEnslaved", "starter")
	if(_id == "no"):
		didAmount += 1
		gotDenied = true
		getRolePawn("starter").afterFailedSocialInteraction()
		affectAffection("starter", "reacter", -0.1)
		affectLust("starter", "reacter", -0.05)
		setState("playerDoesntWantToBeEnslaved", "reacter")

func playerDoesntWantToBeEnslaved_text():
	saynn("Вы отклоняете предложение {starter.name}!")
	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func playerDoesntWantToBeEnslaved_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")

func playerAgreedToBeEnslaved_text():
	saynn("Вы [b]соглашаетесь[/b] стать рабом!")
	sayLine("starter", "SoftSlaveryOfferYes", {main="starter", target="reacter"})
	saynn("Посмотрим, что будет дальше...")
	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func playerAgreedToBeEnslaved_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var theCharID:String = getRoleID("starter")
		stopMe()
		GM.main.RS.startSpecialRelantionship("SoftSlavery", theCharID)
		runScene("NpcOwnerEventRunnerScene", [theCharID, "Intro", ["willing"]])

func about_to_leave_text():
	saynn("{starter.name} решает уйти...")

	addAction("leave", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 30, {})

func about_to_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func chat_started_text():
	saynn("{starter.name} гадает, хочет ли {reacter.you} {reacter.youVerb('want')} поболтать.")
	sayLine("reacter", "TalkChatWhat", {main="reacter", target="starter"})
	addChatTopics("starter", "reacter", "ask")
	if(getRoleChar("starter").isPlayer()):
		showKnownLikesDislikesFor("reacter")

	addAction("cancel", "Отмена", "Проехали", "default", 1.0, 60, {})
	if(false):
		addAction("ask", "Спросить", "", "default", 1.0, 60, {})

func chat_started_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "cancel"):
		setState("chat_cancelled", "reacter")
		affectAffection("reacter", "starter", -0.02)
	if(_id == "ask"):
		chat = _args["chat"]
		setState("chat_asked", "reacter")


func chat_cancelled_text():
	sayLine("starter", "TalkChatCancel", {main="starter", target="reacter"})

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})
	addAction("leave", "Уйти", "Тогда зачем вообще болтать?!", "fight", 0.5, 30, {})

func chat_cancelled_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")
	if(_id == "leave"):
		setState("chat_leaving", "starter")
		affectAffection("starter", "reacter", -0.02)


func chat_leaving_text():
	sayLine("reacter", "TalkChatLeaving", {main="reacter", target="starter"})
	saynn("Похоже, это {reacter.him} немного раздражило...")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func chat_leaving_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getRolePawn("reacter").satisfySocial()
		stopMe()


func chat_asked_text():
	saynn("[say=starter]"+chat["topicFull"]+". Что думаешь?[/say]")
	addReactToChatButtons(chat, "react")

	if(false):
		addAction("react", "Реакция", "", "default", 1.0, 60, {})

func chat_asked_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "react"):
		doReactToChat(_args, isBeingSpied())
		chatAnswer = _args["answer"]
		setState("chat_reacted", "starter")
		if(chatAnswer != "agree"):
			gotDenied = true
			sendSocialEvent("reacter", "starter", SocialEventType.GotRefused)


func chat_reacted_text():
	if(chatAnswer=="agree"):
		sayLine("reacter", "TalkChatAgree", {main="reacter", target="starter"})
		saynn("Похоже, у {reacter.you} и {starter.you} {reacter.youVerb('share')} общий интерес.")
	elif(chatAnswer=="disagree"):
		sayLine("reacter", "TalkChatDisagree", {main="reacter", target="starter"})
		saynn("Похоже, {reacter.youHe} не понравилось высказывание {starter.your}.")
	else:
		sayLine("reacter", "TalkChatWhatever", {main="reacter", target="starter"})

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func chat_reacted_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")


func about_to_flirt_text():
	saynn("{starter.name} кажется, в кокетливом настроении...")
	if(getRoleChar("starter").isPlayer()):
		showKnownLikesDislikesFor("reacter")

	if(!getRoleChar("starter").isGagged()):
		addAction("pickup_line", "Подкат", "Не зависит от внешности... полностью рандомно", "default", 1.0, 60, {})
	else:
		addDisabledAction("Подкат", "Не получится поболтать, если рот заклеен..")
	if(false):
		addAction("flirt_do", "flirt_do", "", "default", 1.0, 60, {})

	addLustFocusButtons("flirt_do", "starter", "reacter")

func about_to_flirt_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "pickup_line"):
		pickedLineIndx = RNG.randi_range(0, PickupLineDB.DB.size()-1)
		#setState("flirt_pickupline", "reacter")
		setState("flirt_pickupline_start", "starter")
	if(_id == "flirt_do"):
		lust = _args["lust"]
		setState("flirt_flirted", "reacter")

func flirt_pickupline_start_text():
	var theEntry:Dictionary = PickupLineDB.DB[pickedLineIndx]
	saynn("[say=starter]"+theEntry["text"]+"[/say]")
	saynn("{starter.name} замирает на секунду, обдумывая, как закончить фразу...")
	
	var allAnwers:Array = []
	for correctAnswer in theEntry["correct"]:
		allAnwers.append([correctAnswer, true])
	for badAnswer in theEntry["wrong"]:
		allAnwers.append([badAnswer, false])
	allAnwers.shuffle()
	for answerEntry in allAnwers:
		addAction("pickline", answerEntry[0], "Закончить подкат этим:", "default", 1.0, 60, {args={answer=answerEntry[0], isCorrect=answerEntry[1]}})

func flirt_pickupline_start_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "pickline"):
		var theEntry:Dictionary = PickupLineDB.DB[pickedLineIndx]
		fullpickupLine = theEntry["text"].replace("___", _args["answer"])
		isLineCorrect = _args["isCorrect"]
		setState("flirt_pickupline", "reacter")

func flirt_pickupline_text():
	#sayLine("starter", "TalkChatPickupLine", {main="starter", target="reacter"})
	saynn("[say=starter]"+fullpickupLine+"[/say]")

	addAction("accept", "Принять", "А подкат был ничего так..", "acceptFlirt", 1.0 if isLineCorrect else 0.0, 60, {})
	addAction("deny", "Отказать", "Это было просто ужасно..", "default", 1.0 if !isLineCorrect else 0.0, 60, {})

func flirt_pickupline_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "accept"):
		affectLust("reacter", "starter", 0.1)
		setState("flirt_accepted", "starter")
	if(_id == "deny"):
		affectLust("reacter", "starter", -0.07)
		setState("flirt_denied", "starter")
		gotDenied = true
		sendSocialEvent("reacter", "starter", SocialEventType.GotRefused)


func flirt_accepted_text():
	saynn("{reacter.name} улыбается. Похоже, подкат сработал...")

	addAction("continue", "Продолжить", "Смотреть, что будет дальше", "default", 1.0, 60, {})

func flirt_accepted_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")
		getRolePawn("reacter").afterSocialInteraction()
		getRolePawn("starter").afterSocialInteraction()


func flirt_denied_text():
	sayLine("reacter", "TalkChatPickupLineFail", {main="reacter", target="starter"})
	saynn("Ну что ж, попытка не пытка...")

	addAction("continue", "Продолжить", "Смотреть, что будет дальше", "default", 1.0, 60, {})

func flirt_denied_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")
		getRolePawn("reacter").afterSocialInteraction()
		getRolePawn("starter").afterFailedSocialInteraction()


func flirt_flirted_text():
	var focus = lust["focus"]
	if(focus == LustFocus.Body):
		saynn("{starter.You} {starter.youVerb('sway')} {starter.yourHis} {starter.thick} {starter.masc} тело с чувством...")
	elif(focus == LustFocus.Butt):
		saynn("{starter.You} {starter.youVerb('turn')} вокруг и {starter.youVerb('wiggle')} {starter.yourHis} {starter.thick} {starter.anusStretch} задницу с чувством...")
	elif(focus == LustFocus.Breasts):
			saynn("{starter.You} {starter.youVerb('jiggle')} и {starter.youVerb('grope')} {starter.yourHis} {starter.breasts}...")
	elif(focus == LustFocus.Crotch):
		var hasPenis = getRoleChar("starter").hasPenis()
		var hasVag = getRoleChar("starter").hasVagina()
		if(hasPenis && hasVag):
			saynn("{starter.You} гордо {starter.youVerb('present')} {starter.yourHis} {starter.penis} и {starter.pussyStretch} {pussy}...")
		elif(hasPenis):
			saynn("{starter.You} гордо {starter.youVerb('present')} {starter.yourHis} {starter.penis}...")
		elif(hasVag):
			saynn("{starter.You} гордо {starter.youVerb('present')} {starter.yourHis} {starter.pussyStretch} {pussy}...")
		else:
			saynn("{starter.You} гордо {starter.youVerb('present')} {starter.yourHis} промежность...")
	addReactToLustFocusButtons("flirt_react", lust)

	if(false):
		addAction("flirt_react", "flirt_react", "", "default", 1.0, 60, {})

func flirt_flirted_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "flirt_react"):
		reactToLustFocus(_args, lust)
		setState("flirt_reacted", "starter")
		var answer:String = lust["answer"] if lust.has("answer") else "accept"
		if(answer != "accept"):
			sendSocialEvent("reacter", "starter", SocialEventType.GotRefused)


func flirt_reacted_text():
	var answer:String = lust["answer"] if lust.has("answer") else "accept"
	var likeness:float = lust["likeness"] if lust.has("likeness") else 1.0
	var text:String = lust["text"] if lust.has("text") else ""
	var hasLearnedAnyLustInterests:bool = lust["hasLearnedAnyLustInterests"] if lust.has("hasLearnedAnyLustInterests") else false
	if(answer == "accept"):
		sayLine("reacter", "TalkFlirtAccept", {main="reacter", target="starter"})
	else:
		gotDenied = true
		sayLine("reacter", "TalkFlirtDeny", {main="reacter", target="starter"})
	if(getRolePawn("starter").isPlayer()):
		if(text != ""):
			saynn(text+" ("+str(Util.roundF(likeness*100.0, 1))+"% шанс успеха)")
		if(hasLearnedAnyLustInterests == true):
			addMessage("Вы узнали кое-что новое о вкусах и предпочтениях {reacter.nameS}..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func flirt_reacted_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")


func offered_sex_text():
	saynn("{starter.name} предлагает трахнуть {reacter.you}..")
	sayLine("starter", "TalkSexOffer", {main="starter", target="reacter"})

	addAction("agree", "Согласиться", "Позволить им трахнуть тебя!", "agreeSexAsSub", 1.0, 60, {})
	addAction("deny", "Отказать", "Пожалуй, лучше не надо...", "default", 0.2, 60, {})

func offered_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "agree"):
		setState("offered_sex_agreed", "starter")
	if(_id == "deny"):
		setState("offered_sex_deny", "starter")
		affectAffection("starter", "reacter", -0.1)
		getRolePawn("reacter").afterSocialInteraction()
		getRolePawn("starter").afterFailedSocialInteraction()
		gotDenied = true
		sendSocialEvent("reacter", "starter", SocialEventType.GotRefused)


func offered_sex_agreed_text():
	sayLine("reacter", "TalkSexOfferAccept", {main="reacter", target="starter"})

	addAction("sex", "Секс", "Пора трахаться!", "default", 1.0, 600, {start_sex=["starter", "reacter"],})

func offered_sex_agreed_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "starter")


func offered_sex_deny_text():
	sayLine("reacter", "TalkSexOfferDeny", {main="reacter", target="starter"})
	saynn("Похоже, {starter.you} получил отказ..")

	addAction("continue", "Продолжить", "Ну, что ж..", "default", 1.0, 60, {})

func offered_sex_deny_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")


func offered_self_text():
	saynn("{starter.name} предлагает {starter.him} трахнуть {reacter.you}.")
	sayLine("starter", "TalkSexOfferSelf", {main="starter", target="reacter"})

	addAction("agree", "Согласиться", "Согласиться трахнуться с ними", "agreeSexAsDom", 1.0, 60, {})
	addAction("deny", "Отказать", "Пожалуй, лучше не надо...", "default", 0.2, 60, {})

func offered_self_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "agree"):
		setState("offered_self_agreed", "starter")
	if(_id == "deny"):
		setState("offered_self_deny", "starter")
		affectAffection("starter", "reacter", -0.1)
		getRolePawn("reacter").afterSocialInteraction()
		getRolePawn("starter").afterFailedSocialInteraction()
		gotDenied = true
		sendSocialEvent("reacter", "starter", SocialEventType.GotRefused)


func offered_self_agreed_text():
	sayLine("reacter", "TalkSexOfferSelfAccept", {main="reacter", target="starter"})

	addAction("sex", "Секс", "Пора трахаться!", "default", 1.0, 600, {start_sex=["reacter", "starter"],})

func offered_self_agreed_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "starter")


func offered_self_deny_text():
	sayLine("reacter", "TalkSexOfferSelfDeny", {main="reacter", target="starter"})

	addAction("continue", "Продолжить", "Ну, что ж..", "default", 1.0, 60, {})

func offered_self_deny_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")


func after_sex_text():
	saynn("После этого секса пришло время разойтись..")

	addAction("continue", "Продолжить", "", "default", 1.0, 60, {})

func after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func grabbed_about_to_fuck_text():
	saynn("{starter.You} {starter.youVerb('grab')} {reacter.you}..")
	saynn("{reacter.You} быстро {reacter.youVerb('realize')} {reacter.yourHis}, что эти оковы не дадут {reacter.youHim} сбежать..")
	sayLine("starter", "TalkGrabAndFuck", {main="starter", target="reacter"})

	addAction("sex", "Секс", "Тебе полная пизда..", "default", 1.0, 600, {start_sex=["starter", "reacter"],})

func grabbed_about_to_fuck_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_grab_and_fuck", "reacter")


func after_grab_and_fuck_text():
	saynn("{starter.name} уходит, поигравшись с {reacter.you}..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func after_grab_and_fuck_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func about_to_kidnap_text():
	saynn("{starter.You} {starter.youVerb('grab')} {reacter.yourHis}, а {starter.youVerb('look')} {reacter.youHim} прямо в глаза..")
	saynn("Одна лишь доминантная аура {starter.YourHis} заставляет {reacter.youHim} дрожать..")
	sayLine("starter", "TalkAboutToKidnap", {main="starter", target="reacter"})
	sayLine("reacter", "TalkAboutToKidnapReact", {main="reacter", target="starter"})

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func about_to_kidnap_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()
		runScene("KidnapDynamicNpcScene", [getRoleID("reacter")])


func shouldShowBigButtons() -> bool:
	if((getState() in ["chat_started"]) && isPlayersTurn()):
		return true
	if((getState() in ["flirt_pickupline_start"]) && isPlayersTurn()):
		return true
	return false

func getAnimData() -> Array:
	if(getState() in ["about_to_kidnap"]):
		return [StageScene.Choking, "idle", {pc="starter", npc="reacter"}]
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]

func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "starter"):
		return "{starter.name} болтает с {reacter.name}."
	if(_role == "reacter"):
		return "{reacter.name} болтает с {starter.name}."
	return .getPreviewLineForRole(_role)

func doHelpStruggleForStarter():
	var theStarter = getRoleChar("starter")
	var struggleData:Dictionary = theStarter.doStruggleOutOfRestraints(false, true, getRoleChar("reacter"), 2.0)
	if(struggleData.empty()):
		struggleText = "Что-то произошло..."
	else:
		struggleText = struggleData["text"]

func saveData():
	var data = .saveData()

	data["chat"] = chat
	data["lust"] = lust
	data["chatAnswer"] = chatAnswer
	data["surrendered"] = surrendered
	data["notFirst"] = notFirst
	data["struggleText"] = struggleText
	data["tryCount"] = tryCount
	data["askCredits"] = askCredits
	data["didAmount"] = didAmount
	data["gotDenied"] = gotDenied
	data["pickedLineIndx"] = pickedLineIndx
	data["fullpickupLine"] = fullpickupLine
	data["isLineCorrect"] = isLineCorrect
	return data

func loadData(_data):
	.loadData(_data)

	chat = SAVE.loadVar(_data, "chat", {})
	lust = SAVE.loadVar(_data, "lust", {})
	chatAnswer = SAVE.loadVar(_data, "chatAnswer", "")
	surrendered = SAVE.loadVar(_data, "surrendered", false)
	notFirst = SAVE.loadVar(_data, "notFirst", false)
	struggleText = SAVE.loadVar(_data, "struggleText", "")
	tryCount = SAVE.loadVar(_data, "tryCount", 0)
	askCredits = SAVE.loadVar(_data, "askCredits", 0)
	didAmount = SAVE.loadVar(_data, "didAmount", 0)
	gotDenied = SAVE.loadVar(_data, "gotDenied", false)
	fullpickupLine = SAVE.loadVar(_data, "fullpickupLine", "")
	isLineCorrect = SAVE.loadVar(_data, "isLineCorrect", false)
	pickedLineIndx = SAVE.loadVar(_data, "pickedLineIndx", 0)
	if(pickedLineIndx < 0):
		pickedLineIndx = 0
	if(pickedLineIndx >= PickupLineDB.DB.size()):
		pickedLineIndx = RNG.randi_range(0, PickupLineDB.DB.size()-1)
