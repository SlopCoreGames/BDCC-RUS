extends BuffBase

func _init():
	id = "testBuff"

func initBuff(_args):
	pass

func getVisibleDescription():
	return "У меня неплохо получается"

func apply(_buffHolder):
	_buffHolder.receiveDamageMult[DamageType.Physical] += 10
