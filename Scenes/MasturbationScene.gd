extends "res://Scenes/SceneBase.gd"

var savedActionText = ""
var spottedText = ""
var isInPublic = false

func _reactInit():
	var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
	if(lustCombatState.isInPublic()):
		isInPublic = true

func _init():
	sceneID = "MasturbationScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		if(GM.pc.getLocation() == GM.pc.getCellLocation()):
			#(if in cell)
			if(RNG.chance(50)):
				saynn("Ты оглядываешься по сторонам: кажется, камера довольно уединенная, и ты в безопасности, пока никто не подглядывает через армированное окно. Но эта мысль лишь разжигает твое желание. Ты чувствуешь, что чертовски возбужден, и, пожалуй, сейчас самое время немного снять напряжение...")
			else:
				saynn("Ты стоишь в своей камере один. Снаружи полно заключенных, но, кажется, никто не обращает внимания на окно, так что, если будешь осторожен, тебя не заметят. Может, стоит немного напоказ выставить свое хозяйство, пока никто не видит?..")
		elif(!lustCombatState.isInPublic()):
			#(if in private place)
			if(RNG.chance(50)):
				saynn("Ты осматриваешься. Вокруг почти тихо. В твоей похотливой голове внезапно промелькнула мысль о чем-то неприличном. Это не твоя камера, но это место находится в стороне, так что ты в безопасности, если будешь действовать быстро и тебя не заметят. Ты немного проходишься, проверяя, нет ли кого рядом; твое лицо уже начинает слегка краснеть от предвкушения.")
			
				saynn("[say=pc]Есть тут кто?[/say]")
			else:
				saynn("Пока ты стоишь в этой комнате, тебя накрывают волны похоти. Это общественное место, но сейчас вокруг никого нет — твой шанс. И даже если кто-то застанет тебя врасплох, возможно, в этом будет только плюс...")
				
				saynn("[say=pc]Немного уединения. Хорошо...[/say]")
		else:
			#(if in public place)
			if(GM.pc.getSkillLevel(Skill.Exhibitionism) < 1):
				saynn("Ты оглядываешься по сторонам: вокруг полно народу. Любая пошлая выходка наверняка привлечет чье-то внимание... Но ты чувствуешь, как внутри всё горит от возбуждения, и мысль о том, чтобы дразнить себя на людях, кажется невероятно горячей... Главное — не спалиться... Ты немного проходишься, пытаясь найти место получше и стараясь не привлекать лишних взглядов. Руки скользят по твоим изгибам, а лицо уже заливается краской...")
				
				if(GM.pc.getExposedPrivates().size() > 0):
					saynn("Твое лицо краснеет еще сильнее, пока ты пытаешься как можно лучше прикрыть свои обнаженные прелести. [b]Тебе не хватает смелости, чтобы заняться чем-то сексуальным.[/b]")
				
				saynn(RNG.pick([
					"[say=pc]Что же я делаю..[/say]",
					"[say=pc]Может, стоит остановиться.. Но..[/say]",
					"[say=pc]Меня же заметят.. Нельзя..[/say]",
				]))
			elif(GM.pc.getSkillLevel(Skill.Exhibitionism) < 2):
				saynn("Это общественное место, вокруг люди, занятые своими делами. Ты гадаешь, как много тебе сойдет с рук; мысль о том, чтобы выставиться напоказ, проносится в голове, и ты не можешь ей сопротивляться — возбуждение уже нарастает. Если будешь осторожна, люди тебя даже не заметят... А может, ты как раз хочешь, чтобы они заметили... Ты не хочешь прятаться и решаешь оставаться почти на виду — как рискованно...")
				
				saynn(RNG.pick([
					"[say=pc]Самой себе не верю..[/say]",
					"[say=pc]Почему мне этого так хочется..[/say]",
					"[say=pc]Почему это так приятно..[/say]",
				]))
			else:
				saynn("Мысль о том, чтобы заняться чем-то непристойным на людях, безумно тебя заводит. Вокруг полно народу, но тебе плевать на них — ты слишком возбуждена!")
				
				saynn("У тебя так и чешутся руки начать раздеваться, а может, и не только. После всей этой практики ты чувствуешь себя очень уверенно, демонстрируя свое тело. Щеки горят, и тебе не терпится поскорее начать.")
				
				saynn(RNG.pick([
					"[say=pc]Как же хочется потрогать себя..[/say]",
					"[say=pc]Все смотрят.. И хорошо.[/say]",
					"[say=pc]Интересно, сколько времени пройдет, прежде чем меня заметят~.[/say]",
				]))
			
	if(state == "doLustAction"):
		saynn(savedActionText.trim_suffix("\n\n"))
		
		if(spottedText != ""):
			saynn(spottedText)
				
	if(state == "" || state == "doLustAction"):
		addButtonAt(13, "Ничего не делать", "Стараться не привлекать внимания", "doidle")
		addButtonAt(14, "Стой", "Хватит уже течь", "endthescene")
		
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
	
		addLustActionsButtons(lustCombatState, lustCombatState.getActionsSorted())

		for activity in lustCombatState.getAllText():
			sayn(activity)
		
		if(lustCombatState.isInPublic()):
			var visibility = lustCombatState.getVisibility()
			if(visibility >= 1.0):
				sayn("\nВидимость: Тебя видно всем!")
			elif(visibility >= 0.9):
				sayn("\nВидимость: Ты почти уверена, что на тебя смотрят...")
			elif(visibility >= 0.6):
				sayn("\nВидимость: У тебя такое чувство, будто за тобой наблюдают...")
			elif(visibility >= 0.3):
				sayn("\nВидимость: Тебе кажется, что за тобой никто не смотрит")
			else:
				sayn("\nВидимость: Ты почти уверена, что тебя никто не видит")
			
			var danger = lustCombatState.getDanger()
			if(danger > 0.0):
				if(danger >= 0.8):
					sayn("Опасность: Люди буквально тянутся к тебе, чтобы пощупать")
				elif(danger >= 0.5):
					sayn("Опасность: Вокруг тебя толпятся люди, осторожнее!")
				elif(danger >= 0.2):
					sayn("Опасность: Повсюду какие-то случайные люди, они наблюдают за тобой")
				else:
					sayn("Опасность: Опасности нет")
		
	if(state == "lustCombatAboutToCum"):
		saynn(savedActionText)
		
		saynn("Ты вот-вот кончишь...")
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		addLustActionsButtons(lustCombatState, lustCombatState.getOrgasmActionsSorted())
		
	if(state == "lustCombatAfterCame"):
		saynn(savedActionText)
		
		addButton("Продолжить", "Ты еще не закончила", "")
		addButton("Стой", "На сегодня хватит...", "endthescene")

