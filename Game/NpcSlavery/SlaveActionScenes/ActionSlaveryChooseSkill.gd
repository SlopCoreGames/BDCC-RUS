extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "ActionSlaveryChooseSkill"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		sayn("Текущий уровень рабыни {npc.name}: "+str(npcSlavery.getLevel()))
		saynn("За каждые 5 уровней рабыни {npc.he} может получить новый навык или специализацию.")
		
		saynn("Текущая основная специализация вашей рабыни: "+npcSlavery.getCurrentSkillName()+". Это навык, который будете тренировать вы.")
		
		sayn("Текущие навыки вашей рабыни:")
		for slaveType in npcSlavery.slaveSpecializations:
			var slaveTypeObj:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveType)
			if(slaveTypeObj == null):
				continue
			sayn(slaveTypeObj.getVisibleName()+": "+npcSlavery.rankToLetter(npcSlavery.slaveSpecializations[slaveType]))
		
		if(npcSlavery.slaveSpecializations.keys().size() > 1):
			addButton("Основной навык", "Выберите основную специализацию вашей рабыни", "pick_main_menu")
		else:
			addDisabledButton("Основной навык", "У вашей рабыни сейчас только одна специализация")
			
		if(npcSlavery.canLearnNewSkill()):
			if(npcSlavery.canLearnNewSkillAndHasAvailable()):
				addButton("Изучить новое", "Добавьте новую специализацию/навык вашей рабыне!", "learn_new_menu")
			else:
				addDisabledButton("Изучить новое", "У вашей рабыни уже есть все возможные навыки!")
		else:
			addDisabledButton("Изучить новое", "Вы можете обучать рабыню новой специализации/навыку каждые 5 уровней рабыни")
		addButton("Готово", "Достаточно копания", "endthescene")

	if(state == "learn_new_menu"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		saynn("Какой навык вы хотите дать своей рабыне? Вы сможете тренировать любой навык, который уже есть у вашей рабыни.")
		
		for slaveType in GlobalRegistry.getSlaveTypes():
			if(npcSlavery.hasSkill(slaveType)):
				continue
			var slaveTypeObj:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveType)
			if(slaveTypeObj == null):
				continue
			if(!slaveTypeObj.canTeach(npc)):
				addDisabledButton(slaveTypeObj.getVisibleName(), "[color=red]Несовместимо с этой рабыней[/color]\n"+slaveTypeObj.getVisibleDesc())
				continue
			if(npcSlavery.getLevel() < slaveTypeObj.getMinimalSlaveLevel()):
				addDisabledButton(slaveTypeObj.getVisibleName(), "[color=red]Требуемый минимальный уровень рабыни: "+str(slaveTypeObj.getMinimalSlaveLevel())+"[/color]\n"+slaveTypeObj.getVisibleDesc())
				continue
			addButton(slaveTypeObj.getVisibleName(), slaveTypeObj.getVisibleDesc(), "learn_new", [slaveType])

		addButton("BACK", "Вы передумали", "")

	if(state == "pick_main_menu"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		saynn("Выберите основную специализацию вашей рабыни.")
		
		saynn("Текущая основная специализация вашей рабыни: "+npcSlavery.getCurrentSkillName()+". Вы будете тренировать выбранную основную специализацию рабыни.")
		
		sayn("Текущие навыки вашей рабыни:")
		for slaveType in npcSlavery.slaveSpecializations:
			var slaveTypeObj:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveType)
			if(slaveTypeObj == null):
				continue
			addButton(slaveTypeObj.getVisibleName(), "Выбрать это", "pick_main", [slaveType])
			sayn(slaveTypeObj.getVisibleName()+": "+npcSlavery.rankToLetter(npcSlavery.slaveSpecializations[slaveType]))
		
		addButton("Назад", "Назад", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "pick_main"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.setMainSkill(_args[0])
		setState("")
		addMessage("Main skill changed!")
		return
		
	if(_action == "learn_new"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.learnNewSkill(_args[0])
		npcSlavery.setMainSkill(_args[0])
		setState("")
		addMessage("Your slave has learned a new skill!")
		return
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
