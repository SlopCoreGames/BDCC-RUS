extends SceneBase

var npcID = ""

func _init():
	sceneID = "DomM2s2"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		addCharacter("kait")
		saynn("Вы обнаруживаете, что Кейт уже в блоке камер.")

		saynn("[say=kait]Эй.[/say]")

		saynn("[say=pc]Эй.[/say]")

		saynn("Кейт оглядывается по сторонам.")

		saynn("[say=kait]Где эта дурацкая лисица? Опять опаздывает?[/say]")

		saynn("Вы пожимаете плечами. И вправду, этой смуглой лисицы нигде не видно.")

		saynn("[say=pc]Есть вести о Ферри?[/say]")

		saynn("[say=kait]Неа.[/say]")

		saynn("Ну что ж. Тогда делать особо нечего.")

		saynn("Вы оба находите стену, чтобы прислониться к ней, и просто ждете.")

		saynn("[say=kait]То, что мы впустили Эви, возможно, было ошибкой.[/say]")

		saynn("[say=pc]Она помогала со списками.[/say]")

		saynn("[say=kait]Рано или поздно мы бы и сами во всем разобрались.[/say]")

		saynn("[say=pc]Рано или поздно. А она справилась меньше чем за минуту.[/say]")

		saynn("[say=kait]И теперь она нам не нужна.[/say]")

		addButton("Возможно", "Может, Кейт и права", "say_maybe_right")
		addButton("Держаться вместе", "Нам нужно держаться вместе, если хотим провернуть это дело", "say_stick_together")
	if(state == "say_maybe_right"):
		saynn("[say=pc]Возможно, ты и прав. Хотя Энс это вряд ли обрадует.[/say]")

		saynn("[say=kait]Верно.[/say]")

		saynn("Кейт запрокидывает голову, и её круглые ушки прижимаются к стене позади неё.")

		saynn("[say=kait]Черт возьми, в этой жизни ничего не дается легко.[/say]")

		saynn("[say=ferri]Эй ты![/say]")

		saynn("Интересный голосок... Ты оглядываешься и видишь разворачивающуюся перед глазами сцену.")

		saynn("[say=pc]Псс. Поныть о жизни успеем.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_intro_guard")
	if(state == "say_stick_together"):
		saynn("[say=pc]Нам нужно держаться вместе, Кейт. Эви — это лишняя пара рук, постарайся потерпеть её. Не будь такой грубой.[/say]")

		saynn("[say=kait]Это она первая начала, блин.[/say]")

		saynn("Кейт запрокидывает голову, и её круглые ушки прижимаются к стене позади неё.")

		saynn("[say=kait]Черт возьми, в этой жизни ничего не дается легко.[/say]")

		saynn("[say=ferri]Эй ты![/say]")

		saynn("Интересный голосок... Ты оглядываешься и видишь разворачивающуюся перед глазами сцену.")

		saynn("[say=pc]Псс. Поныть о жизни успеем.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_intro_guard")
	if(state == "ferri_intro_guard"):
		addCharacter("ferri")
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {pc="ferri", npc=npcID})
		saynn("Перед вами существо, которое можно описать только как драконо-кошка... так что описание не врет. Рядом с ней стоит охранница, которая поворачивается к заключенной, уже зажав электрошокер в {npc.his} руке.")

		saynn("[say=npc]Чего тебе?[/say]")

		saynn("Ферри облизывает клыки. Она находится в нескольких метрах, но начинает сокращать дистанцию.")

		saynn("[say=ferri]А у вас отличная броня, офицер![/say]")

		saynn("[say=npc]И это всё? Ну ладно. Проваливай, пока я тебя не приложила.[/say]")

		saynn("Кошкоподобная гибрид продолжает наступать с дерзкой ухмылкой на лице.")

		saynn("[say=ferri]Хотя я вижу в ней столько уязвимых мест... будет жаль, если кто-нибудь ими воспользуется~.[/say]")

		saynn("[say=npc]Так и просится, чтобы на нее нажали кнопкой тревоги.[/say]")

		saynn("Охранница явно напряглась, {npc.he} тянется к {npc.his} пульту дистанционного управления.")

		saynn("[say=ferri]Ой, да ладно вам. Я же просто играю. Мяу.[/say]")

		saynn("Ферри поднимает свои когтистые лапы... и делает еще один дерзкий шаг вперед, соблазнительно покачивая бедрами, пока ее огромный драконий хвост лениво волочится позади.")

		saynn("[say=ferri]Ты и правда собираешься ударить током меня в шею~? Заставишь меня упасть на колени и истошно кричать от невыносимой боли~?[/say]")

		saynn("[say=npc]Да.[/say]")

		saynn("[say=ferri]И что тогда? Наденешь на меня ошейник и намордник? Скуешь все мои конечности так, что я не смогу пошевелить даже мускулом?[/say]")

		saynn("[say=npc]Конечно.[/say]")

		saynn("[say=ferri]Или, что еще лучше, засунешь меня в колодки и позволишь своим дружкам поиметь меня? Раунд за раундом, пока от меня не останется одна слюнявая лужица.[/say]")

		saynn("[say=npc]Почему бы и нет.[/say]")

		saynn("Ферри делает короткую паузу... но затем снова улыбается.")

		saynn("[say=ferri]Мррр. Значит, тогда мне стоит поторопиться![/say]")

		saynn("Как только рука охранника начинает зависать над пультом, Ферри прыгает на {npc.him}, пытаясь вонзить свои огромные клыки в шею охранника!")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_bites_guard")
	if(state == "ferri_bites_guard"):
		playAnimation(StageScene.Duo, "bite", {pc="ferri", npc=npcID, npcAction="hurt"})
		saynn("Электрошокер вылетает из рук охранницы, когда Ферри прыгает на {npc.him}, пытаясь вонзить свои острые клыки в любую открытую часть кожи.")

		saynn("Охраннице удается сдержать её на время, и бронированные предплечья {npc.his} спасают {npc.him}.")

		saynn("[say=ferri]Да ладно тебе, ты такая вкусная, так и хочется укусить![/say]")

		saynn("[say=npc]Ты только всё усложняешь, заключенная.[/say]")

		saynn("[say=ferri]Хорош![/say]")

		saynn("Ферри бьется в хватке охранницы, клацая клыками в пустоте; её когти скрежещут по броне, высекая искры.")

		saynn("Внезапно охраннице удается ухватиться за рога Ферри.")

		saynn("[say=ferri]Э-эй..![/say]")

		saynn("Дрожь пробегает по спине Ферри, её глаза расширяются. Она пытается вырваться, но охранница лишь тянет её назад, и одна из {npc.his} рук тянется к оружию.")

		saynn("[say=ferri]Полегче с рогами...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_gets_rekt")
	if(state == "ferri_gets_rekt"):
		playAnimation(StageScene.Duo, "defeat", {pc="ferri", npc=npcID, npcAction="stunbaton"})
		saynn("Теперь, когда охранница крепко сжала Ферри, {npc.he} она просто раз раз — и бьет её электрошоковой дубинкой..")

		saynn("[say=ferri]Аааагх![/say]")

		saynn("Ноги Ферри мгновенно подкашиваются, и драконья кошка падает на колени, с грохотом ударившись хвостом о пол. Всё её тело дрожит, зубы стиснуты.")

		saynn("Ферри пытается съязвить, но из горла вырывается лишь сдавленный скулёж.")

		saynn("Вы толкаете Кейт локтем и шепчете ей на ухо.")

		saynn("[say=pc]И это наш химик?[/say]")

		saynn("[say=kait]Ага.[/say]")

		saynn("Охранница лезет в {npc.his} подсумки и достает намордник. Ферри пытается вырваться, но тело всё еще бьет в конвульсиях от разряда, поэтому охранница легко натягивает намордник на её мордочку и туго затягивает кожаные ремни.")

		saynn("[say=ferri]М-Мяу..[/say]")

		saynn("Затем охранница резко заводит её руки ей за спину. Раздается щелчок наручников, стягивающих её запястья.")

		saynn("[say=ferri]Щёлк..[/say]")

		saynn("Последний штрих... к её ошейнику пристегивают поводок.")

		saynn("[say=npc]Вот так. Знаю, ты хотела колодки, но придётся довольствоваться неделей в одиночке.[/say]")

		saynn("[say=ferri]Погоди! Это так жестоко![/say]")

		saynn("[say=npc]Хочешь две недели?[/say]")

		saynn("[say=ferri]Ньоо.. мо-о..[/say]")

		saynn("Похоже, она перешла дорогу не тому охраннику. {npc.He} {npc.verb('pull')} тянет за поводок, подзывая гибрида встать.")

		saynn("На этот раз Кейт подталкивает тебя.")

		saynn("[say=kait]Надо что-то делать. Если не вмешаемся сейчас, мы её долго не увидим.[/say]")

		saynn("Похоже на то.")

		saynn("[say=kait]И эта тупая Эви до сих пор не явилась. Гррр.. Ладно, хрен с ней, я попробую![/say]")

		saynn("[say=pc]Нас всё ещё двое против одного, мы справимся.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_shoves_guard")
	if(state == "kait_shoves_guard"):
		playAnimation(StageScene.Duo, "kick", {pc="kait", npc=npcID, npcAction="hurt"})
		saynn("Кейт стремительно подходит к охраннику и представляется мощным пинком!")

		saynn("[say=npc]Ух.. Какого хрена..[/say]")

		saynn("Охранник спотыкается и в процессе выпускает поводок из рук.")

		saynn("[say=kait]Тебе лучше просто свалить, охранник. Это были цветочки.[/say]")

		saynn("[say=npc]Серьёзно? Ну, тогда ты к ней присоединяешься.[/say]")

		saynn("{npc.He} {npc.verb('try', 'tries')} чтобы почувствовать {npc.his} пульт шокера, но он всё ещё где-то на полу. Зато электродубинка всё ещё там.")

		saynn("Ферри замечает возможность... и срывается с места!")

		saynn("[say=kait]Блядь, ты куда, сука, прёшь?! Стой![/say]")

		saynn("Всё идёт... не самым лучшим образом. Кейт быстро оборачивается к тебе.")

		saynn("[say=kait]Я побегу за Ферри, а ты разберись с охранником![/say]")

		saynn("И вот так, Кейт срывается с места, ловко огибая разъярённого охранника полукругом, и бросается в погоню за драконокошкой.")

		saynn("[say=kait]А ну иди сюда, мелкая дрянь![/say]")

		saynn("Похоже, придётся сразиться...")

		addButton("Драться", "Начать бой", "start_fight")
	if(state == "guard_fight_lost"):
		playAnimation(StageScene.Solo, "kneel")
		GM.pc.setLocation(GM.pc.getCellLocation())
		aimCameraAndSetLocName("solitary_cell")
		setCharacters([npcID])
		saynn("Ты проиграл бой. Похоже, именно тебе придётся провести время в одиночке...")

		saynn("Ферри уже далеко. Похоже, поймать её удастся только в другой раз.")

		saynn("Миссия провалена!")

		addButton("Продолжить", "Прервать миссию", "stopthemission")
		addButton("Перезапустить", "Попробовать еще раз", "trymissionagain")
	if(state == "guard_fight_won"):
		setCharacters([npcID])
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcAction="defeat"})
		saynn("Охранник рушится на пол, не в силах продолжать бой.")

		saynn("[say=npc]Ух...[/say]")

		saynn("[say=pc]Прости, болтать некогда, надо бежать![/say]")

		saynn("Вы видите, как {npc.him} тянется к пульту электрошокера, лежащему на полу. Вы стремительно подлетаете к нему и несколько раз наступаете сверху, втаптывая его в крошево из обломков и искр.")

		saynn("[say=pc]Не-а.[/say]")

		saynn("[say=npc]Да пошел ты.[/say]")

		saynn("Вы киваете и бежите в ту же сторону, куда до этого рванула Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "run_after_kait")
	if(state == "run_after_kait"):
		setCharacters([])
		aimCameraAndSetLocName("main_bench2")
		saynn("Вы вылетаете из блока камер высокой безопасности и взлетаете по лестнице, ведущей в главный зал.")

		saynn("Ни Ферри, ни Кейт поблизости не видно. Вы забираетесь и на главную платформу, чтобы проверить наверняка.")

		saynn("[say=pc]Блядь, да где же они.[/say]")

		saynn("Вы слышите очень знакомый звук, доносящийся со скамейки неподалеку.")

		saynn("[say=rahi]Ну и как там... эта штука?[/say]")

		addButton("Рахи!", "Спросить кошку", "ask_the_cat")
	if(state == "ask_the_cat"):
		addCharacter("rahi")
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="sit"})
		saynn("Ты поворачиваешь голову и видишь Рахи: она сидит на скамье, поджав лапки, а хвост лежит у неё на коленях, и она сама его вылизывает.")

		saynn("[say=pc]Рахи! Ты не видела, кто только что пробежал мимо?[/say]")

		saynn("[say=rahi]Ох.. да.. Они направились в сторону туалета..[/say]")

		saynn("Ты быстро гладишь кошечку по голове.")

		saynn("[say=pc]Спасибо. Мне пора бежать.[/say]")

		saynn("[say=rahi]Мяу...[/say]")

		saynn("Тебе удалось немного перевести дух.. Но ты снова пускаешься в бег.")

		addButton("Туалет", "Пойти проверить!", "go_bathroom")
	if(state == "go_bathroom"):
		setCharacters(["ferri", "kait"])
		playAnimation(StageScene.Duo, "stand", {pc="kait", npc="ferri"})
		aimCameraAndSetLocName("main_dressing1")
		GM.pc.setLocation("main_dressing1")
		saynn("Ты находишь их обеих в раздевалке. Кейт тяжело дышит у самого входа.. а Ферри стоит в углу, скаля клыки.. хотя на ней всё ещё надет намордник и наручники.")

		saynn("[say=kait]Да ладно тебе, ты же беспомощная, сдавайся уже.[/say]")

		saynn("[say=ferri]Ах так? Ну, смотри![/say]")

		saynn("Ферри с громким стуком впечатывается мордой в один из шкафчиков. Не самая блестящая идея.")

		saynn("[say=ferri]Ой... м-м-м...[/say]")

		saynn("Пока Ферри приходит в себя, ты встаешь рядом с Кейт и привлекаешь её внимание.")

		saynn("[say=pc]Она сопротивляется?[/say]")

		saynn("[say=kait]Чертовски верно.[/say]")

		saynn("[say=ferri]Я никуда с тобой не пойду! Ты ведь превратишь меня в одну из этих... сучьих тюремных секс-игрушек... Я так и знала![/say]")

		saynn("Пока вы болтаете, Ферри пытается стянуть наручники. Но те сидят намертво.")

		saynn("[say=pc]Конечно, если тебе так хочется.[/say]")

		saynn("[say=ferri]Мяу-м! Ты думаешь, я этого хочу?[/say]")

		saynn("Кейт закатывает глаза.")

		saynn("[say=kait]Мне это уже надоедает.[/say]")

		saynn("Снежная леопардица начинает медленно подходить к драконьей кошке, которая, заметив это, еще сильнее вжимается в угол.")

		saynn("[say=ferri]Я тебя укушу![/say]")

		saynn("[say=kait]Ага. Просто стой смирно и продолжай мне угрожать.[/say]")

		saynn("Вместо того чтобы наброситься на Ферри, Кейт, похоже, пытается поймать поводок, который всё еще болтается на ошейнике этой рыжей.")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_grabs_leash")
	if(state == "kait_grabs_leash"):
		playAnimation(StageScene.Duo, "shove", {pc="kait", npc="ferri", npcBodyState={leashedBy="kait"}, npcAction="hurt"})
		saynn("Кейт продолжает подкрадываться всё ближе и ближе, протягивая руку к свисающему поводку. Всё это время Ферри отклоняется назад. Бежать некуда.")

		saynn("[say=kait]Сдайся уже.[/say]")

		saynn("[say=ferri]Нет![/say]")

		saynn("Кейт удается схватить поводок.")

		saynn("[say=kait]Попался![/say]")

		saynn("Кейт резко дергает за него, заставляя Ферри потерять равновесие.")

		saynn("[say=ferri]Ик![/say]")

		saynn("Дракокошка спотыкается, ее скованные руки болтаются сзади.")

		addButton("Продолжить", "Смотреть, что будет дальше", "kait_gets_tail_swiped")
	if(state == "kait_gets_tail_swiped"):
		playAnimation(StageScene.Duo, "defeat", {pc="kait", npc="ferri", npcAction="dodge"})
		saynn("Но тут..")

		saynn("Ферри резко взмахивает хвостом!")

		saynn("БАМ!")

		saynn("Толстый драконий хвост врезается в ногу Кейт, сбивая ее с ног!")

		saynn("[say=kait]Агх![/say]")

		saynn("При падении она врезается в шкафчик, что только усиливает боль.")

		saynn("[say=kait]..блять..[/say]")

		saynn("Ферри стоит над ней, тяжело дыша.")

		saynn("[say=ferri]Не стоило подходить ко мне так близко, киска.[/say]")

		saynn("Она не теряет времени и начинает раз за разом бить наручниками о край шкафчика.")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_frees_herself")
	if(state == "ferri_frees_herself"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri"})
		saynn("Ей удается разбить один из замков. Лапы освобождаются, и она тут же срывает с лица корзинный намордник.")

		saynn("[say=ferri]Ахх... так-то лучше![/say]")

		saynn("Кайт, похоже, не в силах сопротивляться — удар хвостом выбил из неё дух. Но ты всё ещё преграждаешь единственный выход.")

		saynn("[say=pc]Последний шанс сдаться.[/say]")

		saynn("Ферри скалится, облизывая обнаженные клыки.")

		saynn("[say=ferri]Заставь меня~.[/say]")

		saynn("Похоже, назревает драка!")

		addButton("Драться", "Начать бой", "dom_start_fight")
	if(state == "lost_ferri_fight"):
		playAnimation(StageScene.GivingBirth, "idle")
		saynn("Ты проиграла бой!")

		saynn("[say=ferri]Ого, это было слишком просто![/say]")

		saynn("И вот, Ферри удалось ускользнуть.")

		saynn("Похоже, поймать её тебе придётся в другой раз.")

		saynn("Миссия провалена!")

		addButton("Продолжить", "Прервать миссию", "stopthemission")
		addButton("Перезапустить", "Попробовать еще раз", "trymissionagain")
	if(state == "won_ferri_fight"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="defeat"})
		saynn("Ферри больше не в силах сражаться! Она падает на пол.")

		saynn("[say=ferri]Агх!..[/say]")

		saynn("Ты ловко хватаешь поводок на её ошейнике.")

		saynn("[say=pc]Кейт?[/say]")

		saynn("[say=kait]Я в порядке... Вещи всё ещё при мне.[/say]")

		saynn("Кейт поднимается и медленно приближается к драконьей кошке, слегка прихрамывая. Она приседает позади Ферри и с болью заламывает ей руки за спину.")

		saynn("[say=ferri]Ой![/say]")

		saynn("[say=kait]Заткнись.[/say]")

		saynn("Она хватает хвост и тоже приковывает его к наручникам. Спущенную намордник снова натягивают ей на морду.")

		saynn("[say=kait]Теперь ты у нас в ловушке, сучка.[/say]")

		saynn("[say=ferri]Не, это ты..[/say]")

		saynn("В ответ Кейт дергает за большой хвост.")

		saynn("[say=ferri]Гррх..[/say]")

		saynn("[say=kait]Давайте уже сломаем её.[/say]")

		saynn("Вы натягиваете поводок, вежливо призывая Ферри встать, заставляя ошейник впиться ей в шею.")

		saynn("[say=ferri]Мяу?.. ой..[/say]")

		addButton("Убежище", "Зашвырни Ферри в камеру!", "hideout_ferri")
	if(state == "hideout_ferri"):
		aimCameraAndSetLocName("hideout_breakroom")
		GM.pc.setLocation("hideout_near_break_room")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="sit"})
		saynn("Ты тянешь за поводок, заставляя Ферри идти за тобой. Кейт следит за тем, чтобы та снова не попыталась сбежать.")

		saynn("Вскоре вы прибываете в ваше убежище. Ты заводишь Ферри в камеру и пристегиваешь поводок к одной из труб.")

		saynn("[say=ferri]Что это еще за...[/say]")

		saynn("[say=pc]Сиди смирно. Мы с тобой скоро разберемся.[/say]")

		saynn("[say=ferri]Мяу...[/say]")

		saynn("Ты выходишь из камеры вместе с Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "avy_encounter")
	if(state == "avy_encounter"):
		setCharacters(["avy", "kait"])
		playAnimation(StageScene.Duo, "stand", {pc="kait", npc="avy"})
		aimCameraAndSetLocName("hideout_near_break_room")
		saynn("Как только вы выходите, вы тут же натыкаетесь на Эви.")

		saynn("[say=kait]Эви! Какого хера ты где была?![/say]")

		saynn("[say=avy]Да я тебя искала, тупица. Просто возникло срочное дело. Арена, все дела.[/say]")

		saynn("Кейт сжимает кулаки, в то время как Эви лишь слегка наклоняет голову, демонстрируя полное безразличие.")

		saynn("[say=kait]Арена, черт возьми! Нам бы не помешало пара лишних рук, знаешь ли![/say]")

		saynn("[say=avy]Хах. Ого, ты и без меня совсем ничего сделать не можешь.[/say]")

		saynn("[say=kait]Слушай, если ты начнешь творить всякую херню, мы и тебя сломаем, Эви![/say]")

		saynn("Эви приподнимает бровь, теперь пристально глядя Кейт прямо в глаза.")

		saynn("[say=avy]С удовольствием посмотрю, как ты попытаешься.[/say]")

		saynn("Они наверняка подерутся, если ты не вмешаешься.")

		addButton("Пусть дерутся", "(Послушание Кейт +) Пусть дерутся. Скорее всего, Кейт проиграет", "let_fight")
		addButton("Вмешаться", "(Послушание Эви +) Вмешаться и поставить Эви на место", "intervene_avy")
	if(state == "intervene_avy"):
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("Ты вмешиваешься, вставая между девушками.")

		saynn("[say=pc]Эй, Эйви, скажи мне. Ты хочешь сбежать из этой тюрьмы?[/say]")

		saynn("[say=avy]Очевидно же, раз я здесь торчу. Эти ошейники — просто отстой.[/say]")

		saynn("Пора надавить на неё посильнее.")

		saynn("[say=pc]Этой команде нужны люди, которые не будут подставлять друг друга. Мы можем на тебя положиться, Эйви?[/say]")

		saynn("[say=avy]Конечно. Ну еще бы. Просто у меня тут кое-какие дела были.[/say]")

		saynn("Она всё пытается оправдаться.")

		saynn("[say=pc]Может, ты наконец возьмёшь на себя ответственность, а не будешь просто пытаться от неё отмазаться?[/say]")

		saynn("Эйви высоко задирает подбородок и скрещивает руки на груди. Два сверлящих взгляда заставляют её вздохнуть и закатить глаза.")

		saynn("[say=avy]Ой, всё. Мой косяк?[/say]")

		saynn("[say=pc]Ты можешь лучше. Видишь, как Кейт всё ещё злится? Она просто в ярости.[/say]")

		saynn("Услышав своё имя, Кейт делает нарочито недовольную мордашку и часто-часто кивает.")

		saynn("[say=avy]Ладно! Да, я облажалась. Совсем чуть-чуть. Доволен?[/say]")

		saynn("[say=pc]Ты довольна, Кейт?[/say]")

		saynn("Снежная леопардица медленно пожимает плечами.")

		saynn("[say=pc]Она вполне довольна.[/say]")

		saynn("Воцаряется тишина.")

		saynn("Эви просто стоит неподвижно, её взгляд мечется с места на место, а хвост низко подметает пол.")

		saynn("[say=pc]Да, можете идти. Нам удалось спасти ситуацию.[/say]")

		saynn("Лисица коротко кивает тебе... и уходит.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pc_last_talk_with_kait")
	if(state == "let_fight"):
		playAnimation(StageScene.Duo, "hurt", {pc="kait", npc="avy", npcAction="shove"})
		saynn("Кейт заносит когтистую лапу, пытаясь полоснуть лисицу!")

		saynn("К несчастью, рефлексы Эви достаточно быстры, чтобы перехватить запястье снежного барса. Эви просто заставляет кошку ударить саму себя собственным кулаком. Бэм.")

		saynn("[say=kait]Ай... ха...[/say]")

		saynn("Эви посмеивается")

		saynn("[say=avy]Я была занята. Так что остынь, тупая кошка. Вижу, ты со всем справилась и без меня. Молодец~.[/say]")

		saynn("Кейт забирает свою лапу. Она встряхивает ею и приглаживает взъерошенную шерсть на запястье.")

		saynn("[say=pc]Может, тебе не стоит злить медведя, Кейт?[/say]")

		saynn("[say=kait]Ладно, хрен с тобой.[/say]")

		saynn("Эви ухмыляется и оставляет вас двоих в покое.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pc_last_talk_with_kait")
	if(state == "pc_last_talk_with_kait"):
		setCharacters(["kait"])
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("Теперь, когда Эви ушла, Кейт поворачивается к тебе.")

		saynn("[say=kait]В общем, Ферри мы заполучили, но теперь её надо сломать! Я раздела её догола, но оставлю намордник и наручники.[/say]")
		
		saynn("Хорошая идея, так ты не будешь рисковать получить укус или царапину каждый раз, когда заходишь в камеру.")
		
		saynn("[say=pc]Звучит отлично, спасибо.[/say]")
		
		saynn("[say=kait]Дай знать, когда захочешь набросать план, ты и сама знаешь, как это делается.[/say]")
		
		saynn("Ты киваешь.")

		saynn("Пора за дело.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "ferri_intro_guard"):
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Guards, [], GuardGenerator.new(), {})

	if(_action == "ferri_bites_guard"):
		processTime(5*60)

	if(_action == "ferri_gets_rekt"):
		processTime(5*60)
		putOn("ferri", "basketmuzzle")
		putOn("ferri", "inmatewristcuffs")

	if(_action == "start_fight"):
		runScene("FightScene", [npcID], "guardFight")
		return

	if(_action == "stopthemission"):
		endScene()
		GM.pc.setLocation(GM.pc.getCellLocation())
		GM.main.MS.failCurrentMission()

	if(_action == "trymissionagain"):
		endScene()
		GM.main.MS.restartCurrentMission()
		return

	if(_action == "run_after_kait"):
		processTime(3*60)

	if(_action == "ask_the_cat"):
		processTime(3*60)
		GM.pc.addStamina(100)

	if(_action == "go_bathroom"):
		processTime(2*60)

	if(_action == "ferri_frees_herself"):
		putOff("ferri", "basketmuzzle")
		putOff("ferri", "inmatewristcuffs")

	if(_action == "dom_start_fight"):
		runScene("FightScene", ["ferri"], "ferriFight")
		return

	if(_action == "hideout_ferri"):
		processTime(3*60)

	if(_action == "let_fight"):
		GM.main.MS.setDecision("fight", "let")

	if(_action == "intervene_avy"):
		GM.main.MS.setDecision("fight", "stop")

	if(_action == "pc_last_talk_with_kait"):
		processTime(3*60)
		addMessage("Task updated!")
		GM.main.RCS.setCurrent("Ferri")

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "guardFight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("guard_fight_won")
			addExperienceToPlayer(20)
		else:
			setState("guard_fight_lost")
			addExperienceToPlayer(5)

	if(_tag == "ferriFight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("won_ferri_fight")
			addExperienceToPlayer(50)
			putOn("ferri", "basketmuzzle")
			putOn("ferri", "inmatewristcuffs")
		else:
			setState("lost_ferri_fight")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()

	data["npcID"] = npcID

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
