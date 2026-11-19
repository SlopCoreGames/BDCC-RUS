extends "res://Inventory/Items/BDSM/HypnovisorMk1.gd"

func _init():
	id = "HypnovisorMk0"

func getVisibleName():
	return "Гипновизор"
	
func getDescription():
	if(isWornByWearer()):
		if(HypnokinkUtil.isInTrance(getWearer())):
			return "Очень важный визор, который помогает сосредоточиться на действительно важных вещах."
		if(HypnokinkUtil.isHypnotized(getWearer())):
			return "Полезный визор, обеспечивающий вашу безопасность."
	return "Старая модель надежного визора дополненной реальности.\nПохоже, его модифицировали для отображения бесконечно вращающейся спирали, сквозь которую время от времени проносятся слова и образы, мелькающие слишком быстро, чтобы их можно было осознать."

func getClothingSlot():
	return InventorySlot.Eyes

func generateRestraintData():
	restraintData = RestraintHypnovisor.new()
	restraintData.setLevel(3)

func getBuffs():	
	if(isWornByWearer() and getWearer().hasPerk(Perk.HypnosisHATS) and HypnokinkUtil.isInTrance(getWearer())):
		return [buff(Buff.AccuracyBuff, [25])]
	else:
		return [buff(Buff.AccuracyBuff, [-25])]

func getPrice():
	return 35

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.Hypnovisor]
	
func maxHypnosisStacks() -> int:
	return 75
	
func getUnriggedParts(_character):
	return {
		"blindfold": ["res://Modules/HypnokinkModule/Items/HypnoVisor/HypnoVisorNorm_Model.tscn"]
		}
		
func getInventoryImage():
	return "res://Modules/HypnokinkModule/Items/HypnoVisor/hypnoVisor_inv.png"

func isRestraintShouldKeep() -> bool:
	return true
