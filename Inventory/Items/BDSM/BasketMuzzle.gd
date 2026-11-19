extends ItemBase

func _init():
	id = "basketmuzzle"

func getVisibleName():
	return "Корзина-намордник"
	
func getDescription():
	return "Лучший способ уберечь вашу собачку от нежелательного жевания, орального секса и укусов. Ваш питомец будет вам благодарен."

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		buff(Buff.MuzzleBuff),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 4

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintMuzzle.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" на тебя нацепили силой. Больше никаких укусов!"
	else:
		return getAStackNameCapitalize()+" на {receiver.name} нацепили силой! Больше никаких укусов для {receiver.him}!"

func updateDoll(doll: Doll3D):
	doll.setState("muzzle", "muzzled")

func getInventoryImage():
	return "res://Images/Items/bdsm/muzzle.png"
