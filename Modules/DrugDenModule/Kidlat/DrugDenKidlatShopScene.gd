extends SceneBase

var isBound = false
var buyLine = ""

func _init():
	sceneID = "DrugDenKidlatShopScene"

func _run():
	if(state == ""):
		isBound = getModule("DrugDenModule").isKidlatBound()
		addCharacter("kidlat", [] if !getModule("DrugDenModule").isKidlatNaked() else ["naked"])
		playAnimation(StageScene.Duo, "stand", {npc="kidlat", kidlatBox=true, further=true, npcBodyState={naked=getModule("DrugDenModule").isKidlatNaked()}})
		var customGreet = getModule("DrugDenModule").getKidlatCustomGreeting()
		var drugDenEvent = GM.main.DrugDenRun.getEventInRoom(GM.pc.getLocation())
		var isFirstTimeThisFloor:bool = drugDenEvent.isFirstTimeThisFloor()
		var isFirstTimeThisRun:bool = drugDenEvent.isFirstTimeThisRun()
		var isOutOfItems:bool = drugDenEvent.isOutOfItems()
		var hasBap:bool = drugDenEvent.hasBap
		saynn("Вы находите Кидлат, стоящую за своей картонной коробкой.")

		if (buyLine != ""):
			saynn("[say=kidlat]"+str(buyLine if !isBound else "I hope you didn't just take it without paying.. This kitty kinda needs the creds.")+"[/say]")

			buyLine = ""
		elif (customGreet != ""):
			saynn("[say=kidlat]"+str(customGreet)+"[/say]")

		elif (isOutOfItems):
			saynn("[say=kidlat]"+str("You bought everything I have, hun! See you around." if !isBound else "Uh.. I think I don't have anything to sell anymore.. Find me again later!")+"[/say]")

		elif (isFirstTimeThisRun || isFirstTimeThisFloor):
			saynn("[say=kidlat]"+str("Hey, luv. Wanna trade?" if !isBound else "Oh, hey.. Welcome to my shop, don't mind how I look..")+"[/say]")

		else:
			saynn("[say=kidlat]"+str("Welcome back, hun." if !isBound else "Welcome back.. I think?")+"[/say]")

		saynn("Вот что она продает:")

		saynn(""+str(drugDenEvent.getItemsListText())+"")

		addButton("Уйти", "Пора идти", "endthescene")
		drugDenEvent.addBuyButtons(self)
		drugDenEvent.applyVisitFlags()
		if (false):
			addButton("Купить", "Купить что-нибудь", "buyKidlatItem")
		if (hasBap && !isBound):
			addButton("Буханка хлеба", "Цена: ? кредитов\n\nАппетитная буханка хлеба", "get_bapped")
		if (getFlag("DrugDenModule.Kidlat3Hap", false) && !isBound):
			addButton("Чат", "Спросить её о кое-чем", "chat_menu")
		if (isBound && !drugDenEvent.isOutOfItems()):
			addButton("Украсть", "Забрать товар бесплатно", "do_sell")
		if (isBound):
			if (!drugDenEvent.wasKidlatGroped()):
				addButton("Лапать", "Лапать беспомощную продавщицу", "do_grope")
				if (GM.pc.getInventory().getAmountOf("restraintkey") >= 2):
					addButton("Рассบายвать путы", "На Кидлат надето 2 пары наручников, так что тебе понадобится 2 ключа, чтобы освободить её!", "do_unlock_restraints")
				else:
					addDisabledButton("Рассบายвать путы", "(Недостаточно ключей) На Кидлат надето 2 пары наручников, так что тебе понадобится 2 ключа, чтобы освободить её!")
			else:
				addDisabledButton("Лапать", "Ты уже успел её пощупать, дай бедной кошечке отдохнуть.")
				addDisabledButton("Рассบายвать путы", "Если ты сначала её пощупаешь, а потом сразу спасешь, это будет выглядеть как-то подозрительно...")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["kidlatShop"])
	if(state == "just_unlock_this_time"):
		saynn("Ты используешь ключи, чтобы освободить бедняжку Кидлат.")

		saynn("[say=kidlat]О, привет, любовь моя. Спасибо! Ты снова спас меня из этих кандалов... И за это тоже...[/say]")

		saynn("Она подбегает к одному из углов и отрывает панель, после чего достает несколько предметов.")

		saynn("[say=kidlat]Могу предложить тебе пополнение запасов моего товара![/say]")

		saynn("Кидлат аккуратно раскладывает свой новый товар в картонную коробку.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "get_bapped"):
		saynn("Среди вещей, которые продает Кидлат, ты замечаешь кое-что необычное... В её коробке просто так лежит буханка хлеба. Выглядит аппетитно... куда вкуснее той обычной жижи, которую ешь ты... Похоже, цены на неё нет... значит, она бесплатная?")

		saynn("Ты тянешься, чтобы схватить его... но прежде чем твои пальцы успевают коснуться мягкой корочки, лапа Кидлат вылетает навстречу, отшлепывая твою руку с молниеносной скоростью!")

		saynn("[say=kidlat]Нет, моё![/say]")

		saynn("А?")

		saynn("[say=pc]Оно не продается? Зачем ты его тогда держишь?[/say]")

		saynn("[say=kidlat]Не твоё дело, дорогуша! Это мой хлеб для эмоциональной поддержки.[/say]")

		saynn("Справедливо... Ты поднимаешь руки, сдаваясь.")

		saynn("[say=kidlat]Мудрое решение~.[/say]")

		addButton("Продолжить", "Ну и ладно", "")
	if(state == "chat_menu"):
		saynn("О чем хочешь спросить Кидлат?")

		addButton("Преступления", "Спросить, что она натворила, чтобы оказаться в этой тюрьме", "ask_crimes")
		addButton("Притон", "Спросить, почему она здесь живет", "ask_drugden")
		if (getFlag("DrugDenModule.Kidlat5Hap")):
			addButton("Титры", "Спросить про кредиты", "ask_credits")
		else:
			addDisabledButton("Титры", "Она тебе еще недостаточно доверяет")
		addButton("Назад", "Назад в предыдущее меню", "")
	if(state == "ask_crimes"):
		saynn("Ты прислоняешься к ближайшей стене, показывая, что больше ничего покупать не собираешься. Кидлат закрывает свой картонный ящик и смотрит на тебя выжидающим взглядом.")

		saynn("[say=kidlat]Я тебе не покажу, где прячу свой заначек, дорогуша![/say]")

		saynn("[say=pc]Всё в порядке. Я просто хотел кое о чем спросить.[/say]")

		saynn("Её ушки навостряются... и на мгновение... она просто замирает, глядя на тебя.")

		saynn("[say=kidlat]О, да? Ну давай, что у тебя на уме?[/say]")

		saynn("[say=pc]Как ты здесь оказалась?[/say]")

		saynn("Она оглядывается по сторонам.")

		saynn("[say=kidlat]Ничего особенного? Просто однажды я набрела на эти туннели... И подумала, что они довольно прикольные.[/say]")

		saynn("Круто? Ну, это еще под вопросом... но ты ведь не об этом спрашивал.")

		saynn("[say=pc]Нет, я имею в виду... Что ты натворил, раз оказался здесь, в этой тюрьме? Почему на тебе лиловая форма?[/say]")

		saynn("Её пушистый хвост нерешительно дергается позади неё. Затем она издает короткий смешок и прислоняется спиной к стене, копируя твою позу.")

		saynn("[say=kidlat]Это долгая и скучная история. Такая же скучная, как и я. Тебе разве нечем заняться?[/say]")

		saynn("[say=pc]Я могу уделить тебе немного времени. Рассказывай, мне чертовски любопытно.[/say]")

		saynn("После долгой паузы она наконец снова заговаривает.")

		saynn("[say=kidlat]Ну, скажем так, я помогла бывшему корешу свистнуть грузовик. Большой куш, а? Там должно было быть полно всякой крутой хрени... ноутбуки, датапады и прочий оверпрайснутый хлам.[/say]")

		saynn("Интересно. Невольно задумываешься, почему на ней лиловый, а не оранжевый...")

		saynn("[say=kidlat]Уже засыпаешь? Могу и завязывать, дорогуша.[/say]")

		saynn("[say=pc]Нет, продолжай, пожалуйста.[/say]")

		saynn("Она пожимает плечами.")

		saynn("[say=kidlat]Все шло как по маслу... пока мы не притормозили, чтобы проверить хабар. Вся чертова куча была забита секс-игрушками.[/say]")

		saynn("Ты пытаешься... подавить смешок... но безуспешно. Кидлат ухмыляется... но её взгляд слегка темнеет.")

		saynn("[say=kidlat]Да, смейся, детка, не стесняйся.[/say]")

		saynn("[say=pc]В смысле, секс-игрушки тоже стоят недешево.[/say]")

		saynn("[say=kidlat]Может и так. Но их чертовски трудно сбывать... ну, в смысле, продавать. Хотя, конечно, тогда у нас мозги не варили. А потом мы услышали сирену.[/say]")

		saynn("Она скрещивает руки на груди, её хвост резко хлещет по земле.")

		saynn("[say=kidlat]Мой так называемый «напарник» решил запереть меня со всем этим «инвентарем» и свалить. Ну, остальное ты и так знаешь. Копы меня скрутили... в тюрьме нацепили ошейник и эту форму... И вот теперь я — ходячая шлюха, ура мне.[/say]")

		saynn("[say=pc]Жестко. Почему они так тебя предали?[/say]")

		saynn("Кидлат лишь пожимает плечами, стараясь не придавать этому значения.")

		saynn("[say=kidlat]У воров нет чести. А я — паршивая воровка. И человек еще хуже. Сама удивляюсь, как мы вообще умудрились так далеко зайти.[/say]")

		saynn("Она посмеивается.")

		saynn("[say=pc]Ты не плохой человек.[/say]")

		saynn("Она слегка отстраняется, глядя на тебя со скепсисом.")

		saynn("[say=kidlat]Только не вздумай меня жалеть. Здесь нет хороших людей, дорогуша.[/say]")

		saynn("На мгновение воцаряется тишина...")

		saynn("[say=kidlat]Разве что ты. До сих пор не пойму, с чего это ты решил помочь этой тупой синей кошачьей хреновине.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "chat_menu")
	if(state == "ask_drugden"):
		saynn("[say=pc]Могу я кое о чем спросить?[/say]")

		saynn("Ее уши приподнимаются и слегка дергаются.")

		saynn("[say=kidlat]Да, валяй.[/say]")

		saynn("[say=pc]Похоже, ты неплохо ориентируешься в этих туннелях.[/say]")

		saynn("Она ухмыляется, обнажая маленький клык.")

		saynn("[say=kidlat]Ага! Если тебе интересно, я тут не живу постоянно. У меня всё ещё есть камера и всё такое. Просто свободное время я провожу здесь.[/say]")

		saynn("Это сильно отличает её от торчков. Те к этому времени уже все мозги теряют... и думают только о новой дозе.")

		saynn("[say=pc]Ладно. Но что тянет тебя сюда?[/say]")

		saynn("Она пожимает плечами, небрежно прислонившись к стене и сложив руки на груди.")

		saynn("[say=kidlat]Тут можно заработать кредитов.[/say]")

		saynn("[say=pc]Кредиты можно заработать и наверху.[/say]")

		saynn("[say=kidlat]Весь день долбить камни? Это быстро надоедает.[/say]")

		saynn("В этом она чертовски права.")

		saynn("[say=pc]Есть и другие способы.[/say]")

		saynn("[say=kidlat]Хех, понимаю, о чём ты. Чувствую, из меня вышла бы хреновая шлюшка.[/say]")

		saynn("[say=pc]Я не говорила, что ты должна быть шлюхой. Есть много способов.[/say]")

		saynn("Она улыбается и покачивает девичьими бедрами из стороны в сторону, дразняще обхватывая лапками грудь, пока они скользят по контурам её живота. У тебя возникает чувство, что она была бы чертовски хорошей шлюхой... если бы только захотела.")

		saynn("[say=kidlat]Хех, а ты милашка, знаешь об этом?[/say]")

		saynn("[say=pc]А ты — еще тот сорванец.[/say]")

		saynn("Она высовывает тебе язык.")

		saynn("[say=kidlat]Маленький непослушный засранец~.[/say]")

		saynn("Воцаряется тишина... аура безответных вопросов гложет кошку.")

		saynn("[say=kidlat]Не знаю... просто чувствую, что мне здесь место. Я здесь как влитая. Надеюсь, это отвечает на твой вопрос.[/say]")

		saynn("Отвечает лишь отчасти.")

		addButton("Продолжить", "Смотреть, что будет дальше", "chat_menu")
	if(state == "ask_credits"):
		playAnimation(StageScene.Cuddling, "idle", {npc="kidlat"})
		saynn("[say=pc]Можно тебя кое о чем спросить?[/say]")

		saynn("[say=kidlat]Конечно, милый. Но можно я сначала спрошу тебя кое о чем?[/say]")

		saynn("Это необычно.")

		saynn("[say=pc]Давай, вперед.[/say]")

		saynn("[say=kidlat]Хочешь... немного пообниматься?..[/say]")

		saynn("Интередное предложение. От объятий еще никто не умирал...")

		saynn("[say=pc]Ладно.[/say]")

		saynn("Вы находите самое не самое мерзкое место поблизости и плюхаетесь на пол. И хотя поверхность холодная, теплые объятия помогают согреться...")

		saynn("[say=kidlat]Какой у тебя вопрос, милый?[/say]")

		saynn("[say=pc]Ты делаешь это ради кредитов? Ну, торгуешь всяким разным.[/say]")

		saynn("Она на мгновение задумывается, а затем вздыхает.")

		saynn("[say=kidlat]Кредиты — это то, на чем держится мир. Не думаю, что я очень жадная... но всем нам приходится ими быть, не так ли?[/say]")

		saynn("На это можно посмотреть и с такой стороны.")

		saynn("[say=kidlat]Без кредитов буквально не выжить. Но еще... чем больше у тебя богатства, тем больше друзей... и тем больше способов сбежать от плохих мыслей. Не хочется быть жадной... но такова жизнь.[/say]")

		saynn("В её словах чувствуются обугленные осколки её сердца.")

		saynn("[say=pc]По мне, так ты совсем не жадная.[/say]")

		saynn("Она улыбается и ластится к тебе щекой.")

		saynn("[say=kidlat]Ха, спасибо. Прости, дорогая, что вечно порчу настроение.[/say]")

		saynn("[say=pc]Всё в порядке. Твоё настроение вполне соответствует атмосфере этого места. Эти стены тоже на меня давят.[/say]")

		saynn("Она кивает и снова погружается в свои мысли.")

		saynn("[say=kidlat]Я заметила одно... как только ты перестаешь приносить пользу своим друзьям, они исчезают. Всё это... сплошная сделка, честное слово... К примеру, ты забудешь обо мне в мгновение ока, как только я перестану что-то продавать... Моё тупое бормотание, наверное, тоже тебя утомляет...[/say]")

		saynn("Смелое заявление.")

		saynn("[say=pc]Оно вовсе не тупое. С чего ты взяла, что я забуду тебя?[/say]")

		saynn("Она прижала ухо, а её щеки залил циановый румянец.")

		saynn("[say=kidlat]Надо было промолчать... Ты всегда отличался от моих других друзей... бывших друзей. Вообще-то... ты просто супер, любовь моя, даже не знаю, как отблагодарить тебя за всё, что ты сделал.[/say]")

		saynn("[say=pc]Не беспокойся об этом.[/say]")

		saynn("Ты притягиваешь её ближе и нежно ласкаешь по бокам. Твои уши улавливают её довольное мурчание.")

		saynn("[say=kidlat]Буду переживать сколько влезет~.[/say]")

		saynn("Она поворачивает голову и облизывает твой нос.")

		saynn("[say=kidlat]Но да, не расстраивайся, если забудешь меня... Я к этому привыкла.[/say]")

		saynn("[say=pc]Кидлат...[/say]")

		saynn("[say=kidlat]Прости-и-и.[/say]")

		saynn("Она улыбается и снова прижимается носом к твоей щеке.")

		saynn("[say=kidlat]Так что, ответ такой... Сами по себе кредиты особо не помогают... но то, на что я их трачу, немного облегчает жизнь. Надеюсь, ты понимаешь, о чем я.[/say]")

		saynn("Невольно задаешься вопросом, куда она девает все кредиты... Но, пожалуй, на объятий ей пока хватает.")

		saynn("Ты помогаешь ей подняться и возвращаешься обратно.")

		saynn("[say=kidlat]Хорошая сделка вышла, хех~.[/say]")

		saynn("Это точно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "chat_menu")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "buyKidlatItem"):
		var drugDenEvent = GM.main.DrugDenRun.getEventInRoom(GM.pc.getLocation())
		buyLine = drugDenEvent.doBuyItem(_args[0])
		return

	if(_action == "get_bapped"):
		setFlag("DrugDenModule.KidlatBap", true)
		var drugDenEvent = GM.main.DrugDenRun.getEventInRoom(GM.pc.getLocation())
		drugDenEvent.hasBap = false

	if(_action == "do_sell"):
		var drugDenEvent = GM.main.DrugDenRun.getEventInRoom(GM.pc.getLocation())
		buyLine = drugDenEvent.doStealAll()
		return

	if(_action == "do_grope"):
		var drugDenEvent = GM.main.DrugDenRun.getEventInRoom(GM.pc.getLocation())
		runScene("DrugDenKidlatBoundGropeScene")
		drugDenEvent.wasGroped = true
		return

	if(_action == "do_unlock_restraints"):
		GM.pc.getInventory().removeXOfOrDestroy("restraintkey", 2)
		setFlag("DrugDenModule.KidlatLockedUpRandomly", false)
		if(!getFlag("DrugDenModule.Kidlat5Hap", false)):
			setFlag("DrugDenModule.Kidlat5Hap", true)
			getCharacter("kidlat").resetEquipment()
			runScene("DrugDenKidlat5Scene")
			endScene()
		else:
			getCharacter("kidlat").resetEquipment()
			getModule("DrugDenModule").regenerateKidlatItems()
			setState("just_unlock_this_time")
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["isBound"] = isBound
	data["buyLine"] = buyLine

	return data

func loadData(data):
	.loadData(data)

	isBound = SAVE.loadVar(data, "isBound", false)
	buyLine = SAVE.loadVar(data, "buyLine", "")
