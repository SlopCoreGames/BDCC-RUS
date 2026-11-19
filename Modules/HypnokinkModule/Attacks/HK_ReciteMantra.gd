extends Attack

func _init():
	id = "ReciteMantra"
	category = Category.Special
	aiCategory = AICategory.Unspecified
	
func getVisibleName(_context = {}):
	return "Читать мантру"
	
func getVisibleDesc(_context = {}):
	var amount = HypnokinkUtil.getSuggestibleStacks(GM.pc) / 2
	return "Произнести короткую мантру, чтобы восстановить "+str(round(amount * 0.65))+" to "+str(round(amount))+" выносливость. Количество зависит от текущей степени гипноза."
	
func _doAttack(_attacker, _receiver, _context = {}):
	var texts = [
		"{attacker.name} произносит короткую, расслабляющую мантру.",
		"{attacker.name} бормочет короткую, расслабляющую мантру.",
		"{attacker.name} шепчет короткую, расслабляющую мантру.",
	]
	var text = RNG.pick(texts)
	
	var amount = HypnokinkUtil.getSuggestibleStacks(_attacker) / 2
	amount = RNG.randi_range(amount * 0.65, amount)
	
	text += "\n[b]{attacker.name} бодрится! (+"+str(amount)+" stamina)[/b]"
		
	_attacker.addStamina(amount)
	_attacker.addEffect(StatusEffect.MantraUsed)
	
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return !_attacker.hasEffect(StatusEffect.MantraUsed)

func getRequirements():
	return [AttackRequirement.CanTalk]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} closes {attacker.his} eyes."

#func getAttackSoloAnimation():
#	return "shove"

func getExperience():
	return [[Skill.Hypnosis, 5]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.0
