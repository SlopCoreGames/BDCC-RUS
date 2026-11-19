extends ItemBase

func _init():
	id = "ImaginaryWristCuffs"

func getVisibleName():
	return "Настоящие наручники"
	
func getDescription():
	return "Набор абсолютно, стопроцентно настоящих наручников."

func getClothingSlot():
	return InventorySlot.Wrists

func getBuffs():
	return [
		buff(Buff.RestrainedArmsBuff),
		]

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.ImaginaryRestraint]
	
func getTakeOffScene():
	return "HypnoCuffsScene"

func isRestraint():
	return true

func generateRestraintData():
	var restraintClass = load("res://Modules/HypnokinkModule/Items/HypnoRestraints/HK_HypnoRestraint.gd")
	restraintData = restraintClass.new()
	restraintData.setLevel(1)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return "There are " + getAStackName() + " cuffs locking your arms together. When did those get there?"
	else:
		return "There are " + getAStackName() + " cuffs locking {receiver.nameS} arms together. When did those get there?"

func getUnriggedParts(_character):
	return {
		"wrist.L": ["res://Modules/HypnokinkModule/Items/HypnoRestraints/HypnoCuffModel.tscn"],
		"wrist.R": ["res://Modules/HypnokinkModule/Items/HypnoRestraints/HypnoCuffModel.tscn"],
	}
	
func getInventoryImage():
	return "res://Modules/HypnokinkModule/Items/HypnoRestraints/imaginaryCuff.png"

func updateDoll(doll: Doll3D):
	doll.setArmsCuffed(true)
