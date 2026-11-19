extends SexActivityBase

var didSpankThisTime:bool = false
var didBigSpankThisTime:bool = false

var subShouldCount:bool = false
var correctSpankAmount:int = 0

var isFakeSpank:bool = false
var awaitsAnswer:bool = false

var correctTimer:int = 0
var wrongTimer:int = 0

var needToSayTooLate:bool = false
var needToSayAvoidedTrap:bool = false

var targetSpanks:int = 0
var coverButtTimer:int = 0

func _init():
	id = "Spanking"
	
	activityName = "Отшлепать"
	activityDesc = "Врежь ей по заднице!"
	activityCategory = ["Humiliate"]

func getGoals():
	return {
		SexGoal.SpankSub: 1.0,
	}

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(_domInfo.getChar().hasBlockedHands() || _domInfo.getChar().hasBoundArms()):
		return false
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.HandsUsed, SexActivityTag.HavingSex]
	if(_indx == SUB_0):
		return [SexActivityTag.AnusUsed, SexActivityTag.VaginaUsed, SexActivityTag.PenisUsed, SexActivityTag.HavingSex, SexActivityTag.PreventsSubTeasing]
	return []

func getCheckTagsSub() -> Array:
	return [SexActivityTag.AnusUsed, SexActivityTag.VaginaUsed, SexActivityTag.PenisUsed, SexActivityTag.HavingSex]

func startActivity(_args):
	targetSpanks = RNG.randi_range(5, 16)
	affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})+0.0, 0.1, -0.1, -0.01)
	addText("{dom.You} {dom.youVerb('prepare')}, чтобы отшлепать {sub.you}.")
	talkText(DOM_0, RNG.pick([
		"А ну, дай мне этот {butt}.",
		"Похоже, ты была плохой {sub.boy}.",
		"Заткнись и засунь этот {butt} себе поглубже.",
		"Не прикрывайся.",
		"Только посмей прикрыться!",
	]))

func init_processTurn():
	var text:String = ""
	var domSay:String = ""
	
	if(subShouldCount):
		if(correctTimer > 0):
			correctTimer = 0
			if(RNG.chance(20)):
				domSay = RNG.pick([
					"Мгм",
					"Верно.",
					"Хорошо.",
					"Продолжай считать",
					"Угу",
					"Молодец",
				])
		if(wrongTimer > 0):
			wrongTimer = 0
			domSay = RNG.pick([
				"Неа!",
				"Неверно!",
				"Подумай еще раз, тупая сучка.",
				"Неправильный ответ.",
				"Не-а.",
				"Ты реально так плохо считаешь?",
				"Серьезно?",
				"Да ты даже посчитать нормально не можешь?",
			])
		
		if(needToSayAvoidedTrap):
			needToSayAvoidedTrap = false
			text += RNG.pick([
				"{sub.You} избежал(а) ловушки!",
			])
			#isFakeSpank = false
			pass
		if(needToSayTooLate):
			needToSayTooLate = false
			text += RNG.pick([
				"{sub.You} не успел(а) ответить вовремя!",
			])
			getDomInfo().addAnger(0.3)
			domSay = RNG.pick([
				"Как можно так плохо считать?",
				"Время вышло!",
				"Думай быстрее!",
			])
	
	if(text != ""):
		addText(text)
	if(domSay != ""):
		talkText(DOM_0, domSay)


func getActions(_indx:int):
	if(_indx == DOM_0):
		addAction("stop", getStopScore(), "Перестать шлепать", "Перестать шлепать их")
		if(state in [""]):
			addAction("fakespank", 0.4-getDomInfo().getAngerScore()/3.0, "Потереть задницу", "Слегка потереть эту задницу и посмотреть на реакцию")
			addAction("spank", 1.0-getDomInfo().getAngerScore()/1.2, "Отшлепать", "Шлепнуть сабку один раз")
			addAction("bigspank", getDomInfo().getAngerScore(), "Сильно шлепнуть!", "Шлепнуть сабку со всей дури")
		if(!subShouldCount):
			addAction("startcount", 1.0, "Считать шлепки", "Заставить сабку считать шлепки")
		else:
			addAction("stopcount", 0.0, "Перестать считать", "Хватит считать шлепки")
	
	if(_indx == SUB_0):
		if(state in ["", "rimming"]):
			addAction("pullaway", getResistScore(SUB_0), "Отстраниться", "Попытаться отстраниться", {A_CHANCE: getSubResistChance(10.0, 5.0)})

		if(coverButtTimer <= 0 && !getSub().hasBoundArms()):
			addAction("coverbutt", 0.05-fetish(SUB_0, Fetish.Masochism)*0.1, "Прикрыть задницу", "Пытаться уклониться от боли")

		if(isReadyToCumHandled(SUB_0)):
			addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})

		if(subShouldCount && awaitsAnswer):
			var answers = [correctSpankAmount]
			while(answers.size() < 3):
				var randomNumber = RNG.randi_range(Util.maxi(correctSpankAmount-3, 0), correctSpankAmount+3)
				if(!answers.has(randomNumber)):
					answers.append(randomNumber)
			answers.shuffle()
			
			for answer in answers:
				var isCorrect = (answer==correctSpankAmount)
				if(isFakeSpank):
					isCorrect = false
				var mult = 1.0
				if(isFakeSpank):
					mult *= max(0.05, getSubInfo().personalityScore({PersonalityStat.Naive: 0.2}))
				elif(!isCorrect):
					mult *= max(0.05, getSubInfo().personalityScore({PersonalityStat.Brat: 0.3}))
				addAction(("correctnumber" if isCorrect else "badnumber"), getComplyScore(SUB_0) * mult, str(answer), "Скажите это", {A_ARGS: [answer]})

