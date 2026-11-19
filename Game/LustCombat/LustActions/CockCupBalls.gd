extends LustAction

func _init():
	id = "CockCupBalls"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isDoingActivity(LustActivity.StrokingCock)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Penis) || pc.isBodypartCovered(BodypartSlot.Penis)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Сжать яички в ладонях"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Удели внимание своим яйцам"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)

	var pc:Player = _lustState.getCharacter()
	
	var text = ""
	if(RNG.chance(50)):
		text += "Сосредоточившись на удовольствии, ты нежно сжимаешь яички, продолжая мастурбировать другой рукой. Ты издаешь приглушенный стон наслаждения и продолжаешь массировать свои яйца, пока твой {pc.cock} выделяет всё больше предэякулята."
		text += "\n\n"
	else:
		text += "Твой {pc.cock} сочится предэякулятом, пока ты обхватываешь пальцами яички и сжимаешь их."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты стараешься напоказ продемонстрировать противнику свои яйца и то, как ласкаво ты их перебираешь."
		text += "\n\n"
		
	if(RNG.chance(10) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Ты такой неряшливый: сперма твоих предыдущих любовниц стекает по твоему телу и капает с кончика твоего члена."
		text += "\n\n"
	
	if(RNG.chance(50) && pc.getLust() >= 50):
		text += "Ты чувствуешь, что финиш уже близко: твой член так и пульсирует и дергается, и каждый раз, когда ты сжимаешь свои яйца, на кончике появляется капля предэякулята, которая скользит по твоим пальцам."
		text += "\n\n"
	
	if(RNG.chance(20) && pc.hasVagina()):
		text += "Пока ты дразнишь свой член, твоя щель становится всё более жадной и влажной; ты чувствуешь, как из неё сочатся соки, пока ты фокусируешься на другом наборе своих бубенцов. Стоны невозможно скрыть."
		text += "\n\n"

	return {
		text = text,
		lust = 2,
		anim = "LustCockTaunt",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
		InterestTopic.NoVagina : 0.3,
		InterestTopic.HasVaginaAndCock : 0.3,
		InterestTopic.BigCock : 0.7,
		InterestTopic.AverageCock : 0.7,
		InterestTopic.SmallCock : 0.7,
		InterestTopic.HasCockOnly : 0.4,
		InterestTopic.StuffedPussy : 0.2,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.4,
		InterestTopic.ExposedPussy : 0.2,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
		InterestTopic.Pregnant: 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 3

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
