extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MentalShower"

func _run():
	if(state == ""):
		addCharacter("eliza")
		
	if(state == ""):
		saynn("Элиза входит в твою камеру и опускается перед тобой на корточки. Она хватает поводок и пытается пристегнуть его к твоему ошейнику.")

		saynn("[say=eliza]"+RNG.pick([
			"Shower time~.",
			"Let’s get you showered.",
			"Follow me to the shower.",
		])+"[/say]")

		addButton("Душ!", "Идти за Элизой", "shower!")
		addButton("Сопротивляться", "Кто знает, что она с тобой сделает, так что душ тебе нахрен не сдался. Поведение—", "resist")

	if(state == "resist"):
		saynn("Ты тихо рычишь и отпихиваешь её ногой. Элиза отпрядывает и фыркает.")

		saynn("[say=eliza]Ладно, так и сиди. Посмотрим, насколько мне будет не плевать.[/say]")

		saynn("Элиза выходит из камеры и закрывает дверь.")

		# (scene ends)
		addButton("Продолжить", "Ооооу", "endthescene")
		

	if(state == "shower!"):
		aimCamera("medical_shower")
		playAnimation(StageScene.Solo, "walk")
		setLocationName("Shower")
		
		saynn("Она приводит тебя в душевую. Безликий серый пол, плитка на стенах и несколько рядов душевых леек.")

		saynn("[say=eliza]В смирительной рубашке в душ не пустят, так что я её сниму, ладно?[/say]")

		saynn("Ты стоишь неподвижно, ожидая, когда твои руки освободят. Ты поспешно прикрываешься.")

		saynn("[say=eliza]Тебя уже нечем удивить~[/say]")

		saynn("Она откладывает смирительную рубашку в сторону и включает тебе один из душей; вода кажется приятно теплой.")

		# (if bad behavior)
		if(getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0) < 0.4):
			if(getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0) < 0.2):
				saynn("[say=eliza]Раз уж ты такой капризный подопытный, я буду приглядывать за тобой, чтобы ты не натворил дел.[/say]")
			else:
				saynn("[say=eliza]Я тебе не особо доверяю, так что буду смотреть на тебя во все глаза, чтобы ты не устроил беспорядок.[/say]")
			addDisabledButton("Попросить отвернуться", "Ты ведешь себя недостаточно хорошо, чтобы просить о таком")
		else:
			addButton("Попросить отвернуться", "Ты не хочешь, чтобы Элиза наблюдала за тобой", "ask_to_look_away")
		addButton("Позволить наблюдать", "Элиза будет наблюдать за тем, как ты принимаешь душ", "be_watched")
		addButtonWithChecks("Показать", "Устроить Элизе небольшое шоу", "show", [], [[ButtonChecks.SkillCheck, Skill.Exhibitionism, 2]])

	if(state == "ask_to_look_away"):
		playAnimation(StageScene.Showering, "body", {pc="pc", bodyState={naked=true}})
		
		saynn("[say=pc]Может, не будешь смотреть?[/say]")

		saynn("[say=eliza]Конечно, раз уж ты так мило просишь.[/say]")

		saynn("Элиза отворачивается и ждет, пока ты закончишь. Ты встаешь под душ и начинаешь мыться. Волосы, лицо, плечи, {pc.breasts}твое {pc.masc} тело. Ты также быстро обмываешь свои причиндалы. Это очень освежает.")

		addButton("Стибрить ключ-карту", "Попытаться обчистить карманы Элизы; чем лучше ты себя ведешь, тем выше шансы. (Текущий шанс: "+str(round(calculateStealChance()*10.0)/10.0)+"%)", "steal_keycard")
		addButton("Помыться внутри", "Вымыть всё, что у тебя внутри дырок", "clean_inside")
		addButton("Готово", "Ты закончил принимать душ", "done")
		
	if(state == "steal_keycard_failed"):
		playAnimation(StageScene.Duo, "defeat", {npc="eliza"})
		# (if failed)

		saynn("Вы подкрадываетесь к врачу и пытаетесь стащить ключ-карту, висящую у неё на поясе.")

		saynn("Но как только вы пытаетесь её схватить, она оборачивается и перехватывает вашу руку. Вид у неё явно не радостный. Не проходит и секунды, как она нажимает кнопку на пульте, посылая мощный разряд тока через ваш ошейник. Вы хватаетесь за горло и падаете на колени. Ой!")

		saynn("[say=eliza]Это была очень плохая идея, заключенная.[/say]")

		saynn("Элиза прижимает вас к полу и силой натягивает смирительную рубашку. Затем она надевает на вас поводок и заталкивает обратно в камеру, чтобы вы могли хорошенько обдумать своё поведение.")

		# (scene ends)
		addButton("Продолжить", "Ой-ой!", "endthescene")

		# (if succ)
	if(state == "steal_keycard_succ"):
		saynn("Вы подкрадываетесь к врачу и пытаетесь стащить ключ-карту, висящую у неё на поясе.")

		saynn("Шум воды заглушает лишние звуки, а благодаря вашему «хорошему» поведению Элиза не так внимательна, как обычно. Вам удается выхватить её ключ-карту и спрятать её... где-то.")

		addButton("Помыться внутри", "Вымыть всё, что у тебя внутри дырок", "clean_inside")
		addButton("Готово", "Ты закончил принимать душ", "done")

	if(state == "clean_inside"):
		playAnimation(StageScene.Showering, "crotch", {pc="pc", bodyState={naked=true}})
		# (if has pussy)
		if(GM.pc.hasVagina()):
			saynn("Вы раздвигаете свои {pc.pussyStretch} губки и ждете, не выйдет ли чего. Всё быстро утекает в слив. Затем вы делаете то же самое со своей задницей. По крайней мере, вам не приходится делать это под присмотром Элизы.")

		# (else)
		else:
			saynn("Вы раздвигаете задницу и ждете, не выйдет ли чего из вашей {pc.analStretch}. Всё быстро утекает в слив. По крайней мере, вам не приходится делать это под присмотром Элизы.")

		addButton("Готово", "Ты закончил принимать душ", "done")

	if(state == "done"):
		saynn("Вы выключаете воду, подходит Элиза и снова надевает на вас смирительную рубашку. Затем она цепляет поводок и ведет вас обратно в камеру.")

		# (scene finished)
		addButton("Продолжить", "Ты чувствуешь свежесть", "endthescene")
		

	if(state == "be_watched"):
		playAnimation(StageScene.ShoweringDuo, "tease", {pc="pc", npc="eliza", bodyState={naked=true}})

