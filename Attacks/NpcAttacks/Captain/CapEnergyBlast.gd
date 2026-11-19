extends Attack

func _init():
	id = "CapEnergyBlast"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 0.7
	
func getVisibleName(_context = {}):
	return "Энергетический залп"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} делает точный выстрел из своего лазерного пистолета {attacker.his}, попадая в {receiver.name} и причиняя нестерпимую боль."
	
	return {
		text = text,
		pain = RNG.randi_range(50, 70),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} заряжает энергию в {attacker.his} пистолете, готовясь выпустить мощный залп прямо в {receiver.name}. Этот выстрел [b]точно[/b] будет болезненным." \
	+ "\n\n"\
	+ "[say=attacker]"+RNG.pick(["Я не хочу тебя убивать. Но ты перешел черту.", "Ты зашел слишком далеко. Пора платить по счетам."])+"[/say]"

func getAttackSoloAnimation():
	return "firepistol"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.1
