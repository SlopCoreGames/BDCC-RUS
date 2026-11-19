extends PawnInteractionBase

var jobTime:int = 0
var minTime:int = 0
var askCreds:int = 0
var askType:String = ""
var slutDom:bool = false
var clientSatisfaction:float = 0.0
var lastClientID:String = ""
var clientApproached:bool = false
var clientRequestedAskType:String = ""
var clientCooldowns:Dictionary = {}

var clientCooldownSeconds:int = 2*60*60

func _init():
	id = "Prostitution"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("main", _pawns["main"])
	setState("", "main")
	if(_args.has("minTime")):
		minTime = _args["minTime"]

func init_text():
	saynn("{main.You} {main.youAre} стоит у стены, {main.yourHis} прижав ногу к ней..")

	addAction("search", "Искать клиентов", "Активно выискивать клиентов", "default", 0.5, 60, {})
	addAction("wait", "Просто подожди", "Просто ждать, пока кто-нибудь сам к тебе подойдет", "default", 1.0, 180, {})
	addAction("stop", "Стой", "Хватит уже этой шлюшни...", "default", (0.2 if (jobTime > (60*30)) else 0.01) if minTime <= 0 else (0.2 if (jobTime > minTime) else 0.0), 0, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "search"):
		var ignoreList:Array = []
		for charID in clientCooldowns:
			ignoreList.append(charID)
		var pawnIDs:Array = findProstitutionTargetsNearby(ignoreList)
		if(!pawnIDs.empty()):
			var pawnID = RNG.pick(pawnIDs)
			clientApproached = false
			setClientToCharID(pawnID)
			return
		setState("", "main")
	if(_id == "wait"):
		setState("", "main")
	if(_id == "stop"):
		stopMe()


