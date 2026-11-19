extends BuffBase

func _init():
	id = Buff.BlocksVaginaLeakingBuff

func getVisibleDescription():
	return "Предотвращает вытекание спермы из киски"

func apply(_buffHolder):
	_buffHolder.blockedOrifices[OrificeType.Vagina] = true

func getBuffColor():
	return DamageType.getColor(DamageType.Lust)
