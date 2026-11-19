extends ItemBase

var prisonerNumber = ""
var inmateType = InmateType.General

func _init():
	id = "inmateuniform"

func getVisibleName():
	return InmateType.getOfficialName(inmateType).capitalize() + " inmate uniform"
	
func setPrisonerNumber(newnumber):
	prisonerNumber = newnumber
	
func setInmateType(newtype):
	inmateType = newtype
	
func getDescription():
	var text = "Короткая рубашка с коротким рукавом и шорты, оба предмета сделаны из черной ткани с "+InmateType.getColorName(inmateType)+" trim."

	if(prisonerNumber != null && prisonerNumber != ""):
		text += " The shirt has a prisoner number attached to it that says \""+prisonerNumber+"\""
	
	return text

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	return [
		]

func getTags():
	return [
		ItemTag.GeneralInmateUniform,
		]

func saveData():
	var data = .saveData()
	
	data["prisonerNumber"] = prisonerNumber
	data["inmateType"] = inmateType
	
	return data
	
func loadData(data):
	.loadData(data)
	
	prisonerNumber = SAVE.loadVar(data, "prisonerNumber", "")
	inmateType = SAVE.loadVar(data, "inmateType", InmateType.General)

func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your inmate shirt and pulls down the shorts"
	else:
		return "take off your inmate shirt and pull down the shorts"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your inmate shirt and the shorts"
	else:
		return "put on your inmate shirt and the shorts"

func generateItemState():
	itemState = ShirtAndShortsState.new()
	itemState.canActuallyBeDamaged = true # Is hack because there are many clothes that use this state already and don't support damaging..

func useInCombat(_attacker, _receiver):
	var text := "You toggle!"
	
	if(itemState is ShirtAndShortsState):
		itemState.noShirt = !itemState.noShirt
		if(itemState.noShirt):
			text = "Вы снимаете рубашку!"
		else:
			text = "Вы надеваете рубашку!"
	
	if(isWornByWearer()):
		updateWearerAppearance()
	
	return text

func getPossibleActions():
	if(!isWornByWearer()):
		return []
	return [
		{
			"name": "Toggle shirt",
			"scene": "UseItemLikeInCombatScene",
			"description": "Choose if you want to wear the shirt too or just the shorts",
		},
	]

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	
	return {
		"clothing": "res://Inventory/RiggedModels/InmateUniform/InmateUniform.tscn",
	}

func getInventoryImage():
	if(inmateType == InmateType.SexDeviant):
		return "res://Images/Items/equipment/shirtlilac.png"
	if(inmateType == InmateType.HighSec):
		return "res://Images/Items/equipment/shirtred.png"
	return "res://Images/Items/equipment/shirtorange.png"
