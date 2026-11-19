extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var articaCondom = false
var condomUsed = false
var condomBroke = false
var condomBreakChance = 0.0
var straponHasCum = false
var straponHasArticaCum = false
var isStraponSex = false
var isStroking = false
var isLicking = false

func _init():
	sceneID = "articaSexBreedScene"

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
		if (isNaked):
			saynn("Твой взгляд приковывает к себе белый пушок, ты намеренно задерживаешь на ней взор,"+str(" milky" if getCharacter("artica").isLactating() else "")+" {artica.breasts}.. пушистый"+str(" cute" if !getCharacter("artica").isVisiblyPregnant() else " round")+" животик.. её сомкнутые ноги, скрывающие"+str(" caged up" if isCaged else "n aroused")+" влагалище.. а также жаждущую киску, спрятанную за её яичками.")

		else:
			saynn("Твой взгляд приковывает к себе белый пушок, ты намеренно задерживаешь взгляд на её рубашке, скрывающей её {artica.breasts} и пушистый"+str(" cute" if !getCharacter("artica").isVisiblyPregnant() else " round")+" животик.. её шорты, прикрывающие её"+str(" caged up" if isCaged else "n aroused")+" влагалище.. а также жаждущую киску за её яичками.")

		saynn("Она замечает твой жадный взгляд; от такого внимания её пушистое тело начинает подрагивать. Ты буквально... чувствуешь... как её запах становится всё сильнее с каждой секундой твоего созерцания.")

		if (isVerySlut):
			saynn("[say=artica]Я.. я ч-что, выгляжу как ш-шлюшка?..[/say]")

		elif (isSlut):
			saynn("[say=artica]Т-ты..[/say]")

		else:
			saynn("[say=artica]Что ты... т-творишь..[/say]")

		saynn("С хищной ухмылкой ты внезапно хватаешь её за воротник и тянешь в сторону своей камеры.")

		saynn("[say=artica]..и-ик!..[/say]")

		addButton("Камера", "Затащить пушистую в камеру", "in_cell")
	if(state == "in_cell"):
		addCharacter("artica", ["naked"])
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		playAnimation(StageScene.SexPawLick, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Как только вы заходите в твоё тесное жилище, Артика оказывается прижатой к кровати."+str(", your hands remove her clothes in seconds and are already exploring her forms, spreading her legs" if !isNaked else ", your hands already start exploring her forms and spreading her legs")+".")

		saynn("[say=artica]Ах..[/say]")

		saynn("Какой великолепный вид... застенчивое, раскрасневшееся личико, которое уже тихонько посапывает от возбуждения..."+str("swollen milky tits with dark cyan perky nips that have purple piercings in them" if getCharacter("artica").isLactating() else "modest round tits with cyan perky nips that have purple piercings in them")+".. её узкая голубая щелочка, спрятанная под пушистыми яичками...")

		saynn("Пушистая прикусывает губу, её глаза стараются избегать твоего взгляда...")

		var isPreg = getCharacter("artica").isPregnant()
		if (GM.pc.hasReachablePenis()):
			if (isVerySlut):
				if (isPreg):
					saynn("[say=artica]У м-меня внутри уже и так большой помёт.. н-но мы всегда можем попытаться с-сделать ещё.. П-пожалуйста.. Вытряси из м-меня все мысли..[/say]")

				else:
					saynn("[say=artica]П-пожалуйста.. мне н-нужен твой член внутри.. чтобы он растянул меня.. заполнил меня до краев, пока я совсем не п-перестану соображать..[/say]")

					saynn("Ну и рот у неё..")

			elif (isSlut):
				if (isPreg):
					saynn("[say=artica]У м-меня и так внутри целое о-огромное потомство.. н-но мы всегда можем попытаться с-сделать ещё..[/say]")

				else:
					saynn("[say=artica]П-пожалуйста.. твой ч-член.. внутрь м-меня..[/say]")

			else:
				if (isPreg):
					saynn("[say=artica]У м-меня и так внутри целое о-огромное потомство..[/say]")

				else:
					saynn("[say=artica]П-пожалуйста.. твой ч-член.. ах..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "what_do")
	if(state == "wear_condom_pick"):
		saynn("Какой презерватив ты хочешь надеть на свой член?")

		addButton("Лучший презерватив", "Надеть лучший презерватив", "wear_condom_best")
		addButton("Худший презерватив", "Надеть самый хреновый презерватив", "wear_condom_worst")
	if(state == "after_wear_condom"):
		playAnimation(StageScene.SexPawLick, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Ты быстро зубами разрываешь упаковку одного из презервативов и натягиваешь его на свой член.")

		if (getCharacter("artica").isVisiblyPregnant()):
			saynn("Артика смотрит на свой беременный живот.. и вопросительно наклоняет голову, глядя на тебя.")

			saynn("[say=pc]Не люблю я этот беспорядок.[/say]")

			saynn("[say=artica]Э-это... с-справедливо...[/say]")

			saynn("Очевидно, что она не в восторге.")

		else:
			saynn("Артика смотрит на свой живот... а затем вопросительно наклоняет голову, глядя на тебя.")

			saynn("[say=pc]Не особо-то мне хочется от тебя забеременеть...[/say]")

			saynn("[say=artica]Э-это... с-справедливо...[/say]")

			saynn("Похоже, презервативы её не особо радуют. Хм.")

		addButton("Продолжить", "Смотреть, что будет дальше", "what_do")
	if(state == "add_condom_on_artica"):
		playAnimation(StageScene.SexPawLick, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Ты с треском разрываешь упаковку презерватива и начинаешь надевать его на голубой член Артики, пока она извивается!")

		saynn("[say=artica]Ах... Но я н-не собираюсь...[/say]")

		saynn("[say=pc]Еще как собираешься. Прямо на себя.[/say]")

		saynn("Она густо краснеет.")

		saynn("[say=artica]Н-наверное..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "what_do")
	if(state == "picked_strapon"):
		playAnimation(StageScene.SexPawLick, "tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Вы закрепляете страпон на талии!"+str(" One that is loaded.." if straponHasCum else "")+""+str(" One that is loaded with Artica's cum.." if straponHasArticaCum else "")+"")

		saynn("[say=artica]Ох.. вау..[/say]")

		if (straponHasCum || straponHasArticaCum):
			saynn("[say=pc]Тебе нравится? Содержимое тебе понравится еще больше~. Давай повеселимся.[/say]")

		else:
			saynn("[say=pc]Тебе нравится~? Давай повеселимся.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "what_do")
	if(state == "start_stroke_cock"):
		playAnimation(StageScene.SexPawLick, "stroketease", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Одна ваша рука ложится на твердый член Артики.. и начинает ласкать его.")

		saynn("[say=artica]И-ик..[/say]")

		saynn("[say=pc]Что~? Ты уже готова кончить? Ну же, малышка, держи себя в руках.[/say]")

		saynn("Пушистая плоть извивается, её бедра слегка подергиваются в такт движениям вашей руки.. из-за чего вам приходится замедлиться.")

		saynn("[say=pc]Не так быстро. Ты кончаешь только от моего"+str(" cock" if GM.pc.hasReachablePenis() else " toy")+", слышишь?[/say]")

		saynn("[say=artica]..ах.. д-да..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "what_do")
	if(state == "select_strapon_menu"):
		saynn("Какой страпон хочешь использовать?")

		addStraponButtons()
		addButton("Назад", "Вы передумали", "what_do")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_put_on_strapon")
	if(state == "what_do"):
		playAnimation(StageScene.SexPawLick, ("stroke" if isStroking else "")+"tease", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Что ты хочешь сделать?")

		if (GM.pc.hasReachablePenis()):
			if (condomUsed):
				addButton("Трахни её!", "Время для безопасного секса", "start_fuck")
			else:
				addButton("Оплодотвори её!", "Время развлечься", "start_fuck")
				addButtonWithChecks("Надеть презерватив", "Надеть презерватив", "wear_condom_pick", [], [[ButtonChecks.HasCondoms]])
		else:
			if (GM.pc.isWearingStrapon()):
				addButton("Трахнуть её", "Заставь эту пушистику извиваться", "start_strapon_fuck")
			else:
				addDisabledButton("Оплодотвори её!", "Твой член сейчас недосягаем...")
				addButtonWithChecks("Надеть страпон", "Выбери, какой страпон ты хочешь надеть", "select_strapon_menu", [], [[ButtonChecks.HasStraponAndCanWear]])
		if (!articaCondom):
			addButtonWithChecks("Надеть на неё презерватив", "Надень на Артику презерватив, чтобы избежать беспорядка в будущем...", "add_condom_on_artica", [], [[ButtonChecks.HasCondoms]])
		if (!isStroking && !isCaged):
			addButton("Ласкай её", "Одновременно ласкай её член", "start_stroke_cock")
		addButton("Отмена", "Ты передумал", "endthescene")
	if(state == "start_fuck"):
		playAnimation(StageScene.SexPawLick, ("stroke" if isStroking else "")+"sex", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		saynn("Артика ахает, когда ты вонзаешь свой "+str("hard cock" if !isStraponSex else "shiny strapon")+" в её сочащуюся похотью киску, её влажные стенки насильно растягиваются, принимая твою "+str(" rubber" if isStraponSex else "")+"толщину и длину... Один толчок быстро сменяется другим, твой "+str("cock" if !isStraponSex else "toy")+" жадно погружается в эту... тугую... сжимающую... киску."+str(" All the while your hand keeps stroking her off, still at a teasing pace!" if isStroking else "")+"")

		saynn("[say=artica]Ах!.. Н-не т-так с-слишком.. ах..ах..ах..[/say]")

		if (isStroking):
			saynn("Кажется, даже это слишком быстро для бедной пушистки...")

		saynn("[say=pc]С чего бы мне замедляться? Твоя шлюшья киска сама умоляет о трахе.[/say]")

		saynn("Её стоны наполняют камеру, пока ты находишь свой ритм, а её "+str(" own" if !isStraponSex else "")+" "+str("cock quickly getting fully hard and swaying back and forth, precum leaking from the tip" if !isCaged else "locked away cock is pushing on its cage, trying to leave the sheath, precum leaking from the peeking tip")+". Пушистка извивается на кровати, пальцы ног поджимаются, ноги раздвигаются всё шире, а её влажные складки затягивают тебя всё глубже в её бархатистое тепло..."+str(" not that you can feel that through the strapon.. but it still feels nice.." if isStraponSex else "")+"")

		saynn("Пока продолжаются грубые толчки, задняя лапа Артики находит твоё лицо... её когти нежно дразнят твою щеку... бирюзовые подушечки лап массируют её...")

		addButton("Лизать лапу", "Оближи лапку, которая прямо перед тобой", "sex_fast_lick")
		addButton("Не облизывать", "Просто трахай её сильнее", "sex_fast")
	if(state == "sex_fast"):
		playAnimation(StageScene.SexPawLick, ("stroke" if isStroking else "")+"fast", {pc="pc", npc="artica", bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		if (isLicking):
			saynn("Как можно отказывать её мягкой задней лапке?.. Ты продолжаешь трахать девчонку, уткнувшись носом в её голубые подушечки; твой язык высунут и время от времени слизывает их, ощущая их шероховатую текстуру...")

		else:
			saynn("Ты игнорируешь мягкие задние лапки девчонки и просто продолжаешь трахать её, отодвигая её пальцы, когда они становятся слишком навязчивыми и лезут под руку.")

			saynn("[say=pc]Я не лапозависимая, это ты такой![/say]")

		saynn("Её киска продолжает сжиматься вокруг твоего "+str("cock" if !isStraponSex else "rubber shaft, increasing friction")+".. но ты продолжаешь долбить её, преодолевая её сопротивление грубой силой. При каждом толчке над её промежностью вздувается бугорок, твой "+str("member" if !isStraponSex else "strapon")+" с силой вбивается в её естественную стенку, пытаясь прорваться прямиком в матку.")

		saynn("[say=artica]Ах-х.. н-настолько интен-сивно.. боги.. ах.. я.. м.. к-кончаю.. ах..[/say]")

		if (isStroking):
			saynn(""+str("The knot on the base of the cyan shaft that you're stroking is inflating with blood" if !isCaged else "Her cute caged up cock is desperately twitching in its small prison")+", её киска подергивалась, извергая слабые струйки соков, а от интенсивного жесткого траха её пушистая плоть впивалась в простыни, заставляя её запрокидывать голову.")

		else:
			saynn(""+str("The knot on the base of the cyan shaft is inflating with blood" if !isCaged else "Her cute caged up cock is desperately twitching in its small prison")+", её киска подергивалась, извергая слабые струйки соков, а от интенсивного, грубого траха её пушистая плоть впивалась в простыни, заставляя её запрокидывать голову.")

		if (isStraponSex):
			saynn("Она близко.. ты чувствуешь это.. ты даже чуешь это..")

		else:
			saynn("Она уже близко... ты это чувствуешь... ты это даже чуешь... Кажется, ты тоже вот-вот кончишь...")

		if (isStraponSex):
			addButton("Кульминация", "Посмотри, что будет!", "sex_cum")
		else:
			addButton("Кончить внутрь", "Оплодотворить пушинку", "sex_cum")
	if(state == "sex_cum"):
		playAnimation(StageScene.SexPawLick, ("stroke" if isStroking else "")+"inside", {pc="pc", npc="artica", pcCum=true, npcCum=true, bodyState={naked=true, hard=true, condom=condomUsed}, npcBodyState={naked=true, hard=true, condom=articaCondom}})
		if (isStraponSex):
			if (straponHasArticaCum || straponHasCum):
				saynn("Пизда Артики не просто сжимается вокруг твоего резинового члена... она спазмирует, а скользкие стенки так и норовят выдоить его до капли. Так что, конечно, с первобытным рыком, ты вгоняешь свою игрушку глубоко в эту шлюшью дырку... пока экстремальная теснота не заставляет её извергнуться...")

				saynn("Ты улыбаешься, пока твой страпон пульсирует, закачивая в матку Артики её собственную горячую, плодовитую сперму..")

				saynn("[say=artica]Ох.. ии-ип.. няяяя..-аах..[/say]")

				if (!getCharacter("artica").isVisiblyPregnant()):
					saynn("[say=pc]Заберемени, жадная шлюха."+str("Enjoy your own pups." if straponHasArticaCum else "Enjoy someone's pups.")+"[/say]")

					saynn("[say=artica]Ч-что?..[/say]")

					saynn("[say=pc]Как думаешь, чьей спермой я набила страпон~?[/say]")

					saynn("[say=artica]С-с-сперма?.. ахх-х..[/say]")

				else:
					saynn("[say=pc]Нгх.. Буду осеменять тебя, даже когда ты будешь беременна. Наслаждайся "+str("your own" if straponHasArticaCum else "someone's")+" спермой внутри себя.[/say]")

					saynn("[say=artica]С-с-сперма?.. ахх-х..[/say]")

			else:
				saynn("Киска Артики не просто сжимается вокруг твоего резинового члена... она спазмирует, а скользкие стенки пытаются выжать из него всё до капли. И тогда, с первобытным рыком, ты вгоняешь свою игрушку глубоко в эту шлюшью дырочку, позволяя Артике кончить прямо на неё..")

				saynn("[say=artica]Ох.. ии-ип.. няяяя..-аах..[/say]")

				saynn("[say=pc]Какая жадная девочка.. но с ней так легко справиться.[/say]")

		elif (!condomUsed):
			saynn("Киска Артики не просто сжимается вокруг твоего члена... она спазмирует, а скользкие стенки настойчиво доят тебя. И тогда, с первобытным рыком, ты вгоняешь свой член в эту шлюшью дырочку, давая ему пульсировать и изливая горячее семя глубоко внутрь, заполняя её утробу до краев..")

			saynn("[say=artica]Ох.. ии-ип.. няяяя..-аах..[/say]")

			if (!getCharacter("artica").isVisiblyPregnant()):
				saynn("[say=pc]Беременей, жадная сучка.[/say]")

			else:
				saynn("[say=pc]Нгх.. Я буду осеменять тебя, даже когда ты уже беременна.[/say]")

		elif (condomBroke):
			saynn("Пизда Артики не просто сжимается вокруг твоего члена... она спазмирует, а влажные стенки с силой доят тебя. И тогда, издав первобытный рык, ты с силой вгоняешь свой член в эту шлюшью дырку и даешь ему пульсировать, извергая горячее семя в презерватив внутри Артики. Но что-то не так...")

			saynn("[say=artica]Ох.. и-ип.. ня-а-а-а..-ах.. так х-хор..[/say]")

			saynn("Ты слегка отстраняешься и замечаешь, что презерватив действительно... лопнул... [b]Все его содержимое выливается прямо в матку Артики![/b]")

			if (getCharacter("artica").isVisiblyPregnant()):
				saynn("[say=pc]Упс.. По крайней мере, ты уже беременна.[/say]")

			else:
				saynn("[say=pc]Упс.. Кто-то может забеременеть...[/say]")

			saynn("[say=artica]Ч-что?.. А!..[/say]")

			saynn("Пушистик слишком... занят... чтобы среагировать.")

		else:
			saynn("Пизда Артики не просто сжимается вокруг твоего члена... она спазмирует, а влажные стенки с силой доят тебя. И тогда, издав первобытный рык, ты с силой вгоняешь свой член в эту шлюшью дырку и даешь ему пульсировать, извергая горячее семя в презерватив внутри Артики, где оно остается надежно запертым...")

			saynn("[say=artica]Ох.. ии-ип.. няяяя..-аах..[/say]")

			saynn("[say=pc]Какая ненасытная шлюшка.[/say]")

		if (!articaCondom):
			saynn("Её тело содрогается от удовольствия, когда волны оргазма, её"+str(" own" if !isStraponSex else "")+" член дёргается"+str(" in your hand" if isStroking else "")+" и извергает "+str("powerful" if !isCaged else "weak")+"струи густого семени"+str(" from inside its cage.. that land onto her belly and tits.." if isCaged else ".. that land onto her tits and face..")+"")

		else:
			saynn("Её тело содрогается от удовольствия, когда волны оргазма, её"+str(" own" if !isStraponSex else "")+" член дёргается"+str(" in your hand" if isStroking else "")+" и извергает "+str("powerful" if !isCaged else "weak")+"струи густого семени"+str(" from inside its cage.. that land onto her belly and tits.." if isCaged else " into the condom, making it sag more and more under its own weight..")+"")

		if (isStraponSex):
			saynn("Ты остаёшься внутри неё и с огромным интересом наблюдаешь за тем, как Артика переживает свой пик...")

		elif (!condomUsed):
			saynn("Ты остаёшься внутри неё и кряхтишь, пока её теснота пытается вытянуть всё твоё семя... даже когда твой оргазм начинает угасать.")

		elif (condomBroke):
			saynn("После всего случившегося можно и не сдерживаться... Ты остаешься внутри неё и кряхтишь, пока её теснота пытается вытянуть всё твоё накопленное семя... даже когда оргазм начинает затихать.")

		else:
			saynn("Доверившись презервативу, ты остаешься внутри неё и кряхтишь, пока её теснота пытается вытянуть всё твоё накопленное семя... даже когда оргазм начинает затихать.")

		saynn("[say=artica]Нх-хх.. с-слишком.. м-много..[/say]")

		saynn("Её рука ложится на низ живота и нежно поглаживает его, пальцы очерчивают точную форму твоего "+str("cock" if !isStraponSex else "strapon")+".."+str(" while you still idly stroke her cock, milking all of her remaning seed out.." if isStroking else "")+"")

		saynn("Пора расслабиться.")

		addButton("Обнимашки", "Немного заботы после секса — это мило", "do_cuddle")
	if(state == "do_cuddle"):
		playAnimation(StageScene.Cuddling, "idle", {pc="pc", npc="artica", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!condomUsed):
			if (isStraponSex):
				saynn("После такого жесткого траха иногда приятно просто потискать пушистую макушку. Ты притягиваешь Артику к себе и нежно обнимаешь её."+str("Her stuffed cyan cunt is dripping her own seed onto your bed.." if straponHasArticaCum else "")+""+str("Her stuffed cyan cunt is dripping someone's seed onto your bed.." if (straponHasCum && !straponHasArticaCum) else "")+"")

			else:
				saynn("После такого жесткого траха иногда приятно просто потискать пушистую макушку. Ты притягиваешь Артику к себе и нежно обнимаешь её. Её набитая циановая киска так и сочится твоим семенем прямо на кровать...")

			if (straponHasArticaCum && !getCharacter("artica").isVisiblyPregnant()):
				saynn("[say=artica]Я.. я м-могу за-забеременеть.. от с-собственной с-спермы..[/say]")

				saynn("[say=pc]В этом-то и план, да~.[/say]")

				saynn("[say=artica]Я бы.. вынашивала с-своих щенков.. х.. ха-ха..[/say]")

			elif (straponHasArticaCum && getCharacter("artica").isVisiblyPregnant()):
				saynn("[say=artica]Ты ис-использовал м-мою сперму..[/say]")

				saynn("Вы гладите её беременный живот.")

				saynn("[say=pc]Ты уже залетела, глупышка.[/say]")

				saynn("[say=artica]Д-да.. правда.. х.. ха-ха..[/say]")

			elif (isVerySlut || isSlut):
				saynn("[say=artica]Н-ня.. я т-такая.. грязная.. членососка..[/say]")

				saynn("[say=pc]Мягкая и готовая к размножению грязная членососка.[/say]")

				saynn("[say=artica]..х.. ха-ха..[/say]")

			else:
				saynn("[say=artica]Н-ня.. я т-такая.. грязная..[/say]")

				saynn("Она осекается.")

				saynn("[say=pc]Кто тут грязнуля?[/say]")

				saynn("[say=artica]П-просто.. м-мягко..[/say]")

				saynn("Ты посмеиваешься и тыкаешь её в носик.")

				saynn("[say=pc]Ты грязная шлюшка, Артика.[/say]")

				saynn("[say=artica]Ой...[/say]")

		elif (condomBroke):
			saynn("После такого жесткого траха иногда приятно просто потискать её пушистое тело. Ты притягиваешь Артику к себе и обнимаешь её. Её набитая голубая киска сочит твою сперму прямо на кровать... И тут Артика наконец это замечает...")

			saynn("[say=artica]Гм.. п-погоди.. т-ты же надел пр-презерватив..[/say]")

			saynn("[say=pc]Надел.[/say]")

			saynn("Ты показываешь ей лопнувшую резину.")

			saynn("[say=artica]Ооооооооохх..-хх..[/say]")

			if (getCharacter("artica").isVisiblyPregnant()):
				saynn("Вы гладите её беременный живот.")

				saynn("[say=pc]Ты уже всё равно залетаешь, какая разница.[/say]")

				saynn("[say=artica]..д-да..[/say]")

			else:
				saynn("Ты гладишь её по животу.")

				saynn("[say=pc]Чтобы ты могла стать мамочкой.[/say]")

				saynn("[say=artica]..д-да..[/say]")

		else:
			saynn("После такого жесткого траха иногда так приятно просто потискать эту пушистую крошку. Выбросив использованный презерватив, ты притягиваешь Артику к себе и нежно обнимаешь её. Её"+str(" clean" if !getCharacter("artica").hasEffect(StatusEffect.HasCumInsideVagina) else "")+" бирюзовая киска сочит соки прямо на твою кровать..")

			if (isVerySlut || isSlut):
				saynn("[say=artica]Н-ня.. Б-без презерватива в сл-следующий раз?..[/say]")

				if (getCharacter("artica").isVisiblyPregnant()):
					saynn("[say=pc]Ого, кто-то тут хочет стать беременной спермобакшей?[/say]")

					saynn("[say=artica]..х.. ха-ха.. ..в-всегда..[/say]")

				else:
					saynn("[say=pc]Ого, кто-то жаждет, чтобы его осеменили.[/say]")

					saynn("[say=artica]..х.. ха-ха..[/say]")

			else:
				saynn("[say=artica]Н-ня.. я.. такая.. текучая..[/say]")

				saynn("Она осекается.")

				saynn("[say=pc]Текучая кто?[/say]")

				saynn("[say=artica]П-просто.. т-текучая..[/say]")

				saynn("Ты посмеиваешься и тыкаешь её в носик.")

				saynn("[say=pc]Ты текучая шлюшка, Артика.[/say]")

				saynn("[say=artica]Ой...[/say]")

		if (articaCondom):
			saynn("Осторожно, ты"+str(" also" if condomUsed else "")+" снимаешь презерватив с члена Артики, после чего аккуратно завязываешь его и выбрасываешь.")

		saynn("Вы проводите так некоторое время.. прежде чем ты отправляешь её на её привычное место.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "do_put_on_strapon", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_cell"):
		processTime(3*60)

	if(_action == "wear_condom_best"):
		condomUsed = true
		condomBreakChance = GM.pc.useBestCondom()
		setState("after_wear_condom")
		return

	if(_action == "wear_condom_worst"):
		condomUsed = true
		condomBreakChance = GM.pc.useWorstCondom()
		setState("after_wear_condom")
		return

	if(_action == "do_put_on_strapon"):
		processTime(2*60)
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		var theFluids = strapon.getFluids()
		if(theFluids != null):
			if(theFluids.hasFluidTypeWithCharID("Cum", "artica")):
				straponHasArticaCum = true
			if(theFluids.hasFluidType("Cum")):
				straponHasCum = true
		isStraponSex = true
		setState("picked_strapon")
		return

	if(_action == "start_strapon_fuck"):
		isStraponSex = true
		setState("start_fuck")
		return

	if(_action == "add_condom_on_artica"):
		articaCondom = true
		GM.pc.useWorstCondom()

	if(_action == "start_stroke_cock"):
		isStroking = true

	if(_action == "sex_fast_lick"):
		processTime(5*60)
		isLicking = true
		setState("sex_fast")
		return

	if(_action == "sex_fast"):
		processTime(5*60)

	if(_action == "sex_cum"):
		processTime(6*60)
		getModule("ArticaModule").triggerCorruption(0.02)
		if(condomUsed):
			condomBroke = GM.pc.shouldCondomBreakWhenFucking("artica", condomBreakChance)
			if(!condomBroke):
				addFilledCondomToLootIfPerk(GM.pc.createFilledCondom())
		
		if(!condomUsed || condomBroke):
			getCharacter("artica").cummedInVaginaByAdvanced("pc", {knotted=false,condomBroke=condomBroke,engulfed=false})
		
		if(articaCondom):
			addFilledCondomToLootIfPerk(getCharacter("artica").createFilledCondom())
		else:
			getCharacter("artica").cummedOnBy("artica")
		
		GM.pc.orgasmFrom("artica")

	if(_action == "do_cuddle"):
		processTime(20*60)
		GM.pc.unequipStrapon()

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
	data["articaCondom"] = articaCondom
	data["condomUsed"] = condomUsed
	data["condomBroke"] = condomBroke
	data["condomBreakChance"] = condomBreakChance
	data["straponHasCum"] = straponHasCum
	data["straponHasArticaCum"] = straponHasArticaCum
	data["isStraponSex"] = isStraponSex
	data["isStroking"] = isStroking
	data["isLicking"] = isLicking

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
	articaCondom = SAVE.loadVar(data, "articaCondom", false)
	condomUsed = SAVE.loadVar(data, "condomUsed", false)
	condomBroke = SAVE.loadVar(data, "condomBroke", false)
	condomBreakChance = SAVE.loadVar(data, "condomBreakChance", 0.0)
	straponHasCum = SAVE.loadVar(data, "straponHasCum", false)
	straponHasArticaCum = SAVE.loadVar(data, "straponHasArticaCum", false)
	isStraponSex = SAVE.loadVar(data, "isStraponSex", false)
	isStroking = SAVE.loadVar(data, "isStroking", false)
	isLicking = SAVE.loadVar(data, "isLicking", false)
