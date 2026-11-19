extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var cagedDays = 0
var cagedDaysTotal = 0
var cageID = ""
var isFirstChastDeny = false

func _init():
	sceneID = "articaCellTeaseScene"

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
		saynn("Вы приглашаете Артику посидеть вместе в вашей камере.")

		if (nakedAndShy):
			saynn("[say=artica]Ох.. эм.. к-конечно.. по крайней мере, другие не будут видеть меня такой.. открытой..[/say]")

		elif (isSlut):
			saynn("[say=artica]Конечно.. мне нравится проводить время в твоей камере, ха-ха..[/say]")

		else:
			saynn("[say=artica]Ох.. эм.. ладно, почему бы и нет..[/say]")

		addButton("Камера", "Привести её в камеру", "in_cell")
	if(state == "in_cell"):
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		saynn("Вы приводите"+str(" pregnant" if getCharacter("artica").isVisiblyPregnant() else "")+" Артику в свою камеру."+str(" Похоже, она чертовски хочет..." if isLusty else "")+" Что вы хотите сделать?")

		if (isNaked):
			saynn("Форма Артики лежит здесь. Если хотите, можете вернуть её ей.")

		addButton("Обнимашки", "Просто обняться с Артикой", "do_cuddle")
		var pcSlaves = GM.main.getPCSlavesIDs()
		if (pcSlaves.size() >= 1):
			addButton("Групповуха рабов", "(Грубо) Позволь своим рабам трахнуть Артику толпой", "start_gangbang")
		else:
			addDisabledButton("Групповуха рабов", "Чтобы устроить групповуху с Артикой, в твоей камере должен быть хотя бы один раб")
		if (corruption > 0.2):
			if (GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump).size() <= 0 && GM.pc.getInventory().getItemsWithTag(ItemTag.PenisPump).size() <= 0):
				addDisabledButton("Дойка", "Чтобы доить Артику, тебе понадобится молокоотсос или пенисный насос")
			else:
				if (getCharacter("artica").hasEffect(StatusEffect.SoreNipplesAfterMilking)):
					addDisabledButton("Дойка", "Дай Артике отдохнуть... Её соски всё ещё болят")
				else:
					addButton("Дойка", "Используй молокоотсосы или пенисные насосы, чтобы подоить Артику!", "start_milkscene")
		else:
			addDisabledButton("Дойка", "Для того чтобы доить Артику, уровень её развращённости должен быть 20% или выше")
		if (isNaked):
			addButton("Дать одежду", "Вернуть Артике её униформу", "give_uniform")
	if(state == "give_uniform"):
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Артика и так достаточно долго ходила голой... поэтому ты решаешь вручить пушистой малышке её сиреневую униформу.")

		if (isVerySlut):
			saynn("[say=artica]Ох.. Я.. д-должна?..[/say]")

			saynn("Похоже, на данный момент она вполне справляется и без неё... но ты всё равно заставляешь её одеться.")

			saynn("[say=artica]Она как-то.. сковывает.. ха-ха..[/say]")

		elif (isSlut):
			saynn("[say=artica]Ох.. Кажется.. я на самом деле н-не против, если люди.. смотрят.. ха-ха..[/say]")

			saynn("Похоже, твои действия сделали пушистую.. более открытой. Тем не менее, ты заставляешь её надеть одежду.")

			saynn("[say=artica]Но.. Спасибочки![/say]")

		else:
			saynn("[say=artica]Ох.. моя одежда..[/say]")

			saynn("Она быстро хватает их и натягивает на себя.")

			saynn("[say=artica]Спасибочки..[/say]")

			saynn("Похоже, она не так уж и злится из-за того, что ты их стащил... Может, стоит повторить?")

		addButton("Продолжить", "Смотреть, что будет дальше", "in_cell")
	if(state == "do_cuddle"):
		if (isLusty):
			playAnimation(StageScene.Cuddling, "squirm", {pc="pc", npc="artica", npcBodyState={hard=true}})
		else:
			playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", npcBodyState={hard=true}})
		var isPreg = getCharacter("artica").isVisiblyPregnant()
		saynn("[say=pc]Давай пообнимаемся.[/say]")

		if (!isPreg):
			saynn("Ты осторожно тянешь Артику к своей кровати, направляя её сесть к тебе между ног.")

			saynn("С нежной улыбкой ты обнимаешь этот белый пушистик, прижимая её к своей {pc.masc} груди. Поначалу её тело кажется немного напряжённым... но под твоими прикосновениями она постепенно расслабляется, уютно устраиваясь в твоих объятиях.")

		else:
			saynn("Ты осторожно тянешь заметно беременную Артику к своей кровати, направляя её сесть к тебе между ног.")

			saynn("С нежной улыбкой ты обнимаешь этот белый пушистик и кладешь руки на её большой круглый живот, ласково поглаживая его. Поначалу её тело кажется немного напряжённым... но под твоими прикосновениями она постепенно расслабляется, уютно устраиваясь в твоих объятиях.")

			saynn("Ты чувствуешь... жизнь... внутри неё... она отзывается на твои осторожные касания редкими толчками...")

			saynn("[say=artica]Ах... я... я стану мамой...[/say]")

		saynn("Прижавшись к ней вплотную, ты шепчешь ей на ушко всякие нежности, и твой голос звучит мягко и успокаивающе.")

		if (!isPreg):
			if (isSlut):
				saynn("[say=pc]"+str(RNG.pick(["Не могу перестать думать о том, как шикарно ты бы смотрелась на коленях...", "То, как ты ерзаешь, когда становишься отчаянной и жаждущей... это так мило...", "Какое мягкое тело... такие упругие груди... такие узкие дырочки... такой милый член."]))+"[/say]")

			else:
				saynn("[say=pc]"+str(RNG.pick(["Отличная разминашка...", "Твой мех такой приятный и пушистый...", "Просто расслабься, пушистик...", "Не нужно стесняться меня, мой драгоценный пушистик..."]))+"[/say]")

		else:
			if (isSlut):
				saynn("[say=pc]"+str(RNG.pick(["Мне нравится, как изменилось твое тело, Артика. Грудь стала пышнее, бедра — шире. Ты выглядишь так, будто тебя создали специально для размножения...", "Ты чертовски сексуальна, когда беременна, Артика. Обожаю то, как твое тело жаждет члена еще сильнее, чем обычно...", "Ты будешь такой послушной мамочкой, Артика. Будешь заботиться о наших щеночках, пока я буду использовать твое тело для своего удовольствия...", "Представь, как все эти малыши копошатся внутри тебя, жаждая маминого молочка. Ты будешь такой горячей, шлюшковатой мамочкой..."]))+"[/say]")

			else:
				saynn("[say=pc]"+str(RNG.pick(["Ты будешь лучшей мамочкой, Артика... Я вижу любовь в твоих глазах.", "Ты такая сексуальная, когда беременна, Артика. Обожаю видеть тебя такой...", "Мне нравится, как изменилось твое тело из-за беременности, Артика... Ты становишься еще прекраснее, когда носишь в себе выводок..."]))+"[/say]")

		saynn("Её щеки заливаются румянцем, её"+str(" clothed" if !isNaked else " exposed")+" киска начинает требовать большего, а её член между ног становится всё больше.."+str(" насколько это позволяет девственная клетка... а позволяет она не особо..." if isCaged else "")+"Потерявшись в моменте, Артика отдается твоим объятиям, её тело дрожит от желания..")

		saynn("Тесный личный контакт заставил Артику жаждать большего.. Но пора возвращаться в главный зал.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		if (!isCaged):
			if (isNaked):
				addButtonWithChecks("Запереть её в клетку", "Незаметно надеть на неё девственную клетку", "chast_menu", [], [[ButtonChecks.HasChastityCageInInventory]])
			else:
				addDisabledButton("Запереть её в клетку", "Чтобы незаметно надеть на неё девственную клетку, Артику нужно сначала заставить раздеться")
		else:
			addButton("Проверить клетку", "Посмотреть, как там её член в клетке", "do_start_remove_chast")
	if(state == "do_start_remove_chast"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		if (cagedDays <= 0):
			saynn("Артика носит эту клетку уже.. ноль дней.."+str(" and "+str(cagedDaysTotal)+" дней в общей сложности..." if cagedDaysTotal != cagedDays else "")+" не так уж и много, а?.. она вполне может продержаться еще несколько дней!.. Или недель.")

			saynn("Ты показываешь Артике ключ от её клетки целомудрия..")

			saynn("[say=artica]Ох.. уже?..[/say]")

		elif (cagedDays <= 1):
			saynn("Артика проносила эту клетку всего.. один день.."+str(" and "+str(cagedDaysTotal)+" дней в общей сложности..." if cagedDaysTotal != cagedDays else "")+" не так уж и много, а?.. она точно может дольше!")

			saynn("[say=artica]Ох.. неужели я справилась? Это было не так уж и сложно..[/say]")

		elif (cagedDays <= 5):
			saynn("Артика проносила эту клетку.. "+str(cagedDays)+" days.."+str(" and "+str(cagedDaysTotal)+" дней в общей сложности..." if cagedDaysTotal != cagedDays else "")+" Это уже что-то..")

			saynn("[say=artica]Ох-х.. Ты же собираешься меня отпереть, в-верно?..[/say]")

		elif (cagedDays < 10):
			saynn("Артика проносила эту клетку.. "+str(cagedDays)+" days.."+str(" and "+str(cagedDaysTotal)+" дней в общей сложности..." if cagedDaysTotal != cagedDays else "")+" Неплохо!")

			saynn("[say=artica]О-ох.. Это и есть ключ.. в-верно?.. к мое-ому члену?.. п-пожалуйста.. ах..[/say]")

		else:
			saynn("Артика проносила эту клетку.. "+str(cagedDays)+" days.."+str(" and "+str(cagedDaysTotal)+" дней в общей сложности..." if cagedDaysTotal != cagedDays else "")+" Ого, ты реально её испытал!")

			saynn("[say=artica]О-ох.. Это и есть ключ.. в-верно?.. к мое-ому члену?.. п-пожалуйста.. ах.. Я ч-чувствую, как он пульсирует.. к-каждый божий д-день..[/say]")

		saynn(""+str("Она не сопротивляется, когда ты стягиваешь с неё шорты, обнажая её член в клетке..." if !isNaked else "Ты переводишь взгляд на её член в клетке...")+" Когда ключ скребет по металлу, она начинает дергаться, а из препуция сочится предэякулят.. Там внутри дикое давление.."+str(" даже если ты держишь её в таком состоянии совсем недолго..." if cagedDays < 5 else "")+"")

		addButton(" Открыть", " Снять клетку с её члена", "do_unlock_chastity")
		addButton(" Открыть ненадолго", " Приучить её меньше полагаться на свой член. Подействует, если она будет в клетке не менее 10 дней", "do_unlock_chastity_tease")
		if (getFlag("ArticaModule.cagedAcceptStage", 0) >= 3):
			addButton("Отказать ей", " Заставить её извиваться...", "do_deny_chastity_unlock")
		else:
			addDisabledButton("Отказать ей", "Обучите Артику меньше полагаться на удовольствие от своего члена, прежде чем делать это...")
	if(state == "do_deny_chastity_unlock"):
		playAnimation(StageScene.BreastGroping, "stroke", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Вы вставляете ключ в замочную скважину... и поворачиваете его...")

		saynn("...тихий щелчок...")

		saynn("[say=artica]Ах..[/say]")

		saynn("Сердце Артики бешено колотится, пока вы медленно снимаете клетку с её члена... члена, который твердеет за считанные секунды... Она закусывает губу, наблюдая, как с него капает смазка...")

		saynn("[say=artica]Я... я з-знаю, ч-что н-нельзя т-трогать...[/say]")

		saynn("Ты улыбаешься.")

		saynn("[say=pc]О да. Ты была очень хорошей девочкой, так быстро смирившись с тем, что твой член бесполезен... будто ты всегда это чувствовала. Думаю, ты заслужила небольшую награду.[/say]")

		saynn("Ваша рука тянется к её стволу... пальцы вот-вот обхватят его...")

		saynn("[say=artica]Ах!..[/say]")

		saynn("Какая жаждущая... погодите... вы ведь еще даже не коснулись её члена. Хм...")

		saynn("Вместо того чтобы ласкать её ствол, вы просто замираете рукой над ним, дразня её... Это заставляет Артику скулить от разочарования; жар вашей ладони заставляет её тело дрожать, а член — подергиваться...")

		saynn("[say=artica]Ннхх... ах...[/say]")

		saynn("С лукавой улыбкой ты начинаешь ласкать... воздух... рядом с членом Артики... скользя ладонью вдоль него... но так и не касаясь его по-настоящему...")

		saynn("[say=artica]Ах-х-х!.. ахх-х.. ахх.. ахх.. ах..[/say]")

		saynn("Артика жадно стонет, пока ощущения посылают волны удовольствия по всему её телу; её член становится твёрже... пульсирует... из него брызжут капли предэякулята... яички напрягаются... пальцы ног поджимаются... а хвост дико дёргается...")

		saynn("[say=pc]Какая же ты стала чувствительная...[/say]")

		saynn("Она извивается в твоих руках, пока ты лишь притворяешься, что ласкаешь её... одной лишь ментальной связи достаточно, чтобы её узел начал раздуваться от прилива крови...")

		saynn("[say=artica]Я... ахх-х.. с-сейчас.. ах.. с-слишком много.. боги.. ах.. нн-яяаах-х..[/say]")

		saynn("Но как только ты чувствуешь, что она на грани оргазма... ты внезапно останавливаешься, убирая руку от её члена.")

		saynn("[say=artica]Ооо-ооой.. ахх-х.. н-ннееет!.. ах.. п-пожааалуйста!.. ахх-х.. я таааак..[/say]")

		saynn("Бедняжка выгибает спину и громко скулит, тёршись о тебя... в то время как твои руки просто удерживают её на месте.")

		saynn("[say=artica]П-по-пожалуйста!.. ах.. е-ещё.. о-очень.. маааленький.. кусочек.. ахх-х..[/say]")

		saynn("[say=pc]Нет. Ты забываешь, кому принадлежит твой член, шлюха.[/say]")

		saynn("[say=artica]Хафф-ф-ф.. ахх-х..[/say]")

		saynn("Твоя рука ложится ей на шею и с заметным усилием сжимается, перехватывая её дыхание.")

		saynn("[say=pc]Ты всего лишь секс-игрушка. Забудь о своём члене, ты кончаешь только тогда, когда в твои дырки трахаются... или вообще не кончаешь. Поняла?[/say]")

		saynn("[say=artica]Кхх-х.. хх-х.. й-й.. ах.. к-к.. ах..[/say]")

		saynn("Она кивает... насколько позволяет твоя хватка... её член всё ещё подергивается и выделяет предэякулят, а узел пульсирует. Если сейчас её зажать, она наверняка кончит прямо в процессе... поэтому ты не спешишь, давая ей немного остыть.")

		saynn("Твоя рука разжимается, позволяя ей откашляться и вдохнуть воздух.")

		saynn("[say=pc]Хорошо. Я всё ещё могу решить использовать твой член... но только когда меня нет рядом... только твоя киска и задница. Поняла?[/say]")

		saynn("Она кивает еще усерднее.")

		saynn("[say=artica]Д-да.. м-мой ч-член только д-для тебя.. хх.. кхх.. для меня он.. бесполезен..[/say]")

		saynn("[say=pc]Хорошая девочка. А теперь давай..[/say]")

		addButton("Запереть её", "Надеть клетку обратно", "do_deny_chastity_lock")
	if(state == "do_deny_chastity_lock"):
		playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Ты снова защелкиваешь клетку на члене Артики... а затем возвращаешь эту похотливую пушистую штучку в главный зал.")

		#if (isFirstChastDeny):
		#	saynn("Было бы интересно подождать и посмотреть, что она предпримет теперь...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_unlock_chastity"):
		playAnimation(StageScene.Duo, "stand", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Вы вставляете ключ в замочную скважину... и поворачиваете его...")

		saynn("...тихий щелчок...")

		saynn("[say=artica]Ах.. С-спасибо-о!..[/say]")

		saynn("[say=pc]Не за что.[/say]")

		saynn("Как только её член освобождают, он тут же становится эрегированным.")

		saynn("Ты забираешь клетку и возвращаешь похотливую пушистую штучку в главный зал.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_unlock_chastity_tease"):
		playAnimation(StageScene.Cuddling, "squirm", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Вы вставляете ключ в замочную скважину... и поворачиваете его...")

		saynn("...тихий щелчок...")

		saynn("[say=artica]Ах.. С-спасибо-о!..[/say]")

		saynn("Как только ты снимаешь клетку... её член мгновенно встает в полную эрекцию.")

		var acceptCaged = getFlag("ArticaModule.cagedAcceptStage", 0)
		if (acceptCaged <= 1):
			saynn("Артика мгновенно тянется рукой, чтобы начать ласкать его... но ты отшвыриваешь её руку прежде, чем она успевает кончить.")

			saynn("[say=pc]Нет. А ну прекрати, иначе я запру тебя в клетку и сломаю ключ![/say]")

			saynn("[say=artica]Ох... ах... ах... н-но... ах-х...[/say]")

			saynn("Её тихие стоны переходят в скулёж... ведь она вынуждена смотреть на свой твердый, сочный голубой член... который дергается и сочится предэякулятом, пока она не может к нему прикоснуться.")

			saynn("[say=pc]Только я решаю, можно ли тебе его трогать, поняла?[/say]")

			saynn("От пушистой раздается еще больше скулежа и тихих стонов.")

			saynn("[say=artica]Ах-х... хафф... д-да... л-ладно... н-не трогать...[/say]")

			saynn("Ты улыбаешься и нежно целуешь девушку в щеку... прежде чем снова надеть клетку на её член, силой загоняя твердый голубой ствол обратно в препуций.")

			saynn("[say=artica]Эй... ах!.. ип!.. м-мой..! Но я... ахх-х..[/say]")

			saynn("Лапки Артики опускаются на промежность... когтистые пальцы начинают тянуть за металл...")

			saynn("[say=pc]Чем быстрее ты поймешь свое место, тем легче тебе будет.[/say]")

		elif (acceptCaged <= 2):
			saynn("Рука Артики тянется к её твердому сочному члену... пальцы обхватывают лазурный ствол... он подергивается... но не двигается.")

			saynn("[say=artica]Я.. ах.. я.. я б-буду ласкать его, т-только если ты п-позволишь..[/say]")

			saynn("Ты слышишь её тяжелое дыхание... её член пульсирует в лапе... одинокая капля предэякулята соскальзывает с кончика и достигает руки.")

			saynn("[say=pc]Хорошо. Потому что я не позволяю тебе ласкать его. Твой член — моя игрушка. Для тебя же... он бесполезен.[/say]")

			saynn("[say=artica]Ах-х.. ахх-ххх..х..[/say]")

			saynn("Твои слова, кажется, только усиливают её отчаяние... Её рука дрожит, пока она издает всякие милые звуки.")

			saynn("[say=artica]Х-хорошо.. д-да.. м-мой член.. б-бесполезен..[/say]")

			saynn("А она быстро усваивает свое место, а?")

			saynn("[say=pc]Убери лапы от члена, шлюшка.[/say]")

			saynn("Из её пасти вырываются тихие стоны... но она подчиняется, ослабляя хватку и позволяя руке соскользнуть...")

			saynn("Пока она это делает, ты снова начинаешь застегивать клетку, борясь с её эрекцией... пока не слышишь щелчок.")

			saynn("[say=artica]Ах-х~... это... с-слишком много..[/say]")

			saynn("[say=pc]Моя игрушка~.[/say]")

			saynn("Её лапы слегка тянут клетку. Видя, что снять её не получается, она начинает теребить и сжимать собственный мошонку... после чего подносит лапы к морде, вдыхая свой запах.")

			saynn("[say=artica]Нхх-х..[/say]")

			saynn("[say=pc]Такая жадная.[/say]")

		else:
			saynn("Большие глаза Артики следят за тем, как её твердый сочный член нетерпеливо дергается и источает предэякулят... но она даже не тянется к нему.")

			saynn("[say=artica]..м-мой ч-член.. бесполезный.. просто.. ах.. с-секс-игрушка..[/say]")

			saynn("[say=pc]Мхм. А для меня он совсем не бесполезный... отличный индикатор того, когда ты кончаешь.[/say]")

			saynn("Она тихонько дышит... её сердце бьется в такт пульсации её члена...")

			saynn("[say=artica]Д-да.. можно оставаться взаперти.. н-навсегда..[/say]")

			saynn("После короткой минуты свободы ты прижимаешь верхнюю часть клетки к кончику её члена, а затем с силой вталкиваешь вздутый, пульсирующий ствол в чехол, пока две металлические части не защелкнутся вместе.")

			saynn("[say=artica]Ах-х-х.. бо-о-оги..[/say]")

		saynn("Ты возвращаешь эту изголодавшуюся крошку в главный зал.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "chast_menu"):
		saynn("Какую из своих клеток ты хочешь на неё надеть?")

		addCageButtons()
		addButton("Отмена", "Вы передумали", "endthescene")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "chast_puton")
	if(state == "chast_puton"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", npcBodyState={hard=true}})
		saynn("Или нет... Наблюдение за тем, как Артика возбуждается от одного лишь прикосновения, наводит тебя на очень коварную мысль.")

		saynn("Ты нежно прикусываешь её ушко, а затем тепло шепчешь прямо в него.")

		saynn("[say=pc]Закрой глаза.. отдайся моим словам.. сосредоточься на моем голосе.. забудь о существовании мира.. всё неважно..[/say]")

		saynn("Артика послушно подчинилась; её дыхание стало глубоким и медленным, так как она полностью сосредоточилась на твоем гипнотическом тоне.")

		saynn("[say=pc]Главное, что ты здесь, в моих объятиях... Просто отдайся чувствам...[/say]")

		saynn("Незаметно ты достаешь металлическую девственную клетку... и начинаешь ее отпирать. Она состоит из двух частей: кольца, похожего на кальгель, и самой клетки, которая вставляется в него. Осторожно ты начинаешь протаскивать кольцо сквозь твердый, сочащийся смазкой член Артики.")

		saynn("[say=artica]..мм..[/say]")

		saynn("Как бы осторожен ты ни был, Артика все равно чувствует прикосновение холодного металла к своему члену... Но тебе удается поймать ее взгляд как раз перед тем, как она успевает открыть глаза.")

		saynn("[say=pc]Тсс... Все хорошо... Просто расслабься, Артика... Доверься мне... Тебе не о чем беспокоиться, пока я рядом... Просто слушай мой голос... Забудь о своих тревогах... Привяжи свой разум ко мне...[/say]")

		saynn("Приложив некоторое усилие, тебе удается протащить кольцо мимо ее узла... а затем и ее мошонку... Теперь пора переходить ко второй части.")

		saynn("Ты прижимаешь клетку к самой головке ее члена... и начинаешь постепенно наращивать давление, борясь с эрекцией Артики...")

		saynn("[say=artica]Н-нн... ня-ах...[/say]")

		saynn("[say=pc]Ты такая послушная пушинка... Слушаешься каждого моего слова... Делаешь всё, что я велю... Так держать...[/say]")

		saynn("Артика слегка ерзает, ее член пульсирует в твоих руках... узел кажется только больше раздувается от прилива крови, пока ты силой заталкиваешь его обратно в препуций... а затем начинаешь проталкивать и остальную часть ствола, пытаясь соединить две металлические части вместе...")

		saynn("[say=pc]Так.. близко..[/say]")

		saynn("Когда в камере эхом отдается последний щелчок.. Артика распахивает глаза, и с ее губ срывается тихий вздох. Она удивленно моргает, глядя на металлическую клетку, которая теперь сковывает ее член. По щекам разливается жар, когда до нее доходит осознание случившегося..")

		addButton("Продолжить", "Смотреть, что будет дальше", "chast_getup")
	if(state == "chast_getup"):
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		if (isVerySlut):
			saynn("Артика встает.. и любуется своей клеткой.")

			saynn("[say=artica]Так.. тесно.. мой бесполезный член.. н-наконец-то заперт..[/say]")

			saynn("Ого, похоже, она совсем не сопротивляется.")

			saynn("[say=pc]Тебе нравится?[/say]")

			saynn("[say=artica]Д-да.. к-конечно.. мм-мм.. шлюхам не нужен их член.. им н-нужно лишь уметь скакать на членах.. и вынашивать выводки..[/say]")

			saynn("Она во все глаза смотрит на свой член, пытающийся выбраться из чехла; голубоватый кончик отчаянно упирается в металл, а с него капает предэякулят..")

			saynn("[say=pc]Слова истинной шлюхи.[/say]")

			saynn("Артика опускает взгляд, обвивая хвостом талию.")

			saynn("Какая прелесть. Ты крепко обнимаешь этот пушистый комок.")

		elif (isSlut):
			saynn("Артика поднимается... её лапы тянут клетку, проверяя, насколько она плотно сидит.")

			saynn("[say=artica]Ох... мой член... он заперт... так туго...[/say]")

			saynn("Ты даришь ей добрую улыбку.")

			saynn("[say=pc]Тебе он правда нужен, Артика?[/say]")

			saynn("Её лапки скользят по клетке... Она пожимает плечами.")

			saynn("[say=artica]Я... я не знаю... Приятно иметь возможность... заниматься с-сексом...[/say]")

			saynn("Ты притягиваешь её ближе и оставляешь легкий поцелуй на её губах.")

			saynn("[say=pc]У тебя прекрасная размножающаяся киска... классная узкая жопка... широкая и глубокая пасть... Правда... Член тебе ни к чему, пушистая. Согласна?[/say]")

			saynn("[say=artica]Если ты п-преподносишь это так... мм-мм... м-может быть... Н-не нужен, если я буду вечно беременна щенками... ха-ха...[/say]")

			saynn("Она во все глаза смотрит на свой член, пытающийся выбраться из чехла; голубоватый кончик отчаянно упирается в металл, а с него капает предэякулят..")

			saynn("[say=pc]Хорошо.. Слова истинной шлюхи.[/say]")

			saynn("Артика опускает взгляд, обвивая хвостом талию.")

		else:
			saynn("Артика быстро вскакивает.. Её руки начинают дергать клетку.. но та заперта наглухо..")

			saynn("[say=artica]Мой.. ч-член.. п-почему ты..[/say]")

			saynn("Ты даришь ей добрую улыбку.")

			saynn("[say=pc]Тебе он правда нужен, Артика?[/say]")

			saynn("Чувствуя сильное волнение, она пытается сорвать её.. но ты останавливаешь её, перехватывая её ладони своими.")

			saynn("[say=artica]Я.. д-да.. эм-м.. Как же я.. как же я.. б-буду.. трахаться..[/say]")

			saynn("Ты притягиваешь её ближе и оставляешь легкий поцелуй на её губах.")

			saynn("[say=pc]Трахаться? Тебя всё еще можно оттрахать, пушинка.. Это всё, что тебе нужно.. Поверь мне..[/say]")

			saynn("Она сильно ерзает.. её огромные глаза следят за тем, как член пытается выбраться из чехла, голубоватый кончик отчаянно упирается в металл, а с него капает предэякулят..")

			saynn("[say=artica]Эм-м.. Я.. я не.. у-уверена..[/say]")

			saynn("Ты слышишь её тихий скулёж.. и крепко прижимаешь её к себе.")

			saynn("[say=pc]У тебя прекрасная киска.. отличная узкая жопка.. широкая глубокая пасть.. Правда.. Член для тебя бесполезен, пушинка. Разве ты не согласна?[/say]")

			saynn("[say=artica]Я.. н-не з-знаю.. кхм.. м-может быть.. о-она с-слишком т-тесная..[/say]")

			saynn("[say=pc]Ты привыкнешь. Я заставлю тебя кончить прямо в ней, будет весело..[/say]")

			saynn("[say=artica]Л-ладно.. м-может, ты и п-правда прав.. ах..[/say]")

		saynn("После этого нужно вернуть Артику в главный зал.. чтобы все могли полюбоваться её новой блестящей клеткой.")

		saynn("(( Пока на Артике надета девственная клетка, некоторые события не смогут сработать ))")
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addCageButtons():
	var strapons = GM.pc.getChastityCages()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "chast_puton", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_cell"):
		processTime(3*60)

	if(_action == "do_cuddle"):
		processTime(10*60)
		getModule("ArticaModule").makeLusty()

	if(_action == "start_gangbang"):
		endScene()
		runScene("articaSlaveGangbangScene")
		return

	if(_action == "start_milkscene"):
		endScene()
		runScene("articaMilkingInCellScene")
		return

	if(_action == "give_uniform"):
		setFlag("ArticaModule.NoClothes", false)
		getCharacter("artica").resetEquipment(true, true, true)
		isNaked = false
		nakedAndShy = false

	if(_action == "do_start_remove_chast"):
		cagedDays = getModule("ArticaModule").getCagedDaysCurrently()
		cagedDaysTotal = getModule("ArticaModule").getCagedDays()

	if(_action == "do_unlock_chastity"):
		processTime(3*60)
		var cage = getCharacter("artica").getWornChastityCage()
		if(cage != null):
			getCharacter("artica").getInventory().removeEquippedItem(cage)
			GM.pc.getInventory().addItem(cage)
		getModule("ArticaModule").endCaged()

	if(_action == "do_unlock_chastity_tease"):
		processTime(3*60)
		getModule("ArticaModule").makeLusty()
		if(cagedDays >= 10):
			var acceptCaged = getFlag("ArticaModule.cagedAcceptStage", 0)
			if(acceptCaged < 3):
				acceptCaged += 1
				setFlag("ArticaModule.cagedAcceptStage", acceptCaged)

	if(_action == "do_deny_chastity_unlock"):
		processTime(3*60)
		var alreadyWasDenied = getFlag("ArticaModule.gotChastityDenied", false)
		if(!alreadyWasDenied):
			isFirstChastDeny = true
			getModule("ArticaModule").addCorruption(0.05)
		setFlag("ArticaModule.gotChastityDenied", true)
		getModule("ArticaModule").makeLusty()
		var cage = getCharacter("artica").getWornChastityCage()
		if(cage != null):
			cageID = cage.uniqueID
			getCharacter("artica").getInventory().removeEquippedItem(cage)
			GM.pc.getInventory().addItem(cage)

	if(_action == "do_deny_chastity_lock"):
		var cage = GM.pc.getInventory().getItemByUniqueID(cageID)
		if(cage != null):
			GM.pc.getInventory().removeItem(cage)
			getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(cage)

	if(_action == "chast_puton"):
		processTime(5*60)
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		getCharacter("artica").getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		isCaged = true
		getModule("ArticaModule").startCaged()

	if(_action == "chast_getup"):
		processTime(3*60)

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
	data["cagedDays"] = cagedDays
	data["cagedDaysTotal"] = cagedDaysTotal
	data["cageID"] = cageID
	data["isFirstChastDeny"] = isFirstChastDeny

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
	cagedDays = SAVE.loadVar(data, "cagedDays", 0)
	cagedDaysTotal = SAVE.loadVar(data, "cagedDaysTotal", 0)
	cageID = SAVE.loadVar(data, "cageID", "")
	isFirstChastDeny = SAVE.loadVar(data, "isFirstChastDeny", false)
