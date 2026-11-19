extends SexActivityBase

func _init():
	id = "Hypnotize"
	
	activityName = "Гипноз"
	activityDesc = "Заставь их подчиняться!"
	activityCategory = ["Hypnosis"]

func getGoals():
	return {
		SexGoal.Hypnotize: 1.0,
	}

func canStopSexWithThisActivity() -> bool:
	return true

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	if(_subInfo.getChar().isBlindfolded()):
		return false
	if(_subInfo.isUnconscious()):
		return false
	if(_domInfo.getChar().isBlindfolded()):
		return false
	if(_domInfo.getChar().isGagged()):
		return false
	if(_domInfo.getChar().isPlayer() && !_domInfo.getChar().hasPerk(Perk.HypnosisAmateurHypnotist)):
		return false
	return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getTags(_indx:int) -> Array:
	if(_indx == DOM_0):
		return [SexActivityTag.MouthUsed, SexActivityTag.HandsUsed]
	return []

func startActivity(_args):
	pass

func init_processTurn():
	if(doesCurrentAnimationHasEyeContact()):
		addTextPick([
			"{dom.You} [rainbow freq=0.05 sat=0.5 val=1.0]{dom.youVerb('stare')}[/rainbow] глубоко в глаза {sub.yourHis}.",
			"{dom.You} [rainbow freq=0.05 sat=0.5 val=1.0]{dom.youVerb('lock')} глаза {sub.yourHis}[/rainbow], завладевая всем вниманием {sub.yourHis}.",
			"Потерявшись во взгляде {dom.your}, мысли {sub.your} превращаются в [rainbow freq=0.05 sat=0.5 val=1.0]далекое эхо[/rainbow], поддаваясь пленительной тяге этих [rainbow freq=0.05 sat=0.5 val=1.0]гипнотических глаз[/rainbow].",
			])
	else:
		addTextPick([
			"{dom.You} [rainbow freq=0.05 sat=0.5 val=1.0]{dom.youVerb('hum')} тихо[/rainbow] на ухо {sub.yourHis}.",
			"[rainbow freq=0.05 sat=0.5 val=1.0]Мягкое, мелодичное напевание[/rainbow] срывается с губ {dom.your}, создавая успокаивающую атмосферу, пока {dom.youHe} нежно погружает сознание {dom.youHeVerb('guide')} {sub.yourHis} в царство глубокого расслабления.",
			"Нежным шепотом {dom.you} {dom.youVerb('plunge')} разум {sub.yourHis} в [rainbow freq=0.05 sat=0.5 val=1.0]гипнотическую пучину[/rainbow].",
			"Тихий шепот срывается с губ {dom.your}, увлекая {sub.you} в [rainbow freq=0.05 sat=0.5 val=1.0]нежные объятия гипноза[/rainbow].",
			"{dom.You} {dom.youVerb('hum')} слышит [rainbow freq=0.05 sat=0.5 val=1.0]успокаивающую мелодию[/rainbow], и её вибрации резонируют во всем {sub.yourHis} существе.",
			])
	affectDom(getDomInfo().fetishScore({Fetish.HypnosisHypnotist: 1.0})+0.0, 0.1, 0.0)
	affectSub(getSubInfo().fetishScore({Fetish.HypnosisSubject: 1.0})+0.0, 0.1, -0.02, 0.0)
	HypnokinkUtil.changeSuggestibilityBy(getSubInfo().getChar(), RNG.randi_range(4,6))
	fetishAffect(SUB_0, Fetish.HypnosisSubject)
	fetishAffect(DOM_0, Fetish.HypnosisHypnotist)