func addLustActionsButtons(lustCombatState:LustCombatState, theActions):
	for actionData in theActions:
		var lustAction:LustAction = GlobalRegistry.getLustAction(actionData["id"])
		
		if(!lustAction.shouldShow(lustCombatState, actionData)):
			continue
		var canDo = lustAction.canDo(lustCombatState, actionData)
		var reasonWhyCant = "You can’t do this right now"
		if(canDo is Array):
			if(canDo.size() > 1):
				reasonWhyCant = canDo[1]
			canDo = canDo[0]
		
		if(canDo):
			addButton(lustAction.getVisibleName(lustCombatState, actionData), lustAction.getVisibleDescription(lustCombatState, actionData), "doLustAction", [actionData])
		else:
			addDisabledButton(lustAction.getVisibleName(lustCombatState, actionData), reasonWhyCant)
	

func _react(_action: String, _args):
	if(_action == "endthescene"):
		GM.pc.getLustCombatState().resetState()
		endScene()
		return
	
	if(_action == "doidle"):
		processTime(30)
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		
		lustCombatState.processLewdTurn()
		
		savedActionText = "You decide to idle for a bit"
		#GM.pc.addLust(-1)
		
		checkDanger()
		spottedMessages()
		
		setState("doLustAction")
		return
	
	if(_action == "doLustAction"):
		processTime(30)
		
		var actionData = _args[0]
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		
		var result = lustCombatState.doAction(actionData)
		savedActionText = result["text"]
		if("lust" in result):
			GM.pc.addLust(result["lust"] * 4)
			if(GM.pc.getLustLevel() >= 1.0 && ("cantCum" in result) && result["cantCum"]):
				GM.pc.addLust(-1)
		if("pain" in result):
			GM.pc.addPain(result["pain"])
		
		if("came" in result):
			lustCombatState.stopActivities()
			setState("lustCombatAfterCame")
			return
		
		if(GM.pc.getLustLevel() >= 1.0):
			setState("lustCombatAboutToCum")
			return
			
		checkDanger()
		spottedMessages()
		
	setState(_action)

