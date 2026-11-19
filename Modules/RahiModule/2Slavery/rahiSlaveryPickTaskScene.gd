extends SceneBase

func _init():
	sceneID = "rahiSlaveryPickTaskScene"


#func _reactInit():
#	if(getModule("RahiModule").canAdvanceStage()):
#		setState("ask_if_advance")

func _run():
	if(state == ""):
		saynn("Выберите задачу, которую Рахи должна выполнить сегодня.")

		addButton("Уборка", "Заставить её убраться в камере", "dotask", ["rahiSlaveryCleaningTaskScene"])
		var rahiModule = getModule("RahiModule")
		if(rahiModule.getSlaveryStage() >= 1):
			addButton("Кража", "Заставить её что-нибудь украсть", "dotask", ["rahiSlaveryStealingTaskScene"])
		if(rahiModule.isSkillLearned("rahiSkillExhibit")):
			addButton("Йога", "(Эксгибиционизм) Заставить её заниматься йогой", "dotask", ["rahiSlaveryYogaTaskScene"])
		if(rahiModule.isSkillLearned("rahiSkillProstitution")):
			addButton("Будка поцелуев", "(Проституция) Заставить Рахи зарабатывать кредиты, предлагая поцелуи и не только", "dotask", ["rahiSlaveryKissingBoothTaskScene"])
		if(rahiModule.getSlaveryStage() >= 8):
			addButton("Без задачи", "Дать Рахи выходной!", "dotask", ["rahiSlaveryFreeTaskScene"])
				
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "dotask"):
		runScene(_args[0], [], "theTask")
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "theTask"):
		if(_result == null || _result.size() == 0):
			setState("")
			return
			
		if(_result == ["free"]):
			setFlag("RahiModule.rahiCommentedOnTask", true)
			endScene()
			runScene("rahiSlaveryTalkScene")
			return
			
		var theresult = _result[0]
		
		setFlag("RahiModule.rahiCommentedOnTask", false)
		if(theresult):
			addExperienceToPlayer(10)
			setFlag("RahiModule.rahiNeedsReward", true)
			setFlag("RahiModule.rahiTaskSuceeded", true)
			endScene()
			runScene("rahiSlaveryTalkScene")
		else:
			addExperienceToPlayer(5)
			setFlag("RahiModule.rahiNeedsPunishment", true)
			setFlag("RahiModule.rahiTaskSuceeded", false)
			endScene()
			runScene("rahiSlaveryTalkScene")
