extends ItemBase

var currentColor = 0

func _init():
	id = "ChastityCageAdvanced"

func getVisibleName():
	return "Продвинутая девайс-клетка"
	
func getDescription():
	return "Блокирует возможность использовать твой член. Эту штуку невероятно трудно снять, к тому же она может бить током! Но зато здесь есть кнопка для смены цвета..."

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
	return 40

func canSell():
	return true

func getTags():
	if(GM.main != null && GM.main.getFlag("AlexRynardModule.ch2DidChastityWith")):
		return [ItemTag.BDSMRestraint, ItemTag.ChastityCage, ItemTag.SoldByAlexRynard]
	return [ItemTag.BDSMRestraint, ItemTag.ChastityCage]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = preload("res://Inventory/RestraintTypes/RestraintChastityCageAdvanced.gd").new()
	restraintData.setLevel(6)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was locked onto your penis, making it useless!"
	else:
		return getAStackNameCapitalize()+" was locked onto {receiver.nameS} penis, making it useless!"

func getRiggedParts(_character):
	if(currentColor == 1):
		return {
			"chastity_cage": "res://Inventory/RiggedModels/ShockCage/ShockCageLilac.tscn",
		}
	if(currentColor == 2):
		return {
			"chastity_cage": "res://Inventory/RiggedModels/ShockCage/ShockCageGeneral.tscn",
		}
	return {
		"chastity_cage": "res://Inventory/RiggedModels/ShockCage/ShockCage.tscn",
	}

func getHidesParts(_character):
	return {
		BodypartSlot.Penis: true,
	}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false

func isImportant():
	return true

func getInventoryImage():
	if(currentColor == 1):
		return "res://Images/Items/bdsm/ShockCagePurple.png"
	if(currentColor == 2):
		return "res://Images/Items/bdsm/ShockCageOrange.png"
	return "res://Images/Items/bdsm/ShockCageRed.png"

func useInCombat(_attacker, _receiver):
	var text = "Вы переключаетесь между 3 доступными цветами."
	
	currentColor += 1
	if(currentColor >= 3):
		currentColor = 0
	
	if(isWornByWearer()):
		updateWearerAppearance()
	
	return text

func getPossibleActions():
	return [
		{
			"name": "Change color",
			"scene": "UseItemLikeInCombatScene",
			"description": "Toggle between colors of your chastity cage",
		},
	]

func saveData():
	var data = .saveData()
	
	data["currentColor"] = currentColor
	
	return data
	
func loadData(data):
	.loadData(data)
	
	currentColor = SAVE.loadVar(data, "currentColor", 0)

func getDatapackEditVars():
	var result = .getDatapackEditVars()

	result["currentColor"] = {
		"name": "Color",
		"type": "selector",
		"value": currentColor,
		"values": [
			[0, "Red"],
			[1, "Purple"],
			[2, "Orange"],
		],
	}
	return result

func applyDatapackEditVar(_id, _value):
	.applyDatapackEditVar(_id, _value)
	
	if(_id == "currentColor"):
		currentColor = _value
