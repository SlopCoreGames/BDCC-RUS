extends SexActivityBase

var ticks:int = 0

func _init():
	id = "BeatingUpWhenAngry"
	
	activityName = "Избить"
	activityDesc = "Начинай избивать их!"
	activityCategory = ["Violence"]

func getGoals():
	return {
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.StocksSex: true,
		SexType.SlutwallSex: true,
		SexType.BitchsuitSex: true,
		SexType.TentaclesSex: true,
	}

func canStopSexWithThisActivity() -> bool:
	return true

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(_subInfo.isUnconscious()):
		return -1.0
	var theScore:float = _domInfo.getIsAngryScore() * 1.0 * max(0.1, 0.1 + _domInfo.personalityScore({PersonalityStat.Mean: 1.0})) - _subInfo.getAboutToPassOutScore() * _domInfo.fetishScore({Fetish.UnconsciousSex: -1.0})
	return min(theScore, 0.2)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.HandsUsed]
	return []

func startActivity(_args):
	if(isTentaclesSex()):
		addText("Разъяренные щупальца начинают хлестать {sub.you}!")
	else:
		addText("{dom.You} {dom.youVerb('start')} неистово избивает {sub.you}!")
	react(SexReaction.AboutToBeatUp)

func init_processTurn():
	ticks += 1
	strike(DOM_0, SUB_0, STRIKE_NORMAL)
	
	var texts:Array = [
		"{dom.You} {dom.youVerb('punch', 'punches')} {sub.youHim}.",
		"{dom.You} {dom.youVerb('punch', 'punches')} {sub.youHim} violently.",
		"{dom.You} {dom.youVerb('punch', 'punches')} {sub.yourHis} jaw.",
		"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.youHim}.",
		"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.youHim} helpless.",
		"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.yourHis} neck.",
		"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.yourHis} back.",
		"{dom.You} {dom.youVerb('pull')} on {sub.yourHis} hair.",
	]
	if(getSexType() == SexType.SlutwallSex):
		texts = [
			"{dom.You} {dom.youVerb('punch', 'punches')} {sub.youHim}.",
			"{dom.You} {dom.youVerb('punch', 'punches')} {sub.youHim} violently.",
			"{dom.You} {dom.youVerb('squeeze', 'squeezes')} больно лупит {sub.yourHis} по заднице.",
			"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.youHim}.",
			"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.youHim} helpless.",
			"{dom.You} {dom.youVerb('scratch', 'scratches')} {sub.yourHis} thighs.",
		]
	elif(getSexType() == SexType.TentaclesSex):
		texts = [
			"Щупальце хлещет {sub.youHim}.",
			"Щупальце бьет {sub.yourHis} в грудь.",
			"Щупальце хлещет {sub.yourHis} по спине.",
			"Щупальце хлещет {sub.yourHis} по ногам.",
			"Щупальца хлопают и бьют {sub.youHim}.",
			"Щупальце хлещет {sub.yourHis} по плечам.",
			"Тентакли яростно хлещут {sub.youHim}.",
			"Тентакль бьет {sub.yourHis} по животу.",
			"Тентакль хлещет {sub.yourHis} по рукам.",
		]
	
	var text:Array = []
	var amount = RNG.randi_range(1, Util.mini(3, texts.size()))
	for _i in range(amount):
		text.append(RNG.grab(texts))
	
	if(RNG.chance(1)):
		var damageText := damageClothes(SUB_0)
		if(damageText != ""):
			text.append(damageText)
			
	addText(Util.join(text, " "))
	react(SexReaction.BeatingUp, [30.0, 30.0])

func getActions(_indx:int):
	if(_indx == DOM_0):
		var stopScore:float = 1.0 - getDomInfo().getIsAngryScore() + getSubInfo().getAboutToPassOutScore() * fetish(DOM_0, Fetish.UnconsciousSex, 0.5)
		if(ticks < 2):
			stopScore *= 0.1
		addAction("stop", stopScore, "Прекратить избиение", "Довольно насилия")
		var hitHardScore:float = getDomInfo().getIsAngryScore()*fetish(DOM_0, Fetish.Masochism)*0.4 - getSubInfo().getAboutToPassOutScore() * fetish(DOM_0, Fetish.UnconsciousSex, 0.5)
		addAction("hithard", hitHardScore, "Бить очень сильно", "Заставить эту сучку пожалеть об этом")

func doAction(_indx:int, _actionID:String, _action:Dictionary):
	if(_actionID == "stop"):
		endActivity()
		if(isTentaclesSex()):
			addText("Тентакли перестали хлестать {sub.you}.")
		else:
			addText("{dom.You} {dom.youVerb('have', 'has')} перестал(а) избивать {sub.you}.")
	
	if(_actionID == "hithard"):
		strike(DOM_0, SUB_0, STRIKE_FULLFORCE)
		
		var text:String
		if(isTentaclesSex()):
			text = RNG.pick([
				"Толстый тентакль [b]очень сильно[/b] хлещет по телу {sub.your}.",
				"Щупальца с силой впечатывают {sub.youHim} в пол, [b]чертовски сильно[/b].",
				"Щупальце бьет {sub.youHim}, [b]очень мощно[/b]."
			])
		else:
			text = RNG.pick([
				"{dom.You} {dom.youVerb('hit')} {sub.youHim} [b]чертовски сильно[/b].",
				"{dom.You} {dom.youVerb('slam')} {sub.youHim} об стену, [b]очень жестко[/b].",
				"{dom.You} {dom.youVerb('punch', 'punches')} {sub.youHim} [b]чертовски сильно[/b].",
			])
		
		if(RNG.chance(33)):
			var damageText := damageClothes(SUB_0)
			if(damageText != ""):
				text += " "+(damageText)
		
		addText(text)
		react(SexReaction.BeatingUpHard, [100.0, 40.0])
		if(RNG.chance(50)):
			doWound(DOM_0, SUB_0)

func saveData():
	var data = .saveData()
	
	data["ticks"] = ticks

	return data
	
func loadData(data):
	.loadData(data)
	
	ticks = SAVE.loadVar(data, "ticks", 0)
