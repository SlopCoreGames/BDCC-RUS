extends FightClubFighter

func _init():
	id = "axis"
	
func getVisibleName():
	return "Аксис"

func getNameAndNickname():
	return "Аксис, Альфа"

func getAvyIntroduction():
	return "Твой следующий противник — Аксис. Типичный качок, которому чертовски повезло заскочить высоко в таблице лидеров и удержаться там. Одиночка, но при этом охренительно флиртующий тип; не буду врать, я сама чуть было не развела ноги перед ним — от его запаха просто сносит крышу."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Аксис. Один из наших лучших бойцов, настоящий белый рыцарь!"
	
func getRank():
	return FightClubRank.PlayToy

func getOrder():
	return 60

func getFightCharacter():
	return "axis"

func getWinScene():
	return "AxisWonScene"

func getLoseScene():
	return "AxisLostToScene"

func getWinExperience():
	return 150

func getWinCredits():
	return 10
