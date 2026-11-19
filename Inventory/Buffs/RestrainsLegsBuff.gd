extends BuffBase

func _init():
	id = Buff.RestrainedLegsBuff

func getVisibleDescription():
	return "Сковывает ноги"

func getBuffColor():
	return Color.purple
