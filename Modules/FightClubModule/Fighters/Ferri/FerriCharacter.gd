extends Character

func _init():
	id = "ferri"
	
	npcLevel = 6
	npcBasePain = 250
	npcBaseLust = 90
	npcCharacterType = CharacterType.Inmate
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Loves,
		InterestTopic.Bodywritings: Interest.Loves,
		InterestTopic.Gags: Interest.Loves,
		InterestTopic.Blindfolds: Interest.Loves,
		InterestTopic.BDSMRestraints: Interest.Loves,
		InterestTopic.ButtPlugs: Interest.Loves,
		InterestTopic.VaginalPlugs: Interest.Loves,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.Likes,
		InterestTopic.MasculineBody: Interest.KindaLikes,
		InterestTopic.ThickBody: Interest.ReallyDislikes,
		InterestTopic.AverageMassBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.Likes,
		InterestTopic.ThickButt: Interest.KindaLikes,
		InterestTopic.AverageButt: Interest.ReallyLikes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.KindaLikes,
		InterestTopic.SmallBreasts: Interest.Likes,
		InterestTopic.MediumBreasts: Interest.Loves,
		InterestTopic.BigBreasts: Interest.Likes,
		InterestTopic.LactatingBreasts: Interest.Loves,
		InterestTopic.StuffedPussy: Interest.SlightlyDislikes,
		InterestTopic.StuffedAss: Interest.SlightlyDislikes,
		InterestTopic.StuffedPussyOrAss: Interest.SlightlyDislikes,
		InterestTopic.Pregnant: Interest.Hates,
		InterestTopic.StuffedThroat: Interest.SlightlyDislikes,
		InterestTopic.CoveredInCum: Interest.Hates,
		InterestTopic.CoveredInLotsOfCum: Interest.Dislikes,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPussy: Interest.ReallyLikes,
		InterestTopic.ExposedAnus: Interest.KindaLikes,
		InterestTopic.ExposedBreasts: Interest.ReallyLikes,
		InterestTopic.ExposedCock: Interest.Likes,
		InterestTopic.ExposedPanties: Interest.KindaLikes,
		InterestTopic.ExposedBra: Interest.KindaLikes,
		InterestTopic.LooseAnus: Interest.Dislikes,
		InterestTopic.LoosePussy: Interest.Dislikes,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.HasVaginaAndCock: Interest.Likes,
		InterestTopic.BigCock: Interest.Dislikes,
		InterestTopic.AverageCock: Interest.ReallyLikes,
		InterestTopic.SmallCock: Interest.KindaLikes,
		InterestTopic.NoCock: Interest.Likes,
	}
	
	pickedSkin="FerriSkin"
	pickedSkinRColor=Color("ff739bc3")
	pickedSkinGColor=Color("ffddcec9")
	pickedSkinBColor=Color("ff000b6a")
	npcSkinData={
	"hair": {"r": Color("ffddcec9"),"g": Color("ff002cd0"),"b": Color("ffc1c2cc"),},
	"ears": {"g": Color("ff44feff"),"b": Color("ff0539b5"),},
	"horns": {"r": Color("ff041080"),"g": Color("ff041080"),"b": Color("ff041080"),},
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.TallyMarks):
		return "Ну и шлюха~"
	if(interest == InterestTopic.CoveredInCum):
		return "Не хочу чувствовать вкус спермы, когда кусаю тебя!"
	if(interest == InterestTopic.Pregnant):
		return "Не хочу кусать беременную сучку! Грр!"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Гермы? Горячо!"
	if(interest == InterestTopic.BDSMRestraints):
		return "Да-да! Нужно больше пут!"
	if(interest == InterestTopic.Gags):
		return "Пускай слюни для меня, заклеванная сучка~"
	if(interest == InterestTopic.Blindfolds):
		return "Не видишь меня? Какая жалость~"
	if(interest == InterestTopic.LactatingBreasts):
		return "Хафф, я бы тоже не прочь кормить грудью.."
	if(interest == InterestTopic.MediumBreasts):
		return "Классные буфера, можно с ними поиграть~?"
	if(interest == InterestTopic.FullyNaked):
		return "Столько кожи, которую можно облизать и укусить~"
	if(interest == InterestTopic.TightPussy):
		return "Какая классная киска~"
		
func _getName():
	return "Ferri"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Гибрид кошки и дракона среднего телосложения. Циановый мех с темно-синими и белыми акцентами. Заключенная блока строгого режима."

func getSpecies():
	return ["feline", "dragon"]

func _getAttacks():
	return ["NpcScratch", "lickWounds", "StrongBite", "TailSwipe", "FerriTaunt", "trygetupattack"]

func getFightIntro(_battleName):
	var text = "Ферри скалится, обнажая свои опасные клыки, и игриво рычит на тебя. Затем она выпускает острые когти и дразняще облизывает один из них. Её длинный драконий хвост мерно покачивается позади неё."
	text += "\n\n"
	text += "[say=ferri]У тебя нет ни единого шанса против великой дракатки~.[/say]"
	text += "\n\n"
	text += "Она принимает боевую стойку и подначивает тебя подойти поближе."
	
	return text

func getThickness() -> int:
	return 100

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("ferrihair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("lynxears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragonhorns"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragontail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 6
	giveBodypartUnlessSame(breasts)

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformHighsec"]

func getAiStrategy(_battleName):
	var basicAI = LoseEarlyAI.new()
	basicAI.setCharacterID(id)
	return basicAI

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Ой, я её сломала. Какая жалость.",
				"Твои штучки не сработают на могучей дракатке!",
				"Оууу. У тебя есть ещё?",
				"И это всё? Мяу...",
			])
		
		return RNG.pick([
			"Я тебя за это укушу!",
			"Нет таких цепей, что смогут меня удержать!",
			"Твои штучки не сработают на могучей дракатке!",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Oh.. mew..",
				"Я тебя так укушу... как только смогу, мяу...",
				"Ты что, реально меня связываешь? Хафф...",
				"Мяяяу...",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Хафф. Только не хочу пускать слюни!",
				"Я хотела укусить тебя, а не кляп. Мяу...",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Хафф. Но я всё равно хочу тебя укусить...",
				"Ты что, только что нацепил намордник на могучего драката?.. Мяу...",
			])
		if(restraintType == RestraintType.Straitjacket):
			return RNG.pick([
				"Ох... а это удобно...",
			])
	
		return RNG.pick([
			"Попробуй свяжи меня, слабо?!",
			"Милашка!",
			"Ты такая милашка!",
			"Почему ты такая мягкая и очаровательная?",
			"Спорим, ты не сможешь связать могучего драката?",
			"Я слишком сильна, чтобы меня так легко связали!",
		])
	return null

func getCombatStance() -> int:
	return CombatStance.STANCE_COMBAT_DEFAULT
