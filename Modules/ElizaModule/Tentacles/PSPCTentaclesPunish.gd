extends SceneBase

var hasNeuro = false
var slaveID = ""

func _init():
	sceneID = "PSPCTentaclesPunish"

func _initScene(_args = []):
	slaveID = _args[0]
	addCharacter(slaveID)

func resolveCustomCharacterName(_charID):
	if(_charID == "slave"):
		return slaveID

func _run():
	if(state == ""):
		aimCameraAndSetLocName(GM.pc.getLocation())
		addCharacter("PCTentacles")
		hasNeuro = getFlag("ElizaModule.tent_neurolink", false)
		playAnimation(StageScene.TentaclesGrope, "tease", {pc=slaveID, plant=true})
		saynn("Вы заводите {slave.name} в свою камеру... и вдруг резко толкаете {slave.him} к {pcTentacles}, вашему личному похотливому комнатному растению.")

		saynn("Щупальца мгновенно обвивают талию и лодыжки {slave.his}, не давая {slave.him} сбежать...")

		saynn("Веселье вот-вот начнется.")

		addButton("Продолжить", "Дать щупальцам самим развлечься с этим человеком", "start_slave_sex")
		if (hasNeuro):
			addButton("Нейролинк", "Использовать устройство Нейро-Связи, чтобы управлять щупальцами, пока они развлекаются с этим человеком", "start_slave_sex_neuro")
		else:
			addDisabledButton("Нейролинк", "Сначала вам нужно разблокировать и создать устройство Нейро-Связи в биолаборатории...")
	if(state == "after_sex_slave"):
		saynn("После секса вы хватаете {slave.name} и приглашаете {slave.him} выйти из вашей камеры...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "start_slave_sex"):
		getCharacter("PCTentacles").prepareForSex()
		runScene("GenericSexScene", ["PCTentacles", slaveID, SexType.TentaclesSex, {}], "tentaclesSexSlave")
		setState("after_sex_slave")
		return

	if(_action == "start_slave_sex_neuro"):
		getCharacter("PCTentacles").prepareForSex()
		runScene("GenericSexScene", ["PCTentacles", slaveID, SexType.TentaclesSex, {SexMod.PCControlsDoms:true}], "tentaclesSexSlaveNeuro")
		setState("after_sex_slave")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["hasNeuro"] = hasNeuro
	data["slaveID"] = slaveID

	return data

func loadData(data):
	.loadData(data)

	hasNeuro = SAVE.loadVar(data, "hasNeuro", false)
	slaveID = SAVE.loadVar(data, "slaveID", "")
