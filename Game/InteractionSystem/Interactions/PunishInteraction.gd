extends PawnInteractionBase

func _init():
	id = "PunishInteraction"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("punisher", _pawns["punisher"])
	doInvolvePawn("target", _pawns["target"])
	setState("", "punisher")

func init_text():
	saynn("{punisher.name} нависает над {target.you}.")
	sayLine("punisher", "PunishDecide", {punisher="punisher", target="target"})
	
	var punisherRestraintsPreventPulling:bool = getRoleChar("punisher").hasBlockedHands() || getRoleChar("punisher").hasBoundArms()

	if(!punisherRestraintsPreventPulling && getRoleChar("target").getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving) && canGetToStocks()):
		addAction("stocks", "Колодки", "Запереть их в колодки!", "punishMean", 0.2 * getStocksScoreMult(), 60, {})
	elif(punisherRestraintsPreventPulling):
		addDisabledAction("Колодки", "Так нельзя, когда руки в кандалах...")
	else:
		addDisabledAction("Колодки", ""+("Для этого на них должен быть ошейник!" if canGetToStocks() else "Колодки слишком далеко...")+"")
	if(!punisherRestraintsPreventPulling && getRolePawn("punisher").isInmate() && getRoleChar("target").getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving) && canGetToSlutwall() && getRolePawn("target").isInmate()):
		addAction("slutwall", "Стенка для шлюх", "Загнать их в стену для шлюх!", "punishMean", 0.2 * getSlutwallScoreMult(), 60, {})
	elif(punisherRestraintsPreventPulling):
		addDisabledAction("Стенка для шлюх", "Так нельзя, когда руки в кандалах...")
	else:
		addDisabledAction("Стенка для шлюх", ""+(("Для этого на них должен быть ошейник!" if !getRoleChar("target").getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving) else "Они не из числа заключенных...") if canGetToSlutwall() else "Нельзя добраться до стены для шлюх...")+"")
	if(roleCanStartSex("punisher")):
		addAction("sex", "Секс", "Просто развлекись с ними!", "sexDom", 1.0, 60, {})
	else:
		addDisabledAction("Секс", "В своих кандалах ты их не оттрахаешь...")
	if(roleCanStartSex("target")):
		addAction("sexsub", "Подчиниться", "Дай им трахнуть тебя", "sexSub", 1.0, 60, {})
	else:
		addDisabledAction("Подчиниться", "В своих кандалах они тебя не оттрахают...")
	if(getRoleChar("punisher").isPlayer()):
		var elizaModule = GlobalRegistry.getModule("ElizaModule")
		if(elizaModule && elizaModule.hasAccessToTentacles()):
			if(!punisherRestraintsPreventPulling && getRoleChar("target").getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving) && canGetToStocks()):
				addAction("tentacles", "Тентакли", "Подставить их под щупальца в своей камере", "default", 0.0, 60, {})
			elif(punisherRestraintsPreventPulling):
				addDisabledAction("Тентакли", "Так нельзя, когда руки в кандалах...")
			else:
				addDisabledAction("Тентакли", ""+("Для этого на них должен быть ошейник!" if canGetToStocks() else "Твоя камера слишком далеко...")+"")
	addAction("leave", "Уйти", "Просто уйти", "justleave", 1.0, 30, {})

	addDefeatButtons("punisher", "target")

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		setState("about_to_stocks", "punisher")
		#sendSocialEvent("punisher", "target", SocialEventType.PunishStocks)
	if(_id == "tentacles"):
		setState("about_to_tentacles", "punisher")
	if(_id == "slutwall"):
		setState("about_to_slutwall", "punisher")
		#sendSocialEvent("punisher", "target", SocialEventType.PunishSlutwall)
	if(_id == "sex"):
		setState("about_to_sex", "punisher")
		sendSocialEvent("punisher", "target", SocialEventType.PunishSex)
	if(_id == "sexsub"):
		setState("about_to_subsex", "punisher")
	if(_id == "leave"):
		setState("just_leaving", "punisher")


func about_to_tentacles_text():
	saynn("{punisher.name} пристегивает поводок к ошейнику {target.your}.")
	addAction("cell", "Сопровождать", "Вести их к своей камере", "default", 1.0, 60, {})

func about_to_tentacles_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "cell"):
		setState("pulling_to_cell_tentacles", "punisher")
		goTowards(GM.pc.getCellLocation())

func pulling_to_cell_tentacles_text():
	saynn("{punisher.name} тащит {target.name} к камере {punisher.his}!")
	addAction("cell", "Сопровождать", "Тянуть их к своей камере", "default", 1.0, 60, {})

func pulling_to_cell_tentacles_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "cell"):
		goTowards(GM.pc.getCellLocation())
		if(getLocation() == GM.pc.getCellLocation()):
			var theTargetID:String = getRoleID("target")
			runScene("PSPCTentaclesPunish", [theTargetID])
			startInteraction("InScene", {main=theTargetID})
			stopMe()
			#setState("about_to_lock_stocks", "punisher")

func about_to_stocks_text():
	saynn("{punisher.name} пристегивает поводок к ошейнику {target.your}.")
	sayLine("punisher", "PunishDecideStocks", {punisher="punisher", target="target"})

	addAction("stocks", "Сопровождать", "Вести их к колодкам", "default", 1.0, 60, {})

func about_to_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		setState("pulling_to_stocks", "punisher")
		goTowards("main_punishment_spot")


func about_to_sex_text():
	saynn("{punisher.name} хватает {target.you}...")
	sayLine("punisher", "PunishSex", {punisher="punisher", target="target"})

	addAction("sex", "Секс", "Начать секс", "default", 1.0, 300, {start_sex=["punisher", "target"],})