func found_client_text():
	if(clientRequestedAskType == ""):
		if(!clientApproached):
			saynn("{main.You} {main.youVerb('call')} {client.you}, чтобы подобраться ближе..")
		else:
			saynn("{client.You} {client.youVerb('approach', 'approaches')} {main.you}..")
		sayLine("main", "ProstitutionStart", {main="main", target="client"})
		sayLine("client", "ProstitutionOffer", {main="client", target="main"})
	else:
		var clientIsMean:bool = getRolePawn("client").scorePersonalityMax({PersonalityStat.Mean: 1.0}) > 0.4
		var askRole:String = "Dom" if(clientRequestedAskType == "service") else "Sub"
		if(clientIsMean):
			saynn(RNG.pick([
				"{client.You} {client.youVerb('demand')} пора покончить с этой {main.you} {main.youVerb('think')} {main.yourHis} ситуацией..",
				"{client.You} {client.youVerb('move')} делает пугающий шаг к {main.you}, заметно взбешенный {main.yourHis} предположением..",
			]))
		else:
			var client_playfully:String = RNG.pick(["assertively", "bluntly", "boldly", "playfully", "pleadingly", "teasingly"])
			saynn(RNG.pick([
				"{client.You} "+client_playfully+" {client.youVerb('gesture')} на {main.you}, гадая, не предложил бы {main.youHe} что-то другое для {client.youHim}..",
				"{client.You} {client.youVerb('think')} предложение {main.your}, но в итоге {client.youVerb('decide')} решается спросить, не готов ли {main.youHe} к чему-то другому..",
			]))
		sayLine("client", "ProstitutionClientAskFor"+askRole+"Slut", {main="client", target="main"})
		if(getRoleChar("main").isPlayer()):
			saynn("Похоже, {client.name} хочет, чтобы ты был "+("доминант-провайдер" if(clientRequestedAskType == "service") else "сабмиссив")+"..")
	
	var haveAnyOptions:bool = false
	
	var ACTION_NAME_USUAL:String = "Usual"
	var ACTION_NAME_SERVICE_DOM:String = "Доминантная услуга"
	var ACTION_NAME_PRICY_SLUT:String = "Дорогая шлюшка"
	var ACTION_DESC_CLIENT_NOT_INTERESTED:String = "Клиента это не интересует..."
	if(clientRequestedAskType in ["", "usual"]):
		if(roleCanStartSex("client")):
			addAction("usual", ACTION_NAME_USUAL, "Позволь им трахать тебя как угодно и за относительно небольшие деньги..", "sexSub", 1.0, 60, {})
			haveAnyOptions = true
		else:
			addDisabledAction(ACTION_NAME_USUAL, "С такими путами они не смогут быть доминантами..")
	else:
		addDisabledAction(ACTION_NAME_USUAL, ACTION_DESC_CLIENT_NOT_INTERESTED)
	if(clientRequestedAskType in ["", "service"]):
		var hasWhoreRepForServiceDom:bool = hasWhoreRepLevelPC_forAskType("service")
		if(roleCanStartSex("main") && ((clientRequestedAskType == "service") || hasWhoreRepForServiceDom)):
			addAction("service", ACTION_NAME_SERVICE_DOM, "Главной будешь ты. Это требует больше усилий,"+(".. так что брать придется больше кредитов," if(hasWhoreRepForServiceDom) else " но твоя репутация шлюхи пока слишком низка, чтобы требовать больше,"), "sexDom", 1.0, 60, {})
			haveAnyOptions = true
		else:
			addDisabledAction(ACTION_NAME_SERVICE_DOM, "С такими путами ты не сможешь быть сервис-домом.." if !roleCanStartSex("main") else "Твоя репутация шлюхи еще недостаточно высока для этого..")
	else:
		addDisabledAction(ACTION_NAME_SERVICE_DOM, ACTION_DESC_CLIENT_NOT_INTERESTED)
	if(clientRequestedAskType in ["", "usual"]):
		if(roleCanStartSex("client") && hasWhoreRepLevelPC_forAskType("pricy")):
			addAction("pricy_slut", ACTION_NAME_PRICY_SLUT, "Требуй кучу кредитов за то, чтобы они тебя трахали.. Но тогда тебе придется их по-настоящему удовлетворять..", "resist", 1.0, 60, {})
			haveAnyOptions = true
		else:
			addDisabledAction(ACTION_NAME_PRICY_SLUT, "С такими путами они не смогут быть доминантами.." if !roleCanStartSex("client") else "Твоя репутация шлюхи еще недостаточно высока для этого..")
	else:
		addDisabledAction(ACTION_NAME_PRICY_SLUT, ACTION_DESC_CLIENT_NOT_INTERESTED)
	if(clientRequestedAskType == ""):
		addAction("cancel", "Отмена", "Вы передумали и не хотите их обслуживать", "default", 0.0 if haveAnyOptions else 1.0, 60, {})
	else:
		addAction("refuse_opposite_role_request", "Отказаться", "Вам не интересно быть "+("сервис-домом" if(clientRequestedAskType == "service") else "sub")+" для них.", "default", 0.0 if haveAnyOptions else 1.0, 60, {})

func found_client_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "usual"):
		askType="usual"
		askCreds = getRolePawn("main").getProstitutionCreditsCost(getRolePawn("client"))
		slutDom = false
		setState("giving_offer", "client")
	if(_id == "service"):
		askType="service"
		var hasWhoreRepForServiceDom:bool = hasWhoreRepLevelPC_forAskType("service")
		var creditsCostMult:float = 2.0 if(hasWhoreRepForServiceDom) else 1.0
		askCreds = getRolePawn("main").getProstitutionCreditsCost(getRolePawn("client"), creditsCostMult, true)
		slutDom = true
		setState("giving_offer", "client")
	if(_id == "pricy_slut"):
		askType="pricy"
		askCreds = getRolePawn("main").getProstitutionCreditsCost(getRolePawn("client"), 3.0)
		slutDom = false
		setState("giving_offer", "client")
	if(_id == "cancel"):
		setState("cancelled_service", "main")
		affectAffection("client", "main", -0.05)
	if(_id == "refuse_opposite_role_request"):
		setState("opposite_role_request_denied", "main")
		affectAffection("client", "main", -0.02)


