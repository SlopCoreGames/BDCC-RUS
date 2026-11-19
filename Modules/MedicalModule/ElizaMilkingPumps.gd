extends "res://Scenes/SceneBase.gd"

var howMuchMilked = 0.0

func _init():
	sceneID = "ElizaMilkingPumps"

func _run():
	if(state == ""):
		addCharacter("eliza")
		
	if(state == ""):
		# (if low-medium)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 4):
			saynn("[say=pc]Я хочу сдать молоко.[/say]")

		# (if high)
		else:
			saynn("[say=pc]Пожалуйста, мне очень нужно подоить вымя. Если этого не сделать, оно начинает чесаться.[/say]")

		saynn("[say=eliza]Это можно устроить. Иди за мной, заключенная.[/say]")

		saynn("Элиза отходит от прилавка и надевает на тебя поводок.")

		addButton("Следовать", "Посмотреть, куда она вас приведет", "follow")

	if(state == "follow"):
		aimCamera("med_milkingroom")
		setLocationName("Райское доение")
		playAnimation(StageScene.Duo, "stand", {npc="eliza", bodyState={exposedChest=true}})
		
		saynn("Ты входишь в помещение, предназначенное для дойки; Элиза заводит тебя в одну из клеток и привязывает твой поводок к одной из металлических перекладин. Ты оглядываешься: в комнате царит уютная, но мрачноватая атмосфера, а освещение здесь не слишком яркое.")

		# (if tied up)
		if(GM.pc.hasBlockedHands() || GM.pc.hasBoundArms()):
			saynn("Элиза была достаточно добра и на время сняла с тебя остальные оковы.")

		# (if clothed)
		if(!GM.pc.isFullyNaked()):
			saynn("Она велит тебе держаться за перекладину перед собой, и ты повинуешься, пока она {pc.undressMessageS}. Тебя оставляют стоять нагой, пока она идет за снаряжением.")

		# (else)
		else:
			saynn("Она велит тебе держаться за перекладину перед собой, и ты повинуешься. Она оставляет тебя стоять нагой, пока идет за снаряжением.")

		saynn("[say=eliza]В ручном доении есть свое очарование, но этот способ куда эффективнее~.[/say]")

		saynn("Ты замечаешь, что в руках у неё пара молокоотсосов и все остальные необходимые принадлежности: мягкие трубки и переходники.")

		# (if low-medium)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 4):
			saynn("[say=pc]Выглядит очень индустриально...[/say]")

			saynn("[say=eliza]Если это работает для коров, то почему бы не использовать это на людях?[/say]")

		# (if high)
		else:
			saynn("[say=pc]Да, пожалуйста, моим молочным кувшинам не помешает хорошая накачка. Му![/say]")

			saynn("[say=eliza]Вот это настрой![/say]")

		saynn("Ты подаешься грудью вперед, и Элиза начинает надевать насосы на твои {pc.breasts}; присоски плотно присасываются к твоим соскам, уже начиная их тянуть. Затем доктор подсоединяет трубки к магистральным трубам, проходящим через всю комнату.")

		saynn("[say=eliza]Вот так, всё, что тебе нужно — это стоять смирно. Но не забывай мычать~, это помогает качеству молока. Готова?[/say]")

		addButton("Дай себя подоить", "Му!", "get_milked")

	if(state == "get_milked"):
		saynn("Ты киваешь доктору, она включает насосы и делает шаг назад. Сначала они работают медленно, нежно стимулируя твои соски быстрым, но слабым ритмом. Это чертовски возбуждает; ты вцепляешься в поручень и сжимаешь бедра, пока насосы постепенно наращивают мощность.")

		# (if low-medium)
		if(GM.pc.getSkillLevel(Skill.Milking) <= 4):
			saynn("[say=pc]Му-у-у...[/say]")

		# (if high)
		else:
			saynn("[say=pc]Му-у-у![/say]")

		saynn("Элиза закусывает губу, наблюдая за тобой. Первые капли {pc.milk} уже собираются. Насосы не останавливаются, они переходят в более медленный режим, но каждый толчок становится гораздо глубже и мощнее, вызывая устойчивый поток молока. Ты слегка прогибаешься в пояснице, с твоих губ срываются тихие стоны. Доктор убеждается, что всё работает исправно, а затем проводит ладонью по твоим {pc.thick} изгибам, игриво шлепнув тебя по заднице.")
