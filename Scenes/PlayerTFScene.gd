extends "res://Scenes/SceneBase.gd"

var savedText:String = ""
var tfCount:int = 0

func _init():
	sceneID = "PlayerTFScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.TFLook, "start")
		saynn("Странное ощущение начинает накрывать тебя...")
		
		saynn("С твоим телом что-то происходит... ты это чувствуешь...")
		
		addButton("Продолжить", "Посмотреть, что будет...", "doTF")
		
	if(state == "afterTF"):
		#if(tfCount >= 2):
		#	saynn("Но это еще не всё...")
		
		saynn(savedText)
		
		var tfHolder:TFHolder = GM.pc.getTFHolder()
		if(tfHolder.hasPendingTransformations()):
			saynn("У тебя возникает предчувствие, что вот-вот случится что-то еще...")
			
			addButton("Еще??", "Посмотреть, что будет с тобой дальше...", "doTF")
		else:
			addButton("Продолжить", "Ты изменился...", "endthescene")
		
		#if(true):
		#	addButton("ОТМЕНИТЬ ВСЁ", "Посмотреть, что будет...", "undoall")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "undoall"):
		var tfHolder:TFHolder = GM.pc.getTFHolder()
		tfHolder.undoAllTransformations()
		endScene()
		return
	if(_action == "doTF"):
		var tfHolder:TFHolder = GM.pc.getTFHolder()
		
		var result:Dictionary = tfHolder.doFirstPendingTransformation({})
		savedText = result["text"]
		
		if(result.has("say") && result["say"] != ""):
			savedText += "\n\n[say=pc]"+result["say"]+"[/say]"
		
		tfCount += 1
		
		if(result.has("anim") && result["anim"].size() > 2):
			var animInfo:Array = result["anim"]
			playAnimation(animInfo[0], animInfo[1], animInfo[2])
		
		setState("afterTF")
		return
		
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["savedText"] = savedText
	data["tfCount"] = tfCount

	return data
	
func loadData(data):
	.loadData(data)
	
	savedText = SAVE.loadVar(data, "savedText", "")
	tfCount = SAVE.loadVar(data, "tfCount", 0)
