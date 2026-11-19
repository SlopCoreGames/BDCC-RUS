extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MentalCheckupNoJacket"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
	if(state == ""):
		saynn("Вы слышите тихие шаги — кто-то приближается к камерам. Поскольку смирительная рубашка наконец снята, вы решаете спрятаться, чтобы вас не заметили через маленькое окошко. Может, они просто пройдут мимо.")

		saynn("Но нет. Из интеркома доносится шум, а затем раздается голос врача.")

		saynn("[say=eliza]Ну как дела, заключенная?[/say]")

		saynn("Вы не отвечаете, и тогда она пытается заглянуть внутрь.")

		saynn("[say=eliza]Хм? А где заключенная?[/say]")

		saynn("В её голосе слышится беспокойство. Дверь вашей камеры начинает медленно открываться. Она заглядывает внутрь и ахает, завидев вас.")

		saynn("[say=eliza]Эй, как ты...[/say]")

		addButton("Атаковать", "Не дайте ей позвать подкрепление. Поведение---", "attack")
		addButton("Сдаться", "Сказать, что это всё ошибка. Поведение-", "surrender")

	if(state == "attack"):
		saynn("Вы пытаетесь оттолкнуть Элизу, но благодаря своей кошачьей ловкости она уворачивается в последний момент.")

		saynn("[say=eliza]О, так вот как ты решил поиграть?[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Продолжить", "В бой!", "startfight")

	if(state == "surrender"):
		playAnimation(StageScene.Duo, "defeated", {npc="eliza"})
		
		saynn("Ты решаешь не сопротивляться. Элиза прижимает тебя к полу и снова натягивает на тебя смирительную рубашку, туго затягивая все ремни.")

		saynn("[say=eliza]Глупая каторжанка, ты правда думал, что всё будет иначе?[/say]")

		saynn("Закончив с рубашкой, она усаживается на тебя сверху. Она хватает шприц-инъектор и вонзает его тебе в шею. Ой! Ты чувствуешь, как конечности расслабляются...")

		saynn("[say=eliza]Тебе отсюда не сбежать. Не с таким паршивым поведением. И я буду колоть тебя иглами до тех пор, пока ты не станешь послушной. Или пока твой разум не сломается. Хе-хе.[/say]")

		saynn("Она встает, но продолжает прижимать тебя к полу своей ногой.")

		saynn("[say=eliza]Уяснила?[/say]")

		saynn("У тебя нет выбора, кроме как кивнуть; кажется, ты не можешь пошевелить даже мускулом. Такая усталость... Элиза выходит из камеры и закрывает дверь.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "won_fight"):
		saynn("Поняв, что больше не может с тобой бороться, Элиза опускается на колени. Но она еще не сдалась: она пытается использовать свой последний козырь, ее рука тянется к поясу и достает оттуда пульт. Заметив это, ты набрасываешься на нее, прижимая ее руки к полу.")

		saynn("Ты нависаешь над ней верхом, твоя рука не дает Элизе нажать ни на одну кнопку на пульте. Она тяжело дышит и смотрит на тебя заинтригованным взглядом.")

		saynn("[say=eliza]Ммм... А это довольно пошло. Знаешь... я вовсе не злюсь на тебя, заключенный.[/say]")

		saynn("Из другой комнаты доносятся громкие шаги. Элиза тихонько хихикает в твоих руках.")

		saynn("[say=eliza]Тебе лучше сбежать, пока нас не застукали в таком виде~.[/say]")

		addButton("Оставить её", "Пора валить", "leave_her")
		addButton("Поцеловать её", "Прощальный подарок", "kiss_her")

	if(state == "kiss_her"):
		saynn("Ты внезапно целуешь Элизу в губы. Поцелуй получается довольно долгим. Она широко открывает глаза от неожиданности, несколько раз моргает, а затем медленно закрывает их, и на её щеках проступает нежный румянец.")

		saynn("Но так же стремительно, как ты начал поцелуй, ты резко прерываешь его и бросаешься наутёк, оставляя Элизу на полу.")

		# (scene ends)
		addButton("Продолжить", "Пора валить", "endthesceneEscape")
		

	if(state == "leave_her"):
		saynn("Ты переводишь взгляд на источник шагов, и Элиза пользуется этой возможностью, чтобы высвободить одну руку и оцарапать тебе щеку. Ой! Она одаривает тебя дерзкой ухмылкой. Ты рычишь на неё.")

		saynn("[say=eliza]Тебе никогда не понять. Насколько важна наука.[/say]")

		saynn("Шаги становятся еще громче, поэтому ты решаешь сбежать, оставляя Элизу на полу.")

		# (add a bit of pain)
		addButton("Продолжить", "Пора валить", "endthesceneEscape")
		# (scene ends)

func _react(_action: String, _args):

	if(_action == "surrender"):
		MedicalModule.addPCBehavior(-0.1)

		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("LatexStraitjacket"))

	if(_action == "attack"):
		MedicalModule.addPCBehavior(-0.9)

	if(_action == "startfight"):
		runScene("FightScene", ["eliza"], "elizafight")

	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "endthesceneEscape"):
		endScene([true])
		return
	
	if(_action == "leave_her"):
		GM.pc.addPain(5)
	
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag == "elizafight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_fight")
			setModuleFlag("MedicalModule", "Mental_PlayerEscaped", true)
			#endScene([true])
			addExperienceToPlayer(50)
		else:
			setState("surrender")
			GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("LatexStraitjacket"))
			addExperienceToPlayer(10)
