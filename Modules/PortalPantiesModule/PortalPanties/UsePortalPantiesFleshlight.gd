extends SceneBase

var uniqueItemID = ""
var charactersWithPortalPanties = []
var cachedChars = false
var isRepeat = false

var portalCharID = ""
var selectedHole = "" #penis,vagina,anus
var extraText = ""

var secondPortalCharID = ""
var secondSelectedHole = ""

func _init():
	sceneID = "UsePortalPantiesFleshlight"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return portalCharID
	if(_charID == "npc2"):
		return secondPortalCharID

func charCanUsePenis(character):
	return character.canUsePenisThroughPortal()

func charCanUseVagina(character):
	return character.canUseVaginaThroughPortal()

func charCanUseAnus(character):
	return character.canUseAnusThroughPortal()

func sayCharacterTable():
	var tableText = "[table=5][cell]ID[/cell][cell]Имя[/cell][cell]Хуй[/cell][cell]Пизда[/cell][cell]Анус[/cell]"
	var ti = 1
	for character in charactersWithPortalPanties:
		tableText += "[cell]"+str(ti)+"[/cell]"
		tableText += "[cell]"+str(character.getName())+"[/cell]"
		if(character.isWearingChastityCage()):
			tableText += "[cell]Obstructed[/cell]"
		else:
			tableText += "[cell]"+("Yes" if charCanUsePenis(character) else "No")+"[/cell]"
		tableText += "[cell]"+("Yes" if charCanUseVagina(character) else "No")+"[/cell]"
		tableText += "[cell]"+("Yes" if charCanUseAnus(character) else "No")+"[/cell]"
		
		ti+=1
	tableText += "[/table]"
	saynn(tableText)

