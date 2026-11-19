extends FluidBase

func _init():
	id = "Piss"

func getVisibleName():
	return "Моча"

func getStatusEffectColor():
	return Color.yellow

func getStatusEffectPicture():
	return "res://Images/StatusEffects/puddle.png"

func getMessyDescription(_pc, _amount):
	if(_amount >= 300.0):
		return "От тебя несёт мочой!"
	if(_amount >= 100.0):
		return "Ты воняешь! Лучше не подпускай к себе людей."
	
	return "От тебя исходит слабый неприятный запах."

func getMessyBuffs(_pc, _amount):
	if(_amount >= 500.0):
		return [
			buff(Buff.LustDamageBuff, [-80]),
			buff(Buff.LustArmorBuff, [50]),
		]
	if(_amount >= 100.0):
		return [
			buff(Buff.LustDamageBuff, [-60]),
			buff(Buff.LustArmorBuff, [20]),
		]
	return [
		buff(Buff.LustDamageBuff, [-30]),
		buff(Buff.LustArmorBuff, [10]),
	]

func getBellyBuffs(_pc, _amount):
	if(_pc.hasPerk(Perk.CumBreathV1)):
		var messLevel = Util.mini(int(_amount / 100), 10)
		
		if(messLevel > 0):
			return [
				buff(Buff.ReceivedLustDamageBuff, [-2 * messLevel]),
			]
	else:
		var messLevel = Util.mini(int(_amount / 100), 10)
		
		if(messLevel > 0):
			return [
				buff(Buff.MaxStaminaBuff, [-5 * messLevel]),
			]

func onSwallow(_pc, _amount):
	var toHeal = Util.mini(int(_amount / 10), 1000)
	
	if(toHeal > 0):
		_pc.addLust(-toHeal)
		return "Питье мочи вызывает тошноту "+_pc.getName()+" out, removing "+DamageType.getDamageColoredString(DamageType.Lust, toHeal)+"."
	
	return null

# Piss reduces the selling price
func getCost(_amount) -> int:
	return int(_amount / 100.0) * -1

func onGettingHitWith(_pc, _amount):
	var likesCum = -1.0
	
	var lustToAdd = int(likesCum * sqrt(_amount) / 1.0)
	var staminaToDrain = int(sqrt(_amount)) * 2
	
	var text = ""
	if(lustToAdd < 0):
		text += _pc.getName()+" ненавидел, когда на него брызгали мочой!"
	elif(lustToAdd > 0):
		text += _pc.getName()+" "+RNG.pick(["loved", "enjoyed", "возбудился от", "liked", "завелся от"])+" когда на него брызгают мочой!"
	
	var painToAdd = 0
	if(RNG.chance(4.0 * sqrt(_amount)) && !_pc.hasEffect(StatusEffect.Collapsed)):
		if(text != ""):
			text += " "
		text += _pc.getName()+" поскользнулся в моче, ой!"
		_pc.addEffect(StatusEffect.Collapsed)
		painToAdd = 10
	
	if(RNG.chance(4.0 * sqrt(_amount)) && !_pc.hasEffect(StatusEffect.Weakness)):
		if(text != ""):
			text += " "
		text += _pc.getName()+" его дико тошнило от того, что его облили мочой!"
		_pc.addEffect(StatusEffect.Weakness, [Util.mini(3, 1 + int(_amount/2000))])
		
	return {
		text = text,
		lust = lustToAdd,
		stamina = staminaToDrain,
		pain = painToAdd,
	}

func getCumOverlayColor():
	return Color.yellow

func canStoreInFluidTank() -> bool:
	return false
