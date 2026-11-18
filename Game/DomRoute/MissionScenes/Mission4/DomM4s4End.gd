extends SceneBase

func _init():
	sceneID = "DomM4s4End"

func _run():
	if(state == ""):
		aimCameraAndSetLocName("hideout_near_break_room")
		addCharacter("avy")
		GM.pc.setLocation("hideout_near_break_room")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("[say=avy]Ну что ж. Сучка сломлена![/say]")

		saynn("[say=pc]Именно.[/say]")

		saynn("Лисичка выглядит счастливой.")

		saynn("[say=avy]Черт возьми, да! Пойду гляну, как она там.[/say]")

		saynn("Эйви заходит в камеру.")

		saynn("Почти одновременно к тебе подходит Анс.")

		addButton("Продолжить", "Смотреть, что будет дальше", "ans_talk")
	if(state == "ans_talk"):
		removeCharacter("avy")
		addCharacter("announcer")
		playAnimation(StageScene.Duo, "stand", {npc="announcer"})
		saynn("Он опирается на свою трость-микрофон.")

		saynn("[say=announcer]Ну и зрелище. Видел, как Кейт пробежала мимо меня совершенно голышом.[/say]")

		saynn("Ты чешешь затылок.")

		saynn("[say=pc]Ага, она потеряла шмотки... во время миссии.[/say]")

		saynn("Ты слышишь тихий смешок.")

		saynn("[say=announcer]Понятно, понятно. Ха, миссия? Ты кого-то поймала?[/say]")

		saynn("[say=pc]Элиза Квинн, врач.[/say]")

		saynn("Он вскидывает бровь.")

		saynn("[say=announcer]Вот как? Уже взялась за персонал?[/say]")

		saynn("Ты пожимаешь плечами.")

		saynn("[say=pc]А почему бы и нет? У нас возникли некоторые... осложнения... но мы справились.[/say]")

		saynn("Он чешет подбородок.")

		saynn("[say=announcer]Что-то мне подсказывает, что тебе чертовски повезло.[/say]")

		saynn("[say=pc]Повезло? Это еще почему?[/say]")

		saynn("[say=announcer]Ты поймала сотрудницу. И при этом ни одна из наших рож до сих пор не впечатана в холодный пол. Я бы сказал, что удача тут сыграла не последнюю роль.[/say]")

		saynn("То, что случилось с Кейт, вряд ли можно назвать удачей.")

		saynn("[say=pc]Думаешь, нам не стоит связываться с персоналом? Ну, по крайней мере, пока?[/say]")

		saynn("[say=announcer]Я просто голос разума, вот и всё.[/say]")

		saynn("Единственный, кто здесь не сошел с ума. Может, иногда и стоит притормозить.")

		saynn("[say=pc]Слышу тебя, старик.[/say]")

		saynn("Оба на какое-то время замолкают. Энс, кажется, уставился в пол, погруженный в свои мысли.")

		saynn("[say=announcer]Может, ты и прав. Может, дело во мне.[/say]")

		saynn("[say=pc]В тебе?[/say]")

		saynn("Пришло время пожать плечами.")

		saynn("[say=announcer]Может, я слишком привязался к этому месту. Уже и жить без него не могу.[/say]")

		saynn("[say=pc]Всё должно измениться.[/say]")

		saynn("[say=announcer]Знаю. Будет больно. Очень больно.[/say]")

		saynn("Вы киваете. Он медленно отступает.")

		saynn("Как раз вовремя — возвращается Эви... и Элиза на поводке.")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_eliza")
	if(state == "avy_eliza"):
		removeCharacter("announcer")
		addCharacter("avy")
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {pc="avy", npc="eliza", npcBodyState={leashedBy="avy"}})
		saynn("[say=avy]А вот и наша новая шлюшка! Та самая, ради которой мы так старались![/say]")

		saynn("Элиза медленно идет за Эви, низко опустив голову... и хвост тоже.")

		saynn("[say=avy]Ну же, скажи это, сучка![/say]")

		saynn("Эви дергает за поводок... затем делает это снова, еще сильнее.")

		saynn("[say=eliza]Ух... гав...[/say]")

		saynn("Эви хватает Элизу за ухо, впиваясь в него когтями.")

		saynn("[say=avy]Что это было? Говори громче![/say]")

		saynn("[say=eliza]Гав.. гав..[/say]")

		saynn("Ави отталкивает Элизу.")

		saynn("[say=avy]Хорошая сучка, блядь.[/say]")

		saynn("[say=pc]Вижу, ты её уже дрессируешь.[/say]")

		saynn("Ави кивает.. и снова смотрит на кошечку.")

		saynn("[say=avy]Ага. Теперь ты наша сучка, верно?[/say]")

		saynn("[say=eliza]..да.[/say]")

		saynn("Элиза почти шепчет, её поза.. поза сломленного человека.")

		saynn("[say=avy]Да что?[/say]")

		saynn("[say=eliza]Я твоя сучка... буду делать всё, что ты захочешь...[/say]")

		saynn("Эйви взъерошивает хвостик Элизы, похлопывая по нему и превращая прическу в полный беспорядок.")

		saynn("[say=avy]Идеально. Мы намного выше тебя, не забывай об этом.[/say]")

		saynn("[say=pc]Завяжи ей глаза, прежде чем выведешь. Вот ключ от её пояса.[/say]")

		saynn("Ты протягиваешь ей ключ.")

		saynn("[say=avy]А нужно ли вообще её отстегивать?.. Мы могли бы оставить ключ себе и сделать её нашей личной залупой.[/say]")

		saynn("[say=pc]Нет, Эйви. Не нужно привлекать к ней лишнее внимание.[/say]")

		saynn("[say=avy]Ну и ладно-о. Пошли, бесполезная.[/say]")

		saynn("И вот Эйви уводит Элизу.")

		saynn("И теперь... ты на шаг ближе к цели.")

		saynn("Миссия выполнена!")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_reseteliza")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "avy_eliza"):
		GM.main.MS.completeMission()
		
	if(_action == "endthescene_reseteliza"):
		endScene()
		getCharacter("eliza").getInventory().clearSlot(InventorySlot.Body)
		putOff("eliza", "oldcollar")
		getCharacter("eliza").resetEquipment()
		playAnimation(StageScene.Solo, "stand")
		return

	setState(_action)
