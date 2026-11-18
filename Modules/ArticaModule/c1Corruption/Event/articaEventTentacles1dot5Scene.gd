extends SceneBase

func _init():
	sceneID = "articaEventTentacles1dot5Scene"

func _reactInit():
	addExperienceToPlayer(30)
	setFlag("ArticaModule.TentaclesArticaHasFlower", true)

func _run():
	if(state == ""):
		addCharacter("artica")
		saynn("Ты показываешь Артике то странное маленькое растение, которое ей не удалось украсть тогда, в оранжереях. Её глаза мгновенно расширяются при виде него.")

		saynn("[say=artica]Э-это.. Я.. Гм.. М-можно мне.. эм-м..[/say]")

		saynn("Без лишних поддразниваний ты просто берешь её лапку и вкладываешь цветок ей в руку.")

		saynn("[say=pc]Вот, держи. Тебе не нужно ничего мне объяснять, Артика. Он твой.[/say]")

		saynn("Артика встает на цыпочки, её хвост бешено виляет за спиной, а щеки заливает румянец.")

		saynn("[say=artica]С-спасибо.. Я.. с-спасибо..[/say]")

		saynn("Ты киваешь. Тебе становится чертовски любопытно, что она и этот доктор задумали с ним.. Остается только ждать.. и смотреть, что будет дальше..")

		addButton("Продолжить", "Посмотреть, что будет", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
