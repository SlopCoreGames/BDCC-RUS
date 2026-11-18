extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MessagesLogScene"

func _run():
	if(state == ""):
		saynn("Произошедшие события:")
		
		for messageData in GM.main.getLogMessages():
			var title = messageData["title"]
			var message = messageData["message"]
			
			sayn("[b]"+title+"[/b]")
			saynn(message)
		
		addButton("Закрыть", "Закрыть журнал", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		GM.main.clearLog()
		endScene()
		return

func _react_scene_end(_tag, _result):
	setState("")
