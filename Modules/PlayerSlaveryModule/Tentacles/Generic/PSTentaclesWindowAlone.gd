extends SceneBase

func _init():
	sceneID = "PSTentaclesWindowAlone"

func _reactInit():
	#addCharacter(GM.main.PS.getTentaclesCharID())
	processTime(60*10)
	GM.pc.addLust(-20)
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
		saynn("Вы подходите к большому армированному окну своей камеры, за которым зияет пустота.")

		saynn("Стекло холодит кончики пальцев. А там, за ним... лишь чернота и крошечные точки света. Звезды.")

		saynn("Вы в плену так долго, что внешний мир кажется сном. Чем-то, что вы когда-то знали, но уже не можете до конца вспомнить.")

		saynn("Поблизости нет ни планет, ни лун. И даже если где-то есть солнце... его, скорее всего, видно только с другой стороны.")

		saynn("Вы немного успокаиваете разум...")

		if (_tentacles.isNormal() || _tentacles.isSmalll()):
			saynn("Тентакли где-то позади вас. Вы слышите их мягкое шуршание.")

			if (_tentacles.getPrefer() != _tentacles.EVENT_WINDOW):
				addButton("Тентакли", "Привлечь их внимание и заставить посмотреть в окно", "get_attention")
			else:
				addDisabledButton("Тентакли", "Они и так предпочитают сохранять осознанность...")
		addButton("Хватит", "Смотреть, что будет дальше", "endthescene")
		if (!_tentacles.isNormal() && !_tentacles.isSmalll()):
			if (_tentacles.isTiny()):
				addDisabledButton("Тентакли", "Они слишком малы и слабы, чтобы разделить этот вид с...")
			else:
				addDisabledButton("Кем-то", "Вам не с кем разделить этот вид...")
	if(state == "get_attention"):
		_tentacles.doAnim("idle")
		addCharacter(GM.main.PS.getTentaclesCharID())
		saynn("Вы привлекаете внимание щупалец и предлагаете им тоже взглянуть на пейзаж.")

		saynn("[say=pc]Мир гораздо больше, чем ты думаешь.[/say]")

		saynn("Вы не уверены, способны ли они вообще мыслить так же, как вы... но это не имеет значения.")

		saynn("[say=pc]Каждый из этих огоньков — целый отдельный мир. Ни один человек не способен осознать, как много здесь можно исследовать.[/say]")

		saynn("Вы еще какое-то время размышляете об этом... а затем переводите взгляд на замершие щупальца. Похоже, вам удалось пробудить в них... любопытство. Определенно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "get_attention"):
		_tentacles.setPrefer(_tentacles.EVENT_WINDOW)

	setState(_action)
