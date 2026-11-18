extends SceneBase

var npcID = ""

func _init():
	sceneID = "DomM4s2LetAvyFightNurse"

func _initScene(_args = []):
	npcID = _args[0]

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		addCharacter(npcID)
		playAnimation(StageScene.Duo, RNG.pick(["punch", "kick", "shove", "bite"]), {pc="avy", npc=npcID, npcAction="defeat"})
		saynn("Ты позволяешь Эви разобраться с этим самой!")

		saynn("Она с легкостью избивает медсестру!")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		var thePawn:CharacterPawn = GM.main.IS.getPawn(npcID)
		if(thePawn):
			thePawn.afterLostFight()
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["npcID"] = npcID

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
