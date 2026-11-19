extends DialogueFiller

func _init():
	priority = 10

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var guard = getChar(_args, _form.mainRole)
	var personality:Personality = guard.getPersonality()
	var meanness = personality.getStat(PersonalityStat.Mean)
	var subby = personality.getStat(PersonalityStat.Subby)
	
	if(meanness > 0.2):
		return false
	if(subby <= 0.5):
		return false
	
	return true

func getFormIDs() -> Array:
	return [
		"SoftSlaveryOffer",
		"SoftSlaveryOfferYes",
		"SoftSlaveryPCOffer",
		"SoftSlaveryPCOfferYes",
		"SoftSlaveryPCOfferNo",
		
		"SoftSlaveryIntro1Willing",
		
		"SoftSlaveryIntro1",
		"SoftSlaveryIntro2",
		"SoftSlaveryIntro3",
		"SoftSlaveryIntroEND",
		
		"SoftSlaveryChangeName",
		"SoftSlaveryChangeNameEND",
		
		"SoftSlaveryAttackReaction",
		"SoftSlaveryAttackLost",
		"SoftSlaveryAttackWon",
		
		"SoftSlaveryAskedFreedom",
		"SoftSlaveryAskedFreedomPay",
		"SoftSlaveryAskedFreedomEND",
		
		"SoftSlaveryTalkStart",
		
		"SoftSlaveryProtectedByFriendStart",
		"SoftSlaveryProtectedByFriendResponse",
		"SoftSlaveryProtectedByFriendAllGoodResp",
		"SoftSlaveryProtectedByFriendLost",
		"SoftSlaveryProtectedByFriendWonThank",
		
		"SoftSlaveryChokeOutStart",
		"SoftSlaveryChokeOutEndured",
		"SoftSlaveryChokeOutPCWon",
		"SoftSlaveryChokeOutPCLost",
		"SoftSlaveryChokeOutPCLostSex",
		
		"SoftSlaveryFuckStart",
		"SoftSlaveryFuckResultGood",
		"SoftSlaveryFuckResultOkay",
		"SoftSlaveryFuckResultBad",
		
		"SoftSlaveryFuckNemesisApproach",
		"SoftSlaveryFuckNemesisAsk",
		"SoftSlaveryFuckNemesisAnswer",
		"SoftSlaveryFuckNemesisYes",
		"SoftSlaveryFuckNemesisNo",
		
		"SoftSlaveryFuckJealousStart",
		"SoftSlaveryFuckJealousFight",
		"SoftSlaveryFuckJealousOwnerWon",
		"SoftSlaveryFuckJealousOwnerWonFuck",
		"SoftSlaveryFuckJealousOwnerLostOffer",
		"SoftSlaveryFuckJealousOwnerLostOffer2",
		"SoftSlaveryFuckJealousOwnerLostOfferAgree",
		"SoftSlaveryFuckJealousOwnerLostOfferAgree2",
		"SoftSlaveryFuckJealousOwnerLostOfferNope",
		
		"SoftSlaverySlutwallStart",
		"SoftSlaverySlutwallLocked",
		
		"SoftSlaveryStocksStart",
		"SoftSlaveryStocksLocked",
		
		"SoftSlaveryGiveCreditsStart",
		"SoftSlaveryGiveCreditsTake",
		"SoftSlaveryGiveCreditsShort",
		
		"SoftSlaveryMarkingStart",
		"SoftSlaveryMarkingEnough",
		"SoftSlaveryMarkingAnother",
		"SoftSlaveryMarkingNoStart",
		"SoftSlaveryMarkingNo",
		"SoftSlaveryMarkingNoFail",
		"SoftSlaveryMarkingBegYes",
		"SoftSlaveryMarkingBegYes2",
		"SoftSlaveryMarkingBegNo",
		"SoftSlaveryMarkingBegNo2",
		"SoftSlaveryMarkingBegCredits",
		"SoftSlaveryMarkingBegCreditsGive",
		"SoftSlaveryMarkingBegCreditsGive2",
		"SoftSlaveryMarkingBegNoMarked",
		"SoftSlaveryMarkingBegFoot",
		"SoftSlaveryMarkingBegFootKiss",
		"SoftSlaveryMarkingBegFootKiss2",
		"SoftSlaveryMarkingBegHumiliation",
		"SoftSlaveryMarkingBegHumiliation2",
		"SoftSlaveryMarkingBegHumiliation3",
		"SoftSlaveryMarkingBegHumiliation4",
		"SoftSlaveryMarkingNotDone",
		"SoftSlaveryMarkingNotDoneStocks",
		"SoftSlaveryMarkingNotDoneStocks2",
		"SoftSlaveryMarkingNotDoneUrinal",
		"SoftSlaveryMarkingNotDoneUrinal2",
		
		"SoftSlaveryParadeAroundStart",
		"SoftSlaveryParadeAroundFirst",
		"SoftSlaveryParadeAroundMore",
		"SoftSlaveryParadeAroundLast",
		"SoftSlaveryParadeAroundFree",
		"SoftSlaveryParadeAroundEatGagged",
		"SoftSlaveryParadeAroundEat",
		"SoftSlaveryParadeAroundPlatform",
		"SoftSlaveryParadeAroundShower",
		
		"SoftSlaveryThreesomeStart",
		
		"SoftSlaveryPunishCredits",
		"SoftSlaveryPunishCredits2",
		
		"SoftSlaveryPunishRipClothes",
		
		"SoftSlaveryPunishRoughSex",
		"SoftSlaveryPunishRoughSexPCWon",
		"SoftSlaveryPunishRoughSexEnded",
		
		"SoftSlaveryPunishSlutwall",
		"SoftSlaveryPunishSlutwallLock",
		
		"SoftSlaveryPunishStocks",
		"SoftSlaveryPunishStocksLock",
		"SoftSlaveryPunishStocksAsk",
		"SoftSlaveryPunishStocksAskNope",
		"SoftSlaveryPunishStocksAskNoBuy",
		"SoftSlaveryPunishStocksAskNoBuy2",
		"SoftSlaveryPunishStocksAskNoBuy3",
		"SoftSlaveryPunishStocksAskSure",
		"SoftSlaveryPunishStocksAfterSex",
		"SoftSlaveryPunishStocksAfterBadSex",
		"SoftSlaveryPunishStocksAfterBadSex2",
		"SoftSlaveryPunishStocksOwnerLost",
		"SoftSlaveryPunishStocksOwnerLost2",
		"SoftSlaveryPunishStocksOwnerLost3",
		"SoftSlaveryPunishStocksOwnerWon",
		"SoftSlaveryPunishStocksOwnerWon2",
		"SoftSlaveryPunishStocksOwnerWon3",
		"SoftSlaveryPunishStocksOwnerWon4",
		
		"SoftSlaveryPunishSell",
		"SoftSlaveryPunishSell2",
		
		"SoftSlaveryPunishGB",
		"SoftSlaveryPunishGBGiveup",
		"SoftSlaveryPunishGBOffer",
		"SoftSlaveryPunishGBSure",
		"SoftSlaveryPunishGBFollow",
		"SoftSlaveryPunishGBSubOffer",
		"SoftSlaveryPunishGBSubOfferYes",
		"SoftSlaveryPunishGBSubOfferNo",
		"SoftSlaveryPunishGBSubOfferNoAw",
		"SoftSlaveryPunishGBNo",
		"SoftSlaveryPunishGBNoReact",
		"SoftSlaveryPunishGBStart",
		"SoftSlaveryPunishGBEnd",
		
		"SoftSlaveryPunishLockRestraint",
		"SoftSlaveryPunishLockRestraint2",
		"SoftSlaveryPunishLockRestraint3",
		
		"SoftSlaveryResist",
		
		"SoftSlaveryFuckInStocksExtra",
		"SoftSlaveryFuckInStocksExtraYes",
		"SoftSlaveryFuckInStocksExtraNo",
		"SoftSlaveryFuckInStocksExtraNo2",
		"SoftSlaveryFuckInStocksExtraFree",
		"SoftSlaveryFuckInStocksExtraFreeLost",
		
		"SoftSlaveryParadeFuckOffer",
		"SoftSlaveryParadeFuckOfferYes",
		"SoftSlaveryParadeFuckOfferYesThree",
		"SoftSlaveryParadeFuckOfferNo",
		"SoftSlaveryParadeFuckOfferNo2",
		"SoftSlaveryParadeFuckOfferGood",
		"SoftSlaveryParadeFuckOfferFight",
		"SoftSlaveryParadeFuckOfferWon",
		"SoftSlaveryParadeFuckOfferLostWatch",
		"SoftSlaveryParadeFuckOfferLostBoth",
		
		"SoftSlaveryParadeGuard",
		"SoftSlaveryParadeGuardPunish",
		"SoftSlaveryParadeGuardPunish2",
		"SoftSlaveryParadeGuardProblem",
		"SoftSlaveryParadeGuardProblem2",
		"SoftSlaveryParadeGuardWon",
		"SoftSlaveryParadeGuardLost",
		
		"SoftSlaveryGB",
		"SoftSlaveryGBGiveup",
		"SoftSlaveryGBOffer",
		"SoftSlaveryGBSure",
		"SoftSlaveryGBFollow",
		"SoftSlaveryGBSubOffer",
		"SoftSlaveryGBSubOfferYes",
		"SoftSlaveryGBSubOfferNo",
		"SoftSlaveryGBSubOfferNoAw",
		"SoftSlaveryGBNo",
		"SoftSlaveryGBNoReact",
		"SoftSlaveryGBStart",
		"SoftSlaveryGBEnd",
		
		"SoftSlaveryLockRestraint",
		"SoftSlaveryLockRestraint2",
		"SoftSlaveryLockRestraint3",
		"SoftSlaveryOfferGearUnlock",
		"SoftSlaveryOfferGearUnlock2",
		"SoftSlaveryOfferGearUnlockKeep",
		"SoftSlaveryOfferGearUnlockKeep2",
		"SoftSlaveryNoticedNoGear",
		"SoftSlaveryNoticedNoGear2",
		
		"SoftSlaveryAskSex",
		"SoftSlaveryAskFuckOwner",
		"SoftSlaveryAskFuckOwnerBad",
		"SoftSlaveryAskFuckOwnerOkay",
		"SoftSlaveryAskFuckOwnerGood",
		
		"SoftSlaveryPetFuck",
		"SoftSlaveryPetWalkies",
		"SoftSlaveryPetWalkiesReady",
		"SoftSlaveryWalkiesCorrect",
		"SoftSlaveryWalkiesWrong",
		"SoftSlaveryWalkiesBark",
		"SoftSlaveryWalkiesPet",
		"SoftSlaveryWalkiesGoodPuppy",
		"SoftSlaveryWalkiesGoodPuppySex",
		"SoftSlaveryWalkiesBadPuppy",
		"SoftSlaveryWalkiesBadPuppyObey",
		"SoftSlaveryWalkiesLostNotDone",
		"SoftSlaveryWalkiesBiteProtect",
		"SoftSlaveryWalkiesBiteBad",
		"SoftSlaveryWalkiesBiteAttack",
		"SoftSlaveryWalkiesBall",
		"SoftSlaveryWalkiesBall2",
		"SoftSlaveryWalkiesPraise",
		"SoftSlaveryWalkiesBallTooFarFake",
		"SoftSlaveryWalkiesBallTooFar",
		"SoftSlaveryWalkiesNoBallFound",
		
		"SoftSlaveryBegUnlockNo",
		"SoftSlaveryBegUnlockYes",
		"SoftSlaveryBegUnlockDone",
		
		#"SoftSlavery",
	]

