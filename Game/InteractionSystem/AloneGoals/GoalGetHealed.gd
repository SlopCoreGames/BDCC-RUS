extends InteractionGoalBase

func getScore(_pawn:CharacterPawn) -> float:
	var theChar:BaseCharacter = _pawn.getChar()
	var theScore:float = 0.0
	if(theChar.hasEffect(StatusEffect.Wounded)):
		theScore += 0.03
	if(theChar.hasEffect(StatusEffect.StretchedPainfullyAnus)):
		theScore += 0.03
	if(theChar.hasEffect(StatusEffect.StretchedPainfullyPussy)):
		theScore += 0.03
	return theScore

func getKeepScore() -> float:
	return 0.7

func getText():
	if(getLocation() == "med_lobbymain"):
		return "{main.name} лечится!"
	return "{main.name} направляется в медблок!"

func getActions() -> Array:
	if(getLocation() == "med_lobbymain"):
		return [
			{
				id = "getHealed",
				name = "Исцеление завершено!",
				desc = "Что-нибудь сделать",
				score = 1.0,
				args = {},
				time = 300,
			},
		]
	return [
		{
			id = "go",
			name = "Вперёд!",
			desc = "Что-нибудь сделать",
			score = 1.0,
			args = {},
			time = 60,
		},
	]

func doAction(_id:String, _args:Dictionary):
	if(_id == "go"):
		goTowards("med_lobbymain")
	if(_id == "getHealed"):
		getPawn().getChar().removeEffect(StatusEffect.Wounded)
		getPawn().getChar().removeEffect(StatusEffect.StretchedPainfullyAnus)
		getPawn().getChar().removeEffect(StatusEffect.StretchedPainfullyPussy)
		completeGoal()

func getAnimData() -> Array:
	return [StageScene.Solo, "walk", {pc="main"}]

func getActivityIcon():
	return RoomStuff.PawnActivity.Help
