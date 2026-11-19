extends BuffBase

func _init():
	id = Buff.BreastsForcedLactationBuff

func getVisibleDescription():
	return "Принудительная лактация"

func getBuffColor():
	return DamageType.getColor(DamageType.Lust)