func _run():
	showFightUI = false
	if(!cachedChars):
		charactersWithPortalPanties = getNpcsWithPortalPanties()
		cachedChars = true
	
	if(state == ""):
		playAnimation(StageScene.SexPortal, "tease", {onlyRight=true})
		
		saynn("Вы активируете флешлайт и смотрите на его маленький экран.")
		
		saynn("Сканирование... Сканирование завершено. Найдено "+str(charactersWithPortalPanties.size())+" "+("entities" if charactersWithPortalPanties.size()!=1 else "entity")+" чел(а), носящих портальные трусики во всей галактике.")
		
		addButton("Отмена", "Вы передумали", "endthescene")
		
		if(charactersWithPortalPanties.size() > 0):
			sayCharacterTable()
			
			saynn("К кому вы хотите подключиться?")
			for character in charactersWithPortalPanties:
				if(character == null):
					continue
				addButton(str(character.getName()), "Подключиться к портальным трусикам этого человека", "connect_to", [character])
		else:
			saynn("Оу. Эта штука почти бесполезна, если никто не носит портальные трусики.")

	if(state == "connected"):
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		if(connectedChar != null):
			saynn("Подключено к портальным трусикам "+connectedChar.getName()+".")
		
		saynn("Через какой портал вы хотите открыться с помощью флешлайта?")
		
		addButton("Назад", "Проехали", "disconnectPortal")
		if(charCanUsePenis(connectedChar)):
			addButton("Пенис", "Показать их член", "openhole", ["penis"])
		if(charCanUseVagina(connectedChar)):
			addButton("Вагина", "Показать их киску", "openhole", ["vagina"])
		if(charCanUseAnus(connectedChar)):
			addButton("В анус", "Показать их анус", "openhole", ["anus"])

	if(state == "choose_vagina"):
		isRepeat = false
		extraText = ""
		playAnimation(StageScene.SexPortalOral, "tease", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)

		if(isPCPortal()):
			saynn("Флешлайт открывается, обнажая... твою {pc.vaginaStretch} киску. Ого, можно рассмотреть каждую деталь твоей собственной щелочки во всех подробностях.")
		else:
			saynn("Флешлайт открывается, обнажая чью-то {npc.vaginaStretch} {pussy}.")

		saynn("Что ты хочешь с ней сделать?")
		
		addButton("Закрыть", "Закрыть портал", "disconnectPortal")
		addButtonWithChecks("Полизать!", "Лизать киску", "vagina_lick", [], [[ButtonChecks.NotOralBlocked]])
		if(GM.pc.hasEffect(StatusEffect.HasCumInsideMouth)):
			addButtonWithChecks("Сплевать внутрь", "Сплевать всё, что у тебя во рту, прямо в эту киску", "vagina_lick_spit", [], [[ButtonChecks.NotOralBlocked], [ButtonChecks.ContentEnabled, ContentType.CumStealing]])
		else:
			addDisabledButton("Сплевать внутрь", "Во рту ничего нет")
		addButtonWithChecks("Да пошло оно!", "Возьми свой член и трахни это отверстие", "vagina_fuck", [], [[ButtonChecks.HasReachablePenis]])
		
	if(state == "vagina_lick"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, ("lick" if connectedChar.getArousal() <= 0.7 else "lickfast"), {onlyRight=isPCPortal(), npc=portalCharID, npcBodyState={}})
		
		if(!isRepeat):
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты осторожно прижимаешься губами к сладким складкам этой киски... и мгновенно чувствуешь их между своих ног. Такое странное ощущение... и всё же, от одной мысли о том, что ты лижешь саму себя, ты намокаешь за считанные секунды...",
					"Ты проводишь языком по чувствительным складкам... и чувствуешь, как это ощущение отзывается между твоих ног. Из твоих уст вырывается милый стон, а щель мгновенно становится влажной. Чувствовать своё теплое дыхание на своей киске — так странно...",
				]))
			else:
				saynn(RNG.pick([
					"Ты осторожно прижимаешься губами к сладким горячим складкам этой {npc.pussyStretch} киски... и чувствуешь, как она слегка подергивается в ответ. Это заставляет тебя жаждать лизать её еще сильнее, смакуя влагу.",
					"Ты проводишь кончиком языка по чувствительным складкам... и чувствуешь, как они становятся влажными. И тогда ты начинаешь лизать еще интенсивнее.",
				]))
		else:	
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты лижешь свою собственную {pussy}, смакуя свои соки и наблюдая за тем, как она сжимается.",
					"Ты просовываешь язык между складок и начинаешь языком трахать свою киску, вырывая из себя стоны.",
					"Вкус твоей мокрой, сочащейся {pussy} настолько хорош, что ты не можешь перестать её лизать.",
					"Ты на время сосредотачиваешься на клиторе, водя по нему языком влево и вправо. От этого ты начинаешь так сильно ерзать...",
					"Ты несколько раз тычешь в разрез киски, а затем начинаешь слизывать влагу со своих внутренних стенок, тихонько посапывая в процессе.",
				]))
			else:
				saynn(RNG.pick([
					"Ты так сладко лижешь эту {pussy}, пробуя сок на вкус и наблюдая, как она сжимается.",
					"Ты просовываешь язык между складок {npc.pussyStretch} и немного трахаешь эту киску языком, заставляя влажные внутренние стенки пульсировать.",
					"Лизать эту мокрую, сочащуюся {pussy} настолько весело, что ты просто не можешь остановиться.",
					"Ты на время сосредотачиваешься на клиторе, водя по нему языком влево и вправо. Пока ты это делаешь, вся {pussy} пульсирует.",
					"Ты несколько раз тычешь в разрез киски, а затем слизываешь влагу со внутренних стенок, тепло дыша на мокрые складки.",
				]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Эта киска сейчас кончит!")
			
			addButton("Глотай!", "Слизывай всё до последней капли", "vagina_lick_swallow")
		else:
			addButton("Лижи сильнее", "Вылизывай как следует", "vagina_lick")
		
		isRepeat = true
	
	if(state == "vagina_lick_swallow"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, "lick", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Твой собственный язык доводит тебя до самого края; волна наслаждения проносится сквозь тебя, заставляя стонать и извиваться, пока твоя {pussy} сжимается и извергает фонтан соков. Глотать собственную девичью сперму... так хорошо...",
				"Ты выгибаешь спину и страстно стонешь, пока твоя киска пульсирует, выбрасывая мощный поток прозрачной жидкости прямо тебе в рот. Ты не можешь перестать извиваться, вылизывая себя дочиста...",
			]))
		else:
			saynn(RNG.pick([
				"Ты чувствуешь, как киска сжимается и пульсирует, пока ты продолжаешь лизать и ласкать её. И вскоре она извергает фонтан соков, который ты тут же начинаешь жадно слизывать.",
				"Внезапно {pussy} начинает сильно пульсировать... а затем из него фонтаном брызжет прямо тебе на лицо и язык, и прозрачная жидкость стекает тебе в горло.",
			]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_vagina")

	if(state == "vagina_lick_spit"):
		playAnimation(StageScene.SexPortalOral, "lick", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Ты прижимаешься губами к своему {pussy}... а затем плюешь "+(extraText)+" прямо в него. Какая извращенная штучка...",
			]))
		else:
			saynn(RNG.pick([
				"Ты прижимаешься губами к этому {pussy}... а затем плюешь "+(extraText)+" прямо в него.",
			]))
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_vagina")








	if(state == "choose_anus"):
		isRepeat = false
		extraText = ""
		playAnimation(StageScene.SexPortalOral, "tease", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)

		if(isPCPortal()):
			saynn("Флешлайт открывается, обнажая твой {pc.analStretch} {asshole}. Ого, можно рассмотреть каждую деталь твоей собственной звезды во всех подробностях.")
		else:
			saynn("Флешлайт открывается, обнажая чьи-то {npc.analStretch} {asshole}.")

		saynn("Что ты хочешь с ней сделать?")
		
		addButton("Закрыть", "Закрыть портал", "disconnectPortal")
		addButtonWithChecks("Полизать!", "Оближи анус", "anus_lick", [], [[ButtonChecks.NotOralBlocked]])
		if(GM.pc.hasEffect(StatusEffect.HasCumInsideMouth)):
			addButtonWithChecks("Сплевать внутрь", "Сплюнь всё, что у тебя во рту, прямо в эту задницу", "anus_lick_spit", [], [[ButtonChecks.NotOralBlocked], [ButtonChecks.ContentEnabled, ContentType.CumStealing]])
		else:
			addDisabledButton("Сплевать внутрь", "Во рту ничего нет")
		addButtonWithChecks("Да пошло оно!", "Возьми свой член и трахни это отверстие", "anus_fuck", [], [[ButtonChecks.HasReachablePenis]])
		
	if(state == "anus_lick"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, ("lick" if connectedChar.getArousal() <= 0.7 else "lickfast"), {onlyRight=isPCPortal(), npc=portalCharID, npcBodyState={}})
		
		if(!isRepeat):
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты осторожно прижимаешься губами к сжатой «звездочке»... и мгновенно чувствуешь их на своем анусе. Такое странное ощущение... и всё же, мысль о том, чтобы пориммить саму себя, заводит тебя до чертиков.",
					"Ты проводишь кончиком языка по чувствительному сжатому сфинктеру... и чувствуешь, как это ощущение отзывается внутри тебя. У тебя вырывается милый стон. Чувствовать свое теплое дыхание на собственном анусе — так странно...",
				]))
			else:
				saynn(RNG.pick([
					"Ты осторожно прижимаешься губами к сжатой «звездочке» {npc.analStretch}... и чувствуешь, как она слегка дергается в ответ. И это заставляет тебя жаждать лизать её еще сильнее.",
					"Ты обводишь кончиком языка чувствительную «звездочку»... и чувствуешь, как она реагирует сжатием. И тогда ты начинаешь лизать её всё активнее.",
				]))
		else:	
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты лижешь свой собственный {asshole}, пробуя его на вкус и наблюдая за тем, как он сжимается.",
					"Ты засовываешь язык в свою {asshole} и начинаешь языком трахать саму себя, издавая стоны.",
					"Вкус твоей {pc.analStretch} {asshole} настолько хорош, что ты не можешь перестать её лизать.",
					"Ты тщательно вылизываешь свой анус. От этого ты начинаешь так сильно ерзать...",
					"Ты несколько раз тычешь языком в анус, а затем слизываешь влагу со внутренних стенок, тихонько посапывая.",
				]))
			else:
				saynn(RNG.pick([
					"Ты хорошенько вылизываешь эту {asshole}, пробуя её на вкус и наблюдая за тем, как она сжимается.",
					"Ты засовываешь язык в эту {npc.analStretch} и какое-то время трахаешь её языком, заставляя влажные внутренние стенки сжиматься.",
					"Лизать эту сжимающуюся {asshole} так весело, что ты просто не можешь остановиться.",
					"Ты тщательно вылизываешь эту {asshole}. Она пульсирует под твоим языком.",
					"Ты несколько раз тычешь языком в анус, а затем слизываешь влагу со стенок, обдавая чувствительную плоть теплым дыханием.",
				]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Эта жопа сейчас кончит!")
			
			addButton("Оргазм", "Смотреть, что будет дальше", "anus_lick_swallow")
		else:
			addButton("Лижи сильнее", "Вылизывай как следует", "anus_lick")
		
		isRepeat = true
	
	if(state == "anus_lick_swallow"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, "lick", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Твой собственный язык доводит тебя до грани; волна наслаждения проносится сквозь тебя, заставляя стонать и корчиться, пока твоя {asshole} сильно сжимается. Это так приятно...",
				"Ты выгибаешь спину и страстно стонешь, пока твоя {asshole} пульсирует и сжимается всё сильнее. Ты не можешь перестать извиваться, слизывая себя дочиста...",
			]))
		else:
			saynn(RNG.pick([
				"Ты чувствуешь, как {asshole} пульсирует и сжимается, пока ты продолжаешь лизать и тереть её... ",
				"Внезапно {asshole} начинает сильно пульсировать, а от оргазма она сжимается ещё мощнее.",
			]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_anus")

	if(state == "anus_lick_spit"):
		playAnimation(StageScene.SexPortalOral, "lick", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Ты прижимаешься губами к своей {asshole}... а затем пускаешь слюну. "+(extraText)+" прямо в него. Какая извращенная штучка...",
			]))
		else:
			saynn(RNG.pick([
				"Ты прижимаешься губами к этой {asshole}... а затем пускаешь слюну. "+(extraText)+" прямо в него.",
			]))
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_anus")









	if(state == "choose_penis"):
		isRepeat = false
		extraText = ""
		playAnimation(StageScene.SexPortalOral, "hold", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(isPCPortal()):
			saynn("Флешлайт открывается, обнажая твой {pc.penis}. Ого, можно рассмотреть каждую деталь твоего члена.")
		else:
			saynn("Флешлайт открывается, обнажая чьё-то {npc.penis}.")
		
		saynn("Что ты хочешь с ней сделать?")
		
		addButton("Закрыть", "Закрыть портал", "disconnectPortal")
		if(!connectedChar.isReadyToPenetrate()):
			addButton("Сделай его твердым", "Подготовь член к большему", "penis_make_hard")
		else:
			addButtonWithChecks("Соси!", "Соси этот член", "penis_suck", [], [[ButtonChecks.NotOralBlocked]])
			
			if(GM.pc.getInventory().getUniqueAmountOf("PortalPantiesFleshlight") >= 2):
				addButton("Прокси-трах", "Заставь этот член трахать чью-то другую дырку через другой флешлайт.", "penis_proxyfuck_choose")
			else:
				addDisabledButton("Прокси-трах", "Для этого тебе нужно 2 флешлайта")
			
			addButtonWithChecks("Скачи на нём", "Поставь этот флешлайт на пол и оседлай его!", "penis_ride_choose", [], [[ButtonChecks.HasReachableVaginaOrAnus]])
			addButtonWithChecks("Мастурбировать с помощью", "Мастурбировать этим членом", "penis_masturbate_choose", [], [[ButtonChecks.HasReachableVaginaOrAnus]])
			
	if(state == "penis_make_hard"):
		playAnimation(StageScene.SexPortalOral, "hold", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn("Ты обхватываешь этот член свободной рукой... и начинаешь его ласкать.")
			
			saynn("Да, ты мастурбируешь... но всё равно так странно видеть, как твой собственный член наливается твердостью прямо у тебя на глазах.")
			
			saynn("С твоих губ срываются тихие стоны. На кончике твоего члена поблескивает капля предэякулята. Должно хватить...")
		else:
			saynn("Ты обхватываешь этот член свободной рукой... и начинаешь его ласкать.")
			
			saynn("Тот, кому принадлежит этот член, вероятно, в полном замешательстве. И всё же, довольно скоро его член тоже начинает твердеть.")
			
			saynn("На кончике твоего члена блестит капля предэякулята. Должно хватить...")
			
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")

	if(state == "penis_masturbate_choose"):
		showFightUI = true
		
		playAnimation(StageScene.SexPortalMasturbation, "tease", {npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Куда ты хочешь засунуть этот член?")
		
		addButtonWithChecks("В киску", "Трахнуть киску этим членом", "penis_masturbate_vagina", [], [[ButtonChecks.HasReachableVagina]])
		addButtonWithChecks("В задницу", "Трахнуть жопу этим членом", "penis_masturbate_anus", [], [[ButtonChecks.HasReachableAnus]])
		addButton("Назад", "Проехали", "choose_penis")



	if(state == "penis_masturbate_vagina"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(!isRepeat):
			playAnimation(StageScene.SexPortalMasturbation, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты подносишь фаллоимитатор к заднице, а затем приставляешь его к своей {pc.vaginaStretch}... Вид того, как он подергивается и течет предэякулятом, касаясь твоих чувствительных мест, заставляет тебя хотеть вогнать его ещё быстрее... С твоих губ срывается стон, когда кончик раздвигает твои лепестки и скользит внутрь.",
				"Ты чувствуешь такую жажду, что не теряешь ни секунды и запихиваешь эту {npc.penis} прямо в свою киску! С твоих губ срывается милый стон, когда ты чувствуешь, как она раздвигает твои влажные внутренние стенки, наполняя их смазкой...",
			]))
		else:
			playAnimation(StageScene.SexPortalMasturbation, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты используешь эту {penis} как дилдо, вгоняя её в свою изголодавшуюся {pussy} и вынимая обратно.",
				"Ты выставляешь задницу, набивая свою {pussy} этим твердым куском мяса, а твои внутренние стенки сжимают его мертвой хваткой!",
				"Ты продолжаешь трахать свою влажную {pussy} этим членом, прикрывая рот рукой, чтобы заглушить стоны.",
				"Они, должно быть, извиваются так же сильно, как и ты; их {penis} дергается внутри твоей киски, пока ты мастурбируешь им!",
				"Ты используешь этот {penis} для своего удовольствия, вставляя его в свою {pussy}, словно какой-то секс-игрушку.",
			]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Внутрь!", "Заставь его кончить в себя", "penis_masturbate_vagina_inside")
		else:
			addButton("Скачи активнее", "Это так охеренно!", "penis_masturbate_vagina")
		
		isRepeat = true

	if(state == "penis_masturbate_vagina_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalMasturbation, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}, npcBodyState={hard=true}})
			
		saynn(RNG.pick([
			"Ты издаешь тихие стоны, когда этот {penis} начинает пульсировать внутри тебя, прежде чем извергнуть свою порцию прямо в твою матку! Твои ноги дрожат, а киска выжимает из этого ствола всё до последней капли.",
			"Ты продолжаешь вгонять этот член туда-сюда... пока он внезапно не начинает заливать твою {pussy} своим семенем! Столько, что часть его уже вытекает наружу. Ноги дрожат, а с губ срываются несколько милых стонов...",
		]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")


	if(state == "penis_masturbate_anus"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(!isRepeat):
			playAnimation(StageScene.SexPortalMasturbation, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты подносишь флешлайт к заднице и прижимаешь его к своей {pc.analStretch} {asshole}... Вид того, как он дергается и течет предэякулятом, касаясь твоих чувствительных мест, заставляет тебя всаживать его еще быстрее... С губ срывается стон, когда кончик раздвигает твою ануску и скользит внутрь.",
				"Ты чувствуешь такую жажду, что не теряешь ни секунды и запихиваешь этот {npc.penis} себе в задницу! С твоих губ срывается милый стон, когда ты чувствуешь, как он раздвигает твои теплые внутренние стенки и наполняет их предэякулятом...",
			]))
		else:
			playAnimation(StageScene.SexPortalMasturbation, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты используешь этот {penis} как дилдо, вгоняя его в свою изголодавшуюся {asshole} и вынимая обратно.",
				"Ты выставляешь задницу, набивая свою {asshole} этим твердым куском мяса, а твои внутренние стенки сжимают его мертвой хваткой!",
				"Ты продолжаешь трахать свой {ass} этим членом, прикрывая рот рукой, чтобы заглушить стоны.",
				"Они, должно быть, извиваются не меньше тебя — их {penis} дергается внутри твоего ануса, пока ты мастурбируешь им!",
				"Ты используешь этот {penis} для своего удовольствия, скользя им внутрь своей {ass}, словно какой-то секс-игрушкой.",
			]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Внутрь!", "Заставь его кончить в себя", "penis_masturbate_anus_inside")
		else:
			addButton("Скачи активнее", "Это так охеренно!", "penis_masturbate_anus")
		
		isRepeat = true

	if(state == "penis_masturbate_anus_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalMasturbation, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}, npcBodyState={hard=true}})
			
		saynn(RNG.pick([
			"Ты издаешь тихие стоны, когда этот {penis} начинает пульсировать внутри, прежде чем извергнуть свой заряд прямо тебе в задницу! Твои ноги дрожат, пока твоя {asshole} выжимает из этого ствола всё до последней капли.",
			"Ты продолжаешь вгонять этот член то в себя, то обратно... пока он внезапно не начинает заливать твою {ass} своим семенем! Так много, что часть его уже начинает вытекать наружу. Твои ноги дрожат, а с губ срываются милые стоны...",
		]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")



	if(state == "penis_ride_choose"):
		showFightUI = true
		
		playAnimation(StageScene.SexPortalRide, "tease", {npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Как именно ты хочешь на нем оседлать?")
		
		addButtonWithChecks("В киску", "Оседлать его член своей киской", "penis_ride_vagina", [], [[ButtonChecks.HasReachableVagina]])
		addButtonWithChecks("В задницу", "Оседлать его член своей жопой", "penis_ride_anus", [], [[ButtonChecks.HasReachableAnus]])
		addButton("Назад", "Проехали", "choose_penis")

	if(state == "penis_ride_vagina"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(!isRepeat):
			playAnimation(StageScene.SexPortalRide, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты кладешь на пол фаллоимитатор с чьим-то {npc.penis}, а затем устраиваешься над ним. Одной рукой ты направляешь его в свою {pc.vaginaStretch} {pussy}, медленно опускаясь на него. С твоих губ срывается милый звук, когда ты чувствуешь, как он раздвигает твои лепестки и скользит внутрь твоего влажного любовного туннеля... Пора оседлать его...",
				"Ты кладешь на пол фаллоимитатор с чьим-то {npc.penis}, а затем устраиваешься над ним. Твоя {pc.vaginaStretch} {pussy} уже совсем мокрая, пока ты опускаешься на этот ствол; его головка раздвигает твои лепестки и скользит внутрь, задевая стенки влагалища и вырывая у тебя тихий стон... Пора оседлать его...",
			]))
		else:
			playAnimation(StageScene.SexPortalRide, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты скачешь на этом твердом {penis}, приподнимая тело, а затем с силой опускаешься на него; твоя {pussy} сжимается, когда большая часть его входит внутрь.",
				"Твои {pc.breasts} слегка подпрыгивают, пока ты скачешь на этом {npc.penis}. Он такой... теплый и скользкий... лучше любой игрушки.",
				"Ты чувствуешь, как их {npc.penis} дергается внутри тебя... и от этого ты скачешь еще сильнее. Ты не планируешь останавливаться, пока не выдоишь эти яички досуха.",
				"Этот {penis} так идеально попадает в твою точку G, что с каждым движением, пока ты скачешь на нем, из тебя вырывается всё больше и больше стонов.",
				"Они, должно быть, в полном замешательстве от того, почему их {penis} внезапно сжимается твоей киской... хорошо... Твоя сочащаяся киска покрывает его своими соками, пока ты скачешь на нем.",
				"Ты скачешь на этом {penis} так, будто это просто дилдо, просто предмет для самоудовлетворения... Но это куда лучше любого дилдо.",
			]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Внутрь!", "Заставь его кончить в себя", "penis_ride_vagina_inside")
		else:
			addButton("Скачи активнее", "Это так охеренно!", "penis_ride_vagina")
		
		isRepeat = true

	if(state == "penis_ride_vagina_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalRide, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}, npcBodyState={hard=true}})
			
		saynn(RNG.pick([
			"Их {npc.penis} пульсирует и бьется внутри тебя... А ты просто продолжаешь скакать. И вскоре ты чувствуешь, как твоя {pussy} наполняется волнами липкой {npc.cum}, а матка забивается до отказа. Хорошо...",
			"Ты была так занята тем, что скакала на этом {npc.penis}, что даже не заметила, как он начал пульсировать и кончать тебе в {pussy}! Волна за волной липкого горячего семени наполняет тебя... пока ты стонешь и извиваешься на нем.",
		]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")



	if(state == "penis_ride_anus"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(!isRepeat):
			playAnimation(StageScene.SexPortalRide, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты кладешь флешлайт с чьим-то {npc.penis} на пол и устраиваешься над ним. Одной рукой ты направляешь его в свою {pc.anusStretch} {anus}, медленно опускаясь на него. С твоих губ срывается милый звук, когда ты чувствуешь, как он раздвигает твою дырочку и скользит внутрь твоего жаждущего любовного туннеля... Пора скакать...",
				"Ты кладешь на пол флешлайт с чьим-то {npc.penis}, а затем устраиваешься над ним. Твоя {pc.anusStretch} {anus} уже вовсю требует ласки, когда ты опускаешься на этот ствол; его головка растягивает твой анус и скользит внутрь, задевая стенки влагалища и вырывая у тебя тихий стон... Пора оседлать его...",
			]))
		else:
			playAnimation(StageScene.SexPortalRide, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}})
			
			saynn(RNG.pick([
				"Ты скачешь на этом жестком {penis}, приподнимаясь всем телом, а затем с силой опускаешься на него, чувствуя, как твоя {asshole} сжимается, когда он входит почти целиком.",
				"Твои {pc.breasts} слегка подпрыгивают, пока ты скачешь на этом {npc.penis}. Он такой... теплый и скользкий... лучше любой игрушки.",
				"Ты чувствуешь, как их {npc.penis} дергается внутри тебя... и от этого ты скачешь еще сильнее. Ты не планируешь останавливаться, пока не выдоишь эти яички досуха.",
				"Этот {penis} так точно попадает в твою чувствительную точку, что, пока ты скачешь на нем, из тебя вырывается всё больше и больше стонов.",
				"Они, должно быть, в полном замешательстве от того, почему их {penis} внезапно оказался зажат в твоей заднице... хорошо... Твои ноги слегка дрожат во время езды, а по всему телу разливается приятное тепло.",
				"Ты скачешь на этом {penis} так, будто это просто дилдо, просто предмет для самоудовлетворения... Но это куда лучше любого дилдо.",
			]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Внутрь!", "Заставь его кончить в себя", "penis_ride_anus_inside")
		else:
			addButton("Скачи активнее", "Это так охеренно!", "penis_ride_anus")
		
		isRepeat = true

	if(state == "penis_ride_anus_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalRide, ("inside"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={exposedCrotch=true, hard=true}, npcBodyState={hard=true}})
			
		saynn(RNG.pick([
			"Их {npc.penis} пульсирует и бьется внутри тебя... пока ты продолжаешь ритмично двигаться. И вскоре ты чувствуешь, как твоя {ass} заливает волнами липкой {npc.cum}, окрашивающей твои внутренние стенки в белый цвет. Хорошо...",
			"Ты так увлеклась ездой на этом {npc.penis}, что даже не заметила, как он начал пульсировать и кончать прямо в твою {ass}! Волна за волной липкое горячее семя наполняет тебя, пока ты стонешь и извиваешься сверху.",
		]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")




	if(state == "penis_suck"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, ("suck" if connectedChar.getArousal() <= 0.7 else "suckfast"), {onlyRight=isPCPortal(), npc=portalCharID, npcBodyState={hard=true}})
		
		if(!isRepeat):
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты обхватываешь губами кончик этого вкусного члена... и тут же чувствуешь его вокруг своего члена. Так странно... и в то же время... так приятно.",
					"Ты слизываешь капельку с этого члена... и тут же чувствуешь это сама. Так необычно... Ты позволяешь кончику своего собственного достоинства войти в рот и начинаешь его сосать.",
				]))
			else:
				saynn(RNG.pick([
					"Ты обхватываешь губами кончик этого вкусного члена... и чувствуешь, как он слегка пульсирует у тебя во рту. Хм, это только заставляет тебя хотеть сосать его еще сильнее.",
					"Ты слизываешь капельку с этого члена и наблюдаешь, как он слегка дергается. Как интересно. Ты позволяешь кончику этого органа войти внутрь и начинаешь его сосать.",
				]))
		else:	
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты сосешь собственный {cock} через портальные трусики!",
					"Ты продолжаешь сосать, ведь ты точно знаешь, как доставить себе удовольствие...",
					"Ты проводишь языком по этому {cock} и вздрагиваешь от ощущений.",
					"Вкус не такой уж плохой, можно было бы сосать собственный {cock} целыми днями...",
					"Ты дрочишь на саму себя, подстраивая движения головы под движения руки.",
				]))
			else:
				saynn(RNG.pick([
					"Ты сосёшь этот {npc.penis} через портальные трусики!",
					"Ты продолжаешь сосать этот {cock}, чувствуя, как он подёргивается у тебя во рту.",
					"Ты проводишь языком по этому {cock} и нежно чмокаешь кончик... прежде чем продолжить жадно сосать его.",
					"Трудно сказать, нравится ли им это... но вкус {npc.his} во рту намекает на то, что да.",
					"Ты оттягиваешь этот {cock}, двигая головой в такт движениям своей руки.",
				]))
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Глотай!", "Сглотать эту порцию", "penis_suck_swallow")
		else:
			addButton("Сосать сильнее", "По-настоящему отыметь этот член ртом", "penis_suck")
		
		isRepeat = true
	
	if(state == "penis_suck_swallow"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortalOral, "hold", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Ты издаёшь приглушённое мычание и стоны, пока твой собственный {pc.penis} пульсирует у тебя во рту, выбрасывая {pc.cum} глубоко в глотку... как же хорошо...",
				"Ты заталкиваешь свой {cock} так глубоко, как позволяет твоя {pc.throatStretch} глотка, и корчишься, пока он пульсирует, наполняя твой живот собственной семенной жидкостью.",
			]))
		else:
			saynn(RNG.pick([
				"Ты чувствуешь, как этот {npc.penis} пульсирует у тебя во рту... прежде чем он выбрасывает струи густой {npc.cum} глубоко в твою глотку...",
				"Ты заталкиваешь этот {npc.penis} так глубоко, как позволяет твоя {pc.throatStretch} глотка, и просто замираешь, позволяя ему пульсировать внутри и наполнять твой живот густой теплой спермой.",
			]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")
	
	if(state == "penis_proxyfuck_choose"):
		saynn("С кем ты хочешь трахнуться этим членом, который держишь в руках?")
		addButton("Назад", "Вы передумали", "choose_penis")
		
		sayCharacterTable()
		
		for character in charactersWithPortalPanties:
			if(character == null):
				continue
			addButton(str(character.getName()), "Трахнуть этого человека через прокси!", "penis_proxyfuck_secondchoose", [character])

	if(state == "penis_proxyfuck_choose_hole"):
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			playAnimation(StageScene.SexPortalProxy, "tease", {onlyRight=true})
		else:
			playAnimation(StageScene.SexPortalProxy, "tease", {onlyRight=(secondPortalCharID=="pc"), npc=secondPortalCharID, npc2=portalCharID})
		
		var connectedChar = GlobalRegistry.getCharacter(secondPortalCharID)
		if(connectedChar != null):
			saynn("Второй флешлайт подключен к "+connectedChar.getName()+".")
		
		saynn("Через какой портал вы хотите открыться с помощью флешлайта?")
		
		addButton("Назад", "Проехали", "disconnectPortal")
		if(charCanUseVagina(connectedChar)):
			addButton("Вагина", "Использовать член, чтобы трахнуть их киску", "penis_proxyfuck_vagina", ["vagina"])
		if(charCanUseAnus(connectedChar)):
			addButton("В анус", "Используй член, чтобы трахать их анус", "penis_proxyfuck_anus", ["anus"])

	if(state == "penis_proxyfuck_vagina"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		#var subConnectedChar = GlobalRegistry.getCharacter(secondPortalCharID)
		
		var animName = ("sex" if connectedChar.getArousal() <= 0.7 else "fast")
		if(!isRepeat):
			animName = "inside"
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			playAnimation(StageScene.SexPortalProxy, animName, {onlyRight=true})
		else:
			playAnimation(StageScene.SexPortalProxy, animName, {onlyRight=(secondPortalCharID=="pc"), npc=secondPortalCharID, npc2=portalCharID})
		
		if(!isRepeat):
			if(secondPortalCharID == "pc" && portalCharID == "pc"):
				# You fuck yourself
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя свой собственный {penis} проникать в твою собственную киску... из тебя вырываются стоны, когда влажные внутренние стенки сжимаются вокруг твоего члена...",
				]))
			elif(secondPortalCharID == "pc"):
				# You are being fucked
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чьё-то {penis} проникать в твою киску... Из твоих уст вырываются стоны, когда влажные внутренние стенки сжимаются вокруг этого твердого члена...",
				]))
			elif(isPCPortal()):
				# You fuck someone else
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, и твой {penis} с легкостью проникает в чью-то {pussy}! Будем надеяться, они готовы, потому что ты не планируешь на этом останавливаться...",
				]))
			elif(secondPortalCharID == portalCharID):
				# Someone else fucks themselves
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чьё-то {penis} входить в их собственную {pussy}! Надеюсь, они готовы, потому что ты заставишь их трахать самих себя!",
				]))
			else:
				# 2 different npcs fuck
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чьё-то {penis} проникать в чью-то другую {pussy}! Надеюсь, они оба готовы, потому что ты не планируешь на этом останавливаться...",
				]))
		else:	
			if(secondPortalCharID == "pc" && portalCharID == "pc"):
				# You fuck yourself
				saynn(RNG.pick([
					"Ты двигаешь фаллоимитаторы друг о друга, стоная от того, как твой собственный {penis} трахает твою {npc2.vaginaStretch} {pussy}!",
					"Твое тело извивается... пока ты трахаешь саму себя самым странным из возможных способов.",
					"Ты слышишь, как твоя киска издает влажные звуки, когда ты вгоняешь свой собственный {penis} туда-сюда... Это так приятно.",
					"Каждый раз, когда ты скользишь фаллоимитатором со своим {pussy} вдоль своей собственной {penis}, он раздвигает твои влажные внутренние стенки и долбит прямо в точку G... Ты точно знаешь, как доставить себе удовольствие.",
					"Ты неистово хуяришь свой {pussy} своим {pc.penis}, быстро и жестко! На животе проступает небольшой бугорок, когда твой {penis} каждый раз достигает шейки матки.",
				]))
			elif(secondPortalCharID == "pc"):
				# You are being fucked
				saynn(RNG.pick([
					"Ты трешь фаллоимитаторы друг о друга, стоная от того, как чьё-то {penis} трахает твою {npc2.vaginaStretch} {pussy}!",
					"Твое тело извивается... пока ты позволяешь кому-то трахать себя самым странным из возможных способов.",
					"Ты слышишь, как твоя киска хлюпает, когда ты всаживаешь чьё-то {penis} туда-сюда... Чертовски приятно.",
					"Каждый раз, когда ты скользишь фаллоимитатором со своим {pussy} вдоль этой {penis}, он раздвигает твои влажные внутренние стенки и долбит прямо в точку G... Ты точно знаешь, как доставить себе удовольствие.",
					"Ты хуяришь свой {pussy} чьим-то {npc.penis} быстро и жестко, словно это дилдо! На животе проступает небольшой бугорок, когда этот {penis} каждый раз достигает шейки матки.",
				]))
			elif(isPCPortal()):
				# You fuck someone else
				saynn(RNG.pick([
					"Ты трешь фаллоимитаторы друг о друга, тихонько дыша от возбуждения, пока твой {penis} трахает чью-то {npc2.vaginaStretch} {pussy}!",
					"Твое тело слегка извивается... пока ты трахаешь кого-то самым странным из возможных способов.",
					"Ты слышишь, как этот {pussy} издает влажные звуки, когда ты всаживаешь свой {penis} туда-сюда... Да, получи, сучка.",
					"Каждый раз, когда ты скользишь флешлайтом с этим {pussy} по их {penis}, его влажные внутренние стенки раздвигаются, а он наотмашь долбит прямо в точку G... От этого киска кажется такой узкой...",
					"Ты херачишь этим {pussy} своим {npc.penis} быстро и жестко; когда твой член отделен от тела, трахать кого-то становится намного проще!",
				]))
			elif(secondPortalCharID == portalCharID):
				# Someone else fucks themselves
				saynn(RNG.pick([
					"Ты двигаешь флешлайты друг против друга, так что получается, будто чья-то {penis} трахает собственную {npc2.vaginaStretch} {pussy}!",
					"Твои глаза с огромным интересом наблюдают за тем, как ты заставляешь кого-то трахать самого себя самым странным образом из возможных.",
					"Ты слышишь, как эта киска издает влажные звуки, пока ты вгоняешь их собственный {penis} туда-сюда... Должно быть, им чертовски приятно, ведь это же двойная стимуляция.",
					"Каждый раз, когда ты скользишь флешлайтом с чьим-то {pussy} по их {penis}, его влажные внутренние стенки раздвигаются, а он наотмашь долбит прямо в точку G... Ты видишь, как подергиваются мышцы, потому что наблюдаешь за процессом так близко.",
					"Ты херачишь чьим-то {pussy} их собственным {npc.penis} быстро и жестко! Эта киска заливает соками весь второй флешлайт.",
				]))
			else:
				# 2 different npcs fuck
				saynn(RNG.pick([
					"Ты трешь фаллоимитаторы друг о друга так, будто чья-то {penis} трахает эту {npc2.vaginaStretch} {pussy}! Они, вероятно, даже не подозревают, что ты заставляешь их трахать друг друга.",
					"Твои глаза с огромным интересом наблюдают за тем, как ты заставляешь одного человека трахать другого самым странным способом из возможных.",
					"Ты слышишь, как эта киска издает влажные звуки, пока ты вгоняешь чью-то {penis} туда-сюда... Странно видеть, как фаллоимитатор работает как настоящий... но в этом есть свое удовольствие.",
					"Каждый раз, когда ты скользишь фаллоимитатором с чьей-то {pussy} по чьей-то другой {penis}, это раздвигает их влажные внутренние стенки и долбит прямо в точку G... Ты видишь, как подергиваются мышцы, потому что наблюдаешь за процессом так близко.",
					"Ты быстро и жестко вколачиваешь чью-то {pussy} в чужую {npc.penis}! Эта киска заливает соками весь другой фаллоимитатор.",
				]))
			
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Оргазм", "Посмотреть, что будет", "penis_proxyfuck_vagina_orgasm")
		else:
			addButton("Еще", "Это заставляет игрушки тереться друг о друга", "penis_proxyfuck_vagina")
		
		isRepeat = true

	if(state == "penis_proxyfuck_vagina_orgasm"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			playAnimation(StageScene.SexPortalProxy, "inside", {onlyRight=true})
		else:
			playAnimation(StageScene.SexPortalProxy, "inside", {onlyRight=(secondPortalCharID=="pc"), npc=secondPortalCharID, npc2=portalCharID})
	
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			# You fuck yourself
			saynn(RNG.pick([
				"Ты издаешь сдавленные страстные звуки, когда твоя {npc.penis} пульсирует внутри твоей {pussy}... прежде чем наполнить свою утробу до краев своей семенной жидкостью. Ты поджимаешь пальцы ног и много ерзаешь, твои руки дрожат, заставляя твой член еще сильнее тереться о стенки твоей киски...",
			]))
		elif(secondPortalCharID == "pc"):
			# You are being fucked
			saynn(RNG.pick([
				"Ты издаешь сдавленные страстные стоны, когда чьё-то {npc.penis} пульсирует внутри твоей {pussy}... а затем наполняет твою матку до краев своей семенной жидкостью. Ты поджимаешь пальцы ног и сильно ерзаешь, а твои руки дрожат, заставляя этот член еще сильнее тереться о стенки твоей киски...",
			]))
		elif(isPCPortal()):
			# You fuck someone else
			saynn(RNG.pick([
				"Ты тихо кряхтишь, когда чьё-то {npc.penis} пульсирует внутри этой сжимающейся {pussy}... прежде чем наполнить её матку до краев твоей семенной жидкостью. Дистанционное оплодотворение, черт возьми!",
			]))
		elif(secondPortalCharID == portalCharID):
			# Someone else fucks themselves
			saynn(RNG.pick([
				"Ты не можешь сдержать улыбку, наблюдая, как пульсирующий {npc.penis} кончает внутри {pussy}, принадлежащей тому же самому человеку. Что, если ты просто заставишь их забеременеть друг от друга?",
			]))
		else:
			# 2 different npcs fuck
			saynn(RNG.pick([
				"Ты невольно улыбаешься, глядя, как пульсирующий {npc.penis} кончает внутри беспомощно дергающейся {pussy}. Ты только что заставила двух совершенно незнакомых людей размножаться. Красава.",
			]))
	
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")




	if(state == "penis_proxyfuck_anus"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		#var subConnectedChar = GlobalRegistry.getCharacter(secondPortalCharID)
		
		var animName = ("sex" if connectedChar.getArousal() <= 0.7 else "fast")
		if(!isRepeat):
			animName = "inside"
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			playAnimation(StageScene.SexPortalProxy, animName, {onlyRight=true})
		else:
			playAnimation(StageScene.SexPortalProxy, animName, {onlyRight=(secondPortalCharID=="pc"), npc=secondPortalCharID, npc2=portalCharID})
		
		if(!isRepeat):
			if(secondPortalCharID == "pc" && portalCharID == "pc"):
				# You fuck yourself
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя собственный {penis} проникать в твою собственную {anus}... Из тебя вырываются стоны, когда твои влажные внутренние стенки сжимаются вокруг твоего члена...",
				]))
			elif(secondPortalCharID == "pc"):
				# You are being fucked
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чьё-то {penis} проникать в твою задницу... Из тебя вырываются стоны, когда твои жаждущие внутренние стенки сжимаются вокруг этого твердого члена...",
				]))
			elif(isPCPortal()):
				# You fuck someone else
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, и твой {penis} с легкостью проникает в чью-то {anus}! Будем надеяться, они готовы, потому что останавливаться ты не собираешься...",
				]))
			elif(secondPortalCharID == portalCharID):
				# Someone else fucks themselves
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чью-то {penis} зайти в их собственную {ass}! Надеюсь, они готовы, ведь ты заставишь их трахать самих себя!",
				]))
			else:
				# 2 different npcs fuck
				saynn(RNG.pick([
					"Ты прижимаешь фаллоимитаторы друг к другу, заставляя чью-то {penis} проникать в чью-то еще {anus}! Надеюсь, оба готовы, потому что ты не планируешь на этом останавливаться...",
				]))
		else:	
			if(secondPortalCharID == "pc" && portalCharID == "pc"):
				# You fuck yourself
				saynn(RNG.pick([
					"Ты трешь фаллоимитаторы друг о друга, стоная от того, как твоя собственная {penis} трахает твою {npc2.anusStretch} {anus}!",
					"Твое тело извивается... пока ты трахаешь саму себя самым странным из возможных способов.",
					"Ты слышишь влажные звуки своей {anus}, когда вгоняешь и вынимаешь свою {penis}... Это так охрененно.",
					"Каждый раз, когда ты скользишь фаллоимитатором со своей {anus} вдоль своей {penis}, он широко раздвигает твои влажные внутренние стенки и долбит прямо в простату... Ты точно знаешь, как доставить себе удовольствие.",
					"Ты неистово и быстро хуяришь свою {anus} своей {npc.penis}! На животе появляется небольшая выпуклость, когда твоя {penis} заходит глубоко и давит на внутренние стенки.",
				]))
			elif(secondPortalCharID == "pc"):
				# You are being fucked
				saynn(RNG.pick([
					"Ты трешь фаллоимитаторы друг о друга, стоная от того, как чья-то {penis} трахает твою {npc2.anusStretch} {anus}!",
					"Твое тело извивается... пока ты позволяешь кому-то трахать себя самым странным из возможных способов.",
					"Ты слышишь, как твоя {anus} издает влажные звуки, пока ты вгоняешь чью-то {penis} туда и обратно... Чертовски приятно.",
					"Каждый раз, когда ты скользишь флешлайтом со своей {anus} вдоль этой {penis}, она раздвигает влажные внутренние стенки и долбит прямо в твою эрогенную зону... Ты точно знаешь, как доставить себе удовольствие.",
					"Ты херачишь своей {anus} чьей-то {npc.penis} быстро и жестко, словно это дилдо! На твоем животе проступает небольшой бугорок, когда эта {penis} проникает глубоко и давит на все твои чувствительные точки.",
				]))
			elif(isPCPortal()):
				# You fuck someone else
				saynn(RNG.pick([
					"Ты трешь флешлайты друг о друга, тихонько пошатывая дыханием, пока твоя {penis} трахает чью-то {npc2.anusStretch} {anus}!",
					"Твое тело слегка извивается... пока ты трахаешь кого-то самым странным из возможных способов.",
					"Ты слышишь, как эта {anus} издает влажные звуки, пока ты вгоняешь свою {penis} туда и обратно... Да, получи, сучка.",
					"Каждый раз, когда ты скользишь флешлайтом с этой {anus} вдоль их {penis}, она раздвигает их влажные внутренние стенки и долбит по всем их кнопкам... От этого задница кажется такой узкой...",
					"Ты херачишь этой {anus} своей {npc.penis} быстро и жестко; когда твой член отсоединен от тела, трахать кого-то становится намного проще!",
				]))
			elif(secondPortalCharID == portalCharID):
				# Someone else fucks themselves
				saynn(RNG.pick([
					"Ты трешь флешлайты друг о друга, создавая иллюзию, будто чья-то {penis} трахает их собственную {npc2.anusStretch} {anus}!",
					"Твои глаза с огромным интересом наблюдают за тем, как ты заставляешь кого-то трахать самого себя самым странным образом из возможных.",
					"Ты слышишь, как эта {anus} издает влажные звуки, пока ты заталкиваешь их собственный {penis} внутрь и обратно... Должно быть, им приятно, ведь это же двойная стимуляция.",
					"Каждый раз, когда ты проводишь флешлайтом с чьим-то {anus} вдоль их {penis}, он раздвигает влажные внутренние стенки и долбит прямо в простату... Ты видишь, как подергиваются мышцы, ведь ты наблюдаешь за процессом так близко.",
					"Ты херачишь чьим-то {anus} через их собственный {npc.penis} — быстро и жестко! Эта сучка сжимается вокруг собственного члена!",
				]))
			else:
				# 2 different npcs fuck
				saynn(RNG.pick([
					"Ты трешь флешлайты друг о друга так, что чей-то {penis} буквально трахает этот {npc2.anusStretch} {anus}! Они, вероятно, даже не осознают, что это ты заставляешь их трахать друг друга.",
					"Твои глаза с огромным интересом наблюдают за тем, как ты заставляешь одного человека трахать другого самым странным способом из возможных.",
					"Ты слышишь, как эта {anus} издает влажные звуки, пока ты вгоняешь чьё-то {penis} туда-сюда... Странно видеть, как флешлайт работает как настоящий... но это чертовски весело.",
					"Каждый раз, когда ты скользишь флешлайтом с чьим-то {anus} вдоль чьего-то {penis}, он раздвигает влажные внутренние стенки и долбит по всем эрогенным точкам... Ты видишь, как подергиваются мышцы, ведь ты наблюдаешь за процессом так близко.",
					"Ты со всей дури вколачиваешь чью-то {anus} в чужую {npc.penis}! Эта шлюха так и сжимает вокруг чужого члена!",
				]))
			
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(connectedChar.getArousal() >= 1.0):
			saynn("Этот член сейчас кончит!")
			
			addButton("Оргазм", "Посмотреть, что будет", "penis_proxyfuck_anus_orgasm")
		else:
			addButton("Еще", "Это заставляет игрушки тереться друг о друга", "penis_proxyfuck_anus")
		
		isRepeat = true

	if(state == "penis_proxyfuck_anus_orgasm"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			playAnimation(StageScene.SexPortalProxy, "inside", {onlyRight=true})
		else:
			playAnimation(StageScene.SexPortalProxy, "inside", {onlyRight=(secondPortalCharID=="pc"), npc=secondPortalCharID, npc2=portalCharID})
	
		if(secondPortalCharID == "pc" && portalCharID == "pc"):
			# You fuck yourself
			saynn(RNG.pick([
				"Ты издаешь страстные, сдавленные стоны, пока твоя {npc.penis} пульсирует внутри твоей {anus}... прежде чем ты заполняешь её до краев своей спермой. Ты поджимаешь пальцы ног и ерзаешь, руки дрожат, заставляя член еще сильнее тереться о твою простату...",
			]))
		elif(secondPortalCharID == "pc"):
			# You are being fucked
			saynn(RNG.pick([
				"Ты издаешь страстные, сдавленные стоны, пока чья-то {npc.penis} пульсирует внутри твоей {anus}... прежде чем ты заполняешь её до краев чужой спермой. Ты поджимаешь пальцы ног и ерзаешь, руки дрожат, заставляя этот член еще сильнее тереться о твои внутренние стенки...",
			]))
		elif(isPCPortal()):
			# You fuck someone else
			saynn(RNG.pick([
				"Ты тихо кряхтишь, пока твоя {npc.penis} пульсирует внутри этой сжимающей {anus}... прежде чем ты заполняешь её до краев своей спермой. Дистанционный трах, черт возьми!",
			]))
		elif(secondPortalCharID == portalCharID):
			# Someone else fucks themselves
			saynn(RNG.pick([
				"Ты не можешь сдержать ухмылки, наблюдая, как пульсирующий {npc.penis} кончает внутри {anus}, принадлежащей тому же человеку. Их простата, должно быть, сейчас просто разрывается от удовольствия...",
			]))
		else:
			# 2 different npcs fuck
			saynn(RNG.pick([
				"Ты невольно улыбаешься, глядя, как пульсирующий {npc.penis} кончает внутри беспомощно дергающейся {anus}. Ты только что заставил двух совершенно незнакомых людей трахаться. Красава.",
			]))
	
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_penis")





	if(state == "vagina_fuck"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortal, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={hard=true, exposedCrotch=true}, npcBodyState={hard=true}})
		
		if(!isRepeat):
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты подносишь влажный {npc.vaginaStretch} {pussy} с фаллоимитатором ближе к своей {pc.penis}... а затем входишь в себя, чувствуя, как твой член скользит в твою киску. Ощущения просто кайф...",
					"Ты хватаешь фаллоимитатор, покрытый чьей-то влажной {npc.vaginaStretch} {pussy}, и надеваешь его на свою {pc.penis}, словно секс-игрушку. Приятно...",
				]))
			else:
				saynn(RNG.pick([
					"Ты подносишь фаллоимитатор, на котором осталась чья-то {npc.vaginaStretch} {pussy}, ближе к своей {pc.penis}... а затем входишь в него, чувствуя, как твой член скользит в эту киску. Она сжимается, явно не ожидая такого. Но это лишь разжигает в тебе желание трахнуть её еще сильнее.",
					"Ты хватаешь фаллоимитатор, на котором осталась чья-то влажная {npc.vaginaStretch} {pussy}, и надеваешь его на свою {pc.penis}, как секс-игрушку. Её киска кажется такой приятной и теплой...",
				]))
		else:	
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты стонешь и содрогаешься, трахая собственную {npc.vaginaStretch} {pussy}!",
					"Ты дрожишь... трахая самого себя, используя собственную {pussy} для своего удовольствия.",
					"Ты так жадно трахаешь собственную киску, что она начинает издавать влажные звуки... Чертовски приятно.",
					"Ты немного меняешь угол наклона фаллоимитатора, чтобы твоя {penis} долбила прямо в точку G, пока ты вколачиваешь свой {pussy}. Ты точно знаешь, как доставить себе удовольствие.",
					"Ты неистово хуяришь свой {pussy} своим {pc.penis}, быстро и жестко! На животе проступает небольшой бугорок, когда твой {penis} каждый раз достигает шейки матки.",
				]))
			else:
				saynn(RNG.pick([
					"Ты тихо посапываешь, трахая эту жадную {npc.vaginaStretch} {pussy}! Это куда приятнее, чем любой секс-игрушка.",
					"Ты улыбаешься во время секса, используя чью-то {pussy} для своего удовольствия на расстоянии.",
					"Ты так жадно трахаешь эту {pussy}, что она начинает издавать влажные звуки... То, как её внутренние стенки обхватывают твою длину... это так охеренно.",
					"Ты заталкиваешь свою {penis} глубоко, вколачиваясь в точку удовольствия в этой щели. Кем бы они ни были, они текут как шлюхи.",
					"Ты херачишь в чью-то {pussy} своей {pc.penis} быстро и жестко! Так сильно, что твоя {penis} каждый раз достает до самой шейки матки, наверняка выдавливая небольшую шишку на их животе.",
				]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(GM.pc.getArousal() >= 1.0):
			saynn("Ты сейчас кончишь!")
			
			addButton("Кончить внутрь", "Кончи в них", "vagina_fuck_inside")
		else:
			addButton("Трахни сильнее", "По-настоящему вжарь в это отверстие", "vagina_fuck")
		
		isRepeat = true
	
	if(state == "vagina_fuck_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortal, "inside", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={hard=true, exposedCrotch=true}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Ты издаешь страстные сдавленные звуки, пока твоя {pc.penis} пульсирует внутри твоей {pussy}... прежде чем залить свою матку до краев своей семенной жидкостью. Ты поджимаешь пальцы ног и много ерзаешь, твои руки дрожат, заставляя твой член сильнее тереться о стенки твоей киски...",
			]))
		else:
			saynn(RNG.pick([
				"Ты тихо кряхтишь, пока твоя {pc.penis} пульсирует внутри этой сжимающей {pussy}... прежде чем залить её матку до краев своей семенной жидкостью. Дистанционное оплодотворение, черт возьми!",
			]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_vagina")



	if(state == "anus_fuck"):
		showFightUI = true
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortal, ("sex" if connectedChar.getArousal() <= 0.7 else "fast"), {onlyRight=isPCPortal(), npc=portalCharID, bodyState={hard=true, exposedCrotch=true}, npcBodyState={hard=true}})
		
		if(!isRepeat):
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты подносишь флешлайт со своей {npc.anusStretch} {anus} ближе к своей {pc.penis}... а затем проникаешь в саму себя, когда твой собственный член скользит в твою собственную задницу. Приятное чувство...",
					"Ты хватаешь флешлайт с чьим-то {npc.anusStretch} {anus} и надеваешь его на свой {pc.penis}, словно секс-игрушку. Приятное чувство...",
				]))
			else:
				saynn(RNG.pick([
					"Ты подносишь флешлайт с чьим-то {npc.anusStretch} {anus} ближе к своему {pc.penis}... а затем входишь в него, и твой член глубоко скользит внутрь. Они сжимаются, явно не ожидая такого. Но это лишь разжигает в тебе желание трахнуть их еще сильнее.",
					"Ты хватаешь флешлайт с чьим-то {npc.anusStretch} {anus} и надеваешь его на свой {pc.penis}, как секс-игрушку. Внутри так приятно и тепло...",
				]))
		else:	
			if(isPCPortal()):
				saynn(RNG.pick([
					"Ты стонешь и содрогаешься, трахая собственную {npc.anusStretch} {ass}!",
					"Тебя пробирает дрожь... пока ты трахаешь сам себя, используя собственную {asshole} для своего удовольствия.",
					"Ты так жадно трахаешь собственную {asshole}, что она начинает издавать влажные звуки... Чертовски приятно.",
					"Ты немного меняешь угол наклона флешлайта, чтобы при каждом толчке твоя {penis} долбила прямо в простату. Ты точно знаешь, как доставить себе удовольствие.",
					"Ты неистово вколачиваешь свой {pc.penis} в собственную {ass}! На животе появляется небольшая выпуклость, когда твой {penis} проникает глубоко и давит на внутреннюю стенку.",
				]))
			else:
				saynn(RNG.pick([
					"Ты тихо дышишь, трахая эту возбужденную {npc.anusStretch} {ass}! Это куда лучше любой секс-игрушки.",
					"Ты улыбаешься во время траха, используя их {ass} для своего удовольствия на расстоянии.",
					"Ты так жадно трахаешь этот {asshole}, что он начинает издавать влажные звуки... То, как его внутренние стенки обхватывают твою длину... это так чертовски хорошо.",
					"Ты засовываешь свой {penis} глубоко, вколачиваясь в этот {asshole}. Кем бы они ни были, они сжимаются, словно шлюхи.",
					"Ты херачишь по чьему-то {ass} своим {pc.penis} быстро и жестко! Так сильно, что твой {penis} проникает глубоко внутрь и давит на их внутреннюю стенку, наверняка образуя небольшую шишку на их животе.",
				]))
		
		if(extraText != ""):
			saynn(extraText)
			extraText = ""
		
		if(GM.pc.getArousal() >= 1.0):
			saynn("Ты сейчас кончишь!")
			
			addButton("Кончить внутрь", "Кончи в них", "anus_fuck_inside")
		else:
			addButton("Трахни сильнее", "По-настоящему вжарь в это отверстие", "anus_fuck")
		
		isRepeat = true
	
	if(state == "anus_fuck_inside"):
		showFightUI = true
		#var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		
		playAnimation(StageScene.SexPortal, "inside", {onlyRight=isPCPortal(), npc=portalCharID, bodyState={hard=true, exposedCrotch=true}})
		
		if(isPCPortal()):
			saynn(RNG.pick([
				"Ты издаешь страстные, сдавленные звуки, пока твой {pc.penis} пульсирует внутри твоего {anus}... прежде чем залить его до краев своей спермой. Ты поджимаешь пальцы ног и корчишься, твои руки дрожат, заставляя член еще сильнее тереться о простату...",
			]))
		else:
			saynn(RNG.pick([
				"Ты тихо кряхтишь, пока твой {pc.penis} пульсирует внутри этого сжимающегося {anus}... прежде чем залить его до краев своей спермой. Дистанционный трах, вот это да.",
			]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "choose_anus")



func calcArousalBasedOnKink(_char, _theKink):
	return (0.1 + _char.getLustLevel()*0.1)

func _react(_action: String, _args):
	if(_action == "endthescene"):
		GM.pc.setArousal(0.0)
		endScene()
		return
	
	if(_action == "penis_masturbate_anus"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.AnalSexGiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.AnalSexReceiving) * sameMult)
		if(GM.pc.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{pc.You} {pc.youVerb('orgasm')} твердый, {pc.yourHis} {asshole} сильно пульсирует!"
			GM.pc.orgasmFrom(portalCharID)
			GM.pc.setArousal(0.0)
	
	if(_action == "penis_masturbate_anus_inside"):
		processTime(60*2)
		GM.pc.gotAnusFuckedBy(portalCharID)
		GM.pc.cummedInAnusBy(portalCharID)
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	if(_action == "penis_masturbate_vagina"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.VaginalSexGiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.VaginalSexReceiving) * sameMult)
		if(GM.pc.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{pc.You} {pc.youVerb('orgasm')} твердый, {pc.yourHis} {pussy} сильно пульсирует!"
			GM.pc.orgasmFrom(portalCharID)
			GM.pc.setArousal(0.0)
	
	if(_action == "penis_masturbate_vagina_inside"):
		processTime(60*2)
		GM.pc.gotVaginaFuckedBy(portalCharID)
		GM.pc.cummedInVaginaBy(portalCharID)
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	if(_action == "penis_ride_anus"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.AnalSexGiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.AnalSexReceiving) * sameMult)
		if(GM.pc.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{pc.You} {pc.youVerb('orgasm')} твердый, {pc.yourHis} {asshole} сильно пульсирует!"
			GM.pc.orgasmFrom(portalCharID)
			GM.pc.setArousal(0.0)
	
	if(_action == "penis_ride_anus_inside"):
		processTime(60*2)
		GM.pc.gotAnusFuckedBy(portalCharID)
		GM.pc.cummedInAnusBy(portalCharID)
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	if(_action == "penis_ride_vagina"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.VaginalSexGiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.VaginalSexReceiving) * sameMult)
		if(GM.pc.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{pc.You} {pc.youVerb('orgasm')} твердый, {pc.yourHis} {pussy} сильно пульсирует!"
			GM.pc.orgasmFrom(portalCharID)
			GM.pc.setArousal(0.0)
	
	if(_action == "penis_ride_vagina_inside"):
		processTime(60*2)
		GM.pc.gotVaginaFuckedBy(portalCharID)
		GM.pc.cummedInVaginaBy(portalCharID)
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	
	if(_action == "anus_fuck"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.AnalSexReceiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.AnalSexGiving) * sameMult)
		if(connectedChar.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{npc.You} {npc.youVerb('orgasm')} твердый, {npc.yourHis} {anus} сильно пульсирует!"
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	if(_action == "anus_fuck_inside"):
		processTime(60*2)
		getCharacter(portalCharID).gotAnusFuckedBy("pc")
		getCharacter(portalCharID).cummedInAnusBy("pc")
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	
	if(_action == "vagina_fuck"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == "pc"):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.VaginalSexReceiving) * sameMult)
		GM.pc.addLust(10)
		GM.pc.addArousal(calcArousalBasedOnKink(GM.pc, Fetish.VaginalSexGiving) * sameMult)
		if(connectedChar.getArousal() >= 1.0 && portalCharID != "pc"):
			extraText = "{npc.You} {npc.youVerb('orgasm')} твердый, {npc.yourHis} {pussy} сильно пульсирует!"
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	if(_action == "vagina_fuck_inside"):
		processTime(60*2)
		getCharacter(portalCharID).gotVaginaFuckedBy("pc")
		getCharacter(portalCharID).cummedInVaginaBy("pc")
		GM.pc.orgasmFrom(portalCharID)
		GM.pc.setArousal(0.0)
		if(portalCharID != "pc"):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			connectedChar.orgasmFrom("pc")
			connectedChar.setArousal(0.0)
	
	
	
	if(_action == "penis_proxyfuck_anus"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == secondPortalCharID):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.AnalSexGiving) * sameMult)
		var connectedChar2 = GlobalRegistry.getCharacter(secondPortalCharID)
		connectedChar2.addLust(10)
		connectedChar2.addArousal(calcArousalBasedOnKink(connectedChar2, Fetish.AnalSexReceiving) * sameMult)
		if(connectedChar2.getArousal() >= 1.0 && portalCharID != secondPortalCharID):
			extraText = "{npc2.You} {npc2.youVerb('orgasm')} твердый, {npc2.yourHis} {anus} сильно пульсирует!"
			connectedChar2.orgasmFrom(portalCharID)
			connectedChar2.setArousal(0.0)
	
	if(_action == "penis_proxyfuck_anus_orgasm"):
		processTime(60*2)
		getCharacter(secondPortalCharID).gotAnusFuckedBy(portalCharID)
		getCharacter(secondPortalCharID).cummedInAnusBy(portalCharID)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.orgasmFrom(secondPortalCharID)
		connectedChar.setArousal(0.0)
		if(portalCharID != secondPortalCharID):
			var connectedChar2 = GlobalRegistry.getCharacter(secondPortalCharID)
			connectedChar2.orgasmFrom(portalCharID)
			connectedChar2.setArousal(0.0)
	
	if(_action == "penis_proxyfuck_vagina"):
		processTime(60)
		var sameMult = 1.0
		if(portalCharID == secondPortalCharID):
			sameMult = 0.6
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.VaginalSexGiving) * sameMult)
		var connectedChar2 = GlobalRegistry.getCharacter(secondPortalCharID)
		connectedChar2.addLust(10)
		connectedChar2.addArousal(calcArousalBasedOnKink(connectedChar2, Fetish.VaginalSexReceiving) * sameMult)
		if(connectedChar2.getArousal() >= 1.0 && portalCharID != secondPortalCharID):
			extraText = "{npc2.You} {npc2.youVerb('orgasm')} твердый, {npc2.yourHis} {pussy} сильно пульсирует!"
			connectedChar2.orgasmFrom(portalCharID)
			connectedChar2.setArousal(0.0)
	
	if(_action == "penis_proxyfuck_vagina_orgasm"):
		processTime(60*2)
		getCharacter(secondPortalCharID).gotVaginaFuckedBy(portalCharID)
		getCharacter(secondPortalCharID).cummedInVaginaBy(portalCharID)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.orgasmFrom(secondPortalCharID)
		connectedChar.setArousal(0.0)
		if(portalCharID != secondPortalCharID):
			var connectedChar2 = GlobalRegistry.getCharacter(secondPortalCharID)
			connectedChar2.orgasmFrom(portalCharID)
			connectedChar2.setArousal(0.0)
	
	if(_action == "choose_penis"):
		if(secondPortalCharID != ""):
			if(secondPortalCharID != "pc" && secondPortalCharID!=portalCharID):
				removeCharacter(secondPortalCharID)
			secondPortalCharID = ""
	
	if(_action == "penis_proxyfuck_secondchoose"):
		var character = _args[0]
		secondPortalCharID = character.getID()
		if(!character.isPlayer()):
			addCharacter(secondPortalCharID)
		setState("penis_proxyfuck_choose_hole")
		return
	
	if(_action == "anus_lick_swallow"):
		processTime(60*2)
		#GM.pc.cummedInMouthBy(portalCharID, FluidSource.Vagina, RNG.randf_range(0.3,0.5))
		#GM.pc.cummedOnBy(portalCharID, FluidSource.Vagina, RNG.randf_range(0.1,0.4))
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.orgasmFrom(portalCharID)
		connectedChar.setArousal(0.0)
	
	if(_action == "anus_lick_spit"):
		processTime(60)
		extraText = GM.pc.getBodypartContentsStringList(BodypartSlot.Head)
		var howMuch = GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Head, portalCharID, BodypartSlot.Anus, 0.2, 20.0)
		var newSexEvent:SexEvent = SexEvent.new()
		newSexEvent.type = SexEvent.HoleSpitted
		newSexEvent.sourceCharID = "pc"
		newSexEvent.targetCharID = portalCharID
		newSexEvent.data = {hole=BodypartSlot.Anus, loadSize = howMuch}
		#newSexEvent.isSexEngine = true
		#newSexEvent.sexEngine = getSexEngine()
		
		GM.pc.sendSexEvent(newSexEvent)
		if(portalCharID != "pc"):
			getCharacter(portalCharID).sendSexEvent(newSexEvent)
	
	if(_action == "anus_lick"):
		processTime(60)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.RimmingReceiving))
		
		if(connectedChar.hasEffect(StatusEffect.HasCumInsideAnus) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			if(RNG.chance(20)):
				if(connectedChar.bodypartTransferFluidsTo(BodypartSlot.Anus, "pc", BodypartSlot.Head, 0.1, 20.0)):
					extraText = RNG.pick([ 
						Util.capitalizeFirstLetter(connectedChar.getBodypartContentsStringList(BodypartSlot.Vagina))+" попадает тебе на язык, вытекая из {npc.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["asshole", "tailhole"])+".",
					])
	
	if(_action == "vagina_lick_swallow"):
		processTime(60*2)
		GM.pc.cummedInMouthBy(portalCharID, FluidSource.Vagina, RNG.randf_range(0.3,0.5))
		GM.pc.cummedOnBy(portalCharID, FluidSource.Vagina, RNG.randf_range(0.1,0.4))
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.orgasmFrom(portalCharID)
		connectedChar.setArousal(0.0)
	
	if(_action == "vagina_lick_spit"):
		processTime(60)
		extraText = GM.pc.getBodypartContentsStringList(BodypartSlot.Head)
		var howMuch = GM.pc.bodypartTransferFluidsToAmount(BodypartSlot.Head, portalCharID, BodypartSlot.Vagina, 0.2, 20.0)
		var newSexEvent:SexEvent = SexEvent.new()
		newSexEvent.type = SexEvent.HoleSpitted
		newSexEvent.sourceCharID = "pc"
		newSexEvent.targetCharID = portalCharID
		newSexEvent.data = {hole=BodypartSlot.Vagina, loadSize = howMuch}
		#newSexEvent.isSexEngine = true
		#newSexEvent.sexEngine = getSexEngine()
		
		GM.pc.sendSexEvent(newSexEvent)
		if(portalCharID != "pc"):
			getCharacter(portalCharID).sendSexEvent(newSexEvent)
	
	if(_action == "vagina_lick"):
		processTime(60)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.OralSexReceiving))
		
		if(connectedChar.hasEffect(StatusEffect.HasCumInsideVagina) && OPTIONS.isContentEnabled(ContentType.CumStealing)):
			if(RNG.chance(20)):
				if(connectedChar.bodypartTransferFluidsTo(BodypartSlot.Vagina, "pc", BodypartSlot.Head, 0.1, 20.0)):
					extraText = RNG.pick([ 
						Util.capitalizeFirstLetter(connectedChar.getBodypartContentsStringList(BodypartSlot.Vagina))+" попадает тебе на язык, вытекая из {npc.yourHis} "+RNG.pick(["", "used ", "stuffed "])+RNG.pick(["pussy", "slit", "kitty"])+".",
					])
	
	if(_action == "penis_suck_swallow"):
		processTime(60*2)
		GM.pc.gotThroatFuckedBy(portalCharID)
		GM.pc.cummedInMouthBy(portalCharID)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.orgasmFrom(portalCharID)
		connectedChar.setArousal(0.0)
	
	if(_action == "penis_suck"):
		processTime(60)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		connectedChar.addLust(10)
		connectedChar.addArousal(calcArousalBasedOnKink(connectedChar, Fetish.OralSexReceiving))

	if(_action == "penis_make_hard"):
		processTime(60*3)
		var connectedChar = GlobalRegistry.getCharacter(portalCharID)
		while(!connectedChar.isReadyToPenetrate()):
			connectedChar.addLust(5)
			if(connectedChar.getLustLevel() >= 1.0):
				break

	if(_action == "disconnectPortal"):
		processTime(30)
		if(portalCharID != ""):
			var connectedChar = GlobalRegistry.getCharacter(portalCharID)
			if(connectedChar != null):
				connectedChar.setArousal(0.0)
			if(portalCharID != "pc"):
				removeCharacter(portalCharID)
			if(secondPortalCharID != "pc"):
				removeCharacter(secondPortalCharID)
			secondPortalCharID = ""
			portalCharID = ""
		setState("")
		return

	if(_action == "connect_to"):
		var character = _args[0]
		portalCharID = character.getID()
		if(!character.isPlayer()):
			addCharacter(portalCharID)
			#GM.main.updateCharacterUntilNow(portalCharID)
		setState("connected")
		return

	if(_action == "openhole"):
		selectedHole = _args[0]
		setState("choose_"+selectedHole)
		return

	setState(_action)

func isPCPortal():
	return portalCharID == "pc"

func getNpcsWithPortalPanties():
	return GM.main.calculateNpcsWithPortalPanties()

func saveData():
	var data = .saveData()

	data["uniqueItemID"] = uniqueItemID
	data["portalCharID"] = portalCharID
	data["selectedHole"] = selectedHole
	data["extraText"] = extraText
	data["secondPortalCharID"] = secondPortalCharID
	data["secondSelectedHole"] = secondSelectedHole

	return data

func loadData(data):
	.loadData(data)

	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
	portalCharID = SAVE.loadVar(data, "portalCharID", "pc")
	selectedHole = SAVE.loadVar(data, "selectedHole", "")
	extraText = SAVE.loadVar(data, "extraText", "")
	secondPortalCharID = SAVE.loadVar(data, "secondPortalCharID", "pc")
	secondSelectedHole = SAVE.loadVar(data, "secondSelectedHole", "")
	
