extends "res://Modules/HypnokinkModule/Scenes/Sessions/HK_SessionInductionBase.gd"

func _init():
	sceneID = HK_Sessions.InductionRapid
	
func _initScene(_args = []):
	onInduction(_args)

func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "sit", {npc="vion", npcAction="sit"})

		saynn("[say=vion]Думаю, к этому моменту ты уже достаточно натренировалась, {pc.name}. Давай в этот раз попробуем срезать путь. Садись, откинься на спинку и закрой глаза, пожалуйста.[/say]")

		saynn("{vion.name}, как обычно, садится напротив тебя. Ты закрываешь глаза, как тебе и велели.")

		saynn("[say=vion]Хорошо. Расслабься, устройся поудобнее. Сделай глубокий вдох.[/say]")

		saynn("Вы вдыхаете.")

		saynn("[say=vion]А теперь медленно выдыхай.[/say]")

		saynn("Ты выдыхаешь.")

		saynn("[say=vion]А теперь еще один глубокий вдох...[/say]")

		saynn("Ты вдыхаешь...")

		saynn("[say=vion]И на выдохе...[/say]")

		saynn("[say=vion][b]Сон.[/b][/say]")

		saynn("[say=vion]Вот так. [b]Спи.[/b] Погружайся в глубокий гипноз. [b]Спи.[/b] Иди глубже для меня. [b]Спи.[/b] Еще глубже. Позволь спокойному беспамятству накрыть тебя с головой. [b]Спи.[/b][/say]")

		saynn("Спи...")

		saynn("[say=vion][b]Сон.[/b][/say]")
		
		addButton("Спать", "", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		afterInduction()
		return

	setState(_action)
	
