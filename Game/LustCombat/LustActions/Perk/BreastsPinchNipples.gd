extends LustAction

func _init():
	id = "BreastsPinchNipples"
	hasByDefault = true
	
func shouldShow(_lustState: LustCombatState, _args):
	if(!_lustState.isInBattle()):
		return false
	#if(!_lustState.isDoingActivity(LustActivity.GropingChest)):
	#	return false
	var pc:Player = _lustState.getCharacter()
	if(!pc.hasBodypart(BodypartSlot.Breasts)):# || pc.isBodypartCovered(BodypartSlot.Breasts)):
		return false
	if(!pc.hasPerk(Perk.MilkSquirt)):
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
	if(!pc.canBeMilked()):
		return [false, "Чтобы это сделать, у тебя должна идти лактация"]
	
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Сжимать соски"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "С силой сдавите соски, заставляя их брызгать молоком и ослепляя противника. Можно делать это через одежду, но эффект будет слабее."

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(3)

	var pc:Player = _lustState.getCharacter()
	pc.stimulateLactation()
	pc.milk(0.3)
	
	var text = ""
	if(pc.isBodypartCovered(BodypartSlot.Breasts)):
		text += "Вы быстро прижимаете руки к своим {pc.breasts} и сжимаете их изо всех сил, щипая соски прямо через ткань. Это возбуждает; вы едва стоите на ногах, разминая грудь и издавая страстные стоны."
		text += "\n\n"
		
		text += "После достаточной стимуляции из ваших сосков внезапно вырывается мощная струя {pc.milk}, которая пропитывает одежду и летит прямо в противника."
		text += "\n\n"
		
		var enemy:BaseCharacter = _lustState.getEnemyCharacter()
		if(enemy != null):
			enemy.addEffect(StatusEffect.Blindness, [2])
	else:
		text += "Вы быстро прижимаете руки к своим {pc.breasts} и сжимаете их изо всех сил, щипая обнаженные соски. Это возбуждает; вы едва стоите на ногах, разминая грудь и издавая страстные стоны."
		text += "\n\n"
	
		text += "После достаточной стимуляции из ваших сосков внезапно вырывается мощная струя {pc.milk}, направленная прямо в противника."
		text += "\n\n"
		
		var enemy:BaseCharacter = _lustState.getEnemyCharacter()
		if(enemy != null):
			enemy.addEffect(StatusEffect.Blindness, [3])

	return {
		text = text,
		lust = 3,
		anim = "LustBreastsAttack",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.1,
		InterestTopic.MasculineBody : 0.1,
		InterestTopic.AndroBody : 0.1,
		InterestTopic.ThickBody : 0.1,
		InterestTopic.SlimBody : 0.1,
		InterestTopic.AverageMassBody : 0.1,
		InterestTopic.BigBreasts : 0.7,
		InterestTopic.SmallBreasts : 0.7,
		InterestTopic.MediumBreasts : 0.7,
		InterestTopic.NoBreasts : 0.7,
		InterestTopic.LactatingBreasts : 1.0,
		InterestTopic.CoveredInCum : 0.2,
		InterestTopic.CoveredInLotsOfCum : 0.1,
		InterestTopic.FullyNaked : 0.5,
		InterestTopic.ExposedBreasts : 0.5,
		InterestTopic.ExposedBra : 0.5,
		InterestTopic.Bodywritings : 0.2,
		InterestTopic.BDSMRestraints : 0.2,
	}

func getPriority():
	return 5

func skillNeeded():
	return 2

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Milking, 5]]
	return []
