extends LustAction

func _init():
	id = "MiscLickSelfClean"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	#if(!_lustState.isDoingActivity(LustActivity.GropingChest)):
	#	return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasPerk(Perk.CumSwallower)):
		return false
	
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc:Player = _lustState.getCharacter()
	#if(!pc.hasPerk(Perk.MilkSquirt)):
	#	return [false, "Requires a \"Battle Cow\" perk"]
	
	if(pc.hasBoundArms()):
		return [false, "С заведенными за спину руками так не выйдет"]
	if(pc.hasBlockedHands()):
		return [false, "С занятыми руками так не получится"]
	if(!pc.hasEffect(StatusEffect.CoveredInCum)):
		return [false, "Чтобы это сделать, ты должна быть чем-то испачкана"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Вылизать себя дочиста"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Используй язык, чтобы очистить себя. Проглатывание различных жидкостей дает разные эффекты."

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	
	var extraMessages = []
	var fluids:Fluids = pc.getFluids()
	var fluidByAmount = fluids.getFluidAmountByType()
	for fluidID in fluidByAmount:
		var swallowData:Dictionary = pc.doSwallow(fluidID, fluidByAmount[fluidID])
		if(swallowData.has("text") && swallowData["text"] != ""):
			extraMessages.append(swallowData["text"])
	
	fluids.transferTo(pc.getBodypart(BodypartSlot.Head), 1.0)
	pc.removeEffect(StatusEffect.Bleeding)
	
	var text = ""
	if(RNG.chance(50)):
		text += "Ты высовываешь язык и начинаешь проводить им по всем доступным изгибам своего {pc.masc} тела. Затем ты собираешь остатки грязи на пальцы и слизываешь их дочиста."
		text += "\n\n"
	else:
		text += "Ты начинаешь собирать жидкости со своего тела языком, а затем с наслаждением проглатываешь всё до последней капли. Ты посасываешь каждый палец, чтобы убедиться, что они идеально чистые."
		text += "\n\n"
	
	if(RNG.chance(50) && _lustState.isInBattle()):
		text += "Ты стараешься вовсю демонстрировать, как сильно тебе нравится слизывать выделения с самой себя, не сводя при этом глаз со своего противника."
		text += "\n\n"

	text += Util.join(extraMessages, " ")+"\n\n"

	return {
		text = text,
		lust = 3,
		anim = "LickWounds",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.CoveredInCum : 1.0,
		InterestTopic.CoveredInLotsOfCum : 0.5,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedBreasts : 0.5,
		InterestTopic.ExposedCock : 0.5,
		InterestTopic.ExposedPussy : 0.5,
		InterestTopic.ExposedBra : 0.1,
		InterestTopic.ExposedPanties : 0.1,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 1]]
	return []
