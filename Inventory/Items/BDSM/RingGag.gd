extends ItemBase

func _init():
	id = "ringgag"

func getVisibleName():
	return "Кольцевой кляп"
	
func getDescription():
	return "Можно использовать, чтобы заткнуть этих наглых соплячек. Этот вариант не мешает оральному сексу. Пикантно."

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		buff(Buff.RingGagBuff),
		buff(Buff.AmbientLustBuff, [10]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 10

func getSellPrice():
	return 2

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintRingGag.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" засунули тебе в рот! У тебя текут слюни, и ты больше не можешь сомкнуть челюсти!"
	else:
		return getAStackNameCapitalize()+" засунули в рот {receiver.nameS}! {receiver.He} {receiver.is} течет слюна, и {receiver.his} больше не может сомкнуть рот!"

func updateDoll(doll: Doll3D):
	doll.setState("mouth", "ringgag")

func getInventoryImage():
	return "res://Images/Items/bdsm/ringgag.png"
