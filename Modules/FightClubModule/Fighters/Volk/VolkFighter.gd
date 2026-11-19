extends FightClubFighter

func _init():
	id = "volk"
	
func getVisibleName():
	return "Волк"

func getNameAndNickname():
	return "Волк, Сука"

func getAvyIntroduction():
	return "Твой следующий противник — парень по имени Волк. Он низкий и мелкий, но у этого ублюдка всё там, где надо, так что берегись его хитростей."
	
func getAnnouncerIntroduction():
	return "А в правом углу у нас Волк. Не вздумай его недооценивать — в этом крошечном теле упакована бешеная ярость."
	
func getRank():
	return FightClubRank.FuckMeat

func getOrder():
	return 10

func getFightCharacter():
	return "volk"

func getWinScene():
	return "VolkWonScene"

func getLoseScene():
	return "VolkLostToScene"

func getWinExperience():
	return 40

func getWinCredits():
	return 5
