extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MainCheckpointScene"

func _run():
	if(state == ""):
		addCharacter("cp_guard")
		playAnimation(StageScene.Duo, "stand", {npc="cp_guard"})

	if(state == "" && !getModuleFlag("CellblockModule", "Cellblock_CheckpointVisited", false)):
		setModuleFlag("CellblockModule", "Cellblock_CheckpointVisited", true)
		
		saynn("Чтобы добраться до лифта, сначала нужно пройти через контрольно-пропускной пункт. Это короткий коридор под прицелом камеры наблюдения и охраняемый охранником. Охранник — явно мужик среднего телосложения, в синей униформе и легкой броне, с ремнем, на котором висят всякие штуки вроде электрошокера и пульта.")

		saynn("Когда ты подходишь к охраннику, он жестом велит тебе остановиться.")

		saynn("[say=cp_guard]Имя.[/say]")

		saynn("[say=pc]Это {pc.name}[/say]")

		saynn("Он усмехается.")

		saynn("[say=cp_guard]Да не еби ты мозг этой херней. Твое настоящее имя, зэк.[/say]")

		saynn("Это немного раздражает; ты вздыхаешь, пока парень медленно разглядывает твое {pc.feminine} тело.")

		saynn("[say=pc]Номер заключенного {pc.inmateNumber}. Теперь можно идти?[/say]")

		saynn("[say=cp_guard]Надо тебя обыскать. Встань к стене.[/say]")

		# (if not naked)
		if(!GM.pc.isFullyNaked()):
			saynn("[say=pc]Почему?[/say]")

			saynn("[say=cp_guard]Чтобы убедиться, что у тебя нет ничего запрещенного.[/say]")

			saynn("[say=pc]И что считается запрещенным?[/say]")

			saynn("[say=cp_guard]Любое оружие, любой контрабандный товар. У меня нет на тебя уйму времени, зэчка.[/say]")
		# (if naked)
		else:
			saynn("[say=pc]Разве не видно, что у меня ничего нет? Я же голая![/say]")

			saynn("[say=cp_guard]Да неужели? Ты и представить не можешь, где заключенные прячут шмотки. Не трать мое время, сучка.[/say]")

		saynn("Охранник будет обыскивать тебя каждый раз, когда ты попытаешься пройти здесь. Что будешь делать?")
	elif(state == "" && GM.main.isVeryLate()):
		saynn("Охранник с собакой останавливает тебя на контрольно-пропускном пункте.")
		
		saynn("[say=cp_guard]Сейчас лифт не работает, возвращайся в камеру, зэчка.[/say]")
	elif(state == ""):
		saynn("Охранник с собакой останавливает тебя на контрольно-пропускном пункте.")

		saynn("[say=cp_guard]Сейчас прощупаю тебя на предмет запрещенки. Прижмись к стене.[/say]")

		saynn("Что будете делать?")
	if(state == ""):
		addButtonUnlessLate("Get frisked", "Let him frisk you", "get_frisked")
		addButtonWithChecks("Предложить рукоблудие", "Может, он пропустит тебя, если ты дашь ему выпустить член?", "offer_handjob", [], [
			ButtonChecks.NotHandsBlocked,
			ButtonChecks.NotLate,
			[ButtonChecks.SkillCheck, Skill.SexSlave, 1],
			])
		addButton("Запугивание", "Попробуй его напугать. Может сработать, если у тебя подходящая репутация", "intimidate")
		addButton("Уйти", "Тебе явно не хочется, чтобы тебя обыскивали", "leave")

	if(state == "leave"):
		saynn("[say=pc]Ой, не хотел сюда забредать.[/say]")

		saynn("Охранник прищуривается, глядя на тебя.")

		saynn("[say=cp_guard]Ну и вали отсюда тогда.[/say]")

		addButton("Продолжить", "Ну и ладно", "leaveandendthescene")

	if(state == "get_frisked"):
		playAnimation(StageScene.Search, "search", {
			npc="cp_guard",pc="pc",
			bodyState={},
			npcBodyState={},
		})
		
		saynn("Ты прислоняешься к стене и ждешь парня. Он встает позади тебя и заставляет тебя расставить ноги пошире.")

		saynn("Затем он приседает и начинает прощупывать тебя снизу вверх; его руки скользят по изгибам твоего {pc.thick} тела, выискивая что-нибудь необычное. Он также проверяет все карманы.")

		saynn("Затем он достает какой-то сканер и использует его на тебе. Наверное, он мог бы просто сделать это с самого начала.")

		# (if has something)
		if(GM.pc.hasIllegalItems()):
			saynn("[say=cp_guard]Это контрабанда. Где ты это нашел, зек?[/say]")

			saynn("[say=pc]На полу?[/say]")

			saynn("[say=cp_guard]Да, конечно. Я это заберу.[/say]")

			saynn("Ну, что поделаешь. Ты закатываешь глаза и уходишь.")
		else:
		# (if clear)
			saynn("[say=cp_guard]Ладно, ты свободна.[/say]")

			saynn("Ты продолжаешь свой путь.")
		
		addButton("Продолжить", "Пора идти", "friskAndEndthescene")
		

	if(state == "offer_handjob"):
		playAnimation(StageScene.SexHandjob, "sex", {
			npc="pc", pc="cp_guard", 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={},
		})

		saynn("Вместо того чтобы делать, как велели, ты подходишь ближе к охраннику и смело кладешь руку ему на пах, слегка сжимая его. Парень хмыкает и ухмыляется.")

		saynn("[say=pc]Как насчет того, чтобы я предложила тебе кое-что другое~[/say]")

		saynn("[say=cp_guard]Думаю, ты можешь попробовать, заключенная. Только без фокусов.[/say]")

		saynn("Твоя вторая рука щекочет его подбородок, пока первая медленно расстегивает распирающие штаны.")

		saynn("[say=pc]Такой серьезный агрегат требует серьезного подхода~[/say]")

		saynn("Ты опускаешься перед ним на колени и вытягиваешь его полуэрегированный член. По форме он напоминает собачий: заостренный кончик, кроваво-красный венозный ствол с узлом на конце. Ты чмокаешь головку и обхватываешь пальцами толстую плоть, слегка поглаживая её, чтобы помочь ему встать колом. Он прислоняется спиной к стене и наблюдает за твоей работой.")

		# (if red)
		if(GM.pc.getInmateType() == InmateType.HighSec):
			saynn("[say=cp_guard]Для «красной» ты чертовски похотливая. И не вздумай выпускать когти, шлюха.[/say]")

		# (if general)
		if(GM.pc.getInmateType() == InmateType.General):
			saynn("[say=cp_guard]Такая сучка... тебе самое место в сиреневом блоке. Я бы не прочь трахать тебя время от времени.[/say]")

		# (if pink)
		if(GM.pc.getInmateType() == InmateType.SexDeviant):
			saynn("[say=cp_guard]Приятно видеть, что секс-игрушки знают своё место. Продолжай работать.[/say]")

		saynn("Его член медленно достигает своего максимума, {cp_guard.penisSizeStr}, очень внушительный. На кончике ты замечаешь капли предэякулята; ты подхватываешь их рукой и размазываешь по всей длине вниз. Твоя свободная рука ныряет в расстегнутые штаны, слегка массируя его яйца. Его дыхание становится глубже, пока ты ласкаешь его собачий член, постепенно ускоряя темп.")

		saynn("Всё это происходит на людях, но тебе плевать. Ты смотришь на парня и дразняще слизываешь предэякулят с его члена. Твоя рука ходит вверх-вниз в размеренном темпе; ты замечаешь, как раздувается его узел, а сам ствол пульсирует.")

		saynn("[say=cp_guard]Я бы не отказался кончить тебе прямо в глотку, шлюшка.[/say]")

		saynn("Ты тихо посмеиваешься и подгоняешь его к пику, обе руки скользят по подергивающемуся члену. Его тяжелое дыхание и раздувающийся узел говорят о том, что он уже на пределе.")

		addButton("Снаружи", "Сделай необходимый минимум и постарайся не испачкаться", "outside")
		addButton("Фейшал", "Дай ему кончить тебе на лицо", "facial")
		addButtonWithChecks("Рот", "Зачем тебе тратить столько спермы? Открой рот и поймай её.", "mouth", [], [ButtonChecks.NotOralBlocked])
		
	if(state == "outside"):
		playAnimation(StageScene.SexHandjob, "tease", {
			npc="pc", pc="cp_guard", 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={},
		})
		
		saynn("Его член пульсирует всё сильнее, узел такой толстый, что пальцами его не обхватить. Проходит всего пара секунд, и парень начинает хрипеть, пока его член извергает струи кончи, одну за другой. Ты сидишь чуть в стороне, стараясь не испачкаться, и наблюдаешь, как он размазывает густую сперму по противоположной стене.")

		saynn("[say=cp_guard]Нгх, блядь... Надо было заставить тебя вылизать всё этим языком.[/say]")

		saynn("Ты посмеиваешься и украдкой вытираешь пальцы о его штаны. Его член медленно опадает, и он прячет его обратно.")

		saynn("[say=cp_guard]Ладно, сегодня больше обыскивать тебя не буду, проходи свободно.[/say]")

		# (scene ends)

		
		addButton("Продолжить", "Всё прошло успешно", "allowFullAndendthescene")
	if(state == "facial"):
		playAnimation(StageScene.SexHandjob, "fast", {
			npc="pc", pc="cp_guard", 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={},
		})
		
		saynn("Ты закрываешь глаза и подставляешься прямо под этот член; твоим рукам наконец удается довести его до края. Парень хрипит, когда его животный член начинает заливать твоё лицо горячей спермой, волна за волной. Ты мгновенно становишься грязной: волосы, лицо, уши, плечи — всё покрывается этой липкой дрянью. Ты сидишь смирно, как послушная тряпка для спермы, и просто принимаешь всё на себя, не двигая руками, лишь направляя его член прямо на себя.")

		saynn("В конце концов его отпускает, член медленно опадает и начинает уменьшаться. Однако он позволяет себе провести кончиком по твоей одежде. Ты можешь лишь приоткрыть один глаз, а если откроешь рот — то наверняка почувствуешь вкус его семени.")

		saynn("[say=cp_guard]Это было круто, выглядишь как настоящая спермостручка. Свободна, сегодня больше обыскивать тебя не буду, шлюха.[/say]")

		# (scene ends)

		addButton("Продолжить", "Всё прошло успешно", "allowFullAndendthescene")
	if(state == "mouth"):
		playAnimation(StageScene.SexOral, "fast", {
			npc="pc", pc="cp_guard", 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={},
		})
		
		saynn("Ты принимаешь нужную позу и широко открываешь рот, высунув язык; член, который ты ласкаешь, покоится на нем. Твои руки быстро работают над ним, пока ты жадно смотришь на охранника, предвкушая сперму. В конце концов он начинает кряхтеть и дергать бедрами вперед-назад, и его член взрывается волна за волной горячей семенной жидкости; большая часть попадает прямо тебе в глотку, а часть — на язык. Ты делаешь это как настоящая шлюха: устраиваешь парню шоу и при этом не даешь пропасть ни единой капле его спермы — ты быстро глотаешь и позволяешь ему набивать тебе рот еще и еще, пока твои руки доят его ствол и выжимают последние соки из яичек, пока там не остается совсем ничего.")

		saynn("Наконец его экстаз проходит, ты отстраняешься и показываешь ему свой рот, полный спермы. Затем ты закрываешь рот и высоко задираешь подбородок, демонстрируя ему тот самый момент, когда ты полностью проглатываешь эту липкую жижу. После этого ты слизываешь и посасываешь каждый свой палец, тоже всё проглатывая, прежде чем показать охраннику свой пустой рот.")

		saynn("[say=cp_guard]Ох, блядь, это было нечто, ты такая хорошая шлюшка. На сегодня ты свободна, но я бы не отказался использовать тебя почаще.[/say]")

		# (scene ends)
		addButton("Продолжить", "Всё прошло успешно", "allowFullAndendthescene")

		
	if(state == "intimidate"):
		saynn("[say=pc]Как насчет того, чтобы пропустить меня спокойно?[/say]")

		saynn("Охранник выпрямляется и хватает свое оружие.")

		# (if red)
		if(GM.pc.getInmateType() == InmateType.HighSec):
			saynn("[say=cp_guard]Не думаю, рыжий. Я тебя не боюсь.[/say]")

		# (if general)
		if(GM.pc.getInmateType() == InmateType.General):
			saynn("[say=cp_guard]Непослушная заключенная, значит? Пора преподать тебе урок.[/say]")

		# (if pink)
		if(GM.pc.getInmateType() == InmateType.SexDeviant):
			saynn("[say=cp_guard]У этой шлюхи есть зубки? С тобой будет очень весело.[/say]")

		saynn("Похоже, назревает драка.")
		
		addButton("Драться", "Начать бой", "fight")

	if(state == "lost_fight"):
		saynn("[say=cp_guard]Тебе лучше начать вести себя прилично, зэк.[/say]")

		saynn("Он прижимает тебя к земле, и ты почти не можешь сопротивляться.")

		# (scene ends)
		addButton("Продолжить", "Ну и ладно", "leaveandendthescene")

	if(state == "won_fight"):
		saynn("Побежденный охранник сидит на полу, не в силах продолжать бой.")

		saynn("[say=cp_guard]Сегодня тебе повезло, зэк. Но не думай, что другие охранники тебя не остановят.[/say]")

		# (if pink)
		if(GM.pc.getInmateType() == InmateType.SexDeviant):
			saynn("[say=cp_guard]Поражен секс-игрушкой, блять...[/say]")
		
		addWonButton()
		
	if(state == "catch_anal"):
		playAnimation(StageScene.SexCowgirl, "sex", {
			pc="cp_guard", npc="pc", 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		
		saynn("Ты садишься верхом на парня и расстегиваешь его ширинку; кажется, он скорее заинтригован, чем напуган, и внимательно наблюдает за тобой. Разумеется, ты позаботилась о том, чтобы он не мог дотянуться ни до оружия, ни до пульта шокера, оставив его совершенно беспомощным.")

		saynn("[say=cp_guard]Вообще-то, можно было и спросить.[/say]")

		saynn("[say=pc]Мне нравится получать всё трудным путем.[/say]")

		saynn("[say=cp_guard]Да неужели? Мне это нравится.[/say]")

		saynn("Твоя рука вытягивает его член и продолжает ласкать его, пока он не встает колом. Его хозяйство имеет заостренную форму, похожую на клык, с жирным узлом на конце и довольно длинное, около {cp_guard.penisSizeStr}. Парень ухмыляется и пытается схватить тебя за {pc.breasts}, но ты отбиваешь его руку.")

		# (if canUndress)
		if(GM.pc.canUndress()):
			saynn("Затем ты {pc.undressMessage}. Одежду ты оставляешь неподалеку.")

		saynn("Ты собираешь немного его предэякулята пальцами, затем подносишь их к заднице и втираешь его в анус. Затем ты берешь его член и направляешь его к своему отверстию, медленно опускаясь на него. Его член начинает медленно прощупывать и растягивать твое кольцо. После нескольких попыток тебе это удается — кончик его члена оказывается внутри тебя.")

		# (if has cock)
		if(GM.pc.isWearingChastityCage()):
			saynn("Твой собственный {pc.cock} тоже пытается встать, хотя ты его даже не трогаешь, но клетка целомудрия мешает полноценной эрекции. На кончике клетки видна одинокая блестящая капля предэякулята.")
		elif(GM.pc.hasPenis()):
			saynn("Твой собственный {pc.cock} тоже твердеет без твоего прикосновения, на самом кончике видна одинокая блестящая капля предэякулята.")

		# (if has vagina)
		if(GM.pc.hasVagina()):
			saynn("Твоя щель пока остается без внимания, но она становится влажной просто от того, насколько сильно ты возбуждена.")

		saynn("[say=cp_guard]Не останавливайся сейчас, сучка![/say]")

		saynn("Он кладет руки на твои {pc.feminine} бедра и прижимает тебя ниже, помогая своему члену скользнуть глубже в тебя. Ты издаешь милый звук и закусываешь губы, когда твое кольцо растягивается достаточно, чтобы пропустить около половины его длины.")

		# (if has cock)
		if(GM.pc.hasPenis()):
			saynn("Ты чувствуешь, как он трется о что-то очень чувствительное внутри тебя; от любого движения твой член начинает подтекать прозрачной жидкостью.")

		# (if has vagina)
		if(GM.pc.hasVagina()):
			saynn("Член настолько наполняет тебя, что ты чувствуешь, как он давит на твою точку G через стенку, разделяющую влагалище и анус.")

		saynn("Ты не останавливаешься, а медленно начинаешь садиться на него, двигая своим {pc.thick} {pc.feminine} телом вверх-вниз по его члену, каждый раз стараясь растянуться еще сильнее; его предэякулят служит смазкой и облегчает процесс. Это приносит невероятное удовольствие, ты приоткрываешь рот и начинаешь стонать, а твои руки ложатся на грудь и начинают ласкать чувствительные соски.")

		# (if has cock)
		if(GM.pc.isWearingChastityCage()):
			saynn("Твой собственный запертый в клетку {pc.cockDesc} член ходит вверх-вниз, твою маленькую простату так сильно массирует, что ты не можешь перестать течь.")
		elif(GM.pc.hasPenis()):
			saynn("Твой собственный {pc.cockDesc} член ходит вверх-вниз, твою маленькую простату так сильно массирует, что ты не можешь перестать течь.")

		# (if has vagina)
		if(GM.pc.hasVagina()):
			saynn("Твоя киска сочит женскими соками; хоть её и не стимулируют напрямую, ощущения всё равно чертовски приятные.")

		saynn("Ты насаживаешься еще глубже, принимая почти всю его длину! Твое кольцо достаточно растянулось, а вся та смазка, которую он в тебя вкачивает, позволяет тебе начать скакать на его члене быстрее. Ты пускаешь слюни и тяжело дышишь, твои пальцы сжимают чувствительные соски, пока ты скачешь на нем, совершенно не заняв руки — это охренительно. Парень тоже тяжело дышит, его руки тянут тебя вверх и вниз, делая твои движения более мощными.")

		saynn("[say=pc]Твою мать, как же хорошо ты меня наполняешь![/say]")

		saynn("[say=cp_guard]И ты не кончишь, пока я тебя не набью до краев![/say]")

		# (if has cock)
		if(GM.pc.isWearingChastityCage()):
			saynn("Твоя {pc.cockSize} игрушка пульсирует и становится твердой как камень, оказывая сильное давление на твою клетку. Член охранника так сильно долбит в твою простату, что кажется, будто ты вот-вот сорвешься в оргазм в любую секунду.")
		elif(GM.pc.hasPenis()):
			saynn("Твоя {pc.cockSize} игрушка пульсирует и становится каменной; охранник так неистово долбит тебя в простату, что кажется, будто ты вот-вот сорвешься в оргазм в любую секунду.")

		saynn("Ты уже близко. И он тоже. Ты чувствуешь, как его звериный член раздувается внутри твоей кишки; его узел наполняется кровью и растягивает тебя еще сильнее, но всё еще не влезает целиком. Твои стоны и тяжелое дыхание не прекращаются; ты упираешься руками в грудь охранника и начинаешь с удвоенной силой насаживаться на его член, при каждом движении позволяя анальному кольцу пропускать всё больше и больше его узла. Одним последним мощным толчком тебе удается наконец втиснуть его — вся эта жирная шишка проскальзывает внутрь, намертво сцепляя вас двоих. Именно это заставляет вас обоих сорваться: парень хрипит, когда его член начинает извергать горячую липкую сперму прямо в тебя, заполняя тебя до краев. Ты стонешь и дрожишь, твои ноги подкашиваются, а руки мертвой хваткой вцепляются в него.")

		# (if has cock)
		if(GM.pc.hasPenis()):
			saynn("Твою маленькую точку P буквально разминают, давления достаточно, чтобы твой {pc.cockDesc} член тоже запульсировал и начал извергать сперму. Не так много, но это почти непрерывный поток. Ты ловишь волну собственного оргазма без помощи рук, и это чертовски приятно.")

		# (if has vagina)
		if(GM.pc.hasVagina()):
			saynn("Твою точку G так сильно терли через стенку кишки, что из-за гиперстимуляции у тебя начинается вагинальный сквирт. Ого, тебе удалось получить вагинальный оргазм через анал.")

		saynn("Вы оба тяжело дышите, приходя в себя после пика удовольствия. Ты смотришь вниз на свой живот и видишь на нем отчетливый бугорок. Ты пытаешься встать, но понимаешь, что не можешь.")

		saynn("[say=cp_guard]Ох, ну ты и жопошлёпка. И теперь ты насажена на мой член. Работает получше любых наручников.[/say]")

		saynn("[say=pc]Да неужели? Ну тогда я буду трахать тебя до тех пор, пока ты не сдашься.[/say]")

		saynn("[say=cp_guard]Везучая ты шлюшка.[/say]")

		saynn("Вы застряли друг в друге примерно на 30 минут. На виду у всех. На вас пялятся другие заключенные, но для них это почти обычное зрелище. В конце концов узел спадает, позволяя вам подняться; твой использованный анус выглядит растянутым и сочит сперму. Пора сваливать, пока кто-нибудь не заставил тебя вылизывать то, что ты наделала.")
		
		addButton("Уйти", "Ура", "allowFullAndendthescene")

func addWonButton():
	addButton("Уйти", "Ты получила пропуск, можешь просто идти", "allowFullAndendthescene")
	addButtonWithChecks("Принять в анус", "Использовать член парня для своего удовольствия", "catch_anal", [], [ButtonChecks.NotHandsBlocked])
	addButtonWithChecks("Секс!", "Пора их оттрахать!", "startsexasdom", [], [ButtonChecks.CanStartSex])
	addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
	addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
	if(GM.pc.getInventory().hasRemovableRestraints()):
		addButton("Сопротивление", "Вырваться из оков", "strugglemenu")

func _react(_action: String, _args):
	if(_action == "get_frisked"):
		for item in GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")
		for item in GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")
	
	if(_action == "friskAndEndthescene"):
		GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
		GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		
		endScene()
		return
	
	if(_action == "outside"):
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "cpguard_suckcock")

	if(_action == "facial"):
		GM.pc.cummedOnBy("cp_guard", FluidSource.Penis)
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "cpguard_suckcock")

	if(_action == "mouth"):
		GM.pc.cummedInMouthBy("cp_guard")
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "cpguard_suckcock")

	if(_action == "allowFullAndendthescene"):
		setModuleFlag("CellblockModule", "Cellblock_FreeToPassCheckpoint", true)
		endScene()
		return

	if(_action == "leaveandendthescene"):
		GM.pc.setLocation("hall_mainentrance")
		endScene()
		return

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "fight"):
		runScene("FightScene", ["cp_guard"], "cpguardfight")
	
	if(_action == "catch_anal"):
		processTime(30 * 60)
		
		GM.pc.gotAnusFuckedBy("cp_guard")
		GM.pc.cummedInAnusBy("cp_guard")
		GM.pc.orgasmFrom("cp_guard")
		GM.pc.addSkillExperience(Skill.SexSlave, 30, "cpguard_catchanal")
	
	if(_action == "startsexsubby"):
		getCharacter("cp_guard").prepareForSexAsDom()
		GlobalRegistry.getCharacter("cp_guard").addPain(-50)
		runScene("GenericSexScene", ["cp_guard", "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "subbysex")
	
	if(_action == "startsexasdom"):
		runScene("GenericSexScene", ["pc", "cp_guard", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "domsex")
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		setModuleFlag("CellblockModule", "Cellblock_FreeToPassCheckpoint", true)
		endScene()
	
	if(_tag == "cpguardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_fight")
			addExperienceToPlayer(30)
		else:
			setState("lost_fight")
			addExperienceToPlayer(5)
			
			
			for item in GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(1, 2)):
				addMessage(item.getForcedOnMessage())

func getDevCommentary():
	return "This checkpoint.. I dunno if its even needed x3. It's more a sandbox element. A boring one that gets in the way. That's why I made it so the scene doesn't even run unless you have something illegal (the guard would always stop you before).\n\nIs it possible to make it fun? I dunno.. Maybe the checkpoint guard should be more fleshed out into an actual character that you can dominate to make him let you pass every time. Dunno."

func hasDevCommentary():
	return true
