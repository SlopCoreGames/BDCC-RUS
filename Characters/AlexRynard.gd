extends Character

func _init():
	id = "alexrynard"
	
	npcLevel = 10
	npcBasePain = 150
	npcBaseLust = 250
	npcBaseStamina = 150
	npcCharacterType = CharacterType.Engineer
	
	pickedSkin="CunningSkin"
	pickedSkinRColor=Color("ffe07a35")
	pickedSkinGColor=Color("ffe7e7e7")
	pickedSkinBColor=Color("ff512c13")
	npcSkinData={
	"hair": {"r": Color("ff1f1f1f"),"g": Color("ff090909"),"b": Color("ffb8542d"),},
	"ears": {"b": Color("ffffffff"),},
	"arms": {"g": Color("ff070707"),},
	"penis": {"g": Color("ffd2160c"),"b": Color("ff8b0000"),},
	"legs": {"g": Color("ff070707"),},
	}
	
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
		InterestTopic.MasculineBody: Interest.Likes,
		InterestTopic.ThickBody: Interest.ReallyLikes,
		InterestTopic.AverageMassBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.ReallyLikes,
		InterestTopic.ThickButt: Interest.Likes,
		InterestTopic.AverageButt: Interest.Likes,
		InterestTopic.SlimButt: Interest.Likes,
		InterestTopic.NoBreasts: Interest.Likes,
		InterestTopic.SmallBreasts: Interest.Likes,
		InterestTopic.MediumBreasts: Interest.Likes,
		InterestTopic.BigBreasts: Interest.Likes,
		InterestTopic.LactatingBreasts: Interest.Hates,
		InterestTopic.StuffedPussy: Interest.Hates,
		InterestTopic.StuffedAss: Interest.Hates,
		InterestTopic.StuffedPussyOrAss: Interest.Dislikes,
		InterestTopic.Pregnant: Interest.ReallyDislikes,
		InterestTopic.StuffedThroat: Interest.Dislikes,
		InterestTopic.CoveredInCum: Interest.Dislikes,
		InterestTopic.CoveredInLotsOfCum: Interest.Hates,
		InterestTopic.FullyNaked: Interest.Hates,
		InterestTopic.ExposedPussy: Interest.KindaLikes,
		InterestTopic.ExposedAnus: Interest.KindaLikes,
		InterestTopic.ExposedBreasts: Interest.Dislikes,
		InterestTopic.ExposedCock: Interest.Dislikes,
		InterestTopic.ExposedPanties: Interest.ReallyLikes,
		InterestTopic.ExposedBra: Interest.ReallyLikes,
		InterestTopic.LooseAnus: Interest.Hates,
		InterestTopic.LoosePussy: Interest.Hates,
		InterestTopic.TightAnus: Interest.Loves,
		InterestTopic.TightPussy: Interest.Loves,
		InterestTopic.NoVagina: Interest.SlightlyDislikes,
		InterestTopic.HasVaginaOnly: Interest.KindaLikes,
		InterestTopic.HasVaginaAndCock: Interest.Dislikes,
		InterestTopic.BigCock: Interest.Hates,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.Likes,
		InterestTopic.NoCock: Interest.KindaLikes,
		InterestTopic.HasCockOnly: Interest.KindaLikes,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Pregnant):
		return "Рожать детей в тюрьме? Ты что, совсем с катушек съехал?"
	if(interest == InterestTopic.Bodywritings):
		return "Искусство мне нравится. Даже татухи на теле."
	if(interest == InterestTopic.CoveredInCum):
		return "Иди в душ, малявка."
	if(interest == InterestTopic.LoosePussy):
		return "Чего ты так постоянно трахаешься? Сходи, подлечи свое либидо."
	if(interest == InterestTopic.LooseAnus):
		return "Мне не нужно видеть твою избитую задницу."
	if(interest == InterestTopic.BDSMRestraints):
		return "Связывание — мое самое большое удовольствие. А размножением пусть занимаются другие."
	if(interest == InterestTopic.AndroBody):
		return "Мне никогда не было дела до внешности. Важнее то, что внутри."
	if(interest == InterestTopic.FullyNaked):
		return "Надень хоть что-нибудь, а то стыдно смотреть."
	if(interest == InterestTopic.LactatingBreasts):
		return "Ты что, корова? Иди траву жуй."
	if(interest == InterestTopic.BigCock):
		return "Как ты вообще... да хрен с тобой."
	if(interest == InterestTopic.StuffedPussy):
		return "Только о размножении и думаешь? У тебя вообще есть мечты?"
	if(interest == InterestTopic.StuffedAss):
		return "Только этого зрелища мне не хватало."
	
func _getName():
	return "Алекс Райнард"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Самец лиса с холодным взглядом. Одет в форму инженера."

func getSpecies():
	return ["canine"]

func getChatColor():
	return '#FFF60C'

func getThickness() -> int:
	return 70

func getFemininity() -> int:
	return 0

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("foxhead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("ponytailhair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("malebreasts")
	breasts.size = -1
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 18
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("foxtail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func getDefaultEquipment():
	return ["EngineerClothesAlex", "plainBriefs", "AlexSpine"]

func _getAttacks():
	return ["NpcScratch", "StrongBite", "simplekickattack", "HeatGrenade", "BolaThrow", "ForceBlindfoldPC", "trygetupattack"]

func getFightIntro(_battleName):
	return "Алекс кряхтит, принимая боевую стойку; его протез позвоночника не предназначен для сражений, но даже с такой помехой он выглядит крепким орешком."

func getLootTable(_battleName):
	return EngineerLoot.new()

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Тебе не так-то просто меня связать.",
				"В следующий раз постарайся получше.",
				"Что на этот раз?",
				"Риггера просто так не свяжешь.",
			])
		
		return RNG.pick([
			"Я сломаю все твои игрушки.",
			"Эти путы не удержат меня вечно.",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Кончай эту херню.",
				"Хватит, оставь это для сирени и красных роз",
				"Сколько у тебя еще осталось?",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Эй! Не затыкай мне, блядь, рот!",
				"Думаешь, если заткнешь меня, это тебя спасет?",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Эй! Не надевай на меня, сука, намордник!",
				"Думаешь, намордник тебя спасет?",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"Эй! Только не в задницу!",
				"Не трогай мою ебаную задницу!",
			])
	
		return RNG.pick([
			"Эй! Ограничители — это по моей части!",
			"Какого хуя ты творишь?",
			"Ты меня реально бесишь",
			"Так ты не победишь",
			"Сражайся со мной, а не занимайся этой хернёй",
			"Убери от меня это дерьмо",
		])
	return null

func getCombatStance() -> int:
	return CombatStance.STANCE_COMBAT_RELAXED
