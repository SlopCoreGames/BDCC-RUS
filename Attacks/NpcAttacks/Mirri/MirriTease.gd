extends Attack

func _init():
	id = "MirriTease"
	category = Category.Lust
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Подразнить"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "От задов {attacker.name} у тебя встает."
	
	return {
		text = text,
		lust = 30,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_receiver.isBlindfolded()):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} соблазнительно наклоняется, демонстрируя свои полосатые трусики."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Ты ведь на самом деле не хочешь со мной драться, верно?",
		"Тебе нравится моя задница?",
		"Разве моя попка не милашка?",
		"Ты и правда хочешь причинить мне боль?",
		"Я кошечка... Мяу-мяу-мяу..."
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]
	

#func getAttackSoloAnimation():
#	return ["firepistol", "res://Inventory/UnriggedModels/Pistol/Pistol.tscn"]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func getAttackSoloAnimation():
	return "LustBodyAttack"
