extends PawnInteractionBase

var foundIllegalItems = false
var throwOutLoc = ""
var guardSurrender = false

func _init():
	id = "CaughtOffLimits"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("guard", _pawns["guard"])
	doInvolvePawn("inmate", _pawns["inmate"])
	setState("", "inmate")

func shouldRunOnMeet(_pawn1, _pawn2, _pawn2Moved:bool):
	if(!_pawn1.canBeInterrupted() || !_pawn2.canBeInterrupted()):
		return [false]
		
	if(_pawn2.isStaff() && _pawn1.isInmate()):
		var pawnTemp = _pawn1
		_pawn1 = _pawn2
		_pawn2 = pawnTemp
	
	if(_pawn1.isStaff() && _pawn2.isInmate()):
		var pawnLoc = _pawn2.getLocation()
		var pawnRoom = GM.world.getRoomByID(pawnLoc)
		
		var isBadLoc = pawnRoom.isLocToCatchOfflimits()
		
		if(isBadLoc):
			return [true, {guard=_pawn1.charID, inmate=_pawn2.charID}, {}]

	return [false]

func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func init_text():
	saynn("{guard.name} замечает {inmate.name} в запретной зоне!")
	sayLine("guard", "GuardCaughtOffLimits", {guard="guard", inmate="inmate"})

	addAction("fight", "Fight!", "Protect yourself!", "fight", 1.0, 60, {})
	addAction("surrender", "Surrender", "Maybe they won't be mean", "surrender", 1.0, 60, {})
	if(getRolePawn("inmate").isPlayer()):
		GM.ES.triggerRun(Trigger.CaughtOffLimitsByDynamicNPC, [getRoleID("guard"), getRolePawn("guard").getCharType()])
	
func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "fight"):
		setState("about_to_fight", "guard")
	if(_id == "surrender"):
		setState("surrendered", "guard")


func about_to_fight_text():
	saynn("{inmate.name} готовится к драке.")
	sayLine("guard", "GuardCaughtOffLimitsFight", {guard="guard", inmate="inmate"})

	addAction("fight", "Fight", "Begin the fight", "fight", 1.0, 600, {start_fight=["inmate", "guard"],})
	addAction("surrender", "Surrender", "You changed your mind", "surrender", 1.0, 30, {})

func about_to_fight_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "fight"):
		var fightResult = getFightResult(_args)
		
		if(fightResult["won"]):
			setState("inmate_won", "inmate")
			sendSocialEvent("inmate", "guard", SocialEventType.LostFight)
		else:
			setState("guard_won", "guard")
			sendSocialEvent("guard", "inmate", SocialEventType.LostFight)
	if(_id == "surrender"):
		setState("inmate_won", "inmate")
		guardSurrender = true


func surrendered_text():
	saynn("{inmate.name} поднимает {inmate.his} руки и сдается.")
	sayLine("guard", "GuardInmateSurrender", {guard="guard", inmate="inmate"})
	saynn("{guard.name} подходит к {inmate.you}.")

	addAction("punish", "Punish", "They gotta serve a punishment!", "punishMean", 1.0, 60, {})
	addAction("frisk", "Frisk", "Go easy on them and just frisk them", "punish", 1.0, 30, {})

func surrendered_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(getCharByRole("inmate").isPlayer() && GM.ES.triggerReact(Trigger.LostOrSurrenderedToDynamicNPC, [getRoleID("guard"), getCharByRole("guard").getCharType(), true])):
		stopMe()
		return
	
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("guard"), target=getRoleID("inmate")})
	if(_id == "frisk"):
		if(getRolePawn("guard").isGuard()):
			setState("about_to_frisk", "inmate")
		else:
			startEscortOut()


func inmate_won_text():
	if(!guardSurrender):
		saynn("{guard.name} падает на пол. {inmate.name} победила!")
		sayLine("guard", "FightLostGeneric", {winner="inmate", loser="guard"})
	else:
		saynn("{guard.name} в последнюю секунду меняет {guard.his} мнение и решает сдаться!")

	addAction("leave", "Leave", "Just leave while you can", "justleave", 1.0, 30, {})
	addAction("punish", "Punish", "Find a way to punish them", "punishMean", 1.0, 30, {})

	addDefeatButtons("inmate", "guard")

func inmate_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		setState("about_to_leave", "inmate")
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("inmate"), target=getRoleID("guard")})


func about_to_leave_text():
	saynn("{inmate.name} решает просто свалить, пока {inmate.he} еще может.")

	addAction("leave", "Continue", "See what happens next.", "default", 1.0, 30, {})

func about_to_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		makeRoleExhausted("guard")
		stopMe()


func guard_won_text():
	saynn("{inmate.name} падает на пол. {guard.name} победила!")
	sayLine("guard", "FightWonGeneric", {winner="guard", loser="inmate"})

	addAction("punish", "Punish", "They gotta serve a punishment!", "punishMean", 1.0, 60, {})
	addAction("frisk", "Frisk", "Search them and let them go", "punish", 1.0, 30, {})

	addDefeatButtons("guard", "inmate")