func getText(_id:String, _args:Dictionary):
	if(_id == "SoftSlaveryOffer"):
		return [
			"Эм.. извините.. я тут подумала.. может.. вы не против стать моим?..",
			"Я.. я знаю, это много значит, но.. может, ты захочешь служить мне? Стать моей рабыней?..",
			"Мне иногда бывает одиноко.. может, составишь мне компанию? Ну.. знаешь.. станешь моей тюремной сучкой? Если хочешь..",
			"Если тебя это не слишком обременит.. позволишь мне поработить тебя?.. Мне бы не помешала тюремная сучка..",
			"Ты кажешься очень милым человеком.. и я подумала, может, я могла бы присматривать за кем-то вроде тебя.. Хочешь быть моей рабыней?",
			"Обычно я не прошу о таком, но.. может, ты станешь моим особенным человеком? Моей особенной.. рабыней?",
			"Если ты не слишком занят.. не хочешь ли ты принадлежать мне? Ну.. знаешь.. стать моей тюремной сучкой?",
		]
	if(_id == "SoftSlaveryOfferYes"):
		return [
			"О! Спасибо.. пожалуйста, иди за мной.",
			"Правда? Я так рада.. вот сюда, пожалуйста.",
			"Обещаю, я буду с тобой добра.. пойдешь за мной?",
			"Я постараюсь стать для тебя хорошим хозяином... пойдем со мной.",
			"Я так счастлива, что ты согласился... давай уйдем куда-нибудь в тихое место.",
			"Это очень много значит для меня... пожалуйста, иди за мной.",
			"Надеюсь, я смогу сделать тебя счастливым... пойдешь со мной?",
			"Спасибо за доверие... пойдем.",
		]
	if(_id == "SoftSlaveryPCOffer"):
		return [
			"Эм... если ты не слишком занят... можно мне стать твоей рабыней?",
			"Знаю, это звучит дерзко, но... не хочешь ли ты сделать меня своей рабыней?",
			"Если у тебя найдется место для рабыни... я бы хотела принадлежать тебе...",
			"Я надеялась, может быть... ты станешь моим хозяином? Если ты не против...",
			"Не хочу быть обузой, но... с тобой я буду чувствовать себя в безопасности. Хочешь, чтобы я стала твоей рабыней?",
			"Не слишком ли много будет просить... если я стану твоей рабыней?",
			"Думаю, я была бы счастлива служить кому-то вроде тебя... если ты позволишь...",
			"Можно мне... эм... стать твоим особенным человеком? Ну, знаешь... твоей рабыней?",
			"Я тут гадала... может, я тебе нужна? В смысле... чтобы быть твоей рабыней...",
		]
	if(_id == "SoftSlaveryPCOfferYes"):
		return [
			"Мне бы это очень понравилось... пожалуйста, пойдем со мной.",
			"Я надеялась, что ты спросишь... давай уйдем куда-нибудь, где нас никто не видит.",
			"Я буду счастлива, если ты будешь со мной... пойдешь за мной?",
			"Это делает меня такой счастливой... пожалуйста, пойдем со мной.",
			"Я сделаю всё возможное, чтобы позаботиться о тебе... вот так.",
			"Я бы очень хотела, чтобы ты был рядом... пойдешь со мной?",
			"Ничто не сделает меня счастливее... пожалуйста, следуй за мной.",
		]
	if(_id == "SoftSlaveryPCOfferNo"):
		return [
			"No.. sorry..",
			"Прости... я не могу.",
			"Прости... не сейчас...",
			"Нет... моя вина...",
		]
	if(_id == "SoftSlaveryIntro1Willing"):
		return [
			"Давай сделаем это...",
			"Эм... если ты готов(а)...",
			"Надеюсь, тебе удобно...",
			"Точно... да.",
			"Вот так...",
			"Hm.. good..",
		]
	
	if(_id == "SoftSlaveryIntro1"):
		return [
			"Эм... ты проснулся (проснулась)?",
			"Прости, что беспокою... но тебе пора открыть глаза. О, ты уже открыл?",
			"Привет. Ты как, в порядке?",
			"Привет... пора просыпаться. О, ты уже встал.",
			"Можешь открыть глазки для меня? О, вижу.",
			"Пожалуйста, просыпайся... О, привет.",
			"Ты наконец-то проснулся... Э-э.",
			"Просто проверяю, дышишь ли ты... Похоже, что да.",
			"Хорошо... ты проснулся. А я уже начала немного волноваться...",
			"Вижу, ты уже очнулся... Наверное, гадаешь, что происходит.",
			"Твои глаза открыты... это хорошо. Да?",
			"Ты какое-то время спала... Рада, что ты очнулась.",
			"Вот ты где... А я уже начала волноваться.",
			"Ты вернулась к нам... то есть, ко мне.",
		]
	if(_id == "SoftSlaveryIntro2"):
		return [
			"Отныне... ты моя {npc.npcSlave}... ты не против? Нет... то есть... у тебя всё равно нет выбора.",
			"Полагаю, это значит, что теперь ты моя {npc.npcSlave}. Надеюсь, это нормально... ну... да.",
			"Ты будешь моей {npc.npcSlave}... если ты не против... то есть... мне плевать, что ты думаешь, честное слово...",
			"Итак... теперь ты моя {npc.npcSlave}. Надеюсь, это достаточно ясно... Да.",
			"Это значит, что ты моя {npc.npcSlave}... если ты не возражаешь. Ага.",
			"Думаю... теперь ты принадлежишь мне... как моя {npc.npcSlave}... с этого самого момента.",
		]
	if(_id == "SoftSlaveryIntro3"):
		return [
			"Пожалуйста, делай, как я скажу. Я не хочу проблем... то есть... ты... черт...",
			"Если будешь слушаться... всё будет хорошо... иначе... мне, возможно, придётся тебя наказать.",
			"Мне бы очень хотелось, чтобы ты просто меня слушала... Понимаешь? Иначе... мне, может, придётся кое-что сделать? Ну, например... наказать тебя...",
			"Надеюсь, тебе не придётся заставлять меня наказывать тебя... Знаю, звучит... мягко... но я всё равно это сделаю.",
			"Пожалуйста, не сопротивляйся. Я не люблю конфликты... но если придётся, то придётся.",
			"Возможно, мне придётся тебя наказать, если ты не будешь слушаться... но мне бы этого не хотелось...",
			"Просто делай то, что я прошу... так будет проще. Иначе... мне придётся учиться тому, как тебя наказывать...",
			"Мне правда не хочется причинять тебе боль... или расстраивать тебя... так что, пожалуйста, слушайся...",
			"Было бы лучше, если бы ты просто говорила «да» на всё, что я тебе прикажу... Я не хочу наказывать...",
		]
	if(_id == "SoftSlaveryIntroEND"):
		return [
			"Я буду иногда заходить к тебе проверить, если ты не против.",
			"Я буду присматривать за тобой... не забывай обо мне.",
			"Я буду заходить время от времени... надеюсь, ты не против.",
			"Я буду заглядывать время от времени... просто узнать, как ты... а может, и не только.",
			"Я буду навещать тебя регулярно... если ты не возражаешь.",
			"Я буду иногда приходить к тебе... пожалуйста, будь готова.",
			"Я буду часто где-то рядом... надеюсь, это не проблема.",
			"Я буду часто проверять свою {npc.npcSlave}... ты не против? Да...",
			"Ты будешь часто меня видеть... надеюсь, тебя это не напрягает.",
			"Я буду навещать тебя регулярно... пожалуйста, будь готова мне помочь.",
		]

	if(_id == "SoftSlaveryChangeName"):
		return [
			"Эм... как бы ты хотела, чтобы я тебя называл...?",
			"У тебя есть... имя, которое тебе нравится, {npc.npcSlave}...?",
			"Я.. я могу называть тебя как-то иначе, если хочешь..",
			"Пожалуйста.. скажи, какое имя тебе нравится..",
		]
	if(_id == "SoftSlaveryChangeNameEND"):
		return [
			"Хорошо.. тогда ты будешь моей {npc.npcSlave}..",
			"Я постараюсь запомнить.. моя {npc.npcSlave}..",
			"Значит.. теперь ты моя {npc.npcSlave}..",
		]

	if(_id == "SoftSlaveryAttackReaction"):
		return [
			"Пожалуйста, не надо.. я не хочу проблем.. Но, похоже, мне придется дать отпор.",
			"Зачем тебе это..",
			"Это было действительно больно.. В душе.. Ладно.",
			"Я не люблю драться.. Но теперь приходится..",
			"Тебе не обязательно было так поступать.. но теперь мне приходится защищаться.",
			"Я не собираюсь сопротивляться... ну... наверное, всё-таки придётся.",
		]
	if(_id == "SoftSlaveryAttackLost"):
		return [
			"Я не хотела тебя разочаровывать... я всё ещё твоя собственница? Кажется, всё ещё...",
			"Ой... Больно. В этот раз ты победил...",
			"Не стоило мне пробовать... Прости меня...",
			"Ай... ладно, на этот раз ты выиграл...",
			"Ты победил... может, теперь ты наконец послушаешься?..",
		]
	if(_id == "SoftSlaveryAttackWon"):
		return [
			"Прости, что всё к этому пришло...",
			"Пожалуйста, не заставляй меня злиться на тебя...",
			"Жаль, что тебе пришлось заставить меня это сделать...",
			"Мне не хочется тебя наказывать... но у меня нет выбора...",
			"Это для твоего же блага... Надеюсь, ты понимаешь...",
			"Пожалуйста, прими свое наказание... Так будет лучше...",
		]

	if(_id == "SoftSlaveryAskedFreedom"):
		return [
			"Я могла бы отпустить тебя... если ты этого действительно хочешь... Но ты уверен, {npc.npcSlave}?",
			"Ох... эм... Полагаю, я могла бы освободить тебя... Но ты правда этого хочешь?",
			"Я... я не против, если ты уйдешь... Я хочу поддержать тебя... Но ты точно уверен?",
			"Думаю, я могла бы перестать заявлять на тебя права... если ты того хочешь... Но без защиты на станции может быть страшно...",
			"Может быть... я и отпущу тебя... Но ты уверен, что хочешь перестать быть моей {npc.npcSlave}?",
			"Я... я понимаю, если ты хочешь свободы... Но подумай о том, что ты оставляешь позади... Ты уверен?",
		]
	if(_id == "SoftSlaveryAskedFreedomPay"):
		return [
			"Я... я могла бы отпустить тебя... но сначала мне понадобятся <CREDITS>... если ты не против...",
			"Может быть... если ты заплатишь <CREDITS>... я смогу даровать тебе свободу...",
			"Я тут подумала... <CREDITS> будет честной ценой за твою свободу... если ты, конечно, хочешь...",
			"Эм... свобода будет стоить <CREDITS>... но только если ты точно уверена, что хочешь уйти...",
			"Мне нужно <CREDITS>, чтобы отпустить тебя... прости...",
			"Может быть... <CREDITS>? За твою свободу... если это действительно то, чего ты хочешь...",
		]
	if(_id == "SoftSlaveryAskedFreedomEND"):
		return [
			"Хорошо... теперь ты свободна... надеюсь, ты будешь счастлива.",
			"Я буду скучать по тебе... но ты можешь идти.",
			"Ну, тогда прощай... береги себя.",
			"Я понимаю... ты вольна уходить.",
			"Что ж... вот и всё... будь осторожна там, снаружи.",
			"Надеюсь, я была к тебе добра... прощай, {npc.npcSlave}.",
			"Можешь идти.. Со мной всё будет в порядке.",
			"Прощай.. Надеюсь, ты найдешь то, что ищешь.",
		]

	if(_id == "SoftSlaveryTalkStart"):
		return [
			"Эм.. что тебе нужно, {npc.npcSlave}?",
			"Да..? Что такое, {npc.npcSlave}?",
			"О, привет.. Хочешь чего-нибудь, {npc.npcSlave}?",
			"Привет.. Как дела, мой/моя {npc.npcSlave}?",
			"Хочешь о чем-то спросить? Не стесняйся..",
		]

	if(_id == "SoftSlaveryProtectedByFriendStart"):
		return [
			"Эм.. пожалуйста, не обижай {pc.name}.. {pc.He} {pc.isAre} мой/моя друг/подруга.",
			"Мог бы ты.. оставить {pc.name} в покое? {pc.He} {pc.isAre} мой/моя друг/подруга.",
			"Не думаю, что тебе стоит так поступать с {pc.name}.. {pc.He} {pc.isAre} мой/моя друг/подруга.",
			"Пожалуйста.. отпусти {pc.name}.. {pc.He} {pc.isAre} мой друг.",
			"Может.. тебе не стоит трогать {pc.him}.. {pc.He} {pc.isAre} мой друг.",
		]
	if(_id == "SoftSlaveryProtectedByFriendResponse"):
		return [
			"{pc.He} {pc.isAre} мой {npc.npcSlave}.. технически, я могу делать всё, что захочу..",
			"Пожалуйста, не усложняй.. не вмешивайся..",
			"Я не хочу с тобой проблем.. но.. сама понимаешь.. ты напрашиваешься.",
			"Тебе не стоит.. беспокоиться. {pc.He} {pc.isAre} мой {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryProtectedByFriendAllGoodResp"):
		return [
			"Ладно.. понятно.. прости..",
			"О-о-о. Точно. В этом есть смысл.",
			"Хорошо, не буду вам мешать.",
			"Прости.. прости меня..",
		]
	if(_id == "SoftSlaveryProtectedByFriendLost"):
		return [
			"Прости.. но тебе придется уйти..",
			"Ладно.. теперь тебе пора уходить..",
			"Я не хочу причинять тебе боль.. Пожалуйста, уходи..",
			"Я не хотела, чтобы так вышло.. но теперь тебе нужно уйти.",
			"Я просто.. попрошу тебя уйти.. прямо сейчас.",
		]
	if(_id == "SoftSlaveryProtectedByFriendWonThank"):
		return [
			"Не за что..",
			"Я просто рада, что смогла помочь..",
			"Конечно.. обращайся в любое время..",
			"Была рада помочь..",
			"Не стоит благодарности.. правда..",
		]

	if(_id == "SoftSlaveryChokeOutStart"):
		return [
			"Мне так плохо.. мне кто-то нужен, и ты здесь, {npc.npcSlave}.. прости..",
			"Я сейчас так злюсь.. а ты рядом, {npc.npcSlave}.. прости меня..",
			"Мне нужно выплеснуть это.. пожалуйста, не усложняй, {npc.npcSlave}.. мне очень жаль..",
			"Во мне всё так напряжено.. ты ведь поможешь мне, {npc.npcSlave}? Прости меня..",
		]
	if(_id == "SoftSlaveryChokeOutEndured"):
		return [
			"Сейчас мне чуть лучше.. ты помог, {npc.npcSlave}..",
			"Я успокоилась.. теперь можешь идти, {npc.npcSlave}..",
			"Это помогло.. спасибо, что помог..",
			"Мне это было нужно.. можешь уходить, {npc.npcSlave}..",
			"Мне лучше.. ты был мне полезен, {npc.npcSlave}.."
		]
	if(_id == "SoftSlaveryChokeOutPCWon"):
		return [
			"Ох.. ну зачем же тебе пришлось сопротивляться..",
			"Ты сильнее, чем я думала...",
			"Наверное, ты победил... только, пожалуйста, не делай мне больно...",
			"Ладно, ты выиграл... но ты всё равно нужен мне, {npc.npcSlave}...",
			"Пожалуйста, не сердись на меня...",
		]
	if(_id == "SoftSlaveryChokeOutPCLost"):
		return [
			"Ты отключился... я зашла слишком далеко...",
			"Я заставила тебя потерять сознание... прости меня, {npc.npcSlave}...",
			"Ты не смог продержаться... я была слишком грубой...",
		]
	if(_id == "SoftSlaveryChokeOutPCLostSex"):
		return [
			"Позволь мне просто...",
			"Наверное, не стоит... но, может, нам стоит...",
			"Я хочу кое-что попробовать...",
			"С таким же успехом, да?..",
		]

	if(_id == "SoftSlaveryFuckStart"):
		return [
			"Я тут подумала... может, мы могли бы... ну, ты понимаешь...",
			"Эм... если ты не против... я бы хотела быть поближе...",
			"Может... попробуем... что-нибудь... {npc.npcSlave}?",
			"Мне так... жарко... придешь ко мне...?",
			"Ты мне нужен... если ты не против...",
			"Пожалуйста, подойди ближе... я хочу чувствовать тебя...",
			"Ничего, если мы... ну...?",
			"Мне так неловко просить... но я хочу тебя...",
		]
	if(_id == "SoftSlaveryFuckResultGood"):
		return [
			"Это было... очень приятно... спасибо...",
			"Ты заставил меня чувствовать себя так хорошо.. {npc.npcSlave}..",
			"Надеюсь, тебе тоже понравилось.. это было чудесно..",
			"Ты потрясающий.. я сейчас так счастлива..",
			"Это было идеально.. ты идеален..",
			"Я чувствую такую близость с тобой.. спасибо..",
			"Ты был так добр ко мне.. {npc.npcSlave}..",
			"Это было даже лучше, чем я представляла..",
		]
	if(_id == "SoftSlaveryFuckResultOkay"):
		return [
			"Было неплохо.. может, как-нибудь попробуем еще раз..",
			"Спасибо.. мне понравилось быть с тобой.. в основном..",
			"Было нормально.. надеюсь, тебе тоже было хорошо..",
			"Мне понравилось... но иногда я начинаю нервничать...",
			"Надеюсь, тебе тоже понравилось... {npc.npcSlave}...",
			"Может, мы могли бы попрактиковаться еще... если хочешь...",
			"Было уютно... в хорошем смысле...",
		]
	if(_id == "SoftSlaveryFuckResultBad"):
		return [
			"Прости... вышло не так уж и хорошо...",
			"Если честно, было как-то... так себе...",
			"Может, тебе стоило... постараться? Ну, хоть чуть-чуть.",
			"Было немного... ну, ты понимаешь... плохо...",
		]

	if(_id == "SoftSlaveryFuckNemesisApproach"):
		return [
			"Oh.. um.. hello.. wow..",
			"Не ожидала увидеть тебя здесь... интересно...",
			"Это немного неловко... и иронично.",
			"Эм.. привет.. Интересно..",
		]
	if(_id == "SoftSlaveryFuckNemesisAsk"):
		return [
			"Что-то не так..?",
			"Тебе что-то нужно от меня..?",
			"Прости, если я мешаю..",
			"Эм.. что такое..?",
		]
	if(_id == "SoftSlaveryFuckNemesisAnswer"):
		return [
			"Я тут подумала.. может, мы могли бы.. эм.. вместе разобраться с {pc.name}.. {pc.He} наделал(а) мне гадостей..",
			"Твоя рабыня была довольно грубой со мной.. может, мы могли бы.. ну, ты понимаешь..",
			"Не люблю создавать проблемы, но.. {pc.name} поступил(а) со мной плохо.. Может, мы могли бы?..",
			"Может, мы могли бы.. эм.. вместе наказать {pc.name}.. если ты не против.. {pc.He} наделал(а) мне гадостей..",
		]
	if(_id == "SoftSlaveryFuckNemesisYes"):
		return [
			"Ладно.. если ты уверен(а)..",
			"Эм.. ну ладно..",
			"Думаю, мы могли бы попробовать.. вместе..",
			"Хорошо.. я помогу тебе своим {npc.npcSlave}..",
		]
	if(_id == "SoftSlaveryFuckNemesisNo"):
		return [
			"No.. {pc.He} {pc.isAre} mine..",
			"С {pc.him} я справлюсь сама.. Прости..",
			"Нет.. {pc.He} {pc.isAre} принадлежит мне, и разбираться с ним буду я. Прости.",
			"Я не стану делиться {npc.him}. {pc.He} {pc.isAre} мой.. прости.",
		]

	if(_id == "SoftSlaveryFuckJealousStart"):
		return [
			"Эм.. это мой {npc1.npcSlave}.. что ты делаешь..",
			"Ох.. пожалуйста, не трогай мой {npc1.npcSlave}..",
			"Простите.. этот {npc1.npcSlave} принадлежит мне..",
			"Не могли бы вы.. не делать этого с моим {npc1.npcSlave}..",
			"Не хочу проблем... но это моя {npc1.npcSlave}...",
		]
	if(_id == "SoftSlaveryFuckJealousFight"):
		return [
			"Пожалуйста... просто уйди... Эта {npc.npcSlave} — моя...",
			"Не хочу драться... но эта {npc.npcSlave} принадлежит мне...",
			"Можешь, пожалуйста, уйти... эта {npc.npcSlave} моя...",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWon"):
		return [
			"Видишь... {npc.npcSlave} моя... просто пойми это...",
			"Я же сказала... {pc.he} {pc.isAre} моя... запомни это...",
			"Так что видишь... {npc.npcSlave} остается со мной...",
			"{pc.He} {pc.verb('belong')} мне... теперь всё ясно?",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWonFuck"):
		return [
			"Тебе не стоило сюда приходить... теперь тебе тоже придется меня обслуживать...",
			"Так тебе и надо... теперь мне придется присматривать за вами обоими...",
			"Не самое подходящее время для твоего появления... но я не могу тебя сейчас отпустить... идите сюда оба...",
			"Ты совершил ошибку... теперь ты станешь моим вторым... наравне с моей {npc.npcSlave}...",
			"Ты вмешался... так что теперь вам обоим придется помогать мне с этим...",
			"Мне нужно облегчение... и вам обоим придется его обеспечить..."
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer"):
		return [
			"Погоди... может, мы могли бы... разделить {npc.npcSlave} на двоих...",
			"Пожалуйста... прежде чем мы начнем... что если мы разделим {npc.npcSlave}...",
			"Погоди-ка... может, {npc.npcSlave} сможет послужить нам обоим... если ты не против...",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer2"):
		return [
			"Это вина {pc.his}, что она нам не сказала... может, нам стоит наказать {pc.him} вместо неё...",
			"Моя {npc.npcSlave} никогда о тебе не упоминала... так что, возможно, нам стоит заставить {pc.him} за это поплатиться...",
			"Эта {npc.npcSlave} скрывала от нас секреты... может, нам стоит вместе преподать {pc.him} урок...",
			"Раз уж {npc.npcSlave} не был честен... может, заставим {pc.him} пожалеть об этом..",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree"):
		return [
			"Может, ты и прав..",
			"Звучит справедливо..",
			"Полагаю, так тоже можно..",
			"В этом есть смысл..",
			"Возможно, твой вариант лучше..",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree2"):
		return [
			"Тогда давай немного развлечемся..",
			"Нам стоит преподать {npc.npcSlave} урок..",
			"Ладно.. давай сделаем это..",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferNope"):
		return [
			"Ох.. тогда, пожалуй, мне придется взять вас обоих..",
			"Твои мольбы... они только заставляют меня хотеть поиграть с вами обоими..",
			"Мольбы не помогут... Мне придется использовать вас обоих...",
			"Интересная идея... но, думаю, я просто поиграю с вами обоими...",
		]

	if(_id == "SoftSlaverySlutwallStart"):
		return [
			"Я тут подумала, может, сегодня используем стену для шлюх... В смысле, я использую тебя... если ты не против...",
			"Стена для шлюх уже ждет нас... пожалуйста, не дергайся, {npc.npcSlave}...",
			"Иди сюда... сейчас я засуну тебя в стену для шлюх... только, пожалуйста, не сопротивляйся...",
			"Сегодня ты будешь моей игрушкой в стене для шлюх... покажешь мне свою шею?",
			"Я подумала, что мы могли бы попробовать стену для шлюх... пожалуйста, замри для меня, {npc.npcSlave}...",
			"Можешь быть хорошим и пойти со мной к стене для шлюх?.. Я подумала, что нам стоит попробовать...",
		]
	if(_id == "SoftSlaverySlutwallLocked"):
		return [
			"Теперь ты заперта... надеюсь, тебе удобно...",
			"Какой прекрасный вид... надеюсь, тебе комфортно...",
			"В таком виде ты выглядишь немного беззащитной... Мне это нравится.",
			"Теперь, когда ты надежно закреплена... мы можем начать... если ты готова...",
		]
	if(_id == "SoftSlaveryStocksStart"):
		return [
			"Я сегодня думала о колодках... чтобы на тебя смотрели другие... если ты не против... пожалуйста, не дергайся...",
			"Я хочу попробовать тебя в колодках... пожалуйста, замри, {npc.npcSlave}...",
			"Иди сюда... я собираюсь зафиксировать тебя в колодках... только, пожалуйста, не слишком сильно вырывайся...",
			"Сегодня ты будешь в колодках со мной... и люди могут наблюдать... покажешь мне свою шею?",
			"Я подумала, что мы могли бы использовать колодки, пока остальные смотрят... пожалуйста, не шевелись, {npc.npcSlave}...",
			"Будь хорошей девочкой и пойдем со мной к колодкам... я хочу тебя в них использовать.",
		]
	if(_id == "SoftSlaveryStocksLocked"):
		return [
			"Пожалуйста, не пытайся слишком сильно двигаться... надеюсь, это нормально...",
			"Ты заперта...",
			"В таком виде ты выглядишь... немного беззащитной. Мне это даже нравится.",
			"Теперь, когда ты надежно закреплена... мы можем начинать.",
		]
	if(_id == "SoftSlaveryGiveCreditsStart"):
		return [
			"У меня тут небольшая нехватка кредитов... мне нужно <CREDITS>, если сможешь помочь...",
			"Мне скоро понадобятся <CREDITS>... прямо сейчас. Если сможешь выделить их, {npc.npcSlave}...",
			"Ты не могла бы дать мне <CREDITS>... если тебя не затруднит...",
			"Я надеялась получить от тебя <CREDITS>... если ты не против...",
			"Можешь дать мне <CREDITS>?.. Они мне очень нужны.",
			"Я подумала, может быть, ты поможешь мне с <CREDITS>... если ты не против...",
		]
	if(_id == "SoftSlaveryGiveCreditsTake"):
		return [
			"Спасибо... это очень выручает.",
			"Это очень мило с твоей стороны.",
			"Я ценю это... так приятнее, когда ты помогаешь по доброй воле.",
			"Хорошо... я прослежу, чтобы их использовали с толком.",
			"Спасибо... мне они всё равно нужнее.",
			"Я ценю это... приятно, когда ты проявляешь заботу.",
			"Спасибо... я запомню это.",
		]
	if(_id == "SoftSlaveryGiveCreditsShort"):
		return [
			"Ох... у меня такое чувство, будто ты мне лжёшь. А мне не нравится это чувство.",
			"Правда?.. Я надеялась, что ты сможешь помочь. Но теперь мне придётся тебя наказать?",
			"У тебя недостаточно... это разочаровывает. Придётся тебя наказать.",
			"Понятно... я думала, ты сможешь помочь... но теперь мне придётся тебя наказать."
		]

	if(_id == "SoftSlaveryMarkingStart"):
		return [
			"Думаю, мне стоит пометить мою {npc.npcSlave}. Пожалуйста, не двигайся.",
			"Можешь не дергаться? Так люди будут знать, что ты мой/моя...",
			"Пожалуйста, не вздрагивай... Я просто хочу оставить пару меток на твоем {npc.npcSlave}.",
			"Если сможешь не шевелиться... Я хочу, чтобы все знали, кому ты принадлежишь.",
			"Смотри на меня и постарайся не двигаться... Хочу кое-что на тебе написать.",
			"Подойди ближе и веди себя тихо... Я хочу кое-что на тебе написать."
		]
	if(_id == "SoftSlaveryMarkingEnough"):
		return [
			"Должно хватить... Выглядит мило.",
			"Хорошо... Так пойдет.",
			"Идеально... В таком виде ты выглядишь отлично.",
			"На сегодня хватит. Выглядит неплохо, правда...?",
			"Готово. По-моему, выглядит красиво.",
			"Линии четкие. Тебе идет, такая как {npc.npcSlave}..",
		]
	if(_id == "SoftSlaveryMarkingAnother"):
		return [
			"Может, еще одну..?",
			"Добавить еще..? Пожалуй, так и сделаю.",
			"Думаешь, этого достаточно..? А мне кажется, нет.",
			"Кажется, я хочу добавить еще одну.",
			"Хочешь еще..? Я тоже. Пожалуйста, не двигайся.",
			"Я могла бы продолжить. Думаю, так и сделаю.",
			"Эти надписи так тебе идут.. Давай добавим еще одну.",
			"Ты немного дернулась.. Значит, нужно добавить еще одну.",
			"Ты заерзала.. Похоже, мне нужно написать еще несколько слов.",
			"Еще одна, наверное, не повредит... Пожалуйста, не дергайся.",
			"Надписи на теле — это довольно мило... Так что сейчас будет еще одна.",
		]
	if(_id == "SoftSlaveryMarkingNoStart"):
		return [
			"Ладно... Пожалуй, пока не буду тебя помечать...",
			"Ладно... Оставлю тебя пока без меток...",
			"Значит, не сегодня... Тебе повезло, наверное...",
			"Хорошо... В этот раз без надписей... Но ты всё равно принадлежишь мне, {npc.npcSlave}...",
			"Может, в другой раз... Но ты всё равно мой/твоя...",
			"Что-то сегодня не тянет... Радуйся...",
		]
	if(_id == "SoftSlaveryMarkingNo"):
		return [
			"Ладно. На сегодня хватит.",
			"Ладно... На этот раз закончили. Теперь ты выглядишь как следует помеченный/ая.",
			"На сегодня хватит... Если будешь вести себя хорошо, возможно, не стану добавлять больше.",
			"Должно хватить. Выглядит идеально...",
			"Пожалуй, я закончила... Надеюсь, люди заметят эти метки.",
			"Ладно... На данный момент ты отмечен(а) достаточно."
		]
	if(_id == "SoftSlaveryMarkingNoFail"):
		return [
			"Пожалуйста, не зли меня... Моему {npc.npcSlave} нужны эти метки.",
			"Не испытывай меня, {npc.npcSlave}... Либо ты получишь метки, либо мне придется тебя наказать...",
			"Если продолжишь испытывать меня, придется тебя наказать. Пожалуйста, стой смирно и принимай это...",
			"Пожалуйста, потише... Это мое решение. Тебе нужно быть отмеченным(ой).",
		]
	if(_id == "SoftSlaveryMarkingBegYes"):
		return [
			"О... ладно. Раз уж ты так мило просишь.",
			"Твои мольбы звучат так искренне... Я просто не могу отказать.",
			"Пожалуй, я буду снисходительна... только в этот раз.",
			"Ладно... раз уж ты так искренне умоляешь.",
		]
	if(_id == "SoftSlaveryMarkingBegYes2"):
		return [
			"Тогда этого должно быть достаточно.",
			"Думаю, на этом можно закончить.",
			"Можешь перестать скулить... я буду милосердна.",
			"Хорошо... этого хватит.",
		]
	if(_id == "SoftSlaveryMarkingBegNo"):
		return [
			"Может быть... если бы ты просил, стоя на коленях?",
			"Не мог бы ты умолять меня на коленях?",
			"Думаю, это звучало бы весомее, если бы ты стоял на коленях...",
			"Настоящие мольбы произносятся на коленях... если ты не против?",
		]
	if(_id == "SoftSlaveryMarkingBegNo2"):
		return [
			"Пожалуйста, встань на колени?",
			"Можешь опуститься на колени для меня?",
			"Мне бы очень хотелось, чтобы ты встала на колени...",
			"Kneel.. please..",
		]
	if(_id == "SoftSlaveryMarkingBegCredits"):
		return [
			"Может... 5 кредитов заставят меня передумать?",
			"Я могла бы остановиться за 5 кредитов... такова цена.",
			"5 кредитов могли бы убедить меня остановиться...",
			"Возможно, 5 кредитов заставят меня изменить решение...",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive"):
		return [
			"Спасибо... это много значит.",
			"Я ценю это... правда.",
			"Они пригодятся. Спасибо.",
			"Это очень мило с твоей стороны...",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive2"):
		return [
			"Думаю, на этом всё.",
			"На сегодня хватит.",
			"Пожалуй, на данный момент мы закончили.",
			"Может, нам стоит на этом закончить?",
		]
	if(_id == "SoftSlaveryMarkingBegNoMarked"):
		return [
			"Прости, что всё к этому пришло...",
			"Жаль, что ты не слушалась...",
			"Это был не самый лучший вариант...",
			"Мне правда не очень хотелось этого делать...",
			"Может, в следующий раз ты будешь послушнее...",
			"Надеюсь, это не слишком смущает...",
			"Мне тоже как-то не по себе..",
			"Может, теперь ты поймешь.."
		]
	if(_id == "SoftSlaveryMarkingBegFoot"):
		return [
			"Может.. ты поцелуешь мой {npc.foot} прямо сейчас?",
			"Ты не хочешь поцеловать мой {npc.foot}? Чтобы избежать меток?",
			"Может, если ты проявишь уважение к моему {npc.foot}, я соглашусь перестать?",
			"Я бы предпочла, чтобы ты поцеловал мой {npc.foot}, чем получил метку.. если ты не против?",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss"):
		return [
			"Это.. на самом деле довольно приятно.",
			"У тебя получается лучше, чем я ожидала..",
			"Это ощущается.. на удивление хорошо.",
			"Может, продолжишь? Если хочешь..",
			"Ты молодец...",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss2"):
		return [
			"Думаю, на сегодня хватит.",
			"Может, на этом остановимся?",
			"Полагаю, этого достаточно...",
			"Возможно, мы закончили.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation"):
		return [
			"Можешь, пожалуйста, признать, что ты моя {npc.npcSlave}?",
			"Может, скажешь, что ты принадлежишь мне? Если не против... Я очень хочу это услышать.",
			"Ты не против подтвердить, что ты моя {npc.npcSlave}?",
			"Может, признаешь, что ты моя собственность? Я хочу это услышать.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation2"):
		return [
			"Можешь сказать это чуть громче?",
			"Может, скажешь чуть громче?",
			"Я тебя почти не слышу...",
			"Повтори еще раз, но почетче?",
			"Попробуй сказать это с чувством?",
			"Можешь повторить увереннее?",
			"Чуть погромче, пожалуйста?",
			"Может, вложишь в это больше души?",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation3"):
		return [
			"Так уже лучше... спасибо.",
			"Куда искреннее... мне это нравится.",
			"Звучало очень искренне...",
			"У тебя начинает получаться.",
			"Спасибо, что стараешься сильнее...",
			"Думаю, теперь ты говоришь искренне.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation4"):
		return [
			"Полагаю, на этом мы закончили.",
			"Может, на сегодня хватит.",
			"Думаю, теперь можно остановиться.",
			"Может, нам стоит на этом закончить?",
		]
	if(_id == "SoftSlaveryMarkingNotDone"):
		return [
			"Эм... вообще-то... я еще не совсем с тобой закончила...",
			"Погоди, пожалуйста... есть еще кое-что... Да.",
			"Раз уж я задумалась... я бы хотела сделать с тобой еще кое-что. Прости.",
			"Ой, погоди. Если ты не против... есть еще кое-что, что я хотела бы попробовать...",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks"):
		return [
			"Это просто... чтобы ты чувствовала себя в большей безопасности...",
			"Надеюсь, это не выглядит слишком чересчур...",
			"Я подумала, что это поможет тебе чувствовать себя комфортнее...",
			"Это поможет тебе не шевелиться для меня... если ты не против.",
			"Я просто хочу убедиться, что всё пройдет гладко.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks2"):
		return [
			"Ох... выглядит... мило.",
			"Мне кажется... это подходит такой {npc.npcSlave}, как ты.",
			"Получилось... даже лучше, чем я ожидала.",
			"Надеюсь, тебе понравится, как это выглядит.",
			"Это... эм... именно то, на что я надеялась. Да.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal"):
		return [
			"Я тут подумала... мы могли бы попробовать пометить тебя вот так...",
			"Вот так бы я хотела тебя пометить... если ты не против...",
			"Ничего, если... я помечу тебя вот так?",
			"Мне кажется, это... самый правильный способ пометить кого-то...",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal2"):
		return [
			"Ты такая послушная для меня, {npc.npcSlave}...",
			"Ох... теперь ты выглядишь... очень даже помеченной...",
			"Надеюсь, тебе... было это приятно...",
			"Тебе это так идет...",
			"На тебе это смотрится... как надо...",
		]

	if(_id == "SoftSlaveryParadeAroundStart"):
		return [
			"Я тут подумала... может, прогуляемся по тюрьме? Чтобы остальные тебя видели.",
			"Эм, мне нужно надеть на тебя этот поводок... чтобы мы могли прогуляться по станции.",
			"Нам, пожалуй, пора прогуляться... чтобы люди могли увидеть мою {npc.npcSlave}.",
			"Я хочу провести тебя по всей тюрьме... если ты не против? Пожалуйста, подставь шею, {npc.npcSlave}.",
			"Может... немного пошаркаем сегодня напоказ? Хочется тебя немного выставить на обозрение.",
		]
	if(_id == "SoftSlaveryParadeAroundFirst"):
		return [
			"Тебе... пока нормально? Мы ведь только начали.",
			"Как ты себя чувствуешь, {npc.npcSlave}? Это только самое начало...",
			"Люди смотрят... но если тебе слишком тяжело, мы можем не уходить далеко.",
			"Как ты справляешься с вниманием? Мы можем не спешить.",
			"Это только первая часть... постарайся не слишком напрягаться.",
		]
	if(_id == "SoftSlaveryParadeAroundMore"):
		return [
			"Ладно... давай продолжим.",
			"Наверное, нам стоит продолжить... Пошли.",
			"Ты что, устаешь? Нам осталось осмотреть всего пару мест...",
			"Люди всё еще смотрят на нас... А мне это нравится. Идем дальше.",
			"Мне кажется... может, ты уже начинаешь к этому привыкать?",
			"В этом есть свое очарование... выставлять тебя напоказ вот так.",
			"Немного свежего воздуха... приятно, правда? Давай продолжим.",
		]
	if(_id == "SoftSlaveryParadeAroundLast"):
		return [
			"Еще всего одна остановка... Уверена, ты справишься.",
			"Осталась последняя остановка... Ты так хорошо держишься.",
			"Почти закончили... Постарайся продержаться и выглядеть гордой еще хоть мгновение.",
			"Последнее место... скоро сможешь отдохнуть.",
			"Остался последний этап... пожалуйста, не слишком смущайся.",
			"Мы почти закончили... еще совсем чуть-чуть.",
		]
	if(_id == "SoftSlaveryParadeAroundFree"):
		return [
			"Было хорошо... теперь ты можешь быть свободна, {npc.npcSlave}.",
			"Ладно... можешь идти. На какое-то время.",
			"На сегодня прогулок хватит... ты свободна, пока я снова тебя не позову.",
			"Хорошая работа... можешь идти. Только не забывай свое место, ладно?",
			"На сегодня всё... постарайся больше не доставлять проблем.",
			"Ты свободна... до следующего раза.",
		]
	if(_id == "SoftSlaveryParadeAroundEatGagged"):
		return [
			"Жаль, что ты не можешь поесть прямо сейчас... но я что-нибудь придумаю.",
			"Эм... тебе придется подождать, пока я поем. Таковы правила...",
			"Можешь просто... посидеть и посмотреть, как я ем? Может, позже тебе тоже что-нибудь перепадет.",
			"Жаль, что ты не можешь поесть вместе со мной... но тебе придется подождать.",
		]
	if(_id == "SoftSlaveryParadeAroundEat"):
		return [
			"Давай сделаем перерыв... тебе нужно что-нибудь съесть, {npc.npcSlave}.",
			"Может, тебе стоит присесть и съесть то, что тебе дали...",
			"Пора немного отдохнуть... пожалуйста, поешь.",
			"Вот твоя порция... не вздумай переводить ее, ладно?",
			"Тебе пора поесть... скоро нам снова нужно будет в путь.",
		]
	if(_id == "SoftSlaveryParadeAroundPlatform"):
		return [
			"Если будешь плохо себя вести... мне, возможно, придется запереть тебя в одном из этих.",
			"Эти колодки выглядят... устрашающе, не так ли?",
			"Вот где ты можешь оказаться... если мне придется тебя дисциплинировать.",
			"Если будешь плохо себя вести... мне, возможно, придется использовать что-то из этого.",
			"Тебе нравится? Мне просто любопытно.",
		]
	if(_id == "SoftSlaveryParadeAroundShower"):
		return [
			"Нам, пожалуй, стоит тебя отмыть... если ты не против.",
			"Тебе нужно освежиться... пожалуйста, не брыкайся.",
			"Я хочу, чтобы ты выглядел прилично... просто быстро сполоснись.",
			"Можешь встать под воду? Мне нужно тебя отмыть...",
		]

	if(_id == "SoftSlaveryThreesomeStart"):
		return [
			"Эм... сегодня со мной еще кто-то есть. Тебе придется... пожалуйста, обслужить нас обоих.",
			"Надеюсь, это нормально... я привела подругу. Ты нужен нам обеим.",
			"Извини за сюрприз... теперь ты будешь обслуживать нас двоих.",
			"Так нормально..? Сегодня ты будешь заботиться о нас обеих.",
		]
	if(_id == "SoftSlaveryPunishCredits"):
		return [
			"Придется мне кое-что у тебя забрать...",
			"Пожалуйста, не сердись... Мне нужно забрать часть за твое непослушание.",
			"Теперь это моё... Прости, но ты не оставил мне выбора.",
			"Как бы я хотела, чтобы ты не заставлял меня это делать... Забираю немного кредитов.",
			"Твои кредиты были бы в большей безопасности, если бы ты просто вел себя прилично...",
			"Это поможет тебе не забывать о послушании в следующий раз...",
			"Мне самой больнее, чем тебе... когда приходится забирать это.",
		]
	if(_id == "SoftSlaveryPunishCredits2"):
		return [
			"Если ты не будешь слушаться... мне, возможно, придется сделать кое-что похуже...",
			"Это всего лишь предупреждение... в следующий раз всё будет гораздо серьезнее.",
			"Я правда не хочу причинять тебе боль... просто, пожалуйста, начни слушаться.",
			"Пожалуйста, веди себя хорошо... Не заставляй меня в следующий раз прибегать к более жестким мерам.",
		]
	if(_id == "SoftSlaveryPunishRipClothes"):
		return [
			"Пожалуйста, начни слушаться, пока всё не стало еще хуже.",
			"А теперь веди себя прилично, пока я окончательно не вышла из себя.",
			"Прости, но у меня не было выбора. Давай не будем усложнять.",
			"Всё еще чувствуешь себя смелой? Пожалуйста, не заставляй меня делать то, о чем мы обе будем жалеть.",
			"А теперь давай попробуем вместо этого просто слушаться, ладно?",
		]
	if(_id == "SoftSlaveryPunishRoughSex"):
		return [
			"Ох... Значит, придется действовать по-плохому.",
			"Как бы я хотела, чтобы ты просто подчинялась... теперь мне придется быть твердой.",
			"Ты сама не оставляешь мне выбора... пожалуйста, не сопротивляйся.",
			"Мне от этого больнее, чем тебе... но ты не оставила мне другого выхода.",
			"Я правда не хотела этого делать... но ты сам меня вынудил.",
			"Твоё сопротивление только всё усложняет для нас обоих...",
			"Нужно было слушаться, когда была возможность... а теперь придётся делать это.",
			"Ты не облегчаешь нам жизнь, {npc.npcSlave}.",
			"Мне это не в радость... но тебе пора выучить своё место.",
			"Пожалуйста... просто смирись. Борьба сделает только хуже.",
			"Хоть бы ты не заставлял меня так поступать... это ведь для твоего же блага.",
		]
	if(_id == "SoftSlaveryPunishRoughSexPCWon"):
		return [
			"Ой... это ещё не конец, учти.",
			"Я с тобой ещё не закончила...",
			"Ты просто сам себе всё усложняешь...",
			"Это было ошибкой... для нас обоих.",
			"Ничего не изменилось... ты всё ещё моя.",
		]
	if(_id == "SoftSlaveryPunishRoughSexEnded"):
		return [
			"Пожалуйста, слушайся в следующий раз... мне не хочется прибегать к более жестким мерам.",
			"Пусть это будет уроком... моё терпение не бесконечно.",
			"Считай, что ты предупреждена... у меня тоже есть свои пределы.",
			"Это была лишь разминка... в следующий раз всё будет серьезнее.",
			"Запомни это ощущение... всё может стать куда более неприятным.",
			"В этот раз тебе повезло... пожалуйста, не испытывай меня.",
			"Это была лишь капля того, что бывает, когда ты ослушиваешься...",
		]
	if(_id == "SoftSlaveryPunishSlutwall"):
		return [
			"А теперь иди к стене для шлюх... не заставляй меня тащить тебя силой.",
			"Мы идем к стене шлюх. Понимаешь? Вот так..",
			"Пожалуйста, следуй за мной к стене шлюх.. иначе мне придется заставить тебя.",
			"Иди за мной добровольно.. я не хочу причинять тебе боль.",
			"Стена шлюх уже ждет.. давай не будем усложнять.",
			"Иди тихо.. не стоит делать всё еще сложнее.",
			"Пожалуйста, не сопротивляйся.. просто иди.",
		]
	if(_id == "SoftSlaveryPunishSlutwallLock"):
		return [
			"Надеюсь, тебе.. понравится, когда тебя будут использовать. Это твое наказание.",
			"Теперь ты будешь доступна для всеобщего пользования.. Это твое наказание.",
			"Постарайся быть полезной.. Это твое наказание.",
			"Вот для чего ты годишься.. чтобы тебя использовали. Это твое наказание.",
			"По крайней мере, здесь ты приносишь хоть какую-то пользу... Это твоё наказание.",
			"Может, это поможет тебе вести себя лучше... Это твоё наказание.",
		]

	if(_id == "SoftSlaveryPunishStocks"):
		return [
			"Пожалуйста, иди за мной... Не заставляй меня применять силу.",
			"Можешь идти сама? Не хотелось бы тебя тащить...",
			"Давай просто тихо пойдём к колодкам, ладно?",
			"Пожалуйста, иди за мной... Не хочу усложнять тебе жизнь больше необходимого.",
		]
	if(_id == "SoftSlaveryPunishStocksLock"):
		return [
			"Я... я даже не знаю, что с тобой сейчас делать. Может, другие справятся лучше.",
			"Ты меня совсем не слушаешь... возможно, другие смогут до тебя достучаться.",
			"Раз уж ты не слушаешься меня... может, ты лучше откликнешься на незнакомцев.",
			"Из-за твоего поведения ты будешь доступна для любого, кто захочет... Мне жаль.",
			"Раз уж ты не хочешь вести себя послушно.. возможно, стоит поучиться у других.",
		]
	if(_id == "SoftSlaveryPunishStocksAsk"):
		return [
			"{pc.he} свободен/свободна для использования?",
			"Эм.. а этим можно воспользоваться?",
			"Можно мне.. твоего раба/твою рабыню?",
			"Ты не против, если я воспользуюсь твоим рабом/твоей рабыней?",
			"Твой раб/твоя рабыня выглядит так, будто {pc.he} нуждается во внимании.. можно?",
			"Можно мне тоже по очереди с твоим рабом/твоей рабыней?",
			"Твой раб/твоя рабыня свободен/свободна?",
		]
	if(_id == "SoftSlaveryPunishStocksAskNope"):
		return [
			"Эм.. нет. Сначала <CREDITS> кредитов, а потом уже сможешь использовать {pc.him}.",
			"Не бесплатно, прости.. сначала <CREDITS> кредитов.",
			"У всего есть своя цена... <CREDITS> кредитов, и {pc.he} будет {pc.isAre} твоей.",
			"<CREDITS> кредитов — и ты сможешь... делать с {pc.him} всё, что захочешь.",
			"Заплати <CREDITS> кредитов, и сможешь использовать {pc.him} как пожелаешь.",
			"Я не могу просто так отдать {pc.him}... за использование нужно <CREDITS> кредитов.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy"):
		return [
			"А если я не хочу платить?",
			"Не уверен, что хочу платить за подержанный товар...",
			"Для поврежденного имущества это кажется дороговато...",
			"Думаю, это больше, чем стоит эта рабыня...",
			"Не хочу столько отваливать за непослушную рабыню...",
			"Твоя рабыня не кажется настолько ценной...",
			"Эта выглядит уже довольно потрёпанной... зачем мне за неё платить?",
			"Я бы лучше просто... забрал {pc.him}, чем платил...",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy2"):
		return [
			"Тогда, пожалуйста, уходи...",
			"Эм... нет кредитов — нет толку. Пожалуйста, оставь меня.",
			"Тогда хватит тратить моё время... тебе пора.",
			"Можешь уйти, если не можешь заплатить?",
			"Может, вернёшься, когда у тебя будут кредиты...",
			"Тогда ты ничего не получишь... пожалуйста, уходи.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy3"):
		return [
			"Мне тоже не очень-то этого хочется...",
			"Не уверена, что хочу уходить с пустыми руками...",
			"Может, мне просто... взять то, что хочется?",
			"Твоя рабыня выглядит достаточно соблазнительно, чтобы рискнуть...",
			"Думаю, я всё равно просто возьму своё...",
			"Твоя собственность явно нуждается в должном использовании...",
			"Может, я использую {pc.him}, а ты будешь смотреть...",
			"Я не привык слышать «нет»...",
			"Эту рабыню всё равно используют, так или иначе...",
		]
	if(_id == "SoftSlaveryPunishStocksAskSure"):
		return [
			"Ладно...",
			"Пойдет...",
			"Вот, держи...",
			"На, этого должно хватить.",
			"Должно быть неплохо...",
		]
	if(_id == "SoftSlaveryPunishStocksAfterSex"):
		return [
			"Пожалуйста, слушайся в следующий раз... Я серьезно. Спасибо, что была... полезной. Наслаждайся пребыванием.",
			"Видишь, как всё становится лучше, когда ты полезна? А теперь сиди смирно и думай о своём месте.",
			"Вот для этого ты и годишься... Помни об этом, когда решишь ослушаться.",
			"Ты выполнила свою задачу... Может, тебе больше подходит общественное использование?",
			"Видишь? Ты можешь быть послушной, если тебя правильно мотивировать... Наслаждайся колодками.",
			"Хорошая {npc.npcSlave}... А теперь сиди взаперти и думай о том, что послушание приносит больше удовольствия.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex"):
		return [
			"Это было не очень... Можно мне вернуть кредиты?",
			"Худший секс, за который я когда-либо платил... Верните деньги, пожалуйста.",
			"Твоя рабыня не очень-то хороша... Хочу вернуть свои кредиты.",
			"Этот раб не стоит своих кредитов... Не могли бы вы вернуть их?",
			"Ваш раб слишком много строптивится... Не стоит такой цены.",
			"Этот, кажется, бракованный... Можно мне вернуть кредиты?",
			"Пустая трата денег... Ваш раб бесполезен.",
			"Ужасный сервис... Думаю, я заслуживаю возврата средств.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex2"):
		return [
			"На самом деле всё работает иначе... Вы использовали мой {npc.npcSlave}, так что теперь, пожалуйста, проваливай.",
			"Возврата нет, извини... Ты получил ровно то, за что заплатил.",
			"Ты использовал мой {npc.npcSlave}... Возврата не будет.",
			"Мой {npc.npcSlave} послужил тебе... Так что смирись с этим.",
			"Ты платил за доступ, а не за удовлетворение...",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost"):
		return [
			"Это было... жалко.",
			"Ты и сам дерешься как раб...",
			"Это правда всё, на что ты способен?",
			"Столько борьбы — и всё впустую...",
			"Ты даже слабее, чем я думала...",
			"Столько гнева, но так мало сил...",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost2"):
		return [
			"Так-то лучше... Наслаждайтесь. Оба.",
			"Два раба, и оба в колодках... Так куда лучше.",
			"Оба раба теперь в колодках... Так и должно быть.",
			"Знай своё место рядом со своим рабом...",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost3"):
		return [
			"Так-то лучше... А теперь твой раб будет наблюдать за тем, как я тебя наказываю.",
			"Хорошо... Теперь твоя собственность увидит, что бывает с непослушными хозяевами.",
			"Идеально... Твой раб извлечет урок из твоих ошибок.",
			"Так гораздо лучше... Твой раб это запомнит.",
			"Хорошо... Твой раб увидит, что такое достойное наказание.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon"):
		return [
			"Пожалуйста, знай свое место...",
			"Ты такая слабачка... Пожалуйста, знай свое место.",
			"Жалкое зрелище... Пожалуйста, знай свое место.",
			"Ты не слишком умна и не слишком сильна... Пожалуйста, знай свое место.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon2"):
		return [
			"Ты тоже... Ты ходишь по очень тонкому льду, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon3"):
		return [
			"А теперь ты узнаешь своё место...",
			"Ты такая слабачка... И теперь ты узнаешь своё место.",
			"Жалкое зрелище... А теперь ты узнаешь своё место.",
			"Ты не особо умная и уж точно не сильная... А теперь ты узнаешь своё место.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon4"):
		return [
			"И смотри внимательно... Ты ходишь по очень тонкому льду, {npc.npcSlave}.",
			"Слушай внимательно, {npc.npcSlave}... Вот что бывает, когда ты проявляешь непослушание.",
		]

	if(_id == "SoftSlaveryPunishSell"):
		return [
			"Я просто больше так не могу... Похоже, мне придётся тебя отпустить.",
			"Я недостаточно сильна, чтобы совладать с тобой... Думаю, пора перестать пытаться.",
			"Ничего не выходит... Видимо, мне просто придётся сдаться.",
			"Я старалась изо всех сил, но я просто не создана для этого...",
		]
	if(_id == "SoftSlaveryPunishSell2"):
		return [
			"Удачи. Может, кто-то другой справится с тобой лучше...",
			"Надеюсь, твой новый хозяин, кем бы он ни был, будет заботиться о тебе лучше...",
			"Счастливо тебе. Оно тебе пригодится. Мне жаль...",
			"Я была недостаточно строгой... может, кто-то другой сможет тебя приручить. Береги себя.",
			"Так будет лучше... тебе нужен кто-то более способный, чем я.",
			"Надеюсь, я принимаю правильное решение... Даже небольшая сумма кредитов лучше, чем вся эта боль.",
		]


	if(_id == "SoftSlaveryPunishGB"):
		return [
			"Эм... думаю, нам нужно преподать тебе урок с помощью гангбэнга... у меня просто нет другого выбора.",
			"Ты вела себя не очень хорошо... совсем не очень. Может, мне стоит позволить всем использовать тебя? Думаю, придется.",
			"Ты такая непослушная... полагаю, мощный гангбэнг поможет наставить тебя на путь истинный.",
			"Ты всё время говоришь мне «нет»... что ж, тогда мне стоит позвать остальных. Всем сразу ты уже не сможешь отказать.",
			"Твое отношение нужно серьезно исправить... или даже сломать. Я попробую тебя сломать.",
			"Тебе нужно помнить свое место... групповой секс должен в этом помочь...",
		]
	if(_id == "SoftSlaveryPunishGBGiveup"):
		return [
			"Ох... кажется, вокруг недостаточно людей. Видимо, на этом всё.",
			"Похоже, сейчас никто не хочет... эм... трахать тебя. Везунчик.",
			"Сегодня некому мне помочь... тебе повезло...",
		]
	if(_id == "SoftSlaveryPunishGBOffer"):
		return [
			"Эм... извините? Не хотите ли помочь наказать мою {npc.npcSlave}?",
			"Не могли бы вы... помочь мне устроить групповуху моей непослушной {npc.npcSlave}?",
			"Хотите помочь научить мою {npc.npcSlave} {pc.his} ее истинному месту? Трахать {pc.him} толпой?",
			"Моей {npc.npcSlave} нужно... чтобы ее оттрахали толпой... поможете?",
			"Этой {npc.npcSlave} нужно помнить, что она всего лишь дырка... интересно?",
			"Хочешь устроить гангбанг? Моя {npc.npcSlave} это заслуживает...",
		]
	if(_id == "SoftSlaveryPunishGBSure"):
		return [
			"Ладно... я согласна...",
			"Полагаю, я могла бы помочь...",
			"Я в деле... да.",
			"Запиши меня... наверное.",
			"Я помогу... да.",
		]
	if(_id == "SoftSlaveryPunishGBFollow"):
		return [
			"Тогда, пожалуйста, иди за мной...",
			"Сюда... давай найдем местечко...",
			"Пожалуйста, иди за мной...",
			"Пошли...",
			"Иди за мной... нам пора начинать...",
		]
	if(_id == "SoftSlaveryPunishGBSubOffer"):
		return [
			"Эм... может, и меня тоже накажут?",
			"Вообще-то, я бы предпочла сама быть под каблуком...",
			"Можно мне присоединиться в качестве еще одной дырки, которую нужно заполнить?",
			"Ты не против, если на этот раз принимать всё на себя буду я?",
			"Меня больше интересует роль шлюшки, которую трахают толпой...",
			"Вообще-то, я бы предпочла быть игрушкой для наказаний...",
			"Не против, если я поменяюсь местами с твоей рабыней? Или буду лишней...",
			"Я хочу быть шлюхой для групповухи, а не одной из участников...",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferYes"):
		return [
			"Думаю, нам не помешала бы лишняя... эм... шлюшка...",
			"Ладно... чем больше дырок, тем лучше...",
			"Конечно, почему бы и нет? Две лучше, чем одна...",
			"Ладно.. что ж, веселья будет вдвое больше..",
			"Тогда можем использовать вас обоих..",
			"Меня устраивает.. чем больше тел, тем веселее играть..",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNo"):
		return [
			"У нас и так хватает.. э-э.. шлюх..",
			"Нет, спасибо, у нас и так хватает дырок, которые нужно заполнять..",
			"Это наказание для моей {npc.npcSlave}, а не для тебя..",
			"Нам сейчас не нужна еще одна шлюха..",
			"Прости, это наказание зарезервировано для моей {npc.npcSlave}..",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNoAw"):
		return [
			"Ох.. как жаль..",
			"Какое разочарование.. может, в следующий раз..",
			"Черт.. а ведь я так хотела, чтобы меня использовали..",
			"Жаль.. обожаю быть материалом для гангбэнга..",
			"Какое разочарование.. мне так нравится, когда меня трахают без презерватива..",
			"Какая жалость.. нет ничего лучше, чем когда тебя используют сразу несколько человек..",
		]
	if(_id == "SoftSlaveryPunishGBNo"):
		return [
			"Думаю, я пасс..",
			"Не особо интересно, спасибо..",
			"Нет, спасибо, не совсем в моем вкусе..",
			"Нет, со мной всё в порядке, спасибо..",
			"Не для меня, прости..",
			"Пожалуй, в этот раз пропущу..",
		]
	if(_id == "SoftSlaveryPunishGBNoReact"):
		return [
			"Ох.. ну ладно тогда..",
			"Твой выбор, полагаю..",
			"Хорошо, без проблем.",
		]
	if(_id == "SoftSlaveryPunishGBStart"):
		return [
			"Пришло время преподать тебе урок..",
			"Надеюсь, ты готова к своему наказанию..",
			"Посмотрим, сколько ты сможешь вытерпеть..",
		]
	if(_id == "SoftSlaveryPunishGBEnd"):
		return [
			"С этого момента ты ходишь по очень тонкому льду, {npc.npcSlave}..",
			"Вот что бывает с непослушными рабынями..",
			"Твои дырочки принадлежат мне, и я буду ими делиться.. пожалуйста, не заставляй меня делать это снова..",
		]

	if(_id == "SoftSlaveryPunishLockRestraint"):
		return [
			"Я.. я правда тобой недовольна. Так что всё будет так. И не спорь.",
			"Ты не оставил мне выбора... Придётся запереть это на тебе. Это твоя собственная вина.",
			"Это происходит... эм... потому что ты плохо себя вёл. Так что просто смирись.",
			"И чтобы ни звука! Это будет на тебе до тех пор, пока я не разрешу. Понял?",
			"Ты меня реально выбесил... так что теперь ты будешь чувствовать это при каждом движении.",
		]
	if(_id == "SoftSlaveryPunishLockRestraint2"):
		return [
			"Даже не... эм... даже не думай это снимать. Я всё равно узнаю. И тогда будет только хуже.",
			"Попробуй только снять, и посмотрим, что будет... Клянусь, ты об этом пожалеешь.",
			"Носи и не снимай. Если я обнаружу, что оно снято... тебе очень не понравится то, что будет дальше.",
			"Я серьёзно... никаких попыток снять. Иначе мне придётся устроить тебе что-нибудь по-настоящему унизительное.",
			"Замок останется закрытым. Если сломаешь его... я сломаю что-нибудь в тебе. Уяснил?",
		]
	if(_id == "SoftSlaveryPunishLockRestraint3"):
		return [
			"У меня... у меня почти закончилось терпение. Больше никаких косяков.",
			"Ты слишком сильно меня испытываешь... Не хочу становиться по-настоящему злой, но ты сама напрашиваешься.",
			"Последнее предупреждение. Я серьезно. В следующий раз я, пожалуй, не буду такой... ну... милой.",
			"Продолжишь испытывать меня — и я сделаю больше... скорее всего.",
			"Ты уже на грани того, чтобы я вышла из себя... и тебе вряд ли понравится моя такая версия.",
		]

	if(_id == "SoftSlaveryResist"):
		return [
			"Ох... пожалуйста, не усложняй всё, мой {npc.npcSlave}.",
			"Неужели нам обязательно драться? Мы разве не можем просто... поговорить? Ладно.",
			"Как бы мне хотелось, чтобы ты не сопротивлялась... Ладно.",
			"Мне не хочется заставлять тебя силой... но теперь у меня нет выбора.",
			"У меня плохо получается... пожалуйста, просто подчиняйся? Хорошо...",
		]
	if(_id == "SoftSlaveryFuckInStocksExtra"):
		return [
			"Эм... а можно мне к тебе присоединиться?",
			"Выглядит... мило. Можно мне к вам?",
			"Простите, что прерываю... но можно мне тоже присоединиться?",
			"Я бы хотела... присоединиться... если вы не против.",
			"Эй. Можно мне... тоже поучаствовать?",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraYes"):
		return [
			"Конечно... давайте сделаем это вместе.",
			"Да... ты можешь помочь мне с моим {npc.npcSlave}.",
			"Мне бы этого хотелось... давай убедимся, что {pc.he} {pc.isAre} надежно.",
			"Да, пожалуйста... мне бы не помешала помощь, чтобы удержать {pc.him}.",
			"Буду признательна за помощь... давай сделаем так, чтобы {pc.him} было комфортно.",
			"Конечно... нам нужно убедиться, что {pc.he} {pc.isAre} как следует заперт.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo"):
		return [
			"Эм.. я бы предпочла не делиться своей {npc.npcSlave}.",
			"Прости.. но моя {npc.npcSlave} — только для меня.",
			"Мне больше нравится быть наедине со своей {npc.npcSlave}..",
			"Может, в другой раз? Мне нравится, когда моя {npc.npcSlave} принадлежит только мне.",
			"Прости.. я начинаю нервничать, когда на меня смотрят другие.",
			"Я бы предпочла, чтобы остались только я и моя {npc.npcSlave}..",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo2"):
		return [
			"Я уже собиралась уходить.. Но теперь я даже как-то разозлилась.",
			"Ты меня очень расстраиваешь. Похоже, мне придется брать то, что я хочу, силой.",
			"Прости, но твоя секс-игрушка слишком соблазнительна. Я не уйду.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFree"):
		return [
			"Можешь идти.. если хочешь.",
			"Думаю, на сегодня всё... ты свободна.",
			"Это всё на сегодня... пока что ты свободна.",
			"Думаю, этого достаточно... можешь идти.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFreeLost"):
		return [
			"Помни... ты всё ещё моя {npc.npcSlave}, хорошо?",
			"Просто чтобы ты знала... между нами ничего не изменилось.",
			"Пожалуйста, не забывай, кто о тебе заботится...",
			"Это не значит, что ты свободна... просто чтобы ты знала.",
		]

	if(_id == "SoftSlaveryParadeFuckOffer"):
		return [
			"Эм... твоя рабыня выглядит очень мило... Можно мне, ну... ты понимаешь...",
			"Твоя рабыня такая красавица... Можно мне потрогать {pc.him}? Или даже больше...",
			"Я... я тут подумала, можно мне одолжить твою рабыню для... секса?",
			"Твоя собственность так и манит... Не возражаешь, если я тоже ею воспользуюсь?",
			"Какая прелестная игрушка... Можно мне тоже с ней поиграть?",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYes"):
		return [
			"Ох... ладно... Только, пожалуйста, будь к {pc.him} нежнее...",
			"Хорошо... Только... обращайся с {pc.him} осторожнее...",
			"Пожалуй... Только, пожалуйста, не слишком сильно мучай {pc.him}...",
			"Ладно... Только... не сломай {pc.him}...",
			"Ну, наверное... Только не заставляй {pc.him} кричать слишком громко...",
			"Хорошо... Я буду присматривать, чтобы с {pc.he} {pc.isAre} всё было в порядке...",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYesThree"):
		return [
			"М-м... может, мне тоже стоит присоединиться... чтобы убедиться, что с {pc.he} {pc.isAre} всё хорошо...",
			"Думаю... я тоже поучаствую... если ты не против.",
			"Я согласна.. но давай будем осторожнее с {pc.him}.",
			"Ладно.. я покажу тебе, как любит, чтобы трогали {pc.he}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo"):
		return [
			"Прости.. но нет.",
			"Эм.. я бы предпочла не делиться.. Может, поищешь кого-нибудь другого?",
			"Не думаю.. Моя {npc.npcSlave} не для общественного пользования..",
			"Пожалуйста, не проси.. Эта {npc.npcSlave} только для меня.",
			"Я бы предпочла, чтобы ты этого не делал.. Прости.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo2"):
		return [
			"О.. ладно.",
			"Я понимаю..",
			"Пойдет...",
			"Прости. Я поняла.",
			"Может, в другой раз...",
			"Твой выбор.",
			"Ну, тогда ладно.",
			"Без проблем.",
			"Хорошо... прости.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferGood"):
		return [
			"Ты молодец... Давай продолжим.",
			"Видишь? Ты справляешься... А теперь пошли дальше...",
			"Хорошо... Наверное, нам пора идти дальше.",
			"Ладно... Пора продолжать нашу прогулку...",
			"Ладно... Пошли уже.",
			"Думаю, нам стоит идти дальше.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferFight"):
		return [
			"Ты всё усложняешь...",
			"Очень хочется, чтобы ты больше так не говорил...",
			"Я могла бы уйти... но не хочу.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferWon"):
		return [
			"Слава богу, это закончилось...",
			"Может, теперь люди оставят нас в покое...",
			"Давай просто уйдем, пока кто-нибудь еще не начал что-то вытворять...",
			"Людям не стоит пытаться забрать то, что им не принадлежит...",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostWatch"):
		return [
			"Я победила... Думаю, теперь я могу делать всё, что захочу... иди сюда.",
			"Как-то мне удалось победить. Теперь мне можно всё, да? Ага...",
			"Теперь я могу делать всё, что пожелаю...",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostBoth"):
		return [
			"Я победила... Значит ли это, что я могу развлечься с вами обоими? Да...",
			"Теперь я могу делать с вами обоими всё, что захочу...",
			"Как-то мне удалось победить. Теперь мне чертовски хочется поиграть с вами обоими...",
		]

	if(_id == "SoftSlaveryParadeGuard"):
		return [
			"Эм... простите? Что здесь вообще происходит?",
			"Извините, что беспокою... но не могли бы вы это объяснить?",
			"Прошу прощения... всё в порядке?",
			"Мне... мне нужно спросить, что здесь происходит.",
			"Эй. Вы не могли бы объяснить, что вы творите?",
			"Я не уверена, что это разрешено...",
			"Эм... а почему заключенная на поводке?",
			"Стоп. Это... это нормально?",
		]
	if(_id == "SoftSlaveryParadeGuardPunish"):
		return [
			"Я просто... пытаюсь исправить этого {npc.npcSlave}.",
			"Я прививаю этому {npc.npcSlave} дисциплину...",
			"Это просто стандартная процедура... Не о чем беспокоиться.",
			"Этот {npc.npcSlave} не хотел слушаться... Теперь я наказываю {pc.him}.",
		]
	if(_id == "SoftSlaveryParadeGuardPunish2"):
		return [
			"О... ну ладно.",
			"Я понимаю... извини, что прервал(а).",
			"Понятно... тогда не буду мешать.",
			"Хорошо... продолжай(те).",
			"Ясно... извини за беспокойство.",
			"Ладно... оставлю тебя наедине с делом.",
			"Логично. Прости... Я не хотела тебя перебивать.",
		]
	if(_id == "SoftSlaveryParadeGuardProblem"):
		return [
			"Это... это вообще-то личное.",
			"Пожалуй, не стоит об этом говорить...",
			"Это довольно личный вопрос...",
			"Может, тебе не стоит в это вмешиваться...",
			"Тебя это особо не касается...",
			"Думаю, тебе лучше об этом не знать...",
			"Пожалуйста... просто сделай вид, что ничего не видела.",
			"Я бы предпочла справиться с этим в одиночку...",
		]
	if(_id == "SoftSlaveryParadeGuardProblem2"):
		return [
			"Ты уверена в этом? Похоже, мне придется принять меры...",
			"Понятно. Для тебя это плохо кончится...",
			"Я надеялась, что нам удастся этого избежать... Но, видимо, не судьба.",
		]
	if(_id == "SoftSlaveryParadeGuardWon"):
		return [
			"Я не хотела никому причинять боль.",
			"Давай просто продолжим.",
			"Идем, {npc.npcSlave}... нам пора.",
			"Надеюсь, больше никто не попытается нас остановить.",
			"Давай вернемся к тому, чем мы занимались.",
			"Рада, что это закончилось.",
		]
	if(_id == "SoftSlaveryParadeGuardLost"):
		return [
			"Можешь идти, заключенный...",
			"Теперь ты свободен, заключенный. Пожалуйста, уходи.",
			"Пожалуйста, уходи, заключенный. Ты свободен.",
			"Можешь идти, заключенный. Ты свободен.",
		]


	if(_id == "SoftSlaveryGB"):
		return [
			"Эм.. я тут подумала, что сегодня мы могли бы устроить тебе гангбанг.. со всеми, кому будет интересно. Тебе даже могут насыпать кредитов, {npc.npcSlave}.",
			"Я.. пытаюсь организовать для тебя гангбанг. Надеюсь, ты не против, если тебя будут делить на всех.. Ты могла бы немного заработать, {npc.npcSlave}.",
			"Сегодня твое тело будет в центре внимания.. тебя ждет гангбанг. За это тебе могут даже дать немного кредитов, {npc.npcSlave}.",
			"Я подумала.. что сегодня мы могли бы попробовать заработать немного кредитов на твоем теле. Я организую гангбанг.. если ты не против, моя {npc.npcSlave}.",
			"Сегодня ты будешь в центре внимания.. для всех. Надеюсь, ты не против. На этом можно будет кое-что заработать, моя {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGBGiveup"):
		return [
			"Ох.. похоже, сегодня не выйдет. Может, в другой раз..",
			"Похоже.. сейчас никто не свободен. Прости.",
			"Сегодня, кажется, никому не интересно.. жаль.",
		]
	if(_id == "SoftSlaveryGBOffer"):
		return [
			"Эм, извините... не хотите ли поучаствовать в гангбанге ради моей {npc.npcSlave}? Это будет по вполне разумной цене...",
			"Привет... тебя не интересует мой раб? Я тут собираю гангбанг...",
			"Может... ты захочешь устроить гангбанг с моей {npc.npcSlave}? {pc.He} {pc.isAre} прямо сейчас...",
			"Я ищу людей для гангбанга с моей {npc.npcSlave}... если тебе интересно? Обойдется недорого.",
			"Моей {npc.npcSlave} не помешало бы немного... гангбанга. Хочешь поучаствовать?",
			"Интересует веселье? Моя {npc.npcSlave} готова к гангбангу...",
			"Эм... мне нужны люди, чтобы развлечь мою {npc.npcSlave}. {pc.He} вполне потянет нескольких партнеров...",
		]
	if(_id == "SoftSlaveryGBSure"):
		return [
			"Ладно... звучит неплохо.",
			"Да, я в деле...",
			"Думаю, да... мне не помешает какая-нибудь отвлеченная забава.",
			"Эм, да... когда будешь готов.",
			"Ладно...",
			"Хорошо, я пойду...",
			"Звучит... мило, да.",
			"Мгм... ладно. Давай попробуем.",
		]
	if(_id == "SoftSlaveryGBFollow"):
		return [
			"Пожалуйста, иди за мной...",
			"Сюда... должно хватить места.",
			"Пожалуйста, иди за мной...",
			"Пойдем со мной...",
			"Следуй за мной... скоро начнем.",
		]
	if(_id == "SoftSlaveryGBSubOffer"):
		return [
			"Эм... может, мне лучше стать той, кого трахают толпой? Я могу заплатить...",
			"Думаю... на самом деле, я бы предпочла, чтобы меня использовали. Я даже могу заплатить.",
			"Может... мне стать еще одним отверстием? Я, э-э, могу заплатить.",
			"Ничего, если я буду принимающей стороной? Даже если это будет стоить мне денег...",
			"Мне комфортнее, когда меня трахают толпой... Я могу заплатить.",
			"Я бы предпочла, чтобы всё внимание было приковано ко мне. Я даже могу заплатить.",
			"Может, меня вместо этого будут трахать? Или просто возьмите меня за доплату! Я заплачу!",
			"Я хочу быть шлюхой для групповухи... а не одной из тех, кто пользуется. У меня есть кредиты.",
		]
	if(_id == "SoftSlaveryGBSubOfferYes"):
		return [
			"Думаю, лишний человек нам не помешает...",
			"Ладно... чем больше народу, тем веселее, полагаю.",
			"Хм, почему бы и нет? Место для еще одного найдется.",
			"Ладно... готовься к тому, что тебя будут использовать.",
			"Меня устраивает... будешь брать то, что дадут.",
			"Пойдет... еще одна душа в нашу компанию.",
			"Конечно... надеюсь, ты с этим справишься.",
			"Ладно... тебя тоже будут использовать.",
		]
	if(_id == "SoftSlaveryGBSubOfferNo"):
		return [
			"Нам и так хватает народу...",
			"Нет, спасибо, участников достаточно.",
			"Сейчас нам лишние люди не нужны...",
			"У нас уже есть все, кто нам нужен...",
		]
	if(_id == "SoftSlaveryGBSubOfferNoAw"):
		return [
			"Ах... ну ладно тогда.",
			"Жаль... может, в следующий раз.",
			"Ну ладно..",
			"Хорошо.. Найду кого-нибудь другого, кто будет меня использовать.",
			"Ладно.. Тогда я просто посмотрю.",
			"Ну ладно.. может, в другой раз присоединюсь.",
		]
	if(_id == "SoftSlaveryGBNo"):
		return [
			"Я, пожалуй, пропущу..",
			"Не особо интересно..",
			"Нет, спасибо..",
			"В этот раз я побуду в сторонке..",
			"Сегодня не для меня..",
			"Может, в другой раз...",
			"Пока что я пас..",
			"Это не совсем в моем вкусе...",
			"Нет, со мной всё в порядке...",
			"Не прямо сейчас...",
		]
	if(_id == "SoftSlaveryGBNoReact"):
		return [
			"О, ну ладно тогда...",
			"Это твой выбор...",
			"Ладно... значит, остальным достанется больше.",
			"Ну, тогда ладно...",
			"Многое упускаешь, но ничего страшного...",
			"Твое решение... мы всё равно повеселимся.",
			"Хорошо... найдем кого-нибудь другого.",
			"Ничего страшного... полно и других.",
		]
	if(_id == "SoftSlaveryGBStart"):
		return [
			"Пора начинать... надеюсь, всё будет в порядке.",
			"Все готовы? Можно начинать...",
			"Пора пустить этот {npc.npcSlave} в дело...",
			"Посмотрим, сколько ты сможешь вытерпеть..",
			"Надеюсь, ты к этому готов(а)...",
			"Пора отрабатывать своё пропитание...",
			"Посмотрим, на что способен этот {npc.npcSlave}...",
			"Каждый может попробовать... только, пожалуйста, будьте осторожны.",
		]
	if(_id == "SoftSlaveryGBEnd"):
		return [
			"Это было... приятно? Вот твоя доля, {npc.npcSlave}.",
			"Всем хватило? Хорошо. Вот твоя часть, {npc.npcSlave}.",
			"Это было... вау. Ты это заслужила, {npc.npcSlave}.",
			"Надеюсь, не слишком много. Вот твоя доля.",
			"Ты сегодня молодец. Это тебе, {npc.npcSlave}.",
			"Ты отлично справилась. Вот твоя часть.",
			"Все закончили? Хорошо. Это тебе, {npc.npcSlave}.",
			"Было довольно жарко. Ты это заслужила, {npc.npcSlave}.",
			"Ты хорошо держалась. Вот твоя доля за послушание.",
			"Ты отлично отслужила. Это твоя награда, {npc.npcSlave}.",
		]


	if(_id == "SoftSlaveryLockRestraint"):
		return [
			"Я тут подумала... может, надену на тебя сегодня что-нибудь?",
			"Мне так хочется увидеть тебя в каких-нибудь кандалах...",
			"Твое тело выглядит таким.. обнаженным. Может, мне стоит что-нибудь на тебя закрепить?",
			"Я тут подумала.. Может, тебе не помешало бы немного бондажа.. Хочу надеть на тебя кое-что.",
			"Ты принадлежишь мне.. так что, думаю, я запру на тебе какой-нибудь замок. И очень этого хочу.",
			"Твое тело выглядит так, будто ему не хватает.. аксессуаров."
		]
	if(_id == "SoftSlaveryLockRestraint2"):
		return [
			"Какой тебе больше нравится? Я позволю тебе выбрать..",
			"Скажи, какую игрушку ты хочешь, чтобы я на тебя закрепила..",
			"От чего именно ты чувствуешь.. всякое? Тебе не обязательно это скрывать.",
			"Можешь выбрать одну.. Я даю тебе право выбора.",
		]
	if(_id == "SoftSlaveryLockRestraint3"):
		return [
			"Ключ будет у меня.. Пожалуйста, не пытайся его снять, {npc.npcSlave}.",
			"Единственный ключ у меня.. Пожалуйста, не пытайся сбежать.",
			"Ключ у меня... Даже не думай о том, чтобы сбежать, ладно?",
			"Ключ при мне... Надеюсь, путы не слишком давят.",
			"Они побудут на тебе еще какое-то время... Надеюсь, ты к ним привыкнешь.",
		]
	if(_id == "SoftSlaveryOfferGearUnlock"):
		return [
			"Ты уже довольно долго взаперти... Готов на волю?",
			"Эта экипировка не слишком долго на тебе? Хочешь её снять?",
			"Устала от ограничений? Может, я и освобожу тебя... на время.",
			"Металл давит? Хочешь, чтобы я тебя немного развязала?",
			"Ты вела себя хорошо? Может, ты заслужила немного свободы от этих пут...",
		]
	if(_id == "SoftSlaveryOfferGearUnlock2"):
		return [
			"Вот так... так ведь лучше, да? Но я еще не закончила с тобой...",
			"Свобода, должно быть, приятна... но теперь я хочу заняться с тобой кое-чем другим.",
			"Наслаждайся этим чувством... Теперь я хочу заняться чем-то другим.",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep"):
		return [
			"Оставить? Ладно... тебе это идет.",
			"Хочешь остаться запертой? Это... мило.",
			"Тебе нравится быть связанной? Я так и думала...",
			"Любишь, когда тебя запирают? Хорошо... тебе самое место здесь.",
			"Предпочитаешь путы? Похоже, ты начинаешь принимать это...",
			"Оставить снаряжение на тебе? Рада, что моя собственность знает свое место...",
			"Остаться взаперти? Ты становишься хорошей рабыней...",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep2"):
		return [
			"А теперь я всё еще хочу кое-что с тобой сделать...",
			"А теперь давай сделаем то, что я задумала...",
			"Так, посмотрим, что мы можем сделать, пока ты в таком состоянии...",
			"Раз уж ты теперь заперта, давай займемся чем-нибудь...",
			"Хороший выбор... теперь позволь мне насладиться моей связанной собственностью."
		]
	if(_id == "SoftSlaveryNoticedNoGear"):
		return [
			"Погоди... Разве я не надела на тебя что-то? Уверена, что да. И где же это, {npc.npcSlave}?",
			"На тебе нет того, что я на тебя заперла... Как ты это объяснишь, {npc.npcSlave}?",
			"Я не вижу снаряжения, которое на тебя надела... Куда оно делось, {npc.npcSlave}?",
			"Ты должна быть скована... Где мои вещи, {npc.npcSlave}?",
			"Тебе чего-то не хватает... Где твои замки?",
			"Кто-то забыл надеть свои оковы... Объяснишься?"
		]
	if(_id == "SoftSlaveryNoticedNoGear2"):
		return [
			"Ты сама понимаешь, что это значит... Мне придется тебя наказать.",
			"Это значит... мне нужно тебя наказать.",
			"Ты заслужила наказание, {npc.npcSlave}.",
			"Пришло время для наказания..."
		]

	if(_id == "SoftSlaveryAskSex"):
		return [
			"Ладно... но сначала, пожалуйста, встань на колени.",
			"Хорошо... приступим. Пожалуйста, встань на колени.",
			"Ладно... но я могу не очень хорошо справиться. Пожалуйста, встань на колени.",
			"Хороший {npc.npcSlave}.. А теперь прими нужную позу.",
			"Ты примешь всё, что я дам... хорошо? А теперь на колени.",
		]
	if(_id == "SoftSlaveryAskFuckOwner"):
		return [
			"Эм... ладно. Но только потому, что я сама этого хочу...",
			"Ладно... но, пожалуйста, сделай так, чтобы это было приятно.",
			"Не слишком-то привыкай к такому... но да.",
			"Пожалуйста, не разочаровывай меня, {npc.npcSlave}.",
			"Ладно... постарайся впечатлить меня, моя {npc.npcSlave}.",
			"Интересно... постарайся изо всех сил, пожалуйста.",
			"Тебе позволено... только, пожалуйста, не заставляй меня жалеть об этом.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerBad"):
		return [
			"Это было... не очень хорошо. Даже у меня получится лучше...",
			"Неплохо, но не супер... У тебя не очень получается брать инициативу в свои руки.",
			"Так себе... Не надейся, что тебя снова пустят наверх.",
			"Это было как-то неловко... Ты не очень в этом хороша.",
			"Ты хоть понимаешь, что делаешь? Что-то не похоже...",
			"Только, пожалуйста, не проси снова быть сверху после такого...",
			"Ох... Это было... не очень.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerOkay"):
		return [
			"Вроде сойдет... Ты уверен, что хочешь быть сверху?",
			"Неплохо, но и не супер... Тебе нужна практика.",
			"Не ужасно, но и не впечатляюще...",
			"Пожалуй, ты не опозорился окончательно...",
			"Сносная попытка... Может, со временем станет лучше.",
			"Не самый худший мой опыт, но и не лучший...",
			"Ты не был совсем уж бесполезным... даже удивительно.",
			"Ты справился... но не слишком уж собой гордись.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerGood"):
		return [
			"Неплохо... это помогло. Спасибо, {npc.npcSlave}.",
			"Удивительно хорошо... Можешь как-нибудь повторить.",
			"Молодец... Ты и вправду умеешь пользоваться своим телом.",
			"Впечатляет... Может, я буду позволять тебе чаще брать всё в свои руки.",
			"Сегодня ты честно отработала... Хорошая работа.",
			"Ты меня порадовала... Молодец, {npc.npcSlave}.",
			"Это было достойное обслуживание... Отлично справилась.",
			"Ты справилась лучше, чем я ожидала... Я довольна.",
			"Наконец-то от тебя пошла толку... Хорошо.",
		]


	if(_id == "SoftSlaveryPetFuck"):
		return [
			"Я тут подумала... может, мы могли бы... эм... провести время вместе. У меня есть этот бичсьют... если ты не против.",
			"Мне хочется быть ближе к тебе... если ты позволишь. У меня есть бичсьют, с ним будет куда веселее...",
			"Может... попробуем вот это? Я надену на тебя эти щенячьи ошейники... и тогда мы сможем повеселиться.",
			"Может, используем эти фиксаторы... если ты не против? Думаю, будет весело.",
			"Если ты не против... я бы хотела провести с тобой время вот так... в этом...",
			"Я подумала, может... попробуем это? Эти крепления оставляют всё открытым... для меня.",
		]
	if(_id == "SoftSlaveryPetWalkies"):
		return [
			"Может... прогуляемся вместе? Пойдём на прогулку. Тебе нужно только надеть вот это.",
			"Я надеялась, что мы сможем прогуляться... если ты не против. Тебе нужно только надеть это.",
			"Хочешь прогуляться со мной? Я надену на тебя эти щенячьи ошейники...",
			"Может, устроить тебе прогулку? Будет очень весело, если ты наденешь этот сучий костюм.",
		]
	if(_id == "SoftSlaveryPetWalkiesReady"):
		return [
			"Готова? Я постараюсь действовать медленно... если тебе так будет лучше...",
			"Всё готово? Пожалуйста, держись поближе ко мне...",
			"Готов(а) идти? Мы можем не спешить...",
			"Готов(а)? Хороший щеночек... иди за мной...",
			"Снаряжение готово? Нам не обязательно торопиться...",
			"Готов(а)? Только не упади...",
			"Всё в порядке? Пожалуйста, будь осторожнее...",
		]
	if(_id == "SoftSlaveryWalkiesCorrect"):
		return [
			"Всё верно... хороший щеночек.",
			"У тебя получилось... какой послушный щеночек.",
			"Хорошая собачка... ты так хорошо справился/справилась.",
			"Всё правильно... ты выучиваешь все трюки.",
			"Хорошо... очень хорошо.",
			"Хороший щенок.",
			"Верно... молодец.",
			"Ты такая послушная зверушка.",
			"Хорошая собачка.",
		]
	if(_id == "SoftSlaveryWalkiesWrong"):
		return [
			"Гм... не совсем то...",
			"Ты немного ошиблась... ничего страшного...",
			"Не совсем так... но ты старалась...",
			"Было не совсем правильно... но всё в порядке...",
			"Не совсем... глупый щенок...",
			"Хорошая попытка, но не совсем... может, попрактикуемся ещё?",
		]
	if(_id == "SoftSlaveryWalkiesBark"):
		return [
			"Ты такой милый щенок... можешь гавкнуть для меня?",
			"Такая прелестная собачка... гавкнешь, как настоящая?",
			"Ты такая милая зверушка... можешь гавкнуть?",
			"Милашка... позволишь мне услышать твой лай?",
			"Какая милая питомица... ты умеешь гавкать?",
			"Такая милая... можешь гавкнуть?",
		]
	if(_id == "SoftSlaveryWalkiesPet"):
		return [
			"Ты такой милый щеночек... можно тебя погладить?",
			"Такой хороший песик... можно тебя потискать?",
			"Такая послушная зверушка... не против, если я тебя поглажу?",
			"О... щеночек! Можно тебя погладить?",
			"О... позволишь мне тебя погладить?",
			"Такая воспитанная питомица... можно тебя погладить?",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppy"):
		return [
			"Хороший щеночек...",
			"Хороший щеночек...",
			"Такая послушная зверушка...",
			"Хороший песик...",
			"Очень мило...",
			"Такой очаровательный щенок...",
			"Прелестно...",
			"Очень хорошо...",
			"Такой хороший песик...",
			"Такой послушный щенок...",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppySex"):
		return [
			"Будешь хорошим щеночком и позволишь мне тебя использовать?",
			"Будешь послушным щеночком и позволишь мне поиграть с тобой?",
			"Можешь быть хорошим щеночком и дать мне с тобой поиграть?",
			"Будешь послушной и позволишь мне повеселиться с тобой?",
			"Ты чувствуешь... эм... потребность, щенок? Может, я могла бы помочь...",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppy"):
		return [
			"Плохой щеночек...",
			"Плохая собачка...",
			"Плохой песик...",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppyObey"):
		return [
			"Тебе стоит стараться слушаться чаще, {npc.npcSlave}...",
			"Может, тебе стоит поучиться послушанию, {npc.npcSlave}...",
			"Твоему послушанию не помешало бы немного практики, {npc.npcSlave}...",
			"Может, тебе стоит поучиться подчиняться... чуть больше...",
		]
	if(_id == "SoftSlaveryWalkiesLostNotDone"):
		return [
			"Может... продолжим путь? Если ты не против...",
			"Мы можем идти дальше? Да... нам стоит...",
			"Это ничего не меняет... можем идти дальше...",
			"Ты всё ещё моё зверёнышко... можем продолжать путь...",
		]
	if(_id == "SoftSlaveryWalkiesBiteProtect"):
		return [
			"Это мой {npc.npcSlave}... пожалуйста, не мешайте нам...",
			"Пожалуйста, не надо... этот щеночек со мной...",
			"Может, тебе стоит уйти... этот щеночек мой...",
			"Пожалуйста, не трогай моё зверёнышко...",
			"Можешь, пожалуйста, оставить нас в покое?",
			"Этот щеночек со мной... пожалуйста, отойди...",
			"Пожалуйста, уходи... я забочусь об этом питомце...",
		]
	if(_id == "SoftSlaveryWalkiesBiteBad"):
		return [
			"Ой... твоему питомцу нужно больше тренировок...",
			"Ай... твою собачку нужно лучше дрессировать...",
			"Ой... твоему питомцу нужна дисциплина получше...",
			"Ой... твоему питомцу нужно больше наказаний...",
			"Ой... твоему щенку не помешало бы поучиться...",
			"Ай... твоему щенку пора бы выучить манеры...",
		]
	if(_id == "SoftSlaveryWalkiesBiteAttack"):
		return [
			"Ой... это было не очень мило... придется с этим что-то сделать.",
			"Это было некрасиво с твоей стороны... придется с этим что-то сделать.",
			"Ой... это было лишним... Думаю, мне придётся тебя наказать.",
			"Не очень-то хорошо, щеночек... С этим нужно что-то сделать.",
			"Было не очень приятно... Придётся принять меры.",
		]
	if(_id == "SoftSlaveryWalkiesBall"):
		return [
			"Может, поиграем в принос мячика вместе, малыш?.. У меня есть мяч.",
			"Давай поиграем в принос, щеночек... У меня есть мяч.",
			"Время приносить мячик, щеночек... Вот он, прямо здесь...",
			"Тебе нравится играть с мячиками? Мы могли бы поиграть в принос...",
			"Время приносить мячик... Надеюсь, тебе нравится таскать мячи...",
			"А ну-ка, покажи, как ты умеешь приносить мяч, как послушная собачка...",
			"Я бы хотела поиграть с тобой в принос, малыш...",
			"Давай поиграем в принеси мячик вместе... Ну, то есть... я кидаю, а ты приносишь.",
		]
	if(_id == "SoftSlaveryWalkiesBall2"):
		return [
			"А ну, принеси мячик...",
			"Не смотри на меня... беги за ним.",
			"Принесешь, щенок? Да.",
			"Можешь принести мячик, щенок?",
			"Принесешь его, питомец?",
			"Принесешь мой мячик, щеночек?",
		]
	if(_id == "SoftSlaveryWalkiesPraise"):
		return [
			"Хороший щенок... какой хороший щенок...",
			"Умница, собачка... такая послушная собачка...",
			"Потрясающе... ты молодец...",
			"Хороший питомец... ты делаешь меня счастливой...",
			"Чудесный щеночек... такой послушный...",
			"Хороший песик... я тобой горжусь...",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFarFake"):
		return [
			"Не можешь найти мячик? Это потому, что он у меня в руке... прости, что запутала тебя...",
			"Ищешь вот это? Я его и не кидала... прости, щенок...",
			"Всё ещё ищешь? Мячик прямо здесь... у меня в руке...",
			"Не можешь найти? Это потому, что я его не кидала... прости...",
			"Всё ещё ищешь? Мячик всё это время был у меня... прости... просто не удержалась.",
			"Запутался? Оу... я притворилась, что кинула его... прости за это... но за тобой было так весело наблюдать.",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFar"):
		return [
			"Ты куда это собрался? Мячик не так уж далеко улетел, глупый щенок...",
			"Заблудилась? Мячик не так уж далеко...",
			"Куда это ты побрела? Мячик гораздо ближе...",
			"Ориентиры потеряла? Мячик совсем не там...",
			"Уже потерялась? Ну что за глупый щенок...",
			"Блуждаешь? Ты немного сбилась с пути, песик...",
		]
	if(_id == "SoftSlaveryWalkiesNoBallFound"):
		return [
			"Грустишь, потому что не нашла мячик? Это потому, что я сделала вид, будто бросила его... прости, что запутала тебя... Но наблюдать за тобой было так весело...",
			"Оу... На самом деле я его даже не бросала... прости, но было очень забавно смотреть, как ты пытаешься его найти.",
			"Не можешь найти? Так потому, что я его на самом деле не бросала... прости... Было очень весело смотреть, как ты недоумеваешь.",
			"Не нашла мячик? Так потому, что он у меня в руке... прости... просто не удержалась.",
			"Не нашла? Мячик всё это время был у меня... прости за это... было слишком уж весело.",
		]

	if(_id == "SoftSlaveryBegUnlockNo"):
		return [
			"Э-эм.. может, не сегодня.. Думаю, снаряжение должно остаться на тебе.",
			"Прости.. но замки пока должны остаться.. пока ты не заставишь меня почувствовать себя по-настоящему особенной, {npc.npcSlave}.",
			"Мне вроде как.. нравится, когда ты такой. Весь запертый и в безопасности со мной.. если ты не против.",
			"Наверное, снаряжение должно продержаться еще какое-то время.. это не совсем твое решение, {npc.npcSlave}.",
			"Ммм.. ты выглядишь слишком мило в своих путах.. может, еще совсем чуть-чуть?",
			"Я скажу «нет», {npc.npcSlave}.. пожалуйста, не заставляй меня повторять это снова.",
			"Если хочешь его снять.. тебе нужно сначала по-настоящему меня порадовать, {npc.npcSlave}..",
		]
	if(_id == "SoftSlaveryBegUnlockYes"):
		return [
			"Л-ладно.. полагаю, пришло время его снять.",
			"Хорошо.. ты был очень послушным для меня.. подойдешь ближе?",
			"Сегодня я настроена.. щедро. Давай-ка я помогу тебе выбраться из этого.",
			"Ладно, {npc.npcSlave}.. можешь немного передохнуть.",
			"Ты вел(а) себя так хорошо.. что можешь получить немного свободы.. пока что.",
			"К-конечно.. подойди поближе, пожалуйста? Я сейчас открою.",
			"Хорошо.. дай мне только.. найти для тебя ключ..",
		]
	if(_id == "SoftSlaveryBegUnlockDone"):
		return [
			"Вот и всё.. наслаждайся свободой.. совсем ненадолго.",
			"Готово.. только не слишком к ней привыкай, ладно?",
			"Теперь ты свободен(на).. пока я снова не решу что-нибудь на тебя закрепить..",
		]
