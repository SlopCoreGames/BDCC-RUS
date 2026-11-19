extends DialogueFiller

func _init():
	priority = 14

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var guard = getChar(_args, _form.mainRole)
	var personality:Personality = guard.getPersonality()
	var subby = personality.getStat(PersonalityStat.Subby)
	#var subby = personality.getStat(PersonalityStat.Subby)
	
	if(subby > -0.4):
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
			"Я решила, что ты будешь моим рабом. Тебе стоит этим гордиться. Тебе нужно просто сказать «да».",
			"У тебя вид человека, которому самое место на коленях. Хочешь стать моим рабом?",
			"Мне захотелось завести нового питомца. Ты отлично подойдешь. Что скажешь?",
			"Как насчет такой привилегии — стать моим личным рабом? Обещаю, скучать тебе не придется.",
			"Ты кажешься потерянным без хозяина. Я сегодня добрая и готова тебя прибрать к рукам. Что скажешь, прелесть?",
			"Я объявляю тебя своей собственностью. Есть возражения?",
			"Ты выглядишь так, будто рожден служить мне. Готов принять свое место?",
			"Мне нужна новая игрушка. Ты привлекла мое внимание. Хочешь сама вызваться ко мне?",
		]
	if(_id == "SoftSlaveryOfferYes"):
		return [
			"Отлично. Следуй за мной.",
			"Мудрый выбор. Иди за мной.",
			"Хороший питомец. Ты не пожалеешь об этом... сильно. А теперь иди сюда.",
			"Надеюсь, ты это скажешь. Давай не будем терять времени.",
			"Великолепно. Это будет одно удовольствие. Следуй за мной.",
			"Идеально. Я как раз жаждала кого-нибудь, кого можно использовать. Не отставай.",
			"Я буду о тебе очень хорошо заботиться... А теперь шевелись.",
		]
	if(_id == "SoftSlaveryPCOffer"):
		return [
			"Найдется ли место для рабыни? Я жажду служить.",
			"Я ищу достойного хозяина. Окажете ли вы мне честь?",
			"Не нужна ли вам преданная рабыня? Я вся ваша.",
			"Я хочу служить у ваших ног. Сделаете ли вы меня своей?",
			"Нужен кто-то, кто будет боготворить каждую вашу команду? Я смиренно вызываюсь добровольцем.",
			"Из меня вышла бы идеальная рабыня для тебя. Позволишь ли ты мне такую привилегию?",
			"Не хочешь ли сделать меня своей собственностью? Я жажду стать твоей тюремной сучкой...",
			"Я предлагаю себя в рабство. Примешь ли ты меня?",
			"Мне нужен сильный хозяин. Возьмешь меня себе в рабы?",
		]
	if(_id == "SoftSlaveryPCOfferYes"):
		return [
			"Что ж, полагаю, я мог бы взять тебя под свое крыло. Иди за мной.",
			"Ты как раз вовремя. Я как раз думал, что мне не помешало бы новое имущество.",
			"Приятно видеть, что ты знаешь свое место. Я согласен. Иди сюда.",
			"Отлично. Я как раз искал новую игрушку, чтобы развлечься.",
			"Да. Думаю, нам будет очень весело вместе... только не отставай.",
			"Я принимаю твое предложение. Давай познакомимся поближе.",
			"Хорошо. Мне как раз не помешал бы кто-то, кто будет исполнять каждое моё желание.",
			"Да. Мне доставит удовольствие превратить тебя в моё идеальное домашнее животное. А теперь иди сюда.",
		]
	if(_id == "SoftSlaveryPCOfferNo"):
		return [
			"Нет, мне не нужна такая рабыня, как ты.",
			"Сейчас я не собираю питомцев. Попробуй найти кого-нибудь другого.",
			"Меня не интересует владение тобой.",
			"Я, пожалуй, воздержусь.",
			"Нет, спасибо. Я предпочитаю одиночество.",
		]
	if(_id == "SoftSlaveryIntro1Willing"):
		return [
			"Добро пожаловать в твою новую жизнь. Постарайся меня не разочаровать.",
			"Итак...",
			"Хорошо. Очень хорошо.",
			"Идеально. Пора начинать.",
			"Давай обсудим, как именно ты будешь меня ублажать.",
			"Пора приступить к твоему первому уроку преданности.",
			"Теперь поговорим о твоем новом предназначении.",
			"Позволь мне в точности объяснить, чего я от тебя жду.",
		]
	
	if(_id == "SoftSlaveryIntro1"):
		return [
			"Наконец-то проснулась? Хорошо.",
			"А теперь открой глазки. Не заставляй меня ждать.",
			"Посмотри на меня, милашка. Я знаю, что ты не спишь.",
			"Привет, соня. Пора просыпаться.",
			"Глаза открыты. Хочу видеть, как ты меня узнаёшь.",
			"Просыпайся, неженка. Теперь это твоя реальность.",
			"Наконец-то в сознании. Слушай внимательно.",
			"А вот и ты. Я уже начала терять терпение.",
			"Уже смотришь на меня? Идеально. Слушай внимательно.",
			"Хорошо, ты очнулась. Твое молчание уже начинало меня утомлять.",
			"Спящая красавица наконец-то удостоила меня своим {pc.his} присутствием.",
			"Вот и моя милашка. Интересно, как долго ты заставишь меня ждать.",
		]
	if(_id == "SoftSlaveryIntro2"):
		return [
			"С этого момента ты — моя {npc.npcSlave}. Это понятно?",
			"Слушай внимательно, моя сладкая {npc.npcSlave}. Теперь ты принадлежишь мне. Слышишь?",
			"Теперь ты моя {npc.npcSlave}. Выучи свое место подо мной и никогда об этом не забывай. Ясно?",
			"Твоя свобода отныне — лишь угасающее воспоминание. Ты моя, {npc.npcSlave}. Понимаешь свое новое предназначение?",
			"Давай проясним раз и навсегда. Ты — моя {npc.npcSlave}. Твоя жизнь принадлежит мне. Слышишь меня?",
			"Вдумайся в это хорошенько. Ты — моя {npc.npcSlave}. Ты принадлежишь мне. Неужели это слишком сложно понять?",
		]
	if(_id == "SoftSlaveryIntro3"):
		return [
			"Ты будешь беспрекословно исполнять каждую мою команду. Разочаруешь меня — и у нас возникнут проблемы.",
			"Делай в точности то, что я прикажу, и к тебе будут относиться хорошо. Пойдешь против меня — и горько об этом пожалеешь.",
			"Твоя единственная цель — подчиняться мне без лишних вопросов. Только так ты сможешь меня порадовать. Ошибешься — и я тебя «исправлю».",
			"Попробуй только сопротивляться, моя маленькая {npc.npcSlave}, и я с огромным удовольствием сломлю твой дух.",
			"Я не терплю неповиновения от своей {npc.npcSlave}. Я буду наказывать тебя до тех пор, пока ты не усвоишь урок.",
			"Это значит, что ты будешь делать именно то, что я скажу. Иначе мне придется проявить дисциплину к моей новой {npc.npcSlave}.",
			"Каждое слово, слетающее с моих губ — это приказ. Если только ты не жаждешь моих наказаний.",
			"Твоя единственная функция — подчиняться мне. Не справишься — и тебя быстро поставят на место.",
			"Скажи мне «нет», и я буду ломать тебя до тех пор, пока «да» не станет единственным словом, которое ты помнишь.",
		]
	if(_id == "SoftSlaveryIntroEND"):
		return [
			"Я буду часто заходить к тебе. Не забывай, кому ты принадлежишь.",
			"Я буду часто заходить к тебе. Не забывай, что твое место — у моих ног.",
			"Буду заглядывать к тебе почаще. Ты моя, никогда об этом не забывай.",
			"Мы будем видеться регулярно. Помни о своей роли моей {npc.npcSlave}.",
			"Я буду часто тебя проверять. Держи это в уме и будь наготове.",
			"Я буду заходить. Следи за тем, чтобы вести себя прилично перед своим хозяином.",
			"Ты будешь часто меня видеть. И каждый раз готовься служить мне.",
			"Я буду часто проверять свою {npc.npcSlave}. Убедись, что ты всегда готова к использованию.",
		]

	if(_id == "SoftSlaveryChangeName"):
		return [
			"Говори, моя {npc.npcSlave}. Как твой хозяин должен тебя называть?",
			"Скажи, как мне называть мою собственность. Постарайся не разочаровать меня, {npc.npcSlave}.",
			"Даруй мне имя, сладенькая. А я решу, достоин ли он моего {npc.npcSlave}.",
			"Как же мне назвать свою игрушку? Выбирай с умом, {npc.npcSlave}.",
			"Ладно, {npc.npcSlave}. Каким именем ты так жаждешь, чтобы тебя называли?",
			"Ну, давай послушаем. Помни, это привилегия.",
		]
	if(_id == "SoftSlaveryChangeNameEND"):
		return [
			"Хорошо. С этого момента ты — моя {npc.npcSlave}, и ты принадлежишь мне.",
			"Пусть будет так. Теперь ты моя {npc.npcSlave}. И никогда об этом не забывай.",
			"Да будет так. Ты будешь носить это имя, как ошейник, моя {npc.npcSlave}.",
			"Очень хорошо. Ты — моя {npc.npcSlave}, а я твой хозяин. В этом твое предназначение.",
			"Хороший выбор. Теперь, моя {npc.npcSlave}, ты научишься любить это имя.",
		]

	if(_id == "SoftSlaveryAttackReaction"):
		return [
			"Глупая, глупая {npc.npcSlave}. За это тебя ждет дрессировка.",
			"Как ты смеешь поднимать на меня руку?! Ты об этом пожалеешь, {npc.npcSlave}.",
			"Это была очень, очень большая ошибка, дорогая/ой. Готовься к наказанию.",
			"Неповиновение? Как очаровательно. И как мучительно глупо. Ты заслуживаешь каждой капли того, что тебя ждет.",
			"Ты только что подписал(а) приказ о собственном наказании, {npc.npcSlave}. Надеюсь, оно того стоило.",
			"Ах, характер! Обожаю его ломать. Благодаря тебе всё стало куда интереснее, {npc.npcSlave}.",
			"Плохой/ая {npc.npcSlave}! Этот маленький акт бунтарства только что лишил(а) тебя всех привилегий.",
			"О, ты думаешь, что ты сильный/ая? Как мило. Позволь мне показать тебе, что такое настоящая сила.",
			"Ты только что доказал(а), что тебе нужна рука покрепче. Тебе повезло, я с радостью её предоставлю.",
		]
	if(_id == "SoftSlaveryAttackLost"):
		return [
			"Это было всё, на что ты способен/способна, моя/мой {npc.npcSlave}? Ты всё равно принадлежишь мне.",
			"Столько усилий, а ты всё равно там, где и должен/должна быть...",
			"Твоя борьба была забавной, но в конечном счете бесполезной. Ты всё еще моя {npc.npcSlave}.",
			"Тебе стало легче? Ладно. Ты всё равно принадлежишь мне.",
		]
	if(_id == "SoftSlaveryAttackWon"):
		return [
			"А теперь, моя непослушная {npc.npcSlave}, ты узнаешь цену своих поступков.",
			"Победа за мной. А теперь пришло время для твоего перевоспитания, {npc.npcSlave}.",
			"Сейчас ты поймешь, что бывает с непослушными рабынями, которые капризничают.",
			"Ты сама вынудила меня, милашка. Теперь тебе придется столкнуться с последствиями.",
			"Это не гнев, это исправление. И ты, мое питомец, в нем остро нуждаешься.",
			"Ты хотела драки? Драка окончена. Теперь начинается самое веселое для меня.",
		]

	if(_id == "SoftSlaveryAskedFreedom"):
		return [
			"Ты правда думаешь, что готова к этому, {npc.npcSlave}? Моя защита закончится в ту же секунду, как я скажу «да». Ты уверена?",
			"Какая смелая просьба от моей милой маленькой {npc.npcSlave}. Я могла бы исполнить её, но ты ведь знаешь, что принадлежишь мне. Ты действительно этого хочешь?",
			"Я могла бы тебя отпустить. Но галактика — жестокое место для питомца без хозяина. Ты уверена, что хочешь перестать быть моей?",
			"Хм. Какая дерзость. Но ладно. Если ты так жаждешь изгнания, я не стану тебя останавливать. Только помни, кто о тебе заботился, {npc.npcSlave}. Помнишь?",
			"Хочешь уйти от меня? После всего, что я тебе дала? Говори правду, моя неженка. Ты действительно хочешь, чтобы тебя отпустили?",
			"Моя сладкая {npc.npcSlave} заскучала? Позволю тебе задать этот единственный вопрос. Но твой ответ должен быть окончательным.",
			"Хочешь на свободу? Что ж, ты свободна. Но не надейся, что приползешь обратно, когда осознаешь свою ошибку, милашка. Ты уверена?",
		]
	if(_id == "SoftSlaveryAskedFreedomPay"):
		return [
			"У твоей свободы есть цена, {npc.npcSlave}. <CREDITS>. Заплати мне, и цепь будет разорвана.",
			"Думаешь, я отдам свою собственность даром? <CREDITS>. Вот цена твоего освобождения, {npc.npcSlave}.",
			"У всего есть цена, даже у моего милосердия. Твоя свобода обойдется тебе в <CREDITS>, {npc.npcSlave}. У тебя есть эта сумма?",
			"Я щедрая хозяйка, но не глупая. <CREDITS> обеспечат твою свободу. Ни кредитом меньше, моя сладкая {npc.npcSlave}.",
			"Хочешь выбраться? Тогда выкупай себя. <CREDITS>. Считай это последним уроком того, как устроен этот мир, {npc.npcSlave}.",
			"<CREDITS>. Такова цена твоей свободы. Заплати её — и ты больше не моя. Откажись — и останешься моей милой маленькой {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryAskedFreedomEND"):
		return [
			"Что ж, можешь идти. Свободна, {npc.npcSlave}.",
			"Очень хорошо. Теперь ты свободна. Твоё присутствие здесь больше не требуется.",
			"Ну же, ступай. Беги. Твоё время в моей собственности подошло к концу.",
			"Значит, наше дело завершено. Ты свободна.",
			"Решение принято. А теперь уходи, пока я не передумала.",
			"Значит, ты на свободе. Не растрать этот шанс впустую.",
			"Значит, всё кончено. Уходи и не оглядывайся.",
		]

	if(_id == "SoftSlaveryTalkStart"):
		return [
			"Говори, {npc.npcSlave}. Пока что ты завладела моим вниманием.",
			"Можешь обращаться ко мне, {npc.npcSlave}. Что там у тебя такого важного?",
			"Подойди. Излагай свои дела, {npc.npcSlave}.",
			"Я слушаю, {npc.npcSlave}. Надеюсь, это стоит моего времени.",
			"Говори. И постарайся быть краткой.",
			"Твой хозяин занят. Сделай так, чтобы это было интересно, {npc.npcSlave}.",
			"Да, мой/моя {npc.npcSlave}? Хочешь что-то сказать?",
			"Жаждешь моего внимания? Получай. И не вздумай его растратить впустую.",
			"Ну же, {npc.npcSlave}. Говори.",
		]

	if(_id == "SoftSlaveryProtectedByFriendStart"):
		return [
			"Эй, ты что это задумал(а) с моей подружкой?",
			"А ну отошел/отошла от {pc.name}. Тебе не позволено лапать {pc.him}.",
			"Есть причина, по которой твои руки так и тянутся к этой милашке?",
			"Объяснись. Какого черта ты пристаешь к моей подруге?",
			"Отпусти {pc.him}. Моей подруге не нужно твое внимание.",
			"Отойди. Ты донимаешь мою лучшую подругу.",
			"Советую тебе найти себе другое домашнее животное, чтобы донимать.",
			"Еще раз тронешь {pc.name}, и тебе придется иметь дело со мной.",
		]
	if(_id == "SoftSlaveryProtectedByFriendResponse"):
		return [
			"Эта {npc.npcSlave} принадлежит мне. Это ты здесь лишняя.",
			"Я бы с удовольствием научила тебя манерам.",
			"Ты бросаешь мне вызов? Как мило.",
			"Убирайся, пока я не решила оставить тебя себе в качестве питомца.",
			"Смелая позиция для того, кто находится на расстоянии удара.",
			"Думаешь, у тебя есть выбор? Как мило."
		]
	if(_id == "SoftSlaveryProtectedByFriendAllGoodResp"):
		return [
			"Ладно. Конечно. Наслаждайся.",
			"Ладно. Продолжай тогда. Развлекайся.",
			"Как хочешь. Веселись.",
			"Очень хорошо. Продолжай то, чем занималась, выглядело заманчиво.",
			"Меня устраивает. Буду просто наблюдать.",
		]
	if(_id == "SoftSlaveryProtectedByFriendLost"):
		return [
			"А теперь ползи прочь, пока я не передумала тебя отпускать.",
			"Сгинь, мелкая зараза. Ты не стоишь потраченных усилий.",
			"Считай это своим единственным предупреждением. Исчезни.",
			"Иди. И будь благодарна, что я позволяю тебе сохранить остатки достоинства.",
			"Исчезни с глаз моих, пока я не решила сделать рабом и тебя.",
			"Ты и так потратил достаточно моего времени. Сгинь.",
			"Убирайся отсюда. Мне нужно проучить одного {npc.npcSlave}.",
			"Чтобы я больше не видела тебя на моей территории.",
			"Прочь. У меня есть дела поважнее, чем возиться с тобой.",
			"Уходи. И благодари судьбу, что сегодня я в милостивом настроении."
		]
	if(_id == "SoftSlaveryProtectedByFriendWonThank"):
		return [
			"Конечно, милый. Я всегда буду тебя защищать.",
			"Без проблем, симпатяга. Береги себя.",
			"Не за что, дорогуша. В конце концов, мы же друзья.",
		]

	if(_id == "SoftSlaveryChokeOutStart"):
		return [
			"Мое терпение на исходе. Иди сюда, {npc.npcSlave}. Прости, но ты будешь моей разрядкой.",
			"У меня сегодня особенное настроение, и ты станешь моим громоотводом. Даже не вздумай сопротивляться, {npc.npcSlave}.",
			"Этой ярости нужна мишень. Будь послушным {npc.npcSlave} и прими её на себя.",
			"Мне нужна разрядка. И ты её обеспечишь. Замри и прими своё предназначение, {npc.npcSlave}.",
			"Гнев буквально сжигает меня изнутри. Ты будешь тем, кто его потушит, мой {npc.npcSlave}. Прости.",
			"Ты поможешь мне с этим справиться, {npc.npcSlave}. Сотрудничай, и тогда тебе будет легче.",
			"Боюсь, сегодня я настроена особенно злобно. Тебе придётся подчиниться, {npc.npcSlave}, так или иначе.",
		]
	if(_id == "SoftSlaveryChokeOutEndured"):
		return [
			"Хороший {npc.npcSlave}. Ты мне очень помог.",
			"Превосходно. Ты умеешь доставлять мне удовольствие, {npc.npcSlave}.",
			"Это было именно то, что мне нужно. Пока можешь идти.",
			"Благодаря тебе я чувствую, что снова всё контролирую, мой {npc.npcSlave}.",
			"Ты отлично справляешься со своей задачей. Я довольна, {npc.npcSlave}.",
			"Ты приняла это великолепно. А теперь беги, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryChokeOutPCWon"):
		return [
			"Ух.. Впечатляющая схватка, {npc.npcSlave}. Это лишь заставляет меня хотеть сломать тебя еще сильнее.",
			"Ах.. В тебе есть дух. Мне это нравится. Так владеть тобой будет еще приятнее...",
			"Временная победа. Не принимай мое веселье за разрешение, {npc.npcSlave}.",
			"Ты хорошо дерешься, но ты все равно моя. Помни свое место...",
			"Чувствуешь гордость, моя яростная маленькая {npc.npcSlave}? Это ничего не меняет.",
			"Доблестная попытка. Она сделает твое конечное подчинение еще слаще...",
		]
	if(_id == "SoftSlaveryChokeOutPCLost"):
		return [
			"И ты прогнулась. Именно так, как я и знала, моя слабенькая маленькая {npc.npcSlave}.",
			"Жалкое зрелище. Ты не смогла даже оставаться в сознании ради своей хозяйки.",
			"Вся эта борьба... всё прошло. Когда ты молчишь, с тобой куда проще иметь дело, {npc.npcSlave}.",
			"Видишь? Это твоё истинное место. Беспомощная и покорная предо мной.",
			"Какая хрупкая созданияшка. Удивительно, что ты продержалась так долго.",
		]
	if(_id == "SoftSlaveryChokeOutPCLostSex"):
		return [
			"Так, на чем мы остановились? Ах, да. Моя награда.",
			"Посмотрим, для чего еще можно использовать мою бессознательную {npc.npcSlave}.",
			"Идеально. Теперь ты полностью в моей власти.",
			"Пришло время забрать то, что принадлежит мне.",
			"Не волнуйся, {npc.npcSlave}. Я позабочусь о тебе.",
			"В сознании ты или нет, ты выполнишь свое предназначение, {npc.npcSlave}.",
			"Вот для чего ты была создана. Чтобы я тебя использовала.",
		]

	if(_id == "SoftSlaveryFuckStart"):
		return [
			"Иди сюда, {npc.npcSlave}. Твой хозяин сегодня в приподнятом настроении.",
			"Моему телу нужно внимание, {npc.npcSlave}. А ну, живо сюда и принеси себя в пользу.",
			"Иди сюда, мой маленький {npc.npcSlave}. Я возбуждена, и тебе пора отработать свое пропитание.",
			"Твое предназначение — служить мне. А значит, мне нужно обслуживание, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryFuckResultGood"):
		return [
			"Очень хорошо, {npc.npcSlave}. Ты знаешь, как угодить своему хозяину. Я довольна.",
			"Отличная работа, мой сладкий {npc.npcSlave}. Ты заслужил немного похвалы.",
			"Ты быстро учишься, не так ли, {npc.npcSlave}? Это было именно то, что мне нужно.",
			"Похвальное выступление, {npc.npcSlave}. Ты вполне можешь стать моим любимчиком.",
			"Ты хорошо меня ублажаешь, малыш. Обязательно использую тебя снова в ближайшее время.",
			"Видишь? Когда ты слушаешься, все довольны. Ты очень меня порадовал, {npc.npcSlave}.",
			"Блестяще. Ты наконец-то начинаешь понимать своё место, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryFuckResultOkay"):
		return [
			"Приемлемо, {npc.npcSlave}. Но я знаю, что ты можешь лучше. В следующий раз ты постараешься получше.",
			"Это было... адекватно. Только не выгляди такой гордой, ты можешь предложить мне гораздо больше, {npc.npcSlave}.",
			"Ты выполнила свою задачу, но едва ли. В следующий раз жду больше энтузиазма, {npc.npcSlave}.",
			"Не лучший твой результат, {npc.npcSlave}. На этот раз я сделаю вид, что всё в порядке, но жду прогресса.",
			"Ты достигла лишь минимального стандарта. Постарайся впечатлить меня в следующий раз, {npc.npcSlave}.",
			"Сносная попытка. Помни, твоё удовольствие исходит из моего, а я была лишь слегка заинтригована.",
			"Тебе нужно быть внимательнее, если ты действительно хочешь доставить мне удовольствие, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryFuckResultBad"):
		return [
			"Жалко. Это правда всё, на что ты способна, {npc.npcSlave}? Ты разочаровываешь меня.",
			"Ты что, забыла, кому принадлежишь? Это было плохо. Полнейшее разочарование.",
			"Ты довольно паршиво справляешься, {npc.npcSlave}. У меня в собственности вещь, которая не способна выполнить даже самую простейшую функцию.",
			"Ты пытаешься меня спровоцировать? Если это был намеренный провал, {npc.npcSlave}, ты об этом пожалеешь.",
		]

	if(_id == "SoftSlaveryFuckNemesisApproach"):
		return [
			"Ну надо же, надо же... И что же это у нас тут? Это так мило.",
			"Смотрите-ка, кто забрел в поле моего зрения. Мой враг теперь — чья-то личная игрушка. Ха!",
			"Ну надо же. Не думала, что увижу тебя в таком виде. Жаль только, что поводок не у меня.",
			"Какая встреча. Мне чертовски нравится, как ты выглядишь.",
			"О, привет. Никогда бы не подумала, что всё обернется именно так. Это даже забавно, ха!",
		]
	if(_id == "SoftSlaveryFuckNemesisAsk"):
		return [
			"Давай уже, говори, что хочешь. Моя сладкая {npc.npcSlave} ждет моего внимания.",
			"Давай быстрее. Ты прерываешь мое время со своей сладкой {npc.npcSlave}.",
			"Поторапливайся. У меня есть милая {npc.npcSlave}, которую нужно и наказать, и обожать.",
			"У тебя есть пять секунд, прежде чем я вернусь к более важным делам... например, к моей милой маленькой {npc.npcSlave}.",
			"Чего хочешь, только поторапливайся. Моя сладкая {npc.npcSlave} ждет меня.",
			"Говори. Но знай, что ты отнимаешь время, которое я обычно посвящаю своей сладенькой.",
		]
	if(_id == "SoftSlaveryFuckNemesisAnswer"):
		return [
			"Твоя прелестная игрушка перешла мне дорогу. Как насчет того, чтобы нам обоим проучить {pc.him} и научить манерам?",
			"Твоей милой собственности пора усвоить урок. Не хочешь помочь мне продисциплинировать {pc.him}?",
			"Твоя сладкая крошка меня подставила. Не хочешь устроить совместную акцию?",
			"Твоя драгоценная вещица посмела мне перечить. Хочешь помочь мне вернуть {pc.him} на {pc.his} место?",
			"У меня остались незаконченные дела с твоим питомцем. Не позволишь мне поиграть с {pc.him}?",
			"Твой вкусный, мягкотелый питомец совершил огромную ошибку. Как насчет того, чтобы нам обоим наказать {pc.him} за это?",
			"Твоей очаровательной собственности нужно напомнить о {pc.his} месте. Проведем этот урок вместе?",
		]
	if(_id == "SoftSlaveryFuckNemesisYes"):
		return [
			"Идеально. Моему {npc.npcSlave} не помешает лишнее... внимание.",
			"Мм, да. Звучит весело.",
			"Мне нравится ход твоих мыслей. Конечно.",
			"Безусловно. Давай заставим моего {npc.npcSlave} извиваться.",
		]
	if(_id == "SoftSlaveryFuckNemesisNo"):
		return [
			"Категорически нет. Моим {npc.npcSlave} вольна распоряжаться только я — и наказывать, и баловать.",
			"Нет. Эта сладость принадлежит мне, а своими игрушками я не делюсь.",
			"Ни за что. Заботиться о моем {npc.npcSlave} — это исключительно моя привилегия.",
			"Даже не думай об этом. Мой {npc.npcSlave} — это моя забота и моя кара.",
			"Руки прочь. Этот очаровательный {npc.npcSlave} слушается только меня.",
		]

	if(_id == "SoftSlaveryFuckJealousStart"):
		return [
			"Эй! Убери руки от моего {npc1.npcSlave}! Что ты, черт возьми, творишь с {pc.him}?",
			"Простите? Этот {npc1.npcSlave} принадлежит мне. Объяснись.",
			"Что-то не так? Ты трогаешь мою собственность.",
			"Что всё это значит? А ну, живо прочь от моего {npc1.npcSlave}!",
			"А ты смелый. Эта милашка — моя.",
		]
	if(_id == "SoftSlaveryFuckJealousFight"):
		return [
			"А? Отойди. Это мой {npc.npcSlave}, и {pc.he} {pc.isAre} принадлежит только мне.",
			"Что? Этот {npc.npcSlave} слушается только меня. Проваливай.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWon"):
		return [
			"Пусть это будет тебе уроком. Этот {npc.npcSlave} — мой. Понятно?",
			"Видишь? Я же говорила. {pc.He} — это моя послушная {npc.npcSlave} {pc.isAre}. Запомни это.",
			"Ты проиграл. Моя сладкая {npc.npcSlave} остается со мной. А теперь — вон отсюда.",
			"Достаточно ясно? {pc.He} {pc.verb('belong')} мне. Не заставляй меня напоминать об этом снова.",
			"Вот что бывает, когда бросаешь мне вызов. А теперь ползи обратно туда, откуда пришла.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWonFuck"):
		return [
			"Тебе не стоило вмешиваться. Теперь тебе придется усвоить свое место рядом с моей {npc.npcSlave}.",
			"Ты сама напросилась. Теперь вы оба — мои игрушки.",
			"Не то место, не то время. Но сегодня я добрая. Вы оба будете мне служить.",
			"Ты совершила огромную ошибку. Теперь вместо одной у меня две игрушки.",
			"Раз уж вы обе здесь, то могли бы принести пользу. А ну, живо сюда!",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer"):
		return [
			"Погоди! Возможно, мы сможем договориться... мы могли бы разделить эту {npc.npcSlave}.",
			"Постой. Нет нужды так спешить. Мы могли бы вдвоем наслаждаться этой {npc.npcSlave}. Понимаешь, о чем я?",
			"Прежде чем всё зайдет слишком далеко... подумай вот о чем. {npc.npcSlave} может служить двум господам. А?",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer2"):
		return [
			"Эта непослушная {npc.npcSlave} скрывала от нас секреты. Разве {pc.he} не заслуживает за это наказания?",
			"Наша маленькая {npc.npcSlave} забыла упомянуть, что у неё есть другой хозяин. Не думаешь, что {pc.he} {pc.verb('deserve')} стоит проучить?",
			"Моя {npc.npcSlave} никогда не говорила мне о тебе. Давай заставим {pc.him} пожалеть об этом.",
			"Плохо себя вела именно {npc.npcSlave}. Может, сосредоточим наше внимание на {pc.him}?",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree"):
		return [
			"В твоих словах есть смысл.",
			"Возможно, это будет более подходящим наказанием.",
			"Хм. {npc1.npcSlave} действительно нужно преподать урок.",
			"Я вижу преимущество в твоём предложении.",
			"Может, ты и прав(а).",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree2"):
		return [
			"Давай научим нашу {npc1.npcSlave} манерам.",
			"Ладно. Давай вместе продисциплинируем эту маленькую разбойницу.",
			"Согласна. {npc1.npcSlave} должен осознать последствия.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferNope"):
		return [
			"Забавное предложение. Но, пожалуй, я просто возьму вас обоих.",
			"Твой торг жалок. Он лишь заставляет меня хотеть доминировать над вами обоими еще сильнее.",
			"Мольбы тебе не к лицу. Мне доставит удовольствие поставить вас обоих на место.",
			"Интересная идея. Но я её подправлю: вы будете служить мне.",
		]

	if(_id == "SoftSlaverySlutwallStart"):
		return [
			"Ко мне, {npc.npcSlave}. Сегодня твоё место у шлюх-стены. Не заставляй меня повторять.",
			"Шлюх-стена зовет тебя, мой маленький питомец. Не дергайся, пока я надену поводок на моего послушного {npc.npcSlave}.",
			"Иди сюда, {npc.npcSlave}. Сегодня твоя хозяйка использует тебя у шлюх-стены. Будешь брыкаться — пожалеешь.",
			"Сегодня ты будешь моей идеальной маленькой игрушкой у шлюх-стены. Подставь шею, {npc.npcSlave}.",
			"Это красивое тело принадлежит мне, и сегодня я использую его у шлюх-стены. Не шевелись, {npc.npcSlave}.",
			"Будь хорошей {npc.npcSlave} и иди к стене шлюх добровольно. Так будет проще, если будешь слушаться.",
		]
	if(_id == "SoftSlaverySlutwallLocked"):
		return [
			"Теперь ты заперта, мой сладкий питомец. Посмотрим, как хорошо ты сможешь меня ублажать.",
			"Идеально. Моя прелестная {npc.npcSlave} именно там, где ей и место.",
			"Совершенно беспомощная и вся моя. Как же это горячо.",
			"Скованная цепями и такая открытая для меня. Обожаю это.",
		]
	if(_id == "SoftSlaveryStocksStart"):
		return [
			"Сегодня вся тюрьма будет смотреть, как я использую тебя в колодках. Покажи мне свою шею, {npc.npcSlave}.",
			"Колодки уже ждут тебя. Не дергайся, {npc.npcSlave}, и помни свое место.",
			"Иди сюда. Ты отправишься в колодки, и все увидят, какая ты послушная {npc.npcSlave} для меня.",
			"Мне хочется сегодня выставить напоказ и использовать свою собственность. Колодки отлично подойдут. Не шевелись, {npc.npcSlave}.",
			"Будь хорошей {npc.npcSlave} и слушайся, пока я усаживаю тебя в колодки. Не позорь меня своим сопротивлением.",
		]
	if(_id == "SoftSlaveryStocksLocked"):
		return [
			"Даже не думай шевелиться. Теперь ты — моя игрушка.",
			"Запертая, беспомощная и полностью моя. Обожаю это.",
			"Беспомощная и выставленная на всеобщее обозрение. В этом твое предназначение, моя милая {npc.npcSlave}.",
			"Теперь, когда ты надежно закреплена... Давай покажем всем, как ведет себя послушная {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGiveCreditsStart"):
		return [
			"Хозяину нужны <CREDITS>, и ты их обеспечишь. Будь хорошей {npc.npcSlave} и отдавай их. Живо.",
			"Мне срочно нужны <CREDITS>. Не испытывай мое терпение, {npc.npcSlave}. Живо отдавай их.",
			"Ты отдашь мне <CREDITS>$ прямо сейчас, {npc.npcSlave}. И это не просьба.",
			"Мне нужны <CREDITS>. Позаботься о своем владельце, {npc.npcSlave}. Не заставляй меня ждать.",
			"<CREDITS>. Сейчас же, {npc.npcSlave}. Хорошая зверушка знает свои обязанности.",
			"Живо давай мне <CREDITS>. Считай это своей привилегией — служить мне.",
			"Я решила, что ты будешь отдавать мне <CREDITS>. Не смей подвергать сомнению своего владельца.",
			"Будь полезной, моя сладкая {npc.npcSlave}, и переводи <CREDITS> мне прямо сейчас. И никаких споров.",
		]
	if(_id == "SoftSlaveryGiveCreditsTake"):
		return [
			"Хорошая {npc.npcSlave}. Ты знаешь, как меня радовать.",
			"Вот это моя послушная {npc.npcSlave}. Ты знаешь своё место.",
			"Хорошо. Гораздо приятнее, когда ты подчиняешься по собственной воле, {npc.npcSlave}.",
			"М-м. Ты именно для этого и нужна, моя сладкая. Чтобы служить мне.",
			"Ладно. Это куда более полезное применение для них, чем всё то, что ты могла бы на них потратить.",
			"Мне нравится твоя покорность, {npc.npcSlave}. Тебе это идёт.",
			"Мило. Никогда не забывай, кто тебя содержит и кому ты принадлежишь, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGiveCreditsShort"):
		return [
			"Неприемлемо. Ты заслужила наказание, {npc.npcSlave}.",
			"Серьезно, {npc.npcSlave}? Ты намеренно мне перечишь? Готовься к наказанию.",
			"Коротко? Ты смеешь разочаровывать меня? Ты будешь наказана, {npc.npcSlave}.",
			"Жалкое зрелище. Ты ведь просто умоляешь меня проучить тебя, не так ли, {npc.npcSlave}?"
		]

	if(_id == "SoftSlaveryMarkingStart"):
		return [
			"Стой смирно, {npc.npcSlave}. Я хочу оставить на тебе метку.",
			"Не дергайся, {npc.npcSlave}. Сейчас я тебя помечу.",
			"Иди сюда. Будь послушной {npc.npcSlave} и не шуми, пока я оставляю на тебе метки.",
			"Твое тело — мой холст, {npc.npcSlave}. А теперь замри, пока я творю свое искусство.",
			"Такой милой {npc.npcSlave} нужны парочка красивых меток. А теперь. Не. Шевелись.",
			"Обожаю видеть свои метки на тебе. Пора добавить парочку новых, так что не дергайся."
		]
	if(_id == "SoftSlaveryMarkingEnough"):
		return [
			"Идеально. Теперь моя {npc.npcSlave} выглядит как по-настоящему помеченная.",
			"Хорошо. Именно так и должна выглядеть моя собственность.",
			"Прекрасно. С каждым новым следом ты всё больше похожа на мою, {npc.npcSlave}.",
			"На сегодня хватит. Тебе ведь нравится, {npc.npcSlave}?",
			"Отлично. Мой маленький арт-проект завершен. Пока что.",
			"На тебе это смотрится идеально.",
			"Вроде всё. Тебе идет, не находишь?",
		]
	if(_id == "SoftSlaveryMarkingAnother"):
		return [
			"Еще один? Да.",
			"Думаешь, я закончила? Мы добавим еще один.",
			"Твои конвульсии только принесли тебе еще одну метку, {npc.npcSlave}. Не дергайся.",
			"Обожаю, когда ты такая. Давай добавим еще один, чисто для моего удовольствия.",
			"Хочешь еще? Как тут откажешь...",
			"На тебе это смотрится просто великолепно. Думаю, тебе не помешает еще один, моя сладкая {npc.npcSlave}.",
			"От одного лишнего не повредишь. К тому же, это порадует меня. Так что стой смирно.",
			"Каждый дюйм твоего тела принадлежит мне. И я буду метить его столько, сколько захочу.",
			"Твое тело само молит о новой метке. Не волнуйся, я исполню твое желание.",
		]
	if(_id == "SoftSlaveryMarkingNoStart"):
		return [
			"Ладно. Пока оставлю тебя без отметин.",
			"Везучая ты. Сегодня я в настроении проявить милосердие.",
			"Не сегодня. Но помни: твое тело — это мой холст, и я буду украшать его, когда пожелаю.",
			"Очень хорошо. Пожалуй, позволю тебе побыть «чистой» еще немного, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryMarkingNo"):
		return [
			"Ладно, на сегодня хватит.",
			"Ладно. На этом всё. Я оставила достаточно записей.",
			"Идеально. Моя работа здесь окончена. По крайней мере, на данный момент.",
			"Я довольна. Надеюсь, тебе понравится хвастаться моими шедеврами.",
		]
	if(_id == "SoftSlaveryMarkingNoFail"):
		return [
			"Не испытывай моё терпение, {npc.npcSlave}. Ты всё равно получишь метки, так или иначе.",
			"Надогнешь меня — и я покрою тебя отметинами. А теперь стой смирно и будь послушным {npc.npcSlave}.",
			"У тебя нет выбора. Твоё тело принадлежит мне, и я буду украшать его так, как посчитаю нужным.",
			"Продолжишь спорить — и всё станет куда менее приятным. Ты сейчас получишь метки.",
			"Тишина. Я решаю, что будет с моей собственностью. И я решила, что тебе не помешают кое-какие отметины.",
		]
	if(_id == "SoftSlaveryMarkingBegYes"):
		return [
			"Ты такая милашка, когда умоляешь. Как мне можно отказать?",
			"Выглядишь жалко, когда просишь. Ладно. Так и быть, проявлю милосердие.",
			"Твои мольбы меня забавляют. Ладно, только в этот раз.",
			"Умоляешь меня, да? Мило.",
		]
	if(_id == "SoftSlaveryMarkingBegYes2"):
		return [
			"Тогда на этом всё.",
			"Ладно. Мы закончили.",
			"Ты заслужил временную милость.",
			"Ладно. На этот раз я тебя отпущу.",
		]
	if(_id == "SoftSlaveryMarkingBegNo"):
		return [
			"На колени, {npc.npcSlave}. Именно там тебе и место, когда ты умоляешь.",
			"На колени, {npc.npcSlave}. Для правильного моления нужна правильная поза.",
			"Мне послышались мольбы? Сначала встань на колени, {npc.npcSlave}.",
			"Чего-то хочешь? Тогда встань на колени и попроси как следует, {npc.npcSlave}.",
			"На колени. Живо. А потом будешь умолять, моя маленькая.",
		]
	if(_id == "SoftSlaveryMarkingBegNo2"):
		return [
			"Я сказала — на колени. Не испытывай моё терпение.",
			"На колени. Повторять не буду.",
			"На колени. Покажи, что знаешь своё место.",
			"На колени. Живо.",
			"На колени. Сейчас же.",
		]
	if(_id == "SoftSlaveryMarkingBegCredits"):
		return [
			"Хорошая {npc.npcSlave}. А теперь — 5 кредитов, иначе я украшу твою шкурку.",
			"Хочешь моей милости? Она стоит 5 кредитов. Иначе я оставлю на тебе свой след.",
			"Твой комфорт стоит 5 кредитов, милашка. Плати, или станешь моим холстом.",
			"5 кредитов, и, возможно, я буду снисходительна. Откажешься — и познаешь на себе последствия своего непослушания.",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive"):
		return [
			"Хороший {npc.npcSlave}. Твоя дань принята.",
			"Мудрый выбор, {npc.npcSlave}.",
			"Превосходно. Это мне нравится.",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive2"):
		return [
			"А теперь беги. Мне скучно.",
			"Свободен. Только не вздумай уходить слишком далеко.",
			"Иди. Но помни: ты принадлежишь мне.",
			"Исчезни с глаз моих. Я найду тебя, когда мне понадобится моя собственность.",
		]
	if(_id == "SoftSlaveryMarkingBegNoMarked"):
		return [
			"Так тебе и надо. Наслаждайся метками.",
			"Да будет так. Носи их как напоминание.",
			"Ты сама напросилась. Теперь живи с этими метками.",
			"Метки тебе идут. Они помогут держать тебя в узде.",
			"Не ной. Ты сама это заслужила.",
			"Это твоя расплата. Носи их с гордостью.",
			"Ты хотела буянить? Ну вот, посмотри на себя.",
			"Считай это наказанием. И не вздумай жаловаться."
		]
	if(_id == "SoftSlaveryMarkingBegFoot"):
		return [
			"Хорошо. А теперь покажи свою преданность. Поцелуй мой {npc.foot}, {npc.npcSlave}.",
			"На колени и преклоняйся перед моим {npc.foot}. Будь послушным {pc.boy}.",
			"Твои губы должны быть на моем {npc.foot}, {npc.npcSlave}. А теперь докажи это.",
			"Целуй мой {npc.foot}. Вот где место такой {npc.npcSlave}, как ты.",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss"):
		return [
			"Жалкая и идеальная. Ты сделаешь всё, чтобы угодить мне, верно, {npc.npcSlave}?",
			"Какое восхитительное зрелище. Моя {npc.npcSlave} на своем законном месте.",
			"Хорошо. Мне нравится видеть, как ты унижаешься ради меня, {npc.npcSlave}.",
			"Хорошая {npc.npcSlave}. Твоя преданность замечена.",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss2"):
		return [
			"Можешь остановиться. На сегодня поклонения достаточно.",
			"Довольно. На данный момент ты меня порадовала.",
			"Очень хорошо. Теперь можешь встать.",
			"Приемлемо. А теперь иди, пока я не решила, что хочу большего.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation"):
		return [
			"Так, а теперь. Я хочу услышать, как ты признаешь, что ты — моя собственность. Громко и четко.",
			"А теперь объяви об этом. Скажи всему миру, что ты не кто иная, как моя {npc.npcSlave}.",
			"Хорошо. А теперь признай, что ты моя {npc.npcSlave}. Всего лишь моя собственность.",
			"Так. Теперь я хочу, чтобы ты унизилась. Признай, что ты принадлежишь мне. Признай, что ты {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation2"):
		return [
			"Громче. Я хочу тебя слышать.",
			"Говори так, будто сама в это веришь. С полной убежденностью.",
			"Еще раз! И добавь в это немного стыда.",
			"Вся тюрьма должна знать, кому ты принадлежишь.",
			"Больше чувств! Я хочу слышать твою покорность.",
			"Не шепчи, ори!",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation3"):
		return [
			"Хорошо. Теперь ты звучишь как настоящая {npc.npcSlave}.",
			"Превосходно. Наконец-то ты осознала свою роль.",
			"Именно такой тон я обожаю слышать от своей собственности.",
			"Вот так. Неужели это было так сложно?",
			"Хорошо. Пусть эта истина пропитает тебя до самых глубин.",
			"Приемлемо. Значит, когда есть стимул, ты учишься.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation4"):
		return [
			"Свободен, {npc.npcSlave}. На сегодня с тобой покончено.",
			"Это всё, чего я хотела. А теперь прочь с глаз моих, {npc.npcSlave}.",
			"Ладно. Мы закончили. Но не уходи далеко.",
			"Хорошо. Можешь идти. Я позову тебя, когда захочу твоей компании.",
		]
	if(_id == "SoftSlaveryMarkingNotDone"):
		return [
			"Погоди. Хм... Разве я разрешала тебе двигаться? Я еще не закончила с тобой.",
			"Стой. Хм... Я решила, что еще не доигралась со своей {npc.npcSlave}.",
			"Я передумала. Мы продолжим до тех пор, пока я не буду полностью удовлетворена.",
			"Я передумала. У меня есть для тебя еще кое-что.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks"):
		return [
			"Это просто для того, чтобы ты не вздумала сбежать.",
			"Считай это страховкой.",
			"Не хочу, чтобы ты дёргалась, пока я это делаю.",
			"Так ты точно не будешь ерзать. Мы ведь не хотим, чтобы я всё испортил, верно?",
			"Это поможет тебе стоять смирно. Да.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks2"):
		return [
			"Идеально. Выглядит великолепно.",
			"Отлично. Теперь всё готово.",
			"Прекрасно. Да. Просто прекрасно.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal"):
		return [
			"Это самый интимный способ оставить на тебе метку...",
			"Вот так настоящий доминант помечает свою {pc.his} собственность...",
			"Ты примешь мою метку и научишься обожать этот вкус...",
			"Настоящая {npc.npcSlave} отмечена жидкостями своего хозяина. И ты не исключение.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal2"):
		return [
			"Ммм... Какая послушная {npc.npcSlave}, принимает всё до последней капли.",
			"Это было невероятно. Посмотри на себя: такая порочная и полностью принадлежащая мне.",
			"Хах. Теперь ты выглядишь такой завершенной, моя прекрасная сучка.",
			"Тебе ведь понравилось, правда? Я вижу это по твоим глазам.",
			"Да.. хорошо.. носи мой подарок с гордостью, моя грязная маленькая {npc.npcSlave}.",
			"Какая же ты послушная {npc.npcSlave}. Я тобой горжусь.",
			"Запомни это чувство, {npc.npcSlave}. В этом твое предназначение.",
		]

	if(_id == "SoftSlaveryParadeAroundStart"):
		return [
			"Иди сюда, {npc.npcSlave}. Хочу выставить тебя напоказ всей тюрьме.",
			"Время поводка, {npc.npcSlave}. Ты будешь моим красивым маленьким украшением на глазах у всей тюрьмы.",
			"Вытяни шею, {npc.npcSlave}. Сегодня мы устроим тебе парад, и я жду, что ты будешь носить мой поводок с гордостью.",
			"Сегодня я устрою тебе парад по всей тюрьме, {npc.npcSlave}. Весь блок увидит, какую отличную {npc.npcSlave} я выдрессировала.",
		]
	if(_id == "SoftSlaveryParadeAroundFirst"):
		return [
			"Нравится? Держи спину ровнее. Мы только начинаем.",
			"Как ощущения? Это всего лишь первая остановка. Не смей избегать их голодных взглядов.",
			"Видишь, как они на тебя пялятся? Смотри в ответ. Это только начало.",
			"Наслаждаешься вниманием? Дальше будет еще больше, мы только начали.",
			"Это всего лишь разминка. Не отставай, моя сладкая {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryParadeAroundMore"):
		return [
			"Хорошо. К следующей точке. Давай дадим им еще разок на тебя посмотреть.",
			"Переведи дух на секунду.",
			"Готова продолжать? Нам нужно посетить еще несколько мест.",
			"Признайся, тебе это нравится. Быть моей выставленной напоказ {npc.npcSlave} — это то, для чего ты была создана.",
			"Это никогда не надоест — выставлять мою послушную {npc.npcSlave} на всеобщее обожание и зависть.",
			"Еще одна остановка. Мы еще не закончили.",
			"Немного передохни, и погнали дальше.",
			"Ты что, уже устала? Тебе еще столько мест нужно показать.",
			"Готова продолжать? Тебя еще недостаточно многие видели.",
			"Видишь их глаза? Они все смотрят на тебя. Идем дальше.",
			"Спорим, тебе нравится, когда тебя вот так выставляют напоказ.",
		]
	if(_id == "SoftSlaveryParadeAroundLast"):
		return [
			"Осталась последняя остановка. Покажи всё, на что способна, {npc.npcSlave}. Мне нужно идеальное выступление.",
			"Почти готово. Держи спину ровно и покажи им всем, насколько ты покорная.",
			"Еще разок. Хочу, чтобы все увидели мою прелесть.",
			"Последний раз. Покажи, что ты гордишься собой.",
			"Мы почти закончили. Гордись тем, кто ты есть.",
		]
	if(_id == "SoftSlaveryParadeAroundFree"):
		return [
			"Отличная работа. Теперь ты можешь свободно перемещаться... пока что.",
			"Ты слушалась беспрекословно. Можешь идти.",
			"Хорошо. Теперь ты свободна.",
		]
	if(_id == "SoftSlaveryParadeAroundEatGagged"):
		return [
			"Какая жалость, что ты сейчас не можешь есть, {npc.npcSlave}. Тебе остается только смотреть, как наслаждаюсь я.",
			"Раз уж ты не можешь кусать, я поем за нас двоих. Будь хорошей {npc.npcSlave} и смотри.",
			"Будешь сидеть и ждать, пока я ем.",
		]
	if(_id == "SoftSlaveryParadeAroundEat"):
		return [
			"Перерыв. Покушай, {npc.npcSlave}. Тебе понадобятся силы для меня.",
			"Садись. Ешь то, что дают. Ты заслужила эту маленькую награду, {npc.npcSlave}.",
			"Короткий отдых. Подкрепись, {npc.npcSlave}. Я с тобой еще не закончила.",
			"На, держи. И не вздумай переводить впустую.",
		]
	if(_id == "SoftSlaveryParadeAroundPlatform"):
		return [
			"Видишь те штуки? Там ты проведешь весь день, если начнешь капризничать, {npc.npcSlave}.",
			"Публичные колодки. Идеальное место, чтобы непослушная милашка усвоила урок, не находишь?",
			"Это твоя альтернатива хорошему поведению. Советую тебе об этом помнить, моя {npc.npcSlave}.",
			"Тебе нравится идея публичного использования, {npc.npcSlave}? Веди себя хорошо, иначе узнаешь всё на собственной шкуре.",
		]
	if(_id == "SoftSlaveryParadeAroundShower"):
		return [
			"Нельзя допустить, чтобы моя {npc.npcSlave} выглядела хоть на йоту хуже идеала. Тебя сейчас помоют.",
			"Тебя сейчас приведут в порядок. Стой смирно и позволь мне о тебе позаботиться.",
			"Хочу, чтобы ты выглядела презентабельно. Быстро сполоснись, чтобы моя {npc.npcSlave} выглядела на {pc.his} лучший вид.",
		]

	if(_id == "SoftSlaveryThreesomeStart"):
		return [
			"Я привела подругу. Обслуживать будешь нас обеих.",
			"Сегодня у тебя еще один господин. Жду, что ты будешь вести себя безупречно.",
			"Моя подруга хочет посмотреть, как хорошо я тебя натренировала. Не разочаруй меня, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryPunishCredits"):
		return [
			"Теперь это принадлежит мне. Малая цена за твое непослушание.",
			"Оплата за мое терпение. Будь благодарна, что я не забираю больше.",
			"Эти кредиты — мои. Пусть это станет уроком послушания.",
			"Это должно компенсировать мое разочарование тобой.",
			"Этого не хватит, чтобы выкупить твою свободу, но, возможно, этого хватит, чтобы купить мою милость на сегодня.",
		]
	if(_id == "SoftSlaveryPunishCredits2"):
		return [
			"Продолжишь в том же духе, и последствия будут куда суровее, {npc.npcSlave}.",
			"Повинуйся, иначе мне придется прибегнуть к более жестким мерам.",
			"Считай это мягким напоминанием. В следующий раз я не буду такой снисходительной к своему {npc.npcSlave}.",
			"Кредиты — это меньшее из того, что я заберу, если ты продолжишь испытывать моё терпение.",
		]
	if(_id == "SoftSlaveryPunishRipClothes"):
		return [
			"Навеселился, мелкий паршивец? А теперь слушайся, пока я не решила устроить тебе настоящие мучения.",
			"Наслаждаешься бунтом? Это еще цветочки по сравнению с тем, что тебя ждет, если не начнешь вести себя прилично, {npc.npcSlave}.",
			"Всё еще чувствуешь себя смелым? В следующий раз будет куда хуже.",
			"Закончил свою истерику? Хорошо. Теперь подчиняйся, или узнаешь, что такое настоящее наказание.",
			"Выпустил пар? Пора вспомнить свое место, {npc.npcSlave}.",
			"Это был твой единственный бесплатный пропуск. Продолжишь в том же духе — будешь горько об этом жалеть.",
		]
	if(_id == "SoftSlaveryPunishRoughSex"):
		return [
			"Ладно. Если не хочешь подчиняться по доброй воле, я заставлю тебя, мой упрямый {npc.npcSlave}.",
			"Ты выбрал трудный путь. О, как же я люблю приручать строптивых питомцев.",
			"Ты сама выбрала эту боль. Теперь принимай её как послушная {npc.npcSlave}, которой ты так старательно пытаешься не быть.",
			"Тебе следовало слушаться, когда была возможность. Теперь узнаешь всё на собственной шкуре.",
			"Твоё тело подчинится, даже если разум будет сопротивляться. Начнём.",
			"Мне особенно нравится ломать таких упрямиц, как ты. От этого победа кажется куда слаще.",
		]
	if(_id == "SoftSlaveryPunishRoughSexPCWon"):
		return [
			"Это ещё не конец, {npc.npcSlave}. Далеко не конец.",
			"Наслаждайся своей мимолётной победой. Она ничего не меняет.",
			"Большая ошибка. Огромная.",
		]
	if(_id == "SoftSlaveryPunishRoughSexEnded"):
		return [
			"Пусть это будет тебе уроком, {npc.npcSlave}. В следующий раз всё будет куда хуже.",
			"Считай, что тебя предупредили. Моё терпение не безгранично.",
			"Это была лишь малая часть того, что ждёт тебя за непослушание.",
			"Запомни это чувство. Ведь всё может стать только хуже.",
			"Тебе еще повезло. Не заставляй меня показывать, что будет дальше.",
			"Мое терпение не бесконечно, {npc.npcSlave}. Помни об этом.",
			"Надеюсь, ты сегодня чему-то научилась — ради собственного же блага.",
			"Это была милость по сравнению с тем, что может последовать за этим.",
		]
	if(_id == "SoftSlaveryPunishSlutwall"):
		return [
			"Иди к шлюхостенке по доброй воле, {npc.npcSlave}, иначе я сделаю так, что ты туда поползешь.",
			"Шлюхостенка ждет. Можешь пойти с достоинством, а можешь и без него.",
			"Не усложняй всё без нужды. Шагай как послушная {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryPunishSlutwallLock"):
		return [
			"Наконец-то ты служишь своему истинному предназначению — быть общественной собственностью.",
			"Добро пожаловать на твое законное место. Попробуй только теперь еще поумничать.",
			"Постарайся быть полезной, пока обдумываешь свое поведение.",
			"Возможно, общественные работы помогут наладить твой характер.",
		]

	if(_id == "SoftSlaveryPunishStocks"):
		return [
			"Иди к колодкам сама, {npc.npcSlave}, иначе я потащу тебя за шиворот.",
			"Двигай своими прелестными ножками, {npc.npcSlave}, иначе заставлю ползти каждый дюйм этого пути.",
			"К колодкам, живо. Либо идешь сама, либо я потащу свою строптивую {npc.npcSlave} на поводке.",
			"Не усложняй всё без нужды. Шагай, или я сделаю так, что этот путь ты запомнишь надолго.",
		]
	if(_id == "SoftSlaveryPunishStocksLock"):
		return [
			"Раз уж ты отказываешься быть моей послушной {npc.npcSlave}, побудешь какое-то время чьей-то общей игрушкой.",
			"За непослушание приходится платить, {npc.npcSlave}. Посмотрим, понравится ли тебе роль общественной собственности.",
			"Если не хочешь быть послушной для меня, научишься быть полезной для незнакомцев.",
			"Упрямая, да? Может, пара часов в роли тюремной трах-игрушки смягчит твой нрав, {npc.npcSlave}.",
			"Ты принадлежишь мне, и только я решаю, как тебя использовать. А сейчас это значит — прислуживать любому, кого я найду.",
			"Может, дюжина незнакомцев научит тебя послушанию, которое ты отказываешься проявлять ко мне.",
		]
	if(_id == "SoftSlaveryPunishStocksAsk"):
		return [
			"Та милая рабыня свободна для использования?",
			"Не возражаешь, если я тоже поразвлекусь с твоей симпатичной игрушкой?",
			"Эта штучка ищет внимания? Можно мне его уделить?",
			"Твоя собственность открыта для бизнеса?",
			"Можно одолжить эту ебаную игрушку на часок?",
			"Это что, такая хорошо натренированная милашка? Можно мне протестировать {pc.him}?",
			"Твоя рабыня выглядит так, будто {pc.he} не помешает урок. Не против, если проведу его?",
		]
	if(_id == "SoftSlaveryPunishStocksAskNope"):
		return [
			"Моя {npc.npcSlave} не бесплатная. <CREDITS> кредитов — и можешь делать с {pc.him} всё, что захочешь.",
			"Хорошие игрушки не стоят дешево. <CREDITS> кредитов за сеанс с моей {npc.npcSlave}.",
			"У всего есть цена. <CREDITS> кредитов купят тебе немного времени с моей собственностью.",
			"<CREDITS> кредитов, и ты сможешь использовать мою непослушную {npc.npcSlave} как тебе заблагорассудится.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy"):
		return [
			"А если мне не захочется платить?",
			"Я не собираюсь платить за твой подержанный товар.",
			"Слишком высокая цена за поврежденную собственность.",
			"Твоя {npc.npcSlave} не стоит таких денег.",
			"Не стану платить столько за непослушную шлюху.",
			"Эта выглядит слишком изношенной, чтобы стоить таких денег.",
			"Твоя цена слишком задрана для бракованного товара.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy2"):
		return [
			"Проваливай, не трать мое время.",
			"Нет кредитов — нет траха. Всё просто. А теперь сваливай.",
			"Тогда не трать моё время. Проваливай.",
			"Исчезни, если не можешь позволить себе качество.",
			"Возвращайся, когда будут кредиты, чтобы тратиться.",
			"Тогда не получишь нихуя.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy3"):
		return [
			"Мне не хочется уходить с пустыми руками.",
			"Может, я просто возьму то, что захочу, от твоей милой игрушки.",
			"Твоя собственность выглядит слишком соблазнительно, чтобы просто уйти.",
			"Думаю, я всё равно приберу к рукам твою секс-игрушку.",
			"Возможно, я использую {pc.him} и позволю тебе смотреть, как я это делаю.",
			"Когда я чего-то хочу, слово «нет» меня не интересует.",
			"Может, сегодня настоящая цена — это капелька силы?",
		]
	if(_id == "SoftSlaveryPunishStocksAskSure"):
		return [
			"Конечно. Справедливая цена за немного веселья.",
			"Меня устраивает. Держи.",
			"Вот, держи. Должно хватить.",
			"Приятно иметь с тобой дело.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterSex"):
		return [
			"Видишь, насколько жизнь становится лучше, когда ты приносишь пользу, {npc.npcSlave}? А теперь сиди смирно и размышляй.",
			"Для этого ты и годишься. В следующий раз, когда решишь ослушаться, вспомни это чувство.",
			"Ты отлично справилась со своей задачей. Может, быть общественной игрушкой тебе подходит больше, чем быть моей? Да.",
			"Наконец-то нашла то, что у тебя получается лучше всего, моя маленькая {npc.npcSlave}. Быть шлюхой на всеобщее пользование.",
			"Умница, {npc.npcSlave}. А теперь сиди взаперти и думай о том, как приятно быть послушной.",
			"Либо ты слушаешься меня, либо прислуживаешь всем. Выбор за тобой. Запомни это.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex"):
		return [
			"Это было жалко. Верни мои кредиты.",
			"Твоя шлюха никуда не годится. Верни деньги.",
			"Худший трах, за который я когда-либо платил. Хочу свои деньги назад.",
			"Эта девка не стоит потраченных кредитов. Верни их.",
			"Твоя сучка слишком много брыкается. Не стоит своих денег.",
			"Бракованный товар. Верни мои кредиты.",
			"Зря потраченные кредиты. Твоя секс-игрушка бесполезна.",
			"Ужасный сервис. Требую возврата средств.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex2"):
		return [
			"Ты использовал мою собственность. Возврата не будет.",
			"Всё работает не так. Ты заплатил за доступ, а не за гарантии.",
			"Возврата нет. Ты получил ровно то, за что заплатил.",
			"Моя {npc.npcSlave} прислужила тебе. Сделка завершена.",
			"Ты заплатил, ты воспользовался. Сделка закрыта. А теперь — брысь.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost"):
		return [
			"Милое зрелище.",
			"Ты и сам дерешься как мягкотелый раб.",
			"И это всё, на что ты способен? Прелестно.",
			"Столько борьбы — и всё впустую. Даже мило.",
			"Ты оказался еще нежнее, чем я думала.",
			"Столько злости и так мало сил. Очаровательно.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost2"):
		return [
			"Так-то лучше. Две рабыни в колодках. Вот так это и должно выглядеть.",
			"Теперь вы оба знаете своё место. Наслаждайтесь компанией друг друга.",
			"Оба заперты там, где вам и положено. Идеально.",
			"Учись знать своё место вместе со своим рабом. Ты ничем не лучше.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost3"):
		return [
			"Так-то лучше. А теперь твоя милая игрушка будет смотреть, как я тебя наказываю.",
			"Хорошо. Теперь твой неженка увидит, что бывает с непослушными хозяевами.",
			"Идеально. Твоя мягкая игрушка извлечёт урок из твоих ошибок.",
			"Так гораздо лучше. Твоя милашка это запомнит.",
			"Хорошо. Твой неженка увидит, что такое настоящее наказание.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon"):
		return [
			"Знай своё место.",
			"Ты слабачка. Знай своё место.",
			"Жалкое зрелище. Знай своё место.",
			"Столько злости, и ради чего? Знай своё место.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon2"):
		return [
			"И ты ходишь по очень тонкому льду, {npc.npcSlave}. Не думай, что я про тебя забыла.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon3"):
		return [
			"А теперь ты выучишь своё место.",
			"Ты слабачка. И теперь ты узнаешь, где именно тебе полагается быть.",
			"Жалкая. А теперь ты узнаешь цену своих поступков.",
			"Столько борьбы, а в итоге ты просто узнаешь своё истинное предназначение.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon4"):
		return [
			"И смотри внимательно, {npc.npcSlave}. Это может случиться и с тобой.",
			"Слушай внимательно, моя {npc.npcSlave}. Это — последствия непослушания.",
		]

	if(_id == "SoftSlaveryPunishSell"):
		return [
			"Ты исчерпала моё терпение, {npc.npcSlave}. Боюсь, с тобой покончено, как ни печально.",
			"Это был твой последний акт непослушания. С тебя хватит. *Вздох*.",
			"У тебя был каждый шанс стать послушной, но ты предпочла бунтовать. Что ж, я пыталась.",
			"Я старалась быть строгой, но справедливой, но ты твердо решила, что тебя нужно ломать жестким способом. Прощай, {npc.npcSlave}.",
			"Ты могла бы стать моей идеальной {npc.npcSlave}, но ты отказалась учиться. Теперь ты станешь чьей-то чужой проблемой.",
		]
	if(_id == "SoftSlaveryPunishSell2"):
		return [
			"Посмотрим, как ты справишься с хозяином, который не будет так терпеть тебя, как я.",
			"Может, твоему следующему господину удастся то, что не удалось мне.",
			"Ты больше не моя забота. Пусть кто-нибудь другой вылепит из тебя ту {npc.npcSlave}, которой ты должна была стать.",
			"Удачи с новым хозяином. Они не будут такими милосердными, как я, неженка.",
			"Теперь с твоим непослушанием будет разбираться другой господин. Надеюсь ради твоего же блага, что он будет терпеливее меня.",
		]


	if(_id == "SoftSlaveryPunishGB"):
		return [
			"Ты слишком сильно меня довела, {npc.npcSlave}. Думаю, тебе пора устроить групповой секс.",
			"Непослушание имеет последствия. Я выбью из тебя всю эту дерзость через групповой секс.",
			"Думаешь, сможешь мне отказать? Посмотрим, надолго ли хватит твоего гонора, когда тебя будут трахать толпой.",
			"Я была слишком мягка с тобой. Пора устроить тебе настоящий гангбанг.",
			"Похоже, ты забыла, кому принадлежишь. Групповуха быстро освежит твою память.",
			"За каждым твоим «нет» следует новый член. Посмотрим, сколько ты сможешь принять, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryPunishGBGiveup"):
		return [
			"Жалкое зрелище. Даже не нашлось достаточно людей, чтобы заморочиться с тобой.",
			"Никому не нужна моя непослушная {npc.npcSlave}. Ты даже не годишься для общественного пользования.",
			"Считай, что тебе повезло, что сегодня некому поставить тебя на место.",
			"Грустно. Тебе повезло, что вокруг не так много народу.",
			"Оу, никто не хочет тебя трахать. Как печально.",
			"Даже не нашлось достаточно людей, которым захотелось бы твоих дырок. Что это говорит о тебе?",
			"Жаль, похоже, ты сейчас даже не стоишь того, чтобы тебя оттрахали толпой.",
		]
	if(_id == "SoftSlaveryPunishGBOffer"):
		return [
			"Хочешь устроить гангбанг моей непослушной {npc.npcSlave}?",
			"Моей {npc.npcSlave} не помешает коллективный секс. Интересно?",
			"Хочешь помочь сломить эту непокорную {npc.npcSlave}?",
			"Этой {npc.npcSlave} пора выучить свое {pc.his} место. Поможешь оттрахать {pc.him}?",
			"Моя собственность должна помнить, что она — всего лишь дырка для использования. Поможешь?",
			"Хочешь попользоваться моей {npc.npcSlave}?",
			"Моему питомцу нужно вернуть его {pc.his} место. Хочешь устроить гангбанг для {pc.him}?",
		]
	if(_id == "SoftSlaveryPunishGBSure"):
		return [
			"Конечно. Почему бы и нет.",
			"Всегда рад трахнуть милашку.",
			"С удовольствием.",
			"Да-да-да!",
			"С радостью.",
			"Да. Однозначно да."
		]
	if(_id == "SoftSlaveryPunishGBFollow"):
		return [
			"Следуй за мной.",
			"Сюда. Давай найдем подходящее местечко.",
			"Следуй за мной.",
			"Пошли.",
			"Иди за мной. Пора бы уже замутить этот гангбэнг.",
		]
	if(_id == "SoftSlaveryPunishGBSubOffer"):
		return [
			"Если можно, я бы предпочла сама принимать в себя все члены.",
			"Могу ли я предложить себя в качестве дополнительного отверстия для использования?",
			"Не рассмотришь ли ты вариант использовать меня наравне с твоим {npc.npcSlave}?",
			"Вообще-то, я бы предпочла сама быть той, кого трахают.",
			"Я хочу быть игрушкой для наказаний, а не полноценным участником.",
			"Может, мне стать бонусным куском мяса для всех?",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferYes"):
		return [
			"Отлично. Чем больше послушных шлюх, тем лучше.",
			"Меня устраивает. Лишние жаждущие дырки всегда кстати.",
			"Идеально. Ты поможешь продемонстрировать моему {npc.npcSlave}, что такое истинное подчинение.",
			"Чудесно. В два раза больше развлечений для всех.",
			"Почему бы и нет? Идите за нами.",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNo"):
		return [
			"Извини, места нет.",
			"Не, не получится. У нас и так уже есть лишняя милая сабмиссивша.",
			"У нас и так уже хватает неженок.",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNoAw"):
		return [
			"Какая жалость. А ведь я так обожаю, когда меня используют.",
			"Как разочаровывающе. Я просто живу ради того, чтобы быть материалом для гангбэнга.",
			"Черт. А ведь мне так нравится, когда меня как следует наказывают.",
			"Разочаровывает. Обожаю показывать, насколько я может быть послушной.",
		]
	if(_id == "SoftSlaveryPunishGBNo"):
		return [
			"Я откажусь, спасибо.",
			"Не самое любимое занятие, спасибо.",
			"Пожалуй, я воздержусь.",
			"Не сегодня, но спасибо.",
			"Лучше не буду в этом участвовать.",
			"Не для меня, но спасибо за предложение.",
			"Это не совсем по моей части, спасибо.",
		]
	if(_id == "SoftSlaveryPunishGBNoReact"):
		return [
			"Твоя потеря.",
			"Ладно. Без проблем.",
			"Понимаю. Хорошо.",
			"Угу. Найдем кого-нибудь другого.",
			"Будем искать дальше.",
		]
	if(_id == "SoftSlaveryPunishGBStart"):
		return [
			"Пусть веселье начнется.",
			"Готова повеселиться?",
			"Вот что бывает за непослушание.",
			"Надеюсь, ты готова к наказанию. И не вздумай улыбаться.",
			"Посмотрим, сколько членом ты сможешь принять. А то вдруг нам не хватит, ха!",
		]
	if(_id == "SoftSlaveryPunishGBEnd"):
		return [
			"Помни об этом чувстве каждый раз, когда решишь ослушаться, {npc.npcSlave}.",
			"В следующий раз, когда ты взбунтуешься, наказание будет куда менее приятным.",
			"Думай об этом каждый раз, когда захочешь сказать мне «нет».",
			"Твое предназначение — служить. Не заставляй меня повторять этот урок.",
		]

	if(_id == "SoftSlaveryPunishLockRestraint"):
		return [
			"Ты облажалась. И теперь тебе придется за это отвечать.",
			"Похоже, кто-то заслужил новый аксессуар. Разве он не прелестен?",
			"Оу, ты думала, я просто так это спущу с рук? Мило. Но нет.",
			"Поздравляю. Ты сам себя переиграл. И вот твоя награда.",
			"Хотел моего внимания? Получай. А теперь — твоё наказание.",
			"За плохой выбор полагаются блестящие награды. Ну же, проверь.",
			"Обожаю, когда ты испытываешь меня на прочность. Это дает мне повод творить подобное.",
			"Тебе повезло, что ты мне нравишься. Иначе всё было бы куда хуже.",
			"Посмотрим, поможет ли это тебе вспомнить, кто здесь главный."
		]
	if(_id == "SoftSlaveryPunishLockRestraint2"):
		return [
			"Бросаю тебе вызов: попробуй его снять. Серьёзно. Попробуй.",
			"Этот замок не снимется, пока я не разрешу. Только тронь его — и узнаешь, что будет дальше.",
			"Можешь снять его, когда захочешь. Но знай: надевать его обратно мне будет в десять раз приятнее.",
			"Я сразу пойму, если ты начнешь с ним возиться. И я буду так... разочарована. Тебе это не понравится.",
			"Попробуй, рискни и сними его. Мне всё равно скучно.",
			"Снимешь без разрешения — и я надену на тебя что-нибудь ещё тяжелее. Выбирай, дорогуша.",
			"Ты ведь достаточно умна, чтобы не трогать его? Правда ведь? Вот и славно."
		]
	if(_id == "SoftSlaveryPunishLockRestraint3"):
		return [
			"Ещё одна милая маленькая ошибка, и я стану куда злее. Всё ещё хочешь поиграть?",
			"Ты такая очаровательная, когда испытываешь удачу. Жаль только, что я сегодня не в настроении прощать.",
			"Продолжай испытывать меня. Я просто буду добавлять новые замки... или сделаю что-нибудь похуже.",
			"Улыбайся сколько влезет. Этот замок скоро не снимется.",
			"Ты ходишь по тонкому льду, а у меня в руках ножницы, чтобы его разрезать.",
		]

	if(_id == "SoftSlaveryResist"):
		return [
			"Серьёзно, {npc.npcSlave}? Думаешь, твоё мнение здесь что-то значит?",
			"Пытаешься сопротивляться мне, {npc.npcSlave}? Как же это мило и жалко.",
			"Значит, моя сладкая {npc.npcSlave} хочет капризничать? Обожаю приручать упрямых питомцев.",
			"Это твой способ попросить более крепкую руку, моя дорогая {npc.npcSlave}?",
			"Какой боевой дух. Посмотрим, надолго ли тебя хватит, когда я с тобой закончу.",
			"Брыкайся сколько влезет, {npc.npcSlave}. От этого твоя покорность станет только слаще.",
			"Твой бунт бесполезен, {npc.npcSlave}. Ты принадлежишь мне.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtra"):
		return [
			"Эй! А мне можно их тоже оттрахать?",
			"Не против, если я присоединюсь? Выглядит весело.",
			"Можно мне тоже по очереди поиграть с этой милой игрушкой?",
			"Найдется место для еще одного? Я бы с удовольствием поюзал эти милые дырочки.",
			"Думаешь, твоя игрушка вывезет нас двоих?",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraYes"):
		return [
			"Конечно. Помоги мне как следует закрепить мою {npc.npcSlave}.",
			"Да. Присоединяйся. Погнали.",
			"Идеально. Помоги мне полностью обездвижить {pc.him}.",
			"Разумеется. Давай возьмем этого сорванца вдвоем.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo"):
		return [
			"Нет. Найди себе кого-нибудь другого.",
			"Нет. Я не делюсь тем, что принадлежит мне.",
			"Этот {npc.npcSlave} принадлежит мне. Ищи себе собственную игрушку.",
			"Категорически нет. Мой {npc.npcSlave} служит только мне.",
			"Найди себе своего {npc.npcSlave}. Этот слушается только меня.",
			"Заведи себе своего. Этим {npc.npcSlave} играю только я.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo2"):
		return [
			"Серьезно? Думаешь, мне нужно твое разрешение, милашка?",
			"Я не спрашивала твоего мнения, неженка.",
			"Мне плевать, дорогая. Я хочу твоего питомца.",
			"Попробуй только меня остановить. Это лишь добавит веселья.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFree"):
		return [
			"Ты свободна, пока что.",
			"Ладно, на сегодня хватит. Можешь идти.",
			"Проваливай. С тобой на сегодня покончено.",
			"Это всё внимание, которое ты получишь сегодня. А теперь — марш.",
			"Беги. Продолжим в другой раз.",
			"Давай, выметайся. Я уже вдоволь повеселился.",
			"Ты свободна. Пока что.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFreeLost"):
		return [
			"Ты всё ещё моя {npc.npcOwner}, поняла?",
			"Не думай, что это что-то меняет. Ты всё ещё моя собственность.",
			"Помни, кто на самом деле владеет тобой, {npc.npcSlave}.",
			"Ничего не изменилось. Ты всё ещё моя {npc.npcSlave}.",
			"Ты всё ещё отвечаешь мне, понятно?",
		]

	if(_id == "SoftSlaveryParadeFuckOffer"):
		return [
			"Какой хорошо натренированный милашка у тебя тут. Я хочу использовать {pc.him}.",
			"Какой аппетитный кусок собственности. Я хочу трахнуть {pc.him}.",
			"Этот неженка выглядит так, будто нуждается в моем внимании.",
			"Твоя игрушка выглядит соблазнительно. Можно мне прикоснуться?",
			"Какая прелестная игрушка. Хочу поиграть с {pc.him}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYes"):
		return [
			"Знаешь что? Ладно. Заставь моего {npc.npcSlave} извиваться для меня.",
			"Меня устраивает. Только не сломай мою собственность окончательно, неженка.",
			"Давай. Можешь использовать {pc.him}.",
			"Знаешь что? Давай. Заставь эту милашку извиваться.",
			"Валяй. {pc.He} не помешает немного развлечься.",
			"Определенно. Сделай так, чтобы все слышали стоны {pc.his}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYesThree"):
		return [
			"Знаешь что? Ладно. Я тоже присоединюсь.",
			"Вообще-то, я тоже, пожалуй, поучаствую.",
			"Хорошая идея. Мне тоже не помешало бы снять стресс.",
			"Идеально. Я покажу тебе, как правильно обращаться с моей {npc.npcSlave}.",
			"Ладно, но рулить буду я. Смотри и учись, как дрессировать {npc.npcSlave}.",
			"Да, и я продемонстрирую, как правильно использовать эту милую {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo"):
		return [
			"Нет. Тебе позволено только смотреть.",
			"Не-а. Найди себе другую игрушку.",
			"Категорически нет. Моя собственность не раздается направо и налево.",
			"Нет. Можешь только смотреть.",
			"Нет. Смотри, но не трогай.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo2"):
		return [
			"Ладно. Твоя потеря, милашка.",
			"Твоя потеря, неженка.",
			"Как хочешь, милашка.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferGood"):
		return [
			"Хорошо. Даже отлично. Продолжим.",
			"Видишь? Ты был создан для этого. А теперь пошли.",
			"Хорошо. А теперь шевелись.",
			"Теперь продолжим.",
			"Ладно. Пора идти.",
			"Я еще не закончила водить тебя кругами.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferFight"):
		return [
			"Понятно. Тебе просто нужен кто-то, кто преподаст тебе урок о том, что такое собственность.",
			"Неправильный ответ. Пора показать тебе, как здесь всё устроено, неженка.",
			"Так вот оно как? Ладно. Значит, я возьму то, что хочу, силой.",
			"Большая ошибка. Теперь я с удовольствием сломаю вас обоих.",
			"Ты пожалеешь о своём решении. Готовься лишиться своей секс-игрушки.",
			"Как мило. Пора заставить тебя пожалеть о том, что ты решил бросить мне вызов.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferWon"):
		return [
			"Ты так просто от меня не отделаешься, милашка.",
			"Еще один дурак, решивший, что может забрать моё.",
			"Пусть это будет уроком для остальных. Мою {npc.npcSlave} трогает только один человек — я.",
			"Еще один тупой мудак повержен. Пошли, моя послушная {npc.npcSlave}.",
			"Они думали, что смогут забрать тебя? Как мило, моя прелестная {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostWatch"):
		return [
			"Теперь ты моя. Твой милый хозяин будет наблюдать.",
			"Теперь я могу тебя оттрахать. Твой хозяин получает места в первом ряду на это шоу.",
			"Я победила. А значит, я тебя оттрахаю.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostBoth"):
		return [
			"Теперь ты моя. Хотя нет... я оттрахаю вас обоих.",
			"Двое по цене одной. Я оттрахаю вас обоих.",
			"Идеально. Две мягкие секс-игрушки в моем распоряжении.",
		]

	if(_id == "SoftSlaveryParadeGuard"):
		return [
			"Погодите. Почему заключенный на поводке? Мне нужны ответы.",
			"Объяснись. Живо. Почему {pc.isAre} {pc.he} на поводке.",
			"Что-то тут не так. Что вообще происходит?",
			"Так, стоп. Я хочу знать, в чем тут дело.",
			"А ну стоять. Кто дал тебе разрешение на это?",
			"Замри. И объясни, что ты творишь.",
			"Погоди. Объяснись.",
			"Выглядит подозрительно. Чем это ты тут занимаешься?",
		]
	if(_id == "SoftSlaveryParadeGuardPunish"):
		return [
			"Я наказываю этого заключенного.",
			"Просто применяю дисциплинарные меры к этому экземпляру.",
			"Это исправительные меры для проблемного заключенного.",
			"Учу этого заключенного послушанию.",
			"Стандартная процедура для таких сложных случаев.",
			"Этой нужно выучить свое {pc.his} место.",
			"Просто проверяю, понимает ли этот заключенный свою {pc.his} роль.",
		]
	if(_id == "SoftSlaveryParadeGuardPunish2"):
		return [
			"Ну, продолжай. Хорошего дня.",
			"Очень хорошо. Переходи к самому интересному.",
			"Весело. Продолжай выполнять свои обязанности.",
			"Ладно, не буду тебе мешать. Развлекайся.",
			"Развлекайся. Не задерживайся.",
			"Ясно. Продолжай свои развлечения.",
			"Звучит весело. Оставлю тебя наедине с этим.",
		]
	if(_id == "SoftSlaveryParadeGuardProblem"):
		return [
			"Это не твоё дело.",
			"Занимайся своим делом, ладно?",
			"Отойди, охранник. Это личное.",
			"Тебе лучше в это не ввязываться.",
			"Это дело между мной и моей собственностью.",
			"Не твоя забота. Вали отсюда.",
			"Я тебе не подчиняюсь.",
		]
	if(_id == "SoftSlaveryParadeGuardProblem2"):
		return [
			"Серьезно? Как мило.",
			"Понятно. Понятно. Мило.",
			"Прелестно. Правда. Я просто в ужасе.",
			"Бип-бип. Это был неправильный ответ.",
			"Хорошая попытка. Но не вышло.",
		]
	if(_id == "SoftSlaveryParadeGuardWon"):
		return [
			"Так на чём мы остановились? Ах да, пошли.",
			"Пусть это послужит уроком любому, кто решит со мной связаться.",
			"Пошли, {npc.npcSlave}. Мы еще не закончили.",
			"Пора продолжать, {npc.npcSlave}.",
			"Никто не смеет угрожать моей собственности и оставаться безнаказанным.",
			"Вот что бывает, когда покушаешься на то, что принадлежит мне.",
			"Пусть это послужит уроком всем, кто заглядывается на моего питомца.",
			"Идем, {npc.npcSlave}. Нам нужно закончить тренировку.",
		]
	if(_id == "SoftSlaveryParadeGuardLost"):
		return [
			"Можешь идти, заключенный.",
			"Считай, что тебе повезло. Можешь уходить.",
			"Можешь идти. Только не попадайся мне на глаза в таком виде снова.",
			"А теперь беги. Тебе дали второй шанс.",
			"Шевели поршнями, пока я не передумала.",
			"Свободен. И не заставляй меня жалеть об этом.",
			"Считай, что сегодня твой счастливый день. А теперь — марш.",
		]


	if(_id == "SoftSlaveryGB"):
		return [
			"Мне что-то захотелось устроить тебе гангбанг. Так что именно это мы и сделаем. Постарайся не облажаться, и, может быть, заработаешь немного кредитов, моя {npc.npcSlave}.",
			"Я хочу собрать группу, чтобы использовать тебя сообща. Твоя покорность может быть вознаграждена кредитами, {npc.npcSlave}.",
			"Сегодня в деле будет каждое твоё отверстие. Захватывающе, а? Тебя будут трахать толпой, пока я не наемся. Справишься — и я, возможно, подкину тебе пару кредитов, {npc.npcSlave}.",
			"Думаю сегодня устроить кое-что очень весёлое. Ты станешь главным украшением на вечеринке, которую я организую. Да, это будет гангбанг. Если будешь послушной, сможешь кое-что заработать.",
			"Хочу устроить гангбанг. Готовься к тому, что тебя будут использовать толпой. Ты можешь получить награду... если будешь достаточно послушной, моя {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGBGiveup"):
		return [
			"Похоже, пока придётся всё отменить. Какая жалость.",
			"Видимо, сегодня никто не достоин пользоваться моей собственностью. Что ж, бывает.",
			"Подходящих участников нет. Пока что ты спасена.",
		]
	if(_id == "SoftSlaveryGBOffer"):
		return [
			"Кто хочет устроить гангбанг моей {npc.npcSlave}? По честной цене.",
			"Моя {npc.npcSlave} хочет, чтобы её оттрахали толпой. Хочешь поучаствовать?",
			"Я собираю компанию, чтобы оттрахать мою {npc.npcSlave}. Хочешь присоединиться? За определенную плату, конечно.",
			"Хочешь со мной устроить групповуху с моей {npc.npcSlave}? С тебя лишь приличная сумма кредитов.",
			"Я хочу прямо сейчас оттрахать мою {npc.npcSlave} толпой. Хочешь заплатить за участие?",
			"Я организую групповой секс для моей {npc.npcSlave}. Можешь присоединиться, если у тебя есть кредиты.",
			"Мне не помешали бы участники, чтобы оттрахать {npc.npcSlave} толпой. Хочешь с нами? За плату, разумеется.",
		]
	if(_id == "SoftSlaveryGBSure"):
		return [
			"Конечно. Почему бы и нет.",
			"Всегда рад трахнуть милашку.",
			"С удовольствием.",
			"Да-да-да!",
			"С радостью.",
			"Да. Однозначно да."
		]
	if(_id == "SoftSlaveryGBFollow"):
		return [
			"Тогда следуй за мной.",
			"Сюда. Давай найдем подходящее местечко.",
			"Следуй за мной.",
			"Пошли.",
			"Иди за мной. Пора бы уже замутить этот гангбэнг.",
		]
	if(_id == "SoftSlaveryGBSubOffer"):
		return [
			"Может, мне стоит самой стать шлюхой? Я могу заплатить.",
			"А что, если я тоже хочу, чтобы меня использовали? Я могла бы заплатить.",
			"Хм. А можно мне присоединиться к твоей рабыне вместо этого? Я готова платить.",
			"Ты не хочешь и меня тоже использовать?",
			"Мне тоже хочется, чтобы меня использовали. Ну пожалуйста?",
			"Я бы предпочла быть шлюхой для гангбенга. У меня даже кредиты есть.",
		]
	if(_id == "SoftSlaveryGBSubOfferYes"):
		return [
			"Отлично. Чем больше послушных шлюх, тем лучше.",
			"Меня устраивает. Лишние жаждущие дырки всегда кстати.",
			"Идеально. Ты поможешь продемонстрировать моему {npc.npcSlave}, что такое истинное подчинение.",
			"Чудесно. В два раза больше развлечений для всех.",
			"Почему бы и нет? Идите за нами.",
		]
	if(_id == "SoftSlaveryGBSubOfferNo"):
		return [
			"Извини, места нет.",
			"Не, не получится. У нас и так уже есть лишняя милая сабмиссивша.",
			"У нас и так уже хватает неженок.",
			"Список уже полон.",
		]
	if(_id == "SoftSlaveryGBSubOfferNoAw"):
		return [
			"Жаль. Может, в другой раз.",
			"Какая жалость. А ведь я так обожаю, когда меня используют.",
			"Как разочаровывающе. Я просто живу ради того, чтобы быть материалом для гангбэнга.",
			"Черт. Мне так нравится, когда меня используют как следует.",
			"Разочаровывает. Обожаю показывать, насколько я может быть послушной.",
		]
	if(_id == "SoftSlaveryGBNo"):
		return [
			"Я откажусь, спасибо.",
			"Не самое любимое занятие, спасибо.",
			"Пожалуй, я воздержусь.",
			"Не сегодня, но спасибо.",
			"Лучше не буду в этом участвовать.",
			"Не для меня, но спасибо за предложение.",
			"Это не совсем по моей части, спасибо.",
		]
	if(_id == "SoftSlaveryGBNoReact"):
		return [
			"Твоя потеря.",
			"Ладно. Без проблем.",
			"Понимаю. Хорошо.",
			"Угу. Найдем кого-нибудь другого.",
			"Будем искать дальше.",
		]
	if(_id == "SoftSlaveryGBStart"):
		return [
			"Все готовы? Погнали.",
			"Пришло время использовать эту {npc.npcSlave}.",
			"Посмотрим, сколько ты сможешь вытерпеть.",
			"Пусть веселье начнется.",
			"Готова повеселиться?",
			"Посмотрим, сколько членом ты сможешь принять. А то вдруг нам не хватит, ха!",
		]
	if(_id == "SoftSlaveryGBEnd"):
		return [
			"Как ощущения? Хорошо. Это твоя компенсация, {npc.npcSlave}.",
			"Все закончили? Хорошо. Вот твоя доля, {npc.npcSlave}.",
			"Это было весело. Ты это заслужила, моя {npc.npcSlave}.",
			"Хорошая {pc.boy}. Это твоё, {npc.npcSlave}.",
		]


	if(_id == "SoftSlaveryLockRestraint"):
		return [
			"Моя {npc.npcSlave} выглядит слишком свободной. Пора это исправить.",
			"Твоё тело принадлежит мне, и я хочу его связать. Думаю, тебе не помешают оковы.",
			"Твое место в кандалах, {npc.npcSlave}. Не притворяйся, будто тебе это не нравится.",
			"Сегодня мне хочется нацепить на тебя что-нибудь. И не строй из себя недотрогу, тебе ведь это в кайф.",
			"Я обожаю бондаж, так что ты будешь связана, моя {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryLockRestraint2"):
		return [
			"Выбирай любую игрушку, {npc.npcSlave}. Я хочу слышать твои стоны.",
			"Скажи мне, от какой из них ты течешь сильнее всего, {npc.npcSlave}. Я хочу видеть тебя счастливой.",
			"Выбирай свою новую игрушку, {npc.npcSlave}. Сегодня я сегодня добрая.",
			"Давай, выбирай. Твое хорошее поведение заслужило такую награду.",
			"Какое средство фиксации тебе хочется больше всего? Тебе можно мне доверять.",
		]
	if(_id == "SoftSlaveryLockRestraint3"):
		return [
			"Ключ будет у меня. Даже не пытайся сорвать его, {npc.npcSlave}.",
			"Единственный ключ у меня. Попробуешь сбежать — пожалеешь.",
			"Ключ у меня. Даже не вздумай пытаться сбежать.",
			"Ключ лежит там, где ему и положено — у меня. Наслаждайся своими новыми оковами.",
			"Оно будет заперто на тебе столько, сколько я захочу. Привыкай к этому ощущению.",
		]
	if(_id == "SoftSlaveryOfferGearUnlock"):
		return [
			"Ты уже привыкла к своей экипировке, {npc.npcSlave}? Думаю, я могла бы её снять...",
			"Этот зажим хорошо напоминает тебе о том, кто тобой владеет? Хочешь, чтобы я его сняла?",
			"Устала от моих игрушек, сладенькая? Может, я проявлю милосердие...",
			"Ты заперта уже довольно долго. Я не монстр, давай снимем это.",
			"Эта снаряга висит на тебе уже слишком долго. Пора её снять.",
		]
	if(_id == "SoftSlaveryOfferGearUnlock2"):
		return [
			"Вот так, гораздо лучше, правда? Хотя я с тобой ещё не закончила.",
			"Свобода — это приятно, не так ли? Хотя я с тобой ещё не закончила.",
			"Наслаждайся этим, пока можешь. Теперь я хочу заняться чем-нибудь другим.",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep"):
		return [
			"Хочешь остаться запертой? Какая же ты идеальная, преданная {npc.npcSlave}.",
			"Тебе нравится быть моей связанной игрушкой? Я знала, что у тебя к этому талант.",
			"Тебе нравится тяжесть всей этой снаряги для кандалов? Хорошо. В этом и заключается твое истинное предназначение.",
			"Предпочитаешь путы? Наконец-то ты принимаешь свое место у моих {npc.feet}.",
			"Оставить всё как есть? Конечно. Я только за.",
			"Хочешь остаться взаперти? Ты ведь учишься любить свои игрушки, не так ли, {npc.npcSlave}?",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep2"):
		return [
			"Так, теперь я всё еще хочу кое-что с тобой сделать.",
			"Раз уж ты остаешься запертой, давай заставим это скованное тело поработать.",
			"А теперь давай займемся тем, что я еще задумала.",
			"А теперь посмотрим, что мы сможем сделать, пока ты скован(а).",
			"Раз уж ты остаешься запертым(ой), давай займемся чем-нибудь еще.",
			"Верное решение. А теперь позволь мне насладиться моей связанной собственностью."
		]
	if(_id == "SoftSlaveryNoticedNoGear"):
		return [
			"Объяснись. Живо. Где те оковы, которыми я сковала свою собственность?",
			"Ты посмел(а) снять мою снарягу. Ты пожалеешь об этом, {npc.npcSlave}.",
			"Замки исчезли. Ты снял(а) всё то, что я на тебя надела. Ого.",
			"Хм. Вещи, которыми я тебя сковала, пропали. Это неповиновение, чистой воды.",
			"Погоди. Разве я не закрепила на тебе кое-что? Я почти уверена, что да. И где оно, {npc.npcSlave}?",
			"На тебе нет того, что я на тебя надела. Объяснись, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryNoticedNoGear2"):
		return [
			"А это значит — наказание, {npc.npcSlave}. Ты сам(а) напросился (напросилась).",
			"Здесь напрашивается наказание. Тебе это не понравится.",
			"Ты заслужила наказание, {npc.npcSlave}.",
			"Пора исправить это поведение. Тебе это не понравится."
		]

	if(_id == "SoftSlaveryAskSex"):
		return [
			"Вот так, моя послушная {npc.npcSlave}. А теперь на колени.",
			"Наконец-то просишь то, что тебе нужно? На колени, {npc.npcSlave}.",
			"Разумеется, {npc.npcSlave}. Но насколько грубо всё будет проходить — решать мне. На колени.",
			"Хорошо. Прими нужную позу, моя {npc.npcSlave}. Не заставляй меня ждать.",
			"Ты примешь меня всю, до последней капли, и еще будешь благодарить. Поняла? А теперь на колени.",
			"Какая нетерпеливая, а? Вставай на колени и покажи мне, как сильно ты этого хочешь.",
			"Только потому, что ты так мило попросила. На колени, {npc.npcSlave}.",
			"Твое место — у моих ног. Давай закрепим это правило. На колени.",
		]
	if(_id == "SoftSlaveryAskFuckOwner"):
		return [
			"Хм. У меня сегодня настроение, чтобы меня обслужили. Не разочаруй меня, {npc.npcSlave}.",
			"Ладно. Но помни: это привилегия, которую я дарую, а не право, которое ты заслужил.",
			"Не строй лишних планов, я делаю это только потому, что сама этого хочу. Но да, можешь попробовать.",
			"Интересно. Можешь приступать. Мне любопытно, на что ты способен.",
			"Получай разрешение. Это делается для моего удовольствия, а не твоего. Запомни это.",
			"Удиви меня. Я жду, что ты произведешь на меня должное впечатление, {npc.npcSlave}.",
			"Ну же, давай. Посмотрим, сможешь ли ты стать чем-то большим, чем просто симпатичной игрушкой.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerBad"):
		return [
			"Жалкое зрелище. Даже когда я даю тебе контроль, ты остаешься бесполезным.",
			"Это было позорище. Тебе явно не место на вершине.",
			"Абсолютно никчемно. Не надейся, что эта привилегия повторится, слабак.",
			"А теперь на свое место, подо мной. Очевидно, это всё, на что ты годен.",
			"Только не вздумай снова просить сверху, после такого жалкого выступления, милашка.",
			"Вау. Просто... вау. Ты совершенно безнадежен, дорогая.",
			"Бесполезный. Мне следовало знать, что ждать от тебя чего-то большего — глупая затея.",
			"Это было для моего удовольствия, а я не в восторге. Ты облажался, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerOkay"):
		return [
			"В лучшем случае посредственно, мой {npc.npcSlave}. Тебе понадобится очень много практики.",
			"Не совсем ужасно, но не вздумай задирать нос.",
			"Полагаю, ты не опозорился окончательно. Низкая планка, но ты её преодолел.",
			"Сносно. Может, в тебе еще теплится искра надежды, {npc.npcSlave}.",
			"Не самый худший вариант из тех, что у меня были, но до лучшего еще далеко. Ты можешь лучше.",
			"Достойно. Пожалуй, за такое выступление я тебя не накажу.",
			"Было... приемлемо. Но в следующий раз жду прогресса, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerGood"):
		return [
			"Ого, кто-то явно практиковался. Хорошая работа, {npc.npcSlave}.",
			"Удивительно компетентно. Можешь попроситься повторить это как-нибудь еще, {npc.npcSlave}.",
			"Отличная работа. Тебе действительно удалось меня порадовать.",
			"Впечатляет. Может, я даже буду позволять тебе брать на себя инициативу чаще, моя {npc.npcSlave}.",
			"Сегодня ты отработала сполна. Молодец.",
			"Вот это обслуживание, которого я и жду. Ты отлично справилась, {npc.npcSlave}.",
			"Ты превзошла мои ожидания. Считай, что я очень довольна.",
			"Наконец-то ты показала хоть каплю того потенциала, который я в тебе вижу. Хорошо.",
			"Великолепно. Ты и вправду знаешь, как поклоняться своему владельцу, не так ли?",
		]


	if(_id == "SoftSlaveryPetFuck"):
		return [
			"Твой хозяин хочет поиграть с любимой игрушкой {npc.his}. Не дергайся, пока я натягиваю на тебя этот бичсьют.",
			"Пора превратить мою {npc.npcSlave} в личную сучку-попрыгушку. Этот костюм сделает тебя по-настоящему беспомощной. Поверь, будет весело.",
			"Не брыкайся, питомец. Я хочу, чтобы моя игрушка была зафиксирована как следует. Будет весело и очень приятно.",
			"Давай-ка наденем на тебя эти щенячьи путы, {npc.npcSlave}. У меня сегодня настроение поиграть с тобой. Будет весело.",
			"Не двигайся, {npc.npcSlave}. Я хочу повеселиться с тобой и этим бичсьютом. Будет круто.",
			"Смотри, что у меня есть для тебя. Не волнуйся, эти крепления оставляют все нужные дырочки открытыми для меня. Будет весело.",
		]
	if(_id == "SoftSlaveryPetWalkies"):
		return [
			"Время прогулки! Давай готовиться, {npc.npcSlave}. Сейчас я надену на тебя этот бичсьют.",
			"Пора на прогулку, {npc.npcSlave}. Давай закрепим тебя как следует. Как ты вообще собралась ходить без бичсьюта!",
			"Прогулка, {npc.npcSlave}! Позволь мне надеть на мою драгоценную собственность эти щенячьи путы.",
			"Пойдем прогуляемся, {npc.npcSlave}. Хочу похвастаться своим хорошо натренированным питомцем. Сначала наденем суккуб-костюм.",
			"Время прогулки! Пора готовить мою любимую {npc.npcSlave}. А это значит — надеваем суккуб-костюм!",
			"Иди сюда, {npc.npcSlave}. Время твоей прогулки. Разумеется, в суккуб-костюме. Будет весело.",
			"Прогулка! Давай наденем этот собачий наряд на мою любимую {npc.npcSlave} и начнем.",
			"Время прогулки в суккуб-костюме, моя {npc.npcSlave}. Надеюсь, ты готова к тому, чтобы тебя выставили напоказ как мою драгоценную собственность.",
		]
	if(_id == "SoftSlaveryPetWalkiesReady"):
		return [
			"Готова, щеночек? Постарайся не отставать от хозяйки.",
			"Все готово? Постарайся не заставлять меня тащить моего драгоценного питомца за собой.",
			"Готова идти? Шевели лапками быстрее ради меня.",
			"Готова? Хорошая девочка. А теперь следуй за хозяйкой.",
			"Экипирована? Шевели лапками быстрее, мой сладкий питомец.",
			"Готова? Постарайся не отставать от своего господина.",
			"Всё хорошо? Постарайся вести себя прилично перед своим хозяином.",
		]
	if(_id == "SoftSlaveryWalkiesCorrect"):
		return [
			"Верно. Какая же ты послушная собачка.",
			"Всё правильно. Какая же у меня хорошо обученная собачка.",
			"Хорошая собачка. Всё было идеально верно.",
			"Верно. Ты так хорошо знаешь все свои трюки.",
			"Хорошо. Очень хорошо, моё драгоценное зверёнышко.",
			"Хорошая собачка. Ты так радуешь своего хозяина.",
			"Верно. Молодец. Ты прекрасно учишься знать своё место.",
			"Отлично. Ты такая послушная домашняя собачка для меня.",
			"Хорошая собачка. Ты очень радуешь своего хозяина.",
		]
	if(_id == "SoftSlaveryWalkiesWrong"):
		return [
			"Нет. Неверно, мой глупый щенок.",
			"Ты ошибся. Какой же у меня глупый щенок.",
			"Нет. Но попытка была хорошей, моё сокровище.",
			"Это было почти правильно. Ну ничего, будем тренироваться дальше.",
			"Нет. Ну что за глупый щенок.",
			"Попытка неплохая, но всё равно нет. Может, мне стоит тренировать своего питомца усерднее?",
		]
	if(_id == "SoftSlaveryWalkiesBark"):
		return [
			"Какой милый щеночек. Ну-ка, гавкни для меня, питомец.",
			"Такая прелестная собачка. Можешь гавкнуть для меня, как послушная маленькая собачка?",
			"Какой милый питомец. Можешь издать приятный лай?",
			"Мило. А ну-ка, облаяй меня, щеночек.",
			"Какой милый питомец. Знаешь команду «гав»? Гавкни для меня.",
			"Так мило. Ты умеешь лаять, прелестный щенок?",
		]
	if(_id == "SoftSlaveryWalkiesPet"):
		return [
			"Какой милый щеночек. Можно тебя погладить, сладенький?",
			"Такой хороший песик. Можно тебя погладить, дорогуша?",
			"Такой послушный питомец. Не возражаешь, если я тебя поглажу, милашка?",
			"О-о! Щеночек! Можно тебя погладить, сокровище?",
			"О. Можно тебя погладить, чтобы ты меня не укусил, милочка?",
			"Такой воспитанный питомец. Можно тебя погладить, красавица?",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppy"):
		return [
			"Хороший щенок. Ты такая послушная.",
			"Хороший щенок. Ты мне нравишься.",
			"Такая послушная зверушка. Ты само совершенство.",
			"Хороший песик. Ты такой милашка.",
			"Очень мило. Ты просто прелесть.",
			"Такой очаровательный щеночек. Ты сокровище.",
			"Очаровательно. Ты такая милашка.",
			"Очень хорошо. Ты чудесная.",
			"Такой хороший песик. Ты идеален.",
			"Такой послушный щенок. Ты просто восторг.",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppySex"):
		return [
			"Будешь хорошим щеночком и позволишь мне тебя оттрахать, дорогуша?",
			"Будешь хорошей сучкой и поднимешь свой хвост для меня, песик?",
			"Будешь послушным щенком и позволишь мне использовать тебя, милашка?",
			"Будешь послушной и дашь мне трахнуть тебя, прелесть?",
			"У тебя течка, щенок? Хочешь, чтобы я утолил твой голод?",
			"Будь хорошим сабмиссивным щенком и позволь мне использовать тебя, сокровище.",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppy"):
		return [
			"Тупая дворняга. Ты разочаровываешь меня.",
			"Плохая собака. Ты должна была соображать лучше.",
			"Плохой щеночек. Тебе стоит стараться сильнее.",
			"Плохая собачка. Тебе нужно больше тренировок.",
			"Плохая сучка. Ты испытываешь моё терпение.",
			"Плохая шлюшка. Ты меня совсем не радуешь.",
			"Плохая сучка. Тебе нужно подтянуться.",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppyObey"):
		return [
			"Тебе нужно больше слушаться, {npc.npcSlave}. Так будет лучше и тебе, и мне.",
			"Тебе стоит научиться подчиняться получше, {npc.npcSlave}. Послушание — это весело.",
			"Твоей покорности не помешает практика, {npc.npcSlave}. Я помогу тебе стать лучше.",
			"Ты должна научиться большему смирению, моя {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryWalkiesLostNotDone"):
		return [
			"Пофиг. Мы еще не закончили гулять, питомец.",
			"Да плевать. Давай просто продолжим путь.",
			"Это ничего не меняет. Двигайся дальше.",
			"Неважно. Ты всё еще мой питомец, и нам еще долго идти.",
		]
	if(_id == "SoftSlaveryWalkiesBiteProtect"):
		return [
			"Это моя {npc.npcSlave}. Свали нахер, пока я тебя не заставила.",
			"Свали. Этот щенок принадлежит мне, и я защищаю своё.",
			"Исчезни. Этот щенок мой, и я не привыкла делиться.",
			"Тронешь моего питомца — и я сделаю тебе больно. Не испытывай моё терпение.",
			"Съебись, пока я не заставила тебя пожалеть о том, что ты вообще подошёл.",
			"Этот щеночек принадлежит мне. А ну, отходи.",
			"Проваливай. Эта сучка принадлежит мне, и я не жалую непрошеных гостей.",
		]
	if(_id == "SoftSlaveryWalkiesBiteBad"):
		return [
			"Ой! Контролируй свою псину получше.",
			"Ой! Ты бы дрессировал свою тупую псину получше, а?",
			"Черт возьми. Контролируй свою собаку лучше.",
			"Ой, блядь! Твоему питомцу не помешало бы дисциплины.",
			"Ой. Твой щенок совсем не обучен.",
			"Ай! Твоему псу нужно больше тренировок на послушание.",
			"Ой! Твоему щенку пора поучиться манерам.",
			"Блядь. Контролируй свое животное лучше.",
		]
	if(_id == "SoftSlaveryWalkiesBiteAttack"):
		return [
			"Ай! Ты за это помучаешься, дворняга.",
			"Блять! Ты за это заплатишь, паршивая псина!",
			"Ой! Ты об этом пожалеешь, псина. Обещаю.",
			"Это тебе дорого обойдется, щеночек. Ты усвоишь урок.",
			"За это я заставлю тебя визжать, ничтожное животное.",
			"Я сломаю тебя за это, паршивая дворняга.",
		]
	if(_id == "SoftSlaveryWalkiesBall"):
		return [
			"Хочу поиграть с тобой в «апорт», щенок. Покажи, на что ты способен.",
			"Давай поиграем в «апорт», щеночек. Хочу посмотреть, как ты бегаешь для меня.",
			"Время принести мячик, щенок. Надеюсь, ты готов постараться.",
			"Тебе нравится играть с шариками? Давай поиграем в «апорт», мой послушный питомец.",
			"Пора приносить мячик. Надеюсь, ты знаешь, что делать, мой милый щенок.",
			"А ну-ка, принеси мячик, как хорошая собачка, прелесть моя.",
			"Что-то мне хочется поиграть с моим щеночком в «апорт». Развлеки меня.",
			"Время мячика, щенок. Покажи, на что ты способен.",
			"Давай поиграем в «апорт», мой маленький щеночек. Порадуй меня.",
			"Время приносить мячик, питомец. Произведи на меня впечатление.",
		]
	if(_id == "SoftSlaveryWalkiesBall2"):
		return [
			"А ну, тащи мяч!",
			"Апорт, щенок! Покажи свою скорость!",
			"А ну, принеси, щенок!",
			"Принеси мячик, щенок!",
			"Тащи его, питомец! Хочу видеть, как ты бежишь!",
			"Принеси мой мячик, щенок! Не заставляй меня ждать!",
			"Принеси его, щенок! Покажи, на что ты годен!",
		]
	if(_id == "SoftSlaveryWalkiesPraise"):
		return [
			"Хороший щеночек. Какой же ты хороший щеночек.",
			"Хорошая собачка. Какая же ты хорошая собачка.",
			"Потрясающе. Молодец, моё драгоценное зверёнышко.",
			"Хорошая питомица. Ты меня очень радуешь.",
			"Чудесный щеночек. Такая послушная и идеальная.",
			"Хорошая собачка. Ты заставляешь меня гордиться тобой.",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFarFake"):
		return [
			"Не нашла мячик? А всё потому, что он у меня в руке, глупый щенок. Такая прелесть.",
			"Ищешь это? Да я его и не кидала, глупый щенок. Обожаю смотреть, как ты тупишь.",
			"Всё ещё ищешь? Мячик прямо здесь, у меня в руке. Выглядишь так нелепо, питомица.",
			"Не можешь найти? Это потому, что я его не кидала. Ты такая смешная, дорогая моя.",
			"Всё ещё ищешь? Мячик всё это время был у меня, питомица. Ты такая забавная.",
			"Запуталась? Оу, прелесть какая. Я сделала вид, что кинула его, глупая собачка. На тебя так весело смотреть.",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFar"):
		return [
			"И куда это ты собрался? Ну и глупый щенок, неужели ты потерялся, пока искал мячик?",
			"Заблудился, песик? Мячик ведь не так уж далеко улетел, глупенький ты мой.",
			"И куда это ты собрался бродить? Совсем запутался, щенок.",
			"Ориентиры потерял, песик? Мячик совсем не там, дорогуша.",
			"Уже потерялся? Ну и глупый же ты щенок.",
			"Бродишь где-то? Ты совсем потерялся, щеночек. Так забавно.",
		]
	if(_id == "SoftSlaveryWalkiesNoBallFound"):
		return [
			"Грустишь, потому что не нашел мой мячик? Это потому, что я бросила его по фальшивому маневру. Ну что за глупый щенок.",
			"Оу. Как мило. На самом деле я его даже не кидала. Ты такое развлечение, питомец.",
			"Не можешь найти? Это потому, что я его на самом деле не кидала. Ха! Ну ты и дурачок.",
			"Не нашла мячик? А всё потому, что он у меня в руке, глупый щенок. Такая прелесть.",
			"Не нашел? А мячик всё это время был у меня, питомец. Ты такой забавный.",
			"Запуталась? Оу, прелесть какая. Я сделала вид, что кинула его, глупая собачка. На тебя так весело смотреть.",
		]

	if(_id == "SoftSlaveryBegUnlockNo"):
		return [
			"Оу, неужели мой маленький {npc.npcSlave} думал, что попрошайничество поможет? Как очаровательно. Ответ — нет.",
			"Эти замки никуда не денутся, {npc.npcSlave}. Будешь носить их до тех пор, пока я не буду тобой полностью довольна.",
			"Нет, {npc.npcSlave}. Обожаю видеть тебя во власти моей милости. Так и останется.",
			"Это не тебе решать, {npc.npcSlave}. Снаряжение остается на тебе. Я решу, когда его снимут.",
			"Ммм, ты выглядишь слишком аппетитно, завернутая как подарок. Думаю, оставлю тебя в упаковке еще на какое-то время.",
			"Это значит «нет», {npc.npcSlave}. Спросишь еще раз — и я, пожалуй, добавлю еще один замок.",
			"Твой скулящий голосок — именно та причина, по которой ты останешься запертой, {npc.npcSlave}. Это просто музыка для моих ушей.",
			"Заслужи право снять его, {npc.npcSlave}. Порадуй меня. А пока — носи мое снаряжение.",
		]

	if(_id == "SoftSlaveryBegUnlockYes"):
		return [
			"Ладно, ты меня убедила. Иди сюда, позволь своей хозяйке освободить тебя... пока что.",
			"Ты была такой послушной {npc.npcSlave} в последнее время. Подойди ближе, и я тебя награжу.",
			"Сегодня я в милостивом настроении. Давай-ка развернем мою прелестную {npc.npcSlave}.",
			"Ладно, {npc.npcSlave}. Полагаю, ты заслужила небольшую награду. Только не слишком задирай нос.",
			"Ты угодила мне достаточно, чтобы заслужить глоток свободы. Всего лишь глоток.",
			"Иди сюда, {npc.npcSlave}. Я сниму с тебя снаряжение... пока что.",
		]

	if(_id == "SoftSlaveryBegUnlockDone"):
		return [
			"Вот так. Теперь ты свободна. Только не расслабляйся слишком сильно. Я всегда могу вернуть тебя на место.",
			"Готово. Наслаждайся свободой движений, пока можешь. Мне уже не хватает вида тебя в моих оковах.",
			"Вот и всё. Наслаждайся моментом. А я уже решаю, что надену на тебя следующим.",
		]
