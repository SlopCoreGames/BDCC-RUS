extends BuffBase

func _init():
	id = Buff.RestrainedArmsBuff

func getVisibleDescription():
	return "Сковывает руки"

func getBuffColor():
	return Color.purple
