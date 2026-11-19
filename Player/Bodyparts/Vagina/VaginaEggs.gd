extends BodypartVagina

func _init():
	visibleName = "vagina"
	id = "vaginaEggs"

func getCompatibleSpecies():
	return [Species.Any]

func hasWomb():
	return true

func shouldOvulateWithBigEggs() -> bool:
	return true

func getCharacterCreatorName():
	return "Вагина (откладывает яйца)"

func getCharacterCreatorDesc():
	return "Вагина, которая откладывает яйца вместо живорождения"

func getTraits():
	return {
		PartTrait.LaysEggs: true,
	}

func getTransformGrowMessage(_context:Dictionary) -> String:
	return .getTransformGrowMessage(_context)+" Этот тоже особенный... в каком-то смысле..."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return .getTransformMorphMessage(_context)+" Этот тоже особенный... в каком-то смысле..."
