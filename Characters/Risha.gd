extends Character

func _init():
	id = "risha"
	npcLevel = 5
	npcBasePain = 150
	npcBaseLust = 120
	npcCharacterType = CharacterType.Guard
	
	pickedSkin="FerriSkin"
	pickedSkinRColor=Color("ff007e91")
	pickedSkinGColor=Color("ffd0e4e3")
	pickedSkinBColor=Color("ff000000")
	npcSkinData={
	"hair": {"r": Color("ff003e6f"),"g": Color("ff113c5e"),"b": Color("ff00335c"),},
	"ears": {"g": Color("ffff5858"),},
	"penis": {"g": Color("ffc31919"),"b": Color("ffd0501e"),},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Likes,
		InterestTopic.Bodywritings: Interest.ReallyLikes,
		InterestTopic.Gags: Interest.Likes,
		InterestTopic.Blindfolds: Interest.KindaLikes,
		InterestTopic.BDSMRestraints: Interest.Loves,
		InterestTopic.ButtPlugs: Interest.Likes,
		InterestTopic.VaginalPlugs: Interest.KindaLikes,
		InterestTopic.FeminineBody: Interest.ReallyLikes,
		InterestTopic.AndroBody: Interest.Likes,
		InterestTopic.MasculineBody: Interest.ReallyDislikes,
		InterestTopic.ThickBody: Interest.Dislikes,
		InterestTopic.AverageMassBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.ThickButt: Interest.Likes,
		InterestTopic.AverageButt: Interest.KindaLikes,
		InterestTopic.SlimButt: Interest.Dislikes,
		InterestTopic.SmallBreasts: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.ReallyLikes,
		InterestTopic.BigBreasts: Interest.Likes,
		InterestTopic.LactatingBreasts: Interest.Likes,
		InterestTopic.StuffedPussy: Interest.Loves,
		InterestTopic.StuffedAss: Interest.ReallyLikes,
		InterestTopic.StuffedPussyOrAss: Interest.Likes,
		InterestTopic.StuffedThroat: Interest.Likes,
		InterestTopic.CoveredInCum: Interest.ReallyLikes,
		InterestTopic.CoveredInLotsOfCum: Interest.Likes,
		InterestTopic.FullyNaked: Interest.Likes,
		InterestTopic.ExposedPussy: Interest.ReallyLikes,
		InterestTopic.ExposedAnus: Interest.Likes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.Dislikes,
		InterestTopic.ExposedPanties: Interest.Hates,
		InterestTopic.ExposedBra: Interest.Hates,
		InterestTopic.LooseAnus: Interest.KindaLikes,
		InterestTopic.LoosePussy: Interest.KindaLikes,
		InterestTopic.TightAnus: Interest.Likes,
		InterestTopic.TightPussy: Interest.Likes,
		InterestTopic.NoVagina: Interest.Hates,
		InterestTopic.HasVaginaOnly: Interest.Loves,
		InterestTopic.HasVaginaAndCock: Interest.Likes,
		InterestTopic.BigCock: Interest.Dislikes,
		InterestTopic.AverageCock: Interest.SlightlyDislikes,
		InterestTopic.SmallCock: Interest.KindaLikes,
		InterestTopic.NoCock: Interest.Likes,
		InterestTopic.HasCockOnly: Interest.SlightlyDislikes,
		InterestTopic.Pregnant: Interest.ReallyLikes,
	}
	
	npcHasMenstrualCycle = true
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Pregnant):
		return "Тебе тоже нравится размножаться, а? В следующий раз, когда пойдёшь в охоту, сразу ко мне"
	if(interest == InterestTopic.BDSMRestraints):
		return "О да, связанные шлюхи — это просто секс"
	if(interest == InterestTopic.NoVagina):
		return "Если у тебя нет киски, как я буду тебя трахать, шлюха?"
	if(interest == InterestTopic.ExposedBra):
		return "Выбрось этот сраный лифчик, здесь он тебе нахрен не нужен"
	if(interest == InterestTopic.ExposedPanties):
		return "Твои тупые трусики порвутся первыми"
	if(interest == InterestTopic.ExposedPussy):
		return "Да~. А теперь наклонись, шлюшка"
	if(interest == InterestTopic.BigCock):
		return "Клянусь, я подберу самую тесную клетку для твоего члена"
	if(interest == InterestTopic.StuffedPussy):
		return "О да, обожаю смотреть на осеменённых шлюх"
	if(interest == InterestTopic.StuffedAss):
		return "Ты там вся течёшь, шлюха"
	if(interest == InterestTopic.CoveredInCum):
		return "Так грязно... Обожаю конченых шлюх"
	if(interest == InterestTopic.FullyNaked):
		return "Думаешь, сможешь просто раздеться и чтобы я тебя после этого не оттрахал?"
	if(interest == InterestTopic.SlimButt):
		return "В эту жопку не влезет всё моё семя, шлюха"
	if(interest == InterestTopic.FeminineBody):
		return "Обожаю девчонок, они стонут лучше всех"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "Ты тоже герма, да~? Но в постели я ведущая"
	
	
