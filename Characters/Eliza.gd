extends Character

func _init():
	id = "eliza"
	npcLevel = 5
	npcBaseLust = 150
	npcBasePain = 120
	npcCharacterType = CharacterType.Nurse
	
	pickedSkin="ArconSkin"
	pickedSkinRColor=Color("fffee5c2")
	pickedSkinGColor=Color("fffff4f5")
	pickedSkinBColor=Color("ffd39666")
	npcSkinData={
	"head": {"skin": "LynxSkin",},
	"hair": {"r": Color("ffd6aac7"),"g": Color("fff1c0e0"),"b": Color("ff46460d"),},
	"ears": {"g": Color("ffdb6b74"),},
	"horns": {"r": Color("ffbd64a5"),"g": Color("ffebc57d"),"b": Color("ff9e0081"),},
	"penis": {"g": Color("ffff90e8"),"b": Color("ff8b0089"),},
	}
	
	npcLustInterests = {
		InterestTopic.Bodywritings: Interest.Loves,
		InterestTopic.Gags: Interest.ReallyLikes,
		InterestTopic.Blindfolds: Interest.ReallyLikes,
		InterestTopic.BDSMRestraints: Interest.ReallyLikes,
		InterestTopic.ButtPlugs: Interest.Likes,
		InterestTopic.VaginalPlugs: Interest.Likes,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.SlightlyDislikes,
		InterestTopic.MasculineBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.Dislikes,
		InterestTopic.ThickButt: Interest.ReallyDislikes,
		InterestTopic.AverageButt: Interest.ReallyLikes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.Dislikes,
		InterestTopic.SmallBreasts: Interest.SlightlyDislikes,
		InterestTopic.MediumBreasts: Interest.Likes,
		InterestTopic.BigBreasts: Interest.Hates,
		InterestTopic.LactatingBreasts: Interest.Loves,
		InterestTopic.StuffedPussy: Interest.Likes,
		InterestTopic.StuffedPussyOrAss: Interest.Likes,
		InterestTopic.StuffedThroat: Interest.Likes,
		InterestTopic.CoveredInCum: Interest.Likes,
		InterestTopic.CoveredInLotsOfCum: Interest.Dislikes,
		InterestTopic.FullyNaked: Interest.KindaLikes,
		InterestTopic.ExposedPussy: Interest.Likes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.ReallyLikes,
		InterestTopic.ExposedPanties: Interest.KindaLikes,
		InterestTopic.ExposedBra: Interest.KindaLikes,
		InterestTopic.LooseAnus: Interest.Likes,
		InterestTopic.LoosePussy: Interest.Dislikes,
		InterestTopic.TightAnus: Interest.Dislikes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.HasVaginaOnly: Interest.SlightlyDislikes,
		InterestTopic.HasVaginaAndCock: Interest.Likes,
		InterestTopic.BigCock: Interest.Loves,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.KindaLikes,
		InterestTopic.HasCockOnly: Interest.Loves,
		InterestTopic.Pregnant: Interest.KindaLikes,
	}
	npcHasMenstrualCycle = true
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Bodywritings):
		return "Я бы с удовольствием использовала твоё тело для медицинских заметок~"
	if(interest == InterestTopic.ThickButt):
		return "Тебе стоит подсушиться, такая огромная задница — это нездорово"
	if(interest == InterestTopic.NoBreasts):
		return "Плоская грудь меня не возбуждает, прости"
	if(interest == InterestTopic.BigBreasts):
		return "Такие вымени годятся только для дойки, фу~"
	if(interest == InterestTopic.ExposedCock):
		return "О~, вот теперь мы заговорили"
	if(interest == InterestTopic.BigCock):
		return "О боже, какой же ты огромный~"
	if(interest == InterestTopic.SmallCock):
		return "Какой милый член~"
	if(interest == InterestTopic.Pregnant):
		return "Приходи к нам, когда будешь готов рожать~"
	if(interest == InterestTopic.TightPussy):
		return "Люблю узкие, тугие щелочки, выглядят так чисто и сексуально"
	if(interest == InterestTopic.LactatingBreasts):
		return "Оооо! А можно их подоить? Прямо очень хочется~"
	
func _getName():
	return "Eliza Quinn"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Элегантная кошка с пастельно-жёлтой шерстью. Носит лабораторный халат, а на её поясе висит немало медицинских инструментов"

func getSpecies():
	return ["feline"]

