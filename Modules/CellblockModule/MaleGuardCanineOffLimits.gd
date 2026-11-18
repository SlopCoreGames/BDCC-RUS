extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MaleGuardCanineOffLimits"

func _run():
	if(state == ""):
		addCharacter("maleguard_canine")
		playAnimation(StageScene.Duo, "stand", {npc="maleguard_canine"})

	if(state == ""):
		saynn("Из тени позади тебя доносится хриплый мужской голос.")

		saynn("[say=maleguard_canine]"+RNG.pick([
			"Hey, you’re not supposed to be here.",
			"You got lost, didn’t you.",
			"Someone is feeling risky today, huh.",
			"I see a stray inmate.",
			"Inmates never learn, do they.",
		])+"[/say]")

		saynn("Ты оборачиваешься и видишь тюремного охранника — судя по синей униформе и броне, это точно он. У него явно выраженные звериные черты: стоячие волчьи уши, длинная морда с грубым носом и виляющий хвост.")

		saynn("Он хватает электрошокер и небрежно приближается к тебе, оглядывая тебя хищным взглядом.")

		saynn("[say=maleguard_canine]"+RNG.pick([
			"What are we gonna do about this?",
			"Care to explain yourself?",
			"Why shouldn’t I report you right here and now?",
			"I don’t like your odds.",
		])+"[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Похоже, другого пути нет.", "fight")

	if(state == "lost_fight"):
		saynn("Тебя одолела всего одна охранница. Не в силах продолжать бой, ты падаешь на колени и ждешь своей участи.")

		addButton("Продолжить", "Посмотреть, что будет", "getrestrained")

	if(state == "getrestrained"):
		saynn("Охранница подходит к тебе вплотную.")

		saynn("[say=maleguard_canine]"+RNG.pick([
			"Time to dispense some justice",
			"Let’s see if this will be enough of a lesson.",
			"Resisting will only make this worse for you.",
			"This is gonna serve as a punishment.",
		])+"[/say]")

		saynn("Он достает какие-то средства фиксации и пытается надеть их на тебя!")

		# (scene ends)

		addButton("Продолжить", "О нет", "endthescene")

	if(state == "won_fight"):
		saynn("Ты прижимаешь поверженного охранника к полу. Кажется, он особо и не сопротивляется.")

		# (if has hands)
		if(!GM.pc.hasBlockedHands()):
			saynn("Ты используешь его же наручники, чтобы сковать его, делая его практически беспомощным.")

		saynn("[say=maleguard_canine]"+RNG.pick([
			"What’s your plan?",
			"Don’t leave me like this, inmate.",
			"A short goodbye fuck before you leave would be nice.",
		])+"[/say]")

		addButton("Оставить его в покое", "Просто обчистить его и свалить, пока тебя не заметили", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "fight"):
		runScene("FightScene", ["maleguard_canine"], "guardfight")
	
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
			

