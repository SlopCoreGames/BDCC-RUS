extends ItemBase

var npcID:String = ""

func _init():
	id = "KeyholderKeyUnlock"

func getVisibleName():
	return "Уникальный ключ"
	
func getDescription():
	var keyName = "unknown"
	if(GlobalRegistry.getCharacter(npcID) != null):
		keyName = GlobalRegistry.getCharacter(npcID).getName()
	
	return "Ключ от твоих оков! Если взять его, откроются все оковы, запертые с помощью "+str(keyName)

func getPrice():
	return 0

func canSell():
	return true

func getTags():
	return [
		]

func getInventoryImage():
	return "res://Images/Items/bdsm/key.png"

func saveData():
	var data = .saveData()
	data["npcID"] = npcID
	return data
	
func loadData(_data):
	.loadData(_data)
	npcID = SAVE.loadVar(_data, "npcID", "")
