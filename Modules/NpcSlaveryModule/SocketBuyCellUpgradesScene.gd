extends SceneBase

var selectedVent = ""

func _init():
	sceneID = "SocketBuyCellUpgradesScene"

func _reactInit():
	return

func _run():
	if(state == ""):
		addCharacter("socket")
		playAnimation(StageScene.Duo, "stand", {npc="socket"})
		
		saynn("Розетка показывает список улучшений, которые она может провести в твоей камере.")
		addButtonAt(14, "Назад", "Хватит покупок", "endthescene")
		
		var howManySlavesSpaces = getModule("NpcSlaveryModule").getSlavesSpace()
		if(howManySlavesSpaces == 0):
			sayn("[b]Расширение камеры[/b]")
			sayn("Позволяет держать в камере одного человека. Укомплектовано металлическим крюком, к которому можно пристегнуть рабыню на поводок.")
			saynn("Цена: "+str(getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost())+" credits")
			addButtonWithChecks("Расширение камеры", "Оплатить улучшение", "first_expansion", [], [[ButtonChecks.HasCredits, getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost()]])
		else:
			sayn("[b]Расширение камеры[/b]")
			sayn("Позволяет держать в твоей камере "+str(howManySlavesSpaces+1)+" рабынь.")
			saynn("Цена: "+str(getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost())+" credits")
			addButtonWithChecks("Расширение камеры", "Оплатить улучшение", "do_cell_expansion", [], [[ButtonChecks.HasCredits, getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost()]])
		var canHaveSlaves = (howManySlavesSpaces > 0)
		
		var hasSybian = getFlag("NpcSlaveryModule.hasSybian", false)
		var sybianPrice = 25
		sayn("[b]Сибиан[/b]")
		if(canHaveSlaves):
			sayn("Установите сибиан в своей камере — вы сможете использовать её сами или давать в награду своим рабыням.")
		else:
			sayn("Установить сибиан в камере.")
		saynn("Цена: "+((str(sybianPrice)+" credits") if !hasSybian else "Куплено!")+"")
		if(!hasSybian):
			addButtonWithChecks("Сибиан", "Оплатить установку сибиана в вашей камере", "pay_upgrade", ["NpcSlaveryModule.hasSybian", sybianPrice, "В вашей камере установлена машина Сибиан"], [[ButtonChecks.HasCredits, sybianPrice]])
	
		var hasHorse = getFlag("NpcSlaveryModule.hasWoodenHorse", false)
		var horsePrice = 30
		sayn("[b]Деревянная лошадка[/b]")
		if(canHaveSlaves):
			sayn("Установите в своей камере пыточный аппарат «деревянная лошадка», чтобы наказывать им своих рабынь.")
		else:
			sayn("Установить «деревянную лошадку» в своей камере. Просто так, без особой причины.")
		saynn("Цена: "+((str(horsePrice)+" credits") if !hasHorse else "Куплено!")+"")
		if(!hasHorse):
			addButtonWithChecks("Деревянная лошадь", "Оплатить установку «деревянной лошадки» в вашей камере", "pay_upgrade", ["NpcSlaveryModule.hasWoodenHorse", horsePrice, "В вашей камере установлен деревянный конь"], [[ButtonChecks.HasCredits, horsePrice]])
	
	
	if(state == "do_cell_expansion"):
		saynn("Вы платите Сокет необходимую сумму кредитов за расширение камеры.")
		
		saynn("Она приступает к расширению стены вашей камеры, позволяя вам при желании поселить в ней ещё одного человека!")
		
		saynn("На это у неё уходит около часа.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "")
	
	if(state == "first_expansion"):
		saynn("Первое улучшение кажется тебе довольно любопытным.")
		
		saynn("[say=pc]Расширение камеры?[/say]")
		
		saynn("Сокет несколько раз кивает.")
		
		saynn("[say=socket]Глядя на чертежи тюрьмы, кажется, что за всеми камерами есть огромный буфер. Там сплошная порода... Но знаешь, я могу всё это расчистить![/say]")
		
		saynn("Интересно. Сейчас твоя камера невероятно тесная.")
		
		saynn("[say=pc]А в это улучшение входит дополнительная кровать?[/say]")
		
		saynn("Сокет смотрит в свой датапад... а затем качает головой.")
		
		saynn("[say=socket]Не-а! Это всего лишь бурение астероида и небольшое отодвигание стены назад.[/say]")

		saynn("Остаётся надеяться, что она не пробурит дыру в открытый космос...")
		
		saynn("[say=socket]Ну? Что скажешь?[/say]")
		
		saynn("Стоимость: "+str(getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost())+" credits.")
		
		addButtonWithChecks("Согласиться", "Отдать ей кредиты", "first_expansion_do_pay", [], [[ButtonChecks.HasCredits, getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost()]])
		addButton("Проехали", "Вы передумали", "")

	if(state == "first_expansion_do_pay"):
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		
		saynn("Ты киваешь и платишь Сокет кредиты. Как только ты это делаешь, она выхватывает гигантское промышленное сверло, состоящее из трех вращающихся модулей с кучей «зубьев» на каждом. Её глаза ярко горят, пока она держит его в руках.")
		
		saynn("[say=socket]Ура! Погнали![/say]")
		
		saynn("Ты приводишь Сокет в свою камеру. Хм, другие инженеры уже там — они разбирают заднюю стенку твоей камеры, обнажая скальную породу. Затем они помогают Сокет собрать гигантское сверло.")

		saynn("[say=pc]Зачем нам вообще кирки, если существует такая штука?[/say]")
		
		saynn("Сокет заканчивает подготовку сверла и включает его; оно с громким рыком вгрызается в скалу.")
		
		saynn("[say=socket]Кто сказал, что не используем? Но иногда нужна более тонкая работа! Эта крошка может разнести твои месторождения урана быстрее, чем гигантский узловатый хер разнесет девственную киску! И то, и другое приведет к мощному взрыву![/say]")

		saynn("Да, сразу видно, как оно просто перемалывает любую породу в пыль. Любые ресурсы будут безвозвратно потеряны.")

		saynn("Когда дрель закончила свою работу, Сокет и другие инженеры быстро восстанавливают укрепленную стену твоей камеры, превращая её снова в уютную металлическую коробку.")

		saynn("[say=socket]Ну вот и всё. Развлекайся![/say]")
		
		saynn("Инженеры упаковывают дрель и уносят её. Теперь вы остались только вдвоем с Сокет.")
		
		saynn("[say=socket]Посмотри, что теперь можно делать![/say]")
		
		addButton("Смотреть", "Смотреть, что будет дальше", "first_expansion_showchains")
		
	if(state == "first_expansion_showchains"):
		playAnimation(StageScene.Duo, "stand", {npc="socket", npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		
		saynn("Сокет протягивает тебе цепь на поводке. Она пристегивает один конец к своей одежде, а другой — к металлическому крюку на полу, который раньше служил опорой для дрели.")

		saynn("[say=socket]Та-да! Ну разве не весело? Теперь я вроде как твоя личная секс-игрушка![/say]")
		
		saynn("В чем-то она права... Ты подходишь к Сокет и начинаешь играть с цепью.")
		
		saynn("[say=pc]Значит, теперь ты можешь меня держать?[/say]")
		
		saynn("[say=socket]У меня еще полно дел, может, как-нибудь в другой раз! Но если хочешь, можешь оставить поводок себе.[/say]")
		
		saynn("Она протягивает тебе поводок и направляется к выходу.")
		
		saynn("[say=socket]Береги себя![/say]")
		
		saynn("Похоже, теперь ты можешь держать кого-то у себя в камере.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescenenosocket")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		runScene("SocketTalkScene")
		return
	
	if(_action == "endthescenenosocket"):
		endScene()
		return
	
	if(_action == "pay_upgrade"):
		setFlag(_args[0], true)
		GM.pc.addCredits(-_args[1])
		addMessage(_args[2])
		return
	
	if(_action == "first_expansion_do_pay"):
		processTime(60*60)
		GM.pc.addCredits(-getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost())
		increaseFlag("NpcSlaveryModule.slavesSpace")
		
	if(_action == "do_cell_expansion"):
		processTime(60*60)
		GM.pc.addCredits(-getModule("NpcSlaveryModule").getSlavesSpaceUpgradeCost())
		increaseFlag("NpcSlaveryModule.slavesSpace")
		
	setState(_action)

func saveData():
	var data = .saveData()

	data["selectedVent"] = selectedVent

	return data

func loadData(data):
	.loadData(data)

	selectedVent = SAVE.loadVar(data, "selectedVent", "")