func giving_offer_text():
	if(clientRequestedAskType == ""):
		var teaseActions:Array = []
		var main_playfully:String = RNG.pick(["naughtily", "playfully", "seductively", "teasingly"])
		if(askType == "service"):
			# not wearing any restraints that would prohibit being a dom
			teaseActions.append_array([
				"{main.You} "+main_playfully+" {main.youVerb('fiddle')} с цепью в {main.yourHis} руках.",
			])
		else:
			teaseActions.append_array([
				"{main.You} "+main_playfully+" {main.youVerb('sway')} {main.yourHis} бедрами рядом с {client.you}.",
			])
			if(getRoleChar("main").bodypartHasTrait(BodypartSlot.Tail, PartTrait.TailFlexible)):
				teaseActions.append_array([
					"{main.You} {main.youVerb('turn')} вокруг и "+main_playfully+" {main.youVerb('raise')} {main.yourHis} хвостом на мгновение. Ну и дразнилка.",
				])
		if(!getRoleChar("main").isBlindfolded()):
			teaseActions.append_array([
				"{main.You} {main.youVerb('wink')} at {client.you}.",
				"{main.You} {main.youVerb('give')} {client.you} похотливым взглядом.",
			])
		if(!getRoleChar("main").isGagged()):
			teaseActions.append_array([
				"{main.You} "+main_playfully+" {main.youVerb('lick')} over {main.yourHis} "+RNG.pick(["upper", "lower"])+" lip.",
			])
		if(!getRoleChar("main").hasBoundArms() && !getRoleChar("main").hasBlockedHands()):
			teaseActions.append_array([
				"{main.You} "+main_playfully+" {main.youVerb('brush', 'brushes')} {main.yourHis} рукой поверх {main.yourHis} "+("crotch" if(askType == "service") else "butt")+".",
			])
			if(getRoleChar("main").hasNonFlatBreasts()):
				teaseActions.append_array([
					"{main.You} {main.youVerb('give')} груди {main.yourHis} медленным, дразнящим сжатием.",
				])
		if(teaseActions.size() > 0):
			saynn(RNG.pick(teaseActions))
	else:
		saynn(RNG.pick([
			"{main.You} {main.youVerb('think')} ненадолго.",
			"{main.You} {main.youVerb('ponder')} на мгновение.",
		]))
	if(askType=="usual"):
		sayLine("main", "ProstitutionUsual", {main="main", target="client"}, {credits=askCreds})
	elif(askType=="service"):
		sayLine("main", "ProstitutionServiceDom", {main="main", target="client"}, {credits=askCreds})
		if(!getRoleChar("main").isPlayer() && (clientRequestedAskType == "")):
			saynn("Похоже, {main.name} предлагает роль доминантной..")
	elif(askType=="pricy"):
		sayLine("main", "ProstitutionPricySlut", {main="main", target="client"}, {credits=askCreds})

	if(!getRolePawn("client").isPlayer() || GM.pc.getCredits() >= askCreds):
		var scoreType:String = "agreeSexWithDomSlut" if(slutDom) else "agreeSexWithSubSlut"
		addAction("agree", "Согласиться", "Отдать им кредиты и сделать дело", scoreType, 1.0, 60, {})
	else:
		addDisabledAction("Согласиться", "Недостаточно кредитов...")
	if(clientRequestedAskType == ""):
		var ACTION_NAME_REQUEST_SUB_SLUT:String = "I need a sub"
		var ACTION_NAME_REQUEST_DOM_SLUT:String = "I need a dom"
		if(roleCanStartSex("client" if(slutDom) else "main")):
			var scoreTypeOppositeRole:String = "agreeSexWithSubSlut" if(slutDom) else "agreeSexWithDomSlut"
			addAction("request_opposite_role", (ACTION_NAME_REQUEST_SUB_SLUT if(slutDom) else ACTION_NAME_REQUEST_DOM_SLUT), "Отказаться "+("подчиняться" if(slutDom) else "dom")+" им, но проявить интерес к "+("вместо этого доминировать над ними" if(slutDom) else "доминант-провайдер"), scoreTypeOppositeRole, 0.5, 60, {})
		elif(slutDom):
			addDisabledAction(ACTION_NAME_REQUEST_SUB_SLUT, "С такими кандалами тебе не получится над ними доминировать...")
		else:
			addDisabledAction(ACTION_NAME_REQUEST_DOM_SLUT, "С такими путами они не смогут оказывать услуги доминантного типа...")
	addAction("deny", "Отказать", "Пожалуй, лучше не надо...", "default", 1.0, 60, {})
	if(false):
		addAction("haggle", "Торговаться", "Эта шлюха явно не стоит таких денег... Попробуй поторговаться", "default", 1.0, 60, {})

