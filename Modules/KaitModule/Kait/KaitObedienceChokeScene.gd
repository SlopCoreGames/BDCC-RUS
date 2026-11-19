extends SceneBase

var usedStrapon = false
var defStrapon = false
var straponHasCum = false

func _init():
	sceneID = "KaitObedienceChokeScene"

func _run():
	if(state == ""):
		addCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("Ты подходишь ближе к Кейт и кладешь руку на её ошейник, нащупывая толстое металлическое кольцо, за которое крепится поводок.")

		saynn("[say=pc]Тебе нравится этот ошейник, Кейт?[/say]")

		saynn("[say=kait]А? Я бунтарка, свободная духом воительница, я ненавижу его всей душой. Если бы могла, швырнула бы его в бездну. Конечно, без меня внутри...[/say]")

		saynn("Логично. Ты слегка тянешь за ошейник влево и вправо, заставляя Кейт поворачивать голову вслед за твоей рукой.")

		saynn("[say=pc]Он громоздкий. И очень туго сидит на шее, верно?[/say]")

		saynn("[say=kait]Да? Есть такое.[/say]")

		saynn("Тебе удается просунуть под него два пальца, зажав кожу между шеей Кейт и едва мягким внутренним кольцом. На мгновение её дыхание перехватывает.")

		saynn("[say=pc]Теперь стало еще теснее.[/say]")

		saynn("[say=kait]Ох... ох, черт...[/say]")

		saynn("Кейт задирает подбородок и слышно сглатывает... ты чувствуешь, как напрягается её горло в этот момент.")

		saynn("[say=pc]Тебе нравится?[/say]")

		saynn("[say=kait]Ну.. хах.. это всё, на что ты способен?..[/say]")

		saynn("Звучит как вызов.")

		addButton("Сжать крепче", "Сжать её шею покрепче", "grab_neck")
	if(state == "grab_neck"):
		playAnimation(StageScene.Choking, "idle", {pc="pc", npc="kait"})
		saynn("Твоя свободная рука тянется к шее Кейт, пальцы обхватывают её горло, оказывая мягкое давление. Достаточное, чтобы освободить пальцы из-под воротника.")

		saynn("[say=kait]Вот так.. уже лучше~.[/say]")

		saynn("Её дыхание становится медленным и глубоким, губы слегка приоткрываются, чтобы поймать хоть немного воздуха.")

		saynn("[say=pc]А что бы ты сделала, если бы охранник сделал тебе так же?[/say]")

		saynn("[say=kait]Я бы сопротивлялась. Очевидно же..[/say]")

		saynn("[say=pc]Покажи мне.[/say]")

		saynn("Её лапы метнулись к твоей руке. Она пытается отцепить её, тянет на себя. Но ты не отпускаешь, постепенно усиливая хватку.")

		saynn("[say=pc]Ну и? Это всё, на что ты способна?[/say]")

		saynn("Уши Кейт встали торчком, а глаза мгновенно заблестели, когда она услышала твои слова.")

		saynn("[say=kait] Ну, держись![/say]")

		saynn("Её когти внезапно впиваются в твое предплечье — не настолько глубоко, чтобы продрать кожу, но достаточно, чтобы оставить следы. В её груди начинает нарастать низкое рычание. Она с силой дергает твою руку, но твоя хватка всё еще держится.")

		saynn("[say=pc] Теперь мой черед.[/say]")

		saynn("Ты сжимаешь её горло еще крепче, перекрывая Кейт дыхание на несколько секунд. Она начинает метаться, её хвост яростно хлещет по воздуху, а свободная лапа пытается зацепить твое плечо. Ты чувствуешь жжение от её когтей... но терпишь.")

		saynn("Причиной того, что ты ослабляешь хватку, становится её внезапный пинок тебе в ногу.")

		saynn("[say=kait]Нгх... я не сдамся... так просто...[/say]")

		saynn("И тогда ты тянешь её еще выше, заставляя встать на цыпочки, пока её тело извивается и пытается вырваться.")

		saynn("Твоя свободная рука спускается к её рубашке. Пальцы нащупывают пуговицы, расстегивая их одну за другой. Тем временем Kait начинает метаться всё сильнее, её лапы впиваются в твои запястья, в твою руку... во всё, до чего она может дотянуться.")

		saynn("[say=pc]Ты ведь даже не стараешься, верно?[/say]")

		saynn("[say=kait]Ах... хах... грубиян. Грр...[/say]")

		saynn("Она скалит клыки. Ты распахиваешь её рубашку, обнажая скромную грудь. Ты накрываешь одну из грудей ладонью, разминая мягкую плоть, а большим пальцем растираешь твердый сосок. Дыхание Кейт сбивается, её ноги дрожат. Из её горла вырывается очередное рычание.")

		saynn("[say=pc]Я буду трогать тебя везде. И тебе ничего не останется.[/say]")

		saynn("[say=kait]П-попробуй![/say]")

		saynn("Ты щипаешь её за сосок, заставляя взвизгнуть. Её когти впиваются в твою руку ещё глубже, оставляя новые царапины.")

		saynn("Затем ты тянешься вниз и стягиваешь с неё шорты, спуская их по бёдрам и обнажая её милую розовую киску; её складки кажутся влажными даже в тусклом свете. Ты проводишь пальцем вдоль её щели, заставляя её вздрогнуть.")

		saynn("[say=pc]Ты... станешь моей секс-игрушкой.[/say]")

		saynn("[say=kait]Ммм... ..заставь меня~..[/say]")

		if (!GM.pc.hasReachablePenis()):
			addButton("Прижать её к полу", "Надеть страпон и прижать Кейт к полу!", "pin_pick_menu")
		else:
			addButton("Прижать её", "Прижать Кейт к полу", "pin_her_down")
	if(state == "pin_pick_menu"):
		saynn("Выбери, какой страпон ты хочешь использовать против Кейт!")

		addButton("По умолчанию", "Использовать любой страпон, что завалялся в убежище", "choose_strapon_def")
		addStraponButtons()
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "choose_strapon_pick")
	if(state == "pin_her_down"):
		addCharacter("kait", ["naked"])
		playAnimation(StageScene.SexChoke, "tease", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (usedStrapon):
			saynn("Ты быстро закрепляешь ремни страпона на талии... а затем...")

		saynn("Ты вжимаешь Кейт в холодный пол, продолжая душить её, пока другая рука высоко задирает её ногу, широко раздвигая ей бёдра.")

		saynn("Твоя "+str("{pc.penis}" if !usedStrapon else "rubber toy")+" уже прижат к её влажному входу, осыпая поцелуями её скользкие складки. Кейт смотрит на тебя широко раскрытыми глазами, её грудь тяжело вздымается.")

		saynn("[say=kait]Это... всё, на что ты способен?..[/say]")

		saynn("Она сама напрашивается.")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_sex")
	if(state == "start_sex"):
		playAnimation(StageScene.SexChoke, "sex", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты не отвечаешь... ты просто с силой вгоняешь свой"+str(" rubber" if usedStrapon else "")+"член в неё одним мощным толчком, уходя до самого основания в её тугую, влажную киску. Глаза Кейт расширяются, из её губ вырывается сдавленный всхлип, а спина выгибается над холодным полом.")

		saynn("[say=kait]Блядь..![/say]")

		saynn("Её киска мгновенно сжимается вокруг тебя, влажные стенки обхватывают твой"+str("strapon's" if usedStrapon else "your")+"член... уже пытаясь выдоить его.")

		saynn("Ты медленно отстраняешься... а затем снова входишь в неё. На этот раз сильнее. Влажный звук того, как ты"+str("cock" if !usedStrapon else "toy")+"растягиваешь её, эхом разносится по комнате.")

		saynn("[say=kait]Ннгх.. ах..[/say]")

		saynn("Её когти снова впиваются в твое предплечье — она всё ещё пытается отцепить твою руку от своего горла, её тело извивается под тобой в попытке вернуть контроль... но ты не даёшь ей ни шанса. Ты задаёшь темп, раз за разом вколачиваясь глубоко в неё.")

		saynn("Ты снова крепче сжимаешь её шею... и чувствуешь, как её киска в ответ судорожно сжимается вокруг тебя. Из её губ вырывается придушенный стон.")

		saynn("[say=pc]Секс-игрушка.[/say]")

		saynn("[say=kait]Я.. свирепая.. ах.. бунтарка..[/say]")

		saynn("Всё тело Кейт дрожит, когда кончик твоего"+str(" cock" if !usedStrapon else " strapon")+" с каждым толчком с силой врезается ей в шейку матки. Ну и боец.")

		addButton("Быстрее", "Трахать её быстрее", "sex_faster")
	if(state == "sex_faster"):
		playAnimation(StageScene.SexChoke, "fast", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься и сжимаешь хватку ещё сильнее, полностью перекрывая ей воздух. Её глаза начинают слегка закатываться, а киска сжимает тебя так туго,"+str(" you almost see stars" if !usedStrapon else ", you have to put extra strength to push through")+".")

		saynn("[say=kait]Ммм..-х..[/say]")

		saynn("Её когтистые лапки оставляют всё больше царапин, свободная нога слабо дрыгается — борьба быстро вытягивает из неё силы.")

		saynn("Твои бёдра с громким шлепком бьются о её бёдра. Она так течёт, что её соки стекают по пушистой заднице прямо на пол.")

		saynn("Рот Кейт широко открыт.. но звуков нет. Её лапки лишь судорожно вцепились в твоё запястье, которое её душит.")

		if (!usedStrapon):
			saynn("Она кончает.. бесшумно. Это так охеренно.. её киска внезапно начинает судорожно сжиматься, обхватывая и доя твой член каждым толчком. Её тело дрожит, а большие испуганные глаза полузакрыты.")

		else:
			saynn("Она кончает... тихо. Это приятно... её киска внезапно сжимается, обхватывая твой резиновый член. Её тело дрожит, а большие, затуманенные глаза полуприкрыты.")

		addButton("Дать ей подышать", "Давай ей дышать, пока трахаешь... но совсем чуть-чуть", "let_breathe")
		addButton("Сжимай сильнее", "(Секс в бессознательном состоянии) Продолжай крепко душить её", "keep_choking")
	if(state == "keep_choking"):
		playAnimation(StageScene.SexChoke, "fast", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}, uncon=true})
		saynn("Ты не даешь ей вздохнуть даже сейчас, вколачиваясь в неё всё сильнее и глубже, душа её прямо во время оргазма. В твоих глазах вспыхивает животная страсть... и ты позволяешь ей полностью завладеть тобой.")

		saynn("[say=kait]..[/say]")

		saynn("Спустя несколько секунд... её глаза закрываются, тело замирает, лапки соскальзывают с твоего запястья и падают на пол рядом с грудью. Она отключилась.")

		saynn("[say=pc]Блядь.[/say]")

		saynn("И всё же ты продолжаешь, вбивая член глубоко в её бессознательное тело, заставляя её киску продолжать судорожно сжиматься вокруг тебя.")

		if (!usedStrapon):
			addButton("Кончить внутрь", "Оплодотвори эту кошечку", "keep_cum_inside")
		else:
			addButton("Всаживай на полную", "Засунь игрушку целиком", "keep_cum_inside")
	if(state == "keep_cum_inside"):
		playAnimation(StageScene.SexChoke, "inside", {pc="pc", npc="kait", pcCum=!usedStrapon, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}, uncon=true})
		if (!usedStrapon):
			saynn("Ты входишь глубоко в последний раз и просто отдаешься оргазму. Твой {pc.penis} начинает пульсировать внутри Кейт, выплескивая горячую {pc.cum} глубоко в её подергивающуюся киску. Струя за струей наполняют её матку, заполняя её, осеменяя.")

			saynn("[say=pc]Нгх..[/say]")

			saynn("Ты кряхтишь... и остаешься внутри нее... чувствуя, как ее внутренние стенки пульсируют вокруг твоего наливающегося члена.")

		else:
			saynn("Ты входишь глубоко в последний раз и просто оставляешь резиновый ствол внутри нее, продлевая ее оргазм."+str("Kait's pussy is pulsing visibly around your toy." if !straponHasCum else "Your strapon suddenly starts throbbing inside Kait, pumping hot seed deep into her pulsing pussy. Rope after rope floods her womb, filling her up, breeding her.")+"")

			saynn("[say=pc]Хорошо..[/say]")

			saynn("Но теперь пришло время дать ей снова вздохнуть.")

		addButton("Вытащить", "Вытащиться и попытаться привести Кейт в чувство", "keep_back_senses")
	if(state == "keep_back_senses"):
		playAnimation(StageScene.SexChoke, "tease", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!usedStrapon || straponHasCum):
			saynn("Затем ты выходишь из нее."+str("Your" if !straponHasCum else "The")+" Сперма начинает вытекать из ее оттраханной киски, скапливаясь на полу под ней. Ты отпускаешь ее шею и тут же тянешься к ее лицу, осторожно похлопывая по щеке.")

		else:
			saynn("Затем ты выходишь. Ее изрядно использованная киска остается приоткрытой на некоторое время... прежде чем наконец сомкнуться. Ты отпускаешь ее шею и тут же тянешься к ее лицу, осторожно похлопывая по щеке.")

		saynn("[say=pc]Кейт. Эй. Кейт.[/say]")

		saynn("Спустя несколько мгновений... она начинает кашлять... и жадно хватать ртом воздух.")

		saynn("Спустя несколько секунд её глаза начинают медленно открываться. Она явно дезориентирована и, моргая, смотрит на тебя.")

		saynn("[say=kait]Ах.. а-ах.. что..[/say]")

		saynn("[say=pc]Всё хорошо. Дыши.[/say]")

		addButton("Забота после", "Притянуть её к себе, чтобы обняться", "keep_aftecare")
	if(state == "keep_aftecare"):
		playAnimation(StageScene.Cuddling, "cuddle", {npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты притягиваешь Кейт к себе в теплые объятия, помогая ей прийти в себя.")

		saynn("Она всё ещё кашляет. Её лапа тянется к горлу, там, где только что были твои пальцы. Теперь под мехом видны отчетливые синяки.")

		saynn("[say=kait]Это было.. кха.. мощно.. Кажется, я моргнула.. и пропустила почти всё..[/say]")

		saynn("[say=pc]Ну..[/say]")

		saynn("[say=kait]Погоди.. Я что, реально отключилась?[/say]")

		saynn("[say=pc]Да. На какое-то время.[/say]")

		saynn("[say=kait]Бля.. Это.. даже как-то горячо.[/say]")

		if (!usedStrapon):
			saynn("Она опускает лапу к своей киске.. и быстро обнаруживает, что та набита твоим семенем..")

		elif (straponHasCum):
			saynn("Она опускает лапу к своей киске.. и быстро обнаруживает, что та набита семенем..")

		else:
			saynn("Она опускает лапу к своей киске.. и быстро обнаруживает, что та вся промокла от её соков..")

		saynn("[say=kait]Очень горячо..[/say]")

		saynn("Она прижимается к тебе, всё ещё тихонько тяжело дыша.")

		saynn("[say=pc]Ты как? В порядке?[/say]")

		saynn("[say=kait]Да.. да.. я в норме.. Просто.. дай мне минутку.[/say]")

		saynn("Ты обнимаешь её, и её тело медленно расслабляется в твоих руках.")

		saynn("[say=kait]Эй.. по крайней мере, я не сдалась![/say]")

		saynn("Ты посмеиваешься и похлопываешь её.")

		saynn("[say=pc]Ты невозможна, Кейт.[/say]")

		saynn("После нежных объятий пришло время остановиться...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "let_breathe"):
		saynn("После столь долгого удушения ты решаешь ослабить хватку на её горле — ровно настолько, чтобы пропустить тонкую струю воздуха. Кейт жадно ловит ртом воздух, её грудь тяжело вздымается, впитывая драгоценный кислород. Её глаза снова широко распахиваются, фокусируясь на тебе.")

		saynn("[say=kait]Хах.. хах.. бля.. ты..[/say]")

		saynn("[say=pc]Я хочу, чтобы ты не спала во время этого.[/say]")

		if (!usedStrapon):
			saynn("Её киска всё ещё ритмично сжимается вокруг тебя, пока ты продолжаешь входить, заставляя её чувствовать каждый дюйм твоего члена, который скользит по её перевозбужденным стенкам.")

		else:
			saynn("Её киска всё ещё ритмично сжимается вокруг резиновой игрушки, пока ты продолжаешь входить, заставляя её чувствовать каждый дюйм игрушки, когда ты вжимаешь её в её перевозбужденные стенки.")

		saynn("[say=kait]Ннгх.. ммх..[/say]")

		saynn("Кажется, она больше не сопротивляется, а просто крепко держится за тебя.")

		saynn("[say=pc]Сдаешься?[/say]")

		saynn("[say=kait]..никогда.. ах..[/say]")

		if (!usedStrapon):
			saynn("Ты снова сильно сжимаешь ей горло, когда тебя накрывает оргазм...")

			addButton("Кончить внутрь", "Оплодотвори кошечку!", "cum_in")
		else:
			saynn("Ты снова крепко сжимаешь ей горло... можно заодно засунуть в неё всю игрушку целиком.")

			addButton("Всаживай на полную", "Посмотреть, что будет", "cum_in")
	if(state == "cum_in"):
		playAnimation(StageScene.SexChoke, "inside", {pc="pc", pcCum=!usedStrapon, npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!usedStrapon):
			saynn("Ты входишь глубоко в последний раз и просто отдаешься оргазму. Твой {pc.penis} начинает пульсировать внутри Кейт, закачивая горячую {pc.cum} глубоко в её пульсирующую киску. Сноп за снопом заливает её матку, наполняя её, оплодотворяя.")

			saynn("[say=kait]Ммм.. бля-а..[/say]")

			saynn("Она вздрагивает, чувствуя, как внутрь врывается горячая волна. Ты хрипишь... и остаешься внутри неё... чувствуя, как её внутренние стенки судорожно сжимаются вокруг твоего пульсирующего члена.")

			saynn("Оргазм начинает угасать...")

		else:
			saynn("Ты входишь глубоко в последний раз и просто оставляешь резиновый ствол внутри! Это продлевает оргазм Кейт, заставляя её еще сильнее извиваться под тобой..."+str("" if !straponHasCum else " And then.. your strapon suddenly starts throbbing inside her, pumping hot seed deep into her pulsing pussy. Rope after rope floods her womb, filling her up, breeding her.")+"")

			saynn("[say=kait]Ммм.. бля-а..[/say]")

			saynn("Даже когда её оргазм начинает угасать, она всё ещё слегка дрожит, а её внутренние стенки подёргиваются вокруг твоего страпона.")

		addButton("Вытащить", "Пора выходить", "cum_pullout")
	if(state == "cum_pullout"):
		playAnimation(StageScene.SexChoke, "tease", {pc="pc", npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!usedStrapon):
			saynn("Ты медленно выходишь, и твой член со влажным звуком выскальзывает наружу. Смесь твоего семени и её соков начинает вытекать из её изрядно использованной киски, скапливаясь на полу.")

		elif (straponHasCum):
			saynn("Ты медленно выходишь, и твоя игрушка со влажным звуком выскальзывает наружу. Смесь семени и соков начинает вытекать из её изрядно использованной киски, скапливаясь на полу.")

		else:
			saynn("Ты медленно выходишь, и твоя игрушка со влажным звуком выскальзывает наружу. Прозрачные соки капают из её изрядно использованной киски, скапливаясь на полу.")

		saynn("Кейт просто лежит какое-то время, тяжело дыша и глядя в потолок. Затем она издаёт дрожащий смешок... который переходит в кашель.")

		saynn("[say=kait]Твою мать... кхг... кхх...[/say]")

		saynn("[say=pc]Ты в порядке?[/say]")

		saynn("Наверное, просто слюна застряла в горле.")

		saynn("[say=kait]Я... да... я в порядке... Это было... блядь.[/say]")

		addButton("Забота после", "Притянуть её к себе, чтобы обняться", "breathe_aftecare")
	if(state == "breathe_aftecare"):
		playAnimation(StageScene.Cuddling, "cuddle", {npc="kait", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты притягиваешь Кейт к себе в теплые объятия, помогая ей прийти в себя.")

		saynn("[say=kait]Хах... ты обмяк на мне.[/say]")

		saynn("[say=pc]Правда? Пощупай свою шею.[/say]")

		saynn("Она подносит лапу к горлу, туда, где только что были твои пальцы. Теперь под мехом отчетливо видны синяки.")

		saynn("[say=kait]Это пустяки! Со мной бы всё было нор...[/say]")

		saynn("[say=pc]Я хотела, чтобы ты это запомнил.[/say]")

		if (!usedStrapon):
			saynn("Затем она опускает лапу к своей киске... и быстро обнаруживает, что та набита твоим семенем до краев...")

			saynn("[say=kait]Ты реально не сдерживался... совсем... Вот это я запомню~.[/say]")

		elif (straponHasCum):
			saynn("Затем она опускает лапу к своей киске... и быстро обнаруживает, что та полна семени...")

			saynn("[say=kait]В этом страпоне явно что-то было... Вот это я запомню~.[/say]")

		else:
			saynn("Затем она опускает лапу к своей киске... и быстро обнаруживает, что та вся промокла от её соков...")

			saynn("[say=kait]Ты так жестко меня оттрахал... Вот это я запомню~.[/say]")

		saynn("Она прижимается к тебе, всё ещё тихонько тяжело дыша.")

		saynn("Ты обнимаешь её, и её тело медленно расслабляется в твоих руках.")

		saynn("[say=kait]Еще разок~?[/say]")

		saynn("Ты посмеиваешься и похлопываешь её.")

		saynn("[say=pc]Ты невозможна, Кейт.[/say]")

		saynn("После нежных объятий пришло время остановиться...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addStraponButtons():
	var strapons = GM.pc.getStrapons()
	for strapon in strapons:
		addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "choose_strapon_pick", [strapon])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "choose_strapon_def"):
		usedStrapon = true
		defStrapon = true
		putOn("pc", "StraponCanine")
		setState("pin_her_down")
		return

	if(_action == "choose_strapon_pick"):
		usedStrapon = true
		defStrapon = false
		var strapon = _args[0]
		GM.pc.getInventory().removeItem(strapon)
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)
		var theFluids = strapon.getFluids()
		if(theFluids != null):
			if(theFluids.hasFluidType("Cum")):
				straponHasCum = true
				setFlag("KaitModule.gotKaitPregMaybe", true)
		setState("pin_her_down")
		return

	if(_action == "sex_faster"):
		processTime(5*60)

	if(_action == "keep_cum_inside"):
		getCharacter("kait").cummedInVaginaBy("pc", FluidSource.Penis if !usedStrapon else FluidSource.Strapon)
		GM.pc.orgasmFrom("kait")

	if(_action == "keep_aftecare"):
		if(defStrapon):
			GM.pc.removeStrapon()
		elif(usedStrapon):
			GM.pc.unequipStrapon()

	if(_action == "cum_in"):
		getCharacter("kait").cummedInVaginaBy("pc", FluidSource.Penis if !usedStrapon else FluidSource.Strapon)
		GM.pc.orgasmFrom("kait")

	if(_action == "breathe_aftecare"):
		if(defStrapon):
			GM.pc.removeStrapon()
		elif(usedStrapon):
			GM.pc.unequipStrapon()

	setState(_action)

func saveData():
	var data = .saveData()

	data["usedStrapon"] = usedStrapon
	data["defStrapon"] = defStrapon
	data["straponHasCum"] = straponHasCum

	return data

func loadData(data):
	.loadData(data)

	usedStrapon = SAVE.loadVar(data, "usedStrapon", false)
	defStrapon = SAVE.loadVar(data, "defStrapon", false)
	straponHasCum = SAVE.loadVar(data, "straponHasCum", false)
