extends SceneBase

func _init():
	sceneID = "PSElizaTentaclesGiveEgg"

func _run():
	if(state == ""):
		addCharacter("eliza")
		saynn("[say=pc]Об яйцах..[/say]")

		saynn("[say=eliza]Да, со всей имеющейся у нас ДНК, создание идеального экземпляра обойдется нам в "+str(getModule("ElizaModule").getTentaclesCostStr())+"[/say]кредитов.[/say]")

		addButton("Хватит", "Хватит об этом болтать", "endthescene")
		if (GM.pc.getInventory().hasItemID("PlantEgg")):
			addButton("Дать яйцо", "Дать Элизе еще одно яйцо!", "give_egg")
		else:
			addDisabledButton("Дать яйцо", "В вашем инвентаре нет растительных яиц")
		if (GM.pc.getCredits() >= getModule("ElizaModule").getTentaclesCost()):
			addButton("Оплатить "+getModule("ElizaModule").getTentaclesCostStr()+"", "Заплатите столько-то кредитов, чтобы создать идеальное яйцо", "begin_stuff")
		else:
			addDisabledButton("Оплатить "+getModule("ElizaModule").getTentaclesCostStr(), "У вас недостаточно кредитов..")
	if(state == "give_egg"):
		saynn("Вы отдаете Элизе одно из своих яиц растений.")

		saynn("[say=eliza]Идеально. Теперь это должно стоить нам всего "+str(getModule("ElizaModule").getTentaclesCostStr())+"[/say]кредитов.[/say]")

		saynn("Ты киваешь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "give_egg"):
		getModule("ElizaModule").addTentacleEgg()
		GM.pc.getInventory().removeXOfOrDestroy("PlantEgg", 1)
		addMessage("Total amount of eggs given is "+str(getFlag("ElizaModule.tent_eggs", 0)))

	if(_action == "begin_stuff"):
		GM.pc.addCredits(-getModule("ElizaModule").getTentaclesCost())
		runScene("PSElizaTentaclesBorn")
		setFlag("ElizaModule.tent_born", true)
		endScene()
		return

	setState(_action)
