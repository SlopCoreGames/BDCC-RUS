extends BuffBase

func _init():
	id = Buff.GagBuff

func getVisibleDescription():
	return "Надевает на носителя кляп"

func apply(_buffHolder):
	_buffHolder.gagged = true

func getBuffColor():
	return Color.purple
