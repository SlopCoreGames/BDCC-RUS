extends SceneBase

var kaitLove = 0
var kaitObedience = 0

func _init():
	sceneID = "KaitTalkScene"

func _run():
	if(state == ""):
		addCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("Вы подходите к Кейт, снежному барсу. Она стоит у доски заданий, погруженная в раздумья.")

		var theUniqieLine:String = getFlag("KaitModule.kaitApproach", "")
		if (theUniqieLine.empty()):
			saynn("[say=kait]Привет.[/say]")

		else:
			saynn("[say=kait]"+str(theUniqieLine)+"[/say]")

			setFlag("KaitModule.kaitApproach", "")
		kaitLove = GM.main.MS.getKaitLove()
		kaitObedience = GM.main.MS.getKaitObedience()
		saynn("Любовь Кейт: "+str(kaitLove)+"\nПослушание Кейт: "+str(kaitObedience)+"")

		addButton("Поговорить", "Может, о чем-нибудь её спросить?", "talk_menu")
		if (kaitLove >= 2):
			addButton("Секс", "Посмотреть, какой пошлостью можно заняться с Кейт", "sex_menu")
		else:
			addDisabledButton("Секс", "Уровень любви Кейт к вам должен быть выше 2")
		if (kaitObedience >= 2):
			addButton("Доминировать", "Посмотреть, что можно приказать Кейт", "dom_menu")
		else:
			addDisabledButton("Доминировать", "Уровень послушания Кейт должен быть выше 2")
		var _isPreg:bool = getCharacter("kait").isVisiblyPregnant()
		if(_isPreg):
			addButton("Беременность", "Посмотреть, что можно сделать с беременной Кейт", "preg_menu")
		elif(getFlag("KaitModule.kaitGaveBirths", 0) > 0 && getCharacter("kait").canBeMilked()):
			addButton("Лактация", "Посмотри, что можно сделать с молочной Кейт", "preg_menu")
		elif(getFlag("KaitModule.kaitGaveBirths", 0) > 0):
			addDisabledButton("Беременность", "Кейт не беременна, так что эти взаимодействия недоступны.")
		if(kaitLove >= 4 || kaitObedience >= 4):
			addButton("Покормить", "Покормить Кейт", "feedmenu")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["kait"])
		addButton("Уйти", "Хватит болтать", "endthescene")
	if(state == "sex_menu"):
		saynn("Какой вид секса ты хочешь с Кейт?")

		addButton("Назад", "Вы передумали", "")
		if (GM.pc.hasReachablePenis() || GM.pc.hasReachableVagina() || GM.pc.isWearingChastityCage()):
			addButton("69", "(Любовь 2+) Лизать или сосать друг друга!", "sex_69")
		else:
			addDisabledButton("69", "Для секса в позе 69 нужны приватные части тела, сорян :(")
		addButton("Поласкать её пальцами", "(Любовь 2+) Заставь эту сучку кончить одними лишь пальцами!", "sex_fingerher")
		if (kaitLove >= 3):
			addButton("Секс наездницей", "(Любовь 3+) Проверить, хочет ли Кейт оседлать тебя", "sex_cowgirl")
		else:
			addDisabledButton("Любовь 3+", "Требуется уровень любви Кейт 3 или выше!")
	if(state == "dom_menu"):
		saynn("Как именно ты хочешь доминировать над Кейт?")

		addButton("Назад", "Вы передумали", "")
		addButton("Легкое доминирование", "(Послушание 2+) Попытаться подчинить Кейт и посмотреть, что из этого выйдет", "dom_light")
		if (!getFlag("KaitModule.didKaitDomIntro")):
			addDisabledButton("Оральный секс", "Сначала тебе нужно полностью подчинить Кейт, прежде чем делать это!")
		else:
			addButton("Оральный секс", "(Послушание 2+) Доминировать над Кейт еще сильнее, заставляя её сосать твой член или лизать твою киску", "oral_sex")
			if (kaitObedience >= 3):
				addButton("Секс с удушением", "(Послушание 3+) Душить Кейт, одновременно трахая её в киску!", "obey_chokesex")
			else:
				addDisabledButton("Послушание 3+", "Требуется уровень послушания Кейт 3 или выше!")
	if(state == "talk_menu"):
		saynn("[say=pc]Можно тебя кое о чем спросить?[/say]")

		saynn("Её ушки навостряются.")

		saynn("[say=kait]Не спеши. У нас полно времени.[/say]")

		addButton("Назад", "Хватит болтать", "")
		addButton("Кейт", "Попросить её рассказать о себе", "ask_kait")
		addButton("Преступления", "Спросить, чем она занималась", "ask_crimes")
		addButton("Свобода", "Спросить, что она собирается делать дальше", "ask_freedom")
		addButton("Убежище", "Поговорить об этом убежище", "ask_hideout")
		addButton("Анс и Эви", "Поговорить об Ансе и Эви", "ask_ans_avy")
	if(state == "ask_kait"):
		saynn("[say=pc]Расскажи о себе. О чём угодно.[/say]")

		saynn("[say=kait]Ну.. Я Кейт, если ты вдруг забыл. Родилась на планете, где полно снега. Наверняка о парочке таких слышал.[/say]")

		saynn("[say=pc]Там красиво?[/say]")

		saynn("[say=kait]Конечно. Снег — это всегда хорошо. Он скрывает всю грязь и жижу.[/say]")

		saynn("[say=pc]Там много грязи, которую нужно скрывать?[/say]")

		saynn("[say=kait]Когда пришла АльфаКорп, всё пошло по пизде. Так что.. да.[/say]")

		saynn("[say=pc]Могу себе представить.[/say]")

		saynn("[say=kait]Влияние АльфаКорп расширяется без остановки. Это уже настоящая империя. А империям всегда нужны победы. Иначе они дохнут.[/say]")

		saynn("Наверное, поэтому по телеку столько пропаганды.")

		saynn("[say=kait]И это даже не то, что меня бесит. У нас же был шанс! Но они нас разделили. АльфаКорп заявила, что где-то в наших горах спрятаны какие-то гребаные магические артефакты. И некоторые из нас им поверили.[/say]")

		saynn("[say=pc]Звучит как отличный повод развернуть на твоей планете гигантскую добычу ископаемых.[/say]")

		saynn("[say=kait]И так — грязь.[/say]")

		saynn("Несколько секунд тишины.")

		saynn("[say=pc]Но вдруг эти магические артефакты реально существуют?[/say]")

		saynn("Она смеется.")

		saynn("[say=kait]Яблоко, управляющее временем? Камень, превращающий всё, к чему прикоснешься, в черное золото? Кольцо, позволяющее подчинять волю других? Да бросьте, они просто паразитируют на людских фетишах. Честно говоря, это даже хуже религии.[/say]")

		saynn("Она вздыхает.")

		saynn("[say=kait]Моих родителей этим промыли мозги. И именно тогда я поняла, что должна свалить, причем как можно быстрее, блядь.[/say]")

		saynn("[say=pc]Некоторые мечты всё же сбываются.[/say]")

		saynn("Она усмехается, но затем закатывает глаза.")

		saynn("[say=kait]Пошел ты. Значит, один из артефактов я всё-таки нашла. Невидимая обезьянья лапка.[/say]")

		saynn("Ты киваешь.")

		saynn("[say=pc]Чего тебе опять?[/say]")

		saynn("[say=kait]Уходи. Снова. И постарайся на этот раз посильнее меня задеть.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_crimes"):
		saynn("[say=pc]Ну и что ты такого натворила, что оказалась именно в этом месте?[/say]")

		saynn("[say=kait]Разное. Боюсь, у меня нет какой-нибудь грустной истории, от которой все бы разрыдались.[/say]")

		saynn("[say=pc]Ты сиреневая не просто так. Ну же, мне же любопытно![/say]")

		saynn("Она запрокидывает голову и уставилась в потолок.")

		saynn("[say=kait]Ты единственный, кто вообще удосужился спросить. Ну, хотя бы Анс спросил. Он милашка.[/say]")

		saynn("Кейт молчит, погрузившись в свои мысли.")

		saynn("[say=kait]Пыталась подкупить одного типа своей задницей. В итоге вместо взятки получила клеймо «Нежелательное разведение». И что самое паршивое? Никакого разведения не было, мы даже до этого не дошли! Полная, блядь, херня.[/say]")

		saynn("[say=pc]Ты злишься из-за того, что тебя не осеменили?[/say]")

		saynn("[say=kait]Ну... да нет. Пфф. Я не шлюха.[/say]")

		saynn("[say=pc]Почему тебя засадили именно в эту тюрьму?[/say]")

		saynn("[say=kait]Этот тип был каким-то важным хреном из «АльфаКорп», не знаю точно. Наверное, просто хотел от меня избавиться. Я слишком много болтаю и сосу недостаточно хорошо. Запереть меня здесь — верный способ сделать так, чтобы я не вернулась.[/say]")

		saynn("Её усики слегка подергиваются, уголки рта опускаются, а хвост беспорядочно виляет.")

		saynn("[say=kait]Слушай... Вся эта система — сплошное дерьмо на дерьме. Каждый делает что хочет, всем плевать на остальных. Повсюду одни коррумпированные куски говна.[/say]")

		saynn("[say=pc]Ты пыталась играть по их правилам, и в итоге обжеглась.[/say]")

		saynn("[say=kait]Здесь нет правил. Единственное правило — лизать ноги тому, кто держит тебя на поводке.[/say]")

		saynn("Ты слышишь рычание.")

		saynn("[say=kait]Этот мир — полное дерьмо. Можно было бы просто сидеть на жопе ровно и ничего не делать. Но мне этого не хочется.[/say]")

		saynn("Она скалится, обнажая клыки.")

		saynn("[say=kait]Я заставлю их вместо этого лизать мои пятки. Всех до единого.[/say]")

		saynn("Похоже, Кейт горит этой идеей.")

		saynn("[say=pc]Это будет непросто.[/say]")

		saynn("Она пожимает плечами, и выражение её лица смягчается.")

		saynn("[say=kait]Мы можем начать с капитана этой дыры.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_freedom"):
		saynn("[say=pc]И что ты будешь делать потом?[/say]")

		saynn("[say=kait]После чего?[/say]")

		saynn("[say=pc]После того как обретешь свободу.[/say]")

		saynn("[say=kait]Жить? Как обычный человек.[/say]")

		saynn("[say=pc]Если ты сбежишь, то вряд ли сможешь жить как обычный человек.[/say]")

		saynn("[say=kait]Знаю. Этот мир — дерьмо. Но он ещё и огромный.[/say]")

		saynn("Она отводит взгляд в сторону.")

		saynn("[say=kait]Попробую найти местечко. На каком-нибудь острове на далекой планете, на которую всем насрать. Буду целый день гонять на волнах. Это будет просто охеренно.[/say]")

		saynn("[say=pc]Похоже на прекрасный сон.[/say]")

		saynn("[say=kait]Мгм. А пока мне просто нужно продолжать сражаться.[/say]")

		saynn("[say=pc]А мне на твоем острове будут рады?[/say]")

		saynn("[say=kait]Ну что, ты что, корпоративный раб?[/say]")

		saynn("[say=pc]Вряд ли.[/say]")

		saynn("[say=kait]Ну тогда ладно. Только закуски прихвати с собой, идет?[/say]")

		saynn("Вы посмеиваетесь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_hideout"):
		saynn("[say=pc]Что думаешь об этом убежище?[/say]")

		saynn("[say=kait]Миленько. Со своей задачей справляется. Пока я могу дышать, и мне в задницу не пялится охранник из «АльфаКорп», я довольна.[/say]")

		saynn("[say=pc]Ох.[/say]")

		saynn("Кейт прищуривается, а затем посмеивается.")

		saynn("[say=kait]Ты не охранник. И на корпоративную сучку ты тоже не похож.[/say]")

		saynn("[say=pc]Значит, полагаю, у меня есть разрешение.[/say]")

		saynn("[say=kait]Пфф. Смотри не злоупотребляй.[/say]")

		saynn("Ты киваешь.")

		saynn("[say=pc]Думаю, это место отлично подходит для того, чтобы ломать людей.[/say]")

		saynn("[say=kait]Верно. Так и есть.[/say]")

		saynn("[say=pc]Тебе нравится ломать людей?[/say]")

		saynn("[say=kait]Необходимое зло. Я не жажду власти. Если бы АльфаКорп не вломилась в мою жизнь, мне было бы на неё абсолютно насрать.[/say]")

		saynn("[say=pc]Значит, тебе стало не плевать только тогда, когда это коснулось тебя лично.[/say]")

		saynn("[say=kait]Я просто хотела жить в мире. Ты что, называешь меня лицемеркой?[/say]")

		saynn("[say=pc]Просто констатирую факт.[/say]")

		saynn("[say=kait]Да, я не настолько тупая, чтобы в одиночку идти против целой гребаной межгалактической корпорации. Мой косяк, если хочешь.[/say]")

		saynn("[say=pc]Но теперь у тебя нет выбора.[/say]")

		saynn("[say=kait]У нас у всех нет выбора.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")
	if(state == "ask_ans_avy"):
		saynn("[say=pc]Что ты думаешь об Ансе и Эви?[/say]")

		saynn("Кейт пожимает плечами.")

		saynn("[say=kait]Анс кажется неплохим парнем. Заключенные выбрали его управлять ареной, так что он явно дело знает. Думаю, я ему доверяю.[/say]")

		saynn("[say=pc]Думаешь?[/say]")

		saynn("[say=kait]Да так, хрен знает, зачем он позвал Эви в эту команду.[/say]")

		saynn("[say=pc]Наверное, потому что она одна из лучших на арене.[/say]")

		saynn("[say=kait]Да ни черта она не лучшая, поверь мне. Она просто самая громкая.[/say]")

		saynn("[say=pc]В любом случае, чем больше рук в бою, тем лучше, не согласен?[/say]")

		saynn("Она снова пожимает плечами.")

		saynn("[say=kait]Может быть.[/say]")

		saynn("[say=pc]Ты ненавидишь Эви?[/say]")

		saynn("[say=kait]Конечно. Любой здравомыслящий человек бы её возненавидел.[/say]")

		saynn("[say=pc]Можешь назвать причины?[/say]")

		saynn("[say=kait]Она высокомерная, эгоистичная сука. К тому же дерется нечестно. Рано или поздно она нас предаст.[/say]")

		saynn("[say=pc]Понятно.[/say]")

		saynn("[say=kait]С чего это она вообще нам помогает? Иди и спроси её, если ещё не сделал этого.[/say]")

		saynn("Ты киваешь.")

		addButton("Продолжить", "Смотреть, что будет дальше", "talk_menu")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["kait"])
		return

	if(_action == "sex_69"):
		endScene()
		runScene("KaitLove69Scene")
		return

	if(_action == "sex_fingerher"):
		endScene()
		runScene("KaitLoveFingerHerScene")
		return

	if(_action == "sex_cowgirl"):
		endScene()
		runScene("KaitLoveRideYouScene")
		return

	if(_action == "dom_light"):
		endScene()
		setFlag("KaitModule.didKaitDomIntro", true)
		runScene("KaitObedienceLightDomScene")

	if(_action == "oral_sex"):
		endScene()
		runScene("KaitObedienceOralSexScene")

	if(_action == "obey_chokesex"):
		endScene()
		runScene("KaitObedienceChokeScene")
		return

	if(_action == "preg_menu"):
		endScene()
		runScene("KaitPregMenuScene")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["kaitLove"] = kaitLove
	data["kaitObedience"] = kaitObedience

	return data

func loadData(data):
	.loadData(data)

	kaitLove = SAVE.loadVar(data, "kaitLove", 0)
	kaitObedience = SAVE.loadVar(data, "kaitObedience", 0)
