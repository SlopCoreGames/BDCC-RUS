extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var onlyCocksGlobal = true
var onlyStraponsGlobal = true
var sceneAmount = 1
var pickedSlaves = []
var pickPool = []
var npc1 = ""
var npc2 = ""
var npc3 = ""
var didFirst = false
var lastScene = ""

func _init():
	sceneID = "articaSlaveGangbangScene"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc1"):
		return npc1
	if(_charID == "npc2"):
		return npc2
	if(_charID == "npc3"):
		return npc3

func _run():
	if(state == ""):
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		saynn("С кем ты хочешь устроить артр-гангбанг для Артики? Тебе нужно выбрать как минимум 2 человек... но чем больше рабов ты выберешь, тем дольше будет длиться этот групповой секс...")

		saynn("Любой, у кого нет подходящего члена, автоматически получит страпон.")

		if (pickedSlaves.size() > 1):
			addButton("Старт", "Вперёд!", "start_gangbang")
		else:
			addDisabledButton("Старт", "Нужно выбрать хотя бы 2 человек перед началом")
		addButton("CANCEL", "Вы передумали", "endthescene")
		if (!pickedSlaves.has("pc")):
			addButton("+Ты", "Добавить себя в список", "toggle_pc")
		else:
			addButton("-You", "Убрать себя из списка", "toggle_pc")
		addSlaveButtons()
		if (false):
			addButton("Ошибка", "Тебе не стоит этого видеть", "toggle_slave")
	if(state == "start_gangbang"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.Solo, "struggle", {pc="artica", bodyState={naked=true}})
		var pcIncluded = (pickedSlaves.has("pc"))
		var howManySlaves = pickedSlaves.size()
		saynn("Ты просишь Артику немного подождать... и подзываешь своих рабов, чтобы они подошли к тебе.")

		saynn("[say=pc]Повеселись с ней."+str(" Я буду наблюдать." if !pcIncluded else " Я тоже присоединюсь.")+"[/say]")

		saynn("Артика растерянно оглядывается... как будто "+str(howManySlaves)+" люди окружают её, перекрывая единственный выход из твоей камеры..")

		saynn("[say=artica]Мм.. что это.. э-это..[/say]")

		if (isNaked):
			saynn("Один из них внезапно хватает её за руки.. а второй хлопает её по упругой"+str(" lactating" if getCharacter("artica").isLactating() else "")+" tits.")

			saynn("[say=artica]И-ип.. п-полегче.. п-подож-.. ой..[/say]")

			saynn("Пока пушистая пытается освободить руки, кто-то тянет её за яйца, обнажая спрятанную за ними киску.. Другой дергает за хвост, заставляя Артику выпятить задницу, отчего её тугое анальное отверстие начинает подергиваться..")

			if (isVerySlut):
				saynn("[say=artica]П-пожалуйста.. ах.. в-трахай меня н-насухую..[/say]")

			elif (isSlut):
				saynn("[say=artica]Неужели меня ждёт.. г-ганбанг..[/say]")

			else:
				saynn("[say=artica]П-пожалуйста.. ах.. н-не надо..[/say]")

		else:
			saynn("Один из них внезапно хватает её за руки.. а второй силой срывает с неё рубашку, обнажая эти упругие"+str(" lactating" if getCharacter("artica").isLactating() else "")+" tits.")

			saynn("[say=artica]И-ип.. п-полегче.. п-подож-.. ой..[/say]")

			saynn("Пока пушистая пытается освободить руки, её шорты тоже стягивают вниз, обнажая её "+str("запертый в клетке член" if isCaged else "sheath")+".. и киску, что прячется за яичками.. Кто-то дергает за хвост, заставляя Артику выпятить зад, пока её узкое анальное отверстие подергивается..")

			if (isVerySlut):
				saynn("[say=artica]П-пожалуйста.. ах.. в-трахай меня н-насухую..[/say]")

			elif (isSlut):
				saynn("[say=artica]Неужели меня ждёт.. г-ганбанг..[/say]")

			else:
				saynn("[say=artica]П-пожалуйста.. ах.. н-не надо..[/say]")

		saynn("Похоже, самое веселье только начинается..")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_first_scene")
		if (false):
			addButton("IGNORE", "Тебе не стоит этого видеть", "start_next_scene")
	if(state == "dp_tease"):
		playAnimation(StageScene.SexDP, "tease", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две рабыни" if !pcIncluded else "ты и твоя рабыня")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("оба члена" if onlyCocks else ("оба страпона" if onlyStrapons else "член и страпон"))
		saynn("Крепко сжав,"+str(slavesText)+" хватает Артику и заставляет её опуститься на колени. {npc1.You} {npc1.youVerb('slide')} под ней и направляет {npc1.yourHis} {npc1.strapon} в её жаждущую щель.. в то время как {npc2.you} {npc2.youVerb('position')} {npc2.yourself} сзади и совмещает {npc2.yourHis} {npc2.strapon} с другим узким отверстием, {npc2.yourHis} руки отводят руки Артики за спину.. "+str(cocksText)+" собираются устроить двойное проникновение в свежие дырочки пушистой в любую секунду..")

		saynn("[say=artica]Ах.. эй..[/say]")

		saynn("Артика пытается освободить руки.. но их держат слишком крепко. Никто здесь не отпустит девчонку, пока её живот не будет полон.")

		if (isVerySlut):
			saynn("[say=artica]К-кажется.. м-меня сейчас р-растянут..[/say]")

		elif (isSlut):
			saynn("[say=artica]В-вы будете ж-жестко обходиться с м-моими дырочками?..[/say]")

		else:
			saynn("[say=artica]Э..э-это м-мне п-положено что-то р-решать?..[/say]")

		# (( Double penetration starts with {npc1.name} on the bottom and {npc2.name} behind. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "dp_sex")
	if(state == "dp_sex"):
		playAnimation(StageScene.SexDP, "sex", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две другие рабыни" if !pcIncluded else "ты и твоя рабыня")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		if (!didFirst):
			saynn("Одним мощным одновременным толчком, "+str("your" if pcIncluded else "their")+" "+str(cocksText)+" меня вжимают в дырки Артики: один член входит ей в киску, а другой — в её тугую дырочку, отчего девчонка чувствует себя невероятно наполненной.")

			saynn("[say=artica]Ах!.. х-хх..[/say]")

			saynn("Тело Артики выгибается от внезапного двойного проникновения; от удовольствия, которое дарит этот грубый секс, её собственный член становится твердым и влажным..")

		else:
			saynn("Вскоре в обе дырки Артики влетает уже новая порция членов, "+str(slavesText)+" заставляя девчонку упасть на колени.. а затем их заталкивают "+str("your" if pcIncluded else "their")+" "+str(cocksText)+" внутрь, растягивая её до предела!")

			saynn("Её влажный, "+str(" caged" if isCaged else " hard")+" бесполезный член подпрыгивает вверх-вниз, пока её жестко трахают, а с кончика стекает смесь предэякулята и старой спермы.")

		# (( Double penetration SEX with {npc1.name} on the bottom and {npc2.name} behind. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "dp_sexfast")
	if(state == "dp_sexfast"):
		playAnimation(StageScene.SexDP, "fast", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две рабыни" if !pcIncluded else "ты и твоя рабыня")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("два члена" if onlyCocks else ("два страпона" if onlyStrapons else "член и страпон"))
		saynn("С каждым толчком Артика чувствовала, как "+str(cocksText)+" полностью заполняет её, растягивая до предела и работая в унисон, практически никогда не оставляя её дырочки пустыми.")

		saynn("Стоны Артики наполняют воздух, пока она вынуждена терпеть этот натиск; её руки заведены за спину, а "+str(slavesText)+" трахают её всё быстрее и быстрее.")

		saynn("[say=artica]Ммм... моя... зад-д-ница... ахх-хх..[/say]")

		if (!didFirst):
			saynn("Первый оргазм Артики стремительно приближается, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+" а её анус и киска туго сжимают"+str(" rubber" if onlyStrapons else "")+" члены.")

		else:
			saynn("Похоже, Артика вот-вот снова кончит, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+" а её анус и киска туго сжимают"+str(" rubber" if onlyStrapons else "")+" члены.")

		# (( Double penetration SEX FAST with {npc1.name} on the bottom and {npc2.name} behind. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "dp_cum")
	if(state == "dp_cum"):
		playAnimation(StageScene.SexDP, "inside", {pc="artica", npc=npc1, npc2=npc2, pcCum=true, npcCum=true, npc2Cum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		#var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		#var slavesText = ("your two slaves" if !pcIncluded else "you and your slave")
		#var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		#var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		#var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "cocks and strapons"))
		saynn("С каждым двойным толчком её киска и анус растягивались до предела... пока плоть просто не начала сдаваться. Её губы издали страстный стон... за которым последовал взрыв её члена, извергающего густые струи спермы"+str(" через маленькое отверстие в девственной клетке" if isCaged else "")+" прямо на пол.")

		if (getCharacter(npc1).isWearingStrapon()):
			saynn("Её киска выжимала страпон, который трахал её... пока игрушка наконец не решила выпустить свой запас смазки-спермы глубоко в матку девушки...")

		else:
			saynn("Её киска выжимала член, который трахал её... пока она не почувствовала, как порция семени вкачивается прямо в её матку, горячие семена заливают её глубины, пока её собственный оргазм всё ещё продолжается...")

		if (getCharacter(npc2).isWearingStrapon()):
			saynn("В то же самое время {npc2.you} вогнал {npc2.yourHis} {npc2.strapon} глубоко ей в задницу; тесноты её пульсирующих внутренних стенок хватило, чтобы спровоцировать и эту игрушку на выброс порции смазки-спермы.")

		else:
			saynn("В то же самое время {npc2.you} вогнал {npc2.yourHis} {npc2.strapon} глубоко ей в задницу; тесноты её пульсирующих внутренних стенок хватило, чтобы {npc2.youHim} кончил за считанные секунды, наполняя этот анус горячей, липкой {npc2.cum} {npc2.yourHis}..")

		if (!didFirst):
			saynn("Мощный первый оргазм... но явно не последний... Артика всё ещё стонет даже после этого...")

			if (isVerySlut):
				saynn("[say=artica]Ах... мои д-дырочки... ах... так м-много...[/say]")

			elif (isSlut):
				saynn("[say=artica]Ах... т-ты ведь е-ещё не з-закончил, да?.. ах... ахх-х...[/say]")

			else:
				saynn("[say=artica]Ах... мой анус... ах... с-слишком м-много... п-подожди...[/say]")

			saynn("Она замечает, что окружающие еще не до конца удовлетворены... Пора сменить состав...")

		# (( Double penetration CUM with {npc1.name} on the bottom and {npc2.name} behind. ))
		addNextGangButton()
	if(state == "spit_tease"):
		playAnimation(StageScene.SexSpitroast, "tease", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две рабыни" if !pcIncluded else "ты и твоя рабыня")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("оба члена" if onlyCocks else ("оба страпона" if onlyStrapons else "член и страпон"))
		saynn("Крепко сжав,"+str(slavesText)+" хватают Артику за все четыре лапы... прежде чем поднять её над полом. Время не теряется, "+str(cocksText)+" уже прицеливаются к дырочкам пушистой.")

		saynn("[say=artica]Ах.. эй..[/say]")

		saynn("{npc1.You} {npc1.youAre} держат её за ноги, {npc1.yourHis} {npc1.strapon} трётся о ту самую жаждущую щель, вот-вот войдя внутрь. {npc2.You} {npc2.youAre} сжимают её грудь, {npc2.yourHis} {npc2.strapon} замирает у губ Артики, готовый ворваться..")

		if (isVerySlut):
			saynn("[say=artica]К-кажется.. м-меня сейчас р-растянут..[/say]")

		elif (isSlut):
			saynn("[say=artica]В-вы будете ж-жестко обходиться с м-моими дырочками?..[/say]")

		else:
			saynn("[say=artica]Э..э-это м-мне п-положено что-то р-решать?..[/say]")

		# (( Spitroast starts with {npc1.name} fucking pussy and {npc2.name} fucking throat. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "spit_sex")
	if(state == "spit_sex"):
		playAnimation(StageScene.SexSpitroast, "sex", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две другие рабыни" if !pcIncluded else "ты и твоя рабыня")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		if (!didFirst):
			saynn("Одним мощным одновременным толчком, "+str("your" if pcIncluded else "their")+" "+str(cocksText)+" вбиваются в дырочки Артики: один скользит в её киску, а другой опускается ей в глотку, буквально лишая пушистую возможности говорить или дышать.")

			saynn("[say=artica] Кх.. х-хх..[/say]")

			saynn("Тело Артики выгибается от внезапного проникновения; удовольствие от того, что её трахают с обоих концов, заставляет её собственный член твердеть и течь..")

		else:
			saynn("Одну порцию членов сменяет другая, "+str(slavesText)+" стремительно хватают Артику за все лапы, прежде чем поднять её и пристроить "+str("your" if pcIncluded  else "their")+" "+str(cocksText)+" к уже использованным дырочкам Артики..")

			saynn("Спустя мгновение её киска и глотка забиты до отказа. Бесконечный групповой секс не дает Артике времени на передышку... она вынуждена терпеть это... её глаза закатываются, а пальцы ног подергиваются.")

			saynn("Её сочащийся"+str(" caged" if isCaged else "")+" член капает её же кончаем на её серый живот... цвет меха скрывает большую часть этой грязи.")

		# (( Spitroast SEX with {npc1.name} fucking pussy and {npc2.name} fucking throat. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "spit_sexfast")
	if(state == "spit_sexfast"):
		playAnimation(StageScene.SexSpitroast, "fast", {pc="artica", npc=npc1, npc2=npc2, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		#var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		#var slavesText = ("your three slaves" if !pcIncluded else "you and your two slaves")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		saynn("Приглушенные стоны наслаждения вырываются из неё, пока два"+str(" rubber" if onlyStrapons else "")+" члена насильно втискивались в неё с обоих концов; ощущения захлестывали её, она пыталась дышать, а её тело сотрясалось от каждого мощного толчка.")

		if (!didFirst):
			saynn("Первый оргазм Артики стремительно приближается, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+", её глотка и киска сжимают "+str(cocksText)+" urgently.")

		else:
			saynn("Похоже, Артика вот-вот снова кончит, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+", её киска судорожно обхватывает {npc1.strapon} жестко.")

		# (( Spitroast SEX FAST with {npc1.name} fucking pussy and {npc2.name} fucking throat. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "spit_cum")
	if(state == "spit_cum"):
		playAnimation(StageScene.SexSpitroast, "inside", {pc="artica", npc=npc1, npc2=npc2, pcCum=true, npcCum=true, npc2Cum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc")
		var slavesText = ("твои две рабыни" if !pcIncluded else "ты и твоя рабыня")
		#var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon())
		#var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon())
		#var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "cocks and strapons"))
		saynn("Тело Артики выгнулось дугой, когда "+str(slavesText)+" плотно прижались к ней с обоих концов. Когда её ноги, горло и грудь были крепко зажаты, она оказалась во "+str("your" if pcIncluded else "their")+" власти толпы, её дыхание прерывалось... пока её"+str(" caged" if isCaged else "")+"пульсирующий член внезапно начал извергать в неё своё семя; стенки её киски сжимались и спазмировали вокруг толстого ствола, засасывая его глубоко, и её глотка делала то же самое со вторым членом..")

		if (getCharacter(npc2).isWearingStrapon()):
			saynn("Член у неё во рту был всего лишь страпоном.. но он всё равно выпустил смазку, заправленную внутрь, когда стенки Артики с силой сжали эту игрушку.")

		else:
			saynn("Член во рту пульсирует и бьётся о её горло.. прежде чем извергнуть горячее семя внутрь, заставляя её глотать всё до последней капли.")

		if (getCharacter(npc1).isWearingStrapon()):
			saynn("Страпон, который трахал её киску, теперь встречает сильное сопротивление, так как набитое дышло Артики выжимает из него всю смазку.")

		else:
			saynn("Матка Артики наполняется {npc1.cum}, пока её оргазмирующая"+str(" used" if didFirst else "")+" киска выжимает {npc1.your} яйца досуха.")

		if (!didFirst):
			saynn("Мощный первый оргазм.. но явно не последний.. Артика кашляет после этого первого раунда..")

			if (isVerySlut):
				saynn("[say=artica]Ах.. мои д-дырочки.. кх-х.. ах.. так.. м-много..[/say]")

			elif (isSlut):
				saynn("[say=artica]Ах.. т-ты ведь ещё не з-закончил, да?.. ах.. кх-х.. кх..[/say]")

			else:
				saynn("[say=artica]Ах.. моё г-горло.. ах-х.. кхх.. кх.. п-подожди..[/say]")

			saynn("Она замечает, что окружающие еще не до конца удовлетворены... Пора сменить состав...")

		# (( Spitroast CUM with {npc1.name} fucking pussy and {npc2.name} fucking throat. ))
		addNextGangButton()
	if(state == "gang_tease"):
		playAnimation(StageScene.SexGangbang, "tease", {pc="artica", npc2=npc1, npc=npc2, npc3=npc3, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}, npc3BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc" || npc3 == "pc")
		var slavesText = ("твои три рабыни" if !pcIncluded else "ты и твои две рабыни")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon() && !getCharacter(npc3).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon() && getCharacter(npc3).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		saynn("Крепко сжав,"+str(slavesText)+" заставляют Артику встать на четвереньки. Время не теряют, все "+str(cocksText)+" уже прицеливаются к дырочкам пушистой.")

		saynn("[say=artica]Ах.. в-вау..[/say]")

		saynn("{npc1.You} {npc1.youAre} снизу, {npc1.yourHis} {npc1.strapon} трется о щелочку девушки, вот-вот войдя в ее сочащуюся киску. {npc2.You} {npc2.youVerb('take')} сзади, {npc2.yourHis} {npc2.strapon} прижатый к этой тугой заднице, пока {npc3.your} {npc3.strapon} касается губ Артики..")

		# (( Gangbang starts with {npc1.name} fucking pussy, {npc2.name} fucking ass and {npc3.name} fucking throat.
		if (isVerySlut):
			saynn("[say=artica]К-кажется.. м-меня сейчас р-растянут..[/say]")

		elif (isSlut):
			saynn("[say=artica]В-вы будете ж-жестко обходиться с м-моими дырочками?..[/say]")

		else:
			saynn("[say=artica]Э..э-это м-мне п-положено что-то р-решать?..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "gang_sex")
	if(state == "gang_sex"):
		playAnimation(StageScene.SexGangbang, "sex", {pc="artica", npc2=npc1, npc=npc2, npc3=npc3, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}, npc3BodyState={exposedCrotch=true,hard=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc" || npc3 == "pc")
		var slavesText = ("твои остальные три рабыни" if !pcIncluded else "ты и твои две рабыни")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon() && !getCharacter(npc3).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon() && getCharacter(npc3).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		if (!didFirst):
			saynn("Одним мощным одновременным толчком, "+str("your" if pcIncluded else "their")+" "+str(cocksText)+" с силой вбиваются в отверстия Артики: один скользит в ее киску, другой растягивает анус, а третий опускается ей в глотку.")

			saynn("[say=artica]Нх-х!.. х-ммхх..[/say]")

			saynn("Тело Артики выгибается от внезапного проникновения; удовольствие от того, что ее трахают со всех сторон, заставляет ее собственный член твердеть и течь..")

		else:
			saynn("Одну порцию членов сменяет другая, "+str(slavesText)+" быстро выравнивают "+str("your" if pcIncluded  else "their")+" "+str(cocksText)+" с уже использованными отверстиями Артики.. прежде чем вогнать их внутрь, не давая этой пушистой штучке ни единого мгновения, чтобы прийти в себя.")

			saynn("Тело Артики дрожит, удовольствие от того, что ее трахают со всех сторон, снова заставляет ее собственный член твердеть, старая сперма стекает с кончика, смешиваясь с предэякулятом.")

		# (( Gangbang SEX with {npc1.name} fucking pussy, {npc2.name} fucking ass and {npc3.name} fucking throat.))
		addButton("Продолжить", "Смотреть, что будет дальше", "gang_sexfast")
	if(state == "gang_sexfast"):
		playAnimation(StageScene.SexGangbang, "fast", {pc="artica", npc2=npc1, npc=npc2, npc3=npc3, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}, npc3BodyState={exposedCrotch=true,hard=true}})
		#var pcIncluded = (npc1 == "pc" || npc2 == "pc" || npc3 == "pc")
		#var slavesText = ("your three slaves" if !pcIncluded else "you and your two slaves")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon() && !getCharacter(npc3).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon() && getCharacter(npc3).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		saynn("Отверстия Артики долбили всё быстрее и сильнее; {npc1.your} {npc1.strapon} вбивается вверх под напором {npc1.youHim}, скользкие голубые складки плотно обхватывают его, в то время как другой {npc2.strapon} молотит по заднице девушки, а внутренние стенки туго сжимают его.. точно так же, как глотка девушки сжимает {npc3.your} {npc3.strapon}.")

		if (!didFirst):
			saynn("Первый оргазм Артики стремительно приближается, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+", все её отверстия сжимают "+str(cocksText)+" urgently.")

		else:
			saynn("Следующий оргазм Артики приближается стремительно, её член бешено пульсирует,"+str(" внутри клетки" if isCaged else "")+", все её отверстия сжимают "+str(cocksText)+" urgently.")

		# (( Gangbang FAST with {npc1.name} fucking pussy, {npc2.name} fucking ass and {npc3.name} fucking throat. ))
		addButton("Продолжить", "Смотреть, что будет дальше", "gang_cum")
	if(state == "gang_cum"):
		playAnimation(StageScene.SexGangbang, "inside", {pc="artica", npc2=npc1, npc=npc2, npc3=npc3, pcCum=true, npcCum=true, npc2Cum=true, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true,hard=true}, npc2BodyState={exposedCrotch=true,hard=true}, npc3BodyState={exposedCrotch=true,hard=true}})
		#var pcIncluded = (npc1 == "pc" || npc2 == "pc" || npc3 == "pc")
		#var slavesText = ("your three slaves" if !pcIncluded else "you and your two slaves")
		var onlyCocks = (!getCharacter(npc1).isWearingStrapon() && !getCharacter(npc2).isWearingStrapon() && !getCharacter(npc3).isWearingStrapon())
		var onlyStrapons = (getCharacter(npc1).isWearingStrapon() && getCharacter(npc2).isWearingStrapon() && getCharacter(npc3).isWearingStrapon())
		var cocksText = ("cocks" if onlyCocks else ("strapons" if onlyStrapons else "члены и страпоны"))
		saynn("горло, киску и задницу Артики спазмировали вокруг трёх "+str(cocksText)+" глубоко застрявших в ней, выцеживая из них каждую каплю спермы,"+str("lube" if  onlyStrapons else "")+" пока её накрывало волнами наслаждения."+str(". в первый раз... но точно не в последний." if !didFirst else "")+"")

		saynn("Практически в тот же самый момент её собственный {artica.penis} извергся, выбрасывая густые струи спермы, в то время как её киска выпустила фонтан прозрачной девичьей смазки... Её тело дергается и дрожит, ноги трясутся, а пальцы ног сильно поджимаются.")

		# (( Gangbang CUM with {npc1.name} fucking pussy, {npc2.name} fucking ass and {npc3.name} fucking throat. ))
		if (!didFirst):
			saynn("Артика кашляет после первого раунда...")

			if (isVerySlut):
				saynn("[say=artica]Ах.. мои д-дырочки.. кх-х.. ах.. так.. м-много..[/say]")

			elif (isSlut):
				saynn("[say=artica]Ах.. т-ты ведь ещё не з-закончил, да?.. ах.. кх-х.. кх..[/say]")

			else:
				saynn("[say=artica]Ах.. моё г-горло.. ах-х.. кхх.. кх.. п-подожди..[/say]")

			saynn("Она замечает, что окружающие еще не до конца удовлетворены... Пора сменить состав...")

		addNextGangButton()
	if(state == "after_gangbang"):
		playAnimation(StageScene.SexStart, "start", {npc="artica", npcBodyState={hard=true,naked=true}})
		var pcIncluded = (npc1 == "pc" || npc2 == "pc" || npc3 == "pc")
		var slavesText = ("твои рабыни" if !pcIncluded else "ты и твои рабыни")
		var onlyCocks = onlyCocksGlobal
		var onlyStrapons = onlyStraponsGlobal
		saynn("После того как последние рабы закончили групповой секс с Артикой, она осталась лежать на полу, совершенно измотанная интенсивной долбежкой во все дыры... Её киска и анус остаются широко раскрытыми и сочащимися"+str(" fake" if onlyStrapons else "")+" семенем, а горло — садненым и растянутым от грубого обращения. Каждая мышца в её теле подергивалась от последствий только что пережитого наслаждения...")

		saynn("[say=artica]Нх-х.. ахх.. х-х-х.. х.х.. нь-ы..х..ах..[/say]")

		if (!onlyStrapons && !onlyCocks):
			saynn("Она лежала там, измученная и использованная.. "+str(slavesText)+" решают окружить её в последний раз. С ехидными улыбками на "+str("your" if pcIncluded else "their")+" лицах, "+str("you" if pcIncluded else "they")+" начинают ласкать члены и теребить киски, готовясь устроить этой пушистке последний, унизительный акт подчинения..")

			saynn("Вскоре, "+str(slavesText)+" unleash "+str("your" if pcIncluded else "their")+" заливают её, покрывая мех и лицо Артики слоями горячей, липкой спермы.. и солевой девичьей смазки.. Мех пушистки помечается множеством запахов одновременно, пока она просто полностью находится во "+str("your" if pcIncluded else "their")+" mercy..")

		elif (onlyCocks):
			saynn("Она лежала там, измученная и использованная.. "+str(slavesText)+" решают окружить её в последний раз. С ехидными улыбками на "+str("your" if pcIncluded else "their")+" лицах, "+str("you" if pcIncluded else "they")+" начинают ласкать члены, готовясь совершить над пушистой один последний, унизительный акт подчинения..")

			saynn("Вскоре, "+str(slavesText)+" unleash "+str("your" if pcIncluded else "their")+" изливаются, покрывая мех и мордочку Артики слоями горячей, липкой спермы.. Мех пушистой помечается множеством запахов одновременно, пока она полностью находится во власти "+str("your" if pcIncluded else "their")+" mercy..")

		else:
			saynn("Она лежала там, измученная и использованная.. "+str(slavesText)+" решают окружить её в последний раз. С ехидными улыбками на "+str("your" if pcIncluded else "their")+" лицах, "+str("you" if pcIncluded else "they")+" снимают "+str("your" if pcIncluded else "their")+" страпоны и начинают тереться "+str("your" if pcIncluded else "their")+" кисками, готовясь совершить над пушистой один последний, унизительный акт подчинения..")

			saynn("Вскоре, "+str(slavesText)+" unleash "+str("your" if pcIncluded else "their")+" изливаются, покрывая мех и мордочку Артики слоями соленой, скользкой девичьей смазки.. Мех пушистой помечается множеством запахов одновременно, пока она полностью находится во власти "+str("your" if pcIncluded else "their")+" mercy..")

		if (isVerySlut):
			saynn("[say=artica]Я.. т-такая.. с-спермоголодная.. ш-шлюшка.. ах-х.. спермобак..[/say]")

		elif (isSlut):
			saynn("[say=artica]Я.. т-такая.. с-спермо.. ш-шлюшка.. ахх..[/say]")

		else:
			saynn("[say=artica]Ххх-х.. ах-х.. т-так.. м-много..[/say]")

		saynn("Ты оставайся там и помоги пушистой прийти в себя.. прежде чем вывести её в главный зал.. всё ещё покрытую различными жидкостями..")

		addButton("Хватит", "Это было весело", "endthescene")
func addSlaveButtons():
	sayn("Кто устроит ей глоббэнд:")
	if(pickedSlaves.has("pc")):
		sayn("Ты")

	var notFit = {}
	var pcSlaves = GM.main.getPCSlavesIDs()
	for slaveID in pcSlaves:
		var character = getCharacter(slaveID)
		var npcSlave = character.getNpcSlavery()
		if(npcSlave == null):
			continue
		if(npcSlave.isMindBroken()):
			notFit[slaveID] = "Сломленная рабыня не может этого сделать"
			continue
		if(npcSlave.isDoingActivity()):
			notFit[slaveID] = "Эта рабыня уже чем-то занята"
			continue
		if(pickedSlaves.has(slaveID)):
			addButton("-"+character.getName(), "Уровень "+str(npcSlave.slaveLevel)+" "+npcSlave.getSlaveTypeName()+"\n\n"+character.getSmallDescription(), "toggle_slave", [slaveID])
			sayn(character.getName())
		else:
			addButton("+"+character.getName(), "Уровень "+str(npcSlave.slaveLevel)+" "+npcSlave.getSlaveTypeName()+"\n\n"+character.getSmallDescription(), "toggle_slave", [slaveID])
	for slaveID in notFit:
		var character = getCharacter(slaveID)
		addDisabledButton(character.getName(), notFit[slaveID])

func startNewGB():
	pickPool = pickedSlaves.duplicate()

func getNextNPC():
	var result = RNG.grab(pickPool)
	if(pickPool.size() <= 0):
		pickPool = pickedSlaves.duplicate()
		pickPool.erase(result)
	return result

func nextGang():
	var possible = ["dp", "spit"]
	if(pickedSlaves.size() > 2):
		possible.append("gang")
	if(possible.has(lastScene)):
		possible.erase(lastScene)
	var nextSceneType = RNG.pick(possible)
	lastScene = nextSceneType
	
	if(!didFirst):
		setState(nextSceneType+"_tease")
	else:
		setState(nextSceneType+"_sex")
	if(pickPool.size() < 3): # Not enough for a gb, refresh the pool
		startNewGB()
	npc1 = getNextNPC()
	if(nextSceneType in ["dp", "spit", "gang"]):
		npc2 = getNextNPC()
	if(nextSceneType in ["gang"]):
		npc3 = getNextNPC()

func after_gangbang():
	for slaveID in pickedSlaves:
		GM.main.updateCharacterUntilNow(slaveID)
		getCharacter(slaveID).removeStrapon()
		
		getCharacter("artica").cummedOnBy(slaveID)
	getModule("ArticaModule").makeLusty()

func addNextGangButton():
	if(sceneAmount <= 1):
		saynn("Это был последний раз...")
	elif(sceneAmount == 2):
		saynn("Рабыни могут использовать Артику еще один раз...")
	else:
		saynn(str(sceneAmount-1)+" осталось!")

	addButton("Продолжить", "Смотреть, что будет дальше", "start_next_scene")

func afterEachGang():
	getModule("ArticaModule").addCorruption(0.01)


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "start_gangbang"):
		pickPool = pickedSlaves.duplicate()
		sceneAmount = pickedSlaves.size()
		for slaveID in pickedSlaves:
			var character = getCharacter(slaveID)
			if(!character.hasReachablePenis()):
				onlyCocksGlobal = false
				var strapon = GlobalRegistry.createItem(RNG.pick(GlobalRegistry.getItemIDsByTag(ItemTag.Strapon)))
				var fluids = strapon.getFluids()
				fluids.addFluid("CumLube", RNG.randi_range(2, 5)*RNG.randf_range(80.0, 100.0))
				character.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
			else:
				onlyStraponsGlobal = false

	if(_action == "toggle_pc"):
		if(pickedSlaves.has("pc")):
			pickedSlaves.erase("pc")
		else:
			pickedSlaves.append("pc")
			playAnimation(StageScene.Duo, "stand", {npc="artica"})
		return

	if(_action == "toggle_slave"):
		var slaveID = _args[0]
		if(pickedSlaves.has(slaveID)):
			playAnimation(StageScene.Duo, "stand", {npc="artica"})
			pickedSlaves.erase(slaveID)
			removeCharacter(slaveID)
		else:
			playAnimation(StageScene.Duo, "stand", {npc=slaveID})
			pickedSlaves.append(slaveID)
			addCharacter(slaveID)
		return

	if(_action == "start_first_scene"):
		nextGang()
		return

	if(_action == "start_next_scene"):
		processTime(5*60)
		sceneAmount -= 1
		if(sceneAmount <= 0):
			processTime(3*60)
			setState("after_gangbang")
			after_gangbang()
			return
		didFirst = true
		nextGang()
		return

	if(_action == "dp_sex"):
		processTime(5*60)

	if(_action == "dp_sexfast"):
		processTime(5*60)

	if(_action == "dp_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInVaginaBy(npc1)
		getCharacter("artica").cummedInAnusBy(npc2)
		afterEachGang()

	if(_action == "spit_sex"):
		processTime(5*60)

	if(_action == "spit_sexfast"):
		processTime(5*60)

	if(_action == "spit_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInVaginaBy(npc1)
		getCharacter("artica").cummedInMouthBy(npc2)
		afterEachGang()

	if(_action == "gang_sex"):
		processTime(5*60)

	if(_action == "gang_sexfast"):
		processTime(5*60)

	if(_action == "gang_cum"):
		processTime(5*60)
		getCharacter("artica").cummedInVaginaBy(npc1)
		getCharacter("artica").cummedInAnusBy(npc2)
		getCharacter("artica").cummedInMouthBy(npc3)
		afterEachGang()

	setState(_action)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy
	data["onlyCocksGlobal"] = onlyCocksGlobal
	data["onlyStraponsGlobal"] = onlyStraponsGlobal
	data["sceneAmount"] = sceneAmount
	data["pickedSlaves"] = pickedSlaves
	data["pickPool"] = pickPool
	data["npc1"] = npc1
	data["npc2"] = npc2
	data["npc3"] = npc3
	data["didFirst"] = didFirst
	data["lastScene"] = lastScene

	return data

func loadData(data):
	.loadData(data)

	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
	onlyCocksGlobal = SAVE.loadVar(data, "onlyCocksGlobal", true)
	onlyStraponsGlobal = SAVE.loadVar(data, "onlyStraponsGlobal", true)
	sceneAmount = SAVE.loadVar(data, "sceneAmount", 1)
	pickedSlaves = SAVE.loadVar(data, "pickedSlaves", [])
	pickPool = SAVE.loadVar(data, "pickPool", [])
	npc1 = SAVE.loadVar(data, "npc1", "")
	npc2 = SAVE.loadVar(data, "npc2", "")
	npc3 = SAVE.loadVar(data, "npc3", "")
	didFirst = SAVE.loadVar(data, "didFirst", false)
	lastScene = SAVE.loadVar(data, "lastScene", "")
