extends SceneBase

func _init():
	sceneID = "ElizaBackupPCSaveScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		saynn("Пустые, оглушительные мысли проносятся сквозь твой безмолвный разум, нарушая покой..")

		saynn("[say=eliza]Да где же этот чертов заключенный?![/say]")

		saynn("Если подумать еще раз.. возможно, это не совсем твои мысли..")

		saynn("[say=eliza]Только не говори мне, что они запихали {pc.him} в какой-нибудь технический люк или типа того..[/say]")

		saynn("Знакомый голос.. всё ближе и ближе.. Главное — не идти на него.. на всякий случай.")

		saynn("[say=eliza]Я не инженер. Я скорее ломаю вещи, чем чиню их, ха![/say]")

		saynn("Твоё ухо улавливает вибрацию воздуха — чей-то судорожный вздох.")

		saynn("[say=eliza]О! Вот так-то лучше. Ленивые медсестры, в моем контракте такого точно не было, когда я подписывалась![/say]")

		saynn("Ты чувствуешь, как игла пронзает твою кожу. Ой..")

		addButton("Встать", "Ты чувствуешь, как сознание начинает пробуждаться..", "do_wakeup")
	if(state == "do_wakeup"):
		playAnimation(StageScene.SexStart, "idle", {pc="eliza", npc="pc"})
		saynn("Боль не уходит. Напротив, теперь, когда сознание возвращается, она ощущается даже сильнее...")

		saynn("[say=eliza]Ну же! Не смей отворачиваться, у меня нет лишних пяти минут, просыпайся уже, пациент![/say]")

		saynn("[say=pc]Голова раскалывается...[/say]")

		saynn("Вы слышите тихий смешок. Открыв глаза, вы видите кошкодевочку, сидящую рядом; на ней лабораторный халат поверх простого топа и юбки-карандаша.")

		saynn("[say=eliza]"+str( RNG.pick(["I shared one of mine nine lives with you. So you better treasure this one more.", "I hope I didn't give you too big of a dose.. That'd be wasteful! Don't worry, if you start seeing colors, that's completely intentional.", "I've seen test subjects hold up better than you, but hey, you're still in one piece.. more or less.", "You really do make a perfect crash test dummy. Good thing I like fixing broken toys~.", "Next time you blackout, I'll charge you extra for this. Science isn't cheap!", "That drug should bring you back in one piece. And if it doesn't.. at least try to have fun while you can!", "This drug will maybe give you superhuman strength or maybe it'll just make you giggle uncontrollably. Who knows, haha.", "I'll fix you up, but remember, every dose brings you a little closer to being my favorite experiment~.", "You're like my favorite toy - so durable! Let's keep it that way.", "Do try to stay upright this time. My drug stash isn't infinite, and I'm not sharing my personal supply.", "You'll be fine. And if you're not, at least I'll get some interesting data out of it."]) )+"[/say]")

		saynn("О чем она... говорит...")

		saynn("[say=eliza]Еще увидимся, пациент~.[/say]")

		saynn("Она проводит быстрый финальный осмотр...")

		if (GM.pc.hasEffect(StatusEffect.StretchedPainfullyAnus) || GM.pc.hasEffect(StatusEffect.StretchedPainfullyPussy) || GM.pc.hasEffect(StatusEffect.Wounded)):
			saynn("[say=eliza]Похоже, ночка у тебя выдалась та еще... Загляни ко мне как-нибудь, если это не пройдет. Обожаю тесты... то есть, обожаю помогать.[/say]")

		elif (GM.pc.getPainLevel() >= 0.5):
			saynn("[say=eliza]Столько синяков... Тебе стоит попробовать отлежаться. У меня есть как раз подходящее местечко, очень мягкое~. Нет? Оу.[/say]")

		else:
			saynn("[say=eliza]Вроде бы ты в порядке. Хорошо.[/say]")

		saynn("..а затем оставляет тебя в одиночестве.")

		saynn("Пора идти..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_wakeup"):
		processTime(3*60)

	setState(_action)
