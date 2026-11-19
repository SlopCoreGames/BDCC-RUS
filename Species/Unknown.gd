extends Species

func _init():
	id = Species.Unknown
	
func getVisibleName():
	return "???"

func isPlayable():
	return false

func getVisibleDescription():
	return "Тебе не стоит этого видеть"
