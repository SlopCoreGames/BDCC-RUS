extends BuffBase

func _init():
	id = Buff.BlindfoldBuff

func getVisibleDescription():
	return "Ослепляет того, кто её носит"

func getBuffColor():
	return Color.purple
