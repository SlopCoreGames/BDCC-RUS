extends Character

func _init():
	id = "gymbully3"
	
	npcLevel = 5
	npcBasePain = 120
	npcBaseLust = 120
	npcBaseStamina = 50
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="SoftSpikySkin"
	pickedSkinRColor=Color("ffd07053")
	pickedSkinGColor=Color("ffdcdcdc")
	pickedSkinBColor=Color("ff7f573c")
	npcSkinData={
	"hair": {"r": Color("ff2c1e14"),"g": Color("ff1c1c1c"),"b": Color("ff000000"),},
	"arms": {"skin": "WoonaSkin",},
	"legs": {"skin": "MonsterGirl",},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.Likes,
		InterestTopic.Bodywritings: Interest.Likes,
		InterestTopic.Gags: Interest.Loves,
		InterestTopic.Blindfolds: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.KindaLikes,
		InterestTopic.ButtPlugs: Interest.KindaLikes,
		InterestTopic.VaginalPlugs: Interest.KindaLikes,
		InterestTopic.FeminineBody: Interest.ReallyLikes,
		InterestTopic.AndroBody: Interest.Dislikes,
		InterestTopic.MasculineBody: Interest.ReallyLikes,
		InterestTopic.ThickBody: Interest.KindaLikes,
		InterestTopic.AverageMassBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.Likes,
		InterestTopic.ThickButt: Interest.KindaLikes,
		InterestTopic.AverageButt: Interest.Likes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.KindaLikes,
		InterestTopic.SmallBreasts: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.KindaLikes,
		InterestTopic.BigBreasts: Interest.ReallyLikes,
		InterestTopic.LactatingBreasts: Interest.KindaLikes,
		InterestTopic.StuffedPussy: Interest.Likes,
		InterestTopic.StuffedAss: Interest.Likes,
		InterestTopic.StuffedPussyOrAss: Interest.Likes,
		InterestTopic.Pregnant: Interest.ReallyLikes,
		InterestTopic.StuffedThroat: Interest.Loves,
		InterestTopic.CoveredInCum: Interest.Likes,
		InterestTopic.CoveredInLotsOfCum: Interest.Loves,
		InterestTopic.FullyNaked: Interest.Loves,
		InterestTopic.ExposedPussy: Interest.KindaLikes,
		InterestTopic.ExposedAnus: Interest.KindaLikes,
		InterestTopic.ExposedBreasts: Interest.KindaLikes,
		InterestTopic.ExposedCock: Interest.KindaLikes,
		InterestTopic.ExposedPanties: Interest.Hates,
		InterestTopic.ExposedBra: Interest.Hates,
		InterestTopic.LooseAnus: Interest.Loves,
		InterestTopic.LoosePussy: Interest.Loves,
		InterestTopic.TightAnus: Interest.Hates,
		InterestTopic.TightPussy: Interest.Hates,
		InterestTopic.HasVaginaAndCock: Interest.Hates,
		InterestTopic.BigCock: Interest.Loves,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.Hates,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.Gags):
		return "КЛЕВАТЬ — ЭТО ПРОСТО ВОСТОРГ! Обожаю трахать заклеенных сучек, когда они ничего не могут сделать!"
	if(interest == InterestTopic.HasVaginaAndCock):
		return "ФУ! Из какой дырки ты вообще ссышь?!"
	if(interest == InterestTopic.TightAnus):
		return "СУЧКА, КАК ЖЕ Я ХОЧУ ЭТУ ЖОПУ. Отдал бы всё, чтобы снова потренировать свой грязный анус."
	if(interest == InterestTopic.TightPussy):
		return "ШЛЮХА! УБЕРИ ЭТУ ПРЕКРАСНУЮ ПИПКУ ОТСЮДА!"
	if(interest == InterestTopic.ExposedPanties):
		return "ДА ПОШЛО ТВОЁ ТРУСЕЛЬЕ, моё и дня не выдерживает!"
	if(interest == InterestTopic.ExposedBra):
		return "Чего ты там сиськи прячешь?! Это же тупо! Я хочу их видеть!"
	if(interest == InterestTopic.FullyNaked):
		return "КАКАЯ СМЕЛАЯ ШЛЮХА! ОБОЖАЮ ТЕБЯ!!"
	if(interest == InterestTopic.SmallCock):
		return "Ох.. хмм.. уф.. ой, прости. Это не твоя вина, ты такой родилась."
	if(interest == InterestTopic.BigCock):
		return "МЕНЯ НЕ ЗРЯ НАЗЫВАЮТ КОРОЛЕВОЙ РАЗМЕРОВ, ДАЙ МНЕ НАСАДИТЬ НА ЭТО!"
	if(interest == InterestTopic.Pregnant):
		return "ВСЕГДА БЕРЕМЕННАЯ — МОЁ КРЕДО"
	if(interest == InterestTopic.CoveredInLotsOfCum):
		return "ДА, БЛЯТЬ, ДАЙ МНЕ ТЕБЯ ОБЛИЗАТЬ! О-О-О!! МОЖНО МНЕ ЗАЛЕТЕТЬ, ЕСЛИ Я ПОТРУСУСЬ О ТЕБЯ ПИСЬКОЙ?"
	if(interest == InterestTopic.StuffedThroat):
		return "Мы можем поцеловаться и разделить эту сперму?!!"
	
	
