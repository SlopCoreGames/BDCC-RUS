extends Attack

func _init():
	id = "TaviSeductiveWhispers"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Соблазнительный шепот"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "whispers")
	
	var text = "{attacker.name} шепчет нежные слова на ухо {receiver.name}, отчего у {receiver.his} пробегает дрожь по спине, а сама {receiver.him} чувствует возбуждение и теряет концентрацию."
	return {
		text = text,
		lust = RNG.randi_range(30, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} наклоняется ближе, и голос {attacker.his} звучит как соблазнительный шепот"

	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Позволь мне подарить тебе наслаждение, которого ты еще никогда не знал...",
		"Не нужно стесняться...",
		"Представь, какой экстаз ждет тебя, если ты отдашься мне телом и душой...",
		"Зачем сопротивляться? Расслабься, и давай вместе отдадимся этим ощущениям...",
		"Хочешь потрогать меня? Только пообещай, что будешь послушным {receiver.boy}..."
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntLustLeanIn"