func guard_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(getCharByRole("inmate").isPlayer() && GM.ES.triggerReact(Trigger.LostOrSurrenderedToDynamicNPC, [getRoleID("guard"), getCharByRole("guard").getCharType(), false])):
		stopMe()
		return
	
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("guard"), target=getRoleID("inmate")})
	if(_id == "frisk"):
		if(getRolePawn("guard").isGuard()):
			setState("about_to_frisk", "inmate")
		else:
			startEscortOut()


func about_to_frisk_text():
	saynn("{guard.name} собирается обыскать {inmate.name}.")
	sayLine("guard", "GuardFrisk", {guard="guard", inmate="inmate"})

	addAction("frisk", "Stay still", "Stay still and let them frisk you", "default", 1.0, 120, {})
	addAction("resist", "Resist", "Try to avoid being frisked", "resist", 1.0, 120, {})

func about_to_frisk_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "frisk"):
		var theChar = getRolePawn("inmate").getChar()
		foundIllegalItems = false
		
		if(theChar.isPlayer()):
			if(theChar.hasIllegalItems()):
				theChar.addCredits(-5)
				addMessage("5 credits were taken from you")
				foundIllegalItems = true
				theChar.getInventory().removeItemsList(theChar.getInventory().getItemsWithTag(ItemTag.Illegal))
				theChar.getInventory().removeEquippedItemsList(theChar.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		else:
			foundIllegalItems = RNG.chance(50)
		setState("frisked", "guard")
	if(_id == "resist"):
		if(doDexterityCheck("inmate", "guard")):
			foundIllegalItems = false
			setState("frisked", "guard")
			if(getRolePawn("inmate").isPlayer()):
				addMessage("You managed to avoid the search!")
		else:
			setState("frisk_failed_resist", "guard")


func frisked_text():
	if(foundIllegalItems):
		saynn("{guard.name} отбирает у {inmate.name} весь контрабандный товар, да еще и 5 кредитов сверху!")
		sayLine("guard", "GuardFriskFound", {guard="guard", inmate="inmate"})
	else:
		saynn("{guard.name} не находит никакого контрабанды.")
		sayLine("guard", "GuardFriskNoFound", {guard="guard", inmate="inmate"})

	addAction("escort_out", "Escort out", "Time to make them go", "default", 1.0, 30, {})

func frisked_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "escort_out"):
		startEscortOut()


func escorting_out_text():
	saynn("{guard.name} выводит {inmate.name} из запретной зоны.")
	if(RNG.chance(20)):
		sayLine("guard", "GuardKeepMoving", {guard="guard", inmate="inmate"})

	addAction("escort_out", "Escort out", "Go to the spot", "default", 1.0, 60, {})

func escorting_out_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "escort_out"):
		goTowards(throwOutLoc)
		if(getLocation() == throwOutLoc):
			setState("escorted_out", "guard")


func escorted_out_text():
	saynn("{guard.name} отталкивает {inmate.name}.")
	sayLine("guard", "GuardGoAway", {guard="guard", inmate="inmate"})

	addAction("leave", "Leave", "Time to go", "default", 1.0, 30, {})

func escorted_out_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func frisk_failed_resist_text():
	saynn("{inmate.name} удается избежать обыска!")
	sayLine("guard", "GuardFriskFailResist", {guard="guard", inmate="inmate"})
	saynn("Похоже, охранник не в духе.")

	addAction("punish", "Punish", "Punish them!", "default", 1.0, 60, {})

func frisk_failed_resist_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("guard"), target=getRoleID("inmate")})


func getAnimData() -> Array:
	if(getCurrentAction() == "fight"):
		return [StageScene.Duo, "shove", {pc="inmate", npc="guard", npcAction="hurt"}]
	if(getState() == "escorted_out"):
		return [StageScene.Duo, "hurt", {pc="inmate", npc="guard", npcAction="shove"}]
	if(getState() == "escorting_out"):
		return [StageScene.Duo, "walk", {pc="inmate", npc="guard", npcAction="walk", flipNPC=true}]
	if(getState() in ["about_to_frisk"]):
		return [StageScene.Search, RNG.pick(["search", "stand"]), {pc="inmate", npc="guard"}]
	if(getState() in ["frisk_failed", "frisked"]):
		return [StageScene.Search, RNG.pick(["idle", "standidle"]), {pc="inmate", npc="guard"}]
	return [StageScene.Duo, "stand", {pc="inmate", npc="guard"}]

func startEscortOut():
	if(GM.world.isLocSafe(getLocation())):
		setState("escorted_out", "guard")
		return
	throwOutLoc = GM.world.getSafeLoc(getLocation())
	goTowards(throwOutLoc)
	setState("escorting_out", "guard")

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "guard"):
		return "{guard.name} has caught {inmate.name} off-limits and is dealing with {inmate.him}."
	if(_role == "inmate"):
		return "{inmate.name} was found by {guard.name}."
	return .getPreviewLineForRole(_role)

func saveData():
	var data = .saveData()

	data["foundIllegalItems"] = foundIllegalItems
	data["throwOutLoc"] = throwOutLoc
	data["guardSurrender"] = guardSurrender
	return data

func loadData(_data):
	.loadData(_data)

	foundIllegalItems = SAVE.loadVar(_data, "foundIllegalItems", false)
	throwOutLoc = SAVE.loadVar(_data, "throwOutLoc", "")
	guardSurrender = SAVE.loadVar(_data, "guardSurrender", false)

