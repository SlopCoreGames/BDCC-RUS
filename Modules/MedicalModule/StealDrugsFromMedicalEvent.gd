extends EventBase

func _init():
	id = "StealDrugsFromMedicalEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "medical_storage")
	
func run(_triggerID, _args):
	if(getFlag("MedicalModule.Medical_StoleDrugsToday")):
		addDisabledButton("Искать", "Ты уже воровал здесь лекарства сегодня")
	else:
		saynn("Здесь можно украсть немного лекарств.")
		
		addButtonUnlessLate("Искать", "Осмотреться в поисках чего-нибудь ценного", "stealdrugs")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "stealdrugs"):
		setFlag("MedicalModule.Medical_StoleDrugsToday", true)
		
		var medicalStorageLoot = load("res://Inventory/LootTable/MedicalStorageLoot.gd")
		var lootTable = medicalStorageLoot.new()
		
		var loot = lootTable.generateAndCreateItems()
		
		if(loot.has("items") && loot["items"].size() > 0):
			runScene("LootingScene", [loot])
			GM.main.addMessage("Вы нашли немного наркоты, которую можно стянуть")
		else:
			GM.main.addMessage("Вы ничего не нашли")
			GM.main.reRun()
