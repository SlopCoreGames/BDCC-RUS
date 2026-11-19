extends Attack

func _init():
	id = "ForceGagPC"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.4
	
func getVisibleName(_context = {}):
	return "Силовое кляпление"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("ballgag"), _attacker)
	
	var text = "{attacker.name} набрасывается на тебя и умудряется [b]запихнуть кляп тебе в рот[/b]! Тебе удается оттолкнуть {attacker.him} назад.\n\n[say=attacker]"+RNG.pick([
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
	return "{attacker.name} делает шаг назад и достает шариковый кляп из одного из {attacker.his} карманов. {attacker.name} вертит его в {attacker.his} руках.\n\n[say=attacker]"+RNG.pick([
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
