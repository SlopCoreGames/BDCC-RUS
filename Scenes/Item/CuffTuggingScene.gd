extends "res://Scenes/SceneBase.gd"


func _init():
	sceneID = "CuffTuggingScene"

func _run():
	if(state == ""):
		saynn("Ты осматриваешь свои наручники. Они не такие сложные, как ошейник, но в них всё равно стоит магнитный замок.")
		
		saynn("Они сидят довольно плотно, и мягкая подкладка внутри особо не спасает.")

		addButton("Оставить как есть", "Ничего не поделаешь", "leaveit")
		if(GM.pc.hasBoundArms()):
			addDisabledButton("Дернуть", "Связанные руки не дают этого сделать")
		else:
			addButton("Дернуть", "Попытаться дернуть их", "tug")

	if(state == "tug"):
		saynn("Ты пробуешь дернуть за одно из колец, но люфт почти отсутствует. Ты решаешь, что ломать пальцы только ради того, чтобы снять одно из них, того не стоит.")
		
		saynn("Увы, прогресса ноль")
		
		addButton("Продолжить", "Ну и ладно", "")

	if(state == "leaveit"):
		saynn("Ты вздыхаешь и оставляешь наручники в покое")
		
		addButton("Продолжить", "Ну и ладно", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
