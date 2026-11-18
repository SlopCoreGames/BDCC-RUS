extends RecruitSceneBase

var gentle = false
var mean = false

func _init():
	sceneID = "RahiRecScenePainPublic"

func _run():
	if(state == ""):
		addCharacter("rahi")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Для того, что ты задумал, тебе понадобятся кое어 какие вещи. Ты спрашиваешь Кейт и Энс... и, к счастью, у них всё есть! Плюсы работы в команде.")

		saynn("После этого ты заходишь в камеру Рахи, хватаешь её поводок и притягиваешь её к центру помещения.")

		saynn("[say=pc]"+str(ch1("Our team only needs brave people. I'm going to test your pain tolerance. Trust me, okay?", "Our team only needs brave people. So I'm gonna test how well you handle pain. Understand?", "Our team has no place for cowards. I'm gonna test how well you handle pain. Understand?"))+"[/say]")

		saynn("Рахи моргает, а затем издает отчетливый глотательный звук.")

		saynn("[say=rahi]Она... она не уверена...[/say]")

		saynn("Ты сильнее сжимаешь поводок.")

		saynn("[say=pc]"+str(ch1("I won't do anything that you can't handle. I will be gentle. Now, let's get those clothes off..", "You will have to trust me, kitty cat. Now, clothes off.", "Too bad, if you're not a painslut yet, you will have to become one. Strip. Everything. Or I'll tear them off myself."))+"[/say]")

		saynn("Ты наблюдаешь, как её лапки начинают расстегивать пуговицы на рубашке. Она обнажает перед тобой свою упругую грудь, её соски слегка покалывает от легкого прохладного ветерка. Следом идут шорты: она цепляет когтями пояс и стягивает их вниз, открывая твоему взору её милую розовую киску.")

		saynn("Рахи замирает, пока ты медленно обходишь её кругом, ведя пальцами по её талии, позвоночнику, плечам... прежде чем потянуться к её груди, чтобы ущипнуть сосок. Рахи ахает, выгибая спину.")

		saynn("[say=rahi]Ах... м-мяу...[/say]")

		saynn("Прежде чем она успевает прийти в себя, ты обхватываешь её сзади и отвешиваешь звонкий шлепок по одной ягодице, эхом разлетающийся по всей камере. Затем ты хлопаешь по другой. Рахи вскрикивает, а её хвост непроизвольно сворачивается кольцом.")

		saynn("[say=pc]"+str(ch1("Shh, you're doing beautifully.", "Too much? I bet you can take more.", "You'll take twenty more if I feel like it."))+"[/say]")

		saynn("Твоя рука скользит между её ног, и пальцы находят клитор. Сначала ты просто играешь с ним, похлопывая по чувствительному бугорку то влево, то вправо... а затем сжимаешь его между пальцами... не сильно... но достаточно, чтобы заставить её жалобно скулить.")

		saynn("[say=rahi]..ммм!..[/say]")

		saynn("Свободной рукой ты тянешься ей за спину, почесывая область у основания хвоста, отчего колени Рахи начинают подкашиваться. Похоже, это её эрогенная зона.")

		saynn("[say=rahi]Ахх..[/say]")

		saynn("Ты убираешь руку от её клитора и снова шлепаешь её по заднице, заставляя кошку снова издавать звуки, полные боли.")

		saynn("[say=rahi]Ах.. п-пожалуйста.. она просит прощения..[/say]")

		saynn("[say=pc]"+str(ch1("Nothing to be sorry about. This is just training. Now let's go for a walk.", "It's okay, kitty. Just try to endure. Let's switch the scenery.", "We're just getting started, little paintoy."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "near_arena")
	if(state == "near_arena"):
		aimCameraAndSetLocName("fight_corner_ne")
		saynn("Ты выводишь Рахи из секретного убежища к ревущей толпе арены. Сейчас там идет сочный бой, так что люди не особо обращают внимание на окружающих. Лапы Рахи шаркают по холодному полу, она прикрывает интимное место хвостом и низко опускает голову, стараясь не привлекать лишнего внимания.")

		saynn("Ты останавливаешься в нескольких метрах от большинства людей... и достаешь небольшой предмет. Это кошачий кнут... тонкий гибкий прут, разделяющийся на множество коротких веревок с узлами на концах. Глаза Рахи расширяются от ужаса.")

		saynn("[say=rahi]Ох.. э-э.. может, это не стоит..[/say]")

		saynn("[say=pc]"+str(ch1("I will be gentle. Please show me your butt.", "Butt or breasts, it's your choice. Butt is less painful.", "You're getting whipped, kitty. Question is how much."))+"[/say]")

		saynn("Рахи дрожит... но кивает. Она разворачивается, крепко упираясь задними лапами и подставляя тебе свою задницу... Нет смысла больше терять время.")

		saynn("Хлыст! Первый удар приходится прямо по её ягодицам, заставляя Рахи подпрыгнуть и взвизгнуть. Ты даже не особо старался — это всё сработала её тревога.")

		saynn("Хлыст! Еще один, чуть ниже первого. Этот уже был ощутимым, Рахи тихонько скулит. Несколько голов оборачиваются — кажется, толпа начинает за тобой подглядывать.")

		saynn("[say=rahi]Хнн.. ах..![/say]")

		saynn("[say=pc]"+str(ch1("Be a good kitty and turn around.", "Turn around, please.", "Turn around, little slut."))+"[/say]")

		saynn("Рахи подчиняется... но как только ты замахиваешься плетью, она тут же пытается прикрыть грудь.")

		saynn("[say=pc]"+str(ch1("If I'm asking for too much, just let me know, kitty. Otherwise.. please?", "Rahi, please, I don't wanna hit your hands. It will hurt like hell.", "I give you three seconds before I smack your hands."))+"[/say]")

		saynn("[say=rahi]М-мяу..[/say]")

		saynn("Она медленно снова открывает тебе свою грудь, её напряженные соски подрагивают в такт её тихому, прерывистому дыханию.")

		saynn("Ты корректируешь прицел... и позволяешь множеству ударов плети обжечь её грудь. Рахи вскрикивает, когда часть ударов приходится прямо по соскам.")

		saynn("[say=rahi]Аах..[/say]")

		saynn("И ты продолжаешь, обходя кошечку со всех сторон. По её заднице прилетает еще несколько раз, отчего на коже проступают красные полосы. Рахи ерзает на месте... её лапы так и норовят прикрыть задницу, но она достаточно умна, чтобы не делать этого.")

		saynn("Всё больше заключенных начинают наблюдать за шоу. Ты слышишь одобрительные выкрики... направленные в твою сторону.")

		saynn("Ты снова принимаешься за её грудь... пара быстрых щелчков заставляют её вздрогнуть. Затем ты приседаешь, целишься между её ног и наносишь резкий удар прямо по её открытой киске. Ты не вкладывал в этот удар много силы... но он всё равно был болезненным.")

		saynn("Рахи запрокидывает голову и кричит, всё её тело сотрясается в конвульсиях, а ноги дрожат. Ты замечаешь блестящую влагу, покрывающую её внутреннюю сторону бёдер.")

		saynn("[say=rahi]Я... хх... ахх... н-не могу...[/say]")

		saynn("Толпе очень нравится шоу, люди тычут пальцами в бедную извивающуюся кошечку.")

		saynn("[say=pc]"+str(ch1("Almost done. You've been very brave. Just a bit more?", "They're watching you. Just a bit more and we can go back.", "They're enjoying your suffering, slut. Wave your tail for them."))+"[/say]")

		saynn("Ты ещё несколько раз хлестаешь её по груди, стараясь действовать мягче и распределяя удары, отчего по её телу всё больше проступают красные полосы. Соски Рахи теперь выглядят куда краснее... совсем как её чувствительный цветок.")

		saynn("[say=rahi]Мммх... с-слишком много...[/say]")

		saynn("Ты видишь, как на глазах наворачиваются слёзы. Похоже, с неё действительно хватит.")

		saynn("[say=pc]"+str(ch1("All right. Let's get you back.", "That's enough then. Follow.", "Alright, you've satisfied the crowd."))+"[/say]")

		saynn("Ты снова хватаешь её за поводок и приказываешь следовать за собой. Рахи пытается прикрыться... но стоит ей коснуться себя хоть где-то, как она тут же шипит от боли.")

		saynn("[say=rahi]...ой... ой...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_cell")
	if(state == "back_to_cell"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={leashedBy="pc", naked=true}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Ты возвращаешь Рахи в камеру. Цепь снова прикована к трубе. Она всё ещё рисует, а по её лицу текут слёзы. Всё её тело дрожит.")

		saynn("Ты знал, что что-то подобное случится, поэтому попросил охлаждающий гель... на упаковке сказано, что в составе алоэ и какой-то обезболивающий компонент... сойдёт. Ты подходишь к кошечке и начинаешь осторожно наносить его на её задницу... на грудь... на чувствительную зону между ног. Сначала Рахи вздрагивает... но затем вздыхает, когда жжение начинает утихать.")

		saynn("[say=rahi]Т-спасибо...[/say]")

		saynn("[say=pc]"+str(ch1("Of course. You did wonderfully.", "You earned it, kitty.", "Don't thank me. Just remember who you are."))+"[/say]")

		saynn("Ты заканчиваешь наносить гель и отступаешь на шаг.")

		saynn("[say=rahi]Это.. было слишком.. всё целиком..[/say]")

		saynn("Да уж, похоже, ей это не особо нравится.")

		saynn("Ты выходишь из камеры, чтобы посмотреть, что об этом думает Кейт...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "near_arena"):
		processTime(3*60)

	if(_action == "back_to_cell"):
		processTime(15*60)

	setState(_action)

func saveData():
	var data = .saveData()

	data["gentle"] = gentle
	data["mean"] = mean

	return data

func loadData(data):
	.loadData(data)

	gentle = SAVE.loadVar(data, "gentle", false)
	mean = SAVE.loadVar(data, "mean", false)