func giving_offer_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "agree"):
		if(getRolePawn("client").isPlayer()):
			GM.pc.addCredits(-askCreds)
		if(getRolePawn("main").isPlayer()):
			GM.pc.addCredits(askCreds)
		setState("offer_accepted", "main")
		sendSlaveryActivityEvent("main", "slutPaid", {credits=askCreds})
	if(_id == "request_opposite_role"):
		clientRequestedAskType = "usual" if(slutDom) else "service"
		setState("found_client", "main")
	if(_id == "deny"):
		setState("offer_denied", "main")
		sendSocialEvent("client", "main", SocialEventType.GotRefused)
	if(_id == "haggle"):
		setState("meow", "inmate")


func offer_denied_text():
	sayLine("client", "ProstitutionDenied", {main="client", target="main"})
	sayLine("main", "ProstitutionDeniedWhatever", {main="main", target="client"})

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func offer_denied_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getRolePawn("main").afterFailedSocialInteraction()
		getRolePawn("client").satisfySocial()
		doRemoveRole("client")
		setState("", "main")


func offer_accepted_text():
	saynn("{client.You} {client.youVerb('hand')} {main.you} кредиты.")
	sayLine("client", "ProstitutionAccept", {main="client", target="main"})
	saynn("Пришло время для самого интересного..")

	addAction("sex", "Секс", "Приготовься к этому...", "default", 1.0, 60, {})
	addAction("scam", "Развести на деньги", "Внезапно потребовать больше кредитов", "punishMean", 0.5, 60, {})

func offer_accepted_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		setState("about_to_sex", "main")
	if(_id == "scam"):
		setState("slut_scam", "client")
		#affectAffection("client", "main", -0.15)
		sendSocialEvent("main", "client", SocialEventType.GotScammed)


