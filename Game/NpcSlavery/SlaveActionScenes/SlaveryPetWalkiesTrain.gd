extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

var isSuccess = false

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

#func _reactInit():
#	processTime(10*60)
#	npc.afterTakingAShower()
#
#	var npcSlavery:NpcSlave = npc.getNpcSlavery()
#	if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
#		npcSlavery.getActivity().satisfyWant("pee")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "SlaveryPetWalkiesTrain"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcBodyState={naked=true, leashedBy="pc"}})

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		saynn("Каким командам ты хочешь обучить своего питомца?")
		
		addButton("Простым", "Попробовать одну из простых команд", "try_simple")
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
			addButton("Продвинутым", "По-настоящему испытать своего питомца", "try_advanced")
		else:
			addDisabledButton("Продвинутым", "Требуется навык «Ласка» уровня B- или выше")
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 11):
			addButton("Пошлым", "Посмотреть, насколько извращенным может быть твой питомец", "try_lewd")
		else:
			addDisabledButton("Пошлым", "Требуется навык питомца A или выше")
		
		
	if(state == "s_sit"):
		saynn("Твой голос звучит твердо, когда ты мягко направляешь скованного щенка в положение сидя.")
		
		saynn("[say=pc]Сидеть![/say]")
		
		saynn("Ты повторяешь команду несколько раз, стараясь приучить своего щеночка связывать это слово с нужным действием.")
		
		if(isSuccess):
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sit", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("{npc.name} реагирует хорошо, поджимая задние лапы {npc.his} и садясь на них. {npc.He} смотрит на тебя сияющими глазами.")
			
			saynn("[say=pc]Умница.[/say]")
		else:
			saynn("Твой питомец изо всех сил пытается и понять, и выполнить команду; {npc.his} пытается сесть, но это оборачивается неуклюжими движениями и замешательством.")
			
			saynn("[say=pc]Поработаем над этим еще немного.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "s_lay"):
		saynn("Ты демонстрируешь действие «лечь» своему щенку, опуская голову и вытягивая руки вперед; твой тон тверд.")
		
		saynn("[say=pc]Лежать![/say]")
		
		saynn("Ты повторяешь команду несколько раз, стараясь приучить своего щеночка связывать это слово с нужным действием.")
		
		if(isSuccess):
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("{npc.name} с энтузиазмом подчиняется твоей команде, грациозно опускаясь {npc.himself} на землю и растягиваясь в удобной позе. {npc.He} смотрит на тебя, ожидая похвалы.")
			
			saynn("[say=pc]Молодец.[/say]")
		else:
			saynn("Несмотря на все твои старания, твой щенок с трудом понимает команду, постоянно наклоняя {npc.his} голову и тихонько поскуливая.")
			
			saynn("[say=pc]Похоже, тебе нужно еще немного потренироваться.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "s_voice"):
		saynn("Ты подбадриваешь щенка, сам издавая звуки, похожие на лай. Затем ты указываешь на питомца и твердо произносишь команду.")
		
		saynn("[say=pc]Голос![/say]")
		
		if(isSuccess):
			saynn("{npc.name} с энтузиазмом подчиняется, отвечая на команду серией звонкого лая и тявканья.")
			
			saynn("[say=npc]"+RNG.pick([
				"Гав! Тяф!",
				"Гав.. гав.",
				"Woof? Wruff..",
				"Тяв, тяв-тяв!",
				])+"[/say]")
			
			saynn("[say=pc]Вот так, хороший песик.[/say]")
		else:
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("Несмотря на все старания {npc.his}, щенок с трудом понимает команду, и {npc.his} пытается гавкнуть, но это звучит жалко.")
			
			saynn("[say=npc]"+RNG.pick([
				"Мм.. афф?",
				"Ar..f?",
				"Bar..-f?",
				"Это так унизительно..",
				"Неужели мне правда нужно..",
				])+"[/say]")
			
			saynn("[say=pc]Ну и глупыш. Мы быстро научим тебя лаять как следует.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "a_givepaw"):
		saynn("Ты мягко берешь лапку своего щенка, слегка встряхивая её, пока отдаешь команду.")
		
		saynn("[say=pc]Дай лапу.[/say]")
		
		saynn("Вы повторяете тренировку несколько раз, а затем произносите команду, не показывая само действие.")
		
		if(isSuccess):
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="paw", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("{npc.name} с энтузиазмом откликается на вашу команду, выпрямляясь и высоко поднимая {npc.his} лапу, предлагая вам ее пожать. Вы делаете это и ласково хлопаете {npc.him}.")
			
			saynn("[say=pc]Очень хорошо.[/say]")
		else:
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("Несмотря на все старания {npc.his}, ваш щенок с трудом понимает, что именно нужно делать с {npc.he}; {npc.he} смотрит на свои {npc.his} тугие путы и издает растерянный скулеж.")
			
			saynn("[say=pc]Лапы у тебя всё еще на месте, глупый щенок.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "a_presentbelly"):
		saynn("Вы гладите питомца по спине и тянетесь к животику {npc.his}, пытаясь заставить {npc.him} показать его вам.")
		
		saynn("[say=pc]Почесать животик? Кто хочет, чтобы почесали животик?[/say]")
		
		if(isSuccess):
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="back", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("{npc.name} слышит ваши слова и тут же переворачивается на {npc.his} спину, подставляя вам свой {npc.his} голый живот. Очевидно, вы начинаете вовсю чесать {npc.him}, отчего {npc.him} начинает извиваться.")
			
			saynn("[say=pc]Вот так, тебе ведь нравится, когда чешут животик, правда?[/say]")
		else:
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("Несмотря на все {npc.his} старания, твой щенок никак не может перевернуться на {npc.his} спину — из-за пут любое движение дается с огромным трудом.")
			
			saynn("[say=pc]Ничего, у тебя обязательно получится. Но пока что никакого почесывания животика![/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "a_heel"):
		saynn("Ты задаешься вопросом, сможет ли твой питомец выполнить команду без лишних объяснений. Ты указываешь пальцем на пол прямо рядом с собой.")
		
		saynn("[say=pc]Рядом![/say]")
		
		if(isSuccess):
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="walk", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("{npc.name} слышит команду и тут же принимает предложенную позу, готовый следовать за тобой.")
			
			saynn("[say=pc]А ты сообразительный, молодец![/say]")
		else:
			playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
			
			saynn("Твой щенок наклоняет {npc.his} голову, пытаясь понять, что же {npc.he} делать с твоими пятками... и почему ты на них указываешь. Слышится растерянное поскуливание.")
			
			saynn("[say=pc]«Рядом» значит стой возле меня и иди следом, глупыш![/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "l_lick"):
		playAnimation(StageScene.PuppySexOral, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		if(GM.pc.isWearingChastityCage()):
			saynn("Решив немного пошалить, ты выставляешь напоказ свою девственность, после чего приседаешь рядом с щенком и указываешь на неё.")
		
			saynn("[say=pc]Лизать.[/say]")
			
			saynn("Эта команда довольно необычна для питомцев... но {npc.name} всё равно подчиняется и начинает водить {npc.his} языком по клетке, время от времени слегка облизывая твои яйца.")
		
			saynn("[say=pc]Умница, {npc.boy}.[/say]")
		elif(GM.pc.hasReachablePenis()):
			saynn("Решив немного пошалить, ты выставляешь свою {pc.penis} напоказ, а затем приседаешь рядом со своим щеночком и указываешь на неё.")
		
			saynn("[say=pc]Лизать.[/say]")
			
			saynn("Эта команда довольно необычна для питомцев... но {npc.name} всё равно подчиняется и начинает водить {npc.his} языком по твоему члену, время от времени слегка облизывая твои яички.")
		
			saynn("[say=pc]Умница, {npc.boy}.[/say]")
		elif(GM.pc.hasReachableVagina()):
			saynn("Решив немного пошалить, ты выставляешь свою киску напоказ, а затем приседаешь рядом со своим щеночком и указываешь на неё.")
		
			saynn("[say=pc]Лизать.[/say]")
			
			saynn("Эта команда довольно необычна для питомцев... но {npc.name} всё равно подчиняется и начинает водить {npc.his} языком по твоим чувствительным складкам, время от времени лаская и облизывая твой клитор.")
		
			saynn("[say=pc]Умница, {npc.boy}.[/say]")
		else:
			saynn("Решив немного пошалить, ты выставляешь свою голую промежность напоказ, а затем приседаешь рядом со своим щеночком и указываешь на неё.")
		
			saynn("[say=pc]Лизать.[/say]")
			
			saynn("Эта команда довольно необычна для питомцев... но {npc.name} всё равно подчиняется и начинает водить {npc.his} языком по твоей промежности, время от времени нежно посасывая её.")
		
			saynn("[say=pc]Умница, {npc.boy}.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "l_presentbutt"):
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Ты покручиваешь пальцем и говоришь строгим голосом.")
		
		saynn("[say=pc]Представься, щенок![/say]")
		
		if(npc.isWearingChastityCage()):
			saynn("Не совсем та команда, которую обычно дают питомцу... Но {npc.name} повинуется, разворачиваясь и низко опуская {npc.his} голову, при этом задирая {npc.his} {npc.masc} задницу высоко вверх, открывая тебе идеальный вид на {npc.his} запертый член"+(", мокрая киска" if npc.hasReachableVagina() else "")+" и {npc.analStretch} анальное отверстие. Твой питомец, кажется, готов к спариванию в любой момент.")
		elif(npc.hasReachablePenis()):
			saynn("Не совсем та команда, которую обычно дают питомцу... Но {npc.name} повинуется, разворачиваясь и низко опуская {npc.his} голову, при этом задирая {npc.his} {npc.masc} задницу высоко вверх, открывая тебе идеальный вид на {npc.his} {npc.penis}"+(", мокрая киска" if npc.hasReachableVagina() else "")+" и {npc.analStretch} анальное отверстие. Твой питомец, кажется, готов к спариванию в любой момент.")
		elif(npc.hasReachableVagina()):
			saynn("Не совсем та команда, которую обычно дают питомцу... Но {npc.name} повинуется, разворачиваясь и низко опуская {npc.his} голову, при этом задирая {npc.his} {npc.masc} задницу высоко вверх, открывая тебе идеальный вид на {npc.his} влажную киску и {npc.analStretch} анальное отверстие. Твой питомец, кажется, готов к спариванию в любой момент.")
		else:
			saynn("Не совсем та команда, которую обычно дают питомцу... Но {npc.name} повинуется, разворачиваясь и низко опуская {npc.his} голову, при этом задирая {npc.his} {npc.masc} задницу высоко вверх, открывая тебе идеальный вид на {npc.his} {npc.analStretch} анальное отверстие. Твой питомец, кажется, готов к спариванию в любой момент.")
		
		saynn("[say=pc]Отличная задница, щенок.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "l_kissfeet"):
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sad", npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Ты слегка приподнимаешь одну ногу, подставляя ступню своему щенку. С твоих губ срывается строгая команда.")
		
		saynn("[say=pc]Поцелуй.[/say]")
		
		saynn("{npc.name} отвечает тем, что подползает чуть ближе и осыпает твои пальцы ног мелкими поцелуями.")
		
		saynn("[say=pc]Еще.[/say]")
		
		saynn("{npc.He} тихонько лает и начинает покрывать твою стопу всё большим количеством нежных поцелуев, а губы {npc.his} буквально боготворят твою кожу при каждом прикосновении.")
		
		saynn("[say=pc]Хорошая собачка, какая послушная зверушка.[/say]")
		
		saynn("Ты замечаешь, как виляет хвост {npc.his}.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "try_simple"):
		processTime(10*60)
		var succChance = 60
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
			succChance = 100
		
		if(RNG.chance(succChance)):
			isSuccess = true
		else:
			isSuccess = false
		npcSlavery.getActivity().satisfyWant("train")
		setState(RNG.pick(["s_sit", "s_lay", "s_voice"]))
		return

	if(_action == "try_advanced"):
		processTime(10*60)
		var succChance = 50
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 11):
			succChance = 75
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 13):
			succChance = 90
		
		if(RNG.chance(succChance)):
			isSuccess = true
		else:
			isSuccess = false
		npcSlavery.getActivity().satisfyWant("train")
		setState(RNG.pick(["a_givepaw", "a_presentbelly", "a_heel"]))
		return

	if(_action == "try_lewd"):
		processTime(10*60)
		var succChance = 60
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 13):
			succChance = 80
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 15):
			succChance = 100
		
		if(RNG.chance(succChance)):
			isSuccess = true
		else:
			isSuccess = false
		npcSlavery.getActivity().satisfyWant("train")
		setState(RNG.pick(["l_lick", "l_presentbutt", "l_kissfeet"]))
		return

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["isSuccess"] = isSuccess

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	isSuccess = SAVE.loadVar(data, "isSuccess", false)