func getFightIntro(_battleName):
	var text = "Элиза аккуратно собирает волосы в хвост и расстегивает лабораторный халат, демонстрируя на поясе целый арсенал шприцев, инъекторов, баночек с таблетками и флаконов с препаратами."
	text += "\n\n"
	text += "[say=eliza]"+RNG.pick([
		"Я доктор Куинн. Но можешь звать меня Королевой.",
		"Я могу показать тебе всё что угодно. Только попроси меня вежливо.",
		"У нас столько препаратов для испытаний, не глупи.",
		"Я тебе рассказывала, что однажды умудрилась взорвать целую лабораторию?",
	])+"[/say]"	
	
	return text
	
func _getAttacks():
	return ["biteattack", "stretchingAttack", "lickWounds", "trygetupattack", "ElizaHornyCloud", "ElizaHornyDrug", "ElizaTaunt", "ElizaWeaknessDrug", "NpcScratch", "ForceMuzzlePC"]

func getLootTable(_battleName):
	return MedicalLoot.new()

func getThickness() -> int:
	if(GM.main):
		var speciesTF:String = GM.main.getFlag("ElizaModule.elizatf_species", "")
		var bodyTF:String = GM.main.getFlag("ElizaModule.elizatf_body", "")
		
		if(bodyTF == "hucow"):
			return 120
		if(speciesTF == "demon"):
			return 90
	return 75

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("ponytailhair2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 4
	giveBodypartUnlessSame(breasts)

func updateBodyparts():
	if(!GM.main):
		return
	var cockTF:String = GM.main.getFlag("ElizaModule.elizatf_cock", "")
	var speciesTF:String = GM.main.getFlag("ElizaModule.elizatf_species", "")
	var bodyTF:String = GM.main.getFlag("ElizaModule.elizatf_body", "")
	
	var breasts: BodypartBreasts = getBodypart(BodypartSlot.Breasts)
	var breastsSize:int = breasts.size if breasts else -1
	
	var shouldPaint:bool = false
	var currentPP:String = ""
	if(hasPenis()):
		currentPP = getBodypart(BodypartSlot.Penis).id
	
	var elizaSkinType:String = ""
	
	if(cockTF == "canine"):
		if(currentPP != "caninepenis"):
			var penis = GlobalRegistry.createBodypart("caninepenis")
			penis.lengthCM = 22
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				shouldPaint = true
	elif(cockTF == "dragon"):
		if(currentPP != "dragonpenis"):
			var penis = GlobalRegistry.createBodypart("dragonpenis")
			penis.lengthCM = 22
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				shouldPaint = true
	elif(cockTF == "feline"):
		if(currentPP != "felinepenis"):
			var penis = GlobalRegistry.createBodypart("felinepenis")
			penis.lengthCM = 18
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				shouldPaint = true
	elif(cockTF == "horse"):
		if(currentPP != "equinepenis"):
			var penis = GlobalRegistry.createBodypart("equinepenis")
			penis.lengthCM = 25
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				shouldPaint = true
	elif(cockTF == "human"):
		if(currentPP != "humanpenis"):
			var penis = GlobalRegistry.createBodypart("humanpenis")
			penis.lengthCM = 20
			penis.ballsScale = 1
			if(giveBodypartUnlessSame(penis)):
				shouldPaint = true
	else:
		if(currentPP != ""):
			removeBodypart(BodypartSlot.Penis)
		
	var currentHead:String = getBodypart(BodypartSlot.Head).id if hasBodypart(BodypartSlot.Head) else ""
	if(speciesTF == "dragon"):
		if(currentHead != "dragonhead"):
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragonhead"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("demonhorns2"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragontail"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragonears"))
			shouldPaint = true
	elif(speciesTF == "catgirl"):
		elizaSkinType = "catgirl"
		if(currentHead != "humanhead" || !hasTail()):
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("humanhead"))
			if(hasHorns()):
				removeBodypart(BodypartSlot.Horns)
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears2"))
			shouldPaint = true
	elif(speciesTF == "human"):
		elizaSkinType = "human"
		if(currentHead != "humanhead" || hasTail()):
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("humanhead"))
			if(hasHorns()):
				removeBodypart(BodypartSlot.Horns)
			if(hasTail()):
				removeBodypart(BodypartSlot.Tail)
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("plantilegs"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("humanears"))
			shouldPaint = true
	elif(speciesTF == "demon"):
		elizaSkinType = "demon"
		if(currentHead != "felinehead" || !hasHorns()):
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("demonhorns2"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("demontail"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("hoofs"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
			shouldPaint = true
	else:
		if(currentHead != "felinehead" || hasHorns()):
			if(hasHorns()):
				removeBodypart(BodypartSlot.Horns)
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinetail"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
			giveBodypartUnlessSame(GlobalRegistry.createBodypart("felineears"))
			shouldPaint = true
	
	if(bodyTF == "hucow"):
		if(breastsSize != 10):
			breasts.size = 10
	elif(speciesTF == "demon"):
		if(breastsSize != 6):
			breasts.size = 6
	else:
		if(breastsSize != 4):
			breasts.size = 4
	
	
	
	if(elizaSkinType == "catgirl"):
		pickedSkin="FurGirl"
		pickedSkinRColor=Color("ffeebcad")
		pickedSkinGColor=Color("ffea8432")
		pickedSkinBColor=Color("fffee5c2")
		npcSkinData={
		"hair": {"r": Color("ffd6aac7"),"g": Color("fff1c0e0"),"b": Color("ff46460d"),},
		"ears": {"r": Color("ffd6aac7"),"g": Color("ffdb6b74"),},
		"penis": {"g": Color("ffff90e8"),"b": Color("ff8b0089"),},
		"tail": {"g": Color("ffd6aac7"),},
		}
	elif(elizaSkinType == "demon"):
		pickedSkin="ArconSkin"
		pickedSkinRColor=Color("fffee5c2")
		pickedSkinGColor=Color("fffff4f5")
		pickedSkinBColor=Color("ffd39666")
		npcSkinData={
		"head": {"skin": "LynxSkin",},
		"hair": {"r": Color("ffce74af"),"g": Color("fff1c0e0"),"b": Color("ff46460d"),},
		"ears": {"g": Color("ffdb6b74"),},
		"horns": {"r": Color("ffbd64a5"),"g": Color("ffebc57d"),"b": Color("ff9e0081"),},
		"tail": {"g": Color("ffeb7dbb"),},
		"legs": {"skin": "LuxeSkin","g": Color("ffeb7dbb"),},
		"penis": {"g": Color("ffff90e8"),"b": Color("ff8b0089"),},
		}
	elif(elizaSkinType == "human"):
		pickedSkin="FurGirl"
		pickedSkinRColor=Color("ffeebcad")
		pickedSkinGColor=Color("ffea8432")
		pickedSkinBColor=Color("ffebb7a0")
		npcSkinData={
		"hair": {"r": Color("ffd6aac7"),"g": Color("fff1c0e0"),"b": Color("ff46460d"),},
		"ears": {"g": Color("ffd79482"),},
		"penis": {"g": Color("ffffb290"),"b": Color("ffe0957e"),},
		"tail": {"g": Color("ffd6aac7"),},
		}
	else:
		pickedSkin="ArconSkin"
		pickedSkinRColor=Color("fffee5c2")
		pickedSkinGColor=Color("fffff4f5")
		pickedSkinBColor=Color("ffd39666")
		npcSkinData={
		"head": {"skin": "LynxSkin",},
		"hair": {"r": Color("ffd6aac7"),"g": Color("fff1c0e0"),"b": Color("ff46460d"),},
		"ears": {"g": Color("ffdb6b74"),},
		"horns": {"r": Color("ffbd64a5"),"g": Color("ffebc57d"),"b": Color("ff9e0081"),},
		"penis": {"g": Color("ffff90e8"),"b": Color("ff8b0089"),},
		}
	
	if(shouldPaint):
		paintBodyparts()
		#updateAppearance()

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Милая попытка",
				"Прелестно~",
				"Есть ещё такие?",
				"Это пойдёт в мою коллекцию",
			])
		
		return RNG.pick([
			"Ah..",
			"Это уже слишком",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"Ого, неужели сегодня я буду твоей веревочной зайкой?",
				"Странно, что мне это даже нравится?",
				"Сколько у тебя еще осталось?",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Ну же-е-е, у меня уже слюни текут!",
				"Как-то странно ощущается... а, ладно, не слушай меня",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Я тебе не собака!",
				"Зачем ты надела на кошку намордник?",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"Ой... Моя задница",
				"Ай! Ты что, смазки не добавил?",
			])
		if(restraintType == RestraintType.VaginalPlug):
			return RNG.pick([
				"Oh.. kinky",
				"Люблю играть с игрушками. Но обычно мои игрушки умеют разговаривать и извиваться.",
			])
		if(restraintType == RestraintType.Straitjacket):
			return RNG.pick([
				"Эй! Ты где это взял? Это же наше!",
				"Смирительная рубашка? Серьёзно? Ты же здесь пациент!",
			])
	
		return RNG.pick([
			"Мы будем драться или заниматься всякими извращениями? Или и то, и другое?",
			"Ох, извращения...",
			"Я тебе не раб на верёвках. Я что, кошечка для бондажа?",
			"Значит, тебя тянет на бондаж, да?",
			"Наркотики отлично сочетаются с бондажом",
		])
	return null

func getDefaultEquipment():
	return ["LabcoatOutfit", "LaceBra", "LacePanties", "ElizaNecklace"]

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_SYRINGE
