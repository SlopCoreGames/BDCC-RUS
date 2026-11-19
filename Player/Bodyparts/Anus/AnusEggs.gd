extends BodypartAnus

func _init():
	visibleName = "cloaca"
	id = "anusEggs"

func getCompatibleSpecies():
	return [Species.Any]

func hasWomb():
	return true

func shouldOvulateWithBigEggs() -> bool:
	return true

func getCharacterCreatorName():
	return "Клоака (откладывает яйца)"

func getCharacterCreatorDesc():
	return "Уникальный вид ануса, способный откладывать оплодотворенные яйца"

func getTraits():
	return {
		PartTrait.AnusWomb: true,
		PartTrait.LaysEggs: true,
	}

func getTransformGrowMessage(_context:Dictionary) -> String:
	return .getTransformGrowMessage(_context)+" Этот тоже особенный... в каком-то смысле..."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return .getTransformMorphMessage(_context)+" Этот тоже особенный... в каком-то смысле..."