func spottedMessages():
	spottedText = ""
	
	var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
	if(lustCombatState.isInPublic()):
		if(lustCombatState.getVisibility() < 1.0):
			
			if(RNG.chance(50)):
				return
			
			var barks = [
				"Your heart races, you swear you saw someone’s eyes watching you.",
				"You look around frantically, constantly checking if someone sees you.",
				"You can’t believe that you are doing this, you feel like you could be spotted at any second.",
				"What if someone is watching?.. Just thinking about it makes you more aroused.",
				"You wonder how far you can push this before being spotted..",
			]
			
			spottedText = RNG.pick(barks)
			return
		
		if(lustCombatState.getDanger() > 0):
			var population = GM.pc.getLocationPopulation()
			if(population.size() <= 0 || RNG.chance(50)):
				return
			
			var randomPop = RNG.pick(population)
			if(randomPop == WorldPopulation.Inmates):
				var randI = RNG.randi_range(0, 5)
				match(randI):
					0:
						spottedText = "You catch a lewd gaze of one of the inmates that stares at you and your {pc.masc} body."
					1:
						spottedText = "One of the inmates exposes his canine cock and starts stroking himself while watching the show that you’re offering."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayMale]Да, тряси этой задницей![/sayMale]",
							"[sayMale]Ну и шлюшка![/sayMale]",
							"[sayMale]Не останавливайся, сучка. Устрой нам шоу.[/sayMale]",
						])
					2:
						spottedText = "A group of inmates turn around and catch the glimpses of your hands doing lewd things."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayMale]Глянь на {pc.him}, может, поможем ей?[/sayMale]",
							"[sayMale]Охренеть, {pc.he} {pc.isAre} так и тянет оттрахать {pc.him}.[/sayMale]",
							"[sayFemale]Пацаны могут делать с этой жопой что угодно, но лицо {pc.his} принадлежит мне~.[/sayFemale]",
						])
					3:
						spottedText = "One of the inmate girls walks past and then spots what you are doing before taking a step back, blushing."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayFemale]Э-эй, так нельзя![/sayFemale]",
							"[sayFemale]М-м.. виновата.[/sayFemale]",
						])
					4:
						spottedText = "An inmate creeps closer to you and watches you play with yourself, smiling."
					5:
						spottedText = "You notice the eyes of many inmates attached to you, it seems you are attracting quite an audience."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayMale]Я хочу первым трахнуть {pc.him}![/sayMale]",
							"[sayMale]Эта задница такая {pc.thick}, так и хочется её растянуть.[/sayMale]",
							"[sayMale]Эй, гляньте, какая шлюха выставляет свою {pc.herself} напоказ![/sayMale]",
							"[sayFemale]Милая, почему бы тебе не вылизать меня?[/sayFemale]",
							"[sayFemale]Ну и шлюха![/sayFemale]",
						])
			if(randomPop == WorldPopulation.Guards):
				var randI = RNG.randi_range(0, 7)
				match(randI):
					0:
						spottedText = "One of the staff members glances at you. You quickly turn away but you’re almost certain he saw you doing something lewd."
					1:
						spottedText = "A staff member walks past and sees you. She rolls her eyes and leaves you to your things."
					2:
						spottedText = "A few staff members walk past but one of them stops and stares at you."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayMale]Эй, может, пойдем проучим {pc.him}?[/sayMale]",
							"[sayMale]Посмотрите на эту шлюху.[/sayMale]",
							"[sayFemale]Эй, прекращай, а то придется применить силу.[/sayFemale]",
						])
					3:
						spottedText = "One of the guards sees your actions and starts walking towards you with a stun baton in his hand. Luckily, he stops to watch you some more."
					4:
						spottedText = "One of the female staff members raises her brow at you."
						spottedText += "\n\n"
						spottedText += RNG.pick([
							"[sayFemale]Ты что, сирень? Это бы всё объяснило.[/sayFemale]",
							"[sayFemale]Кто-то так и просит, чтобы его наказали.[/sayFemale]",
							"[sayFemale]Эй, только не ной потом, когда тебя начнут передавать из рук в руки.[/sayFemale]",
							"[sayFemale]Кто-то разгорячился, а~?[/sayFemale]",
						])
					5:
						spottedText = "Staff starts crowding around you but that only makes you more eager, you’ve been spotted."
					6:
						spottedText = "A guard sneaks a hand under his crotch armor piece and clearly strokes himself while watching you."
					7:
						spottedText = "One of the staff members walks past and pretends to not see what you are doing."
						
	

func checkDanger():
	var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
	var newDanger = lustCombatState.getDanger()
	if(lustCombatState.isInPublic() && newDanger >= 1.0):
		print("SPOTTED")
		lustCombatState.resetDanger()
		var population = GM.pc.getLocationPopulation()
		if(population.size() > 0):
			var randomPop = RNG.pick(population)
			var triggerID
			if(randomPop == WorldPopulation.Inmates):
				triggerID = Trigger.MasturbationSpottedInmate
			if(randomPop == WorldPopulation.Guards):
				triggerID = Trigger.MasturbationSpottedGuard
			
			if(triggerID != null && GM.ES.triggerReact(triggerID)):
				GM.pc.getLustCombatState().resetState()
				endScene()

func resolveCustomCharacterName(_charID):
	if(_charID == "attacker"):
		return "pc"
	
	return null

func saveData():
	var data = .saveData()
	
	data["savedActionText"] = savedActionText
	data["isInPublic"] = isInPublic
	data["spottedText"] = spottedText
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedActionText = SAVE.loadVar(data, "savedActionText", "")
	isInPublic = SAVE.loadVar(data, "isInPublic", false)
	spottedText = SAVE.loadVar(data, "spottedText", "")
