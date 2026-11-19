extends Character

func _init():
	id = "nova"
	
	pickedSkin="NovaSkin"
	pickedSkinRColor=Color("ffc5c4c4")
	pickedSkinGColor=Color("ff414241")
	pickedSkinBColor=Color("ff747474")
	npcSkinData={
	"hair": {"r": Color("ffd9d9d9"),"g": Color("ff0f5fdb"),"b": Color("ff0f5fdb"),},
	"ears": {"r": Color("ff737373"),"g": Color("ffb5b5b5"),"b": Color("ffb8b8b8"),},
	"penis": {"g": Color("ffd12020"),"b": Color("ff8b0000"),},
	}
	
	npcArmor = {
		DamageType.Physical: 10,
	}
	npcStats = {
		Stat.Sexiness: 1,
	}
	npcLevel = 2
	npcCharacterType = CharacterType.Guard
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Loves,
		InterestTopic.Bodywritings: Interest.Loves,
		InterestTopic.Gags: Interest.Likes,
		InterestTopic.Blindfolds: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.Loves,
		InterestTopic.ButtPlugs: Interest.ReallyLikes,
		InterestTopic.VaginalPlugs: Interest.ReallyLikes,
		InterestTopic.FeminineBody: Interest.ReallyLikes,
		InterestTopic.AndroBody: Interest.ReallyDislikes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.ThickButt: Interest.Loves,
		InterestTopic.AverageButt: Interest.KindaLikes,
		InterestTopic.SlimButt: Interest.SlightlyDislikes,
		InterestTopic.NoBreasts: Interest.SlightlyDislikes,
		InterestTopic.SmallBreasts: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.Loves,
		InterestTopic.BigBreasts: Interest.ReallyLikes,
		InterestTopic.StuffedPussy: Interest.Loves,
		InterestTopic.StuffedPussyOrAss: Interest.Loves,
		InterestTopic.StuffedThroat: Interest.Likes,
		InterestTopic.CoveredInCum: Interest.Likes,
		InterestTopic.CoveredInLotsOfCum: Interest.Loves,
		InterestTopic.FullyNaked: Interest.KindaLikes,
		InterestTopic.ExposedPussy: Interest.ReallyLikes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedPanties: Interest.Dislikes,
		InterestTopic.ExposedBra: Interest.Dislikes,
		InterestTopic.LooseAnus: Interest.KindaLikes,
		InterestTopic.LoosePussy: Interest.KindaLikes,
		InterestTopic.TightAnus: Interest.Loves,
		InterestTopic.TightPussy: Interest.Loves,
		InterestTopic.HasVaginaOnly: Interest.ReallyLikes,
		InterestTopic.HasVaginaAndCock: Interest.Loves,
		InterestTopic.BigCock: Interest.Likes,
		InterestTopic.AverageCock: Interest.ReallyLikes,
		InterestTopic.SmallCock: Interest.ReallyLikes,
		InterestTopic.HasCockOnly: Interest.ReallyDislikes,
		InterestTopic.Pregnant: Interest.Loves,
	}
	
	npcHasMenstrualCycle = true
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Pregnant):
		return "Скоро станешь мамочкой? Мило~"
	if(interest == InterestTopic.TallyMarks):
		return "Я бы с удовольствием оставил на тебе побольше меток"
	if(interest == InterestTopic.BDSMRestraints):
		return "Разве ты не милая рабыня ограничений~"
	if(interest == InterestTopic.ThickButt):
		return "Такую задницу так и хочется пощупать"
	if(interest == InterestTopic.ExposedPanties):
		return "Снимай трусики, милашка"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Гермафродиты — это кайф~. Обожаю полный комплект~"
	if(interest == InterestTopic.StuffedPussyOrAss):
		return "Тебя трахнули, да~? Похотливая"
	if(interest == InterestTopic.TightAnus):
		return "Мамочке бы очень понравилось дрессировать твою жопку"
	if(interest == InterestTopic.TightPussy):
		return "Мы можем так весело тебя растягивать~"
	if(interest == InterestTopic.MediumBreasts):
		return "Обожаю твою сиську — не слишком маленькая, не слишком большая~"
	if(interest == InterestTopic.AverageCock):
		return "Какой у тебя классный член~"
	
func _getName():
	return "Nova"

func getGender():
	return Gender.Androgynous
	
func getPronounGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Серая хаски в высокотехнологичной броне охраны. Среднего роста, подтянутое телосложение"

func getSpecies():
	return ["canine"]

func _getAttacks():
	return ["stunbatonAttack", "stunbatonOverchargeAttack", "AIHumiliateMommy", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	var mes = "Силовая броня Новы вспыхивает огнями, когда она сжимает верный электрошокер и устремляет свой взгляд на тебя."
	mes += "\n\n"
	return mes+formatSay("У тебя нет права молчать: всё, что я скажу, будет использовано против тебя. Иди сюда, сладенькая~")

func getChatColor():
	return '#90A9F4'

func createBodyparts():
	var mybreasts: BodypartBreasts = GlobalRegistry.createBodypart("humanbreasts")
	mybreasts.size = BreastsSize.G
	giveBodypartUnlessSame(mybreasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("shorthair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	var penis:BodypartPenis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 21
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("huskytail"))

func getThickness():
	return 115

func onGivingBirth(_impregnatedEggCells: Array, _newkids: Array):
	.onGivingBirth(_impregnatedEggCells, _newkids)
	
	GM.main.increaseModuleFlag("NovaModule", "Nova_GaveBirthTimes", 1)

func onCharacterVisiblyPregnant():
	.onCharacterVisiblyPregnant()
	
	if(!GM.main.getModuleFlag("NovaModule", "Nova_FirstTimePregnantHappened", false)):
		GM.main.setModuleFlag("NovaModule", "Nova_NotThereToday", true)

func getLootTable(_battleName):
	return GuardLoot.new()

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"О, это была отличная попытка, милашка~",
				"Я на свободе. А ты — нет~",
				"Мило~",
				"Это было твое лучшее?!",
			])
		
		return RNG.pick([
			"Хафф, я становилась охранницей не для этого",
			"В моем контракте этого не было",
			"Это напоминает мне о моем прошлом",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Эй-эй-эй! С меня уже хватит",
				"Почему бы тебе не надеть это?",
				"Можешь разблокировать вот этот? Он мне не нужен",
				"Черт, надеюсь, у тебя нет запасного ошейника",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Хафф. Но я хочу пофлиртовать с тобой, сладенький",
				"Пора тренировать свою речь с кляпом",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Ого. Я тебе, блять, не домашний питомец",
				"Намордник? Ты это серьезно?",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"О, для остальных еще найдется местечко~",
				"Эй! Это не я задрот по жопам, это ты!",
				"У меня есть и побольше, хочешь попробовать~?",
			])
		if(restraintType == RestraintType.VaginalPlug):
			return RNG.pick([
				"Это мне подарок?",
				"У меня есть и побольше, хочешь попробовать~?",
			])
	
		return RNG.pick([
			"Это меня не сломит",
			"Черт возьми!",
			"Эй, ну хватит",
			"Глупый питомец, прекрати",
			"Это было бы извращенно, если бы это делал ты",
			"Я охранник, а не рабыня в кандалах",
		])
	return null

func getDefaultEquipment():
	return ["GuardArmor"]

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_STUNBATON
