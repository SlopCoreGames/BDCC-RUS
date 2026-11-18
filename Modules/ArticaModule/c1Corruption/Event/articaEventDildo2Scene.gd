extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var npcID = ""

func _init():
	sceneID = "articaEventDildo2Scene"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

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
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		saynn("Артика, воодушевленная чем-то, спешит к своей камере, и её задние лапки мило цокают по полу.")

		saynn("Но стоит ей войти, как возбуждение быстро сменяется разочарованием.")

		saynn("Она оглядывается и находит записку... Быстро пробежав её глазами, она ахает и поспешно уходит куда-то ещё."+str(", making sure her paws are covering her private bits." if nakedAndShy else "")+".")

		addButton("Записка", "Взглянуть", "read_note")
	if(state == "read_note"):
		playAnimation(StageScene.Solo, "stand")
		saynn("Ты ждешь, пока Артика уйдет, и заходишь в её камеру. Ты подбираешь записку, оставленную ею на подушке, и читаешь её...")

		saynn("Очевидно, что она от Сокета.")

		saynn("[say=socket]Хей! Я закончил 3D-печать детали, но никто не хочет её доставлять. Я всё упаковал, максимально незаметно. Сам бы принес, но не знаю, где твоя камера, сорян! Оставил в мастерской, под одной из скамеек. Уверен, никто не найдет.[/say]")

		saynn("Это заставляет задуматься: как же тогда записка оказалась здесь?..")

		addButton("Мастерская", "Отправиться туда", "in_workshop")
	if(state == "in_workshop"):
		playAnimation(StageScene.CanineDildoSex, "tease", {pc="artica", bodyState={hard=true}})
		aimCameraAndSetLocName("eng_workshop")
		saynn("Когда вы входите в мастерскую, вы видите раскрасневшееся лицо Артики и её широко распахнутые глаза.")

		saynn("Она уставилась на сверток... на свой сверток. Он и впрямь был упакован, но обертка была мягкой, и очертания невозможно было перепутать. Очевидно, с печатью тоже что-то пошло не так, потому что размер оказался куда больше, чем заказывала Артика — эта штука как минимум в два раза больше её клитора...")

		saynn("Почему-то это зрелище заставляет вас улыбнуться. Артика часто-часто моргает."+str("her shorts bulging heavily" if !isNaked else "her real cock throbbing eagerly")+"..")

		saynn("Сделав глубокий вдох, она подхватывает сверток, стараясь казаться как можно более непринужденной... но у неё явно не получается. Ни в один карман этот монстр не влезет... она прижимает его к спине, обернув вокруг него свой пушистый хвост, чтобы спрятать его как можно надежнее.")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_walks_with_dildo")
	if(state == "artica_walks_with_dildo"):
		playAnimation(StageScene.Solo, "walk", {pc="artica", bodyState={hard=true}})
		aimCameraAndSetLocName("mining_nearentrance")
		saynn("Коридоры кажутся длиннее обычного, и каждый шаг Артики сопровождается страхом, что её заметят.")

		saynn("Она пытается выбрать наименее людный маршрут... но ей неизбежно приходится воспользоваться лифтом. Она нажимает кнопку задней лапой, так как обе руки заняты тем, что она удерживает тяжелую штуковину за спиной...")

		saynn("Артика замирает, когда мимо проходят пара заключенных; их разговор затихает, когда они бросают на неё взгляд. Сердце пушистой бьется в груди, пока она выдавливает из себя улыбку.")

		saynn("Они одаривают её любопытными взглядами... но в итоге решают направиться к шахтам, позволяя Артике издале            ть слышимый выдох облегчения.")

		saynn("Двери лифта наконец открываются...")

		saynn("[say=risha]О, это ты.[/say]")

		saynn("[say=artica]Ой...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "risha_meets_artica")
	if(state == "risha_meets_artica"):
		addCharacter("risha")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="risha", bodyState={hard=true}})
		saynn("Злобная охранница выходит из лифта, оказываясь лицом к лицу с Артикой.")

		if (isNaked):
			saynn("[say=risha]Шлюшка уже привыкает ходить голой, а?[say=risha]"+str(" And carrying someone's cubs too, such a breeding whore." if getCharacter("artica").isVisiblyPregnant() else "")+"[/say]")

		else:
			saynn("[say=risha]Удивлена, что тебя до сих пор не заставили раздеться?[say=risha]"+str(" At least someone has knocked you up." if getCharacter("artica").isVisiblyPregnant() else "")+"[/say]")

		saynn("[say=artica].. ..[/say]")

		saynn("Риша прищуривается, бесцеремонно разглядывая Артику с ног до головы — она чувствует, что что-то не так...")

		saynn("[say=risha]Что это ты там прячешь, шлюха?[/say]")

		saynn("Мысли Артики мечутся в голове. Кто знает, что будет с её игрушкой, если эта сука-охранница её обнаружит...")

		saynn("[say=artica].. .. ..[/say]")

		saynn("Скептический взгляд Риши не отрывается.")

		saynn("[say=risha]Серьёзно? Хвост запутался? Дай гляну, я умею распутывать что угодно.[/say]")

		saynn("Отчаяние пульсировало в венах Артики...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_gets_on_her_knees")
	if(state == "artica_gets_on_her_knees"):
		playAnimation(StageScene.Duo, "kneel", {pc="artica", npc="risha", bodyState={hard=true}})
		saynn("Собрав всю свою храбрость, Артика делает единственное, что приходит в голову. Она падает на колени и склоняет голову, принимая позу полного подчинения... но при этом её лапы всё ещё спрятаны за спиной.")

		saynn("[say=artica].. .. ..[/say]")

		saynn("[say=risha]С чего это мне должно быть дело, что у тебя был тяжелый день в шахте? Хотя я рада, что ты хоть не бездельничаешь.[/say]")

		saynn("Артика строит глазки, как преданный щенок.")

		saynn("[say=artica].. .. ..? ..[/say]")

		saynn("Риша вскидывает бровь, явно наслаждаясь тем, как Артика унижается.")

		saynn("[say=risha]Что именно, говоришь?[/say]")

		saynn("Щеки пушистой заливаются румянцем от смеси стыда и решимости... прежде чем она кивает.")

		saynn("Риша ухмыляется.")

		saynn("[say=risha]Руки на стену, шлюха. И ноги разведи, не хватало еще, чтобы шипы тебя слишком сильно исцарапали.[/say]")

		saynn("Сердце Артики екнуло — попытки спасти свою задницу провалились. Похоже, ей нужна помощь. Вы замечаете, что двери лифта всё еще открыты...")

		addButton("Схватить Артику", "Помочь ей выбраться из этой ситуации", "help_artica_unstuck_risha")
	if(state == "help_artica_unstuck_risha"):
		removeCharacter("risha")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Вы небрежно проходите мимо них, на секунду задержавшись.")

		saynn("[say=pc]Привет.[/say]")

		saynn("Злобный взгляд Риши следует за вами, а её рука тянется к оружию.")

		saynn("[say=risha]Занимайся своим делом, зэк.[/say]")

		saynn("Большие глаза Артики уставились на вас. Вы едва заметно подмигиваете ей.")

		saynn("[say=pc]Мгм. Так и делаю, так и делаю.[/say]")

		saynn("Заметив оружие Риши, вы притворяетесь испуганным... Заходите в лифт... и нажимаете кнопку нужного блока камер.")

		saynn("[say=artica]Подож-..[/say]")

		saynn("Но прежде чем двери закрываются, вы внезапно протягиваете руку, хватаете Артику за воротник... и рывком затаскиваете её в лифт.")

		saynn("Вы слышите только...")

		saynn("[say=risha]Ну и сучка..[/say]")

		saynn("..прежде чем двери наконец разрывают ваш зрительный контакт. Металлическая комната начинает подниматься вверх с раздражающим скрежетом.")

		saynn("Артика тяжело дышит, всё ещё что-то сжимая за спиной.")

		saynn("[say=pc]Как ты?[/say]")

		saynn("[say=artica]Д-да.. я в порядке.. с-спасибо![/say]")

		saynn("[say=pc]Нужна помощь?[/say]")

		saynn("Вы слегка наклоняетесь, дразняще пытаясь разглядеть, что именно держит Артика. Но она отворачивается.")

		saynn("[say=artica]Да не особо.. вроде всё хорошо..[/say]")

		saynn("От вашей самодовольной ухмылки она краснеет. Лучше не смущать бедную пушистицу сильнее, она тоже заслужила немного развлечений.")

		saynn("[say=pc]Ладно, держи свои секреты при себе.[/say]")

		saynn("Двери открываются.. Артика поспешно убегает.")

		addButton("Следовать", "Посмотрим, на что она способна", "artica_in_cellblock_oops")
	if(state == "artica_in_cellblock_oops"):
		aimCameraAndSetLocName("cellblock_nearcells")
		playAnimation(StageScene.Solo, "jog", {pc="artica"})
		saynn("Стараясь не привлекать лишнего внимания, Артика бежит по коридору, а её щеки пылают от смущения... и возбуждения. Она крепко прижимает к себе сверток, обернув его хвостом, чтобы почти полностью скрыть содержимое.")

		saynn("Она видит лиловый блок и, вероятно, уже представляет, какое удовольствие её ждет...")

		saynn("Но тут..")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_trips")
	if(state == "artica_trips"):
		playAnimation(StageScene.Solo, "defeat", {pc="artica"})
		aimCameraAndSetLocName("cellblock_lilac_nearcell")
		GM.pc.setLocation("cellblock_lilac_nearcell")
		saynn("...но в спешке она спотыкается.")

		saynn("[say=artica]Ой-ой![/say]")

		saynn("Артика растягивается на полу, а сверток выскальзывает из её рук, проносится по полу и замирает прямо посреди лилового блока...")

		saynn("Бедняжка сегодня явно не в духе. Когда она вскакивает на ноги, то понимает, что уже слишком поздно: другие лиловые уже заметили странный новый предмет...")

		addButton("Продолжить", "Смотреть, что будет дальше", "lilacs_near_dildo")
	if(state == "lilacs_near_dildo"):
		playAnimation(StageScene.CanineDildoSex, "tease", {pc="artica"})
		saynn("Вокруг свертка быстро собирается толпа, и их глаза расширяются, когда они понимают, что это такое.")

		saynn("[sayMale]Что это такое?[/sayMale]")

		saynn("[sayFemale]Похоже на гигантский дилдо![/sayFemale]")

		saynn("В воздухе витает шепот и хихиканье. Сиреневые девчонки обступают предмет всё плотнее, словно это какой-то арт-объект...")

		saynn("[sayMale]Чьё это?[/sayMale]")

		saynn("Артика отчаянно пытается прорваться сквозь толпу, чтобы вернуть свою игрушку... но натыкается на сопротивление более сильных девчонок.")

		saynn("[say=artica]..ой.. м-можно мне?..[/say]")

		saynn("[sayFemale]Я первая его увидела, он мой![/sayFemale]")

		saynn("[sayMale]Ага, щас. Отвали! Я забираю его себе![/sayMale]")

		saynn("[sayFemale]Да пошёл ты, отдай мне![/sayFemale]")

		saynn("Толпа, кажется, готова драться за этот дилдо — каждая сиреневая хочет заполучить его себе. Сердце Артики уходит в пятки; надежда стремительно тает, ведь у неё нет шансов одолеть хоть кого-то, не говоря уже о всех сразу. Столько усилий, чтобы достать эту игрушку... и всё ради того, чтобы её потерять...")

		addButton("Продолжить", "Смотреть, что будет дальше", "a_solution")
	if(state == "a_solution"):
		saynn("Сиреневые начинают пинать друг друга, тянуть за волосы, кусать за лодыжки... пока их не останавливает громкий голос.")

		saynn("[sayMale]Стойте! Стойте! Хватит драться! Есть идея, как с этим разобраться! Испытание для самых смелых![/sayMale]")

		saynn("Толпа дает случайной сиреневой дает шанс на оправдание.")

		saynn("[sayMale]Слушай, у этого дилдо просто гигантская луковица. Скажем так... тот, кто сможет её принять... тот и заслуживает его оставить себе![/sayMale]")

		saynn("Между сиренями проносится одобрительный ропот. Похоже... Толпа была набита единомышленницами-шлюхами, каждая из которых жаждала достойного вызова. Артика выглядит... снова полной надежд.")

		addButton("Продолжить", "Смотреть, что будет дальше", "first_person_rides")
	if(state == "first_person_rides"):
		playAnimation(StageScene.CanineDildoSex, "sex", {pc=npcID, skipToHover=true, bodyState={naked=true, hard=true}})
		saynn("Эта игрушка... если её вообще можно так назвать... была любезно смазана кем-то щедрым. Естественным образом выстроилась гигантская очередь, отсортированная по силе заключенных.")

		var npcHasPussy = getCharacter(npcID).hasReachableVagina()
		saynn("Толпа с нетерпением наблюдает за тем, как первая заключенная приближается к гигантскому дилдо. {npc.He} запрыгивает на него верхом, широко раздвинув {npc.his} ноги. Сделав глубокий вдох, {npc.he} опускает {npc.himself} на ствол, {npc.his}"+str("wet pussy" if npcHasPussy else "eager tailhole")+"обволакивая толстую игрушку. {npc.He} издает тихий стон, {npc.his} бедра двигаются в медленном, размеренном ритме... но быстро набирают скорость...")

		saynn("[sayMale]Да ладно тебе, ну попробуй уже![/sayMale]")

		saynn("{npc.He} increased {npc.his} pace, riding the dildo faster and harder, {npc.his} moans growing louder. {npc.He} rocked {npc.his} hips, trying to force the full length, knot included, inside.. but it was proving to be too large.."+str(" {npc.his} pussy just wasn't stretching wide enough to take that fat orb in.." if npcHasPussy else " {npc.his} ass just wasn't stretching wide enough to take that fat orb in..")+"")

		saynn("[sayFemale]Дай мне попробовать![/sayFemale]")

		saynn("С последним отчаянным толчком, {npc.he} пытается заглотить узел... но не сумев этого сделать, тело {npc.his} так сильно сжимается вокруг гигантского резинового члена, что {npc.he} быстро кончает, а тело {npc.his} сотрясается в дрожи.."+str(" {npc.his} pussy clenching tightly around the shaft, {npc.his} juices coating it and dripping onto the floor.." if npcHasPussy else " {npc.his} anal walls clenching tightly around the shaft..")+""+str(" {npc.his} {npc.penis} shooting spurts of seed super far!" if getCharacter(npcID).hasReachablePenis() else "")+"")

		saynn("[sayMale]Ладно! Ну-ну-ну-ну[/sayMale]")

		addButton("Продолжить", "Смотреть, что будет дальше", "second_person")
	if(state == "second_person"):
		playAnimation(StageScene.CanineDildoSex, "fast", {pc=npcID, skipToHover=true, bodyState={naked=true, hard=true}})
		saynn("Одна за другой заключенные начали по очереди оседлать фаллос... Вид того, как разные девки садятся на точную копию члена Артики... заставляет её тихо стонать, а ноги — непроизвольно тереться друг о друга...")

		var npcHasPussy = getCharacter(npcID).hasReachableVagina()
		var npcHasPenis = getCharacter(npcID).hasReachablePenis()
		saynn("Очередная заключенная грациозно подходит и садится верхом на игрушку, располагая {npc.himself} над скользким резиновым членом. Толпа затихла, пристально наблюдая за тем, как {npc.he} начинает свою {npc.his} попытку.")

		saynn("{npc.He} медленно опускает {npc.himself} на ствол, издавая мягкий, прерывистый стон, пока тот растягивает {npc.his} "+str("pussy slit" if npcHasPussy else "eager tailhole")+"широко открытую дырку. Бедра {npc.His} начали двигаться... быстро. Намного быстрее, чем у всех, кто пробовал до неё.")

		saynn("Заключенная практически вбивала {npc.himself} в эту игрушку; жирное утолщение с каждым толчком шлепало по растянутому ебальнику {npc.his}... постепенно растягивая его всё сильнее, а острый кончик прорисовывал бугор под {npc.his} животом..."+str(" {npc.his} cock bobbing up and down, the toy stimulating {npc.his} pleasure spot.." if npcHasPenis else "")+"")

		saynn("Неужели это она? Артика выглядит испуганной...")

		saynn("[sayMale]{npc.He} делает это![/sayMale]")

		saynn("[sayFemale]Да вы, блять, не смейте! Я хочу первой растянуть свою жопу этим хреном![/sayFemale]")

		addButton("Продолжить", "Посмотрите, какая участь ждет этот дилдо...", "second_cums")
	if(state == "second_cums"):
		playAnimation(StageScene.CanineDildoSex, "inside", {pc=npcID, pcCum=true, bodyState={naked=true, hard=true}})
		var npcHasPussy = getCharacter(npcID).hasReachableVagina()
		var npcHasPenis = getCharacter(npcID).hasReachablePenis()
		var npcHasProstate = (npcHasPenis && !npcHasPussy)
		var npcHasPenisGspot = (npcHasPenis && npcHasPussy)
		saynn("Заключенная чувствовала, как игрушка растягивает {npc.him} всё шире и шире... она почти проскальзывает внутрь...")

		saynn("Последним мощным толчком {npc.he} пытается загнать её внутрь... издавая крик экстаза, пока {npc.he} сильно кончает, а тело {npc.his} содрогается от интенсивного растяжения,"+str("{npc.his} pussy clenching hard and squirting juices all over the toy, inner walls milking the thick shaft.." if npcHasPussy else "{npc.his} asshole clenching hard, inner walls milking the thick shaft..")+" "+str("{npc.his} {npc.penis} spurted thick ropes of {npc.cum} as {npc.his} prostate was milked dry, {npc.his} body shaking uncontrollably.." if npcHasProstate else "")+""+str("{npc.his} {npc.penis} spurted thick ropes of {npc.cum} as {npc.his} g-spot was squeezed hard, {npc.his} body shaking uncontrollably.." if npcHasPenisGspot else "")+"")

		saynn("И всё же... {npc.he} никак не могла принять её целиком... несмотря ни на что.")

		saynn("[sayMale]Ха-ха, фаллос всё ещё свободен! Кто докажет, что он здесь самая большая шлюха?![/sayMale]")

		saynn("{npc.He} просто стояла, тяжело дыша и дрожа... прежде чем медленно снять {npc.himself} с фаллоса, при этом на лице {npc.his} читалось удовлетворение... смешанное с гневом. {npc.He} всё-таки была так близка.")

		saynn("Сердце Артики бешено колотилось, пока она наблюдала, как остальные по очереди используют резиновую копию её члена... Но теперь настала её очередь...")

		addButton("Артика", "Посмотрим, на что она способна", "artica_turn")
	if(state == "artica_turn"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.CanineDildoSex, "hover", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Пушистая штучка делает шаг вперед, её ноги дрожат от смеси возбуждения и тревоги. Артика делает глубокий вдох."+str(" and undresses, exposing herself fully to the eager crowd, putting out on display both her wet pussy and {artica.penis}.." if !isNaked else ", her wet pussy and {artica.penis} are both out on display for the eager crowd..")+"Назад пути уже не было.")

		saynn("Она хватает предложенный флакон с лубрикантом... наносит немного на лапки, а затем распределяет его по всей поверхности фаллоса. Вид того, что, по сути, является её собственным членом... так близко... со всеми его венами и бугорками, во всех деталях... заставляет Артику часто сглатывать, а слюна течет изо рта не переставая... Остатки смазки она наносит на свои чувствительные голубые складки киски, делая их нежными и скользкими...")

		saynn("После этого пушистая встает над гигантской игрушкой, кончик которой уже касается её мокрой, сочащейся щели."+str(" Her caged up member is twitching a lot behind its metal prison.." if isCaged else " Her real member is twitching a lot..")+"")

		saynn("[sayFemale]У нас нет всей вечности, поторапливайся![/sayFemale]")

		saynn("[sayMale]Дай девчонке насладиться, всё равно это в последний раз, когда она видит этот дилдо.[/sayMale]")

		saynn("Время поджимало...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_starts_riding")
	if(state == "artica_starts_riding"):
		playAnimation(StageScene.CanineDildoSex, "sex", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Размер этой игрушки заставил Артику на мгновение заколебаться... но она решает рискнуть и медленно опускается на неё. Острый кончик легко скользит внутрь её киски, растягивая Артику ровно настолько, чтобы та издала тихий стон и прикусила губу.")

		saynn("[say=artica]..мммх..[/say]")

		saynn("Она опускалась всё ниже и ниже, её влажные внутренние стенки растягивались всё сильнее. Когда она достигла толстого узла... она замерла и начала медленно подниматься, не спеша привыкать к такому обхвату. Огромное количество смазки облегчало процесс... но всё равно это было совсем не просто...")

		saynn("Артика закрывает глаза и стонет всё громче, чувствуя на себе взгляды толпы, даже не глядя на них... их шепот и подбадривающие слова смешиваются с её любовными звуками...")

		saynn("[say=artica]Мммхх.. ммхха.. ах.. мммх..[/say]")

		saynn("Со временем она начинает двигаться интенсивнее, ритмично насаживаясь на дилдо в приличном темпе,"+str("her locked cock dripping plenty of pre inside of its little cage, bobbing up and down a lot.." if isCaged else "her real cock dripping eagerly, bobbing up and down a lot..")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_rides_faster")
	if(state == "artica_rides_faster"):
		playAnimation(StageScene.CanineDildoSex, "fast", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Её дыхание стало глубоким и частым, бедра двигались в размеренном ритме; каждый толчок приближал её к узлу, и раздутый шар всё настойчивее давил на вход в её киску, растягивая её всё шире... неестественно широко.")

		saynn("[say=artica]Ах.. ахх-.. ах.. какой огромный.. ах..[/say]")

		saynn("Она продолжала скакать и скакать, кусая губу и с силой насаживаясь на этот резиновый стержень, теперь намеренно пытаясь заглотить узел.. От ощущения такого сильного растяжения у неё сводит пальцы ног, хвост подергивается, а уши дрожат.")

		saynn("[say=artica]Ммм-м.. ммхх.. мх-ах.. ах.. п-пожалуйста.. ах..[/say]")

		saynn("Это видно невооруженным глазом.. Артика с каждым разом заглатывает узел всё глубже, когда с силой обрушивается на него всем телом.. Её голубая киска растянута до предела.. но она не останавливается, а волны удовольствия заставляют всё её тело дрожать.")

		saynn("[sayMale]Ого, у неё реально получается! Эта шлюшка почти заглотила узел![/sayMale]")

		saynn("[sayFemale]Поверю, когда увижу своими глазами.[/sayFemale]")

		saynn("Она чувствовала это.. Она знала, что сможет.. Она обязана была это сделать..")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_fails_to_take_the_knot")
	if(state == "artica_fails_to_take_the_knot"):
		playAnimation(StageScene.CanineDildoSex, "inside", {pc="artica", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Одним последним невероятным рывком она пробивает ментальный барьер, насаживаясь на него со всей силы.. так сильно, что вскоре её накрывает мощнейший оргазм. Её киска судорожно сжимает дилдо, заливая его соками, её "+str("caged cock shooting cum wildly, sending thick ropes of seed to splatter all over the floor" if isCaged else "hard cock shooting cum wildly, sending thick ropes of seed to splatter all over the floor")+".. Она неконтролируемо дрожит, но органические волны смешиваются с глубоким чувством.. разочарования..")

		saynn("[say=artica]НХХхх.. АХх-х.. ах..[/say]")

		saynn("[sayFemale]Ха, так я и знала![/sayFemale]")

		saynn("Артике не удалось заглотить узел... осознание накрывает её с головой...")

		saynn("[sayMale]Ладно-ладно, ну и кто следующий?[/sayMale]")

		saynn("[say=artica]..н-нет.. о нет.. о-о..[/say]")

		saynn("Она попыталась еще несколько раз... но всё без толку... ноги дрожат, сбивая её с толку. Толпа подбадривала её старания... но Артика слышала лишь злые комментарии... тело измождено... а на душе сплошная печаль...")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_getsup_after_fail")
	if(state == "artica_getsup_after_fail"):
		playAnimation(StageScene.Duo, "stand", {npc="artica", npcBodyState={naked=true}})
		saynn("Артика медленно сползает с дилдо, тяжело дыша, пока её растянутая киска пытается сомкнуться. Она выглядит... отрешенной... просто глядя на других заключенных, которые начинают скакать на её игрушке...")

		saynn("Её губы дрожат... хвост зажат между ног... уши прижаты...")

		addButton("Утешить её", "Попытаться успокоить пушистую", "do_comfort")
		addButton("Принять участие самому!", "Попытаться выиграть этот дилдо для Артики", "do_participate")
	if(state == "do_comfort"):
		setFlag("ArticaModule.nextReaction", "d2won")
		playAnimation(StageScene.Hug, "hug", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Ты крепко обнимаешь эту пушистую крошку; твои руки смыкаются вокруг её дрожащего тела, пока она утыкается лицом тебе в плечо.")

		saynn("[say=pc]Ты молодец, Артика. Правда. Это было отличное шоу.[/say]")

		saynn("[say=artica]..но я же не..[/say]")

		saynn("[say=pc]Да ладно, всё нормально.[/say]")

		saynn("Случайные заключенные продолжают испытывать игрушку на прочность, пытаясь засунуть её по самую рукоятку; их стоны эхом разносятся по всему тюремному блоку...")

		saynn("[say=pc]Иногда сдаться — это правильный выбор. Нужно уметь вовремя зафиксировать убытки.[/say]")

		saynn("Артика кладет голову тебе на плечо, украдкой наблюдая за тем, как другие пытаются, но терпят неудачу."+str(" Seeing her scaled up cock is making her horny again, her real member brushing against your leg as she is hugging you.." if !isCaged else " Seeing her scaled up cock is making her horny again, her chastity cage rubbing against your leg and she is gently humping your leg..")+"")

		saynn("[say=artica]..ты д-думаешь.. может, я с-смогу попробовать еще раз?..[/say]")

		saynn("[say=pc]Ты уверена? Возможно, это не лучшая идея, твои..[/say]")

		saynn("Пока ты это говорил, Артика уже снова стояла в очереди, ожидая своей очереди.")

		saynn("[say=artica]Попробую еще раз..[/say]")

		saynn("Она явно хочет этот дилдо.. впрочем, это логично.")

		addButton("Продолжить", "Смотреть, что будет дальше", "again_start")
	if(state == "again_start"):
		playAnimation(StageScene.CanineDildoSex, "hover", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Вскоре настала её очередь. Артика сделала шаг вперед, снова готовясь к встрече с дилдо. Ты ободряюще киваешь ей, словно желая удачи..")

		saynn("Пушинка устраивается прямо над гигантским узловатым дилдо, её киска уже влажная от предвкушения.")

		saynn("[sayMale]Опять ты? Ты реально хочешь раздолбать свою киску в хлам, да?![/sayMale]")

		saynn("[sayFemale]Ну, в смысле.. растянутые дырки хороши для двойного проникновения..[/sayFemale]")

		saynn("Она не слушала толпу, сосредоточившись лишь на своем теле и дыхании..")

		addButton("Продолжить", "Смотреть, что будет дальше", "again_starts_riding")
	if(state == "again_starts_riding"):
		playAnimation(StageScene.CanineDildoSex, "sex", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Медленно она опускается на игрушку, чувствуя, как толстый ствол снова наполняет её киску, а каждая вена и каждая выпуклость вжимаются в её внутренние стенки. Она начинает в мягком ритме, подпрыгивая на игрушке вверх-вниз, давая телу привыкнуть к её форме. Но с каждым разом она садится всё глубже и глубже..")

		saynn("[say=artica]Мммх.. ах..[/say]")

		saynn("Первый стон срывается с её губ, когда кончик игрушки находит её тугую шейку матки, посылая электрические разряды удовольствия по всему телу."+str("her cock twitching eagerly" if !isCaged else "her caged cock twitching eagerly")+"..")

		saynn("[sayFemale]Ммм.. сомневаюсь, что она на это решится.. но как же это горячо..[/sayFemale]")

		saynn("Даже когда дилдо начинает неистово долбить в самое устье её матки, Артика продолжает пытаться насадиться на него ещё глубже, отчего на её животе проступает милый бугорок, когда игрушка сжимает и давит на её тугую «машинку для детей»..")

		addButton("Продолжить", "Смотреть, что будет дальше", "again_artica_rides_faster")
	if(state == "again_artica_rides_faster"):
		playAnimation(StageScene.CanineDildoSex, "fast", {pc="artica", bodyState={naked=true, hard=true}})
		saynn("Постепенно Артика ускоряется, её бёдра двигаются всё быстрее, а киска жадно заглатывает толстый, раздутый ствол. Она чувствовала, как узел настойчиво давит ей в преддверие.. но она просто старалась об этом не думать, наслаждаясь процессом и позволяя жирной сфере растягивать её щели всё шире с каждым толчком.")

		saynn("[say=artica]Мммхх.. ах.. ахх.. ах.. к-какой же охрененный чл.. ах..[/say]")

		saynn("Сразу видно, что внутри неё уже нарастает давление; пушинка терпеливо стонет, а её тело пробивает дрожь.")

		saynn("[sayMale]Давай уже, кончай и пошли дальше, ты тратишь наше время.[/sayMale]")

		saynn("Кто бы это ни был, он ошибается.. Сейчас точно что-то произойдет..")

		addButton("Продолжить", "Смотреть, что будет дальше", "artica_knots_dildo_yay")
	if(state == "artica_knots_dildo_yay"):
		playAnimation(StageScene.CanineDildoSex, "knotinside", {pc="artica", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Давление достигло почти невыносимого пика, киска Артики плотно обхватила толстый ствол. Но затем, внезапно, после одного из мощных толчков, пушинка чувствует, как узел с влажным, приятным чпоком проскальзывает внутрь неё..")

		saynn("[say=artica]АХХХхх..!..[/say]")

		saynn("Артика кричит от экстаза, её тело сотрясают конвульсии, когда фаллос входит в неё на всю длину, а острый кончик пробивает шейку матки и давит на само чрево. Все её мышцы напрягаются, она инстинктивно пытается отпрянуть... но тяжелая игрушка удерживает её на месте, заставляя лишь повалиться назад, пока дрожащие лапы не дают ей окончательно рухнуть и не навредить себе...")

		saynn("[sayMale]Святые... Что за...[/sayMale]")

		saynn("[sayFemale]НЕЕЕЕТ! ЭТО ДОЛЖНА БЫЛА БЫ БЫТЬ Я![/sayFemale]")

		saynn("[sayMale]Никогда не видела, чтобы у кого-то была такая огромная луковица в основании...[/sayMale]")

		saynn("Девушка запрокидывает голову и кончает напропалую; её киска извергает потоки смазки, доя эту жирную реплику её собственного члена, пока разум затопляет волна наслаждения. Её настоящий член пульсирует и выстреливает струями спермы, а яички напрягаются от того, как эта толстая сфера вминает её точку G...")

		saynn("[sayMale]Итак, у нас есть победительница! Эта бело-голубая сирень забирает дилдо себе на правах собственности![/sayMale]")

		saynn("[sayFemale]Ей точно понадобится эта штука, чтобы прийти в себя после того, как ей так разнесли киску...[/sayFemale]")

		saynn("Кто-то подходит к Артике и похлопывает её по голове. Пока пушистая лишь жадно стонет и пускает слюни, её член и киска всё еще пульсируют...")

		saynn("[sayMale]Хочешь что-нибудь сказать?[/sayMale]")

		saynn("[say=artica]Ааах-х... д-да... я т-такая... шлюха для узлов... ааах-х...[/say]")

		saynn("Мило. За неё прямо радуешься.")

		saynn("[sayMale]Так и есть. Наслаждайся своей новой игрушкой, ты это заслужила.[/sayMale]")

		addButton("Артика", "Пойти проверить её", "after_won_artica")
	if(state == "after_won_artica"):
		playAnimation(StageScene.Duo, "stand", {npc="artica", npcBodyState={naked=true,hard=true}})
		saynn("Толпа начинает медленно расходиться... оставляя тебя и Артику наедине...")

		saynn("[say=pc]У тебя получилось, Артика.[/say]")

		saynn("[say=artica]Д-да... ах... с-спасибо. Мне, кажется... н-нужна помощь... ч-чтобы встать... ах...[/say]")

		saynn("Ты киваешь и протягиваешь ей руку... нет, обе руки. Осторожно ты начинаешь тянуть её вверх, снимая с игрушки. Толстое утолщение, всё ещё застрявшее глубоко внутри неё, поначалу сопротивляется, растягивая её киску ещё сильнее... но затем оно начинает медленно выскальзывать.")

		saynn("[say=artica]Ах... АХ![/say]")

		saynn("С влажным, отчетливым звуком «чпок» утолщение наконец выскальзывает, оставляя её киску широко раскрытой... Ты поддерживаешь Артику, так как её ноги всё ещё дрожат от слабости.")

		saynn("Игрушка... выглядит мокрой... она вся покрыта слоем смазки и соков Артики...")

		saynn("[say=artica]Я... я отнесу его в свою камеру..[/say]")

		saynn("[say=pc]Конечно. Наслаждайся.[/say]")

		saynn("[say=artica]Обязательно.. ха-ха.. Спасибо..[/say]")

		saynn("Она хватает игрушку и делает несколько неуверенных шагов, её задние лапы постепенно обретают силу.")

		saynn("После такого грандиозного шоу пришло время уходить..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_participate"):
		setFlag("ArticaModule.nextReaction", "d2pc")
		playAnimation(StageScene.CanineDildoSex, "tease", {pc="pc"})
		saynn("Нельзя просто смотреть, как Артика грустит. Ты должен помочь ей выиграть этот дилдо.. И вот ты встаешь в очередь.")

		saynn("Заметив тебя, Артика склоняет голову набок.")

		saynn("[say=pc]Не волнуйся, ты не одна. Я помогу тебе заполучить эту игрушку.[/say]")

		saynn("[say=artica]Правда?.. К-как?..[/say]")

		saynn("Твоя воодушевленная улыбка говорит ей обо всем. Её глаза расширяются, она приоткрывает рот, чтобы прошептать тебе какой-то секрет.. но в последний момент передумывает.")

		saynn("Очередь заключенных движется быстро, люди кончают от этой игрушки всего за несколько минут..")

		saynn("Наконец-то подошла твоя очередь..")

		saynn("[say=artica]У-удачи..[/say]")

		saynn("Глядя на то, сколько людей не смогли заглотить этот дилдо.. тебе он точно понадобится..")

		addButton("Дилдо", "Подойти к нему", "pc_approach_dildo")
	if(state == "pc_approach_dildo"):
		playAnimation(StageScene.CanineDildoSex, "hover", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("Ты уверенно шагнула вперед"+str(", undressing and revealing your naked form to the crowd" if GM.pc.isFullyNaked() else ", displaying your naked form to the crowd proudly")+".")

		saynn("Не теряя времени, ты устраиваешься над гигантским узловатым дилдо. Твой "+str("pussy is already slick and needy just from looking at it, arousal dripping down your juices." if GM.pc.hasReachableVagina() else "tailhole is already twitching needy just from looking at it.")+"")

		if (GM.pc.hasReachableVagina()):
			saynn("Ты направляешь кончик к своему {pc.pussyStretch} входу.. и начинаешь медленно опускаться, чувствуя, как острый силиконовый наконечник раздвигает твою щель.. и раскрывает лепестки.")

		else:
			saynn("Ты направляешь кончик к своему {pc.anusStretch} входу.. и начинаешь медленно опускаться, чувствуя, как острый силиконовый наконечник давит на твою дырочку.. и раздвигает её.")

		addButton("Глубже..", "Прими его как можно глубже", "pc_deeper")
	if(state == "pc_deeper"):
		playAnimation(StageScene.CanineDildoSex, "inside", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("Огромная толщина игрушки растягивает твои влажные внутренние стенки, пока ты принимаешь всё больше и больше; каждый дюйм заставляет тебя чувствовать себя еще полнее. Твои бедра двигаются намеренно медленно, пока ты пытаешься привыкнуть к раздутому члену Артики внутри тебя, твоя "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+" обволакивает его форму, ощущая каждую бороздку и венку..")

		saynn("[say=pc]Такой большой.. нхх..[/say]")

		saynn("Артика прикусывает губу, наблюдая, как ты медленно опускаешься на эту игрушку.. Её лапы нервно сжимают её тело, обхватывая {artica.breasts} и нежно сжимая их"+str(", making some milk come out" if getCharacter("artica").canBeMilked() else "")+"..")

		saynn("[sayMale]Давай уже, заканчивай с этим, люди ждут.[/sayMale]")

		saynn("[sayFemale]Заткнись и дай {pc.him} насладиться этим.[/sayFemale]")

		saynn("В конце концов, узел упирается в твою "+str("pussy folds" if GM.pc.hasReachableVagina() else "anal star")+".. высшее испытание. Ты пытаешься опуститься еще ниже, чувствуя, как раздутая сфера давит на вход, растягивая твою "+str("slit" if GM.pc.hasReachableVagina() else "ass")+" до естественного максимума.. но этого всё равно мало, чтобы пролезть..")

		saynn("Очевидно, что всё будет не так просто...")

		addButton("Скачи на нём", "Попытаться заглотить его", "pc_ride_dildo_sex")
	if(state == "pc_ride_dildo_sex"):
		playAnimation(StageScene.CanineDildoSex, "sex", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("Решив во что бы то ни стало помочь Артике, ты начинаешь двигаться на дилдо, скользя своей "+str("pussy along its slick surface, its tip hammering at your cervix while the thick shaft rubs against your g-spot, making you moan eagerly." if GM.pc.hasReachableVagina() else "tailhole along its slick lubed-up surface, its tip reaching deep inside you while the thick shaft rubs against your pleasure spot, making you moan eagerly.")+"")

		saynn("Твоя "+str("pussy" if GM.pc.hasReachableVagina() else "ring")+"сжимается вокруг него... но ты продолжаешь пытаться принять его поглубже, пока узел шлепает по твоей чувствительной плоти, и каждая попытка растягивает тебя всё сильнее.")

		saynn("[say=pc]Ммм.. черт возьми.. ах..[/say]")

		saynn("Ты бросаешь на Артику быстрый взгляд... Она извивается и тяжело дышит, её глаза прикованы к тебе, а лапки прикрывают покрасневшие щеки..."+str(" Her real cock putting pressure on its cage.." if isCaged else " Her real cock is hard and drippy..")+"")

		saynn("Ты пробуешь снова и снова... но пока ты чувствуешь лишь распирание... и растянутую "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+".. нужно наносить удары сильнее...")

		addButton("Жёстче", "Трахнуть игрушку еще сильнее", "pc_ride_faster")
	if(state == "pc_ride_faster"):
		playAnimation(StageScene.CanineDildoSex, "fast", {pc="pc", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Тебе нужно победить... ты должна победить... поэтому ты насаживаешься на эту игрушку всё сильнее и быстрее, мощными толчками стараясь насадиться на этот узел, намеренно пытаясь растянуть свою "+str("pussy" if GM.pc.hasReachableVagina() else "ass")+".")

		saynn("Твои стоны наполняют воздух, а внутренние стенки плотно обхватывают дилдо. Один мощный толчок за другим... узел начинает проскальзывать внутрь тебя, дюйм за дюймом... Но то, как он стимулирует каждый твой нерв... заставляет тебя кончать уже сейчас."+str(" Your cock is ready to burst at any second.." if GM.pc.hasPenis() else "")+"")

		saynn("[say=pc]Блядь... ах... давай же... ебаный узел... ах...[/say]")

		saynn("Ты пытаешься... но не можешь... сколько бы ты ни старалась протолкнуть его глубже, оргазм в конце концов накрывает тебя с головой... Твое тело начинает содрогаться вокруг этого толстого, раздутого члена, а с губ срываются громкие страстные стоны, пока твой перестимулированный "+str("pussy squirts all over the toy" if GM.pc.hasReachableVagina() else "tailhole clenches tightly around the toy")+""+str(", your {pc.penis} shooting thick ropes of {pc.cum} forward, your balls tensing up.." if GM.pc.hasPenis() else "")+"")

		saynn("[sayFemale]Оу. Даже {pc.he} не справилась бы.[/sayFemale]")

		saynn("[sayMale]Ага. Хватит забирать эту «ломательницу сук» себе одной, подъем уже.[/sayMale]")

		saynn("Похоже, ты проиграла... все твои мышцы напряжены, из-за чего оседлать игрушку становится так трудно, а твоя чувствительная "+str("pussy slit" if GM.pc.hasReachableVagina() else "asshole")+" становится сверхчувствительной после этого оргазма...")

		saynn("Ты снова смотришь на Артику... и видишь её огромные жалобные глаза... они заставляют тебя хотеть продолжать... Как ты можешь так предать её?")

		saynn("Медленно, сквозь всю боль и дискомфорт... ты продолжаешь насаживаться на эту реплику члена Артики... Твой "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole is")+" ноет... но ты продолжаешь растягивать его всё сильнее...")

		saynn("[say=pc]Нгхх... бля... хх...[/say]")

		saynn("[sayFemale]Ого, {pc.he} не унимается![/sayFemale]")

		saynn("[sayMale]Да сдавайся уже, ты заставляешь людей ждать.[/sayMale]")

		saynn("Ты стонешь громче и трахаешь эту игрушку ещё яростнее, лишь бы заткнуть этого придурка. Дискомфорт постепенно уходит, когда твой любовный туннель снова смазывается, позволяя тебе быстро ускориться...")

		addButton("Жёстче", "Трахни игрушку ещё сильнее!", "pc_accidently_knots_toy")
	if(state == "pc_accidently_knots_toy"):
		playAnimation(StageScene.CanineDildoSex, "knotinside", {pc="pc", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Внезапно один из толчков заставляет твой "+str("pussy" if GM.pc.hasReachableVagina() else "anal ring")+" растянуться ровно настолько...")

		saynn("Жирное основание этого огромного дилдо с влажным чпоком входит внутрь, заполняя тебя целиком!")

		saynn("[say=pc]АХ! Ох, блядь![/say]")

		saynn("Это слишком... твоё тело дрожит, ноги подкашиваются, и ты плюхаешься назад, опираясь на руки... Игрушка... она зашла в тебя целиком... "+str("the tip breaking into your womb and stretching it out" if GM.pc.hasReachableVagina() else "the tip pushing on your inner walls")+", образуя огромную выпуклость на твоём животе...")

		saynn("[sayFemale]{pc.He} сделала это! Вау![/sayFemale]")

		saynn("[sayMale]Святые... блядь...[/sayMale]")

		if (GM.pc.hasReachableVagina()):
			saynn("Киска содрогается, заливая игрушку фонтанами девичьей смазки... снова и снова... этой стимуляции достаточно, чтобы сбросить тебя с края... нет, перекинуть через всю лестницу...")

		else:
			saynn("Твоя задница сжимается вокруг игрушки... снова и снова... этой стимуляции достаточно, чтобы сбросить тебя с края... нет, перекинуть через всю лестницу...")

		saynn("Ты испускаешь серию страстных стонов, твои внутренние стенки со всей силы сжимают игрушку..."+str(" Your {pc.penis} wastes the rest of its {pc.cum}, your balls getting emptied in seconds.." if GM.pc.hasPenis() else "")+"")

		saynn("Одна из заключенных подходит к тебе и приседает рядом, проверяя, весь ли узел внутри тебя... так и есть...")

		saynn("[sayMale]Похоже, у нас есть победительница! Эта девка забирает дилдо себе целиком и полностью для {pc.himself}![/sayMale]")

		saynn("[sayFemale]НЕЕЕЕТ! ЭТО ДОЛЖНА БЫЛА БЫ БЫТЬ Я![/sayFemale]")

		saynn("[sayMale]Никогда не видела, чтобы у кого-то была такая огромная луковица в основании...[/sayMale]")

		saynn("Ты смотришь на Артику... насколько это возможно. Ого, на её лице написано выражение похотливой шлюхи; она тяжело дышит, прикрывая лапами свою "+str("caged throbbing cock" if isCaged else "hard throbbing cock")+", струйки семени так и брызжут сквозь её когти, пока она пытается сдержать внезапный оргазм.")

		saynn("Толпа начинает расходиться... некоторые разочарованно вздыхают.")

		addButton("Хватит", "Попытайся освободиться и награди Артику!", "pc_enough_givetoy")
		addButton("Замок-трах!", "Зачем останавливаться на достигнутом?", "pc_knotfuck")
	if(state == "pc_enough_givetoy"):
		playAnimation(StageScene.Hug, "hug", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		saynn("Приложив настоящую силу... тебе удается освободиться, и узел с приятным хлопком выскальзывает из твоего широко растянутого отверстия.")

		saynn("[say=pc]Ах..[/say]")

		saynn("Игрушка... вся в смазке и твоих соках...")

		saynn("Артика подходит к тебе, её щеки пылают красным, пока она приходит в себя после собственного оргазма...")

		saynn("[say=pc]Это твоё, Артика. Можешь... взять его. Только... осторожно.[/say]")

		saynn("[say=artica]П-правда?.. Ты выиграл его..[/say]")

		saynn("[say=pc]Я выиграла его для тебя.[/say]")

		saynn("Артика обнимает тебя и радостно прижимается щекой, довольно мурлыча.")

		saynn("[say=artica]С-спасибооо.. Я бы не с-справилась без тебя..[/say]")

		saynn("Ты ухмыляешься.")

		saynn("[say=pc]Думаю, ты сможешь~.[/say]")

		saynn("Она снова заливается румянцем. Она берет игрушку за основание... и игриво облизывает влажный кончик.")

		saynn("[say=pc]Форма просто потрясающая, один из лучших членов, на которых я скакала~.[/say]")

		saynn("[say=artica]Ах.. т-ты д-действительно так с-считаешь?..[/say]")

		saynn("Ты киваешь, заставляя пушистую бестию извиваться еще сильнее, и просто посмеиваешься.")

		saynn("[say=pc]Давай, спрячь его где-нибудь в камере.[/say]")

		saynn("Она кивает в ответ... и быстро убегает к своей камере.")

		saynn("Ого, твой "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+" всё еще пульсирует, пытаясь сомкнуться.. Послевкусие такое сильное..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "pc_knotfuck"):
		playAnimation(StageScene.CanineDildoSex, "knot", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("..но ты всё еще чувствуешь жажду. Почему-то твое тело требует добавки.")

		saynn("Одним мощным рывком ты освобождаешься от этого узла, твой разверзшийся "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+" пульсирует, пока волна наслаждения разливается по всему телу..")

		saynn("Но вместо того чтобы остановиться, ты продолжаешь насаживаться на стержень, снова втискивая свою "+str("pussy" if GM.pc.hasReachableVagina() else "butt")+" на эту длину, заставляя узел войти внутрь и намертво пригвоздить тебя к игрушке... пока ты снова не вырвешь её.")

		saynn("[say=pc]Ах!.. Твою мать, да!..[/say]")

		saynn("[sayFemale]Какого хера? Это что, {pc.she}..[/sayFemale]")

		saynn("[sayMale]Трахнуть этот гигантский дилдо узлом, да? Ну и сучка безумная.[/sayMale]")

		saynn("Толпа в благоговейном ужасе наблюдает за тем, как ты непринужденно позволяешь этому жирному узлу входить и выходить из твоего растянутого, влажного "+str("cunt" if GM.pc.hasReachableVagina() else "asshole")+", страстно стоная при каждом движении..")

		saynn("Твоя дырка, размягченная этим членом, теперь легко растягивается вокруг узла.. позволяя тебе скакать на нем всё быстрее.. Каждый раз, когда узел выходит, ты чувствуешь внутри холодную пустоту.. пустоту, которую вскоре снова заполняет толстая силиконовая плоть.")

		saynn("Узел идеально стимулирует твои чувствительные точки.. буквально вбиваясь в них.. Ты запрокидываешь голову и просто стонешь, а твое тело дрожит, когда очередная волна оргазма накрывает тебя, твоя "+str("pussy gushing out juices" if GM.pc.hasReachableVagina() else "asshole clenching again")+""+str(", cock dribbling your seed" if GM.pc.hasPenis() else "")+"..")

		addButton("Быстрее!", "Еще! Еще!", "pc_knotfuck_fast")
	if(state == "pc_knotfuck_fast"):
		playAnimation(StageScene.CanineDildoSex, "knotfast", {pc="pc", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Артика наблюдает, завороженная, ее настоящий член пульсирует от желания, ведь она не может отвести от тебя глаз..")

		saynn("Даже во время множественных оргазмов ты продолжаешь, заставляя себя идти дальше, испытывая выносливость. Узел входит и выходит, заставляя твою "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+"раскрытая и расслабленная, всё твоё тело дрожит, а из горла вырываются похотливые стоны.")

		saynn("[say=pc]Ах.. ах.. я такая.. такая сучка-узловая..[/say]")

		saynn("Этот дилдо заполняет тебя целиком, даря невероятное наслаждение.. Твой разум затоплен удовольствием. Пока ты кончаешь снова и снова, твои бёдра дико содрогаются, а любовный туннель сжимается вокруг игрушки, пытаясь её «доить». Этот цикл кажется бесконечным: каждый оргазм перетекает в следующий, доводя твоё тело до самого предела.."+str(" Your cock barely shoots any seed, just twitching during each climax.." if GM.pc.hasPenis() else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "pc_knotfuck_ends")
	if(state == "pc_knotfuck_ends"):
		playAnimation(StageScene.CanineDildoSex, "knotinside", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("Наконец, ты начинаешь замедляться, усталость берет своё.. Твой разум постепенно проясняется..")

		saynn("Ты просто сидишь, насаженная на узловатый дилдо, твоё "+str("pussy" if GM.pc.hasReachableVagina() else "anus")+" растянутое и измученное, соки стекают по его стержню..")

		saynn("Ты бросаешь взгляд на застенчивую Артику; на твоих губах играет удовлетворенная улыбка, пока ты наблюдаешь, как она снова кончает, а её член пульсирует в её лапах. Невольно задумываешься: неужели то, что она видела, как ты скачешь на копии её члена, заставило её так завестись..?")

		addButton("Хватит", "Попытайся освободиться и награди Артику!", "pc_enough_givetoy")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "read_note"):
		processTime(3*60)

	if(_action == "in_workshop"):
		processTime(10*60)

	if(_action == "artica_walks_with_dildo"):
		processTime(5*60)

	if(_action == "risha_meets_artica"):
		processTime(3*60)

	if(_action == "artica_gets_on_her_knees"):
		processTime(2*60)

	if(_action == "help_artica_unstuck_risha"):
		processTime(3*60)

	if(_action == "artica_in_cellblock_oops"):
		processTime(5*60)

	if(_action == "artica_trips"):
		processTime(60)

	if(_action == "lilacs_near_dildo"):
		processTime(5*60)

	if(_action == "a_solution"):
		processTime(2*60)

	if(_action == "first_person_rides"):
		processTime(3*60)
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {})
		addCharacter(npcID)

	if(_action == "second_person"):
		processTime(4*60)
		var savedNPCid = npcID
		removeCharacter(npcID)
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [[NpcCon.AvoidIDs, [savedNPCid]]], InmateGenerator.new(), {})
		addCharacter(npcID)

	if(_action == "second_cums"):
		processTime(3*60)

	if(_action == "artica_turn"):
		processTime(3*60)
		removeCharacter(npcID)

	if(_action == "artica_starts_riding"):
		processTime(3*60)

	if(_action == "artica_rides_faster"):
		processTime(5*60)

	if(_action == "artica_fails_to_take_the_knot"):
		processTime(5*60)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "artica_getsup_after_fail"):
		processTime(3*60)

	if(_action == "do_comfort"):
		processTime(3*60)

	if(_action == "do_participate"):
		processTime(3*60)

	if(_action == "again_start"):
		processTime(5*60)

	if(_action == "again_starts_riding"):
		processTime(3*60)

	if(_action == "again_artica_rides_faster"):
		processTime(5*60)

	if(_action == "artica_knots_dildo_yay"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "after_won_artica"):
		processTime(3*60)

	if(_action == "pc_approach_dildo"):
		processTime(5*60)

	if(_action == "pc_deeper"):
		processTime(2*60)
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 50)

	if(_action == "pc_ride_dildo_sex"):
		processTime(3*60)
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 50)

	if(_action == "pc_ride_faster"):
		processTime(3*60)
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 50)
		GM.pc.orgasmFrom("pc")

	if(_action == "pc_accidently_knots_toy"):
		processTime(3*60)
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 50)
		GM.pc.orgasmFrom("pc")
		getModule("ArticaModule").triggerCorruption(0.03)

	if(_action == "pc_enough_givetoy"):
		processTime(3*60)

	if(_action == "pc_knotfuck"):
		processTime(5*60)
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 50)

	if(_action == "pc_knotfuck_fast"):
		processTime(3*60)
		GM.pc.orgasmFrom("pc")
		GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina if GM.pc.hasReachableVagina() else BodypartSlot.Anus, 60)

	if(_action == "pc_knotfuck_ends"):
		processTime(3*60)
		GM.pc.addStamina(-500)
		getModule("ArticaModule").triggerCorruption(0.02)

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
	data["npcID"] = npcID

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
	npcID = SAVE.loadVar(data, "npcID", "")
