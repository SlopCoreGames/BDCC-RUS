extends BuffBase

func _init():
	id = Buff.BlocksAnusLeakingBuff

func getVisibleDescription():
	return "Предотвращает протекание спермы из ануса"

func apply(_buffHolder):
	_buffHolder.blockedOrifices[OrificeType.Anus] = true

func getBuffColor():
	return DamageType.getColor(DamageType.Lust)
