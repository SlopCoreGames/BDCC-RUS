extends NpcOwnerTraitBase

func _init():
	id = "Kind"

func getVisibleName() -> String:
	return "Добрый"

func getVisibleDescription() -> String:
	return "Владелец будет чуть реже творить с тобой всякие гадости. А еще он может решить тебя не наказывать."

func getPossiblePCNamesForLevel(_npcOwner, _level:int) -> Array:
	#var ownerHasVagina:bool = _npcOwner.getOwner().hasVagina()
	if(_level <= 1):
		return ["pet", "dear", "sweetie", "cupcake", "brat", "toy"]
	if(_level <= 2):
		return ["softie", "hun", "pearl", "snowdrop", "sweetheart"]
	return ["angel", "bunny", "flower", "love", "starlight", "hun"]

func getTraitScore(_npcOwner) -> float:
	var personality:Personality = _npcOwner.getOwner().getPersonality()
	var theMean:float = personality.getStat(PersonalityStat.Mean)
	if(theMean > 0.0):
		return 0.0
	return max(-theMean, 0.2)

func getTraitExclusiveType() -> String:
	return "meanness"

func getEventTags(_npcOwner) -> Dictionary:
	return {
		NOET.Kind: 1.0,
	}

func getEventWeightMults(_npcOwner) -> Dictionary:
	return {
		NOET.Mean: 0.5,
	}

func getNOMs(_npcOwner) -> Dictionary:
	return {
		NOM.Kind: 1.0,
	}

func getSkipPunishmentChance() -> float:
	return 50.0

#bunny kitty doll brat servant
