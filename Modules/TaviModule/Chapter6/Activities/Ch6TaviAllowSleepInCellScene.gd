extends SceneBase

var isCorrupt = false
var isPure = false
var isNormal = false
var isVirgin = false

func _init():
	sceneID = "Ch6TaviAllowSleepInCellScene"

func _run():
	if(state == ""):
		addCharacter("tavi")
		isCorrupt = getModule("TaviModule").isCorrupt()
		isPure = getModule("TaviModule").isPure()
		isNormal = (!isCorrupt && !isPure)
		isVirgin = getModule("TaviModule").isVirgin()
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		if (!getFlag("TaviModule.Ch6TaviSleepInPCCellFirstTime")):
			setFlag("TaviModule.Ch6TaviSleepInPCCellFirstTime", true)
			saynn("Ты уже несколько дней являешься владельцем Тави, и она научилась доверять тебе всё больше. Возможно, пришло время спросить, не хочет ли она спать в твоей камере вместе с тобой.")

			saynn("[say=pc]Эй. Тебе нравится спать в твоей камере?[/say]")

			saynn("Тави оглядывает своё тускло освещённое личное пространство. Маленькая комната, окружённая четырьмя холодными металлическими стенами с красными акцентами повсюду — напоминание о том, кто такая Тави.")

			saynn("[say=tavi]"+str(taviSpeak("It's.. fine. I'm used to sleeping in cells.", "I think hell would have been more comfy for me. But I'm not in a hurry.", "It's.. fine. I'm used to sleeping in cells."))+"[/say]")

			saynn("Она снова смотрит на тебя с любопытством.")

			saynn("[say=tavi]Интересно, почему ты об этом спрашиваешь?[/say]")

			saynn("[say=pc]Как тебе идея поспать в моей камере?[/say]")

			saynn("Тави слегка наклоняет голову, а затем мягко улыбается.")

			saynn("[say=tavi]"+str(taviSpeak("There is not a lot of space on these beds. But I can just be your blanket~.", "You sure you can handle my heat~? I'm one hot kitty.", "There is not a lot of space on these beds. Good thing cats can fit anywhere."))+"[/say]")

			saynn("Она подходит ближе и касается твоего носа своим — очень интимный жест.")

			saynn("[say=tavi]"+str(taviSpeak("Sure. If you give me permission, I will sleep with you. Or more~.", "Sure. Just give me permission and I will be all yours~.", "Sure. We can sleep together. Just let me know if you actually want that."))+"[/say]")

		else:
			saynn("Ты говоришь Тави, что хочешь обсудить идею того, чтобы она спала в твоей камере.")

			if (getFlag("TaviModule.Ch6TaviAllowedToSleepInPCCell")):
				saynn("В настоящее время Тави [b]будет[/b] спать в твоей камере по ночам, если у неё будет такая возможность.")

				if (getFlag("TaviModule.Ch6TaviAllowedToLewdPCDuringSleep")):
					saynn("Кроме того, Тави [b]будет[/b] время от времени утолять свою течку твоим телом.")

				else:
					saynn("Тави [b]не будет[/b] пытаться утолять свою течку твоим телом.")

			else:
				saynn("В данный момент Тави [b]не будет[/b] спать в твоей камере по ночам или утолять свою течку твоим телом.")

		addButton("Разрешить сон", "Позволить Тави спать в твоей камере по ночам", "toggle_sleep")
		addButton("Разрешить похоть", "Позволить Тави время от времени утолять течку во время сна с тобой", "toggle_lewd")
		addButton("Уйти", "Вы достаточно это обсудили", "endthescene")
func taviSpeak(normalSpeak, corruptSpeak, pureSpeak):
	if(isCorrupt):
		return corruptSpeak
	if(isPure):
		return pureSpeak
	return normalSpeak


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "toggle_sleep"):
		setFlag("TaviModule.Ch6TaviAllowedToSleepInPCCell", !getFlag("TaviModule.Ch6TaviAllowedToSleepInPCCell"))
		if(!getFlag("TaviModule.Ch6TaviAllowedToSleepInPCCell")):
			setFlag("TaviModule.Ch6TaviAllowedToLewdPCDuringSleep", false)
		return

	if(_action == "toggle_lewd"):
		setFlag("TaviModule.Ch6TaviAllowedToLewdPCDuringSleep", !getFlag("TaviModule.Ch6TaviAllowedToLewdPCDuringSleep"))
		if(getFlag("TaviModule.Ch6TaviAllowedToLewdPCDuringSleep")):
			setFlag("TaviModule.Ch6TaviAllowedToSleepInPCCell", true)
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["isCorrupt"] = isCorrupt
	data["isPure"] = isPure
	data["isNormal"] = isNormal
	data["isVirgin"] = isVirgin

	return data

func loadData(data):
	.loadData(data)

	isCorrupt = SAVE.loadVar(data, "isCorrupt", false)
	isPure = SAVE.loadVar(data, "isPure", false)
	isNormal = SAVE.loadVar(data, "isNormal", false)
	isVirgin = SAVE.loadVar(data, "isVirgin", false)
