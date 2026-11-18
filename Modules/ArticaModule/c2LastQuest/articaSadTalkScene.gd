extends SceneBase

var isCaged = false

func _init():
	sceneID = "articaSadTalkScene"

func _run():
	if(state == ""):
		setFlag("ArticaModule.LQTalkedOnce", true)
		addCharacter("artica", ["sad", "naked"])
		isCaged = getCharacter("artica").isWearingChastityCage()
		playAnimation(StageScene.SexStart, "start", {pc="pc", npc="artica", npcBodyState={naked=true}})
		saynn("Ты находишь Артику на её кровати. Она забилась в угол, обхватив руками колени.")

		saynn("Её взгляд... расфокусирован. Волосы совсем растрепаны...")

		saynn("[say=pc]Эй.[/say]")

		saynn("Она поворачивает голову в твою сторону, всё ещё прячась за коленями.")

		saynn("[say=artica]М..м-м-м..хх..[/say]")

		addButton("Поговорить", "Поговорить с пушистиком", "do_talk")
		addButton("Подразнить", "Подразнить пушистика", "do_tease")
		addButton("Секс", "Повеселиться", "do_sex")
		addButton("Уйти", "Оставить грустную пушистицу в покое", "endthescene")
	if(state == "do_talk"):
		saynn("[say=pc]Хочешь поболтать?[/say]")

		saynn("Ты слышишь печальный вздох.")

		saynn("[say=artica]М-мне... п-продолжают сниться кошмары..[/say]")

		saynn("[say=pc]Кошмары? Они не дают тебе спать?[/say]")

		saynn("Она качает головой, оглядывая камеру, её голос то и дело срывается на всхлип...")

		saynn("[say=artica]Я п-понятия не имею... Я ч-что, с-сейчас сплю?..[/say]")

		saynn("Ох. Появляется чувство, что Артике совсем нехорошо.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "do_tease"):
		saynn("[say=pc]Артика..[/say]")

		saynn("Она почти не реагирует, когда ты протягиваешь руку и проводишь ею по её бедру; её тело напряжено и безжизненно.")

		saynn("Ты продолжаешь ласкать её бедро, водя пальцами вверх и вниз по меху, почти касаясь промежности, пытаясь вернуть искру жизни в её глаза.")

		saynn("[say=pc]Я всегда рядом.[/say]")

		saynn("По её телу пробегает легкая дрожь... но она почти не откликается.")

		saynn("[say=artica]Но... г-где я н-нахожусь?..[/say]")

		saynn("Лучше на этом остановиться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "")
	if(state == "do_sex"):
		saynn("[say=pc]Может, это тебе поможет..[/say]")

		saynn("Ты придвигаешься ближе, протягивая руку, чтобы коснуться её; твои пальцы скользят по её бедру, ожидая хоть какой-то реакции.. Но Артика остается почти неподвижной..")

		saynn("Твои прикосновения становятся смелее: рука проскальзывает между её ног, нежно потирая клитор. Снова реакция Артики минимальна — от стимуляции её киска даже не становится влажнее.")

		saynn("[say=artica]Ммм.. хх.. хх..[/say]")

		saynn("Похоже, Артика совсем потеряла сексуальное влечение. Стало даже хуже, чем когда она только прибыла в BDCC..")

		addButton("Хватит", "Пожалуй, не стоит давить на неё", "endthescene")
		addButtonWithChecks("Секс силой", "(некон) Как эта сучка смеет больше не раздвигать ноги с жадностью?", "force_sex", [], [[ButtonChecks.HasReachablePenis]])
	if(state == "force_sex"):
		playAnimation(StageScene.SexMissionary, "fast", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		saynn("Раздражённый отсутствием реакции, ты меняешь тон.")

		saynn("[say=pc]Хватит уже погрязнуть в жалости к себе. Может, тебе на самом деле только и хочется, чтобы тебе напомнили о твоем месте?[/say]")

		saynn("Ты широко раздвигаешь ноги Артики... и уже приставляешь свой {pc.penis} к её киске, решительно настроенный выбить из неё это дурацкое меланхоличное состояние.")

		saynn("[say=artica]Ах..[/say]")

		saynn("[say=pc]Ты всё равно всего лишь шлюха.[/say]")

		saynn("С этими словами ты входишь в неё своим членом, и резкое проникновение заставляет тело Артики содрогнуться. Она тихо ахает, её мышцы напрягаются, когда твой член наполняет её, растягивая её узкую киску...")

		saynn("Вскоре ты понимаешь, что она всё ещё совершенно сухая; от дискомфорта Артика сопротивляется, её разум всё ещё затуманен отчаянием... Но ты просто продолжаешь вколачивать в неё свой член, заставляя его входить внутрь, пока её сопротивление не начинает рушиться.")

		saynn("[say=artica]Х.. хх.. Я п-просто.. б-бесполезная сучка..[/say]")

		saynn("Артика скулит, её голос едва слышен за звуками шлепков твоих яичек о её задницу.")

		saynn("[say=artica]..н-ничего, к-кроме.. никчемной ш-шлюхи..[/say]")

		saynn("Её"+str(" caged" if isCaged else "")+"Твой член всё ещё бесполезен и никчемен, он даже не пытается встать колом в её тесноте, пока ты трахаешь её. Артика издаёт тихие звуки, пока ты трахаешь её насухую, прижимая её своими руками...")

		saynn("Её киска, может, и не слишком смазана... но она всё равно сжимается так туго, подгоняя тебя к самому пику. Может, тебе стоит оставить Артику вечной сломанной секс-игрушкой..")

		addButton("Кончить внутрь", "Оплодотворить пушинку", "do_cum_inside")
	if(state == "do_cum_inside"):
		playAnimation(StageScene.SexMissionary, "inside", {pc="pc", npc="artica", pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		var pcHasKnot = GM.pc.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)
		saynn("Наконец, ты с силой вгоняешь свой член глубоко внутрь,"+str(" knotting her pussy and" if pcHasKnot else "")+"пробивая её матку.")

		saynn("[say=artica]Ммм..[/say]")

		saynn("Тело Артики слегка дрожит... пока ты продолжаешь заливать её шлюшью щель своим горячим семенем, крепко удерживая её руками,"+str(" and primed for breeding" if !getCharacter("artica").isVisiblyPregnant() else "")+"")

		saynn("[say=pc]Чем быстрее ты будешь двигаться, тем лучше. Иначе мне придётся промыть тебе мозги, чтобы ты стал идеальным чехлом для члена.[/say]")

		saynn("[say=artica]П-промыть мозги?.. З-звучит.. х.. гх.. хорошо..[/say]")

		saynn("Ты выходишь, позволяя её набитой, покрытой синяками киске сочиться семенем прямо на простыни..")

		saynn("[say=artica]Ах..[/say]")

		saynn("И вот так, опустошив свои яйца внутри неё, ты оставляешь её одну.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_talk"):
		processTime(3*60)

	if(_action == "do_tease"):
		processTime(3*60)

	if(_action == "do_sex"):
		processTime(3*60)

	if(_action == "do_cum_inside"):
		processTime(3*60)
		getCharacter("artica").cummedInVaginaBy("pc")
		GM.pc.orgasmFrom("pc")

	setState(_action)

func saveData():
	var data = .saveData()

	data["isCaged"] = isCaged

	return data

func loadData(data):
	.loadData(data)

	isCaged = SAVE.loadVar(data, "isCaged", false)
