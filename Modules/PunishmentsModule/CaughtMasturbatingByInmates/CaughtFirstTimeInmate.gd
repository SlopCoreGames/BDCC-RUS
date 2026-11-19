extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "CaughtFirstTimeInmate"

func _reactInit():
	if(RNG.chance(50)):
		var zone = BodyWritingsZone.getRandomZone()
		GM.pc.addBodywriting(zone, BodyWritings.getRandomWritingIDForZone(zone))
		addMessage("Хотя она также оставила тебе память на твоем... "+BodyWritingsZone.getZoneVisibleName(zone)+"..")

func _run():
	if(state == ""):
		addCharacter("inmateShemale")
		playAnimation(StageScene.Solo, "defeat")

	if(state == ""):
		saynn("Ты вовсю ласкал себя, как вдруг кто-то толкнул тебя в спину. Ой! Ты приземляешься на пол и чувствуешь, как кто-то придавливает тебя к земле — какая-то заключенная. Она упирается коленом тебе в спину, что-то шепча прямо в ухо.")

		saynn("[say=inmateShemale]Посмотри на себя, маленькая похотливая штучка. Тебе никто не говорил, что ты играешь в очень опасную игру~[/say]")

		saynn("Ты чувствуешь, как что-то упирается тебе в задницу. О, она определенно дикгёрл.")

		saynn("[say=inmateShemale]Хах. Чувствуешь? Продолжай в том же духе, и очень скоро станешь шлюхой для общего пользования~. Надеюсь, ты меня услышала.[/say]")

		saynn("Ты слегка киваешь, всё понимая. Она решает проявить милосердие и просто уходит.")

		# (scene ends)
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