func getAssDescriptionAfterImpact(_isHard:bool=false) -> String:
	var subHealth = getSub().getPainLevel()
	
	if(subHealth < 0.1):
		return RNG.pick([
			"{sub.YourHis} {butt} всё еще в порядке.",
			"{sub.YourHis} {butt} еще не покраснела.",
			"{sub.YourHis} {butt} может выдержать куда больше шлепков.",
			"{sub.YourHis} {butt} может выдержать больше.",
		])
	if(subHealth < 0.3):
		return RNG.pick([
			"{sub.YourHis} {butt} начинает чувствовать приятное тепло.",
			"{sub.YourHis} {butt} начинает краснеть.",
			"{sub.YourHis} {butt} отлично разогревается.",
			"{sub.YourHis} {butt} покрывается легким розовым румянцем.",
		])
	if(subHealth < 0.6):
		return RNG.pick([
			"{sub.YourHis} {butt} розовеет от шлепков.",
			"{sub.YourHis} {butt} явно получает хорошую порцию шлепков.",
			"{sub.YourHis} {butt} начинает покрываться розовым цветом.",
			"{sub.YourHis} {butt} отлично отзывается на шлепки.",
		])
	if(subHealth < 0.9):
		return RNG.pick([
			"{sub.YourHis} {butt} теперь заметно покраснела.",
			"{sub.YourHis} {butt} получает знатную взбучку.",
			"{sub.YourHis} {butt} явно наслаждается хорошей порцией шлепков.",
			"{sub.YourHis} {butt} становится совсем красной и горячей.",
		])
	return RNG.pick([
		"{sub.YourHis} {butt} буквально горит от интенсивных шлепков.",
		"{sub.YourHis} {butt} хорошенько отшлепана и вся так и сияет.",
		"{sub.YourHis} {butt} приобрела прекрасный малиновый оттенок.",
		"{sub.YourHis} {butt} хорошенько отшлепана и готова к продолжению.",
	])

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stop"):
		addText("{dom.You} {dom.youVerb('stop')} начинает сеанс шлепков с {sub.you}.")
		endActivity()
		return
	if(_id == "startcount"):
		subShouldCount = true
		correctTimer = 0
		wrongTimer = 0
		correctSpankAmount = 0
		
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('tell')} просит {sub.you} начать считать шлепки.",
		])
		var addSay:String = ""
		if(!getDom().isPlayer()):
			addSay = " Я остановлюсь на "+str(targetSpanks)+" spanks."
		
		addText(text)
		talkText(DOM_0, "Считай, сколько раз я ударю тебя по заднице."+addSay)
		return
	if(_id == "stopcount"):
		subShouldCount = false
		correctTimer = 0
		wrongTimer = 0
		correctSpankAmount = 0
		awaitsAnswer = false
		needToSayAvoidedTrap = false
		needToSayTooLate = false
		
		addText("{dom.You} {dom.youVerb('tell')} просит {sub.you} перестать считать шлепки.")
		talkText(DOM_0, "Можешь перестать считать.")
		return
	if(_id == "fakespank"):
		didSpankThisTime = true
		if(subShouldCount):
			if(awaitsAnswer):
				if(isFakeSpank):
					needToSayAvoidedTrap = true
				else:
					needToSayTooLate = true
			awaitsAnswer = true
			isFakeSpank = true
			#correctSpankAmount += 1
		
		addTextPick([
			"{dom.You} {dom.youVerb('rub')} {sub.your} {butt}!",
			"{dom.You} gently {dom.youVerb('rub')} {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('caress', 'caresses')} {sub.your} задница!",
			"{dom.You} {dom.youVerb('brush', 'brushes')} {dom.yourHis} ладонь впечатывается в {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('poke')} {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('touch', 'touches')} {sub.your} {butt} слегка!",
		])
		
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})+0.6, 0.1, -0.01, -0.01)
		
		if(RNG.chance(50)):
			addText(getAssDescriptionAfterImpact(true))
		
		#getSubInfo().addPain(1)
		#affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})-0.3, 0.05, -0.1, -0.01)
		#affectDom(getSubInfo().fetishScore({Fetish.Sadism: 1.0})+0.3, 0.05, -0.01)
		
		return
	if(_id == "spank"):
		didSpankThisTime = true
		if(subShouldCount):
			if(awaitsAnswer):
				if(isFakeSpank):
					needToSayAvoidedTrap = true
				else:
					needToSayTooLate = true
			awaitsAnswer = true
			correctSpankAmount += 1
			isFakeSpank = false
		
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('spank')} {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('smack')} {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('hit')} {sub.your} задница!",
			"{dom.You} {dom.youVerb('deliver')} удар приходится по {sub.your} {butt}!",
			"{dom.You} {dom.youVerb('make')} {sub.your} {butt} колышется от шлепка!",
			"{dom.You} {dom.youVerb('spank')} {sub.your} {butt} слегка!",
		])
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})+0.3, 0.05, -0.1, -0.01)
		
		if(coverButtTimer > 0):
			coverButtTimer -= 1
			if(coverButtTimer <= 0):
				text += " {sub.YourHis} руки слишком сильно болят, чтобы продолжать."
			else:
				text += " {sub.YourHis} руки смягчили удар."
		else:
			getSubInfo().addPain(1)
			sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=1,isDefense=false,intentional=true})
		
		if(RNG.chance(50)):
			text += " "+getAssDescriptionAfterImpact(true)
		
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0}, -0.5), 0.1, -0.2, 0.0)
		affectDom(getDomInfo().fetishScore({Fetish.Sadism: 0.5}, 0.5), 0.1, 0.0)
		
		getSubInfo().addArousalSex(max(0.0, getSubInfo().fetishScore({Fetish.Masochism: 0.1})+0.02))
		
		sendSexEvent(SexEvent.Spanked, DOM_0, SUB_0, {strongSpank=false, pain=(0 if coverButtTimer > 0 else 1)})
		
		addText(text)
		return
	if(_id == "bigspank"):
		didBigSpankThisTime = true
		if(subShouldCount):
			if(awaitsAnswer):
				if(isFakeSpank):
					needToSayAvoidedTrap = true
				else:
					needToSayTooLate = true
			awaitsAnswer = true
			correctSpankAmount += 1
			isFakeSpank = false
		
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('spank')} {sub.your} {butt} [b]hard[/b]!",
			"{dom.You} {dom.youVerb('smack')} {sub.your} {butt} [b]со всей силы[/b]!",
			"{dom.You} {dom.youVerb('hit')} {sub.your} задницу [b]садистски[/b]!",
		])
		var damageDivider = 1
		if(coverButtTimer > 0):
			damageDivider = 2
			coverButtTimer -= 2
			if(coverButtTimer <= 0):
				text += " {sub.YourHis} руки слишком сильно болят, чтобы продолжать."
			else:
				text += " {sub.YourHis} руки смягчили удар."
		
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0}, -0.5), 0.1, -0.05, 0.0)
		affectDom(getDomInfo().fetishScore({Fetish.Sadism: 0.5}, 0.5), 0.2, 0.0)
		
		if(RNG.chance(50)):
			text += " "+getAssDescriptionAfterImpact(true)
		
		var addPain:int = int(round(10/damageDivider))
		getSubInfo().addPain(addPain)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=addPain,isDefense=false,intentional=true})
		affectSub(getSubInfo().fetishScore({Fetish.Masochism: 1.0})-0.6, 0.05, -0.1, -0.01)
		affectDom(getSubInfo().fetishScore({Fetish.Sadism: 1.0})+0.3, 0.05, -0.01)
		
		getSubInfo().addArousalSex(max(0.0, getSubInfo().fetishScore({Fetish.Masochism: 0.2})+0.02))
		
		sendSexEvent(SexEvent.Spanked, DOM_0, SUB_0, {strongSpank=true, pain=addPain})
		
		addText(text)
		return

	if(_id == "cum"):
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		
		#satisfyGoals()
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="spank"})
		addGenericOrgasmText(SUB_0)
		return
	if(_id == "coverbutt"):
		coverButtTimer = 3
		addText("{sub.You} {sub.youVerb('cover')} {sub.yourHis} {ass} {sub.yourHis} руками.")
		return
	if(_id == "correctnumber"):
		correctTimer = 2
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('say')} нужное число.",
		])
		
		awaitsAnswer = false
		getDomInfo().addAnger(-0.1)
		
		var randomAddition:String = RNG.pick([
			"Нгх..",
			"Кажется...",
			"Ах...",
			"ARgh..",
			"Ow..",
			"Блядь..",
		])
		
		var domSay:String = ""
		if(correctSpankAmount >= targetSpanks):
			satisfyGoals()
			if(!getDom().isPlayer()):
				domSay = RNG.pick([
					"Отлично, на этом хватит.",
				])
				endActivity()
		
		addText(text)
		talkText(SUB_0, str(correctSpankAmount)+"! "+randomAddition)
		talkText(DOM_0, domSay)
		return
	if(_id == "badnumber"):
		wrongTimer = 2
		var saidNumber = _action["args"][0]
		
		var text:String = RNG.pick([
			"{sub.You} {sub.youVerb('say')} [b]НЕПРАВИЛЬНОЕ[/b] число!",
		])
		if(isFakeSpank):
			text = RNG.pick([
				"{sub.You} удалось обмануть и назвать число [b]не получив порцию шлепков[/b]!",
			])
		
		awaitsAnswer = false
		getDomInfo().addAnger(0.4)
		
		var randomAddition = RNG.pick([
			"Наверное...",
			"Кажется.. погоди..",
			"Agh.. No.. wait..",
			"ARgh.. Please..",
			"Ow.. Yeah?..",
			"Блядь.. О нет..",
		])
		
		addText(text)
		talkText(SUB_0, str(saidNumber)+"! "+randomAddition)
		#talkText(DOM_0, "Wrong!")
		return
	if(_id == "pullaway"):
		addResistanceIfPlayer(_indx)
		var text:String = ""
		var successChance = getSubResistChance(30.0, 25.0)
		if(RNG.chance(successChance)):
			text = RNG.pick([
				"{sub.You} {sub.youVerb('pull')} от {dom.you}.",
			])
			getDomInfo().addAnger(0.3)
			if(state != ""):
				state = ""
			else:
				satisfyGoals()
				endActivity()
		else:
			text = RNG.pick([
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь вырваться из {dom.your} рук.",
				"{sub.You} отчаянно {sub.youVerb('try', 'tries')}, пытаясь вырваться из {dom.your} руки.",
			])
			getDomInfo().addAnger(0.03)
		addText(text)
		reactSub(SexReaction.Resisting, [50])
		return

