extends Character

func _init():
	id = "volk"
	
	npcLevel = 3
	npcBasePain = 120
	npcBaseLust = 100
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="WoonaSkin"
	pickedSkinRColor=Color("ff868686")
	pickedSkinGColor=Color("ff3b3b3b")
	pickedSkinBColor=Color("ffcbcbcb")
	npcSkinData={
	"hair": {"r": Color("ffffffff"),"g": Color("ffd3d3d3"),"b": Color("ffa9a9a9"),},
	"penis": {"g": Color("ff732a2a"),"b": Color("ffd14747"),},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Likes,
		InterestTopic.Bodywritings: Interest.Likes,
		InterestTopic.Gags: Interest.Hates,
		InterestTopic.Blindfolds: Interest.Loves,
		InterestTopic.BDSMRestraints: Interest.Likes,
		InterestTopic.ButtPlugs: Interest.Hates,
		InterestTopic.VaginalPlugs: Interest.Hates,
		InterestTopic.FeminineBody: Interest.Dislikes,
		InterestTopic.AndroBody: Interest.Hates,
		InterestTopic.MasculineBody: Interest.Dislikes,
		InterestTopic.ThickBody: Interest.ReallyDislikes,
		InterestTopic.AverageMassBody: Interest.Dislikes,
		InterestTopic.SlimBody: Interest.SlightlyDislikes,
		InterestTopic.ThickButt: Interest.Dislikes,
		InterestTopic.AverageButt: Interest.Dislikes,
		InterestTopic.SlimButt: Interest.Loves,
		InterestTopic.NoBreasts: Interest.Dislikes,
		InterestTopic.SmallBreasts: Interest.Loves,
		InterestTopic.MediumBreasts: Interest.Dislikes,
		InterestTopic.BigBreasts: Interest.Dislikes,
		InterestTopic.LactatingBreasts: Interest.Hates,
		InterestTopic.StuffedPussy: Interest.ReallyDislikes,
		InterestTopic.StuffedAss: Interest.ReallyDislikes,
		InterestTopic.StuffedPussyOrAss: Interest.SlightlyDislikes,
		InterestTopic.Pregnant: Interest.Hates,
		InterestTopic.StuffedThroat: Interest.Hates,
		InterestTopic.CoveredInCum: Interest.Hates,
		InterestTopic.CoveredInLotsOfCum: Interest.Hates,
		InterestTopic.FullyNaked: Interest.Hates,
		InterestTopic.ExposedPussy: Interest.Hates,
		InterestTopic.ExposedAnus: Interest.Hates,
		InterestTopic.ExposedBreasts: Interest.Hates,
		InterestTopic.ExposedCock: Interest.Hates,
		InterestTopic.ExposedPanties: Interest.Loves,
		InterestTopic.ExposedBra: Interest.Loves,
		InterestTopic.LooseAnus: Interest.Dislikes,
		InterestTopic.LoosePussy: Interest.Dislikes,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.NoVagina: Interest.Likes,
		InterestTopic.HasVaginaAndCock: Interest.Hates,
		InterestTopic.BigCock: Interest.Hates,
		InterestTopic.AverageCock: Interest.Hates,
		InterestTopic.SmallCock: Interest.Hates,
		InterestTopic.NoCock: Interest.ReallyLikes,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Gags):
		return "Хочу слышать твои стоны, сука"
	if(interest == InterestTopic.ButtPlugs):
		return "Почему бы тебе не использовать члены вместо этого?"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Сука, иметь и член, и пизду — это ненормально"
	if(interest == InterestTopic.ExposedPanties):
		return "Не терпится изрезать твои трусики в клочья"
	if(interest == InterestTopic.ExposedBra):
		return "Этот лифчик бронированный, сука?"
	if(interest == InterestTopic.FullyNaked):
		return "Надень хоть что-нибудь, сука"
	if(interest == InterestTopic.CoveredInCum):
		return "Я тебя еще даже не трогаю, сука"
	if(interest == InterestTopic.AndroBody):
		return "Ты девка или пацан?"
	if(interest == InterestTopic.SmallBreasts):
		return "Будешь визжать, если я пощупаю твои сиськи?"
		
func _getName():
	return "Volk"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Самец из общего блока. Серая шерсть, низкий рост, куча шрамов"

func getSpecies():
	return ["canine"]

func _getAttacks():
	return ["biteattack", "ShivAttack", "VolkTaunt", "trygetupattack"]

func getFightIntro(_battleName):
	if(_battleName == "arenafight"):
		var text = "Волк приседает, еще сильнее пригибаясь к земле. Затем он сплевывает в сторону. Довольно грубо. Голос у него очень хриплый, будто он курил без перерыва лет десять."
		text += "\n\n"
		text += "[say=volk]Что? Есть проблемы?[/say]"
		text += "\n\n"
		text += "Затем он разминает шею, встает и внезапно выхватывает шив — остро заточенный кусок стекла с обмотанной тряпкой рукояткой. Правило «никаких ограничений» означает, что он волен использовать его когда угодно."
		text += "\n\n"
		text += "[say=volk]Сюрприз. Иди сюда, сука.[/say]"
		
		return text
	else:
		return .getFightIntro(_battleName)

func getThickness() -> int:
	return 50

func getFemininity() -> int:
	return 30

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("wolfhead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("wolfears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("messyhair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("buffarms"))
	var breasts = GlobalRegistry.createBodypart("malebreasts")
	breasts.size = -1
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 15
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func getLootTable(_battleName):
	var loot = InmateLoot.new()
	loot.addLoot(100, ["Шило"])
	return loot
	
func getDefaultEquipment():
	return ["inmatecollar", "inmateuniform"]

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_SHIV
