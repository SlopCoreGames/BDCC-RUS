extends BodypartAnus

func _init():
	visibleName = "anus"
	id = "anuswomb"

func getCompatibleSpecies():
	return [Species.Any]

func hasWomb():
	return true

func getCharacterCreatorName():
	return "Анус (с маткой)"

func getCharacterCreatorDesc():
	return "Уникальный вид ануса, имеющий связь с маткой. Выбрав этот вариант, вы сможете забеременеть при анальном сексе"

func getTraits():
	return {
		PartTrait.AnusWomb: true,
	}

func getTransformGrowMessage(_context:Dictionary) -> String:
	return .getTransformGrowMessage(_context)+" Этот тоже особенный... в каком-то смысле..."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return .getTransformMorphMessage(_context)+" Этот тоже особенный... в каком-то смысле..."
