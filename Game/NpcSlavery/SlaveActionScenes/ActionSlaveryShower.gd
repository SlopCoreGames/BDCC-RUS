extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter
var isFastServing = false

var deservesPunishment = false

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)
	if(_args.size() > 2 && _args[2] != null):
		isFastServing = true

func _reactInit():
	if(isFastServing):
		addCharacter(npcID)
		setState("sub_shower_pc")
		GM.pc.afterTakingAShower()
		getCharacter(npcID).afterTakingAShower()
		GM.pc.addStamina(200)
		GM.pc.addPain(-200)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "ActionSlaveryShower"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		saynn("Вы стоите в раздевалке вместе с {npc.name}.")
		
		saynn("Как вы хотите, чтобы {npc.him} приняла душ?")
		
		addButton("В одиночку", "Просто наблюдать", "shower_alone")
		if(npcSlavery.getObedience() < 0.3 && npcSlavery.getLove() < 0.3):
			addDisabledButton("Вместе", "Ваша рабыня недостаточно послушна")
		else:
			addButton("Вместе", "Принять душ вместе со своей рабыней", "shower_together")
		if(npcSlavery.getSlaveSkill(SlaveType.Submissive) >= 4):
			addButton("Забота о сабке", "Позволить рабыне отмыть вас", "sub_shower_pc")
		else:
			addDisabledButton("Забота о сабке", "Требуется навык «Покорность» не ниже ранга D")

		addButton("Отмена", "Вы передумали", "endthescene")

	if(state == "sub_shower_pc"):
		if(GM.pc.getLocation() == "main_dressing2"):
			aimCameraAndSetLocName("main_shower2")
		else:
			aimCameraAndSetLocName("main_shower1")
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		playAnimation(StageScene.ShoweringDuo, "shower", {pc="pc", npc=npcID, bodyState={naked=true}, npcBodyState={naked=true}})

		var subReaction = "Okay."
		
		if(npcSlavery.isActivelyResisting()):
			subReaction = RNG.pick([
				"Неужели обязательно? Ну ладно..",
				"Давайте уже покончим с этим..",
				"..fine.",
			])
		elif(npcSlavery.getAwareness() > 0.7):
			subReaction = RNG.pick([
				"Yes, {npc.pcOwner}.",
			])
		else:
			subReaction = RNG.pick([
				"Конечно.",
				"Хорошо.",
			])

		if(isFastServing):
			saynn("Вы говорите {npc.name}, что не прочь принять душ.")
			
			saynn("[say=npc]"+subReaction+"[/say]")
			
			saynn("Ваша рабыня ведет вас в одну из раздевалок, прежде чем начать ритуал раздевания.")
		else:
			saynn("Вы говорите {npc.name}, что сегодня именно {npc.his} должна вас вымыть.")
			
			saynn("[say=npc]"+subReaction+"[/say]")
			
			saynn("После короткой паузы ваша рабыня начинает ритуал раздевания.")
		
		saynn("Когда вся одежда снята, {npc.name} ведет вас дальше, в душевую. {npc.He} берет на себя роль заботливой служанки и начинает с тщательного мытья ваших волос.")
			
		saynn("Вода, как обычно, холодная, но прикосновения {npc.his} кажутся теплыми и приятными. Когда пальцы {npc.his} перебирают пряди, вы чувствуете комфорт. Затем {npc.he} спускается к вашей шее и плечам, смывая всю грязь и засохшие выделения.")
		
		if(npcSlavery.getLove() < 0.5 && npcSlavery.getObedience() < 0.5):
			saynn("{npc.He} не смеет... или просто недостаточно осмеливается... коснуться вашей груди, поэтому {npc.he} обходит ваши {pc.breasts} и вместо этого сосредотачивается на мытье вашей {pc.masc} спины и боков. По крайней мере, {npc.he} {npc.isAre} отлично справляется, и вы чувствуете, как напряжение в мышцах уходит.")

			if(GM.pc.hasReachablePenis() || GM.pc.isWearingChastityCage()):
				saynn("Ваша рабыня тоже не решается коснуться ваших {pc.penis}, лишь быстро омывая область вокруг них и скользя {npc.his} руками по вашим {pc.thick} бедрам и ногам. Возможно, {npc.he} нужно еще немного практики. Так или иначе, к концу процедуры вы чисты, но не совсем удовлетворены.")
			elif(GM.pc.hasReachableVagina()):
				saynn("Твой суб тоже не решается трогать твою киску, лишь быстро омывая область вокруг, скользя {npc.his} руками по твоим {pc.thick} бедрам и ногам. Возможно, {npc.he} нужно еще немного тренировок. Так или иначе, к концу процедуры ты чиста, но не совсем удовлетворена.")
			else:
				saynn("Твой суб тоже не решается касаться других твоих интимных мест, лишь быстро омывая всё вокруг, скользя {npc.his} руками по твоим {pc.thick} бедрам и ногам. Возможно, {npc.he} нужно еще немного тренировок. Так или иначе, к концу процедуры ты чиста, но не совсем удовлетворена.")
		else:
			saynn("Нежным касанием {npc.he} следует контурам твоих {pc.breasts}, а ладони {npc.his} скользят по твоим"+(" lactating" if GM.pc.isLactating() else "")+"соскам. Затем {npc.he} уделяет внимание и твоей {pc.masc} спине и бокам, тщательно отмывая всё повсюду, даже подмышками. Ты чувствуешь, как напряжение в мышцах уходит.")
			
			if(GM.pc.isWearingChastityCage()):
				saynn("После мытья спины руки твоего суба скользят вниз по твоему"+(" крупная беременная" if GM.pc.isVisiblyPregnant() else "")+"животу и достигают твоих {pc.penis}. Прикосновение настолько нежное, что ты просто позволяешь {npc.him} делать свое дело; {npc.his} пальцы осторожно скользят по твоей девственной клетке, пробираясь как можно ближе к члену, стараясь вымыть каждую щелочку и каждый уголок.")
			elif(GM.pc.hasReachablePenis()):
				saynn("После мытья спины руки твоего суба скользят вниз по твоему"+(" крупная беременная" if GM.pc.isVisiblyPregnant() else "")+"животу и достигают твоих {pc.penis}. Прикосновение настолько нежное, что ты просто позволяешь {npc.him} делать свое дело; {npc.his} пальцы осторожно скользят по чувствительной коже, стараясь вымыть каждую щелочку и каждый уголок.")
			elif(GM.pc.hasReachableVagina()):
				saynn("После мытья спины руки твоего суба скользят вниз по твоему"+(" крупная беременная" if GM.pc.isVisiblyPregnant() else "")+" живота и добирается до твоей {pc.vaginaStretch} киски. Прикосновения настолько нежные, что ты просто позволяешь {npc.him} делать это, пока {npc.his} пальцы осторожно скользят по чувствительной коже, вычищая каждую щелочку и каждый уголок.")
			else:
				saynn("После мытья спины руки твоего суба скользят вниз по твоему"+(" крупная беременная" if GM.pc.isVisiblyPregnant() else "")+" живота и добирается до твоей промежности. Прикосновения настолько нежные, что ты просто позволяешь {npc.him} делать это, пока {npc.his} пальцы осторожно скользят по чувствительной коже, следя за тем, чтобы всё между твоими ногами было идеально чистым.")
		
		saynn("Теперь и ты, и твоя сучка чисты снаружи.")
		
		addButton("Хватит", "Хватит мыться", "endthescene")
		if(npcSlavery.getSlaveSkill(SlaveType.Submissive) >= 10):
			if(GM.pc.hasEffect(StatusEffect.HasCumInsideAnus) || GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
				addButton("Внутри", "Приказ помыться и внутри тоже", "sub_cleans_inside_pc")
			else:
				addDisabledButton("Внутри", "Тебе нечего предложить подчиненной для очистки")
		else:
			addDisabledButton("Внутри", "Требуется ранг навыка «Подчинение» A- или выше")
		
	if(state == "sub_cleans_inside_pc"):
		if(GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
			playAnimation(StageScene.SexOral, "lick", {pc="pc", npc=npcID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			
			saynn("Глаза твоего саба заблескивают, когда ты приказываешь {npc.him}, что тебе тоже нужно почистить киску. Вместо того чтобы делать это {npc.his} руками, твой подчиненный решает опуститься на {npc.his} колени перед тобой. {npc.His} ладони ложатся на внутреннюю сторону твоих бедер и мягко раздвигают их, позволяя {npc.him} уткнуться {npc.his} лицом в твою влажную щель.")
			
			saynn("{npc.He} скользит {npc.his} языком мимо твоих чувствительных губ и с жадностью начинает вылизывать твои внутренние стенки, стараясь собрать как можно больше {npc.he} в свой {npc.his} рот.")
			
			if(GM.pc.hasEffect(StatusEffect.HasCumInsideAnus)):
				saynn("Пока он возится с твоей киской, {npc.his} разводит твои ягодицы руками, помогая им сочиться смазкой, а {npc.his} заставляет тебя то сжиматься, то расслабляться, ускоряя процесс.")
				
			saynn("Каждое ласкающее прикосновение, каждое выверенное движение приближают тебя всё ближе и ближе... Пока внезапный, бурный оргазм не накрывает тебя с головой, и твоя киска не извергает целый фонтан смазки прямо в лицо твоему субу... пока другой душ быстро не смывает всё это во второй раз.")
			
			saynn("После всего этого твой саб выплевывает всю накопленную жижу прямо в слив. В любом случае, глотать это было бы слишком мерзко.")
			
			GM.pc.clearOrificeFluidsCheckBlocked()
		else:
			GM.pc.clearOrificeFluidsCheckBlocked()
			playAnimation(StageScene.SexRimming, "sex", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			
			saynn("Глаза твоего саба так и сверкают, когда ты приказываешь {npc.him}, что тебе нужно вычистить задницу и внутри тоже. Вместо того чтобы делать это {npc.his} руками, твой саб решает встать на {npc.his} колени позади тебя. {npc.His} ладони ложатся на твою ягодицу и мягко раздвигают её, позволяя {npc.him} уткнуться {npc.his} лицом внутрь.")
			
			saynn("{npc.He} просовывает {npc.his} язык сквозь твое чувствительное анальное кольцо и с жадностью начинает вылизывать твои внутренние стенки, стараясь собрать как можно больше {npc.he} в свой {npc.his} рот.")
		
			if(GM.pc.isWearingChastityCage()):
				saynn("Каждое ласкающее и расчетливое движение приближает тебя всё ближе и ближе... Пока внезапный короткий оргазм не накрывает тебя с головой; твой запертый член пульсирует за металлической клеткой, капая {pc.cum} на пол, пока твою простату выжимают досуха.")
			elif(GM.pc.hasReachablePenis()):
				saynn("Каждое ласкающее и расчетливое движение приближает тебя всё ближе и ближе... Пока внезапный короткий оргазм не накрывает тебя с головой; твой {pc.penis} пульсирует, извергая {pc.cum} на пол, пока твою простату выжимают досуха.")
			elif(GM.pc.hasReachableVagina()):
				saynn("Каждое ласкающее и расчетливое движение приближает тебя всё ближе и ближе... Пока внезапный короткий оргазм не накрывает тебя с головой; твоя заброшенная киска пульсирует, извергая фонтан жидкостей на пол.")
			else:
				saynn("Каждое ласкающее и расчетливое движение приближает тебя всё ближе и ближе... Пока внезапный короткий оргазм не накрывает тебя с головой; твое тело корчится и дрожит.")
				
			saynn("После всего этого твой саб выплевывает всю накопленную жижу прямо в слив. В любом случае, глотать это было бы слишком мерзко.")
			
		addButton("Продолжить", "Это было весело", "endthescene")
		
	if(state == "shower_together"):
		if(GM.pc.getLocation() == "main_dressing2"):
			aimCameraAndSetLocName("main_shower2")
		else:
			aimCameraAndSetLocName("main_shower1")
		playAnimation(StageScene.ShoweringDuo, "shower", {pc=npcID, npc="pc", bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("Вы принимаете душ вместе с {npc.name}. Поводок пристегнут к душевой лейке, чтобы твой раб не мог просто сбежать или даже повернуться к тебе.")
		
		saynn("Твои собственнические руки ложатся на тело {npc.his} и начинают его мыть, тщательно отмывая интимные места — везде, кроме самого нутра.")

		addButton("Хватит", "Это было весело", "endthescene")
		addButton("Помыться внутри", "Вымыть отверстия внутри твоего раба", "together_cleaninside")

	if(state == "together_cleaninside"):
		if(npc.hasReachableVagina()):
			saynn("Без всякого предупреждения ты хватаешь {npc.his} за задницу и раздвигаешь её так, что оба {npc.his} растягиваются настежь.")
			
			saynn("Ты приказываешь {npc.him} тужиться, и вскоре вся жидкость внутри {npc.his} начинает вытекать, быстро смываясь бегущей водой.")
		else:
			saynn("Без всякого предупреждения ты хватаешь {npc.his} за задницу и раздвигаешь её так, что хвостовое отверстие {npc.his} растягивается настежь.")
			
			saynn("Ты приказываешь {npc.him} тужиться, и вскоре вся жидкость внутри {npc.him} начинает вытекать, быстро смываясь бегущей водой.")
		
		addButton("Хватит", "Это было весело", "endthescene")

	if(state == "shower_alone"):
		if(GM.pc.getLocation() == "main_dressing2"):
			aimCameraAndSetLocName("main_shower2")
		else:
			aimCameraAndSetLocName("main_shower1")
		
		if(deservesPunishment):
			playAnimation(StageScene.Duo, "stand", {npc=npcID, flipNPC=true, npcAction="stand", npcBodyState={naked=true, leashedBy="pc"}})
		
			saynn("Твоя рука сжимает поводок рабыни, чтобы убедиться, что {npc.he} не выкинет какую-нибудь глупость.")
			
			saynn("Ты подставляешь {npc.him} под струю воды и приказываешь {npc.him} вымыть {npc.himself}")
			
			saynn("Но {npc.name} лишь дуется и стоит неподвижно, игнорируя приказ и прикрывая {npc.himself} так, как только может {npc.he}. По крайней мере, от воды {npc.he} не сбежать.")
		else:
			playAnimation(StageScene.Duo, "stand", {npc=npcID, flipNPC=true, npcAction="struggle", npcBodyState={naked=true, leashedBy="pc"}})
			#var npcSlavery:NpcSlave = npc.getNpcSlavery()
			saynn("Твоя рабыня принимает душ одна, пока ты держишь {npc.his} на поводке, чтобы {npc.he} не натворила глупостей.")
			
			saynn("Но, похоже, твоя рабыня достаточно послушна: {npc.he} моет {npc.his} тело под струями воды, позволяя тебе наблюдать за процессом.")
		
		addButton("Хватит", "Это было весело", "endthescene")
		addButton("Помыться внутри", "Прикажи им промыть и внутри тоже", "alone_cleaninside")
		
	if(state == "alone_cleaninside"):
		playAnimation(StageScene.Showering, "rub", {pc=npcID, bodyState={naked=true}})
		#playAnimation(StageScene.Duo, "stand", {npc=npcID, flipNPC=true, npcAction="struggle", npcBodyState={naked=true, leashedBy="pc"}})
		
		if(!deservesPunishment):
			if(npc.hasReachableVagina()):
				saynn("Ты приказываешь {npc.him} вымыться и внутри тоже. {npc.name} разводит обе {npc.his} дырочки {npc.his} руками, чтобы ты мог всё вычистить.")
			else:
				saynn("Ты приказываешь {npc.him} вымыться и внутри тоже. {npc.name} разводит {npc.his} задницу руками, чтобы ты мог всё вычистить.")
		else:
			saynn("Ты приказываешь {npc.him} вымыться и внутри тоже... но твоя рабыня отказывается это делать, требуя, чтобы ты сначала отвернулся. Очевидно, что делать это ты не собираешься.")
			
			saynn("Похоже, {npc.he} только что заслужил(а) для {npc.himself} наказание.")
		
		addButton("Хватит", "Это было весело", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "shower_alone"):
		processTime(10*60)
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.isResistingSuperActively() || (npcSlavery.isActivelyResisting() && RNG.chance(70))):
			deservesPunishment = true
			npcSlavery.deservesPunishment(1)
		else:
			deservesPunishment = false
		
		npc.afterTakingAShower()
		
	
	if(_action == "alone_cleaninside"):
		processTime(10*60)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.isResistingSuperActively() || (npcSlavery.isActivelyResisting() && RNG.chance(90))):
			deservesPunishment = true
			npcSlavery.deservesPunishment(1)
		else:
			deservesPunishment = false
		
			if(!npc.clearOrificeFluidsCheckBlocked()):
				addMessage("Что-то помешало вашей рабыне очистить все отверстия")
	
	if(_action == "shower_together"):
		processTime(10*60)
		npc.afterTakingAShower()
		GM.pc.afterTakingAShower()
	
	if(_action == "sub_shower_pc"):
		processTime(10*60)
		npc.afterTakingAShower()
		GM.pc.afterTakingAShower()
		GM.pc.addStamina(200)
		GM.pc.addPain(-200)
	
	if(_action == "sub_cleans_inside_pc"):
		processTime(5*60)
		GM.pc.orgasmFrom(npcID)
	
	if(_action == "together_cleaninside"):
		processTime(10*60)
		if(!npc.clearOrificeFluidsCheckBlocked()):
			addMessage("Что-то помешало тебе вымыть каждую дырочку")

		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["isFastServing"] = isFastServing
	data["deservesPunishment"] = deservesPunishment

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	isFastServing = SAVE.loadVar(data, "isFastServing", false)
	deservesPunishment = SAVE.loadVar(data, "deservesPunishment", false)
	
