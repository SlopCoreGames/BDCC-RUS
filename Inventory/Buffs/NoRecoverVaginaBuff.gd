extends BuffBase

func _init():
	id = Buff.NoRecoverVaginaBuff

func getVisibleDescription():
	return "Поддерживает растянутость киски"

func apply(_buffHolder):
	_buffHolder.orificesPreventedFromRecovering[OrificeType.Vagina] = true

func getBuffColor():
	return Color.red
