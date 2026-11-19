extends Character

func _init():
	id = "avy"
	
	pickedSkin="WoonaSkin"
	pickedSkinRColor=Color("ff393939")
	pickedSkinGColor=Color("ff242424")
	pickedSkinBColor=Color("ff1f1f1f")
	npcSkinData={
	"hair": {"r": Color("ff161616"),"g": Color("ffff0000"),"b": Color("ff070707"),},
	"ears": {"g": Color("ff890000"),"b": Color("fff00000"),},
	"breasts": {"g": Color("ff581818"),"b": Color("ff800000"),},
	"penis": {"g": Color("ffff0000"),"b": Color("ff8b0000"),},
	}
	
	npcLevel = 5
	npcBasePain = 130
	npcBaseLust = 110
	npcCharacterType = CharacterType.Inmate
	
	npcPersonality = {
		PersonalityStat.Brat: 1.0,
		PersonalityStat.Mean: 1.0,
		PersonalityStat.Subby: -1.0,
		PersonalityStat.Impatient: -0.3,
		PersonalityStat.Naive: -0.5,
		PersonalityStat.Coward: 0.5,
	}
	npcFetishes = {
		Fetish.AnalSexReceiving : FetishInterest.Hates,
		Fetish.AnalSexGiving : FetishInterest.Loves,
		Fetish.VaginalSexGiving : FetishInterest.Loves,
		Fetish.OralSexReceiving : FetishInterest.Loves,
		Fetish.OralSexGiving : FetishInterest.Hates,
		Fetish.Sadism : FetishInterest.Loves,
		Fetish.Masochism : FetishInterest.Hates,
		Fetish.UnconsciousSex : FetishInterest.Loves,
		Fetish.Breeding : FetishInterest.Loves,
		Fetish.Bondage : FetishInterest.Dislikes,
		Fetish.Condoms : FetishInterest.Hates,
		Fetish.DrugUse : FetishInterest.Loves,
		Fetish.Exhibitionism : FetishInterest.Likes,
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Loves,
		InterestTopic.Bodywritings: Interest.Loves,
		InterestTopic.Gags: Interest.Likes,
		InterestTopic.Blindfolds: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.ReallyLikes,
		InterestTopic.ButtPlugs: Interest.Likes,
		InterestTopic.VaginalPlugs: Interest.Likes,
		InterestTopic.FeminineBody: Interest.ReallyLikes,
		InterestTopic.AndroBody: Interest.KindaLikes,
		InterestTopic.MasculineBody: Interest.Dislikes,
		InterestTopic.ThickBody: Interest.KindaLikes,
		InterestTopic.AverageMassBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.Loves,
		InterestTopic.ThickButt: Interest.SlightlyDislikes,
		InterestTopic.AverageButt: Interest.SlightlyDislikes,
		InterestTopic.SlimButt: Interest.ReallyLikes,
		InterestTopic.NoBreasts: Interest.KindaLikes,
		InterestTopic.SmallBreasts: Interest.Likes,
		InterestTopic.MediumBreasts: Interest.KindaLikes,
		InterestTopic.BigBreasts: Interest.KindaLikes,
		InterestTopic.LactatingBreasts: Interest.Likes,
		InterestTopic.StuffedPussy: Interest.KindaLikes,
		InterestTopic.StuffedAss: Interest.ReallyLikes,
		InterestTopic.StuffedPussyOrAss: Interest.Likes,
		InterestTopic.StuffedThroat: Interest.Loves,
		InterestTopic.CoveredInCum: Interest.ReallyLikes,
		InterestTopic.CoveredInLotsOfCum: Interest.Loves,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPussy: Interest.KindaLikes,
		InterestTopic.ExposedAnus: Interest.ReallyLikes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.ReallyDislikes,
		InterestTopic.ExposedPanties: Interest.Hates,
		InterestTopic.ExposedBra: Interest.Dislikes,
		InterestTopic.LooseAnus: Interest.Hates,
		InterestTopic.LoosePussy: Interest.Hates,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.NoVagina: Interest.KindaLikes,
		InterestTopic.HasVaginaOnly: Interest.KindaLikes,
		InterestTopic.HasVaginaAndCock: Interest.Likes,
		InterestTopic.BigCock: Interest.Hates,
		InterestTopic.AverageCock: Interest.Dislikes,
		InterestTopic.SmallCock: Interest.Likes,
		InterestTopic.NoCock: Interest.KindaLikes,
		InterestTopic.HasCockOnly: Interest.KindaLikes,
		InterestTopic.Pregnant: Interest.Loves,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Значит, ты герма, да~?"
	if(interest == InterestTopic.ExposedPanties):
		return "Снимай трусики сама, пока я их не сорвала, шлюха"
	if(interest == InterestTopic.TallyMarks):
		return "О боже~. Обожаю, когда у шлюх есть зарубки на теле"
	if(interest == InterestTopic.Bodywritings):
		return "Можно я тоже оставлю на тебе пару словечек~?"
	if(interest == InterestTopic.BigCock):
		return "Пфф, да у тебя вообще крови хватит, чтобы член встал?"
	if(interest == InterestTopic.LoosePussy):
		return "Мда, твоя киска уже слишком раздолбана, даже не весело"
	if(interest == InterestTopic.LooseAnus):
		return "Может, будешь скакать на лошадиных членах чуть пореже со своей задницей?"
	if(interest == InterestTopic.StuffedThroat):
		return "О да, обожаю, когда шлюхи пускают слюни из спермы~"
	if(interest == InterestTopic.CoveredInLotsOfCum):
		return "Ну ты и спермобак~"
	if(interest == InterestTopic.SlimBody):
		return "Ох, ты такая худая, что, кажется, я смогу удерживать тебя в воздухе, пока трахаю~"
	if(interest == InterestTopic.Pregnant):
		return "Кто-то тебя обрюхатил, а~? Это случайно не был я?"
	if(interest == InterestTopic.ExposedCock):
		return "Спрячь свой член, шлюха, со мной он тебе не понадобится"
	
	
func _getName():
	return "Avy"

func getGender():
	return Gender.Androgynous
	
func getPronounGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Заключенная по кличке Ред — лисица среднего роста с черным мехом и женственной внешностью."

func getSpecies():
	return ["canine"]
	
func _getAttacks():
	return ["biteattack", "simplekickattack", "stretchingAttack", "lickWounds", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	if(_battleName == "arenafight"):
		return "Ави стоит в полный рост, помахивая своим лисьим хвостом. Кажется, она ждет, когда ты сделаешь первый ход..."
	return "Ави стоит прямо, слегка заложив руки за спину и расставив когтистые пальцы."

func getThickness() -> int:
	return 75

func getFemininity() -> int:
	return 50

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 4
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("foxhead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("longhair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	var penis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 22
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninetail"))

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformHighsec"]

func getCombatStance() -> int:
	return CombatStance.STANCE_LUST_BRAVE
