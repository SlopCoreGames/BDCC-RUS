extends ItemBase

func _init():
	id = "bondagemittens"

func getVisibleName():
	return "Бондажные варежки"
	
func getDescription():
	return "Черные кожаные варежки для рук. Как только ты их надеваешь, твои руки становятся практически бесполезными"

func getClothingSlot():
	return InventorySlot.Hands

func getBuffs():
	return [
		buff(Buff.BlockedHandsBuff),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 5

func getSellPrice():
	return 2

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintMittens.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getA():
	return ""

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" were locked onto your hands"
	else:
		return getAStackNameCapitalize()+" were locked onto {receiver.nameS} hands"

func updateDoll(doll: Doll3D):
	doll.setState("gloves", "mittens")

func getInventoryImage():
	return "res://Images/Items/bdsm/bondagemitten.png"
