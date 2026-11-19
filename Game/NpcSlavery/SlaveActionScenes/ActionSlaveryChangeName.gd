extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "ActionSlaveryChangeName"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		saynn("Текущее имя твоего раба — {npc.name}.")
		
		if(npc.getFlag("OriginalName") != null && npc.getFlag("OriginalName") != npc.getName()):
			saynn("Ты вспоминаешь, что {npc.his} оригинальное имя было"+str(npc.getFlag("OriginalName", "Bob"))+".")
		
		if(npcSlavery.isMindBroken()):
			saynn("[say=npc]..kh..[/say]")
		else:
			saynn("[say=npc]Мне что, сказать что-то?[/say]")
		
		saynn("Что именно ты хочешь изменить?")
		
		addButton("Имя", "Выбери новое имя для своего раба", "pick_name")
		addButton("Краткое описание", "Выберите новое краткое описание для своего раба", "pick_desc")
		addButton("Цвет чата", "Измените цвет чата вашего раба", "pick_chatcolor")
		addButton("Назад", "Назад", "endthescene")
	
	if(state == "pick_chatcolor"):
		var colorPicker = colorPickerScene.instance()
		GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
		colorPicker.setCurrentColor(npc.getChatColor())
			
		addButton("Подтвердить", "Изменить имя", "do_pick_color")
		addButton("Сбросить на стандартное", "Сбросить цвет чата рабыни", "do_reset_chatcolor")
		addButton("Отмена", "Вы передумали", "")
	
	if(state == "pick_name"):
		say("Выберите новое имя для вашей рабыни:")
		
		var textBox:LineEdit = addTextbox("npc_name")
		textBox.text = npc.getName()
		var _ok = textBox.connect("text_entered", self, "onNameTextBoxEnterPressed")
		
		addButton("Подтвердить", "Изменить имя", "do_pick_name")
		addButton("Отмена", "Вы передумали", "")
		addButtonAt(4, "Случайно?", "Выбрать случайное имя", "do_random_name")
	
	if(state == "pick_desc"):
		saynn("Выберите новое описание для вашей рабыни")
		
		var textBox = addBigTextbox("npc_desc")
		textBox.text = npc.getSmallDescription()
		#var _ok = textBox.connect("text_entered", self, "onNameTextBoxEnterPressed")
		
		addButton("Подтвердить", "Изменить описание", "do_pick_desc")
		addButton("Отмена", "Вы передумали", "")

func onNameTextBoxEnterPressed(_new_text:String):
	GM.main.pickOption("do_pick_name", [])

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "do_pick_color"):
		var theColor:Color = getTextboxData("colorpicker")
		npc.npcChatColorOverride = "#"+theColor.to_html(false)
		addMessage("Вы изменили цвет чата вашего раба!")
		setState("")
		removeCharacter(npcID)
		addCharacter(npcID)
		return
	
	if(_action == "do_pick_name"):
		var new_name:String = ""
		if(_args.size() > 0):
			new_name = _args[0]
		else:
			new_name = getTextboxData("npc_name")

		if(setSlaveNameTo(new_name)):
			addMessage("Вы изменили имя вашего раба!")
			setState("")
		return

	if(_action == "do_random_name"):
		runScene("CharacterNameGeneratorScene", [], "name_generator")
		return
	
	if(_action == "do_reset_chatcolor"):
		npc.npcChatColorOverride = ""
		setState("")
		removeCharacter(npcID)
		addCharacter(npcID)
		return
	
	if(_action == "do_pick_desc"):
		if(setSlaveDescTo(getTextboxData("npc_desc"))):
			addMessage("Вы изменили описание вашего раба!")
			setState("")
		return
		
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "name_generator"):
		if(_result.has("random_name")):
			GM.main.pickOption("do_pick_name", [_result["random_name"]])

func setSlaveNameTo(newname:String):
	newname = newname.replace("{", "")
	newname = newname.replace("}", "")
	newname = newname.replace("[", "")
	newname = newname.replace("]", "")
	newname = newname.replace("\"", "")
	newname = newname.strip_edges()
	
	if(newname == ""):
		return false
	if(npc.getFlag("OriginalName") == null):
		npc.setFlag("OriginalName", npc.getName())
	npc.npcName = newname
	removeCharacter(npcID)
	addCharacter(npcID)
	return true

func setSlaveDescTo(newname:String):
	newname = newname.replace("{", "")
	newname = newname.replace("}", "")
	newname = newname.replace("[", "")
	newname = newname.replace("]", "")
	newname = newname.replace("\"", "")
	newname = newname.strip_edges()
	
	if(newname == ""):
		return false
	if(npc.getFlag("OriginalDesc") == null):
		npc.setFlag("OriginalDesc", npc.getSmallDescription())
	npc.npcSmallDescription = newname
	removeCharacter(npcID)
	addCharacter(npcID)
	return true

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
