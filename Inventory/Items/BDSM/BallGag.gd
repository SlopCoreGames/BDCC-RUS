extends ItemBase

func _init():
	id = "ballgag"

func getVisibleName():
	return "Шарик-кляп"
	
func getDescription():
	return "Можно использовать, чтобы заткнуть этих дерзких засранок"

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		buff(Buff.GagBuff),
		buff(Buff.AmbientLustBuff, [10]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 5

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBallGag.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" запихали тебе в рот! У тебя уже текут слюни"
	else:
		return getAStackNameCapitalize()+" запихали в {receiver.nameS} рот! {receiver.He} {receiver.is} уже текут слюни"

func updateDoll(doll: Doll3D):
	doll.setState("mouth", "ballgag")

func getInventoryImage():
	return "res://Images/Items/bdsm/ballgag.png"
