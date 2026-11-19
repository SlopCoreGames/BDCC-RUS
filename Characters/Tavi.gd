extends Character

func _init():
	id = "tavi"
	
	npcLevel = 5
	npcBasePain = 90
	npcBaseLust = 150
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="TaviSkin"
	pickedSkinRColor=Color("ff57197c")
	pickedSkinGColor=Color("fffedaff")
	pickedSkinBColor=Color("ff00ff1c")
	npcSkinData={
	"hair": {"r": Color("ff7f1b9b"),"g": Color("ff00ff0f"),"b": Color("ff631c89"),},
	"horns": {"r": Color("ff0f2c13"),"g": Color("ff0c2d16"),},
	"penis": {"g": Color("ff44f45d"),"b": Color("ff0c6214"),},
	}
	
	npcLustInterests = {
		InterestTopic.Gags: Interest.KindaLikes,
		InterestTopic.Blindfolds: Interest.Hates,
		InterestTopic.BDSMRestraints: Interest.ReallyLikes,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.ReallyDislikes,
		InterestTopic.MasculineBody: Interest.Likes,
		InterestTopic.ThickBody: Interest.KindaLikes,
		InterestTopic.AverageMassBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.ThickButt: Interest.Dislikes,
		InterestTopic.AverageButt: Interest.KindaLikes,
		InterestTopic.SlimButt: Interest.Likes,
		InterestTopic.BigBreasts: Interest.Hates,
		InterestTopic.LactatingBreasts: Interest.Hates,
		InterestTopic.StuffedPussy: Interest.Likes,
		InterestTopic.StuffedAss: Interest.Likes,
		InterestTopic.StuffedPussyOrAss: Interest.KindaLikes,
		InterestTopic.StuffedThroat: Interest.Dislikes,
		InterestTopic.CoveredInCum: Interest.ReallyLikes,
		InterestTopic.CoveredInLotsOfCum: Interest.ReallyDislikes,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPanties: Interest.ReallyLikes,
		InterestTopic.ExposedBra: Interest.ReallyLikes,
		InterestTopic.LooseAnus: Interest.Hates,
		InterestTopic.LoosePussy: Interest.Hates,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.HasVaginaAndCock: Interest.Dislikes,
		InterestTopic.BigCock: Interest.ReallyDislikes,
		InterestTopic.AverageCock: Interest.Dislikes,
		InterestTopic.SmallCock: Interest.SlightlyDislikes,
		InterestTopic.Pregnant: Interest.Hates,
	}
	npcHasMenstrualCycle = true
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Pregnant):
		return "Зачем ты перед ним нагнулась? Знаешь же, что бывает с тюремными детками?"
	if(interest == InterestTopic.Blindfolds):
		return "Как мне с тобой сражаться, если ты меня даже не видишь?"
	if(interest == InterestTopic.BigBreasts):
		return "Хватит выставлять свои вымя напоказ, дерись уже!"
	if(interest == InterestTopic.LooseAnus):
		return "Жопа выглядит совсем убитой, мерзость."
	if(interest == InterestTopic.LoosePussy):
		return "Ты трахаешься без передышки, да? Пизде твоего отдыха не знаешь?"
	if(interest == InterestTopic.BigCock):
		return "Этот член и близко ко мне не подойдет."
	if(interest == InterestTopic.HasVaginaAndCock):
		return "И что происходит, когда ты кончаешь сама в себя?"
	if(interest == InterestTopic.StuffedThroat):
		return "Не смей на меня дышать, шлюха."
	if(interest == InterestTopic.CoveredInCum):
		return "Ха, ну ты и грязная сучка."
	if(interest == InterestTopic.LactatingBreasts):
		return "Иди дои свои сиськи, они у тебя текут."
	
func _getName():
	return "Tavi"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Заключенная «красного блока». Очень высокая кошка с уникальным узором из фиолетовой и зеленой шерсти и красно-зелеными глазами."

func getSpecies():
	return ["feline"]

func _getAttacksForBattle(_battlename):
	if(_battlename == "tavi_lust_battle"):
		return ["TaviAlluringGaze", "TaviFelineGrace", "TaviSeductiveWhispers", "TaviSensualScratches", "TaviTemptingTease", "stretchingAttack", "lickWounds", "trygetupattack"]
	return null

func _getAttacks():
	return ["biteattack", "kickToBallsAttack", "slapTitsAttack", "stretchingAttack", "lickWounds", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	return getName() + " принимает боевую стойку и готовится к драке. "+formatSay("Что, боишься маленькую кошечку~?")

func getThickness() -> int:
	return 60

func getFemininity() -> int:
	return 90

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("tavihair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 4
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func updateBodyparts():
	var taviModule = GlobalRegistry.getModule("TaviModule")
	
	if(taviModule.shouldHaveCock()):
		if(!hasBodypart(BodypartSlot.Penis)):
			var penis = GlobalRegistry.createBodypart("felinepenis")
			penis.lengthCM = 22
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				paintBodyparts()
	else:
		removeBodypart(BodypartSlot.Penis)
	
	if(taviModule.hasHorns()):#.hasHorns()):
		if(giveBodypartUnlessSame(GlobalRegistry.createBodypart("demonhorns2"))):
			paintBodyparts()
	elif(hasBodypart(BodypartSlot.Horns)):
		removeBodypart(BodypartSlot.Horns)
	
	if(!taviModule.hasWombMark()):
		if(!hasPerk(Perk.StartNoHeat) || !hasPerk(Perk.StartInfertile)):
			skillsHolder.addPerk(Perk.StartNoHeat)
			skillsHolder.addPerk(Perk.StartInfertile)
		removeEffect(StatusEffect.TaviWombMark)
	else:
		if(hasPerk(Perk.StartNoHeat) || hasPerk(Perk.StartInfertile)):
			skillsHolder.removePerk(Perk.StartNoHeat)
			skillsHolder.removePerk(Perk.StartInfertile)
		addEffect(StatusEffect.TaviWombMark)

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformHighsec"]

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Есть еще, милашка~?",
				"Тебе лучше поискать цепи покрепче~",
				"Меня не остановить, никогда~",
				"Я — твой самый жуткий сон~",
			])
		
		return RNG.pick([
			"Хорошая разминка",
			"Эти стены меня надолго не удержат~",
			"Следующей целью буду ты~",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Это уже чересчур",
				"Хватит сопротивляться, смирись со своей судьбой",
				"Эм... может, просто поговорим?",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Кляп? Серьёзно?",
				"Тебе не нравится, когда я болтаю?",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Намордник? Ты издеваешься?",
				"Рыжая в наморднике. Ну надо же, как стереотипно",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"Ай!",
				"Пф!",
			])
		if(restraintType == RestraintType.VaginalPlug):
			return RNG.pick([
				"Эй! Не перегибай палку!",
			])
	
		return RNG.pick([
			"Это у тебя такая прелюдия?",
			"Ни наручники, ни ошейники меня не остановят",
			"Не вздумай меня злить.",
			"Так ты не победишь",
			"Почему бы тебе не попробовать драться честно?",
			"Пикантно~",
		])
	return null

func getCombatStance() -> int:
	return CombatStance.STANCE_LUST_SLY
