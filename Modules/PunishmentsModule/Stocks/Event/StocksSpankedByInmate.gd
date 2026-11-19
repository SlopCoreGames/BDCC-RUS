extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "StocksSpankedByInmate"

func _reactInit():
	GM.pc.addLust(20)
	addMessage("+20 lust")
	
	if(RNG.chance(50)):
		var zone = BodyWritingsZone.getRandomZone()
		GM.pc.addBodywriting(zone, BodyWritings.getRandomWritingIDForZone(zone))
		addMessage("Someone also left a memento on your "+BodyWritingsZone.getZoneVisibleName(zone)+"..")
		

func _run():
	if(state == ""):
		# (if can see)
		if(!GM.pc.isBlindfolded()):
			saynn("Ты чувствуешь, что кто-то идет к тебе сзади. Ты пытаешься оглянуться, но успеваешь лишь мельком увидеть полосатую форму заключенного.")

		# (if blind)
		else:
			saynn("Ты чувствуешь, что кто-то приближается. Из-за повязки на глазах невозможно понять, кто это — ты слышишь только шаги.")

		saynn("Внезапно ты чувствуешь, как чья-то рука шлепает тебя по {pc.thick} заднице! Ой! Ты пытаешься прикрыться, но нет — ты совершенно беспомощна.")

		# (one of these)
		if(RNG.chance(20)):
			saynn("Ты слышишь, как какой-то мужчина что-то напевает под нос.")

		# (another)
		elif(RNG.chance(20)):
			saynn("Ты слышишь мужской смешок.")

		# (another)
		else:
			saynn("[sayMale]"+RNG.pick([
				"Want another one?",
				"Just look at this slut with {pc.his} ass out like that.",
				"Beg and I might just fuck you. Haha.",
				"You deserve it.",
				"So how did you end up there. Wait, I don’t care.",
				"Let me just tender some meat.",
				"Your butt is pretty soft.",
			])+"[/sayMale]")

		saynn("Заключенный кладет на тебя руки и начинает тискать твою задницу, а затем отвешивает еще один крепкий шлепок, от которого твои ягодицы затряслись. Ты издаешь приглушенный стон.")

		# (if has vagina && chance)
		if(GM.pc.hasReachableVagina() && RNG.chance(50)):
			# (if clothed)
			if(!GM.pc.isFullyNaked()):
				saynn("Его рука ложится тебе на промежность и начинает тереться. Ты чувствуешь, как его пальцы впиваются в ткань. Ты пытаешься свести ноги, но он лишь снова шлепает тебя и силой раздвигает их. Ты тихо стонешь, пока он дразнит тебя...")

			# (if naked)
			else:
				saynn("Его рука опускается к твоей промежности; ты чувствуешь, как его пальцы очерчивают контуры твоей обнаженной киски. Ты пытаешься свести ноги, но он лишь снова шлепает тебя и силой раздвигает их. Ты тихо стонешь, пока он дразнит тебя...")

		# (if has cock && chance)
		if(GM.pc.hasReachablePenis() && RNG.chance(50)):
			# (if clothed)
			if(!GM.pc.isFullyNaked()):
				saynn("Затем его рука скользит вниз, к твоему бугорку; пальцы впиваются в ткань и слегка сжимают твой мошонку. После этого он начинает ласкать тебя прямо через одежду, водя рукой взад-вперед. Это чертовски возбуждает.")

			# (if naked)
			else:
				saynn("Затем его рука скользит к твоей {pc.cock}. Он берет твои яйца в ладонь и слегка сжимает их. Затем его пальцы обхватывают твой член и начинают дразняще ласкать его. Это так возбуждает!")

		saynn("Он отвешивает еще несколько шлепков, каждый всё сильнее и сильнее, пока перед глазами не начинают плясать красные искры. Затем он усмехается и оставляет тебя в покое. Ты определенно возбудился, а не разозлился.")

		addButton("Продолжить", "Ow", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

