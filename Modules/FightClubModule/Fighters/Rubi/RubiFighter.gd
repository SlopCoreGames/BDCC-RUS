extends FightClubFighter

func _init():
	id = "rubi"
	
func getVisibleName():
	return "Руби"

func getNameAndNickname():
	return "Руби, Похотливый"

func getAvyIntroduction():
	return "Так, твой первый противник — кот по имени Руби. Свежее мясо, прямо как ты: приперся сюда, чтобы доказать всем, что он альфа-самец или типа того. Советую с ним поаккуратнее, а то он может сломаться, если начнешь слишком сильно нажимать на его кнопки."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Руби! Многообещающий боец, который пока не выиграл ни одного боя!"
	
func getRank():
	return FightClubRank.FuckMeat

func getOrder():
	return 0

func getFightCharacter():
	return "rubi"

func getWinScene():
	return "RubiWonScene"

func getLoseScene():
	return "RubiLostToScene"

func getWinExperience():
	return 30

func getWinCredits():
	return 3
