extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "FemaleGuardFelineOffLimits"

func _run():
	if(state == ""):
		addCharacter("femaleguard_feline")
		playAnimation(StageScene.Duo, "stand", {npc="femaleguard_feline"})

	if(state == ""):
		saynn("Позади раздаются шаги — тяжелые, как от массивных сапог. Ты пытаешься спрятаться, но они выдают присутствие преследователя; голос звучит по-женски.")

		saynn("[say=femaleguard_feline]"+RNG.pick([
			"Hey there~.",
			"I see a new prey.",
			"How did you end up here, silly.",
			"Excuse you.",
			"Whacha doin’ there.",
		])+"[/say]")

		saynn("Ты оборачиваешься и видишь тюремную стражницу — судя по синей униформе и броне, она из охраны. Она высокая и довольно подтянутая, как и большинство фелинок.")

		saynn("Она хватает электрошокер и осторожно приближается к тебе.")

		saynn("[say=femaleguard_feline]"+RNG.pick([
			"Hmmm.. Just give up.",
			"Put your hands up for me. I give you one chance.",
			"Don’t make me use my claws, just surrender.",
			"Time to teach you a lesson.",
		])+"[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Похоже, другого пути нет.", "fight")

	if(state == "lost_fight"):
		saynn("Тебя одолела всего одна охранница. Не в силах продолжать бой, ты падаешь на колени и ждешь своей участи.")
		
		addButton("Продолжить", "Посмотреть, что будет", "getrestrained")

	if(state == "getrestrained"):
		saynn("Охранница подходит к тебе вплотную.")

		saynn("[say=femaleguard_feline]"+RNG.pick([
			"Time to dispense some justice",
			"Let’s see if this will be enough of a lesson.",
			"Resisting will only make this worse for you.",
			"This is gonna serve as a punishment.",
		])+"[/say]")

		saynn("Она достает средства фиксации и пытается надеть их на тебя!")

		# (scene ends)

		addButton("Продолжить", "О нет", "endthescene")

	if(state == "won_fight"):
		saynn("Ты прижимаешь поверженную стражницу к полу. Она почти не сопротивляется.")

		# (if has hands)
		if(!GM.pc.hasBlockedHands()):
			saynn("Ты используешь её же наручники, чтобы сковать её, делая её практически беспомощной.")

		saynn("[say=femaleguard_feline]"+RNG.pick([
			"Nice moves. What’s your plan?",
			"Don’t leave me like this, inmate.",
			"A little kiss before you leave?",
		])+"[/say]")

		addButton("Оставь её в покое", "Просто обчисти её и свали, пока тебя не заметили", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "fight"):
		runScene("FightScene", ["femaleguard_feline"], "guardfight")
	
	if(_action == "getrestrained"):
		for item in GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(1, 2)):
			addMessage(item.getForcedOnMessage())
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag == "guardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_fight")
			addExperienceToPlayer(30)
		else:
			setState("lost_fight")
			addExperienceToPlayer(5)
			

