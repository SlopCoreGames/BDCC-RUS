extends SceneBase

func _init():
	sceneID = "ElizaTFHerScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Теперь, когда вы разблокировали определенные препараты для трансформации, вы можете приказывать Элизе принимать их. Она будет выполнять лишь некоторые из них.")

		saynn("Что именно вы хотите изменить в Элизе?")

		addButton("Готово", "Достаточно копания", "endthescene")
		if (getFlag("ElizaModule.tfcan_cocks") || getFlag("ElizaModule.tfcan_felinecock", false)):
			addButton("Член", "Изменить пенис Элизы или избавиться от него", "penis_menu")
		else:
			addDisabledButton("Член", "Вы еще не разблокировали препарат, способный на это...")
		if (getFlag("ElizaModule.tfcan_species") || getFlag("ElizaModule.tfcan_demon") || getFlag("ElizaModule.tfcan_catgirl")):
			addButton("Вид", "Изменить вид Элизы", "species_menu")
		else:
			addDisabledButton("Вид", "Вы еще не разблокировали препарат, способный на это...")
		if (getFlag("ElizaModule.tfcan_hucow")):
			addButton("Тело", "Изменить тело Элизы", "body_menu")
		else:
			addDisabledButton("Тело", "Вы еще не разблокировали препарат, способный на это...")
	if(state == "penis_menu"):
		playAnimation(StageScene.Solo, "stand", {pc="eliza", bodyState={naked=true, hard=true}})
		saynn("Какой пенис вы хотите дать Элизе?")

		addButton("Подтвердить", "Сделать её такой", "")
		addButton("Без члена", "Сказать ей оставаться в обычном виде", "cock_no")
		if(getFlag("ElizaModule.tfcan_felinecock", false)):
			addButton("Кошачий", "Велеть ей отрастить кошачий член", "cock_feline")
		else:
			addDisabledButton("Кошачий", "Вы еще не разблокировали препарат, способный на это...")
		if(getFlag("ElizaModule.tfcan_cocks")):
			addButton("Собачий", "Велеть ей отрастить собачий член", "cock_canine")
			addButton("Драконий", "Велеть ей отрастить драконий член", "cock_dragon")
			addButton("Конский", "Приказать ей отрастить лошадиный член", "cock_horse")
			addButton("Человек", "Приказать ей отрастить человеческий член", "cock_human")
		else:
			addDisabledButton("Собачий", "Вы еще не разблокировали препарат, способный на это...")
			addDisabledButton("Драконий", "Вы еще не разблокировали препарат, способный на это...")
			addDisabledButton("Конский", "Вы еще не разблокировали препарат, способный на это...")
			addDisabledButton("Человек", "Вы еще не разблокировали препарат, способный на это...")
	if(state == "species_menu"):
		playAnimation(StageScene.Solo, "stand", {pc="eliza", bodyState={naked=true, hard=true}})
		saynn("Как вы хотите изменить вид Элизы?")

		addButton("Подтвердить", "Сделать её такой", "")
		addButton("Кошачий", "Оставить Элизу прежней", "species_feline")
		if (getFlag("ElizaModule.tfcan_demon")):
			addButton("Демон", "Сделать Элизу полудемоном", "species_demon")
		if (getFlag("ElizaModule.tfcan_catgirl")):
			addButton("Кошкодевочка", "Сделать Элизу кошкодевочкой", "species_catgirl")
		if (getFlag("ElizaModule.tfcan_species")):
			addButton("Драконий", "Превратить Элизу в дракона", "species_dragon")
			addButton("Человек", "Превратить Элизу в человека", "species_human")
	if(state == "body_menu"):
		playAnimation(StageScene.Solo, "stand", {pc="eliza", bodyState={naked=true, hard=true}})
		saynn("Как именно вы хотите изменить тело Элизы?")

		addButton("Подтвердить", "Сделать её такой", "")
		addButton("Обычный", "Оставить Элизу прежней", "body_normal")
		if (getFlag("ElizaModule.tfcan_hucow")):
			addButton("Челококорова", "Сделать Элизе огромные вымя", "body_hucow")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "cock_no"):
		setFlag("ElizaModule.elizatf_cock", "")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "cock_canine"):
		setFlag("ElizaModule.elizatf_cock", "canine")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "cock_feline"):
		setFlag("ElizaModule.elizatf_cock", "feline")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "cock_dragon"):
		setFlag("ElizaModule.elizatf_cock", "dragon")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "cock_horse"):
		setFlag("ElizaModule.elizatf_cock", "horse")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "cock_human"):
		setFlag("ElizaModule.elizatf_cock", "human")
		getCharacter("eliza").updateBodyparts()
		setState("penis_menu")
		return

	if(_action == "species_feline"):
		setFlag("ElizaModule.elizatf_species", "")
		getCharacter("eliza").updateBodyparts()
		setState("species_menu")
		return

	if(_action == "species_demon"):
		setFlag("ElizaModule.elizatf_species", "demon")
		getCharacter("eliza").updateBodyparts()
		setState("species_menu")
		return

	if(_action == "species_dragon"):
		setFlag("ElizaModule.elizatf_species", "dragon")
		getCharacter("eliza").updateBodyparts()
		setState("species_menu")
		return

	if(_action == "species_catgirl"):
		setFlag("ElizaModule.elizatf_species", "catgirl")
		getCharacter("eliza").updateBodyparts()
		setState("species_menu")
		return

	if(_action == "species_human"):
		setFlag("ElizaModule.elizatf_species", "human")
		getCharacter("eliza").updateBodyparts()
		setState("species_menu")
		return

	if(_action == "body_normal"):
		setFlag("ElizaModule.elizatf_body", "")
		getCharacter("eliza").updateBodyparts()
		setState("body_menu")
		return

	if(_action == "body_hucow"):
		setFlag("ElizaModule.elizatf_body", "hucow")
		getCharacter("eliza").updateBodyparts()
		setState("body_menu")
		return

	setState(_action)