#ACEOREGEXPAC - Experiments Shower has a few lines for being heavily pregnant
		if(GM.pc.isHeavilyPregnant()):
			saynn("Ты встаешь под душевую лейку и начинаешь мыться. Волосы, лицо, плечи, {pc.breasts}, твое {pc.masc} тело. Ты не можешь прикрываться вечно, так что Элизе удается мельком увидеть твои интимные места.")
			saynn("Из-за того, насколько тяжелым и обременительным стало твое чрево, тебе приходится хорошенько потянуться и размять живот. Все в порядке, дело не в том, что ты не можешь этого сделать, просто это занимает больше времени, но взгляд Элизы остается прикованным к твоему натянутому животу, пока ты возишься.")
		else:
			saynn("Ты встаешь под душевую лейку и начинаешь мыться. Волосы, лицо, плечи, {pc.breasts}, твое {pc.masc} тело. Ты не можешь прикрываться вечно, так что Элизе удается мельком увидеть твои интимные места.")

		addButton("Помыться внутри", "Вымыть всё, что у тебя внутри дырок", "clean_inside1")
		addButton("Готово", "Ты закончил принимать душ", "done1")

	if(state == "clean_inside1"):
		# (if has pussy)
		if(GM.pc.hasVagina()):
			saynn("Ты раздвигаешь свои {pc.pussyStretch} губки киски и ждешь, не выйдет ли что-нибудь. Все быстро уходит в слив. Затем ты делаешь то же самое с задницей. Элиза ухмыляется, наблюдая за этим, отчего ты краснеешь.")

		# (else)
		else:
			saynn("Ты раздвигаешь задницу и ждешь, не выйдет ли что-нибудь из твоей {pc.analStretch}. Все быстро уходит в слив. Элиза ухмыляется, наблюдая за этим, отчего ты краснеешь.")

		addButton("Готово", "Ты закончил принимать душ", "done1")

	if(state == "done1"):
		saynn("Вы выключаете воду, подходит Элиза и снова надевает на вас смирительную рубашку. Затем она цепляет поводок и ведет вас обратно в камеру.")

		# (scene end)
		addButton("Продолжить", "Ты чувствуешь свежесть", "endthescene")
		
