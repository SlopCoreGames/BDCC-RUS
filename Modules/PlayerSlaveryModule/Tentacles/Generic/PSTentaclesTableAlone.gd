extends SceneBase

func _init():
	sceneID = "PSTentaclesTableAlone"

func _reactInit():
	#addCharacter(GM.main.PS.getTentaclesCharID())
	processTime(60*10)
	pass

func resolveCustomCharacterName(_charID):
	if(_charID == "ten"):
		return GM.main.PS.getTentaclesCharID()
	if(_charID == "sci1"):
		return GM.main.PS.getScientist1CharID()
	if(_charID == "sci2"):
		return GM.main.PS.getScientist2CharID()

func _run():
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		saynn("Ты стоишь возле стола. В целом, здесь особо разгуляться негде...")

		if (_tentacles.isNormal() || _tentacles.isSmalll()):
			saynn("Но, возможно, можно заняться йогой... А если привлечь внимание щупалец... они тоже могут заинтересоваться.")

			if (_tentacles.getPrefer() != _tentacles.EVENT_PLAY):
				addButton("Йога", "Сделать упражнения из йоги и попытаться привлечь внимание щупалец", "do_yoga")
			else:
				addDisabledButton("Йога", "Щупальца и так явно настроены на активность...")
		else:
			saynn("Но, может, стоит заняться йогой? Хотя зачем тебе это?..")

			saynn("Если подумать... да... особого смысла сейчас нет. Можно, конечно, дать что-нибудь на виду у камеры наблюдения... но и всё.")

			addButton("Йога", "Сделать упражнения из йоги", "do_yoga")
		addButton("Уйти", "Вы передумали", "endthescene")
	if(state == "do_yoga"):
		if (_tentacles.isNormal() || _tentacles.isSmalll()):
			addCharacter(GM.main.PS.getTentaclesCharID())
		saynn("Никто об этом не говорил... но тебе не помешало бы заняться йогой.")

		var randomPose = RNG.pick(["cobra", "catcow", "dog", "bridge"])
		playAnimation(StageScene.Yoga, randomPose)
		if (randomPose == "cobra"):
			saynn("Ты находишь чистое место и ложишься на живот, вытянув ноги назад и положив ладони возле груди. Ты упираешься в пол и начинаешь приподнимать грудную клетку.")

			saynn("Твоя спина выгибается. Плечи отводятся назад. Голова запрокидывается к потолку.")

			saynn("Замри в этой позе настолько, насколько сможешь... хорошо... Останавливайся, когда почувствуешь легкое жжение в мышцах.")

		elif (randomPose == "catcow"):
			saynn("Ты находишь чистое место и встаешь на колени, после чего крепко упираешься ладонями в пол, переходя на четвереньки. Спина прямая, голова в нейтральном положении. Ты делаешь медленный вдох...")

			saynn("Затем ты прогибаешь спину, опуская живот и одновременно поднимая подбородок и грудь.")

			saynn("Еще один вдох. А затем делаешь всё наоборот: выгибаешь позвоночник вверх, словно потягивающаяся кошка, прижимая подбородок к груди.")

			saynn("Ты медленно переходишь из одной позы в другую... стараясь дышать глубоко. Останавливайся, когда почувствуешь легкое жжение в мышцах.")

		elif (randomPose == "dog"):
			saynn("Ты находишь чистое место и выпрямляешься. Из этого положения ты наклоняешься вперед, позволяя ладоням коснуться холодного пола. Затем ты медленно ведешь руками вперед и поднимаешь бедра, прижимая свой {pc.feet} к полу настолько плотно, насколько это возможно.")

			saynn("Твое тело образует... своего рода треугольник. Руки прямые, спина вытянута, голова слегка расслаблена.")

			saynn("Держи эту позу как можно дольше... И останавливайся, когда почувствуешь, что мышцы начинают приятно гореть.")

		else:
			saynn("Ты находишь чистое место и опускаешься на колени... а затем кладешь свой {pc.feet} плашмя на пол, вплотную к телу. Руки лежат по бокам, ладонями вниз. Медленно ты поднимаешь бедра к потолку.")

			saynn("Твое тело образует изящную дугу, начиная от плеч и заканчивая коленями. Грудь приподнимается, мышцы бедер напрягаются. Ты медленно двигаешь бедрами, растягиваясь всё сильнее...")

			saynn("Держи эту позу как можно дольше... И останавливайся, когда почувствуешь, что мышцы начинают приятно гореть.")

		if (_tentacles.isNormal() || _tentacles.isSmalll()):
			saynn("Позади тебя слышится мягкий шорох...")

			saynn("Тентакли замерли совсем рядом, их кончики приподняты и направлены в твою сторону. Они наблюдали за тем, как ты растягиваешься.")

			saynn("Похоже, ты вызвала у них любопытство.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_yoga"):
		processTime(15*60)
		GM.pc.addStamina(-20)
		GM.pc.addEffect(StatusEffect.Yoga)
		if(_tentacles.isNormal() || _tentacles.isSmalll()):
			_tentacles.setPrefer(_tentacles.EVENT_PLAY)

	setState(_action)
