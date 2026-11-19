extends FightClubFighter

func _init():
	id = "avy"
	
func getVisibleName():
	return "Эви"

func getNameAndNickname():
	return "Ави, Непобедимая"

func getAvyIntroduction():
	return "Тебе не стоит этого видеть"
	
func getAnnouncerIntroduction():
	return "Тебе не стоит этого видеть"
	
func getRank():
	#if(GM.main.getFlag("FightClubModule.AvyGotRekt")):
	#	return FightClubRank.FuckMeat
	return FightClubRank.GrandChampion

func getOrder():
	return 10000

func getFightCharacter():
	return "avy"

func getWinScene():
	return "AvyWonScene"

func getLoseScene():
	return "AvyLostToScene"

func getWinExperience():
	return 550

func getWinCredits():
	return 30

func canFight():
	return false
