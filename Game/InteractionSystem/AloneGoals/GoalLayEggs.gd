extends InteractionGoalBase

var announced:bool = false

func getScore(_pawn:CharacterPawn) -> float:
	if(_pawn.getChar().isReadyToLayEggs()):
		if(_pawn.isSlaveToPlayer()):
			return 0.0
		return 1.0
	return 0.0

func getKeepScore() -> float:
	if(getPawn().getChar().isReadyToLayEggs()):
		return 1.1
	return 0.0

func getText():
	return "{main.name} откладывает яйца..."

func getActions() -> Array:
	if(!announced):
		return [
			{
				id = "announce",
				name = "Отложи яйца!",
				desc = "Что-нибудь сделать",
				score = 1.0,
				args = {},
				time = 30,
			},
		]
	
	return [
		{
			id = "giveBirth",
			name = "Отложи яйца!",
			desc = "Что-нибудь сделать",
			score = 1.0,
			args = {},
			time = 7200, # 2 hours
		},
	]

func doAction(_id:String, _args:Dictionary):
	if(_id == "announce"):
		announced = true
		GM.main.addLogMessage("News", "Ты только что получил известие, что "+getPawn().getChar().getName()+" начала где-то откладывать яйца. Ты можешь найти их и помочь, если захочешь.")
	if(_id == "giveBirth"):
		getPawn().getChar().layEggsByNPCWithNotificationIfNeeded()
		completeGoal()

func getAnimData() -> Array:
	return [StageScene.EggLaying, "idle", {pc="main", bodyState={naked=true}}]

func getActivityIcon():
	return RoomStuff.PawnActivity.LayEggs

func saveData():
	var data = .saveData()
	
	data["aa"] = announced
	return data

func loadData(_data):
	.loadData(_data)
	
	announced = SAVE.loadVar(_data, "aa", false)