func about_to_sex_text():
	saynn("Пара уходит с дороги остальным..")
	saynn("{main.You} {main.youVerb('pull')} {client.you} поближе для секса..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {start_sex=["main" if slutDom else "client", "client" if slutDom else "main", SexType.DefaultSex, {SexMod.BondageDisabled: !slutDom}],})

func about_to_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var _result:SexEngineResult = getSexResult(_args, true)
		if(_result):
			if(slutDom):
				clientSatisfaction = _result.getSubSatisfaction(getRoleID("client"))
			else:
				clientSatisfaction = _result.getDomSatisfaction(getRoleID("client"))
		else:
			Log.printerr("Prostitution interaction received null sex result")
		setState("after_sex", "client")


func after_sex_text():
	saynn("Секс закончился..")
	saynn(("Твой" if(getRoleChar("client").isPlayer()) else "Client's")+"уровень удовлетворения составляет.. "+str(Util.roundF(clientSatisfaction*100.0, 1))+"%")

	addAction("leave", "Уйти", "Было неплохо", "default", (clientSatisfaction if (askType!="pricy") else (clientSatisfaction/2.0)), 60, {})
	addAction("demand_creds_back", "Потребовать кредиты назад", "Хреново вышло, эта шлюха должна вернуть тебе кредиты", "default", (0.05 if clientSatisfaction > 0.9 else (1.0 if clientSatisfaction <= 0.5 else 0.4)), 60, {})

func after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		addRepScore("main", RepStat.Whore, float(askCreds)/50.0)
		doRepEvent("main", "whoreany")
		if(askCreds >= 30):
			doRepEvent("main", "whorelot")
		setState("client_leaving", "client")
	if(_id == "demand_creds_back"):
		setState("client_demands_credits", "main")


func client_leaving_text():
	saynn("{client.You} {client.youAre} уходит, довольный.")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func client_leaving_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("client")
		setState("", "main")


func client_demands_credits_text():
	sayLine("client", "ProstitutionDemandCreds", {main="client", target="main"})
	saynn(("Ты —" if(getRoleChar("client").isPlayer()) else "Клиент...")+" явно злится..")

	addAction("return_creds", "Вернуть кредиты", "Всё равно тебе их будет не хватать", "surrender", 1.0, 60, {})
	addAction("refuse", "Отказаться", "", "fight", 1.0, 60, {})

func client_demands_credits_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "return_creds"):
		if(getRolePawn("client").isPlayer()):
			GM.pc.addCredits(askCreds)
			addMessage("Ты вернул кредиты!")
		if(getRolePawn("main").isPlayer()):
			GM.pc.addCredits(-askCreds)
		setState("client_got_credits_back", "client")
		affectAffection("client", "main", 0.1)
		sendSlaveryActivityEvent("main", "slutReturnedCredits", {credits=askCreds})
	if(_id == "refuse"):
		setState("slut_refused_creds_back", "client")
		affectAffection("client", "main", -0.2)
		sendSocialEvent("client", "main", SocialEventType.GotScammed)


func client_got_credits_back_text():
	saynn("{main.You} {main.youVerb('huff')}, но {main.youVerb('hand')} {client.you} кредиты обратно.")
	saynn("Вы киваете и уходите." if(getRoleChar("client").isPlayer()) else "Клиент кивает и уходит.")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func client_got_credits_back_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("client")
		setState("", "main")


func slut_refused_creds_back_text():
	sayLine("main", "ProstitutionRefuseReturnCreds", {main="main", target="client"})
	saynn("Обстановка стремительно накаляется..")

	addAction("whatever", "Да и хрен с ним", "Пусть оставляют деньги себе", "surrender", 1.0, 60, {})
	addAction("attack", "Атаковать", "Попробовать забрать их силой...", "fight", 1.0, 60, {})

func slut_refused_creds_back_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "whatever"):
		setState("client_leaving_grumbly", "client")
	if(_id == "attack"):
		setState("client_attacked_slut", "main")


func client_leaving_grumbly_text():
	saynn("{client.You} {client.youVerb('grumble')}.. но {client.youVerb('leave')} в конце концов.")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func client_leaving_grumbly_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		doRemoveRole("client")
		setState("", "main")


func client_attacked_slut_text():
	saynn("{client.You} {client.youVerb('decide')}, чтобы напасть на {main.you}!")
	sayLine("client", "AttackStart", {main="client", target="main"})

	addAction("fight", "Драться", "Пора дать сдачи...", "default", 1.0, 600, {start_fight=["client", "main"],})

func client_attacked_slut_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "fight"):
		var fightResult = getFightResult(_args)
		
		if(fightResult["won"]):
			if(getRolePawn("client").isPlayer()):
				GM.pc.addCredits(askCreds)
				addMessage("Ты вернул кредиты!")
			if(getRolePawn("main").isPlayer()):
				GM.pc.addCredits(-askCreds)
		
			setState("client_won", "client")
			sendSlaveryActivityEvent("main", "slutReturnedCredits", {credits=askCreds})
			sendSocialEvent("client", "main", SocialEventType.LostFight)
		else:
			setState("slut_won", "main")
			sendSocialEvent("main", "client", SocialEventType.LostFight)


