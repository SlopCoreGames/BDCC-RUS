extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "PCOverrideExample"

func _reactInit():
	if(!GM.pc.isOverriddenPlayer()):
		GM.main.overridePC()
		GM.pc.setName("Tavi")
		GM.pc.setGender(Gender.Female)
		GM.pc.setSpecies([Species.Feline])
		GM.pc.resetBodypartsToDefault()
		GM.pc.giveBodypart(GlobalRegistry.createBodypart("tavihair"))
		
		GM.pc.updateAppearance()
		GM.pc.updateNonBattleEffects()
		playAnimationForceReset(StageScene.Solo, "stand")

func _onSceneEnd():
	pass
	#GM.main.clearOverridePC()
	#GM.pc.updateAppearance()
	#GM.pc.updateNonBattleEffects()

func _run():
	if(state == ""):
		saynn("Привет. Твое имя — {pc.name}")
		
		saynn("[say=pc]Да, меня зовут {pc.name}[/say]")

		addButton("Выход", "Остановить сцену", "endthescene")
		addButton("Сбросить переопределение", "Ня", "clear_override")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "clear_override"):
		GM.main.clearOverridePC()
		GM.pc.updateAppearance()
		GM.pc.updateNonBattleEffects()
		playAnimationForceReset(StageScene.Solo, "stand")
		endScene()
		return

	
	setState(_action)
