extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "RahiTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["rahi"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("rahi")
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcAction="sit"})
		
	if(state == ""):
		if(!GM.main.getModuleFlag("RahiModule", "Rahi_Introduced")):
			GM.main.setModuleFlag("RahiModule", "Rahi_Introduced", true)
			
			saynn("Блуждая по тюремному блоку, вы натыкаетесь на кошку — новое лицо. Она сидит на металлической скамье, поджав ноги, а сверху лежит её пушистый хвост, который она время от времени лениво поглаживает. Оранжевая униформа и ошейник говорят о том, что она из общего блока; она не выглядит особо устрашающей.")

			saynn("Вы решаете подойти и привлечь её внимание взмахом руки; она тут же сдвигается в сторону, а её хвост выпрямляется.")

			saynn("[say=rahi]Она просто отдыхает здесь. Тебе нужно, чтобы она освободила скамью?[/say]")

			saynn("Вы вскидываете бровь, услышав её манеру речи, и секунду спустя качаете головой.")

			saynn("[say=pc]Не обязательно, я просто осматриваюсь.[/say]")

			saynn("После ваших слов она, кажется, успокаивается, и её лапки снова начинают нежно поглаживать хвост.")

			saynn("[say=rahi]Ты, должно быть, одна из новеньких, я тебя раньше не видела. Мяу...[/say]")

			saynn("Этот случайный кошачий звук вас немного забавляет. Каждый раз, когда вы пытаетесь заглянуть ей в глаза, она быстро отводит взгляд.")
		else:
			saynn("Вы подходите к дружелюбной на вид кошке, которая сидит на скамье и бездельничает, как и всегда. Она одаривает вас легкой улыбкой и освобождает место рядом, если вы захотите присесть.")

			if(getCharacter("rahi").isHeavilyPregnant()):
				saynn("[say=rahi]"+RNG.pick([
					"Her belly has become so big..",
					"Her breasts.. They keep itching..",
					"Can you.. Maybe.. no..",
					"Hi.. Does she look fat..",
					"She can’t stop making milk..",
					"She can feel it.. Not too long left..",
				])+"[/say]")
			elif(getCharacter("rahi").isVisiblyPregnant()):
				saynn("[say=rahi]"+RNG.pick([
					"Her breasts are getting bigger..",
					"Pregnant.. kitty.. Meow..",
					"Look at her belly.. It’s ours..",
					"Meow.. You want kittens?.. She does..",
					"You think she would be a good mommy?..",
				])+"[/say]")
			else:
				saynn("[say=rahi]"+RNG.pick([
					"It’s a quiet day today, isn’t it? It was for her..",
					"Hey there.. meow..",
					"Kitty is happy to see you around.",
					"Meow meow meow..",
					"Do you think they can give her some tuna?",
				])+"[/say]")

		if(getFlag("RahiModule.Rahi_ChillHappened") && !getFlag("RahiModule.rahi1ElizaSceneHappened")):
			saynn("(Чтобы продолжить историю Рахи, найдите её в душевой, а затем ложитесь спать)")

		addButton("Поговорить", "Показать список тем для разговора", "talk")
		addButton("Внешность", "Рассмотреть кошкодевочку поближе", "appearance")
		
		if(RahiModule.trustsPC()):
			addButtonWithChecks("Обнять кошечку", "Стать с кошечкой очень близким и интимным", "embrace", [], [ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		else:
			addDisabledButton("Обнять кошечку", "Она тебе еще недостаточно доверяет")
		
		if(!getModuleFlag("RahiModule", "Rahi_GaveApple")):
			if(GM.pc.getInventory().hasItemID("appleitem")):
				addButton("Предложить яблоко", "Может, ей бы понравилось", "giveapple")
			else:
				addDisabledButton("Предложить яблоко", "Для этого тебе нужно яблоко")
		addButton("Уйти", "Сделать что-то другое", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["rahi"])
		
	if(state == "appearance"):
		saynn("Перед тобой кошкодевочка ростом 1,6 м с хвостиком и парой милых кошачьих ушек на макушке. Её тело покрыто коричневым мехом, при этом живот и мордочка чуть светлее. У неё длинные белые вибриссы и голубые глаза, которыми она в основном смотрит сверху вниз. Позади неё колышется кошачий хвост, который, кажется, живет своей собственной жизнью. На её униформе видна оранжевая отделка и номер P-12406. Запястья и лодыжки отягощены массивными кандалами, а на шее — заключенный ошейник, такой же, как у тебя. Она не кажется особенно сильной; изгибы её тела женственны, а пропорции напоминают обычную домашнюю кошку — не слишком худая, но и не слишком толстая.")

		if(getCharacter("rahi").isVisiblyPregnant()):
			saynn("Единственное, что не кажется стройным — это её животик, он выглядит довольно огромным для такой скромной кошечки. Из-за лишнего веса ей приходится двигаться медленно, её кошачья ловкость уже не может проявиться в полной мере.")
			
			saynn("Её грудь выглядит заметно больше, чем обычно, как минимум уверенный размер D. Соски стали темнее. Можно догадаться, что она кормит грудью.")
		else:
			saynn("Под униформой можно разглядеть грудь примерно C-размера, с упругими розовыми сосками — ничего сверхъестественного, но всё равно очень мило.")

		saynn("Можно предположить, что под шортами скрывается милая розовая щелочка, прикрытая аккуратно подстриженным пушком.")
		
		addButton("Назад", "Назад", "")
		
	if(state == "talk"):
		saynn("Ты садишься рядом и пытаешься расслабиться, хотя металлическая скамья для этого подходит не лучшим образом. Хвост кошечки начинает нервно подергиваться, но она поглаживает его, успокаивая.")

		saynn("[say=rahi]Хочешь о чем-нибудь поболтать? Мяу...[/say]")
		
		addButton("Кто ты?", "Спросить имя кошечки", "who_are_you")
		if(!GM.main.getModuleFlag("RahiModule", "Rahi_AskedName")):
			addDisabledButton("Речь", "Она тебя еще не знает")
			addDisabledButton("Почему ты здесь?", "Она тебя еще не знает")
			addDisabledButton("Что это за место?", "Она тебя еще не знает")
		else:
			addButton("Речь", "Спросить, почему она так странно говорит", "speech")
			addButton("Почему ты здесь?", "Спросить, как она попала в тюрьму", "why_are_you_here")
			addButton("Что это за место?", "Спросить, для чего нужна эта платформа", "what_is_this_place")
		addButton("Назад", "Назад", "")


	if(state == "who_are_you"):
		saynn("[say=pc]Так.. Как тебя зовут?[/say]")

		saynn("Вопрос заставляет кошку задуматься на несколько секунд.")

		saynn("[say=rahi]Это.. заключенная номер сто двадцать четыре ноль шесть..[/say]")

		saynn("Ты одариваешь девушку слегка растерянным взглядом, и она, уклоняясь от него, пытается скрыть смущение. Неловкое молчание прерывается её голосом.")

		saynn("[say=rahi]Заключенных лишают имен... Их заменяют номерами. Она привыкла к своему номеру...[/say]")

		saynn("[say=pc]А что, если номер мне не понравится?[/say]")

		saynn("Кошка пожимает плечами и указывает на середину платформы, где стоят колодки и столбы для цепей.")

		saynn("[say=rahi]Тебя наказывают... мяу...[/say]")

		saynn("[say=pc]Но... э-э... А как насчет общения с другими заключенными? Тебе ведь не обязательно называть их по номерам.[/say]")

		saynn("[say=rahi]Ну... Обычно её зовут кити или кошечкой. Ей нравится «кити». Мяу...[/say]")

		saynn("Кити робко улыбается тебе, а затем снова переключает внимание на свой хвост. В голове у тебя остается странное чувство.")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "speech"):
		saynn("[say=pc]Почему ты так разговариваешь, кити?[/say]")

		saynn("Она смотрит на тебя, слегка наклонив голову, и из её пасти вырывается тихое «мяу».")

		saynn("[say=rahi]Типа чего?..[/say]")

		saynn("[say=pc]Ну, знаешь, в третьем лице. Не видела, чтобы другие кошачьи так делали.[/say]")

		saynn("[say=rahi]О-о-о.. Кити не знает, оно само собой.. Она к этому привыкла.[/say]")

		saynn("[say=pc]Так было всегда?[/say]")

		saynn("Кити пожимает плечами на твой вопрос и немного трет носик.")

		saynn("[say=rahi]Давно.. мяу. Еще до того, как она здесь оказалась. Кити здесь уже целую вечность.. она как-то потеряла счет времени..[/say]")

		saynn("Ты киваешь, пытаясь переварить информацию. Это что, какое-то психическое расстройство? Ты решаешь, что спрашивать об этом будет слишком грубо.")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "why_are_you_here"):
		saynn("[say=pc]Как ты здесь оказалась? Эта тюрьма кажется полной настоящих отбросов, а ты не похожа на плохую девчонку. Тебя подставили?[/say]")

		saynn("Ты замечаешь, как выражение лица Кити становится более нейтральным, и видишь легкую, едва заметную гримасу.")

		saynn("[say=rahi]Люди попадают сюда по разным причинам.. Кити.. поймали на попытке ограбить человека..[/say]")

		saynn("Кошечка уставилась в одну точку на полу, лишь прижимая лапки к хвосту.")

		saynn("[say=rahi]Этот парень выглядел богачом... Слишком богатым... Оказывается, богатеи тоже любят пушки...[/say]")

		saynn("Она тянет за ошейник и задирает подбородок, демонстрируя тебе плохо заживший ожог на шее, где шерстка совсем не растет.")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "what_is_this_place"):
		saynn("[say=pc]Для чего нужна эта платформа?[/say]")

		saynn("Кошечка поправляет выбившуюся прядь волос и трет носик. Вы оба сидите на скамье на возвышении. Посреди платформы разбросано немало БДСМ-атрибутики.")

		saynn("[say=rahi]Для наказаний. Если будешь слишком сильно баловаться, окажешься там... Это главный зал, так что на тебя будут пялиться и заключенные, и персонал... И каждый волен делать с тобой всё, что захочет, пока ты там заперта...[/say]")

		saynn("[say=pc]Тебя тоже туда запирали?[/say]")

		saynn("[say=rahi]Пару раз...[/say]")

		saynn("Ты понимающе киваешь.")

		saynn("[say=rahi]Для них не нужен доступ персонала, так что даже другие заключенные могут засунуть тебя туда... Или вытащить... Но это случается не так уж часто... Ну, ты понимаешь... Мяу...[/say]")

		addButton("Продолжить", "Продолжить разговор", "talk")

	if(state == "giveapple"):
		saynn("Вы достаете свежее яблоко и протягиваете его кошке. Рахи смотрит на вас с недоумением, положив лапки на свой спокойный хвост.")

		saynn("[say=rahi]Какое симпатичное яблоко..[/say]")

		saynn("[say=pc]Возьми, это тебе.[/say]")

		saynn("Кошечка удивленно мяукает. Она осторожно забирает у вас яблоко и начинает его обнюхивать.")

		saynn("[say=pc]Оно не отравлено, не бойся, глупышка.[/say]")

		saynn("[say=rahi]Спасибо! Кити знает.. Обычно она ест только в столовой.[/say]")

		saynn("Она откусывает кусочек, и в её глазах читается счастье.")

		saynn("[say=pc]Ну, по крайней мере, это что-то новенькое. Что-то реально съедобное.[/say]")

		saynn("[say=rahi]Да, оно очень вкусное! Еще раз спасибо![/say]")

		saynn("[say=pc]Не за что.[/say]")

		saynn("Она улыбается и придвигается ближе к вам, игриво подталкивая вашу ногу хвостом. Она продолжает оставлять следы от клыков на яблоке.")

		saynn("[say=rahi]Это напоминает ей о прошлом..[/say]")

		saynn("[say=pc]Жизнь до тюрьмы?[/say]")

		saynn("[say=rahi]Нет.. То прошлое было так давно, что кажется, будто это была другая жизнь.. Мяу..[/say]")

		saynn("[say=rahi]У неё было несколько хозяев.. здесь..[/say]")

		saynn("[say=pc]Разве так можно?[/say]")

		saynn("[say=rahi]Это не то чтобы запрещено.. Если ты сильнее кого-то, то можешь делать с ним всё, что захочешь.. Примерно так здесь всё устроено..[/say]")

		saynn("Вы кладете руку ей на дальнее плечо, и она прижимается к вам поближе. Слышно её тихое мурлыканье, пока она хрустит яблоком.")

		saynn("[say=pc]Разве персонал не должен защищать слабых?[/say]")

		saynn("[say=rahi]Персонал тоже так делает.. Но киске это нравилось.. Когда ты кому-то принадлежишь, жизнь становится проще.. Меньше проблем, мяу. Бесплатная еда и кровать.. пока делаешь то, что от тебя хотят..[/say]")

		saynn("[say=pc]Ну, теперь всё понятно.[/say]")

		saynn("[say=rahi]Да..[/say]")

		saynn("Киска устраивается у вас на груди, устремив взгляд в высокий потолок. Вы оба молчите несколько минут. Похоже, у этой кошечки за плечами долгая история владения ею.")

		saynn("[say=pc]Спасибо, что поделилась, киса.[/say]")

		saynn("Кошечка мяукает и возвращается в привычную позу, позволяя тебе встать, если захочешь.")

		saynn("[say=rahi]Без проблем... Спасибо за яблоко...[/say]")
		
		addButton("Продолжить", "Жизнь — штука суровая", "")

