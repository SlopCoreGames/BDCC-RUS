extends LustAction

func _init():
	id = "ButtSpankSelf"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.GropingButt)):
		return false
	#var pc:Player = _lustState.getCharacter()
	#if(!pc.hasBodypart(BodypartSlot.Vagina) || pc.isBodypartCovered(BodypartSlot.Vagina)):
	#	return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "шлепнуть по заднице"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Заставить свою задницу подпрыгивать"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты с силой шлепаешь свою {pc.thick} задницу, заставляя её колыхаться! Ох, ты издаешь похотливый звук, а твоя попка слегка краснеет."
		text += "\n\n"
	else:
		text += "Ты ласкаешь свою милую попку, а затем со всей силы хлопаешь по ней, заставляя её подпрыгивать. Ты издаешь стон и поглаживаешь место удара, чтобы оно не так сильно жгло."
		text += "\n\n"
	
	if(RNG.chance(40) && (pc.hasEffect(StatusEffect.HasCumInsideVagina) || pc.hasEffect(StatusEffect.HasCumInsideAnus))):
		text += "И пока ты шлепаешь себя, из твоего использованного отверстия вытекает всё больше спермы, она стекает по твоим бедрам, создавая настоящий беспорядок."
		text += "\n\n"
	
	if(_lustState.isInBattle()):
		text += "Ты позаботилась о том, чтобы продемонстрировать, как твоя задница колышется после твоих шлепков."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты тихонько дышишь и снова шлепаешь себя по заднице. Хафф, кажется, от этого можно даже кончить."
		text += "\n\n"

	return {
		text = text,
		lust = 1,
		pain = 3,
		anim = "LustButt",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.4,
		InterestTopic.MasculineBody : 0.4,
		InterestTopic.AndroBody : 0.4,
		InterestTopic.ThickButt : 0.7,
		InterestTopic.AverageButt : 0.7,
		InterestTopic.SlimButt : 0.7,
		InterestTopic.FullyNaked : 0.8,
		InterestTopic.ExposedPussy : 0.8,
		InterestTopic.ExposedAnus : 0.8,
		InterestTopic.ExposedCock : 0.8,
		InterestTopic.ExposedPanties : 0.3,
		InterestTopic.LooseAnus : 0.1,
		InterestTopic.LoosePussy : 0.1,
		InterestTopic.TightAnus : 0.1,
		InterestTopic.TightPussy : 0.1,
		InterestTopic.TallyMarks : 0.3,
		InterestTopic.Bodywritings : 0.3,
		InterestTopic.BDSMRestraints : 0.4,
		InterestTopic.ButtPlugs : 0.1,
		InterestTopic.VaginalPlugs : 0.1,
	}

func getPriority():
	return 5

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
