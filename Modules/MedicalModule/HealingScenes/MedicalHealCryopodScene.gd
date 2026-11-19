extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MedicalHealCryopodScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcAction="stand", bodyState={naked=true}})
		
	if(state == ""):
		aimCameraAndSetLocName("med_researchlab")
		saynn("Вы позволяете Элизе списать достаточно кредитов за процедуру в криокамере. Она проводит вас в лабораторию и готовит аппарат. Вы отдаете ей все свои вещи, надеваете дыхательную маску и ложитесь в капсулу. Элиза нажимает несколько кнопок, и высокотехнологичная машина начинает творить свою магию, замещая воздух внутри плотной голубой жидкостью.")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue")

	if(state == "continue"):
		playAnimation(StageScene.Cryopod, "idle", {bodyState={naked=true}})
		
		saynn("Вскоре вы обнаруживаете, что полностью погружены в жидкость и парите над полом. Странная субстанция щекочет вас во всех самых неожиданных местах, включая ваши интимные зоны.")

		saynn("Это ощущается так уютно... Ваши глаза закрываются, а сознание уплывает куда-то в подсознание. Тем временем ваши раны медленно затягиваются.")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue1")

	if(state == "continue1"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza", npcAction="stand", bodyState={naked=true}})
		aimCameraAndSetLocName("med_nearlab")
		GM.pc.setLocation("med_nearlab")
		
		saynn("Время летит незаметно. В конце концов Элиза будит вас и выключает машину, после чего извлекает вас — полностью исцеленного и восстановившего силы.")

		saynn("[say=eliza]Не за что~.[/say]")

		saynn("Доктор Куинн выводит вас в коридор, прежде чем отпустить.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		


func _react(_action: String, _args):
	if(_action in ["continue1"]):
		processTime(60*10)
	
	if(_action == "continue"):
		GM.pc.afterCryopodTreatment()
		processTime(60*60*4)
	
	if(_action == "endthescene"):
		endScene()
		return
		
	setState(_action)
