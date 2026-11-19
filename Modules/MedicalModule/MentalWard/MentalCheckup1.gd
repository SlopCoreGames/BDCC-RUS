extends "res://Scenes/SceneBase.gd"

var savedBehavior = 0.0

func _init():
	sceneID = "MentalCheckup1"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
	if(state == ""):
		saynn("Вы слышите статический шум — включается интерком.")

		# (if best behaviour)
		if(getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0) >= 0.8):
			saynn("[say=eliza]Как поживает моя милашка?[/say]")

			saynn("[say=pc]Да, у меня всё хорошо.[/say]")

		# (if medium behaviour)
		elif(getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0) >= 0.3):
			saynn("[say=eliza]Ну как успехи, подопытный?[/say]")

			saynn("[say=pc]Я в порядке.[/say]")

		# (if bad behaviour)
		else:
			saynn("[say=eliza]Будешь сегодня вести себя хорошо, заключенная? Ты там?[/say]")

			saynn("[say=pc]Конечно, без проблем.[/say]")

		saynn("[say=eliza]Сейчас открою дверь, только отойди от неё подальше.[/say]")

		saynn("Элиза заглядывает в маленькое окошко, чтобы убедиться, что вы на месте, а затем запускает процесс открытия двери. Механизм громоздкий, поэтому требуется время, чтобы отщелкнуть все замки, после чего включаются основные моторы, и дверь медленно отъезжает, открывая вид на коридор, где в дверном проеме стоит Элиза.")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue")

	if(state == "continue"):
		saynn("[say=eliza]Давай проверим твое поведение. Я не могу позволить непокорным подопытным приближаться к оборудованию.[/say]")

		saynn("Элиза входит в камеру; на ней привычный белый халат, длинная юбка и зеленый топ. У нее пальцеходящая походка, на босых ногах — крупные звериные пальцы, а бедра скрыты черными прозрачными чулками. Она потягивает кофе — очевидно, это часть ее ежедневной рутины.")

		saynn("Доктор наблюдает за тобой. Ты сидишь у стены, беспомощный в своей смирительной рубашке. Она поправляет очки и расплывается в лукавой ухмылке.")

		saynn("[say=eliza]Поползи ко мне. Преклонись передо мной.[/say]")

		addButton("Повиноваться", "Сделать, как она приказала. Поведение+", "obey")
		addButton("Отказаться", "Ты не собираешься этого делать! Поведение-", "refuse")

	if(state == "refuse"):
		saynn("Ты качаешь головой.")

		saynn("[say=pc]Я не буду этого делать.[/say]")

		# (if was good behavior)
		if(savedBehavior >= 0.8):
			saynn("[say=eliza]Почему же? Моя милашка капризничает? Ну что ж, тогда никаких вкусняшек.[/sat]")

		# (if medium)
		elif(savedBehavior >= 0.3):
			saynn("[say=eliza]Какое разочарование. Видимо, поглаживаний по голове ты не хочешь.[/say]")

		# (if bad behaviour)
		else:
			saynn("[say=eliza]Так и знала. Слишком упрямая.[/say]")

		saynn("[say=eliza]Теперь проверю остальных. А ты сиди здесь и не рыпайся.[/say]")

		saynn("Элиза оставляет тебя в одиночестве и нажимает на кнопку, чтобы закрыть дверь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "obey"):
		playAnimation(StageScene.Duo, "kneel", {npc="eliza"})
		
		saynn("Ты ложишься на пол и подползаешь к ногам Элизы. Она ухмыляется, наблюдая за твоими мучениями со связанными руками. Опершись о ближайшую стену, ты встаешь на колени и склоняешь голову, демонстрируя покорность.")

		saynn("[say=eliza]Очень хорошо~.[/say]")

		saynn("Элиза наклоняется и кладет руку тебе на голову. Она гладит тебя, почесывая за ушком.")

		saynn("[say=eliza]А теперь пойду проверю остальных.[/say]")

		saynn("Элиза выходит из камеры и нажимает на кнопку, чтобы закрыть дверь.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):

	if(_action == "refuse"):
		savedBehavior = getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0)
		
		MedicalModule.addPCBehavior(-0.1)
		
	if(_action == "obey"):
		MedicalModule.addPCBehavior(0.05)

	if(_action == "endthescene"):
		endScene()
		return

	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["savedBehavior"] = savedBehavior
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedBehavior = SAVE.loadVar(data, "savedBehavior", 0.0)
