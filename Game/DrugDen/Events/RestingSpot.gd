extends DrugDenEventBase

func _init():
	id = "RestingSpot"

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return RNG.randi_range(1, 2)

func getStartCooldown() -> int:
	return RNG.randi_range(1, 2)

func getInteractInfo() -> Dictionary:
	return {
		text = "Вы нашли чьё-то место для отдыха! Здесь можно вздремнуть, чтобы полностью восстановить выносливость, или заняться мастурбацией, чтобы снять возбуждение!",
		actions = [
			{
				id = "rest",
				name = "Отдохнуть",
				desc = "Fully restore your stamina.",
				args = [],
				disabled = false,
			},
			{
				id = "masturbate",
				name = "Подрочить",
				desc = "Get rid of your lust. Your hands and arms have to be free.",
				args = [],
				disabled = (GM.pc.hasBoundArms() || GM.pc.hasBlockedHands()),
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	if(_actionID == "rest"):
		GM.pc.addStamina(GM.pc.getMaxStamina())
		GM.pc.addIntoxication(-0.5)
		return {text="You rest for a bit and now feel energized.", ended=true, anim=[StageScene.Sleeping, "sleep"]}
	
	GM.pc.orgasmFrom("pc")
	return {text="You get as comfy as you can and masturbate until you cum, which helps to clear your mind!", ended=true, anim=[StageScene.Grope, "watchstroke" if GM.pc.hasReachablePenis() else "watchrub", {onlyPC=true, pcCum=true, bodyState={naked=true,hard=true}}]}

func getMapIcon():
	return RoomStuff.RoomSprite.BED
