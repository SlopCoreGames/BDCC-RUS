extends LustAction

func _init():
	id = "StartGropeChest"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.canStartNewActivity(LustActivity.GropingChest)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Breasts) || pc.isBodypartCovered(BodypartSlot.Breasts)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "щупать сиськи"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Начать ласкать свою грудь"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	_lustState.startActivity(LustActivity.GropingChest)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты кладешь свободную руку на свою {pc.breasts} и нежно сжимаешь одну из грудей; сосок терся между пальцами, пока ты издавала тихий стон."
		text += "\n\n"
	else:
		text += "Твоя свободная рука сама собой тянется к {pc.breasts} и сжимает одну из грудей. Ты начинаешь дышать глубже, дразня свои соски."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.canBeMilked()):
		text += "Немного {pc.milk} просачивается наружу, твоя грудь кажется налитой."
		text += "\n\n"

	return {
		text = text,
		lust = 1,
		anim = "LustBreastsSqueeze",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.3,
		InterestTopic.MasculineBody : 0.3,
		InterestTopic.AndroBody : 0.3,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.BigBreasts : 0.4,
		InterestTopic.SmallBreasts : 0.4,
		InterestTopic.MediumBreasts : 0.4,
		InterestTopic.NoBreasts : 0.4,
		InterestTopic.CoveredInCum : 0.3,
		InterestTopic.CoveredInLotsOfCum : 0.2,
		InterestTopic.FullyNaked : 0.3,
		InterestTopic.ExposedBreasts : 0.3,
		InterestTopic.ExposedBra : 0.3,
		InterestTopic.TallyMarks : 0.2,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.1,
		InterestTopic.Gags : 0.1,
	}

func isTease():
	return true

func skillNeeded():
	return 1

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
