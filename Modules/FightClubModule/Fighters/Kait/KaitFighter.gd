extends FightClubFighter

func _init():
	id = "kait"
	
func getVisibleName():
	return "Кейт"

func getNameAndNickname():
	return "Кейт, Сучка для разведения"

func getAvyIntroduction():
	return "Твой следующий противник — Кейт. Она шлюха, которая строит из себя умнее всех. Чертова заноза в заднице. По мне, так она всего лишь племенная скотина, и ничего больше. Но киска у неё была приятная и тугая, так что тебе стоит попробовать её после победы."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Кейт. Говорят, её удар — самый мощный в тюрьме! Добавьте к этому кошачью ловкость, и вы получите поистине яростную воительницу!"
	
func getRank():
	return FightClubRank.AttentionWhore

func getOrder():
	return 70

func getFightCharacter():
	return "kait"

func getWinScene():
	return "KaitWonScene"

func getLoseScene():
	return "KaitLostToScene"

func getWinExperience():
	return 200

func getWinCredits():
	return 15
