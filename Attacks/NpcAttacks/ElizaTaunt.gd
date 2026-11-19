extends Attack

func _init():
	id = "ElizaTaunt"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Насмешка Элизы"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Мысли о том, что сказала Элиза, вызывают у вас возбуждение..."
	return {
		text = text,
		lust = 20,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} на мгновение перестает сражаться и вместо этого одаривает вас лукавой улыбкой."

	text += "\n\n"
	text += "[say=eliza]"+RNG.pick([
		"Я заставлю тебя познать такое наслаждение, какого ты еще никогда не чувствовал... Ты кончишь так много, что забудешь обо всем на свете~",
		"Вижу, это место тебе не по душе. Но я могу сделать его куда лучше — всего лишь противогаз и один особенный газ, так что просто перестань сопротивляться~",
		"Столько прототипов, которые нужно опробовать... Не лишай себя возможности получить удовольствие, подними руки~.",
		"Я могу дать тебе истинное предназначение — давать молоко, как хорошая коровка. Обещаю, это будет о-о-очень приятно~. А по утрам у меня будет кофе получше~.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LustButt"