func about_to_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "punisher")


func about_to_subsex_text():
	saynn("{punisher.name} подчиняется {target.you}...")
	sayLine("punisher", "PunishSubSex", {punisher="punisher", target="target"})

	addAction("sex", "Секс", "Начать секс", "default", 1.0, 300, {start_sex=["target", "punisher"],})

func about_to_subsex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "punisher")


func pulling_to_stocks_text():
	saynn("{punisher.name} тащит {target.name} к платформе для наказаний!")

	addAction("stocks", "Сопровождать", "Потянуть их к колодкам", "default", 1.0, 60, {})

func pulling_to_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		goTowards("main_punishment_spot")
		if(getLocation() == "main_punishment_spot"):
			setState("about_to_lock_stocks", "punisher")


func about_to_lock_stocks_text():
	saynn("{punisher.name} ведет {target.name} к колодкам.")
	sayLine("punisher", "PunishAboutToStocks", {punisher="punisher", target="target"})

	addAction("lock_them", "Запереть их", "Загнать их в колодки", "default", 1.0, 120, {})

func about_to_lock_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "lock_them"):
		affectAffection("target", "punisher", -0.1)
		addRepScore("target", RepStat.Alpha, -3.0)
		sendSocialEvent("punisher", "target", SocialEventType.PunishStocks)
		setState("in_stocks", "punisher")


func in_stocks_text():
	saynn("{punisher.name} зажимает {target.name} в колодках!")
	sayLine("punisher", "PunishLockIntoStocks", {punisher="punisher", target="target"})

	addAction("leave", "Уйти", "Оставить их в покое", "default", 1.0, 30, {})

func in_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		startInteraction("InStocks", {inmate=getRoleID("target")}, {punisherID=getRoleID("punisher")})


func after_sex_text():
	saynn("После секса {punisher.name} оставляет {target.you} в покое...")

	addAction("leave", "Уйти", "Пора идти", "default", 1.0, 30, {})

func after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func just_leaving_text():
	saynn("{punisher.name} решает просто оставить {target.name} в покое..")

	addAction("leave", "Уйти", "Пора идти", "default", 1.0, 30, {})

func just_leaving_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func about_to_slutwall_text():
	saynn("{punisher.name} пристегивает поводок к ошейнику {target.your}.")
	sayLine("punisher", "PunishDecidedSlutwall", {punisher="punisher", target="target"})

	addAction("escort", "Сопровождать", "Повести их к шлюзовой стене", "default", 1.0, 60, {})

func about_to_slutwall_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "escort"):
		setState("pulling_to_slutwall", "punisher")
		goTowards("fight_slutwall")


func pulling_to_slutwall_text():
	saynn("{punisher.name} тащит {target.name} к шлюх-стене!")

	addAction("escort", "Сопровождать", "Потянуть их к шлюзовой стене", "default", 1.0, 60, {})

func pulling_to_slutwall_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "escort"):
		goTowards("fight_slutwall")
		if(getLocation() == "fight_slutwall"):
			setState("about_to_lock_slutwall", "punisher")


func about_to_lock_slutwall_text():
	saynn("{punisher.name} зажимает {target.name} в шлюх-стене.")

	addAction("lock_them", "Запереть их", "Загнать их в шлюзовую стену", "default", 1.0, 120, {})

func about_to_lock_slutwall_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "lock_them"):
		affectAffection("target", "punisher", -0.1)
		addRepScore("target", RepStat.Alpha, -3.0)
		sendSocialEvent("punisher", "target", SocialEventType.PunishSlutwall)
		setState("in_slutwall", "punisher")


func in_slutwall_text():
	saynn("{punisher.name} зажимает {target.name} в шлюх-стене!")
	sayLine("punisher", "PunishLockIntoSlutwall", {punisher="punisher", target="target"})

	addAction("leave", "Уйти", "Оставить их в покое", "default", 1.0, 30, {})

func in_slutwall_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		startInteraction("InSlutwall", {inmate=getRoleID("target")}, {punisherID=getRoleID("punisher")})


func getAnimData() -> Array:
	if(getState() == "about_to_sex"):
		return [StageScene.SexStart, "start", {pc="punisher", npc="target"}]
	if(getState() == "in_slutwall"):
		return [StageScene.SlutwallSex, "tease", {pc="target", npc="punisher"}]
	if(getState() == "in_stocks"):
		return [StageScene.StocksSexOral, "tease", {npc="punisher", pc="target"}]
	if(getState() in ["pulling_to_stocks", "pulling_to_slutwall", "pulling_to_cell_tentacles"]):
		if(getLocation() != "main_punishment_spot" && getLocation() != "fight_slutwall"):
			return [StageScene.Duo, "walk", {pc="target", npc="punisher", npcAction="walk", flipNPC=true, bodyState={leashedBy="punisher"}}]
	if(getState() in [""]):
		return [StageScene.SexStart, "start", {pc="punisher", npc="target"}]
	
	return [StageScene.Duo, "stand", {pc="target", npc="punisher"}]

func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "target"):
		return "{punisher.name} наказывает {target.name}."
	if(_role == "punisher"):
		return "{punisher.name} наказывает {target.name}."
	return .getPreviewLineForRole(_role)

func isRoleOnALeash(_role:String) -> bool:
	if(_role == "target" && getState() in ["pulling_to_stocks", "pulling_to_slutwall", "pulling_to_cell_tentacles"]):
		return true
	return false
	
func isRoleLeashing(_role:String) -> bool:
	if(_role == "punisher" && getState() in ["pulling_to_stocks", "pulling_to_slutwall", "pulling_to_cell_tentacles"]):
		return true
	return false

