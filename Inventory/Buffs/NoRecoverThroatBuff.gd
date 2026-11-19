extends BuffBase

func _init():
	id = Buff.NoRecoverThroatBuff

func getVisibleDescription():
	return "Горло остается растянутым"

func apply(_buffHolder):
	_buffHolder.orificesPreventedFromRecovering[OrificeType.Throat] = true

func getBuffColor():
	return Color.red
