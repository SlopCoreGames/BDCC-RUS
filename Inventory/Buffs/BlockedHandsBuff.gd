extends BuffBase

func _init():
	id = Buff.BlockedHandsBuff

func getVisibleDescription():
	return "Блокирует использование рук"

func getBuffColor():
	return Color.purple
