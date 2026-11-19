extends PawnInteractionBase

var domSatisfaction = 0.0

func _init():
	id = "AskingForKey"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])
	setState("", "reacter")

func init_text():
	saynn("{starter.name} неловко переминается с ноги на ногу.")
	sayLine("starter", "AskKeyCanYouUnlock", {main="starter", target="reacter"})

	addAction("give_key", "Отдать ключ", "Просто отдай им ключ...", "help", 0.5, 60, {})
	addAction("sex_challenge", "Секс-челлендж", "Отдать ключ... но только если они станут твоей секс-игрушкой и удовлетворят тебя", "sexDom", 3.0, 60, {})
	addAction("deny", "Отказать", "Отказать в просьбе!", "fight", 1.0, 60, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "give_key"):
		setState("gave_key", "reacter")
		var _howMany = getRoleChar("starter").unlockAllKeyholderLocksFrom(getRoleID("reacter"))
		getRolePawn("reacter").satisfySocial()
		getRolePawn("starter").satisfySocial()
	if(_id == "sex_challenge"):
		setState("sex_challenge_start", "starter")
	if(_id == "deny"):
		setState("denied_request", "starter")
		affectAffection("starter", "reacter", -0.05)
		getRolePawn("reacter").satisfySocial()
		getRolePawn("starter").afterFailedSocialInteraction()


func denied_request_text():
	saynn("{reacter.name} на секунду задумывается... а затем качает {reacter.his} головой.")
	sayLine("reacter", "AskKeyDeny", {main="reacter", target="starter"})
	saynn("Похоже, {starter.you} {starter.youAre} не получит этот ключ от {reacter.him}... по-хорошему.")

	addAction("leave", "Уйти", "Ну ладно... как хочешь...", "surrender", 1.0, 60, {})
	addAction("attack", "Атаковать", "Ты получишь этот ключ любым способом!", "fight", 1.0, 60, {})

func denied_request_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		setState("denied_leave", "starter")
	if(_id == "attack"):
		affectAffection("reacter", "starter", -0.1)
		startInteraction("GenericAttack", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})


func denied_leave_text():
	saynn("{starter.name} решает просто уйти... и остаться запертым...")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func denied_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func gave_key_text():
	saynn("{reacter.name} на секунду задумывается...")
	sayLine("reacter", "AskKeyGive", {main="reacter", target="starter"})
	saynn("{reacter.YouHe} {reacter.youHeVerb('approach', 'approaches')} {starter.you} и {reacter.youHeVerb('unlock')} умный замок на снаряжении с помощью {reacter.yourHis} уникального ключа...")
	saynn("Свобода...")

	addAction("leave", "Уйти", "Ура.", "default", 1.0, 60, {})

func gave_key_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func sex_challenge_start_text():
	saynn("{reacter.name} на секунду задумывается...")
	sayLine("reacter", "AskKeyChallenge", {main="reacter", target="starter"})
	saynn("Похоже, {starter.you} {starter.youArent} получит этот ключ, только если {starter.youHe} {starter.youHeVerb('let')} {reacter.you} ебаный {starter.youHim}...")

	addAction("submit", "Подчиниться", "Позволь этому случиться...", "sexSub", 1.0, 300, {start_sex=["reacter", "starter", SexType.DefaultSex, {SexMod.BondageDisabled: true}],})
	addAction("refuse", "Отказаться", "Пожалуй, лучше не надо...", "default", 0.1, 60, {})

func sex_challenge_start_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "submit"):
		var theDom:String = getRoleID("reacter")
		var _result:SexEngineResult = getSexResult(_args, true)
		if(_result.isSubUnconscious("pc")):
			var _howMany = GM.pc.unlockAllKeyholderLocksFrom(theDom)
			addMessage("Доминант решил всё равно развязать твои путы.")
		domSatisfaction = _result.getAverageDomSatisfaction() if _result else 0.0
		setState("sex_challenge_after_sex", "reacter")
	if(_id == "refuse"):
		setState("sex_challenge_refused", "starter")


func sex_challenge_after_sex_text():
	saynn("Удовлетворение {reacter.name} было..."+str(Util.roundF(domSatisfaction*100.0, 1))+"%")

	addAction("unlock_them", "Открой их", "Они тебе отлично служили.", "default", max(domSatisfaction, 0.01), 60, {})
	addAction("deny", "Отказать", "Этого было недостаточно.", "punishMean", 0.1 if domSatisfaction >= 0.89 else (1.0 - min(domSatisfaction, 0.6)), 60, {})

func sex_challenge_after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "unlock_them"):
		var _howMany = getRoleChar("starter").unlockAllKeyholderLocksFrom(getRoleID("reacter"))
		getRolePawn("reacter").satisfySocial()
		getRolePawn("starter").satisfySocial()
		setState("sex_challenge_unlock", "starter")
	if(_id == "deny"):
		affectAffection("starter", "reacter", -0.05)
		getRolePawn("reacter").satisfySocial()
		getRolePawn("starter").afterFailedSocialInteraction()
		setState("sex_challenge_denied", "starter")


func sex_challenge_unlock_text():
	saynn("{reacter.name} решает отпереть умные оковы {starter.your} с помощью уникального ключа {reacter.his}..")
	sayLine("reacter", "AskKeyChallengeUnlock", {main="reacter", target="starter"})
	saynn("Свобода, ура!")

	addAction("continue", "Продолжить", "Смотри, что будет дальше...", "default", 1.0, 60, {})

func sex_challenge_unlock_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func sex_challenge_denied_text():
	saynn("{reacter.name} качает головой, глядя на {reacter.his}.")
	sayLine("reacter", "AskKeyChallengeFail", {main="reacter", target="starter"})
	saynn("Похоже, {starter.you} {starter.youAre} не удастся освободить..")

	addAction("leave", "Уйти", "Ну, что ж..", "default", 1.0, 60, {})
	addAction("attack", "Атаковать", "Ты получишь этот ключ!", "fight", 1.0, 60, {})

func sex_challenge_denied_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
	if(_id == "attack"):
		affectAffection("reacter", "starter", -0.1)
		startInteraction("GenericAttack", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})


func sex_challenge_refused_text():
	saynn("{starter.You} {starter.youVerb('shake')} {starter.yourHis} голову.")
	sayLine("starter", "AskKeyChallengeRefuse", {main="starter", target="reacter"})
	saynn("{reacter.name} пожимает плечами.")
	sayLine("reacter", "AskKeyChallengeRefuseStay", {main="reacter", target="starter"})

	addAction("leave", "Уйти", "Ну, что ж..", "default", 1.0, 60, {})
	addAction("attack", "Атаковать", "Ты точно получишь этот ключ!", "fight", 1.0, 60, {})

func sex_challenge_refused_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
	if(_id == "attack"):
		affectAffection("reacter", "starter", -0.1)
		startInteraction("GenericAttack", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})


func getAnimData() -> Array:
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "starter"):
		return "{starter.name} просит ключ у {reacter.name}."
	if(_role == "reacter"):
		return "{starter.name} просит ключ у {reacter.name}."
	return .getPreviewLineForRole(_role)

func saveData():
	var data = .saveData()

	data["domSatisfaction"] = domSatisfaction
	return data

func loadData(_data):
	.loadData(_data)

	domSatisfaction = SAVE.loadVar(_data, "domSatisfaction", 0.0)

