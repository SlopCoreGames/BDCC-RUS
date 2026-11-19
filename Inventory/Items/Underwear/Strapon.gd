extends ItemBase

func _init():
	id = "Strapon"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Страпон"
	
func getDescription():
	var text = "Страпон, который можно использовать во время секса. Можно надеть, только если у тебя еще нет члена."

	return text

func getClothingSlot():
	return InventorySlot.Strapon

func getBuffs():
	return [
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "снимает твой страпон"
	else:
		return "снять страпон"

func getPuttingOnStringLong(withS):
	if(withS):
		return "надевает страпон"
	else:
		return "надеть страпон"

func getPrice():
	return 10

# If you're changing these, keep in mind that StraponOvi and StraponOviFeeldoe don't inherit these
func getTags():
	if(id == "Strapon"):
		return [
			ItemTag.Strapon,
			ItemTag.SoldByMedicalVendomat,
			ItemTag.SoldByTheAnnouncer,
			ItemTag.StraponUsedByNPC,
			]
	return [
		ItemTag.Strapon,
		ItemTag.SoldByTheAnnouncer,
		ItemTag.StraponUsedByNPC,
		]

#func generateItemState():
#	itemState = PantiesState.new()

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"strapon": "res://Inventory/RiggedModels/Strapons/HumancockStrapon.tscn",
	}

func getHidesParts(_character):
	return {
		BodypartSlot.Penis: true,
		"chastity_cage": true,
	}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false

func updateDoll(doll: Doll3D):
	doll.setPenisScale(1.0)
	doll.setBallsScale(1.0)

func getStraponLength():
	return 20.0

func getStraponPleasureForDom():
	return 0.1

func onSexEnd():
	destroyMe()

func getPutOnScene():
	return "StraponPutOnScene"

func getCasualName():
	return "strapon"

func getLewdStraponName() -> String:
	return getCasualName()

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(500.0)

func getPossibleActions():
	return [
		{
			"name": "Перекачать жидкость",
			"scene": "FluidTransferScene",
			"description": "Перелить жидкость из одного контейнера в другой",
		},
	]

func getInventoryImage():
	return "res://Images/Items/strapons/human.png"

func alwaysRecoveredAfterSex():
	return true

func canDye():
	return true

func getStraponTraits() -> Dictionary:
	return {
	}

func canStuffEggInto(_targetChar, _bodypart:String) -> bool:
	return false

func doStuffEggInto(_targetChar, _bodypart:String) -> Dictionary:
	return {success = false}


func doStuffEggIntoTransfer(_targetChar, _bodypart:String) -> Dictionary:
	var theWearer = getWearer()
	
	var ourMenstrualCycle:MenstrualCycle = theWearer.getMenstrualCycle()
	var targetMenstrualCycle:MenstrualCycle = _targetChar.getMenstrualCycle()
	if(!ourMenstrualCycle || !targetMenstrualCycle):
		return {success = false}
	
	var theEgg:EggCell = ourMenstrualCycle.transferAnyBigEggTo(targetMenstrualCycle, OrificeType.fromBodypart(_bodypart))
	if(!theEgg):
		return {success = false}
	var theEggName:String = EggLaid.getNameByEggType(theEgg.bigEggType)
	
	var theHole:String = "в дырочку {<TARGET>.your}"
	if(_bodypart == BodypartSlot.Vagina):
		theHole = "в киску {<TARGET>.your}"
	if(_bodypart == BodypartSlot.Anus):
		theHole = "в анус {<TARGET>.your}"
	if(_bodypart == BodypartSlot.Head):
		theHole = "в глотку {<TARGET>.your}"
	
	var theTextLine:String = theEggName+" получает [b] в задницу "+theHole+"[/b] яйцекладом {<USER>.your}."
	theTextLine = theTextLine.replace("<TARGET>", _targetChar.getID())
	theTextLine = theTextLine.replace("<USER>", getWearer().getID())
	return {
		success = true,
		text = theTextLine,
	}

func canStuffEggIntoTransfer(_targetChar, _bodypart:String) -> bool:
	var theWearer = getWearer()
	
	if(!_targetChar || !_targetChar.getMenstrualCycle()):
		return false
	
	if(theWearer && theWearer.isEggStuffed()):
		return true
	
	return false
