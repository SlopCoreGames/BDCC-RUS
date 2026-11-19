extends ItemBase

func _init():
	id = "RingRahi"

func getVisibleName():
	return "Кольцо вечной любви"
	
func getDescription():
	return "Простое металлическое кольцо. Но оно значит для тебя очень много. На нем выгравировано: \"Помни. Вечно и навсегда.\"\n\n\"[i]Да...[/i]\"\n"

func getClothingSlot():
	return InventorySlot.Ring

func getBuffs():
	return [
		buff(Buff.DodgeChanceBuff, [10]),
		buff(Buff.ExposureBuff, [-50]),
		]

func getPrice():
	return 50

func canSell():
	return true
