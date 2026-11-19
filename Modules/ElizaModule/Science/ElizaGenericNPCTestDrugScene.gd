extends SceneBase

var npcID = ""

func _init():
	sceneID = "ElizaGenericNPCTestDrugScene"

func _initScene(_args = []):
	npcID = _args[0]
	addCharacter(npcID)
	if(GM.pc.getLocation() == "med_lobbymain"):
		setState("bring_to_eliza")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		saynn("Вы замечаете, что трансформации {npc.name} можно сканировать... Поэтому вы выхватываете поводок и ловко застегиваете его на ошейнике {npc.his}.")

		saynn("[say=pc]Ты и я идем в медпункт.[/say]")

		addButton("Медпункт", "Пойти к Элизе", "bring_to_eliza")
	if(state == "bring_to_eliza"):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		aimCameraAndSetLocName("med_lobbymain")
		saynn("Вы находите доктора Куинн за стойкой в вестибюле медпункта.")

		saynn("[say=pc]Эй, у меня тут подопытный экземпляр. Думаю, вы сможете просканировать {npc.him}.[/say]")

		saynn("Глаза доктора загораются. Тот, кто на вашем поводке, чувствует себя, мягко говоря, не в своей тарелке.")

		saynn("[say=eliza]Отлично![/say]")

		saynn("Она нажимает кнопку, и двери с вашей стороны открываются, приглашая вас войти.")

		saynn("[say=eliza]Пойдем в лабораторию.[/say]")

		addButton("Лаборатория", "Привести подопытного туда", "to_lab")
	if(state == "to_lab"):
		playAnimation(StageScene.Duo, "stand", {pc="eliza", npc=npcID, npcBodyState={leashedBy="eliza"}})
		aimCameraAndSetLocName("med_researchlab")
		GM.pc.setLocation("med_researchlab")
		saynn("Ты тянешь за поводок, завлекая подопытную в исследовательскую лабораторию.")

		saynn("Элиза берет небольшой ручной сканер и начинает медленно водить им по телу {npc.his}.. {npc.name} при этом слегка ерзает. В конце концов, кошечке удается собрать достаточно данных.")

		saynn("[say=eliza]Готово! База данных обновлена! А еще мы получили за это очки науки, отличная работа![/say]")

		saynn("Она убирает сканер и достает две таблетки.")

		saynn("[say=eliza]А теперь.. у меня есть для тебя предложение.[/say]")

		saynn("Она смотрит на тебя, держа на ладонях две таблетки. Синяя — в левой руке.. и красная — в правой..")

		saynn("[say=eliza]Раз уж ты мой ассистент, я предоставлю выбор тебе~. Синяя отменит любые трансформации и вернет всё как было. Скучно, как по мне![/say]")

		saynn("Скучно, значит..")

		saynn("[say=eliza]Или! Есть еще красная.. на случай, если тебе нравится, как выглядит {npc.he} {npc.verb('look')}! Она сотрет резервную ДНК тела {npc.his}.. сделав все текущие изменения постоянными.[/say]")

		saynn("Выбор очевиден..")

		addButton("Синяя", "Заставить их съесть синюю таблетку, которая отменит все трансформации", "eat_blue")
		addButton("Красный", "Заставить их съесть красную таблетку, которая сделает все трансформации постоянными", "eat_red")
	if(state == "eat_blue"):
		saynn("Вы выбираете синюю.")

		saynn("[say=eliza]О-о-о~.[/say]")

		saynn("Элиза осторожно дает {npc.name} выбранную вами таблетку. И вскоре тело {npc.his} возвращается в свое обычное состояние.")

		saynn("[say=eliza]Ну, возвращайся, когда найдешь кого-нибудь еще, кого я смогу просканировать![/say]")

		saynn("Ты киваешь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "eat_red"):
		saynn("Вы выбираете красную.")

		saynn("[say=eliza]Мудрый выбор~.[/say]")

		saynn("Элиза осторожно дает {npc.name} выбранную вами таблетку. И, как и ожидалось, ничего не меняется. Но теперь все трансформации стали постоянными!")

		saynn("[say=eliza]Наслаждайся! Возвращайся, когда найдешь кого-нибудь еще, кого я смогу просканировать![/say]")

		saynn("Ты киваешь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "bring_to_eliza"):
		processTime(5*60)

	if(_action == "to_lab"):
		GM.main.SCI.doTestTFsOf(getCharacter(npcID))

	if(_action == "eat_blue"):
		getCharacter(npcID).getTFHolder().undoAllTransformations()

	if(_action == "eat_red"):
		getCharacter(npcID).getTFHolder().makeAllTransformationsPermanent()

	setState(_action)

func saveData():
	var data = .saveData()

	data["npcID"] = npcID

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