func _getName():
	return "Risha"

func getGender():
	return Gender.Androgynous
	
func getPronounGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Очень высокая рысь с бирюзовой шерстью. Обычно носит громоздкую стражниковскую броню. Её кошачье лицо украшено кучей пирсинга"

func getSpecies():
	return ["feline"]

func _getAttacks():
	return ["aitaunthumiliate", "stunbatonAttack", "stunbatonStrongAttack", "biteattack", "simplekickattack", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	return getName() + " оглядывает тебя и облизывает губы.\n\n"+("[say=risha]Ты для меня — легкая добыча. Почему бы тебе просто не раздеться, чтобы мы могли повеселиться~[/say]")+"\n\nРиша встает в боевую стойку и жестом приглашает тебя подойти ближе. Её тяжелая броня, кажется, ни капли не мешает подвижности, а руку она крепко сжимает на электрошоковой дубинке\n\nПохоже, первый ход за тобой"

func getThickness() -> int:
	return 110

func getFemininity() -> int:
	return 70

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("felinehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("overeyehair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("lynxears2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("buffarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 8
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("felinepenis")
	penis.lengthCM = 22
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("shorttail"))

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"Ха-ха! И это всё?",
				"Жалкая попытка",
				"А теперь хватит пытаться меня связать и раздвигай ноги",
				"Hahaha, cute",
			])
		
		return RNG.pick([
			"Я сильная, если надо — порву эти путы пополам",
			"Они не удержат меня вечно",
			"От этого у меня только сильнее разгорается желание трахнуть твою задницу",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"О черт, прекрати",
				"Я не смогу тебя осеменить, если буду связана",
				"Сучка, здесь всё контролирую я",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"Эй! Не затыкай мне, блядь, рот!",
				"О-о-о, сейчас я тебя укушу",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"Эй! Не надевай на меня, сука, намордник!",
				"О-о-о, сейчас я тебя укушу",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"Блядь!",
				"Моя задница!",
				"Сучка, я еще отомщу твоей заднице!",
			])
		if(restraintType == RestraintType.VaginalPlug):
			return RNG.pick([
				"Оставь это для шлюх!",
				"Я не шлюха, это ты!",
				"Игрушки используют только шлюхи. У меня есть кое-что по-настоящему стоящее.",
			])
	
		return RNG.pick([
			"Эй! Вообще-то я охранница!",
			"Я еще применю это против тебя позже.",
			"Не вздумай меня злить.",
			"Так ты не победишь",
			"Сражайся со мной, а не занимайся этой хернёй",
			"Я — огромная кошка, тебя не свяжешь!",
		])
	return null

func getDefaultEquipment():
	return ["GuardArmor", "RishaPiercings"]

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_STUNBATON
