extends Character

func _init():
	id = "rubi"
	
	npcLevel = 1
	npcBasePain = 70
	npcBaseLust = 50
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="SoftSpikySkin"
	pickedSkinRColor=Color("ffeaeeec")
	pickedSkinGColor=Color("ffa5b9b0")
	pickedSkinBColor=Color("ff125437")
	npcSkinData={
	"hair": {"r": Color("ff6f847f"),"g": Color("ff74968e"),"b": Color("ffa9a9a9"),},
	"penis": {"g": Color("ff25ed6c"),"b": Color("ff8b0000"),},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Dislikes,
		InterestTopic.Bodywritings: Interest.Dislikes,
		InterestTopic.Gags: Interest.Dislikes,
		InterestTopic.Blindfolds: Interest.Dislikes,
		InterestTopic.BDSMRestraints: Interest.Dislikes,
		InterestTopic.ButtPlugs: Interest.ReallyLikes,
		InterestTopic.VaginalPlugs: Interest.SlightlyDislikes,
		InterestTopic.FeminineBody: Interest.KindaLikes,
		InterestTopic.AndroBody: Interest.Likes,
		InterestTopic.MasculineBody: Interest.Loves,
		InterestTopic.ThickBody: Interest.Hates,
		InterestTopic.AverageMassBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.ThickButt: Interest.SlightlyDislikes,
		InterestTopic.AverageButt: Interest.ReallyLikes,
		InterestTopic.SlimButt: Interest.Likes,
		InterestTopic.NoBreasts: Interest.ReallyLikes,
		InterestTopic.SmallBreasts: Interest.Dislikes,
		InterestTopic.MediumBreasts: Interest.Likes,
		InterestTopic.BigBreasts: Interest.ReallyLikes,
		InterestTopic.LactatingBreasts: Interest.Likes,
		InterestTopic.StuffedPussy: Interest.Loves,
		InterestTopic.StuffedAss: Interest.Likes,
		InterestTopic.StuffedPussyOrAss: Interest.KindaLikes,
		InterestTopic.Pregnant: Interest.Hates,
		InterestTopic.StuffedThroat: Interest.Loves,
		InterestTopic.CoveredInCum: Interest.Likes,
		InterestTopic.CoveredInLotsOfCum: Interest.KindaLikes,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPussy: Interest.ReallyLikes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.Loves,
		InterestTopic.ExposedPanties: Interest.KindaLikes,
		InterestTopic.ExposedBra: Interest.KindaLikes,
		InterestTopic.LooseAnus: Interest.Loves,
		InterestTopic.LoosePussy: Interest.Likes,
		InterestTopic.TightAnus: Interest.KindaLikes,
		InterestTopic.TightPussy: Interest.KindaLikes,
		InterestTopic.NoVagina: Interest.Likes,
		InterestTopic.HasVaginaOnly: Interest.KindaLikes,
		InterestTopic.HasVaginaAndCock: Interest.Hates,
		InterestTopic.BigCock: Interest.Hates,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.Hates,
		InterestTopic.NoCock: Interest.KindaLikes,
		InterestTopic.HasCockOnly: Interest.KindaLikes,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.ButtPlugs):
		return "Клизмы в задницу, вот это дааа~"
	if(interest == InterestTopic.ThickBody):
		return "Извини, мне не интересно"
	if(interest == InterestTopic.MasculineBody):
		return "О, обожаю крепких типов~"
	if(interest == InterestTopic.BigBreasts):
		return "О да, заставь эти сиськи прыгать"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Не фанатка гермафродитов, слишком много всего в одном месте"
	if(interest == InterestTopic.ExposedCock):
		return "Классный член~"
	if(interest == InterestTopic.BigCock):
		return "Ой, только не надо выворачивать меня наизнанку"
	if(interest == InterestTopic.Pregnant):
		return "Шлюха, я не хочу драться с беременной сукой"
	if(interest == InterestTopic.LactatingBreasts):
		return "Могу прикинуться кошечкой, если позволишь мне пососать эти~"
	if(interest == InterestTopic.SmallCock):
		return "Как, блядь, я вообще что-то почувствую с таким хералом?"
	
func _getName():
	return "Rubi"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Стройный фимбой с сиреневой кожей. У него кошачье телосложение среднего роста, довольно подтянутое, с узкими плечами и широкими бедрами."

func getSpecies():
	return ["feline"]

func _getAttacks():
	return ["simplepunchattack", "simplekickattack", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	var text = "Руби — заключенный с лиловым оттенком кожи, он без рубашки, так что видна его рельефная мускулатура. Но, несмотря на это, его телосложение скорее женственное: узкие плечи, стройная плоская грудь с парой заметных сосков, широкие бедра, миловидное лицо и длинные волосы."
	text += "\n\n"
	text += "Он выпрямляется и вызывающе смотрит на тебя."
	text += "\n\n"
	text += "[say=rubi]Ну что, будешь драться со мной? Я тренировался годами, так что у тебя нет ни единого шанса. Но не переживай, я буду с тобой нежен~.[/say]"
	text += "\n\n"
	text += "На его лице играет дерзкая ухмылка; одна рука лежит на бедре, а другой он манит тебя подойти поближе."
	
	return text

func getThickness() -> int:
	return 80

func getFemininity() -> int:
	return 40

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("longhair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("malebreasts")
	breasts.size = -1
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("felinepenis")
	penis.lengthCM = 15
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformSexDeviant"]

func getCombatStance() -> int:
	return CombatStance.STANCE_COMBAT_KARATE