func client_won_text():
	saynn("{client.You} победил! {main.You} {main.youAre} на полу, не в силах продолжать бой..")
	saynn("{client.You} {client.youVerb('take')} кредиты обратно у этой шлюхи..")

	addAction("leave", "Уйти", "Пора идти..", "default", 0.2, 60, {})
	addAction("punish", "Наказать", "Заставить их пожалеть о содеянном.", "punishMean", 1.0, 60, {})

func client_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		setState("client_won_leave", "client")
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("client"), target=getRoleID("main")})


func client_won_leave_text():
	saynn("Забрав кредиты, {client.you} просто {client.youVerb('leave')}..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func client_won_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func slut_won_text():
	saynn("{main.You} победила! {client.You} {client.youAre} на полу, не в силах продолжать бой..")

	addAction("kick_them_away", "Отпихнуть их", "Отпихнуть это отребье", "default", 0.4, 60, {})
	addAction("punish", "Наказать", "Заставить их пожалеть об этом", "punishMean", 1.0, 60, {})

func slut_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "kick_them_away"):
		setState("slut_won_kick", "main")
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("main"), target=getRoleID("client")})


func slut_won_kick_text():
	saynn("{main.You} {main.youVerb('decide')} просто отпихнуть {client.you} подальше от {main.yourHis} рабочего места..")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func slut_won_kick_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		var theLoc:String = getLocation()
		var _ok = doWanderGurantee()
		doRemoveRole("client")
		setLocation(theLoc)
		setState("", "main")


func slut_scam_text():
	sayLine("main", "ProstitutionScam", {main="main", target="client"})
	saynn("[say=client]Ты серьезно?[/say]")
	saynn("[say=main]Плати или проваливай.[/say]")
	saynn("Похоже, услуги {main.your} только что подорожали..")

	if(!getRolePawn("client").isPlayer() || GM.pc.getCredits() >= 5):
		addAction("pay", "Заплатить", "Накинуть еще 5 кредитов сверху", "surrender", 1.0, 60, {})
	addAction("leave", "Уйти", "Да какая разница...", "surrender", 1.0, 60, {})
	addAction("demand_creds_back", "Потребовать кредиты назад", "Хватит. Ты просто хочешь вернуть свои кредиты.", "fight", 1.0, 60, {})

func slut_scam_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "pay"):
		affectAffection("client", "main", -0.15)
		askCreds += 5
		if(getRolePawn("client").isPlayer()):
			GM.pc.addCredits(-5)
		if(getRolePawn("main").isPlayer()):
			GM.pc.addCredits(5)
		setState("offer_accepted", "main")
		
		sendSlaveryActivityEvent("main", "slutPaid", {credits=5})
	if(_id == "leave"):
		affectAffection("client", "main", -0.15)
		setState("client_leaving_grumbly", "client")
	if(_id == "demand_creds_back"):
		affectAffection("client", "main", -0.15)
		setState("client_demands_credits", "main")


func cancelled_service_text():
	saynn("{main.You} {main.youVerb('decide')}, чтобы в последний момент передумать {main.yourHis}.")
	saynn("[say=main]Ой, я передумала.[/say]")
	saynn("[say=client]Ладно, хрен с тобой.[/say]")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func cancelled_service_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getRolePawn("client").afterFailedSocialInteraction()
		doRemoveRole("client")
		setState("", "main")


