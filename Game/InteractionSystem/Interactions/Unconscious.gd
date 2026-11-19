extends PawnInteractionBase

var timesWaited:int = 0

func _init():
	id = "Unconscious"

func canNurseSave() -> bool:
	return getPawnAmount() == 1

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("main", _pawns["main"])
	setState("", "main")

func init_text():
	saynn("{main.You} {main.youAre} без сознания..")
	
	addAction("wait", "Подождать", "Может, хоть что-нибудь да случится...", "default", 1.0, 600, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "wait"):
		timesWaited += 1
		if(timesWaited >= 5 && getRolePawn("main").isPlayer()):
			var nurseAmount:int = GM.main.IS.getAvailableNursesAmount()
			if(nurseAmount <= 0):
				setState("no_nurses", "main")
				return
			
		setState("", "main")

func no_nurses_text():
	saynn("В голове всё покалывает..")
	saynn("Кажется, на этот раз спасать тебя уже некому..")
	
	addAction("giveup", "Сдаться?", "А что еще остается...", "default", 1.0, 60, {})

func no_nurses_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "giveup"):
		stopMe()
		runScene("ElizaBackupPCSaveScene")

func about_to_fuck_text():
	saynn("{user.name} приближается к {main.you}..")
	
	saynn("В глазах {user.his} вспыхивает зловещий блеск..")
	
	addAction("sex", "Секс", "Пора развлечься", "default", 1.0, 300, {start_sex=["user", "main", SexType.DefaultSex, {SexMod.SubsStartUnconscious: true}],})

func about_to_fuck_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "user")

func after_sex_text():
	saynn("После этого {user.name} пора было поскорее уходить..")
	
	addAction("leave", "Уйти", "Пора идти..", "default", 1.0, 60, {})

func after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		doRemoveRole("user")
		setState("", "main")

func getInterruptActions(_pawn:CharacterPawn) -> Array:
	var result:Array = []
	if(getPawnAmount() == 1 && _pawn.getChar().canStartSex()):
		result.append({
			id = "fuck",
			name = "Блядь",
			desc = "Трахнуть их, пока они в отключке",
			score = 0.5,
			scoreType = "sexUse",
			scoreRole = "main",
			args = {},
		})
	if(getPawnAmount() == 1 && !_pawn.isPlayer() && getRolePawn("main").isPlayer()):
		result.append({
			id = "grab",
			name = "Схватить",
			desc = "Придумать с ними что-нибудь интересненькое...",
			score = (0.5 if _pawn.getSocial() > 0.4 else 0.0),
			scoreType = "punishMean",
			scoreRole = "main",
			args = {},
		})
	return result

func doInterruptAction(_pawn:CharacterPawn, _id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "fuck"):
		doInvolvePawn("user", _pawn)
		setState("about_to_fuck", "user")
	if(_id == "grab"):
		if(triggerUnconsciousPCGrabEvent(_pawn)):
			stopMe()

func getAnimData() -> Array:
	if(getState() in ["about_to_fuck", "after_sex"]):
		return [StageScene.SexStart, "defeated", {pc="user", npc="main"}]
	return [StageScene.Sleeping, "sleep", {pc="main"}]

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "main"):
		return "{main.name} без сознания..."
	if(_role == "user"):
		return "{nurse.name} что-то делает с {main.name}."
	return .getPreviewLineForRole(_role)

func getActivityIconForRole(_role:String):
	if(_role == "main"):
		return RoomStuff.PawnActivity.Unconscious
	else:
		return RoomStuff.PawnActivity.Chat

func saveData():
	var data = .saveData()

	data["timesWaited"] = timesWaited
	return data

func loadData(_data):
	.loadData(_data)

	timesWaited = SAVE.loadVar(_data, "timesWaited", 0)
