extends Attack

func _init():
	id = "ForceMuzzlePC"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.4
	
func getVisibleName(_context = {}):
	return "Силовой прихват"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("basketmuzzle"), _attacker)
	
	var text = "{attacker.name} набрасывается на тебя и умудряется [b]зажать тебе рот[/b]! Ты отталкиваешь {attacker.him} назад.\n\n[say=attacker]"+RNG.pick([
		"Так гораздо лучше.",
		"Скушай это.",
		"Веди себя прилично, зэк.",
		"Что такое, язык проглотила?",
	])+"[/say]"
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return _receiver.isPlayer() && !_receiver.isBitingBlocked()

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} делает шаг назад и достает из одного из {attacker.his} карманов проволочную корзину-намордник. {attacker.name} вертит ее в {attacker.his} руках.\n\n[say=attacker]"+RNG.pick([
		"У тебя есть право оставаться с кляпом во рту.",
		"Спорим, у тебя уже слюнки текут?",
		"Да ладно, мы же обе знаем, что ты этого хочешь.",
		"Пора заставить оппозицию замолчать.",
	])+"[/say]"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "RestraintFace"
