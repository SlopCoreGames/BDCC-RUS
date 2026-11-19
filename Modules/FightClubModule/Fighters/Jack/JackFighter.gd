extends FightClubFighter

func _init():
	id = "jack"
	
func getVisibleName():
	return "Джек"

func getNameAndNickname():
	return "Джек, Самец"

func getAvyIntroduction():
	return "Твой следующий противник — Джек. Он силен, вероятно, даже сильнее меня. Если мы говорим о чистой физической мощи, конечно. Но я всё равно надеру ему задницу в любой день недели — эти галлоны спермы в его яйцах слишком сильно туманят ему разум."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Джек, Самец! Дамы обожают его, а некоторые парни его боятся. Несравненная сила и невероятная плодовитость — встречайте истинного жеребца!"
	
func getRank():
	return FightClubRank.AttentionWhore

func getOrder():
	return 80

func getFightCharacter():
	return "jack"

func getWinScene():
	return "JackWonScene"

func getLoseScene():
	return "JackLostToScene"

func getWinExperience():
	return 250

func getWinCredits():
	return 20