func opposite_role_request_denied_text():
	saynn("{main.You} {main.youVerb('shake')} {main.yourHis} head.")
	saynn(RNG.pick([
		"Похоже, {client.you} придется искать кого-то другого...",
		"{client.You} {client.youVerb('walk')} прочь, с легким разочарованием...",
	]))

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func opposite_role_request_denied_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		getRolePawn("main").satisfySocial()
		getRolePawn("client").satisfySocial()
		doRemoveRole("client")
		setState("", "main")


func getInterruptActions(_pawn:CharacterPawn) -> Array:
	var result:Array = []
	if(getPawnCount() == 1):
		var approachScore:float = -0.01 if(clientCooldowns.has(_pawn.charID)) else 0.5
		result.append({
			id = "approach",
			name = "Подойти",
			desc = "Посмотреть, что они предлагают...",
			score = approachScore,
			scoreType = "sexUse",
			scoreRole = "main",
			args = {},
		})
	return result

func doInterruptAction(_pawn:CharacterPawn, _id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "approach"):
		clientApproached = true
		setClientToCharID(_pawn.charID)


func getAnimData() -> Array:
	if(getPawnCount() > 1):
		return [StageScene.Duo, "stand", {pc="main", npc="client"}]
	return [StageScene.Solo, "stand", {pc="main"}]

func hasWhoreRepLevelPC_forAskType(_askType:String) -> bool:
	if(_askType == "pricy"):
		return hasRepLevelPC("main", RepStat.Whore, 8)
	if(_askType == "service"):
		return hasRepLevelPC("main", RepStat.Whore, 4)
	return true

func isSlutDom():
	return slutDom

func setClientToCharID(charID:String) -> void:
	lastClientID = charID
	# let creatures be obsessed sometimes, as a treat
	if(RNG.chance(95)):
		clientCooldowns[charID] = clientCooldownSeconds
	doInvolvePawn("client", charID)
	clientRequestedAskType = ""
	setState("found_client", "main")

func processTime(_howMuch:int):
	jobTime += _howMuch
	if(clientCooldowns.empty() || _howMuch <= 0):
		return
	var newClientCooldowns:Dictionary = {}
	for charID in clientCooldowns:
		clientCooldowns[charID] -= _howMuch
		if(clientCooldowns[charID] > 0):
			newClientCooldowns[charID] = clientCooldowns[charID]
	clientCooldowns = newClientCooldowns
	
func getActivityIconForRole(_role:String):
	if(getPawnCount() == 1):
		return RoomStuff.PawnActivity.Prostitution
	else:
		return .getActivityIconForRole(_role)

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "main"):
		return "{main.name} воркует с {main.himself}.."
	if(_role == "client"):
		return "{client.name} выступает клиентом у {main.name}."
	return .getPreviewLineForRole(_role)

func saveData():
	var data = .saveData()

	data["jobTime"] = jobTime
	data["minTime"] = minTime
	data["askCreds"] = askCreds
	data["askType"] = askType
	data["slutDom"] = slutDom
	data["clientSatisfaction"] = clientSatisfaction
	data["lastClientID"] = lastClientID
	data["clientApproached"] = clientApproached
	data["clientReqAskType"] = clientRequestedAskType
	data["clientCooldowns"] = clientCooldowns
	return data

func loadData(_data):
	.loadData(_data)

	jobTime = SAVE.loadVar(_data, "jobTime", 0)
	minTime = SAVE.loadVar(_data, "minTime", 0)
	askCreds = SAVE.loadVar(_data, "askCreds", 0)
	askType = SAVE.loadVar(_data, "askType", "")
	slutDom = SAVE.loadVar(_data, "slutDom", false)
	clientSatisfaction = SAVE.loadVar(_data, "clientSatisfaction", 0.0)
	lastClientID = SAVE.loadVar(_data, "lastClientID", "")
	clientApproached = SAVE.loadVar(_data, "clientApproached", false)
	clientRequestedAskType = SAVE.loadVar(_data, "clientReqAskType", "")
	clientCooldowns = SAVE.loadVar(_data, "clientCooldowns", {})

