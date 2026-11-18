extends "res://Scenes/SceneBase.gd"

# Heavy work in progress, the text is just to get a feel for how the game is gonna start

func _init():
	sceneID = "IntroWakeup"

func _run():
	if(state == ""):
		addCharacter("risha")
		playAnimation(StageScene.Duo, "stand", {npc="risha"})
		
		saynn("Сегодня тебе не снилось ничего, кроме сплошной усталости, зато удалось наконец-то выспаться. Тебя пробуждает гул голосов заключенных и топот ног по бетонному полу. Ты открываешь глаза и видишь за окном охранницу — ту самую, что вчера охраняла капитана. Она стучит в стекло и включает интерком.")

		saynn("[say=risha]Подъем, зэк! Дважды повторять не стану.[/say]")

		saynn("Ты послушно встаешь с кровати — она всё равно была чертовски неудобной. Охранница открывает камеру и заходит внутрь.")

		saynn("[say=risha]Время лени прошло, зэк. Живо на уровень шахт, пора заняться настоящей работой.[/say]")

		if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)):
			saynn("Охранница также бросает взгляд на твой шлем-гарнитуру.")

			saynn("[say=risha]Ха, похоже, её никто не снимал со вчерашнего дня. Ну, тогда и я не буду — так тебе и надо, кусачая дрянь![/say]")

		addButton("Ладно", "Сказать, что сделаешь это", "fine")
		addButton("Отъебись", "Сказать, что ты недоволен", "fuck_off")

	if(state == "fine"):
		saynn("[say=pc]Как скажешь, босс.[/say]")

		saynn("Охранница ухмыляется и холодно похлопывает тебя по голове.")

		saynn("[say=risha]Будь послушным, и, возможно, тебе здесь даже понравится.[/say]")

		saynn("Она наклоняется, чтобы ваши лица оказались на одном уровне.")

		saynn("[say=risha]Как моей секс-игрушке~[/say]")

		saynn("Она внезапно отвешивает тебе звонкий шлепок по заднице, заставляя тебя ахнуть.")

		saynn("[say=risha]А пока что используй лифт, чтобы добраться до шахт.[/say]")

		saynn("Охранница выходит из камеры и идет дальше, оставляя тебя наедине со своими мыслями.")
		
		addButton("Продолжить", "Пора заняться делом", "endTheScene")

	if(state == "fuck_off"):
		saynn("[say=pc]Почему бы тебе просто не отъебаться и не достать кого-нибудь другого?[/say]")

		saynn("Охранница не особо удивлена, хотя теперь она держит руку на электрошоковой дубинке прямо у тебя перед глазами.")

		saynn("[say=risha]Ты хочешь, чтобы я нацепила на тебя поводок и лично потащила тебя в шахты? Или мне просто посадить тебя в колодки, чтобы каждый заключенный мог на тебе отыграться? Секс-игрушки здесь очень популярны, ленивая ты шлюха![/say]")

		saynn("Ты стискиваешь зубы, но хранишь молчание — связываться с охранницей сейчас кажется не лучшей идеей." + (" And besides, being muzzled doesn't help with that either." if (GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)) else "") ) # same but cleaner(?)

		saynn("[say=risha]Еще один такой косяк при мне, и я лично посажу тебя в колодки, чтобы все подряд тебя трахали — вот тогда ты поймешь, какая ты на самом деле шлюха. А теперь дуй к лифту и спускайся в шахты![/say]")

		saynn("Охранница выходит из камеры и идет дальше, оставляя тебя наедине со своими мыслями.")
		
		addButton("Продолжить", "Пора заняться делом", "endTheScene")



func _react(_action: String, _args):
	if(_action == "endTheScene"):
		GM.main.setFlag("Game_CompletedPrologue", true)
		runScene("WorldScene")
		endScene()
		
	setState(_action)

func _react_scene_end(_tag, _result):
	pass

func getDevCommentary():
	return "This small scene was added just to tell the players that skipped most of the reading: Go to the fucking mineshaft!\n\nYeah, it's written in a way that implies that Risha will come after you if you don't do that. Why doesn't she? I'm lazy x3. And also.. I dunno, she would just fuck you or something. What if you want to explore around first without being fucked by some dickgirl if you press one wrong button? Yeah, I can make it optional or something.."

func hasDevCommentary():
	return true
