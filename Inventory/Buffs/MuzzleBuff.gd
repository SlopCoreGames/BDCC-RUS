extends BuffBase

func _init():
	id = Buff.MuzzleBuff

func getVisibleDescription():
	return "Предотвращает укусы и использование рта"

func apply(_buffHolder):
	#_buffHolder.gagged = true
	pass

func getBuffColor():
	return Color.purple