func _getName():
	return "Bully Girl"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Заключенная в красной форме, на голове красная повязка."

func getFightIntro(_battleName):
	var text = "Девушка смотрит на тебя безумным взглядом, облизывая свой заточенный кусок металла, отчего тот даже слегка кровоточит."
	text += "\n\n"
	text += "[say=gymbully3]"+RNG.pick([
		"Неправильная девчонка с правильным ножом может натворить много добра в этом дерьмовом мире. С ума сойти, как они все считают себя нормальными~",
	])+"[/say]"
	
	return text

func getSpecies():
	return ["canine"]
	
func _getAttacks():
	return ["biteattack", "simplekickattack", "slapTitsAttack", "stretchingAttack", "ShivAttack", "shoveattack", "trygetupattack"]

func getThickness() -> int:
	return 70

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("messyhair"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 3
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformHighsec"]

func reactRestraint(restraintType, restraintAmount, isGettingForced):
	if(!isGettingForced):
		if(restraintAmount == 0):
			return RNG.pick([
				"А ТЕПЕРЬ ХВАТИТ!",
				"ВСЁ ЭТО — В ПОМОЙКУ!",
				"ЗАЖАТЬ АНУС, СУЧКА!",
				"Тебе меня не остановить!",
			])
		
		return RNG.pick([
			"ЭТО ВООБЩЕ НЕ ВЕСЕЛО!",
			"НУ И ОБЛОМ!",
			"Хафф!",
			"Веселье начинается только тогда, когда остальные связаны!",
		])
	
	if(isGettingForced):
		if(restraintAmount > 2 && RNG.chance(30)):
			return RNG.pick([
				"БЛЯТЬ, БЛЯТЬ, БЛЯТЬ",
				"СУКА, СУКА, СУКА",
				"ОХ, БЛЯТЬ, ОХ, ПИЗДЕЦ",
				"СУЧЬЯ ПОПА, ПИЗДА, СУКА, ШЛЮХА",
			])
		
		if(restraintType == RestraintType.Gag):
			return RNG.pick([
				"AHHH! FUUUCK",
				"СУЧКА, МОЙ ГАГ-ТЕЛК ПРОСТО ИДЕАЛЕН, Я ГОДЫ ТРЕНИРОВАЛСЯ!",
			])
		if(restraintType == RestraintType.Muzzle):
			return RNG.pick([
				"РРРРААААРР! Стоп, какого хуя?",
				"КАК МНЕ ТЕПЕРЬ СОСАТЬ ЧЛЕН?!",
			])
		if(restraintType == RestraintType.ButtPlug):
			return RNG.pick([
				"ПОЧЕМУ ОН ТАКОЙ МАЛЕНЬКИЙ?",
				"МНЕ НУЖНО КАК МИНИМУМ ТРИ, ЧТОБЫ ХОТЬ ЧТО-ТО ПОЧУВСТВОВАТЬ!",
				"СУЧКА, Я РАНЬШЕ В КОСПЛЕЕ КИТСУНЕ ХОДИЛА!",
			])
		if(restraintType == RestraintType.VaginalPlug):
			return RNG.pick([
				"Если это не фаллос размером с лошадиный член, я нихера не почувствую!",
				"Ой, мило!",
			])
		if(restraintType == RestraintType.Straitjacket):
			return RNG.pick([
				"ТОЛЬКО НЕ СНОВА! ДА ПОШЛА ОНА НАХУЙ, ЭТА ПСИХУШКА!",
				"НЕТ-НЕТ-НЕТ, ЭТО СЛИШКОМ НАПОМИНАЕТ МНЕ О ВРЕМЕНАХ В ПСИХУШКЕ!",
			])
	
		return RNG.pick([
			"ЧТО ЭТО ЗА ХУЙНЯ?",
			"ОХ, ЕБАНЫЙ В РОТ!",
			"Ты это серьезно?!",
			"БЛЯТЬ!",
			"Драться честно надо, сучка!",
		])
	return null

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_SHIV
