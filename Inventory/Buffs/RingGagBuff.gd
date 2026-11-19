extends BuffBase

func _init():
	id = Buff.RingGagBuff

func getVisibleDescription():
	return "Заставляет носителя широко раскрыть рот и вставляет кляп"

func apply(_buffHolder):
	_buffHolder.gagged = true

func getBuffColor():
	return Color.purple
