extends Attack

func _init():
	id = "HypnoTriggerTiredness"
	category = Category.Special
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Триггер: Расслабление"
	
func getVisibleDesc(_context = {}):
	return "Используйте их постгипнотическое внушение, чтобы вызвать состояние спокойствия и сонливой расслабленности."
	
func _doAttack(_attacker, _receiver, _context = {}):
	var texts = [
		"{attacker.name} щелкает пальцами {attacker.his}, активируя гипнотическую команду {receiver.nameS}."
	]
	var text = RNG.pick(texts)
	
	#if(_receiver.addEffect(StatusEffect.Stunned, [1])):
	#	text += "\n[b]{receiver.name} is briefly stunned![/b]"
	
	_receiver.addEffect(StatusEffect.PosthypnoticTriggerUsedUp)
	
	return {
		text = text,
		stamina = RNG.randi_range(15, 35),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_attacker.hasBlockedHands()):
		return false
		
	if(_receiver.statusEffects.has(StatusEffect.ImplantedPosthypnoticTrigger) && !_receiver.statusEffects.has(StatusEffect.PosthypnoticTriggerUsedUp)):
		return true
		
	return false

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} поднимает {attacker.his} руку, занеся пальцы, чтобы щелкнуть ими."

func getAttackSoloAnimation():
	return "throw"

func getRequirements():
	return [AttackRequirement.FreeHands, AttackRequirement.CanTalk]

func getExperience():
	return [[Skill.Hypnosis, 10]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.0
