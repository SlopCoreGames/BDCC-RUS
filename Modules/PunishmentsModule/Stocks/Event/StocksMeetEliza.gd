extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "StocksMeetEliza"

func _reactInit():
	pass
	
func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.StocksSexOral, "tease", {npc="eliza"})
		# (if can see)
		if(!GM.pc.isBlindfolded()):
			saynn("Вы видите знакомого врача, проходящую мимо. Она замечает вас и направляется к вам.")

		# (if can’t see)
		else:
			saynn("Вы слышите цокот каблуков мимо вас. Кто бы это ни был, кажется, этот человек заметил вас и остановился.")

		saynn("[say=eliza]"+RNG.pick([
			"О, привет. Рада тебя снова видеть.",
			"Может, мне освободить тебя и затащить на пару экспериментов? Хммм...",
			"Не обращай на меня внимания, я просто хотела на тебя посмотреть~.",
			"Выглядишь мило. И сколько тебя уже использовали? Наверное, стоит заглянуть тебе за спинку.",
			"Привет, заключенный.",
		])+"[/say]")

		# (if gagged)
		if(GM.pc.isGagged()):
			saynn("Вы пытаетесь что-то сказать, но из-за кляпа выходят лишь невнятные звуки. Элиза посмеивается и гладит вас по голове, прежде чем уйти.")

		# (if not gagged)
		else:
			saynn("Вы чувствуете легкое унижение, поэтому предпочитаете молчать. Элиза посмеивается и ласково гладит вас по голове, прежде чем уйти.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