#ACEPREGEXPAC - Eliza comments on her pregnant, possibly milky state
		if(getCharacter("eliza").isVisiblyPregnant()):
			saynn("[say=eliza]Хорошая коровка~. Хочу услышать, как ты мычишь для меня.[/say]")
			saynn("Вы видите, как Элиза поглаживает свой округлившийся живот, словно изучая вашу реакцию, пока насосы доят ваш {pc.breasts}")
			saynn("[say=eliza]Может, мне стоит попробовать это попозже...")
		else:
			saynn("[say=eliza]Хорошая коровка~. Хочу услышать, как ты мычишь для меня.[/say]")

		saynn("Ты подаешься вперед и непроизвольно издаешь милое «му», а в голове начинает все туманиться. Наслаждение от дойки переполняет твой разум; ты ерзаешь и виляешь попой, пока насосы беспокойно выкачивают {pc.milk} из твоих {pc.breasts}.")

		# (if has pussy)
		if(GM.pc.hasVagina()):
			saynn("Твоя мокрая киска заставляет тебя чувствовать себя жаждущей; ты оглядываешься по сторонам, надеясь, что где-то здесь есть бык, который трахнет тебя до беспамятства. Влага стекает из твоей щели, образуя под тобой маленькую лужицу. Ты кончила, но оргазм просто растворился в этом море удовольствия..")

		saynn("Блядь, как же жарко, когда тебя доят, словно какое-то фермерское животное. Никаких мыслей... Никаких сложных решений... Ты чувствуешь, как разум погружается в блаженство... Просто стой смирно и позволяй себя интенсивно доить, это ведь именно то, чего ты хочешь прямо сейчас... Ты открываешь рот и высовываешь язык, стоная и тяжело дыша, каждые несколько секунд у тебя вырывается мычание, а в глазах читается похоть и вожделение. Ты даже не замечаешь, что доктор отошел по делам, ты просто хочешь, чтобы это продолжалось.")

		addButton("Мууу", "Отдайся этому полностью..", "moo")

	if(state == "moo"):
		saynn("Время идет.. Кто знает, сколько.. Всё, что ты слышишь, это звук насосов, сосков которых всасываются в твой {pc.breasts}, замедляющийся по мере того, как у них начинает садиться заряд. Ты пускаешь слюни и мычишь, чувствуя полную отрешенность.")

		saynn("В конце концов возвращается доктор. Она щелкает пальцами прямо перед твоим лицом.")

		saynn("[say=eliza]О да, посмотри на себя. Такая шлюшка, обожающая доение. Ну-ка, посмотрим...[/say]")

		saynn("Элиза выключает насосы и проверяет, сколько молока ты выдала.")

		# (if less < 400)
		if(howMuchMilked < 400.0):
			saynn("[say=eliza]Не так уж много, хм. Может, тебе нужны дыньки побольше?[/say]")

		# (if > 400)
		elif(howMuchMilked < 900.0):
			saynn("[say=eliza]Неплохо. Сойдет.[/say]")

		# (if a lot)
		else:
			saynn("[say=eliza]О, мило, очень хорошо. Хватит, чтобы получить неплохую прибыль.[/say]")

		saynn("Ты стонешь, когда она снимает молокоотсосы — соски становятся невероятно чувствительными. Тебе трудно стоять, не держась за что-нибудь; Элиза пристегивает поводок к твоему ошейнику и выводит тебя наружу.")

		# (if clothed)
		if(!GM.pc.isFullyNaked()):
			saynn("Она также хватает твою одежду и протягивает тебе.")

		saynn("[say=eliza]Ты быстро придешь в себя. Я уверена~. Пошли, коровка.[/say]")

		saynn("[say=pc]Му-у..[/say]")

		addButton("Следовать", "Му-у-у...", "follow1")

	if(state == "follow1"):
		aimCamera("med_nearmilking")
		setLocationName("Коридор")
		GM.pc.setLocation("med_nearmilking")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
		saynn("Элиза выводит тебя из доильного зала и отпускает.")

		saynn("[say=eliza]Пойду я, у меня смена ещё не закончилась. Просто ищи выход.[/say]")

		saynn("Элиза слегка шлепает тебя и уходит своей дорогой.")

		# (scene ends)
		addButton("Продолжить", "Пора идти", "endthescene")
		


func _react(_action: String, _args):
	if(_action == "follow"):
		runScene("ParadedOnALeashScene", ["eliza", GM.pc.getLocation(), "med_milkingroom", [
			"Almost there, inmate",
			"Feeling excited? You should be~",
			"Thanks for participating in our program, inmate",
			"We have the best milking equipment and staff here~",
			"The leash is for your own safety, really~",
		]])
	
	if(_action == "get_milked"):
		GM.pc.orgasmFrom("eliza")
	
	if(_action == "moo"):
		setModuleFlag("MedicalModule", "Med_wasMilkedToday", true)
		processTime(60*60)
		howMuchMilked = GM.pc.milk()
		
		increaseModuleFlag("MedicalModule", "Med_milkMilked", howMuchMilked)
		increaseModuleFlag("MedicalModule", "Med_milkedMilkTimes")
		GM.main.SCI.handleBountyFluid(GM.pc.getFluidType(FluidSource.Breasts), howMuchMilked)
		
		addMessage(str(round(howMuchMilked / 10.0)*10.0)+" из твоей груди было подоено мл молока")

		GM.pc.addSkillExperience(Skill.Milking, 80, "eliza_milkingpumps")
		
		if(howMuchMilked >= 400.0):
			var credits = Util.maxi(1, int(floor(sqrt(howMuchMilked / 100.0) / 2.0)))
			GM.pc.addCredits(credits)
			addMessage("Вы получили "+str(credits)+" work "+Util.multipleOrSingularEnding(credits, "credit")+"!")

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["howMuchMilked"] = howMuchMilked
	
	return data
	
func loadData(data):
	.loadData(data)
	
	howMuchMilked = SAVE.loadVar(data, "howMuchMilked", 0.0)
