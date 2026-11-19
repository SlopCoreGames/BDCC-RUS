extends "res://StatusEffect/StretchedPainfullyPussy.gd"

func _init():
	id = StatusEffect.StretchedPainfullyAnus

func getEffectName():
	return "Анус болезненно растянут на x"+str(stacks)

func getEffectDesc():
	if(stacks <= 1):
		return "Твой анус выглядит в синяках и довольно сильно болит... День отдыха может помочь"
	if(stacks <= 2):
		return "Твой анус настолько весь в синяках, что сам не заживет... Тебе стоит найти врача"
	
	return "Твой анус получил серьезные повреждения и сам не заживет... Тебе стоит найти врача"

func getEffectImage():
	return "res://Images/StatusEffects/donut.png"

func getBuffs():
	if(stacks <= 1):
		return [
			buff(Buff.AmbientPainBuff, [5]),
			buff(Buff.NoRecoverAnusBuff),
			buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Anus, -100.0]),
			buff(Buff.SensitivityGainBuff, [BodypartSlot.Anus, -20.0 - (stacks-1)*30.0]),
			buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Anus, -10.0 - (stacks-1)*20.0]),
		]
	
	return [
		buff(Buff.AmbientPainBuff, [4+stacks*2]),
		buff(Buff.NoRecoverAnusBuff),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Anus, -100.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Anus, -100.0]),
		buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Anus, -50.0]),
	]
