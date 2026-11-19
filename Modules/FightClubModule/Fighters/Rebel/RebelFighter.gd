extends FightClubFighter

func _init():
	id = "rebel"
	
func getVisibleName():
	return "Мятежник"

func getNameAndNickname():
	return "Ребел, Кулак Судьбы"

func getAvyIntroduction():
	return "Твой следующий противник — Ребел. Эта кобыла в отличной форме; тупая как пробка, но может размозжить тебе череп одним мизинцем. Так что имей в виду: увернись от этого, и всё будет путем."
	
func getAnnouncerIntroduction():
	return "А в правом углу — Ребел! Сегодня она решила забить на тренировку и пришла сюда, чтобы испытать свои силы. Добро пожаловать!"
	
func getRank():
	return FightClubRank.FailedHero

func getOrder():
	return 40

func getFightCharacter():
	return "rebel"

func getWinScene():
	return "RebelWonScene"

func getLoseScene():
	return "RebelLostToScene"

func getWinExperience():
	return 100

func getWinCredits():
	return 5
