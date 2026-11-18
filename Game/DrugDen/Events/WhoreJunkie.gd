extends DrugDenEventBase

func _init():
	id = "WhoreJunkie"
	eventWeight = 0.4

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return RNG.randi_range(2, 10)

func getStartCooldown() -> int:
	return RNG.randi_range(1, 10)

func getInteractInfo() -> Dictionary:
	return {
		text = "Вы замечаете торчка, который не кажется агрессивным.",
		actions = [
			{
				id = "approach",
				name = "Подойти",
				desc = "See what's up",
				args = [],
				disabled = false,
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	return {sceneID=RNG.pick(["DrugDenEventWhoreScene", "DrugDenEventWhoreSubScene"]), ended=true}

func getMapIcon():
	return RoomStuff.RoomSprite.IMPORTANT
