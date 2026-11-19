extends InteractionGoalBase

func getScore(_pawn:CharacterPawn) -> float:
	if(!_pawn.isInmate() && !_pawn.shouldPersueGoalOverride(id)):
		return 0.0
	var hunger:float = _pawn.getHunger()
	if(hunger < 0.5):
		return 0.0
	if(hunger < 1.0):
		return 0.02 * hunger
	return 0.0 + hunger

func getKeepScore() -> float:
	var hunger:float = getPawn().getHunger()
	if(hunger < 0.5):
		return 0.0
	return getScore(getPawn()) + 0.1

func getText():
	var action = getCurrentAction()
	
	if(action == "eat"):
		return "{main.name} ест!"
	return "{main.name} проголодался! Направляется в столовую!"

func getActions() -> Array:
	if(getLocation() != "hall_canteen"):
		return [
			{
				id = "go",
				name = "Иди в столовую!",
				desc = "Что-нибудь сделать",
				score = 1.0,
				args = {},
				time = 30,
			},
		]
	
	return [
		{
			id = "eat",
			name = "Поесть!",
			desc = "Что-нибудь сделать",
			score = 1.0,
			args = {},
			time = 300,
		},
	]

func doAction(_id:String, _args:Dictionary):
	if(_id == "eat"):
		getPawn().hunger = 0.0
		getPawn().getChar().addStamina(getPawn().getChar().getMaxStamina())
		completeGoal()
	if(_id == "go"):
		goTowards("hall_canteen")

func getAnimData() -> Array:
	if(getLocation() != "hall_canteen"):
		return [StageScene.Solo, "walk", {pc="main"}]
	return [StageScene.Solo, "stand", {pc="main"}]

func getActivityIcon():
	return RoomStuff.PawnActivity.Eat
