extends Character

func _init():
	id = "kait"
	npcHasMenstrualCycle = true
	
	pickedSkin="LynxSkin"
	pickedSkinRColor=Color("ff9ea3b5")
	pickedSkinGColor=Color("ffcdcad5")
	pickedSkinBColor=Color("ff494c54")
	npcSkinData={
	"hair": {"r": Color("ff555555"),"g": Color("ff3c3c3c"),"b": Color("ff3d3d3d"),},
	"ears": {"b": Color("ffdcdcdc"),},
	"tail": {"skin": "LuxeSkin",},
	}
	
	npcLevel = 15
	npcBasePain = 130
	npcBaseLust = 160
	npcBaseStamina = 200
	npcCharacterType = CharacterType.Inmate
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Dislikes,
		InterestTopic.Bodywritings: Interest.Dislikes,
		InterestTopic.Gags: Interest.Dislikes,
		InterestTopic.Blindfolds: Interest.Dislikes,
		InterestTopic.BDSMRestraints: Interest.Dislikes,
		InterestTopic.ButtPlugs: Interest.KindaLikes,
		InterestTopic.VaginalPlugs: Interest.KindaLikes,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.SlightlyDislikes,
		InterestTopic.MasculineBody: Interest.ReallyLikes,
		InterestTopic.ThickBody: Interest.Likes,
		InterestTopic.AverageMassBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.Likes,
		InterestTopic.ThickButt: Interest.Dislikes,
		InterestTopic.AverageButt: Interest.ReallyLikes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.Likes,
		InterestTopic.SmallBreasts: Interest.Loves,
		InterestTopic.MediumBreasts: Interest.Likes,
		InterestTopic.BigBreasts: Interest.Hates,
		InterestTopic.LactatingBreasts: Interest.Hates,
		InterestTopic.StuffedPussy: Interest.Dislikes,
		InterestTopic.StuffedAss: Interest.Dislikes,
		InterestTopic.StuffedPussyOrAss: Interest.Dislikes,
		InterestTopic.Pregnant: Interest.Hates,
		InterestTopic.StuffedThroat: Interest.Dislikes,
		InterestTopic.CoveredInCum: Interest.Dislikes,
		InterestTopic.CoveredInLotsOfCum: Interest.Dislikes,
		InterestTopic.FullyNaked: Interest.Loves,
		InterestTopic.ExposedPussy: Interest.Likes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Loves,
		InterestTopic.ExposedCock: Interest.Loves,
		InterestTopic.ExposedPanties: Interest.ReallyLikes,
		InterestTopic.ExposedBra: Interest.KindaLikes,
		InterestTopic.LooseAnus: Interest.Dislikes,
		InterestTopic.LoosePussy: Interest.Dislikes,
		InterestTopic.TightAnus: Interest.ReallyLikes,
		InterestTopic.TightPussy: Interest.ReallyLikes,
		InterestTopic.NoVagina: Interest.ReallyLikes,
		InterestTopic.HasVaginaOnly: Interest.ReallyLikes,
		InterestTopic.HasVaginaAndCock: Interest.Hates,
		InterestTopic.BigCock: Interest.ReallyLikes,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.ReallyDislikes,
		InterestTopic.HasCockOnly: Interest.Likes,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Как же я, блядь, ненавижу герм"
	if(interest == InterestTopic.ExposedBreasts):
		return "Сиськи классные, признаю"
	if(interest == InterestTopic.LoosePussy):
		return "Охренеть, твоя киска просто в хлам"
	if(interest == InterestTopic.LooseAnus):
		return "Серьезно? Твоя жопа просто уничтожена"
	if(interest == InterestTopic.BigBreasts):
		return "Не тряси своими вымями, блядь"
	if(interest == InterestTopic.LactatingBreasts):
		return "Ты что, блядь, корова какая-то?"
	if(interest == InterestTopic.ExposedCock):
		return "Ммм.. классный член"
	if(interest == InterestTopic.FullyNaked):
		return "Охренеть, у тебя вообще нет стыда. Даже завидно"
	if(interest == InterestTopic.Pregnant):
		return "Тебя кто-то осеменил? Мерзость"
	if(interest == InterestTopic.MasculineBody):
		return "Мм.. Ты такой мужественный..."
	if(interest == InterestTopic.SmallCock):
		return "Ха, какой жалкий член."
	
func _getName():
	return "Kait"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Девушка-снежный барс в сиреневой униформе. Среднего роста, стройного телосложения."

func getSpecies():
	return ["feline"]

func _getAttacks():
	return ["simplekickattack", "NpcScratch", "biteattack", "kickToBallsAttack", "slapTitsAttack", "stretchingAttack", "lickWounds", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	#var didCommit:bool = GM.main.hasCommittedToMainRoute()
	var isOnKaitRoute:bool = GM.main.getFlag("KaitModule.joinedTeam", false)
	
	var mes = "Кейт подпрыгивает на месте и потягивается, как это обычно делают кошки. Затем она переключает внимание на тебя, принимая боевую стойку: слегка приседает и выпускает когти."
	mes += "\n\n"
	if(_battleName == "arenafight"):
		if(isOnKaitRoute):
			mes += "[say=kait]О, привет. Хах. Не думай, что я буду поддаваться только потому, что мы в одной команде.[/say]"
			mes += "\n\n"
			mes += "[say=kait]Хорошо.[/say]"
		else:
			mes += "[say=kait]И кто ты, черт возьми, такой?[/say]"
	else:
		mes += "[say=kait]Ты вообще кем себя возомнил?[/say]"
	mes += "\n\n"
	mes += "Она фыркает и принимает боевой вид; её большой пушистый хвост так и ходит ходуном, будто живет своей собственной жизнью."
	mes += "\n\n"
	if(_battleName == "arenafight"):
		if(isOnKaitRoute):
			mes += "[say=kait]Впрочем, это неважно. Просто запомни: если выиграю — помечу тебя.[/say]"
		else:
			mes += "[say=kait]Ну, давай, нападай![/say]"
	else:
		mes += "[say=kait]Давай, коврик для ног, покажи, на что способен![/say]"
	return mes

func getThickness() -> int:
	return 60

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("overeyehair2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 3
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	var tail = GlobalRegistry.createBodypart("felinetail")
	tail.tailScale = 1.2
	giveBodypartUnlessSame(tail)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformSexDeviant"]

func getLootTable(_battleName):
	return InmateLoot.new()

func getCombatStance() -> int:
	return CombatStance.STANCE_COMBAT_RELAXED

func onGivingBirth(_impregnatedEggCells: Array, _newkids: Array):
	.onGivingBirth(_impregnatedEggCells, _newkids)
	GM.main.increaseModuleFlag("KaitModule", "kaitGaveBirths", 1)
	GM.main.setFlag("KaitModule.kaitDidCuddle", false)
