extends "res://Characters/Captain.gd"

func _init():
	id = "captainInmate"
	npcCharacterType = CharacterType.Generic
	disableSerialization = true

func _getName():
	return "Mr. Wright"

func getSmallDescription() -> String:
	return "Черношёрная собака."

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformHighsec"]
