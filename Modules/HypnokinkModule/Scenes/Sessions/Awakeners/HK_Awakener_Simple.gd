extends "res://Modules/HypnokinkModule/Scenes/Sessions/HK_SessionAwakenerBase.gd"

func _init():
	sceneID = HK_Sessions.AwakenerSimple
	
func _initScene(_args = []):
	onAwakener()
	
func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "sit", {npc="vion", npcAction="sit"})

		saynn("[say=vion]Так, давай возвращать тебя в чувство. Сделай глубокий вдох.[/say]")

		saynn("Вы вдыхаете.")

		saynn("[say=vion]Сосредоточься на моем голосе. Поднимай свои мысли на поверхность.[/say]")

		saynn("Ваш разум содрогается от пробуждения, выныривая из уютного туманного оцепенения.")

		saynn("[say=vion]С каждым вдохом ты всё отчетливее осознаешь окружающий мир. С каждым моим словом ты всё больше просыпаешься. А теперь медленно открывай глаза...[/say]")

		saynn("Вы открываете глаза и морщитесь от резкого света, льющегося снаружи.")

		saynn("[say=vion]Вот так. Просыпаешься. В полном сознании.[/say]")

		saynn("Транс прерван, и вы на мгновение замираете, чтобы размять ноги. Затем вы встаете.")
		
		addButton("Продолжить", "", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		afterAwakener()
		return

	setState(_action)
