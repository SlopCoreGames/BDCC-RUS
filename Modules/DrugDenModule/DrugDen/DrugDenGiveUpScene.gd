extends SceneBase

func _init():
	sceneID = "DrugDenGiveUpScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Ты уверен, что хочешь сдаться?")
		
		addButton("Сдаться", "Хватит исследовать", "do_give_up")
		addButton("Отмена", "Ты передумал!", "endthescene")

	if(state == "do_give_up"):
		playAnimation(StageScene.Solo, "kneel")

		saynn("Ты решаешь прекратить осмотр этого места и просто подождать...")
		
		saynn("В конце концов, голод и усталость берут своё, и ты уже не можешь держать глаза открытыми. Ты окончательно валишься с ног...")

		saynn("Последнее, что ты видишь — это какое-то синее свечение, окружающее тебя...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "stop_run")
	
	if(state == "stop_run"):
		playAnimation(StageScene.Sleeping, "sleep")
		addCharacter("eliza")
		aimCameraAndSetLocName("medical_hospitalwards")
	
		saynn("[say=eliza]Просыпайся, соня![/say]")
		
		saynn("Ты открываешь глаза... и понимаешь, что находишься где-то в медблоке.")
		
		saynn("[say=eliza]Наноботы сработали на ура! Пока ты дрых, я подлатала твои раны. И вот тебе маффин, ты же голодный как волк![/say]")
	
		saynn("Она протягивает тебе маффин. Ты съедаешь его мгновенно. На вкус это лучшее, что ты когда-либо пробовал в своей жизни.")
	
		saynn("[say=pc]Спасибо..[/say]")
		
		saynn("Она указывает на ящик тумбочки рядом с твоей больничной койкой.")
		
		saynn("[say=eliza]Все твои вещи там.[/say]")
		
		saynn("Вы встаете, хватаете свои вещи и готовитесь следовать за Элизой.")
		
		addButton("Следовать", "Посмотреть, куда она вас приведет", "back_to_lobby")
		
	if(state == "back_to_lobby"):
		GM.pc.setLocation("med_lobbymain")
		aimCameraAndSetLocName("med_lobbymain")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
		saynn("Элиза выводит вас в вестибюль.")
		
		saynn("[say=eliza]Береги себя![/say]")
		
		addButton("Продолжить", "Пора идти!", "endthescene")
		addButton("Бежать назад", "Спешно вернуться к скрытому входу в притон", "endthescene_rushback")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "endthescene_rushback"):
		GM.pc.setLocation("yard_deadend2")
		endScene()
		return
	if(_action == "do_give_up"):
		GM.main.processTimeUntil(23*60*60)
	if(_action == "stop_run"):
		GM.pc.setLocation("medical_hospitalwards")
		GM.main.stopDungeonRun()
		GM.pc.addPain(-GM.pc.getPain())
		GM.pc.addLust(-GM.pc.getLust())
		GM.pc.addStamina(GM.pc.getMaxStamina())



	setState(_action)
