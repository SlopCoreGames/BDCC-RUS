extends DrugDenEventBase

func _init():
	id = "LockedLockerMedical"
	eventWeight = 0.4

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return RNG.randi_range(2, 6)

func getStartCooldown() -> int:
	return RNG.randi_range(2, 6)

func getInteractInfo() -> Dictionary:
	return {
		text = "Вы натыкаетесь на запертый [b]медицинский[/b] шкафчик. Чтобы заглянуть внутрь, понадобится 1 ключ сдерживания.",
		actions = [
			{
				id = "loot",
				name = "Открыть ключом",
				desc = "Используйте 1 ключ от наручников, чтобы открыть этот шкафчик!",
				args = [],
				disabled = !GM.pc.getInventory().hasItemID("restraintkey"),
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	GM.pc.getInventory().removeXOfOrDestroy("restraintkey", 1)
	return {text="Вы используете ключ, чтобы открыть медицинский шкафчик...", noLootText="К сожалению, здесь пусто.", lootTable="junkieMedicalLocker", ended=true}

func getMapIcon():
	return RoomStuff.RoomSprite.IMPORTANT