func getActions(_indx:int):
	if(_indx == DOM_0):
		if(state in [""]):
			addAction("stop", getStopScore(), "Прекратить гипноз", "Хватит пудрить им мозги.")
		if(state in [""]):
			if((getDom() == GM.pc) && (isSubInTrance()) && (!(getSub().hasEffect(StatusEffect.ImplantedPosthypnoticTrigger)))):
				addAction("implant_posthypno", 1.0, "Дать триггер", "Внедрить коварный постгипнотический триггер.")
	
	if(_indx == SUB_0):
		if(state in [""]):
			addAction("surrender", getComplyScore(SUB_0), "Сдаться", "Поддаться словам.")
		if(state in [""]):
			addAction("resist", getResistScore(SUB_0), "Сопротивляться гипнозу", "Не позволяй им управлять собой!", {A_CHANCE: getSubResistChance(20, 15)})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stop"):
		endActivity()
		addTextPick([
			"{dom.You} {dom.youVerb('stop')} копается в {sub.your} голове.",
			"{dom.You} {dom.youVerb('lean')} приходит в себя, разрушая чары."
		])
		return
	if(_id == "implant_posthypno"):
		getSub().addEffect(StatusEffect.ImplantedPosthypnoticTrigger)
		addText("{dom.You} {dom.youVerb('whisper')} прямо в {sub.your} ухо.")
		talkText(DOM_0, "Каждый раз, когда я щелкну пальцами, ты будешь...")
		return

	if(_id == "surrender"):
		var subSay:String = ""
		HypnokinkUtil.changeSuggestibilityBy(getSubInfo().getChar(), RNG.randi_range(4,16))
		
		if(isSubInTrance()):
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Повиноваться...", "Подчиняться...", "Да...",
				])
		elif(isSubHypnotized()):
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Я буду послушной...",
					"Я буду слушаться...",
					"Я подчиняюсь...",
					"Y-yes..."	
				])
		else:
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Чт-что ты...",
					"Что это такое?",
					"Что происходит?",
					"Я не..."	
				])
		if(subSay != ""):
			talkText(SUB_0, subSay)
		return
	if(_id == "resist"):
		addText("{sub.You} {sub.youVerb('try', 'tries')}, чтобы сопротивляться гипнотическому влиянию {dom.your}.")
		var subSay:String = ""
		getDomInfo().addAnger(0.04)
		
		if(isSubInTrance()):
			HypnokinkUtil.changeSuggestibilityBy(getSubInfo().getChar(), RNG.randi_range(4,16))
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Ннн...", 
					"Пожалуйста...", 
					"Can't...",
				])
		elif(isSubHypnotized()):
			HypnokinkUtil.changeSuggestibilityBy(getSubInfo().getChar(), RNG.randi_range(-4,2))
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Я не...",
					"Мне лучше...",
					"Я не буду...",
					"No...",
					"Я не могу..."
				])
		else:
			HypnokinkUtil.changeSuggestibilityBy(getSubInfo().getChar(), -RNG.randi_range(1, 16))
			if(RNG.chance(75)):
				subSay = RNG.pick([
					"Ты что творишь?",
					"Что это такое?",
					"Что происходит?",
					"Нет!",
					"Прекрати!"
				])
		
		if(HypnokinkUtil.getSuggestibleStacks(getSub()) < 5.0 && RNG.chance(getSubResistChance(20, 15))):
			addText("{sub.You} {sub.youVerb('manage')}, чтобы вырваться из гипнотического взгляда {dom.yourHis}!")
			failGoals()
			endActivity()
		
		if(subSay != ""):
			talkText(SUB_0, subSay)
		return

func getSubResistChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().hasBlockedHands()): # Can't cover eyes or something
		theChance *= 0.5
	if(getSub().hasBoundArms()):
		theChance *= 0.8
	if(getSub().hasBoundLegs()):
		theChance *= 0.8
	
	return max(theChance, 5.0)

func isSubHypnotized() -> bool:
	return HypnokinkUtil.isHypnotized(getSub())

func isSubInTrance() -> bool:
	return HypnokinkUtil.isInTrance(getSub())
	
func getAnimationPriority():
	return 0

func getAnimation():
	if(state == ""):
		return [StageScene.SexMissionary, "tease", {pc=DOM_0, npc=SUB_0}]

func doesCurrentAnimationHasEyeContact():
	var currentAnimData = getSexEngine().getBestAnimation()
	if(currentAnimData == null || currentAnimData.size() <= 0):
		return true
	
	if(currentAnimData[0] in [
		StageScene.BreastFeeding,
		StageScene.Choking,
		StageScene.Duo,
		StageScene.Duo,
		StageScene.HangingDuo,
		StageScene.HangingSex,
		StageScene.Hug,
		StageScene.PuppyDuo,
		StageScene.PuppyFeetCrotch,
		StageScene.PuppySexOral,
		StageScene.Rekt,
		StageScene.SexCowgirl,
		StageScene.SexCowgirlAlt,
		StageScene.SexCowgirlChoke,
		StageScene.SexFeetPlay,
		StageScene.SexHandjob,
		StageScene.SexMissionary,
		StageScene.SexStart,
		StageScene.SexTribadism,
		StageScene.UrinalPeeing,
		StageScene.UrinalSex,
		StageScene.DuoHypnoTied,
	]):
		return true
	return false
