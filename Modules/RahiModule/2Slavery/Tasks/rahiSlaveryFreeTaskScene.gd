extends SceneBase

func _init():
	sceneID = "rahiSlaveryFreeTaskScene"

func _run():
	if(state == ""):
		addCharacter("rahi")
		saynn("Чем больше об этом думаешь... тем больше понимаешь, что сегодня вообще не хочется давать Рахи никаких заданий.")

		saynn("[say=pc]В последнее время ты отлично справляешься, киса. Считай, что сегодня у тебя выходной.[/say]")

		var randomResponce = RNG.pick(["Ня.. Спасибо, {rahiMaster}..", "Ох.. Иногда мне так нравится бездельничать..", "Спасибо.. Если хочешь, мы всё ещё можем чем-нибудь заняться..", "Ты лучший, {rahiMaster}.."])
		saynn("[say=rahi]"+str(randomResponce)+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "stop_task"):
		#getCharacter("rahi").resetEquipment()
		endScene(["free"])
		return

	setState(_action)
