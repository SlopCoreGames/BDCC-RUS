extends Attack

func _init():
	id = "SentinelHeatGrenade"
	category = Category.Lust
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.8
	
func getVisibleName(_context = {}):
	return "Тепловая граната"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Lust)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Lust)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "Ты вдыхаешь розовый туман и чувствуешь, как тебя накрывает дикое возбуждение, в голове роятся грязные мысли. Может, сдаться — это не такая уж плохая идея..."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick(["Цель поражена.", "Атака прошла успешно.", "Взломщик почти готов.", "Урон похоти успешно нанесен."])+"[/say]"
	return {
		text = text,
		lust = RNG.randi_range(30, 80),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} выхватывает одну из прототипных гранат прямо из грудной полости {attacker.his}! {attacker.He} бросает её в твою сторону. Ты видишь, как в воздухе за ней тянется [b]густой розовый дымный[/b] шлейф!"

func getAttackSoloAnimation():
	return "throw"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
