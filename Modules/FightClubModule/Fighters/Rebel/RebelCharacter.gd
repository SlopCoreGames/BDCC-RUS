extends Character

func _init():
	id = "rebel"
	
	npcLevel = 8
	npcBasePain = 180
	npcBaseLust = 120
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="LynxSkin"
	pickedSkinRColor=Color("ffab472b")
	pickedSkinGColor=Color("ffe7b686")
	pickedSkinBColor=Color("ff7a2a13")
	npcSkinData={
	"hair": {"r": Color("ffd42eb4"),"g": Color("ff00ff6c"),"b": Color("ffe105ff"),},
	"arms": {"skin": "MonsterGirl",},
	"tail": {"skin": "MonsterGirl",},
	"legs": {"skin": "MonsterGirl",},
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.ReallyLikes,
		InterestTopic.Bodywritings: Interest.ReallyLikes,
		InterestTopic.Gags: Interest.Likes,
		InterestTopic.BDSMRestraints: Interest.Likes,
		InterestTopic.ButtPlugs: Interest.Loves,
		InterestTopic.VaginalPlugs: Interest.Loves,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.Likes,
		InterestTopic.MasculineBody: Interest.Loves,
		InterestTopic.ThickBody: Interest.ReallyLikes,
		InterestTopic.AverageMassBody: Interest.ReallyLikes,
		InterestTopic.SlimBody: Interest.Likes,
		InterestTopic.ThickButt: Interest.KindaLikes,
		InterestTopic.AverageButt: Interest.Likes,
		InterestTopic.SlimButt: Interest.KindaLikes,
		InterestTopic.NoBreasts: Interest.ReallyDislikes,
		InterestTopic.SmallBreasts: Interest.Likes,
		InterestTopic.MediumBreasts: Interest.ReallyLikes,
		InterestTopic.BigBreasts: Interest.Loves,
		InterestTopic.LactatingBreasts: Interest.KindaLikes,
		InterestTopic.StuffedPussy: Interest.Likes,
		InterestTopic.StuffedAss: Interest.Likes,
		InterestTopic.StuffedPussyOrAss: Interest.Likes,
		InterestTopic.Pregnant: Interest.Hates,
		InterestTopic.StuffedThroat: Interest.KindaLikes,
		InterestTopic.CoveredInCum: Interest.KindaLikes,
		InterestTopic.CoveredInLotsOfCum: Interest.KindaLikes,
		InterestTopic.FullyNaked: Interest.ReallyLikes,
		InterestTopic.ExposedPussy: Interest.Loves,
		InterestTopic.ExposedAnus: Interest.Loves,
		InterestTopic.ExposedBreasts: Interest.KindaLikes,
		InterestTopic.ExposedCock: Interest.KindaLikes,
		InterestTopic.ExposedPanties: Interest.Hates,
		InterestTopic.ExposedBra: Interest.SlightlyDislikes,
		InterestTopic.LooseAnus: Interest.Loves,
		InterestTopic.LoosePussy: Interest.Loves,
		InterestTopic.TightAnus: Interest.Dislikes,
		InterestTopic.TightPussy: Interest.Dislikes,
		InterestTopic.NoVagina: Interest.Dislikes,
		InterestTopic.HasVaginaOnly: Interest.Likes,
		InterestTopic.HasVaginaAndCock: Interest.KindaLikes,
		InterestTopic.BigCock: Interest.Loves,
		InterestTopic.AverageCock: Interest.Likes,
		InterestTopic.SmallCock: Interest.ReallyDislikes,
		InterestTopic.HasCockOnly: Interest.Likes,
	}
	
func interestVerbalReaction(interest):
	if(interest == InterestTopic.BigCock):
		return "Обожаю крепкие жеребьи члены"
	if(interest == InterestTopic.LooseAnus):
		return "Ха! Твоя задница уже растянута. Но мы всегда идем дальше"
	if(interest == InterestTopic.TightAnus):
		return "Подготовка твоей жопки займет немало времени"
	if(interest == InterestTopic.Pregnant):
		return "Зачем ты пришла сюда беременной?"
	if(interest == InterestTopic.ButtPlugs):
		return "О да, я вижу, ты обожаешь тренировать свою задницу"
	if(interest == InterestTopic.ExposedPanties):
		return "Снимай трусики, милашка"
	if(interest == InterestTopic.AverageButt):
		return "Тряси этой попой, сладкая~"

func _getName():
	return "Rebel"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Высокая кобылка из красного блока. Выглядит очень мускулистой для самки: плотное тело, четко очерченные мышцы, огромные сиськи."

func getSpecies():
	return ["equine"]

func _getAttacks():
	return ["StrongPunch", "RebelThrow", "RebelTaunt", "RebelPin", "trygetupattack"]

func getFightIntro(_battleName):
	var text = "Бунтарка — настоящая рестлерша: она поворачивается к зрителям и взревывает, играя мускулами на всеобщее обозрение. А затем переключает всё своё внимание на тебя."
	text += "\n\n"
	text += "[say=rebel]Видишь это?[/say]"
	text += "\n\n"
	text += "Рэбел указывает на тебя, а затем сжимает руку в кулак."
	text += "\n\n"
	text += "[say=rebel]Когда ты проиграешь, это засунут тебе прямо в задницу, дорогуша. Всю мою гребаную руку целиком. Я превращу тебя в куклу на руке.[/say]"
	text += "\n\n"
	text += "Мысль о том, что эта дамочка сделает мне фистинг, пугает. Кажется, ставки еще никогда не были такими высокими."
		
	return text

func getThickness() -> int:
	return 125

func getFemininity() -> int:
	return 33

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("mohawkhair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("horseears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("buffarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 8
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("horsetail"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("hoofs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("horsehead"))

func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniform"]

func getCombatStance() -> int:
	return CombatStance.STANCE_COMBAT_RELAXED
