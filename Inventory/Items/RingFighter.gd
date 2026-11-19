extends ItemBase

func _init():
	id = "RingFighter"

func getVisibleName():
	return "Кольцо Триумфа"
	
func getDescription():
	return "Золотое кольцо, украшенное искусной гравировкой, изображающей победителя-воина, а у его ног на коленях склонились двое поверженных врагов. Оно излучает ауру силы и свершения.\n\n\"[i]Хм. Думаю, можно с уверенностью сказать... что у нашей арены появился новый Гранд-чемпион![/i] \"\n"

func getClothingSlot():
	return InventorySlot.Ring

func getBuffs():
	return [
		buff(Buff.ReceivedPhysicalDamageBuff, [-10]),
		buff(Buff.StatBuff, [Stat.Agility, 10]),
		]

func getPrice():
	return 50

func canSell():
	return true
