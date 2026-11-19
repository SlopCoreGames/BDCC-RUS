extends "res://Game/NpcSlavery/SlaveActivities/StuckInStocks.gd"

func _init():
	id = "StuckInSlutwall"
	
func getVisibleName():
	return "Застрявшая в шлюзовой стене"

func getActivityText():
	return "{npc.name} сейчас застряла в шлюзовой стене, так что {npc.he} {npc.isAre} здесь нет."

func getInteractActions():
	return [
	]

func onStart(_args = []):
	var pawn = GM.main.IS.spawnPawnIfNeeded(getCharID())
	pawn.setLocation("fight_slutwall")
	GM.main.IS.startInteraction("InSlutwall", {inmate=getCharID()})

func onInteractionChanged(_newInteraction):
	if(_newInteraction == null || _newInteraction.id != "InSlutwall"):
		stopActivity()

func getSexEventID():
	return "slutwallUsed"
