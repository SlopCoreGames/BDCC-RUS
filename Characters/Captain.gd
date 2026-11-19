extends Character

func _init():
	id = "captain"
	npcCharacterType = CharacterType.Generic
	
	pickedSkin="FerriSkin"
	pickedSkinRColor=Color("ff404040")
	pickedSkinGColor=Color("ff545454")
	pickedSkinBColor=Color("ff545454")
	npcSkinData={
	"hair": {"r": Color("ff252525"),"g": Color("ff252525"),"b": Color("ff001384"),},
	"ears": {"g": Color("ffe3776f"),},
	}
	
	npcLevel = 50
	npcBasePain = 300
	npcBaseLust = 500
	npcBaseStamina = 250
	npcArmor = {
		DamageType.Physical: 20,
		DamageType.Lust: 20,
		DamageType.Stamina: 20,
	}
	npcRestraintStrugglePower = 1.5
	npcBaseRestraintDodgeChanceMult = 0.5
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Likes,
		InterestTopic.Bodywritings: Interest.Likes,
		InterestTopic.Gags: Interest.Likes,
		InterestTopic.Blindfolds: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.Loves,
		InterestTopic.ButtPlugs: Interest.Likes,
		InterestTopic.VaginalPlugs: Interest.Likes,
		InterestTopic.FeminineBody: Interest.KindaLikes,
		InterestTopic.AndroBody: Interest.KindaLikes,
		InterestTopic.MasculineBody: Interest.KindaLikes,
		InterestTopic.ThickBody: Interest.KindaLikes,
		InterestTopic.AverageMassBody: Interest.KindaLikes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.ThickButt: Interest.KindaLikes,
		InterestTopic.AverageButt: Interest.KindaLikes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.KindaLikes,
		InterestTopic.SmallBreasts: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.KindaLikes,
		InterestTopic.BigBreasts: Interest.KindaLikes,
		InterestTopic.LactatingBreasts: Interest.Likes,
		InterestTopic.StuffedPussy: Interest.KindaLikes,
		InterestTopic.StuffedAss: Interest.KindaLikes,
		InterestTopic.StuffedPussyOrAss: Interest.KindaLikes,
		InterestTopic.Pregnant: Interest.KindaLikes,
		InterestTopic.StuffedThroat: Interest.KindaLikes,
		InterestTopic.CoveredInCum: Interest.KindaLikes,
		InterestTopic.CoveredInLotsOfCum: Interest.KindaLikes,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPussy: Interest.Likes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.Likes,
		InterestTopic.ExposedPanties: Interest.KindaLikes,
		InterestTopic.ExposedBra: Interest.KindaLikes,
		InterestTopic.LooseAnus: Interest.KindaLikes,
		InterestTopic.LoosePussy: Interest.KindaLikes,
		InterestTopic.TightAnus: Interest.KindaLikes,
		InterestTopic.TightPussy: Interest.KindaLikes,
		InterestTopic.HasVaginaAndCock: Interest.KindaLikes,
		InterestTopic.BigCock: Interest.KindaLikes,
		InterestTopic.AverageCock: Interest.KindaLikes,
		InterestTopic.SmallCock: Interest.KindaLikes,
	}
	
func _getName():
	return "Cpt. Wright"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Пёс с чёрной шерстью. Одет в очень официальную форму"

func getSpecies():
	return ["canine"]

func _getAttacks():
	return ["CapEnergyBlast", "CapTacticalStrike", "CapDisablingShot", "CapRapidFire", "CapTakeAim", "CapEvasiveManeuver", "trygetupattack"]

func getThickness() -> int:
	return 50

func getFemininity() -> int:
	return 0

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	var breasts = GlobalRegistry.createBodypart("malebreasts")
	breasts.size = -1
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("combedbackhair"))

func getDefaultEquipment():
	return ["OfficialClothes"]

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Прекрати пытаться, умоляю.",
				"Какому-то заключённому никогда не удастся меня остановить.",
			])
		
		return RNG.pick([
			"Эти стены не удержат меня вечно.",
			"Я пытался быть с тобой добрым. Много раз.",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Хм. Не думал о том, чтобы стать здесь охранником?",
				"Ты бы смог связать заключённых вот так?",
				"Всё выходит из-под контроля. Я должна тебя остановить.",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Хах. Так вот каково это на вкус.",
				"Мои способы контроля над другими выходят далеко за рамки простых слов.",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Намордник? Я что, случайно начала лаять приказами?",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"Ой! Как ты умудрился...",
			])
	
		return RNG.pick([
			"Ты только делаешь себе хуже.",
		])
	return null

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_PISTOL