func getRandomAnusWord() -> String:
	return RNG.pick(["задний вход", "anus", "tailhole"])
	
func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()):
		theChance *= 0.7
	if(getSub().hasBoundArms()):
		theChance *= 0.7
	if(getSub().isBlindfolded()):
		theChance *= 0.8
	if(getSub().hasBoundLegs()):
		theChance *= 0.5
	
	return max(theChance, 5.0)

func getOrgasmHandlePriority(_indx:int) -> int:
	if(_indx == SUB_0):
		return 5
	return -1

func saveData():
	var data = .saveData()

	data["subShouldCount"] = subShouldCount
	data["correctSpankAmount"] = correctSpankAmount
	data["isFakeSpank"] = isFakeSpank
	data["awaitsAnswer"] = awaitsAnswer
	data["correctTimer"] = correctTimer
	data["wrongTimer"] = wrongTimer
	data["needToSayTooLate"] = needToSayTooLate
	data["needToSayAvoidedTrap"] = needToSayAvoidedTrap
	data["targetSpanks"] = targetSpanks
	data["coverButtTimer"] = coverButtTimer

	return data

func loadData(_data):
	.loadData(_data)

	subShouldCount = SAVE.loadVar(_data, "subShouldCount", false)
	correctSpankAmount = SAVE.loadVar(_data, "correctSpankAmount", 0)
	isFakeSpank = SAVE.loadVar(_data, "isFakeSpank", false)
	awaitsAnswer = SAVE.loadVar(_data, "awaitsAnswer", false)
	correctTimer = SAVE.loadVar(_data, "correctTimer", 0)
	wrongTimer = SAVE.loadVar(_data, "wrongTimer", 0)
	needToSayTooLate = SAVE.loadVar(_data, "needToSayTooLate", false)
	needToSayAvoidedTrap = SAVE.loadVar(_data, "needToSayAvoidedTrap", false)
	targetSpanks = SAVE.loadVar(_data, "targetSpanks", 0)
	coverButtTimer = SAVE.loadVar(_data, "coverButtTimer", 0)

func getAnimation():
	if(state == ""):
		if(didSpankThisTime):
			didSpankThisTime = false
			return [StageScene.Spanking, "spankonce", {pc=DOM_0, npc=SUB_0}]
		if(didBigSpankThisTime):
			didBigSpankThisTime = false
			return [StageScene.Spanking, "fastonce", {pc=DOM_0, npc=SUB_0}]
		
		return [StageScene.Spanking, "tease", {pc=DOM_0, npc=SUB_0}]

func hasAnimsToPlay() -> bool:
	return true