#ACEPREGEXPAC - experiments shower lines for being heavily pregnant
	if(state == "show"):
		saynn("Заметив пристальный взгляд Элизы, ты решаешь устроить для нее небольшое представление: ты встаешь под душ и начинаешь медленно покачивать {pc.masc} бедрами из стороны в сторону. Зачерпнув ладонями воду, ты проводишь ими по своему {pc.thick} телу, скользя по {pc.breasts}, а затем слегка шлепаешь себя по заднице. Ты замечаешь, как Элиза приподнимает бровь.")

		# (if has pussy and cock)
		if(GM.pc.hasVagina() && GM.pc.hasPenis()):
			saynn("Ты решаешься на смелый шаг и наклоняешься вперед, широко расставив ноги"+str("showing the underside of your heavy pregnancy between your legs" if GM.pc.isHeavilyPregnant() else "")+"и демонстрируя Элизе во всей красе твое {pc.analStretch} анусное кольцо, {pc.pussyStretch} киску и {pc.cock} — полный комплект!")

		# (if has just pussy)
		elif(GM.pc.hasVagina()):
			saynn("Ты решаешься на смелый шаг и наклоняешься вперед, широко расставив ноги"+str("showing the underside of your heavy pregnancy between your legs" if GM.pc.isHeavilyPregnant() else "")+"и демонстрируя Элизе во всей красе твое {pc.analStretch} анусное кольцо и {pc.pussyStretch} киску, все твои девчачьи местечки!")

		# (if just cock)
		elif(GM.pc.hasPenis()):
			saynn("Ты решаешься на смелый шаг и наклоняешься вперед, широко расставив ноги"+str("showing the underside of your heavy pregnancy between your legs" if GM.pc.isHeavilyPregnant() else "")+"и демонстрируя Элизе во всей красе твое {pc.analStretch} анусное кольцо и {pc.cock}, все твои запчасти!")

		# (else)
		else:
			saynn("Ты решаешься на смелый шаг: наклоняешься вперед, широко расставляя ноги,"+str("showing the underside of your heavy pregnancy between your legs" if GM.pc.isHeavilyPregnant() else "")+"и демонстрируя Элизе во всей красе твое {pc.analStretch} анусное кольцо, все твои интимные места!")

		saynn("Элиза кажется совершенно шокированной; ты оглядываешься и видишь, как она краснеет. Ты тихонько посмеиваешься и начинаешь сильнее покачивать своей {pc.thick} задницей перед ней, делая вид, что моешься, пока вода стекает по твоей спине.")

		# (if has pussy)
		if(GM.pc.hasVagina()):
			saynn("Ты даже раздвигаешь киску перед ней, просто чтобы окончательно сбить её с толку и показать, что не боишься выставлять свое тело напоказ.")

		# (if has cock)
		if(GM.pc.hasPenis()):
			if(GM.pc.isWearingChastityCage()):
				saynn("Ты даже воровато потираешь свою клетку, пока твой член не встает колом прямо внутри целомудрия.")
			else:
				saynn("Ты даже воровато ласкаешь себя, пока твой {pc.cock} не станет полностью твердым.")

		saynn("[say=eliza]Должна сказать, ты та еще штучка![/say]")

		saynn("Ты хихикаешь и выпрямляешься, продолжая мыться.")

		addButton("Готово", "Ты закончил принимать душ", "done2")

	if(state == "done2"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Вы выключаете воду, подходит Элиза и снова надевает на вас смирительную рубашку. Затем она цепляет поводок и ведет вас обратно в камеру.")
		
		addButton("Продолжить", "Ты чувствуешь свежесть", "endthescene")

func _react(_action: String, _args):
	if(_action == "shower!"):
		runScene("ParadedOnALeashScene", ["eliza", GM.pc.getLocation(), "medical_shower", [
			"Almost there, patient",
		]])

	if(_action in ["clean_inside", "clean_inside1"]):
		GM.pc.clearOrificeFluids()
		processTime(60 * 10)

	if(_action in ["ask_to_look_away" , "be_watched", "show"]):
		GM.pc.afterTakingAShower()
		processTime(60 * 10)
		
		addMessage("You feel fresh and clean")
		
		if(_action == "be_watched"):
			GM.pc.addSkillExperience(Skill.Exhibitionism, 10)
		if(_action == "clean_inside1"):
			GM.pc.addSkillExperience(Skill.Exhibitionism, 10)
		if(_action == "show"):
			MedicalModule.addPCBehavior(0.05)
			GM.pc.addSkillExperience(Skill.Exhibitionism, 40)

	if(_action == "resist"):
		MedicalModule.addPCBehavior(-0.1)

	if(_action == "steal_keycard"):
		
		if(!RNG.chance(calculateStealChance())):
			setState("steal_keycard_failed")
			MedicalModule.addPCBehavior(-0.7)
		else:
			setState("steal_keycard_succ")
			setModuleFlag("MedicalModule", "Mental_HasKeycard", true)
		return

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func calculateStealChance():
	var result = -30.0 + getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0) * 130.0 + GM.pc.getStat(Stat.Agility) * 2.0
	
	return clamp(result, 0.0, 100.0)
