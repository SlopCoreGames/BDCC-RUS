extends RecruitSceneBase

var gentle = false
var mean = false

func _init():
	sceneID = "RahiRecScenePetplayPublic"

func _run():
	if(state == ""):
		addCharacter("rahi")
		aimCameraAndSetLocName("hideout_breakroom")
		gentle = (c1 == 0)
		mean = (c1 == 2)
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="allfours", further=true, npcBodyState={naked=true, leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Ты входишь в камеру Рахи и хватаешь её поводок. Она не сопротивляется, когда ты ведешь её к выходу... но вдруг замирает и оборачивается.")

		saynn("[say=pc]"+str(ch1("I really wanna trust you. You're gonna be a good puppy for me for a bit, okay?", "I will check how obedient you are. From now on, you're a dog. Until I say otherwise. Got it?", "You will act like a bitch in heat from now on. Do you understand that, slut?"))+"[/say]")

		saynn("Рахи растерянно моргает, её ушки прижимаются к голове.")

		saynn("[say=rahi]Мяу?.. Но она же кошка..[/say]")

		saynn("Твоя хватка на поводке крепнет.")

		saynn("[say=pc]"+str(ch1("Yes, I know. But I wanna see how well you can do this. It's gonna be fun. Let's get those clothes off first, pets don't wear them, do they?", "I only see a puppy in front of me. A very strange puppy. Puppies usually don't wear clothes, do they?", "I don't care. You'll play the part or I'll make you. Now, dogs don't need clothes. Take them off."))+"[/say]")

		saynn("Она колеблется... но в конце концов её лапки начинают расстегивать пуговицы на рубашке. И ты просто наблюдаешь, как она обнажает свою упругую грудь, соски которой теперь ловят легкий прохладный ветерок. Следом идут шорты: она цепляется когтями за пояс и медленно тянет его в стороны, позволяя ткани соскользнуть по бедрам и обнажить её милый розовый цветок.")

		saynn("[say=pc]"+str(ch1("Good. Precious. Now could you get on all fours for me?", "Mhm. Pups don't walk on two legs too.", "Get on all fours."))+"[/say]")

		saynn("Рахи трется мордочкой о лапы... а затем медленно опускается перед тобой, поджав хвост между ног.")

		saynn("[say=rahi]... мяу?..[/say]")

		saynn("[say=pc]"+str(ch1("Almost. Try to get into the mindset of a puppy for me, please? Now let's go for a walk.", "No, that's not the noise that puppies make. Let's go for walk.", "Meow? Really? You're such a dumb pup. Let's go."))+"[/say]")

		saynn("Её щеки едва заметно краснеют. Пора вывести свою собачку на прогулку.")

		addButton("Продолжить", "Смотреть, что будет дальше", "near_arena")
	if(state == "near_arena"):
		aimCameraAndSetLocName("fight_corner_ne")
		saynn("Ты выводишь её из секретного убежища навстрев ревущей толпе арены. Сейчас там идет сочный бой, так что вы не привлекаете слишком много внимания. Лапки Рахи шаркают по холодному полу, хвост поджат, а подбородок опущен.")

		saynn("Время от времени она пытается подняться на задние лапы... но рывок поводка заставляет её снова опуститься.")

		saynn("[say=pc]"+str(ch1("You're doing so well. Just keep crawling, puppy.", "Stay down. Eyes forward. No stopping, just crawl.", "What part of being a bitch don't you understand? Crawl."))+"[/say]")

		saynn("Она подчиняется, медленно ползя за тобой и стараясь ни в кого не врезаться.")

		saynn("Некоторые заключенные начинают обращать на вас внимание. Сначала слышится лишь шепот... затем на вас начинают указывать пальцами. Щеки Рахи краснеют всё сильнее... но она продолжает ползти.")

		saynn("Один из заключенных подходит ближе. Он спрашивает, можно ли погладить Рахи.")

		saynn("Кошка замирает. Она смотрит на тебя широко распахнутыми, умоляющими голубыми глазами.")

		saynn("[say=pc]"+str(ch1("Of course. She loves attention. Just be gentle.", "Yes. But make it quick.", "Go ahead. She's just an animal."))+"[/say]")

		saynn("Заключенная опускается на колени и начинает чесать Рахи за ушком. Та вздрагивает, всё её тело напрягается.")

		saynn("[say=rahi]..ррр-р..[/say]")

		saynn("Её глаза полузакрываются, когда та же заключенная начинает поглаживать её по голове. Сквозь зубы прорывается тихий скулёж.")

		saynn("Когда она заканчивает, заключенная уходит... но на её место приходит кто-то другой. Они вежливо просят разрешения, и ты позволяешь им тоже погладить твою зверушку.")

		saynn("[sayFemale]Кто у нас хорошая собачка?? Кто у нас умница???[/sayFemale]")

		saynn("Рахи густо краснеет от обилия поглаживаний и почесушек, её попка при этом едва заметно покачивается.")

		saynn("[say=pc]"+str(ch1("Say something, puppy.", "Voice, puppy.", "Use your voice, mut."))+"[/say]")

		saynn("[say=rahi]..р-р-р... гав...[/say]")

		saynn("[sayFemale]Да, ты! Какая красивая собачка! Прелестная маленькая питомица~.[/sayFemale]")

		saynn("Рахи изо всех сил пытается сдержаться... из неё начинает вырываться едва уловимое мурлыканье. Та же заключенная теперь гладит Рахи по спине и мягко шлепает её по заднице, прежде чем подняться и привлечь внимание целой толпы людей!")

		saynn("Группа спрашивает, можно ли им погладить Рахи по животику.")

		saynn("[say=pc]"+str(ch1("Yes, just be extremely gentle with my puppy.", "Go ahead. She'll roll over for you.", "If she resists, just hold her down."))+"[/say]")

		saynn("Заключенные хихикают и переворачивают Рахи на спину! Кошечка пискнула... но не сопротивляется. Её животик обнажен, розовые соски затвердели, а хвост прикрывает остальные её грязные местечки.")

		saynn("Чья-то грубая ладонь начинает медленно выводить круги по её мягкому коричневому меху. Дыхание Рахи сбивается. Её бедра непроизвольно дергаются.")

		saynn("Другая заключенная наклоняется и начинает чесать её под подбородком. Третья рука ласкает её ушки. Четвертая гладит её за талию. Пятая проводит по внутренней стороне бедер и хвосту.")

		saynn("Теперь Рахи окружена толпой заключенных, которые гладят её, чешут... и шепчут ей на ушко... восхваляя её... Битва на арене, кажется, больше не так интересна этим людям.")

		saynn("[say=rahi]Хх.. ахх-х.. гав.. мм.. р-ррррф..[/say]")

		saynn("Её хвост и пальцы на лапах поджимаются, лицо горит, а из милой собачки вырывается всё больше и больше мурчания.")

		saynn("[say=pc]"+str(ch1("Look at you. You love this, don't you, puppy?", "That's it, puppy. Let everyone see how much you like it.", "Such a slut. Getting off on being treated like a dog."))+"[/say]")

		saynn("Рахи скулит... её пасть издает долгие, жаждущие звуки. Её бедра начинают качаться в пустоте, а бедра трутся друг о друга. Обилие почесушек живота и поглаживаний по голове в сочетании со всеми этими сладкими словами заставляет её выглядеть глупо: язык вываливается наружу, она начинает тихо тяжело дышать и лаять, а хвост больше не прикрывает её влажную киску.")

		saynn("В конце концов, толпе надоедает развлекаться с твоей киской, и она начинает расходиться.")

		saynn("Рахи лежит на спине, всё еще тяжело дыша, ноги слегка разведены, а хвост виляет... стуча по полу.")

		saynn("[say=pc]"+str(ch1("Good puppy. Precious puppy. I hope I wasn't too hard on you.", "You don't get to ask for more. Only if you choose to obey.", "There you go. That's a bitch in heat if I ever saw one. Obey and this might happen again."))+"[/say]")

		saynn("Ты тянешь за поводок. Рахи неуклюже переворачивается... начинает идти на четвереньках, оставляя влажный след от своей сжимающейся щели на бетоне.")

		addButton("Продолжить", "Смотреть, что будет дальше", "back_to_cell")
	if(state == "back_to_cell"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={leashedBy="pc"}})
		aimCameraAndSetLocName("hideout_breakroom")
		saynn("Ты возвращаешь Рахи в камеру. Цепь снова затянута вокруг её соска. Она всё ещё тяжело дышит, а её взгляд с трудом фокусируется.")

		if (perfect):
			saynn("[say=rahi]Гав! Ох.. Д-да.. она сделает всё что угодно.. только.. пожалуйста.. ещё погладь её.. ещё..[/say]")

		elif (success):
			saynn("[say=rahi]Да.. гав..[/say]")

		else:
			saynn("[say=rahi]Э-это было.. ч-что-то с чем-то..[/say]")

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
