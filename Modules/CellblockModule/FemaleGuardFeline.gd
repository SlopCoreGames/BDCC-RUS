extends Character

func _init():
	id = "femaleguard_feline"
	
	npcArmor = {
		DamageType.Physical: 5,
	}
	npcLevel = 1
	npcBasePain = 50
	npcBaseLust = 70
	npcBaseStamina = 120
	npcCharacterType = CharacterType.Guard
	
	pickedSkin="TaviSkin"
	pickedSkinRColor=Color("fff7fafe")
	pickedSkinGColor=Color("ff1d2f50")
	pickedSkinBColor=Color("ff99a3b6")
	npcSkinData={
	"hair": {"r": Color("ff0d2254"),"g": Color("ff8096bb"),"b": Color("ff8096bb"),},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Hates,
		InterestTopic.Bodywritings: Interest.Hates,
		InterestTopic.Gags: Interest.Loves,
		InterestTopic.Blindfolds: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.Loves,
		InterestTopic.ButtPlugs: Interest.Hates,
		InterestTopic.VaginalPlugs: Interest.Hates,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.ReallyLikes,
		InterestTopic.MasculineBody: Interest.Loves,
		InterestTopic.ThickBody: Interest.Dislikes,
		InterestTopic.AverageMassBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.Dislikes,
		InterestTopic.ThickButt: Interest.SlightlyDislikes,
		InterestTopic.AverageButt: Interest.KindaLikes,
		InterestTopic.SlimButt: Interest.SlightlyDislikes,
		InterestTopic.NoBreasts: Interest.ReallyLikes,
		InterestTopic.SmallBreasts: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.ReallyDislikes,
		InterestTopic.BigBreasts: Interest.Hates,
		InterestTopic.LactatingBreasts: Interest.Hates,
		InterestTopic.StuffedPussy: Interest.Hates,
		InterestTopic.StuffedAss: Interest.ReallyLikes,
		InterestTopic.StuffedPussyOrAss: Interest.KindaLikes,
		InterestTopic.StuffedThroat: Interest.Hates,
		InterestTopic.CoveredInCum: Interest.Hates,
		InterestTopic.CoveredInLotsOfCum: Interest.Hates,
		InterestTopic.FullyNaked: Interest.Dislikes,
		InterestTopic.ExposedPussy: Interest.KindaLikes,
		InterestTopic.ExposedAnus: Interest.Dislikes,
		InterestTopic.ExposedBreasts: Interest.KindaLikes,
		InterestTopic.ExposedCock: Interest.ReallyLikes,
		InterestTopic.ExposedPanties: Interest.Loves,
		InterestTopic.ExposedBra: Interest.Likes,
		InterestTopic.LooseAnus: Interest.ReallyDislikes,
		InterestTopic.LoosePussy: Interest.ReallyDislikes,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.NoVagina: Interest.Likes,
		InterestTopic.HasVaginaOnly: Interest.SlightlyDislikes,
		InterestTopic.HasVaginaAndCock: Interest.Likes,
		InterestTopic.BigCock: Interest.Loves,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.KindaLikes,
		InterestTopic.HasCockOnly: Interest.Loves,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.BDSMRestraints):
		return "Значит, ты шлюшка, которая обожает ограничения, да?"
	if(interest == InterestTopic.CoveredInCum):
		return "Фу, тебе нужно срочно в душ"
	if(interest == InterestTopic.StuffedPussy):
		return "Да, у тебя там всё в сперме, иди отмойся"
	if(interest == InterestTopic.BigBreasts):
		return "Завидую твоей сиське, заключенная"
	if(interest == InterestTopic.ExposedPanties):
		return "Классные трусики~"
	if(interest == InterestTopic.BigCock):
		return "Хм... А член у тебя что надо"
	if(interest == InterestTopic.MasculineBody):
		return "Ого, а ты горячая"
	
func _getName():
	return "Женщина-охранница"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Высокая кошка в форме охранницы."

func getSpecies():
	return ["feline"]

func _getAttacks():
	return ["HeatGrenade", "DoubleCuffPC", "CuffPCHands", "ForceGagPC", "ForceMuzzlePC", "stunbatonAttack", "stunbatonOverchargeAttack", "biteattack", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	return "Охранница готовится к бою"
	
func getLootTable(_battleName):
	return GuardLoot.new()

func getThickness() -> int:
	return 60

func getFemininity() -> int:
	return 0

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 4
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("shorthair"))

func getDefaultEquipment():
	return ["GuardArmor"]
