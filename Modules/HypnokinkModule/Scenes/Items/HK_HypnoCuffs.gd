extends SceneBase

var uniqueItemID

func _init():
	sceneID = "HypnoCuffsScene"
	
func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func _run():
	if(state == ""):
		if(HypnokinkUtil.isHypnotized(GM.pc)):
			saynn("Ты вряд ли сможешь снять эти вполне реальные наручники.")
			addButton("Продолжить", "Ничего не поделаешь", "endthescene")
		else:
			saynn("Немного подумав, ты понимаешь, что на самом деле на тебе нет никаких наручников!")
			addButton("Продолжить", "Ну, это было легко.", "remove")
			addButton("Подыграть", "Притворяться бывает даже весело", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "remove"):
		var inventory = GM.pc.getInventory()
		var item: ItemBase = inventory.getItemByUniqueID(uniqueItemID)
		inventory.removeEquippedItem(item)
		endScene()
		return
		
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
