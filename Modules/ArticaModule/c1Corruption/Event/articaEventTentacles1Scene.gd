extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaEventTentacles1Scene"

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
		aimCameraAndSetLocName("yard_vaulthere")
		saynn("Похоже, Артика просто хочет прогуляться по двору.")

		saynn("Она идет по каменным дорожкам, жадно вдыхая свежий воздух."+str(" Her paws are covering her private bits from any random onlookers.. trying to." if nakedAndShy else "")+"")

		saynn("Ты просто следуешь за этой пушистой задницей на некотором расстоянии, гадая, откуда у неё вдруг взялась такая тяга к приключениям. Ведь она ведь до последнего не хотела покидать столовую...")

		saynn("Артика заглядывает в спортзал... и видит толпу парней и девчонок, которые там качаются... кажется, это зрелище её не особо прельщает.")

		saynn("Но вот этот второй этаж... Артика то и дело поглядывает в сторону зоны для персонала... почему-то её дико тянет к теплицам. Может, она проголодалась?")

		saynn("Она заходит в тупик, ближайший к вам. Сами теплицы расположены на возвышении... на платформе, на которую ей явно не залезть. Но она пытается: подпрыгивает изо всех сил, стараясь хоть что-то там разглядеть.")

		saynn("После нескольких безрезультатных попыток Артика останавливается... и вздыхает. Похоже, она готова сдаться и вернуться на своё место.")

		addButton("Следовать", "Посмотреть, что будет дальше", "artica_near_stairs")
	if(state == "artica_near_stairs"):
		aimCameraAndSetLocName("yard_nearstairs")
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		saynn("На обратном пути Артика замечает своего рода... секретный проход. Скрытая за высокими зелеными кустами, это... лестница, ведущая прямиком туда, куда она так хотела попасть! Но на ней явно висит знак «запретная зона для заключенных».")

		saynn("Артика замирает... и начинает размышлять. Вероятно, она прикидывает, стоит ли нарушать правила... просто чтобы удовлетворить своё любопытство.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sudden_nova")
	if(state == "sudden_nova"):
		addCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="nova"})
		saynn("[say=nova]Думаешь что-нибудь стащить~?[/say]")

		if (isNaked):
			saynn("Артика вздрагивает, когда охранник подходит сзади."+str(" Her paws momentarily spot covering her private bits, exposing her hard cyan cock to their gaze.." if nakedAndShy else " Her exposed hard cock is bouncing up and down as she does it..")+"")

		else:
			saynn("Артика вздрагивает, когда охранник подходит сзади. Взгляд охранника тут же приковывается к натянутым шортам Артики...")

		saynn("[say=artica]Ой!..[/say]")

		saynn("[say=nova]Охх~. Неужели кого-то настолько сильно штырит от яблок?[/say]")

		saynn("[say=artica].. ..[/say]")

		saynn("Когда она не напугана, Артика говорит очень тихо... Ты почти не слышишь, что она шепчет хаски.")

		saynn("[say=nova]Не только от яблок, да. Но, знаешь, другие растения, которые там выращивают... скажем так, весьма... экзотичные. Чего это ты так любопытствуешь?[/say]")

		saynn("Артика часто моргает, её щеки заливает румянец.")

		saynn("[say=artica].. .. .. ..[/say]")

		saynn("[say=nova]Понятия не имею, я тут просто караулю. Лучше спроси кого-нибудь в медблоке, они делают из некоторых из них лекарства.[/say]")

		saynn("Артика едва заметно кивает.")

		saynn("[say=artica].. ..[/say]")

		saynn("[say=nova]Может, хочешь экскурсию? Правда, потом мне придется устроить тебе обыск догола, чтобы убедиться, что ты ничего не стащила~.[/say]")

		saynn("Щёки девушки густо краснеют. Охранница сокращает дистанцию и ласково улыбается.")

		saynn("[say=nova]Да ладно тебе... Я не кусаюсь~. Разве что если ты сама будешь умолять меня оставить на тебе метку~.[/say]")

		saynn("Артика опускает взгляд.")

		saynn("[say=artica].. ..[/say]")

		saynn("[say=nova]Оу~. Ну, валяй тогда, милашка, я не держу. Но если вдруг захочешь, чтобы я помогла тебе утолить твою жажду...[/say]")

		saynn("Охранница подмигивает.")

		saynn("[say=artica]..[/say]")

		saynn("[say=nova]Хе-хе~.[/say]")

		saynn("Артика кивает и направляется прочь, кажется, в сторону главного лифта. Она и правда вовсю исследует это место.")

		addButton("Следовать", "Смотреть, что будет дальше", "in_medical")
	if(state == "in_medical"):
		removeCharacter("nova")
		addCharacter("eliza")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="eliza"})
		aimCameraAndSetLocName("med_lobby_start")
		saynn("Очевидно, что в том же лифте, что и Артика, тебе не поехать... так что остаётся только ждать следующий.")

		saynn("Пока ты тайком пробираешься в медицинское лобби и присаживаешься на одну из скамеек, ты видишь, как Артика увлечённо болтает с врачом-кошаткой. Какое бы желание ею ни двигало, похоже, его достаточно, чтобы вытолкнуть эту пушистую девчонку из зоны комфорта и заставить общаться с людьми."+str(" Even while naked.." if isNaked else "")+"")

		saynn("[say=artica].. ..[/say]")

		saynn("Но она всё ещё говорит довольно тихо...")

		saynn("[say=eliza]Я бы с радостью тебе помогла, правда. Просто не думаю, что смогу — здесь мои руки связаны. Чёртова бюрократия![/say]")

		saynn("Артика выглядит грустной; она опускает взгляд и начинает поглаживать свой хвост.")

		saynn("[say=eliza]Вообще-то... кажется, есть кое-что, что мы можем сделать.[/say]")

		saynn("Доктор хватает свой датапад и отводит Артику в сторону, подальше от посторонних глаз, прежде чем что-то ей показать. Ты сидишь слишком далеко, чтобы разглядеть это...")

		saynn("[say=eliza]Видишь это растение? Они не позволяют мне даже подойти к нему близко. И, кажется, я знаю почему! Его молекулярная структура может служить основой для очень мощного искусственного удобрения... ну и для кое-чего ещё... Думаешь, сможешь принести его мне?[/say]")

		saynn("[say=artica].. .. ..?[/say]")

		saynn("Доктор пожимает плечами и чешет себя за ухом.")

		saynn("[say=eliza]В смысле... если формулировать именно так, то звучит, конечно, паршиво. Но это же ради науки![/say]")

		saynn("Кошка улыбается.")

		saynn("[say=eliza]Принеси его мне... и, думаю, я смогу тебе помочь~.[/say]")

		saynn("Артика неохотно кивает и направляется обратно к лифту.")

		saynn("Интересно... Похоже, у Артики теперь есть какая-то миссия.")

		addButton("Следовать", "Посмотрим, на что она способна", "artica_near_stairs_again")
	if(state == "artica_near_stairs_again"):
		removeCharacter("eliza")
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("yard_nearstairs")
		saynn("Вы следуете за девушкой, когда она возвращается во внутренний двор... к тому полусекретному проходу на верхний этаж.")

		saynn("Сначала она просто озирается по сторонам, чтобы убедиться, что её никто не видит. Не очень-то успешно, ведь вам удаётся мастерски не попадаться ей на глаза. Но что ж, бывает.")

		saynn("После этого она начинает красться по лестницам, стараясь избегать любой явной опасности...")

		saynn("Делать всё равно нечего, поэтому вы решаете пригнуться и следовать за этой пушистой девчонкой... своего рода телохранителем.")

		addButton("Следовать", "Смотреть, что будет дальше", "artica_sneaks")
	if(state == "artica_sneaks"):
		playAnimation(StageScene.Solo, "crawl", {pc="artica"})
		aimCameraAndSetLocName("green_chokepoint")
		saynn("Несмотря на то, какой застенчивой и нервной она иногда бывает, она не глупа. Артика с лёгкостью обходит патрули, лишь осторожно высовывая голову и выбирая маршруты с наименьшим количеством охраны.")

		saynn("Вы идёте за ней, но держитесь на расстоянии пары препятствий, чтобы не спугнуть её. Маршрут, который она выбрала, весьма продуман...")

		saynn("Вскоре она добирается до теплиц! Но сначала ей нужно миновать своего рода узкое место... коридор, в обход которого не пройти... и там, конечно же, стоит охранник...")

		saynn("Артика прячется за металлическими ящиками... и терпеливо ждёт.")

		saynn("Однако удача не на её стороне: кажется, ничего не меняется, и охранник всё так же преграждает единственный путь.")

		saynn("По какой-то причине Артика уставилась прямо в потолок... а затем внезапно издала пронзительный щебет... очень похожий на птичий...")

		saynn("[sayMale]А? Здесь есть кто-нибудь?[/sayMale]")

		saynn("Артика снова щебечет, и громкий звук эхом разносится по всему двору.")

		saynn("[sayMale]Кто это делает?.. Какого черта...[/sayMale]")

		saynn("Сбитый с толку охранник поворачивается к нижнему уровню... и начинает внимательно осматриваться. Пока он занят, Артика встает на четвереньки и быстро проползает мимо него в одну из теплиц!")

		saynn("Вы быстро идете следом...")

		addButton("Теплицы", "Посмотрим, на что она способна", "artica_takes_plant")
	if(state == "artica_takes_plant"):
		aimCameraAndSetLocName("main_greenhouses")
		playAnimation(StageScene.Solo, "stand", {pc="artica"})
		saynn("Вы заглядываете внутрь и замечаете, что Артика что-то ищет. Здесь повсюду стоят лотки с самыми разными растениями, и девушка просматривает их одно за другим, пытаясь найти нужное...")

		saynn("Взгляд Артики останавливается на одном маленьком растении. Она быстро хватает его и прячет.")

		saynn("Но как раз перед тем, как она успевает уйти...")

		saynn("[say=nova]Ох, смотри-ка, кто это уже вернулся~.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "nova_catches_artica")
	if(state == "nova_catches_artica"):
		addCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="nova"})
		saynn("Стражница стоит у входа, преграждая Артике единственный путь к отступлению. Тебе удается остаться незамеченной, спрятавшись за подносами.")

		saynn("[say=artica]Ой...[/say]")

		saynn("[say=nova]Как-то я знала, что найду тебя здесь~. Заблудилась, милашка?[/say]")

		saynn(""+str("Naked Artica shrugs and covers her privates" if isNaked else "Artica shrugs")+", её ноги слегка дрожат.")

		saynn("[say=nova]Ну и... что же нам с тобой делать? Думаю, можно начать с того, что ты вытряхнешь всё из своих карманов...[/say]")

		saynn("Стражница начинает медленно приближаться к девушке; с каждым тяжелым шагом её бронированных сапог Артика всё сильнее съеживается... Пока та не сдается и не показывает украденный цветок.")

		saynn("[say=artica].. .. ..[/say]")

		saynn("[say=nova]Серьезно, а~? Ты так сильно любишь цветочки~? Никогда бы не подумала.[/say]")

		saynn("[say=artica]..[/say]")

		saynn("Артика осторожно кладет яркое растение на пол и отступает назад. Стражница улыбается и облизывает губы, продолжая наступать.")

		saynn("[say=nova]Что-то мне сомневается, что ты пришла сюда ради любви к цветам~. Тебе придется показать мне... всё, что у тебя есть, сладкая булочка.[/say]")

		saynn("Бедная Артика дрожит всем телом, её глаза широко распахнуты."+str(" For some reason her state of fear isn't affecting her arousal, the girl is hard as a rock.." if isNaked else " For some reason her state of fear isn't affecting her arousal, the girl's shorts are bulging..")+"")

		addButton("Просто наблюдай", "(Порча) Позволить Нове лапать Артику во время обыска с раздеванием..", "let_nova_fun")
		addButton("Сразиться с Новой", "Дать о себе знать", "fight_nova")
		addButton("Псс..", "Попытаться достаточно отвлечь хаски, чтобы совершить быстрый побег. Придется вернуться за растением в другой раз..", "psst_husky")
	if(state == "fight_nova"):
		playAnimation(StageScene.Duo, "shove", {npc="nova", npcAction="hurt"})
		saynn("Ты не собираешься позволять этой охраннице задирать Артику; резким рывком ты отталкиваешь хаски подальше от своей пушистой шкурки.. обе выглядят весьма удивленными.")

		saynn("[say=artica]Ах![/say]")

		saynn("[say=nova]Ах.. Ого, ты откуда взялась?[/say]")

		saynn("Нова переключает всё своё внимание на тебя.")

		saynn("[say=nova]Ты что, её ангел-хранитель~? Хотя настоящий Ангел здесь — это я~.[/say]")

		saynn("Она тянется к своему электрошокеру.. В то время как Артика просто прижимается к стене позади неё, часто хлопая глазами.")

		saynn("Пора сражаться!")

		addButton("Драться", "Начать бой", "start_fight")
	if(state == "won_nova"):
		playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="defeat"})
		saynn("Пораженная Нова падает перед тобой на колени.")

		saynn("[say=nova]Агх..[/say]")

		saynn("Артика быстро подбегает к тебе.")

		saynn("[say=artica]Как ты.. это сделал..[/say]")

		saynn("[say=pc]Знаешь, я тут тоже ворую.[/say]")

		saynn("[say=artica]Ох..[/say]")

		saynn("Нова улыбается, видя вас двоих вместе.")

		saynn("[say=nova]Вы двое.. просто прелесть.[/say]")

		saynn("[say=pc]Угу.[/say]")

		saynn("Ты шепчешь Артике, чтобы она взяла всё, что ей нужно. Девушка быстро подбирает цветок, который выронила, когда сдавалась Нове, и возвращается к тебе.")

		saynn("[say=artica]Понятно..[/say]")

		saynn("Пока хаски всё ещё занята восстановлением, ты просто хватаешь Артику за руку и убегаешь, пока не набежала новая стража!")

		saynn("[say=nova]Даже прощального поцелуя не было..[/say]")

		addButton("Бежать", "Быстро уйти", "won_runaway")
		addButton("Прощальный поцелуй", "Просто потому что она просит..", "meme_kiss")
	if(state == "meme_kiss"):
		playAnimation(StageScene.Hug, "kiss", {pc="pc", npc="nova"})
		saynn("Ты замираешь на месте... и возвращаешься к Нове.")

		saynn("Суровым взглядом ты помогаешь ей подняться, а затем крепко прижимаешь к себе. Ваши губы сталкиваются в долгом страстном поцелуе, и твой язык проникает в её пасть, переплетаясь с её языком.")

		saynn("Артика просто стоит, часто хлопая глазами с широко разинутой пастью.")

		saynn("К концу всего этого взгляд Новы становится отсутствующим...")

		saynn("[say=pc]Вот так. Маленький прощальный поцелуй.[/say]")

		saynn("[say=nova]В-вау...[/say]")

		saynn("Ты хватаешь Артику за руку и убегаешь... на этот раз по-настоящему...")

		addButton("Бежать", "Быстро уйти", "won_runaway")
	if(state == "won_runaway"):
		setFlag("ArticaModule.nextReaction", "t1won")
		removeCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		aimCameraAndSetLocName("yard_vaulthere")
		GM.pc.setLocation("yard_vaulthere")
		saynn("Вы с Артикой перемахиваете через перила и приземляетесь в густых зарослях внутреннего дворика.")

		saynn("[say=artica]С-спасибо... Мне этот цветок тоже н-нужен... эм...[/say]")

		saynn("[say=pc]Тебе не обязательно говорить, Артика. Он твой.[/say]")

		saynn("Она кивает и тихонько хихикает.")

		saynn("[say=artica]Ты такой милый... Увид-имся...[/say]")

		saynn("После этого девушка направляется к своему месту. Судя по тому, насколько она всё ещё возбуждена, она, вероятно, скоро вернется к тому доктору...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "lost_nova"):
		setFlag("ArticaModule.nextReaction", "t1lost")
		playAnimation(StageScene.Duo, "defeat", {npc="nova"})
		saynn("Обессиленный, ты падаешь на колени перед охранником... Артика ахает и бросается к тебе, пытаясь помочь.")

		saynn("[say=nova]Ой... Теперь ты заставляешь меня чувствовать себя виноватой.[/say]")

		saynn("[say=artica]Ты в по-порядке?..[/say]")

		saynn("[say=pc]Да, прости, я просто не смогла.[/say]")

		saynn("Нова хмурится.")

		saynn("[say=nova]Жаль, что я не помогла тебе украсть? Вы оба заслуживаете наказания за то, что оказались здесь.[/say]")

		saynn("[say=artica]Всё хо-орошо... Я мо-огу снова пойти работать в шахты, если это н-необходимо...[/say]")

		saynn("Выражение лица охранника смягчается.")

		saynn("[say=nova]Ой, да ладно... Проваливайте оба. Пока я не передумала.[/say]")

		addButton("Уйти", "Беги, пока есть возможность!", "lose_nova_run")
	if(state == "lose_nova_run"):
		removeCharacter("nova")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		aimCameraAndSetLocName("yard_vaulthere")
		GM.pc.setLocation("yard_vaulthere")
		saynn("Ты хватаешь Артику за руку и вылетаете из теплиц, перепрыгивая через перила, чтобы не попасться на глаза остальным охранникам.")

		saynn("[say=artica]С-спасибо.. К-к-как ты..[/say]")

		saynn("[say=pc]Я тоже оттуда ворую.[/say]")

		saynn("[say=artica]Ох..[/say]")

		saynn("Артика опускает взгляд, что-то осознав.")

		saynn("[say=artica]Я.. у-уронила его там..[/say]")

		saynn("[say=pc]Всё в порядке. Может, я смогу помочь?[/say]")

		saynn("Она пожимает плечами.")

		saynn("Похоже, тебе придётся вернуться туда как-нибудь в другой раз и украсть этот цветок самостоятельно.")

		saynn("[say=artica]Я н-не очень хорошая воровка.. Я п-пойду на своё место..[/say]")

		saynn("Ты киваешь и отпускаешь её.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "psst_husky"):
		setFlag("ArticaModule.nextReaction", "t1ran")
		playAnimation(StageScene.Duo, "stand", {npc="artica"})
		saynn("Может, стоит попробовать отвлечь хаски так же, как Артика отвлекла того другого охранника..")

		saynn("[say=pc]Псс..[/say]")

		saynn("Нова замирает, её уши навостряются... точь-в-точь как у пушистика.")

		saynn("[say=nova]Будешь вести себя хорошо, я... что это было?[/say]")

		saynn("Пока Нова проверяет, откуда донесся шум, ты меняешь укрытие, прячась за другим подносом.")

		saynn("[say=pc]Псс..[/say]")

		saynn("На этот раз тебя замечает только Артика, в её глазах читается удивление. Ты пытаешься позвать её к себе, шепча как можно тише.")

		saynn("[say=pc]..давай же, ну же..[/say]")

		saynn("Как только Нова слышит, как задние лапы Артики цокают по кафелю, она мгновенно переходит в режим боевой готовности.")

		saynn("[say=nova]Эй![/say]")

		saynn("Охранница тоже тебя заметила... ты быстро вскакиваешь, хватаешь Артику за руку и тянешь её к выходу.")

		saynn("[say=nova]А ну вернись сейчас же![/say]")

		addButton("Беги!", "Пора уходить", "after_escape")
	if(state == "after_escape"):
		removeCharacter("nova")
		aimCameraAndSetLocName("yard_vaulthere")
		GM.pc.setLocation("yard_vaulthere")
		saynn("Ты вылетаешь из теплиц и перепрыгиваешь через первое попавшееся ограждение. Оно высоковато... но, к счастью, тебе удается приземлиться на мягкую траву.")

		saynn("Нова пытается тебя догнать... но быстро сбивается с пути и бежит в неверном направлении.")

		saynn("Артика тяжело дышит.")

		saynn("[say=artica]Вау.. ах.. хах.. к-как тебе это..[/say]")

		saynn("[say=pc]Я тоже иногда там ворую.[/say]")

		saynn("Она кивает... а затем опускает взгляд, осознав что-то.")

		saynn("[say=artica]О да.. К сожалению, я н-ничего не прихватила.. но с-спасибо, что спас меня..[/say]")

		saynn("Похоже, тебе придется вернуться туда и самому принести ей нужное растение. По крайней мере, теперь ты знаешь, как оно выглядит!")

		saynn("[say=artica]Д-думаю, мне пора возвращаться на свое место..[/say]")

		saynn("Вы киваете и замечаете, что она всё ещё возбуждена... страх, который она испытала, ничуть не погасил её желание.")

		saynn("[say=pc]Береги себя.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "let_nova_fun"):
		setFlag("ArticaModule.nextReaction", "t1bully")
		#playAnimation(StageScene.SexStanding, "tease", {pc="nova", npc="artica", npcBodyState={naked=true, hard=true}})
		playAnimation(StageScene.Search, "breasts", {pc="artica", npc="nova", bodyState={naked=true, hard=true}})

		addCharacter("artica", ["naked"])
		saynn("Вы решаете остаться и посмотреть, как развернётся эта сцена. Возможно, вам представится шанс заполучить то растение, которое нужно Артике...")

		saynn("[say=nova]Надеюсь, ты будешь вести себя хорошо~?[/say]")

		if (!isNaked):
			saynn("Без особых усилий Нова заставляет Артику прислониться к одной из стен, задрав её руки высоко вверх.")

			saynn("[say=nova]Хорошо. Будь послушной девочкой и не шевелись, пока я это делаю.[/say]")

			saynn("Хаски обследует своими лапами лиловую форму Артики, ища всё, что слишком сильно выпирает... И, очевидно, находит кое-что... но ничего криминального.")

			saynn("[say=nova]Хм.. Контрабанды нет. Но придётся провести полный обым без одежды, чтобы убедиться, что ты чиста~.[/say]")

			saynn("[say=artica]Ой...[/say]")

			saynn("Быстрыми движениями лап Нова расстегивает рубашку Артики и заставляет её снять её, обнажая {artica.breasts} Артики.")

			saynn("[say=nova]Мило~.[/say]")

			saynn("Затем она снова прижимает Артику к стене и на этот раз стягивает с неё шорты, обнажая её тугое анальное отверстие, прикрытое хвостом... а также её возбужденную щель и её "+str("locked away member" if isCaged else "hard dripping member")+"..")

			if (isCaged):
				saynn("[say=nova]Тебя заперли в клетке? Как это мило.[/say]")

			else:
				saynn("[say=nova]Герма... прямо как я. Интересно~.[/say]")

		else:
			saynn("Без особых усилий Нова заставляет Артику прислониться к одной из стен, задрав её руки высоко вверх.")

			saynn("[say=nova]Хорошо. Будь послушной девочкой и не шевелись, пока я это делаю.[/say]")

			saynn("Лапы Новы блуждают по меху Артики, пока та проводит быстрый визуальный осмотр, явно замечая, что у Артики есть и возбужденная щель, и "+str("locked away member" if isCaged else "hard dripping member")+"..")

			if (isCaged):
				saynn("[say=nova]Тебя заперли в клетке? Как это мило.[/say]")

			else:
				saynn("[say=nova]Герма... прямо как я. Интересно~.[/say]")

			saynn("Охранница также проверяет ноги и руки Артики, проводя ладонями по их изгибам.")

			saynn("[say=nova]Контрабанды нет. Думаю, мне нужно провести... более тщательный обыск... чтобы убедиться~.[/say]")

		saynn("Артика не смеет даже пошевелиться, от страха она полностью оцепенела... И Нова это видит.")

		saynn("[say=nova]Ой... Расслабься, я не причиню тебе боли~. Тебе стоит бояться, только если ты была плохой девочкой, заслуживающей наказания...[/say]")

		saynn("Это не особо облегчает участь бедной пушистой бедняжки.")

		saynn("Пальцы Новы скользят по изгибам груди Артики... а затем крепко сжимают её, заставляя девушку тихо ахнуть."+str(" Some breast milk squirts out from her swollen dark nips.." if getCharacter("artica").isLactating() else "")+"")

		if (getCharacter("artica").isLactating()):
			saynn("[say=nova]Какая молочная грудь~.[/say]")

		else:
			saynn("[say=nova]Какая классная грудь~.[/say]")

		saynn("С хитрой ухмылкой на лице охранница двинулась ниже, ведя пальцами по животу"+str(" pregnant" if getCharacter("artica").isVisiblyPregnant() else " fluff")+"и бокам девушки, пока не добралась до её аппетитной девичьей попки.")

		var hasCumInHoles = (getCharacter("artica").hasEffect(StatusEffect.HasCumInsideVagina) || getCharacter("artica").hasEffect(StatusEffect.HasCumInsideAnus))
		saynn("Нова немного разминает ягодицы Артики, снимая напряжение... а затем осторожно разводит их,"+str(", making the fluff's holes leak some of the mess onto her thighs.." if hasCumInHoles else ", making the fluff's tight holes look stretched")+".")

		if (hasCumInHoles):
			saynn("[say=nova]Охх.. Какая ты неаккуратная девчонка~. Но контрабанды нет.[/say]")

		else:
			saynn("[say=nova]Всё скользко и чисто~. Контрабанды нет.[/say]")

		saynn("Артика извивается под прикосновениями Новы, её"+str(" cock pulsing in its small cage" if isCaged else " cock throbbing with need")+"тело дрожит от непрекращающейся ласки. Охранница делает пометку об этом...")

		saynn("[say=nova]Такая голодная.. Ну же, повернись ко мне, милашка.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "nova_makes_artica_cum")
	if(state == "nova_makes_artica_cum"):
		playAnimation(StageScene.Grope, "grope", {pc="artica", npc="nova", pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Артика послушно разворачивается, подставляясь охраннице. Но когда Нова берет в руки электрошокер, глаза пушистой снова округляются от страха.")

		saynn("[say=artica]..[/say]")

		saynn("[say=nova]Это~? Я всего лишь хочу сделать вот так..[/say]")

		saynn("Хаски сжимает рукоять оружия, заставляя его трещать в воздухе. От этого звука Артику пробирает дрожь, и она начинает еще сильнее ерзать.")

		if (!isCaged):
			saynn("Нова ослабляет хватку, а затем проводит кончиком шокера по твердому члену Артики, отчего тот начинает бешено пульсировать, а яички напрягаются даже без всякого разряда тока..")

		else:
			saynn("Нова ослабляет хватку, а затем проводит кончиком шокера по металлической девственной клетке Артики, отчего член внутри начинает бешено пульсировать, а яички напрягаются даже без всякого разряда тока..")

		saynn("[say=nova]Что же ты стащила, сладкая булочка?[/say]")

		saynn("[say=artica].. ..!..[/say]")

		saynn("[say=nova]Всего лишь цветок, значит..[/say]")

		saynn("Нова держит оружие в паре дюймов от неё, а затем снова сжимает рукоять, заставляя шокер искрить электричеством. Артика ахает и выгибает спину,"+str("her locked cock putting more pressure on its cage, precum actively leaking from the tip.." if isCaged else "her hard cock throbbing hard, the knot near the base inflating with blood..")+"")

		saynn("[say=artica].. .. ..[/say]")

		saynn("[say=nova]Угу~. Я тебя слышу~.[/say]")

		saynn("Нова, кажется, заворожена этой реакцией; она ослабляет хватку и подносит дубинку ближе к киске Артики, касаясь холодным кончиком оружия влажных чувствительных складок.")

		saynn("Артику трясет, её взгляд прикован к дубинке... И охранница вовсю этим пользуется, делая вид, будто сжимает рукоять... пока Артика внезапно не кончает!")

		saynn("Словно от удара током, оргазм захватывает её тело; ноги дрожат, когда её {artica.penis} извергается потоком горячей спермы, тягучие струйки разлетаются во все стороны и оседают на растениях...")

		saynn("[say=artica]Н-ня-а-ах..[/say]")

		saynn("Нова не переставая улыбается, наблюдая за тем, как смущенная, изнывающая от оргазма девушка пытается сдержаться.")

		saynn("[say=nova]Ты что, только от страха кончила~?[/say]")

		saynn("Она посмеивается, глядя на то, как густо краснеют щеки Артики.")

		saynn("[say=nova]Я так впечатлена, что даже не знаю, стоит ли тебя сейчас наказывать~. Ладно, "+str("grab your clothes and " if !isNaked else "")+"позволь мне тебя проводить.[/say]")

		saynn("Нова щелкает карабином на ошейнике Артики... а затем уводит её за собой. Глаза пушистой девчонки провожают одинокий цветок, оставшийся лежать на полу...")

		addButton("Цветок!", "Схватить его", "after_nova_grab_flower")
	if(state == "after_nova_grab_flower"):
		removeCharacter("nova")
		removeCharacter("artica")
		playAnimation(StageScene.Solo, "stand")
		GM.pc.setLocation("main_greenhouses")
		saynn("Когда они отвернутся, ты быстро бросаешься к цветку и срываешь его.")

		saynn("Артика, должно быть, обрадуется такому подарку.")

		saynn("Но пора уходить... пока тебя здесь не заметили.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "artica_near_stairs"):
		processTime(5*60)

	if(_action == "sudden_nova"):
		processTime(5*60)

	if(_action == "in_medical"):
		processTime(5*60)

	if(_action == "artica_near_stairs_again"):
		processTime(5*60)

	if(_action == "artica_sneaks"):
		processTime(5*60)

	if(_action == "artica_takes_plant"):
		processTime(3*60)

	if(_action == "nova_catches_artica"):
		processTime(3*60)

	if(_action == "start_fight"):
		runScene("FightScene", ["nova"], "novaFight")
		return

	if(_action == "won_runaway"):
		processTime(3*60)

	if(_action == "meme_kiss"):
		processTime(3*60)

	if(_action == "lose_nova_run"):
		processTime(3*60)
		addMessage("You will have to sneak to the greenhouses yourself to steal that plant for Artica")

	if(_action == "after_escape"):
		processTime(3*60)
		addExperienceToPlayer(20)
		addMessage("Steal a plant from the greenhouses to help Artica")

	if(_action == "nova_makes_artica_cum"):
		processTime(3*60)
		getModule("ArticaModule").triggerCorruption(0.05)

	if(_action == "after_nova_grab_flower"):
		processTime(5*60)
		setFlag("ArticaModule.TentaclesPcHasFlower", true)
		addExperienceToPlayer(50)

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "novaFight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_nova")
			addExperienceToPlayer(50)
			setFlag("ArticaModule.TentaclesArticaHasFlower", true)
			getModule("ArticaModule").addCorruption(0.02)
		else:
			setState("lost_nova")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy

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
