extends PawnInteractionBase

func _init():
	id = "NurseSave"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("nurse", _pawns["nurse"])
	doInvolvePawn("inmate", _pawns["inmate"])
	setState("", "nurse")

func init_text():
	saynn("{nurse.name} подходит и проверяет состояние {inmate.your}..")
	saynn("После этого {nurse.he} подкатывает {nurse.verb('unfold')} каталку и начинает закреплять на ней бессознательного человека..")

	addAction("medbay", "To medbay", "Time to go..", "default", 1.0, 120, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "medbay"):
		setState("moving_to_medical", "nurse")


func moving_to_medical_text():
	saynn("{nurse.name} толкает каталку с {inmate.you} на ней в сторону медицинского крыла!")

	addAction("medbay", "To medbay", "Push push push", "default", 1.0, 60, {})

func moving_to_medical_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "medbay"):
		goTowards("medical_hospitalwards")
		if(getLocation() == "medical_hospitalwards"):
			setState("in_wards", "nurse")


func in_wards_text():
	saynn("{nurse.name} укладывает {inmate.you} в одну из больничных коек для восстановления..")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 120, {})

func in_wards_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		if(getRolePawn("inmate").isPlayer()):
			setState("in_wards_pc", "inmate")
			doRemoveRole("nurse")
		else:
			var theChar = getRoleChar("inmate")
			var inpawn = getRolePawn("inmate")
			stopMe()
			inpawn.deleteMe()
			if(theChar):
				theChar.removeEffect(StatusEffect.Wounded)
				theChar.removeEffect(StatusEffect.StretchedPainfullyAnus)
				theChar.removeEffect(StatusEffect.StretchedPainfullyPussy)

func in_wards_pc_text():
	saynn("Пора отдохнуть..")

	addAction("rest", "Rest", "Try to recover..", "default", 1.0, 90, {})

func in_wards_pc_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "rest"):
		setState("in_wards_pc2", "inmate")


func in_wards_pc2_text():
	saynn("Медсестра оставляет вас, когда приходит один из врачей..")
	saynn("Они осматривают вас, а затем делают инъекцию каким-то шприцем..")
	saynn("Вы медленно приходите в себя..")

	addAction("rest", "Rest", "Try to rest..", "default", 1.0, 3600, {})

func in_wards_pc2_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "rest"):
		setState("in_wards_pc3", "inmate")
		var theChar = getRoleChar("inmate")
		theChar.addPain(-theChar.getPain())
		theChar.addStamina(theChar.getMaxStamina())
		setLocation("med_lobbyne")


func in_wards_pc3_text():
	saynn("В конце концов, вы обретаете чувство реальности..")
	saynn("Когда вы окончательно очухаетесь, медсестры отводят вас обратно в холл медпункта и отпускают..")

	addAction("go", "Go", "It's time to go..", "default", 1.0, 60, {})

func in_wards_pc3_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "go"):
		stopMe()


func getAnimData() -> Array:
	if(getState() in ["in_wards", "in_wards_pc", "in_wards_pc2", "in_wards_pc3"]):
		return [StageScene.Sleeping, "sleep", {pc="inmate"}]
	if(getState() == ""):
		return [StageScene.SexStart, "defeated", {pc="nurse", npc="inmate"}]
	return [StageScene.Solo, "jog", {pc="nurse"}]
	
func getPreviewLineForRole(_role:String) -> String:
	if(_role == "inmate"):
		return "{inmate.name} is unconscious and being transported to medical by {nurse.name}.."
	if(_role == "nurse"):
		return "{nurse.name} is pushing a stretcher with {inmate.name} to medical."
	return .getPreviewLineForRole(_role)

func getActivityIconForRole(_role:String):
	if(_role == "nurse"):
		return RoomStuff.PawnActivity.Help
	else:
		return RoomStuff.PawnActivity.Unconscious