func _react(_action: String, _args):
	if(_action == "giveapple"):
		GM.main.setModuleFlag("RahiModule", "Rahi_GaveApple", true)
		GM.pc.getInventory().removeXOfOrDestroy("appleitem", 1)
	
	if(_action == "who_are_you"):
		GM.main.setModuleFlag("RahiModule", "Rahi_AskedName", true)
	
	if(_action == "embrace"):
		runScene("RahiEmbraceScene")
		endScene()
		return
	
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func getDevCommentary():
	return "This character's name is Rahi.. And the developer's name is Rahi.. hmmmm.. your first thought is probably.. damn self-inserts!\n\nYeah, Rahi is my fursona. Is Rahi -me- though? Not really, we share a loooot of differences. I don't talk in third person x3. Most of the time.. But that's not why people are usually upset at self-inserts.\n\nPeople usually don't like them because self-inserts tend to be the idealized copies of ourselves without any flaws or problems. Nothing ever bad happens to self-inserts, every challenge is easy for them, stuff like that.\n\nDid I deliberately tried to go against that? Nah. I just wanted to portray one of the variants of Rahi that could potentially exist.. This Rahi does have bad things happen to her but not because I wanted to prove that she isn't a self-insert. She is x3\n\nRahi does have a 'built-in' flaw that is the way she speaks. I will be honest, I made her do that because tajarans in space station 13 had to talk like that and Rahi is originally from ss13 x3. I tried to explain why she does that in her dedicated content though, hopefully its logical enough ^^\n\nI hope you get my idea. Rahi is just a shy kitty. But there are no just 'shy kitties' in one of the most secure prisons in the galaxy."

func hasDevCommentary():
	return true
