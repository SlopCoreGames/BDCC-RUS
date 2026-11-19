extends LustAction

func _init():
	id = "TeaseCock"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(_lustState.isDoingActivity(LustActivity.StrokingCock)):
		return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Penis) || !pc.isBodypartCovered(BodypartSlot.Penis)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Ласкать член"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Потеребить член через одежду"

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)
	var pc:Player = _lustState.getCharacter()
	
	var cantCum = false
	
	var text = ""
	if(pc.isWearingChastityCage()):
		cantCum = true
		if(RNG.chance(50)):
			text += "Ты опускаешь руку к паху и слегка растираешь свой {pc.cock} через ткань. Пальцы находят самое приятное место и сосредотачиваются на нем. Проклятая клетка мешает нормально ласкать его."
			text += "\n\n"
		else:
			text += "Ты ощупываешь свой прикрытый {pc.cock} и слегка поглаживаешь клетку через одежду. Жаль, что это почти не дает стимуляции. Тем не менее, после таких ласк ты чувствуешь, как из члена начинает сочиться смазка."
			text += "\n\n"
	else:
		if(RNG.chance(50)):
			text += "Ты опускаешь руку к паху и слегка растираешь свой {pc.cock} через ткань. Пальцы находят чувствительную головку и концентрируются на ней, отчего твоя одежда начинает сильнее выпирать."
			text += "\n\n"
		else:
			text += "Ты ощупываешь свой прикрытый {pc.cock} и слегка поглаживаешь его через одежду. По мере того как ты ласкаешь себя, контур ствола становится всё отчетливее, и из него уже сочится смазка."
			text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Пока ты трешь себя, ты выставляешь свой бугорок напоказ перед врагом. Ты ухмыляешься, надеясь, что им нравится это шоу."
		text += "\n\n"
	
	if(RNG.chance(20) && pc.hasEffect(StatusEffect.CoveredInCum)):
		text += "Столько спермы на твоем теле... Ты зачерпываешь немного пальцами и используешь её как смазку — не хочется переводить драгоценную жижу."
		text += "\n\n"
	
	if(RNG.chance(30) && pc.getLust() >= 50):
		text += "Твой член такой влажный, что ты чувствуешь его легкое подергивание, когда смазка течет всё сильнее, оставляя темные пятна на твоей одежде."
		text += "\n\n"
	
	if(RNG.chance(20) && pc.hasVagina()):
		text += "Пока ты дразнишь свой член, твоя щелка становится всё более жадной и влажной; ты чувствуешь, как ткань впивается в неё, когда ты трешь промежность. Стоны невозможно скрыть."
		text += "\n\n"
	
	if(RNG.chance(50)):
		if(pc.isWearingChastityCage()):
			text += RNG.pick([
				"[say=pc]Хафф.. Тупая клетка..[/say]",
				"[say=pc]Блядь, как же хочется потеребить свой член..[/say]",
				"[say=pc]Кто угодно может увидеть меня в таком виде..[/say]",
				"[say=pc]Ох, блядь..[/say]",
			])
		else:
			text += RNG.pick([
				"[say=pc]Да, черт возьми..[/say]",
				"[say=pc]Блядь, как же охеренно ласкать свой член..[/say]",
				"[say=pc]Кто угодно может увидеть меня в таком виде..[/say]",
				"[say=pc]Ох, блядь..[/say]",
			])
		text += "\n\n"
		if(_lustState.isInPublic() && !_lustState.isInBattle()):
			text += "Ты надеешься, что никто этого не услышал... Пытаешься держать рот на замке."
			text += "\n\n"

	return {
		text = text,
		lust = 1,
		cantCum = cantCum,
		anim = "LustStrokeAttack",
	}

func getLustTopics():
	return {
		InterestTopic.HasVaginaAndCock : 0.2,
		InterestTopic.BigCock : 1.0,
		InterestTopic.AverageCock : 1.0,
		InterestTopic.SmallCock : 1.0,
		InterestTopic.NoCock : 1.0,
		InterestTopic.HasCockOnly : 0.2,
		InterestTopic.FullyNaked : 0.4,
		InterestTopic.ExposedCock : 0.4,
		InterestTopic.ExposedPanties : 0.4,
		InterestTopic.BDSMRestraints : 0.2,
	}

func getPriority():
	return 4

func isTease():
	return true

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
