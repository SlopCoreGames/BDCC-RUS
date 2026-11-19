extends "res://Scenes/SceneBase.gd"

var gotPayed = false

func _init():
	sceneID = "BullyGangScene"

func _run():
	if(state == ""):
		addCharacter("gymbully")
		addCharacter("gymbully2")
		addCharacter("gymbully3")
		playAnimation(StageScene.Duo, "stand", {npc="gymbully"})

	if(state == ""):
		# (if first time)
		if(!getModuleFlag("GymModule", "Gym_BullyGangIntroduced")):
			setModuleFlag("GymModule", "Gym_BullyGangIntroduced", true)
			
			saynn("Пока ты озираешься по сторонам в спортзале, раздумывая, чем бы заняться, к тебе со спины подходят трое заключенных. Двое парней и девчонка. Главный из них хлопает тебя по плечу. Ты слышишь хриплый мужской голос.")

			saynn("[say=gymbully]Эй, ты. Да-да, я с тобой разговариваю.[/say]")

			saynn("Ты оборачиваешься и видишь, что на всех надеты красные робы, а на головах — красные повязки; судя по всему, они из одной банды.")

			saynn("[say=gymbully]Раньше тебя здесь не видели. В курсе, как тут всё устроено?[/say]")

			saynn("Новичков они, похоже, не жалуют. Ты слегка качаешь головой.")

			saynn("[say=gymbully]Этой территорией рулим мы, малявка. И если хочешь здесь тусоваться, лучше плати. Официальная цена — 5 кредитов в день.[/say]")

			saynn("[say=pc]А если не захочу?[/say]")

			saynn("[say=gymbully]Тогда сваливаешь отсюда.[/say]")

			saynn("Девчонка огрызается тебе прямо из-за плеча главного.")

			# (if general inmate)
			if(GM.pc.getInmateType() == InmateType.General):
				saynn("[say=gymbully3]Всё верно, сучка из общего блока. Даже спусковой крючок нажать не смогла, чтобы заслужить красную робу?[/say]")

			# (if red inmate)
			elif(GM.pc.getInmateType() == InmateType.HighSec):
				saynn("[say=gymbully3]Давай, плати или съебывай, сучка.[/say]")

			# (if lilac)
			elif(GM.pc.getInmateType() == InmateType.SexDeviant):
				saynn("[say=gymbully3]Лучше заплати сейчас, пока тебя не разделили между всеми зэками здесь, сиреневая шлюшка.[/say]")
		
		# (if not the first time)
		else:
			saynn("К тебе подходят трое заключенных — те самые, которых ты помнишь. Они окружают тебя кольцом.")

			saynn("[say=gymbully]Ты сама знаешь, зачем мы здесь. Плати или проваливай.[/say]")

		if(GM.pc.getCredits() >= 5):
			addButton("Заплатить", "Ну, что тут поделаешь...", "pay")
		else:
			addDisabledButton("Заплатить", "Недостаточно кредитов")
		addButton("Запугивание", "Сказать им, что ты не собираешься ни платить, ни уходить", "intimidate")

	if(state == "pay"):
		saynn("Ты протягиваешь им чип с кредитами. Главный быстро проверяет его и убирает, после чего расплывается в улыбке.")

		saynn("[say=gymbully]Приятно иметь с тобой дело.[/say]")

		saynn("Троица отходит от тебя и отправляется донимать кого-то другого.")

		# (scene ends)
		addButton("Продолжить", "Вздох", "endthescene")

	if(state == "intimidate"):
		saynn("[say=pc]Я не уйду. И платить не собираюсь. Так что вали вместе со своими шестерками и не донимай меня.[/say]")

		saynn("Главный ухмыляется, остальные на тебя рычат.")

		saynn("[say=gymbully]Посмотрим, как ты запоешь, когда мы отъебнем твое смазливое личико.[/say]")

		addButton("Драться", "Пора драться", "fight")

	if(state == "if_won"):
		saynn("Члены банды быстро разбегаются, когда ты начинаешь вколачивать их лидера.")
		
		addButton("Продолжить", "Приятно", "endthescene")

	if(state == "if_lost"):
		saynn("Обессиленный, ты падаешь на колени. Бандиты валят тебя на землю и придавливают к ней, пока главный шарит по твоим карманам.")

		saynn("[say=gymbully]Полегче, дорогуша. Я не заберу всё до последней копейки.[/say]")

		# (if has 5 credits)
		if(gotPayed):
			saynn("Его рука находит в твоем кармане чип на 5 кредитов и забирает его.")

			saynn("[say=gymbully]Вот видишь. Наслаждайся. Пока что.[/say]")

		# (if not enough)
		else:
			saynn("Ему не удалось найти у тебя достаточно кредитов. Он вздыхает.")

			saynn("[say=gymbully]Мне даже почти жаль, что я забираю твои последние кредиты. Но с другой стороны, опыт стоит куда больше денег, не так ли?[/say]")


		addButton("Продолжить", "Ow", "endthescene")
		# (scene ends)

func _react(_action: String, _args):

	if(_action == "pay"):
		processTime(5 * 60)
		GM.pc.addCredits(-5)

	if(_action == "fight"):
		runScene("FightScene", ["gymbully"], "gymbullyfight")

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["gotPayed"] = gotPayed
	
	return data
	
func loadData(data):
	.loadData(data)
	
	gotPayed = SAVE.loadVar(data, "gotPayed", false)

func _react_scene_end(_tag, _result):
	if(_tag == "gymbullyfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(30)
		else:
			setState("if_lost")
			
			if(GM.pc.getCredits() >= 5):
				gotPayed = true
				GM.pc.addCredits(-5)
			else:
				gotPayed = false
			#addExperienceToPlayer(5)

func getDevCommentary():
	return "I was.. pretty out of it while writing this scene. That's why its so short and doesn't have any sex scenes and is kinda bad.\n\nThis scene is why I shouldn't write anything while I'm sad/depressed, heh. Should I remove it/rewrite it? Maybe. But to get rid of these bullies completely I would probably try to make a quest. Something about you and Nova teaming up and trying to destroy their gang.. or getting gangbanged x3 why not both"

func hasDevCommentary():
	return true
