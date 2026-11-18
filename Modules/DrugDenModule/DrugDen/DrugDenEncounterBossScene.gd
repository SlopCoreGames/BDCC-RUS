extends "res://Modules/DrugDenModule/DrugDen/DrugDenEncounterTemplateScene.gd"

func _init():
	sceneID = "DrugDenEncounterBossScene"
	
	expWin = 150
	wonState = "wonFight"

func _reactInit():
	npcID = generateJunkieNPCID(true)
	addCharacter(npcID)
	#startFightWithNPC()


func _run():
	encounter_run()
	
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты пробираешься всё глубже в туннели, где воздух пропитан вонью пота, химикатов и чем-то тухлым. Похоже, ты наткнулся на одну из нарколабораторий.")
		
		saynn("И ты здесь не один...")
		
		saynn("Грязное, дергающееся месиво из торчка преграждает путь к лаборатории, {npc.his} его зрачки расширены до предела. {npc.His} всё его тело колотит, будто {npc.he} {npc.isAre} едва держится в сознании.")
		
		saynn("Вокруг {npc.him} пол усеян полубессознательными телами других торчков, которые стонут, улетев в свои кайфы.")
		
		saynn("[say=npc]"+RNG.pick([
			"You lost, dipshit? This is MY fucking lab. Crawl back to whatever pisshole you came from.",
			"Hhhhnngh.. Fresh meat. You here to trade? Maybe I let you sniff some - if you ain't a little BITCH about it!",
			"Haaaah.. You smell clean. Too clean. Either you take a hit, or I break your fuckin’ legs.",
			"Heh. HEH. Ohhh, you’re fucked, buddy. You don’t walk into my kingdom and just leave. I don’t like SHARING.",
			"Hey, guys! Look at this dumb fuck. Thinks {pc.he} can just waltz in and take my shit! HAH! Let’s see if you can still breathe after I’m done with you!",
			"Mmmnnghh. My head’s buzzing, my hands are itching, and you look like a fucking punching bag. Lucky you!",
			"YOU WANT TO STEAL MY HIT FROM ME? YOU FUCKER, NO ONE STEALS MY HIT FROM ME!",
		])+"[/say]")
		
		saynn("Похоже, придется сразиться с {npc.him}...")
		
		addButton("Драться", "Начать бой", "startFight")
	
	if(state == "wonFight"):			
		removeCharacter(npcID)
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Ты победил. Босс-торчок повержен, и теперь лаборатория в твоем распоряжении.")
		
		saynn("Ты перешагиваешь через груду битого стекла и разлитых жидкостей, разглядывая оборудование. Место — просто пиздец какой грязное: засаленные столы, ржавые горелки и колбы, наполненные зловещей бурлящей жижей. Несмотря на весь этот дерьмовый вид, здесь явно идет серьезная химическая работа.")
		
		saynn("У тебя есть несколько вариантов. Ты можешь получше изучить это место и попытаться понять, как этим торчкам удается варить дурь при таком скудном оснащении. Это может пригодиться для апгрейда твоей собственной лаборатории.")
		
		saynn("Или, может, стоит самому воспользоваться оборудованием? Тут уже что-то варится... к тому же есть записи, которыми можно воспользоваться... так почему бы не закончить начатое? Скорее всего, получится одна из тех странных таблеток...")
		
		saynn("Как вариант, можно не рисковать и просто наварить обезболивающих или анафродизиаков.")
		
		saynn("Можно просто разнести эту лабораторию в щепки и покончить с этим.")
		
		addButton("Сварить странную таблетку", "Использовать лабораторную установку, чтобы создать странную таблетку. Гарантировано получится одна из тех, что вы еще не открыли (если только вы не открыли их все).", "make_strange_pill")
		addButton("Очки науки", "Внимательно изучить лабораторную установку, чтобы понять принцип её работы. Это даст вам немного очков науки.", "do_science")
		addButton("Обезболивающее", "Использовать лабораторию, чтобы создать 1 таблетку обезболивающего", "make_painkillers")
		addButton("Анафродизиак", "Использовать лабораторию, чтобы создать 2 таблетки анафродизиака", "make_anaphrodisiac")
		addButton("Просто уничтожить", "Просто разнести лабораторию и идти дальше", "just_destroy_lab")
	
		if(getFlag("DrugDenModule.Kidlat2Hap", false) && !getFlag("DrugDenModule.Kidlat3Hap", false)):
			var drugDen:DrugDen = GM.main.DrugDenRun
			if(!drugDen.getFlag("hasKidlatUniform", false)):
				var uniformLevel = drugDen.getFlag("kidlatUniformFloor", -1)
				
				if(uniformLevel < 0):
					drugDen.setFlag("kidlatUniformFloor", drugDen.level + 3)
					
					addMessage("One of the half-conscious junkies mentions that Kidlat's uniform might somewhere on Drug Den level "+str(drugDen.getFlag("kidlatUniformFloor", 0)))
				if(uniformLevel == drugDen.level):
					saynn("[b]Вы замечаете здесь чью-то униформу.[/b]")
					
					addButton("Униформа", "Похоже, это форма Кидлата!", "take_kidlat_uniform")
	
	if(state == "make_strange_pill"):
		saynn("Ориентируясь на записи, интуицию и капельку везения, вы наспех смешиваете сомнительные жидкости. Результат — странная, причудливая таблетка. Кто знает, что она сделает, даже её цвет внушает тревогу. Вы убираете её в карман, надеясь, что она не прикончит вас позже. Пора двигаться дальше.")
		
		addButton("Продолжить", "Пора уходить", "endthescene")
	
	if(state == "do_science"):
		saynn("Вы не спеша изучаете оборудование торчков... грубое, грязное, но на удивление эффективное. В их безрассудстве есть чему поучиться. Заметив несколько интересных деталей, вы с удовлетворением отходите в сторону. Нет смысла задерживаться.")
		
		addButton("Продолжить", "Пора уходить", "endthescene")
	
	if(state == "make_painkillers"):
		saynn("Вы перебираете химикаты, осторожно отбирая нужное. Спустя несколько минут дрожащих рук вам удается синтезировать одну надежную обезболивающую таблетку. Немного, но это может спасти вашу задницу позже. Вы идете дальше, готовые ко всему, что ждет впереди.")
		
		addButton("Продолжить", "Пора уходить", "endthescene")
	
	if(state == "make_anaphrodisiac"):
		saynn("Вы наскребаете нужные соединения, дистиллируя их в две горькие на вид таблетки. Сойдет, чтобы притупить жар, если всё станет... чересчур. Вы прячете их, отпихиваете ногой пустую колбу и продолжаете исследование.")
		
		addButton("Продолжить", "Пора уходить", "endthescene")
	
	if(state == "just_destroy_lab"):
		playAnimation(StageScene.Solo, "shove")
		
		saynn("Хватит этой грязи. Вы проводите рукой по столу, разбивая стекло и разбрызгивая полусмешанную жижу по стенам. Несколько точных ударов ногами — и горелки разнесены в щепки. Довольный собой, вы отворачиваетесь, оставляя после себя лишь руины, и толкаетесь вперед.")
		
		addButton("Продолжить", "Пора уходить", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "make_strange_pill"):
		processTime(5*60)
		var newPill:ItemBase = GlobalRegistry.createItem("TFPill")
		newPill.makePillStrangeIfCan()
		GM.pc.getInventory().addItem(newPill)
		addMessage("You have created a strange pill")
		GM.main.increaseFlag("DrugDenModule.RaidedLabs")
		
	if(_action == "do_science"):
		processTime(5*60)
		GM.main.SCI.addPoints(20 + 5*int(GM.main.DrugDenRun.getLevel()/3.0) + 5*int(GM.main.DrugDenRun.getLevel()/9.0) + 5*int(GM.main.DrugDenRun.getLevel()/27.0))
		GM.main.increaseFlag("DrugDenModule.RaidedLabs")
		
	if(_action == "make_painkillers"):
		processTime(5*60)
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("painkillers"))
		addMessage("You have created some painkillers")
		GM.main.increaseFlag("DrugDenModule.RaidedLabs")
		
	if(_action == "make_anaphrodisiac"):
		processTime(5*60)
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("AnaphrodisiacPill"))
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("AnaphrodisiacPill"))
		addMessage("You have created some anaphrodisiacs")
		GM.main.increaseFlag("DrugDenModule.RaidedLabs")
		
	if(_action == "take_kidlat_uniform"):
		addMessage("You find a uniform that looks a lot like Kidlat's! Better find her now or you will lose it.")
		GM.main.DrugDenRun.setFlag("hasKidlatUniform", true)
		return
		
	if(_action == "startFight"):
		startFightWithNPC()
		return
	if(encounter_react(_action, _args)):
		return
	
	setState(_action)
