extends ItemBase

func _init():
	id = "ChastityCagePermanentNormal"

func getVisibleName():
	return "Постоянная клетка"
	
func getDescription():
	return "Лишает возможности использовать член. Навсегда."

func getClothingSlot():
	return InventorySlot.Penis

func getRequiredBodypart():
	return BodypartSlot.Penis

func getBuffs():
	return [
		buff(Buff.ChastityPenisBuff),
		buff(Buff.SensitivityGainBuff, [25.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.ChastityCage]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintUnremovable.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" была намертво застегнута на твоем члене, сделав его бесполезным!"
	else:
		return getAStackNameCapitalize()+" была намертво застегнута на члене {receiver.nameS}, сделав его бесполезным!"

func updateDoll(doll: Doll3D):
	doll.setState("cock", "caged")

func isImportant():
	return true

func getInventoryImage():
	return "res://Images/Items/bdsm/chastity_cage.png"
