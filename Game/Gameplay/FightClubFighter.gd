extends Reference
class_name FightClubFighter

var id = "error"

func getVisibleName():
	return "Ошибка"

func getNameAndNickname():
	return "Ошибка, Ошибка"

func getAvyIntroduction():
	return "ЗАМЕНИ МЕНЯ"
	
func getAnnouncerIntroduction():
	return "МЕНЯ ТОЖЕ ЗАМЕНИ"
	
func getRank():
	return FightClubRank.FuckMeat

func getOrder():
	return 0

func getFightCharacter():
	return null

func getWinScene():
	return null

func getLoseScene():
	return null

func getWinExperience():
	return 30

func getWinCredits():
	return 5

func getRepeatWinExperience():
	return round(getWinExperience() / 2.0)
	
func getRepeatWinCredits():
	return floor(getWinCredits() / 4.0)

func canFight():
	return true
