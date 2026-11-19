extends "res://Modules/HypnokinkModule/Scenes/Sessions/HK_SessionInductionBase.gd"

func _init():
	sceneID = HK_Sessions.InductionAlreadyHypnotized
	
func _initScene(_args = []):
	onInduction(_args)

func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "sit", {npc="vion", npcAction="sit"})
		
		saynn("[say=vion]Какой смысл в индукции, если ты и так уже под гипнозом, а?[/say]")
		
		saynn("{vion.He} вздыхает и подводит тебя к дивану.")
		
		saynn("[say=vion]Садись.[/say]")
		
		saynn("Ты садишься. {vion.name} подтаскивает стул и усаживается прямо напротив тебя.")
		
		saynn("[say=vion]И просто на всякий случай... [b]Спи.[/b][/say]")
		
		addButton("Спать", "", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		afterInduction()
		return

	setState(_action)
