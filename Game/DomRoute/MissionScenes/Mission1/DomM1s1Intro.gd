extends SceneBase

func _init():
	sceneID = "DomM1s1Intro"

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		addCharacter("kait")
		saynn("[say=pc]Пошли заберем эти записи.[/say]")

		saynn("Кейт нетерпеливо подпрыгивает.")

		saynn("[say=kait]Наше первое ограбление, ебать-копать! Пойду соберу всех.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "explain_stuff")
	if(state == "explain_stuff"):
		addCharacter("announcer")
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="kait", pc="announcer"})
		saynn("Спустя несколько минут Кейт возвращается с Эви и Анс.")

		saynn("Вы начинаете обсуждать план.")

		saynn("[say=kait]Датапад явно не вариант. Его же просто сотрут.[/say]")

		saynn("[say=announcer]У меня есть идея. Что, если мы используем древний кусок технологии... известный как принтер?[/say]")

		saynn("[say=kait]Принтер? Древний? Да их повсюду используют.[/say]")
		
		saynn("Анс вскидывает бровь.")
		
		saynn("[say=announcer]Серьезно? Не там, откуда я родом.[/say]")
		
		saynn("[say=kait]Хочешь распечатать тысячи записей? Как именно?[/say]")

		saynn("[say=announcer]Найди любую консоль. Отсортируй личные дела заключенных по... длине списка преступлений. И распечатаем топ двадцать или около того. Как раз на одну страницу влезет.[/say]")

		saynn("[say=avy]Только меня сначала исключи, а то я буду первым в этом списке.[/say]")

		saynn("Кейт на мгновение закатывает глаза.")

		saynn("[say=kait]Очень смешно, Эви.[/say]")

		saynn("Снежная леопардица потирает подбородок.")

		saynn("[say=kait]Хм... Странно. Но это может сработать. Бумагу-то они удаленно не сотрут. Ты знаешь, к каким консолям можно подобраться?[/say]")

		saynn("[say=announcer]На командной палубе полно кабинетов. Всё, что нужно — это бейдж сотрудника.[/say]")

		saynn("[say=pc]На командной палубе?[/say]")

		saynn("[say=avy]Да не бойся ты. Там наверху сборище сопляков. В худшем случае наткнешься на охранника или двух.[/say]")

		saynn("[say=kait]Тогда я схожу за Рахи. Давайте все встретимся у контрольно-пропускного пункта, перед главным лифтом.[/say]")

		saynn("[say=announcer]Надеюсь, без меня можно обойтись. Арене нужно присматривать.[/say]")

		saynn("[say=kait]Тебе стоит остаться и заняться этим, ты и так нам во всём помогла.[/say]")

		saynn("Ан кивает.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "explain_stuff"):
		processTime(5*60)
		addMessage("Task updated!")

	setState(_action)
