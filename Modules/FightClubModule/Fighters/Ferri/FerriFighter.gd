extends FightClubFighter

func _init():
	id = "ferri"
	
func getVisibleName():
	return "Ферри"

func getNameAndNickname():
	return "Ферри, Девчонка-задира"

func getAvyIntroduction():
	return "Твой следующий противник — гибрид кошки и дракона по имени Ферри. Рыжая, и, скорее всего, кого-то прирезала ради наживы — их всех так ловят. Слышал, она любит пускать в ход свои клыки. Хрен знает, по мне так она просто много лает, а кусается слабо."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Ферри — помесь ловкой кошечки и могучего дракона! Она свирепая воительница, одержавшая немало побед! Она бы и дальше разносила всех в щепки, если бы персонал постоянно не нацеплял на неё намордник!"
	
func getRank():
	return FightClubRank.FailedHero

func getOrder():
	return 30

func getFightCharacter():
	return "ferri"

func getWinScene():
	return "FerriWonScene"

func getLoseScene():
	return "FerriLostToScene"

func getWinExperience():
	return 80

func getWinCredits():
	return 5
