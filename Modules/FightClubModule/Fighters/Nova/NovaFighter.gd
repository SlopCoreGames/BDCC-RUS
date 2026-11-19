extends FightClubFighter

func _init():
	id = "nova"
	
func getVisibleName():
	return "Нова"

func getNameAndNickname():
	return "Нова, Ангел"

func getAvyIntroduction():
	return "Твой следующий противник — Нова. Она бывшая заключенная, так что, хоть сейчас она и работает охранницей, это место ей до боли знакомо. Везучая сучка — скорее всего, сосала и трахалась во все дыры, чтобы вырваться на свободу, что тут скажешь."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Нова! Она была достаточно добра, чтобы не стучать на нас, и даже прикрывает нас от остального персонала в обмен на право драться здесь! Встречайте!"
	
func getRank():
	return FightClubRank.PlayToy

func getOrder():
	return 50

func getFightCharacter():
	return "novaArena"

func getWinScene():
	return "NovaWonScene"

func getLoseScene():
	return "NovaLostToScene"

func getWinExperience():
	return 100

func getWinCredits():
	return 7
