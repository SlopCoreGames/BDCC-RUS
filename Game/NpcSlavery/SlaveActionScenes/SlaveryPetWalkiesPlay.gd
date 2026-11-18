extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter


func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func _reactInit():
	pass
	#processTime(10*60)
	#npc.afterTakingAShower()
	
	#var npcSlavery:NpcSlave = npc.getNpcSlavery()
	#if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
	#	npcSlavery.getActivity().satisfyWant("shower")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "SlaveryPetWalkiesPlay"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()

		saynn("Как хочешь поиграть со своим питомцем?")
		
		addButton("Апорт", "Заставить их принести тебе палку", "play_fetch")
		if(npc.isWearingChastityCage() || npc.hasReachablePenis() || npc.hasReachableVagina()):
			if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
				addButton("Футплей", "Это тоже своего рода игра...", "play_feet")
			else:
				addDisabledButton("Футплей", "Требуется навык «Ласка» уровня B- или выше")
		else:
			addDisabledButton("Футплей", "Тут особо нечего теребить...")
		
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 11):
			addButtonWithChecks("Блядь", "Утолить жажду питомца своим членом", "petplay_fuck", [], [[ButtonChecks.HasReachablePenis]])
			addButtonWithChecks("Страпон", "Утолить жажду питомца своими игрушками", "petplay_strapon_choose", [], [[ButtonChecks.HasStraponAndCanWear]])
		else:
			addDisabledButton("Блядь", "Требуется навык питомца A или выше")
	
	if(state == "petplay_strapon_choose"):
		saynn("Выбери, какой страпон хочешь использовать.")
		
		var strapons = GM.pc.getStrapons()
		for strapon in strapons:
			addButton(strapon.getVisibleName(), strapon.getVisibleDescription(), "petplay_strapon", [strapon])

	
	if(state == "play_fetch"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		playAnimation(StageScene.PuppyDuo, "throw", {npc=npcID, npcAction="walk", flipNPC=true, npcBodyState={naked=true}})
		
		saynn("Ты находишь на полу деревянную палку и поднимаешь её.")
		
		saynn("[say=pc]Посмотри на это, щеночек.[/say]")
		
		saynn("Ты следишь за тем, чтобы твой питомец не сводил глаз с палки... а затем швыряешь её в случайном направлении.")
		
		saynn("[say=pc]"+RNG.pick([
			"Got get it!",
			"Fetch!",
			"Bring it back, {npc.boy}!",
		])+"[/say]")
		
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 15):
			saynn("С приливом энергии твой питомец срывается с места вслед за палкой, {npc.his} движения грациозные и ловкие... даже если оковы всё ещё прилично его сковывают.")
			
			saynn("{npc.He} хватает палку {npc.his} ртом и приносит её тебе, {npc.his} хвост неистово виляет, когда ты берешь палку и награждаешь {npc.him} поглаживаниями по голове.")
		elif(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 11):
			saynn("Твой питомец бросается за палкой, {npc.his} движения плавные и уверенные. {npc.He} немного спотыкается из-за пут... но {npc.he} всё же удается принести палку обратно.")
			
			saynn("Твой питомец тяжело дышит, пока ты вынимаешь палку из {npc.his} рта и награждаешь {npc.him} лаской.")
		elif(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 7):
			saynn("Твой питомец с энтузиазмом гонится за палкой, {npc.his} движения полны рвения и решимости. Несмотря на то, что оковы слегка мешают {npc.him}, {npc.he} удается подцепить палку и принести её тебе.")
			
			saynn("Виляя хвостом, твой питомец с нетерпением ждет, пока ты забираешь палку из {npc.his} рта и награждаешь {npc.him} парой поглаживаний по голове.")
		else:
			if(RNG.chance(33)):
				saynn("Ваш питомец с азартом несется за палкой, но {npc.he}, кажется, никак не может совладать с путами, спотыкаясь о {npc.his} собственные лапы и упуская палку из виду.")
				
				saynn("Несмотря на все старания {npc.his}, твой питомец никак не может найти палку: он в замешательстве обнюхивает землю, а в конце концов просто сдается. Оу. Похоже, твоему любимцу не помешало бы еще немного тренировок. Ты похлопываешь {npc.him} по голове за старание.")
			else:
				saynn("Ваш питомец с азартом несется за палкой, {npc.his} движения полны энтузиазма, но лишены необходимой мышечной памяти. {npc.He} поначалу с трудом пытается ее отыскать, но после недолгих поисков {npc.he} удается найти ее, радостно лая.")
				
				saynn("Пусть это и заняло несколько минут, но твой питомец в конце концов приносит палку, тяжело дыша, когда {npc.he} роняет её к твоим ногам. В награду ты даёшь {npc.him} несколько ободряющих похлопываний.")
			
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "play_feet"):
		playAnimation(StageScene.PuppyFeetCrotch, "crotch", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true}}) 
		
		saynn("Щеночек хочет поиграть? Ты как раз знаешь, чем его занять.")

		saynn("[say=pc]Вперед, щеночек, перевернись на спинку![/say]")

		saynn("{npc.name} наклоняет {npc.his} голову. Но когда ты повторяешь команду, {npc.he} плюхается и пытается перевернуться на другой бок. Ты ловишь {npc.him} в этот момент, наступая ногой на {npc.his} пах.")

		if (npc.isWearingChastityCage()):
			saynn("{npc.His} запертый член мгновенно реагирует, дергаясь внутри, когда ты проводишь ступней по {npc.his} яичкам, нежно разминая их.")

			saynn("[say=pc]Начало[/say]")

			saynn("Твой питомец совершенно беспомощен: оковы плотно стягивают {npc.him}, твоя нога крепко прижата к девственной клетке {npc.his}, а пальцы ног так и норовят поиграть с ней.")

			saynn("[say=pc]Я сказала: «Проси!»[/say]")

			saynn("{npc.name} скулит и мило дрыгает {npc.his} связанными лапками, {npc.his} широко раскрыв глаза"+str(" under the blindfold" if npc.isBlindfolded() else "")+".")

			saynn("Ты сильнее разминаешь ногой {npc.his} клетку... пока твой щенок не начинает ерзать под твоей ногой."+str(" {npc.His} {npc.pussyStretch} pussy is dripping juices just like {npc.his} cock is dripping pre." if npc.hasReachableVagina() else "")+"")

			saynn("[say=pc]Вот так лучше. Что, сейчас кончишь, щеночек?[/say]")

			saynn("[say=npc]..гав-в!..[/say]")

		elif (npc.hasReachablePenis()):
			saynn("{npc.His} {npc.penis} мгновенно реагирует: он твердеет, и капля предэякулята выступает на {npc.his} яичках, когда ты нежно разминаешь их ступней.")

			saynn("[say=pc]Начало[/say]")

			saynn("Твой питомец совершенно беспомощен: путы крепко держат {npc.him}, твоя нога плотно прижата к {npc.his} мошонке, а пальцы ног забавляются с ней.")

			saynn("[say=pc]Я сказала: «Проси!»[/say]")

			saynn("{npc.name} скулит и мило дрыгает {npc.his} связанными лапками, {npc.his} широко раскрыв глаза"+str(" under the blindfold" if npc.isBlindfolded() else "")+".")

			saynn("Ты чуть выше поднимаешь ногу и начинаешь ласкать {npc.his} {penis}... пока твой щенок не начинает ерзать под твоей ногой."+str(" {npc.His} {npc.pussyStretch} pussy is dripping too, even though you are focussed on {npc.his} member." if npc.hasReachableVagina() else "")+"")

			saynn("[say=pc]Вот так лучше. Что, сейчас кончишь, щеночек?[/say]")

			saynn("[say=npc]..гав-в!..[/say]")

		elif (npc.hasReachableVagina()):
			saynn("{npc.His} {npc.pussyStretch} мгновенно реагирует, становясь влажной и жаждущей, когда ты проводишь ступней по {npc.his} чувствительным лепесткам, нежно лаская их.")

			saynn("[say=pc]Начало[/say]")

			saynn("Твой питомец совершенно беспомощен: оковы крепко держат {npc.him}, твоя нога плотно прижата к {npc.his} щели, а пальцы ног вовсю с ней играют.")

			saynn("[say=pc]Я сказала: «Проси!»[/say]")

			saynn("{npc.name} скулит и мило дрыгает {npc.his} связанными лапками, {npc.his} широко раскрыв глаза"+str(" under the blindfold" if npc.isBlindfolded() else "")+".")

			saynn("Твои пальцы находят {npc.his} клитор и начинают теребить его... пока твой щенок не начинает извиваться под твоей ногой.")

			saynn("[say=pc]Вот так лучше. Что, сейчас кончишь, щеночек?[/say]")

			saynn("[say=npc]..гав-в!..[/say]")
		
		addButton("Заставить их кончить", "Позволить им достичь оргазма", "feetplay_allowcum")
		addButton("Отказать", "Украсть у них оргазм", "feetplay_deny")
		
	if(state == "feetplay_deny"):
		if (npc.isWearingChastityCage()):
			saynn("На этот раз ты решаешь лишить своего щенка разрядки, доводя {npc.him} до {npc.his} пика своей ступней... только чтобы остановиться именно в тот момент, когда {npc.his} запертый член начал дергаться в своей маленькой клетке.")

		elif (npc.hasReachablePenis()):
			saynn("На этот раз ты решаешь лишить своего щенка разрядки, доводя {npc.him} до {npc.his} пика своей ступней... только чтобы остановиться именно в тот момент, когда {npc.his} {npc.penis} начал дергаться и пульсировать.")

		elif (npc.hasReachableVagina()):
			saynn("На этот раз ты решаешь лишить своего щенка разрядки, доводя {npc.him} до {npc.his} пика своей ступней... только чтобы остановиться именно в тот момент, когда {npc.his} {npc.pussyStretch} киска начала едва заметно подергиваться.")

		saynn("Твой питомец скулит и извивается, отчаянно жаждая разрядки... которая всё не наступает... Ты прижимаешь {npc.him} ногой к полу, ожидая, пока {npc.him} утихнет.")

		saynn("[say=pc]Такой милашка.[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "feetplay_allowcum"):
		playAnimation(StageScene.PuppyFeetCrotch, "crotch", {pc="pc", npc=npcID, npcCum=true, npcBodyState={naked=true, hard=true}}) 
		if (npc.isWearingChastityCage()):
			saynn("Ты продолжаешь теребить и ласкать девайс целомудрия и {npc.his} яички своего питомца... пока член внутри внезапно не начинает пульсировать, выстреливая {npc.cum} сквозь маленькое отверстие в клетке, и всё это попадает на {npc.his} живот.")

		elif (npc.hasReachablePenis()):
			saynn("Ты продолжаешь теребить и ласкать член и {npc.his} яички своего питомца... пока ствол внезапно не начинает пульсировать, выбрасывая струйки густой {npc.cum}, которые попадают прямо на {npc.his} живот.")

		elif (npc.hasReachableVagina()):
			saynn("Ты продолжаешь теребить и ласкать влажную, жаждущую киску своего питомца... пока тот не издает страстный милый звук, а {npc.his} лепестки пульсируют, пока струя прозрачной {npc.girlcum} бьет по {npc.his} собственным бедрам, делая их совсем мокрыми.")

		saynn("После всего этого твой щенок остается тяжело дышащим и извивающимся, а от принудительного оргазма {npc.his} щечки кажутся красными.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
		
		
	if(state == "petplay_fuck"):
		playAnimation(StageScene.PuppySexOral, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты знаешь способ куда-куда лучше, чтобы удовлетворить жажду своего питомца.")

		saynn("Ты выставляешь напоказ свои {pc.penis}, давая питомцу рассмотреть их получше.")

		saynn("[say=pc]Давай повеселимся.[/say]")

		saynn("[say=npc]Гав..[/say]")

		saynn("В какую дырку хочешь трахнуться?")

		addButton("В задницу", "Трахнуть их в зад", "petplay_fuck_ass")
		if (npc.hasReachableVagina()):
			addButton("В киску", "Трахнуть их в киску", "petplay_fuck_pussy")
		else:
			addDisabledButton("В киску", "До их киски не добраться")
	if(state == "petplay_fuck_pussy"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		saynn("Ты устраиваешься позади {npc.him}, твой член уже касается складок {npc.his}, и от этих ласк она становится влажной.")

		addButton("Трахаться медленно", "Нежно обращайся со своим питомцем", "fuck_vag_slow")
		addButton("Трахаться быстро", "Вжарить своему питомцу", "fuck_vag_fast")
	if(state == "fuck_vag_fast"):
		playAnimation(StageScene.PuppySexAllFours, "fast", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Твои ладони ложатся на задницу питомца, когда ты втискиваешь туда свой член, силой раздвигая ждущие тебя лепестки. Твой питомец дергается вперед... но ты лишь оттягиваешь {npc.him} назад, снова всаживаясь внутрь и трахая {npc.his} жаждущую щель.")

		saynn("Несмотря на твою грубость, из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} совершенно беспомощной, пока твой член на бешеной скорости долбит {npc.his} мокрую киску, а смазка покрывает твой ствол, делая трение терпимым.")

		saynn("То, как киска {npc.his} обхватывает твой член при каждом толчке, ощущается невероятно — ты уже чувствуешь приближение оргазма.")

		addButton("Кончить внутрь", "Оплодотворить щенка", "fuck_vag_cuminside")
		addButton("Вытащить", "Вместо этого кончить прямо на задницу", "fuck_vag_pullout")
	if(state == "fuck_vag_slow"):
		playAnimation(StageScene.PuppySexAllFours, "sex", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не слишком грубить и действуешь с питомцем медленно. Твоя рука чуть лучше направляет член, когда ты проникаешь в {npc.him}, и головка широко раздвигает лепестки. После этого ты просто кладешь руки на {npc.thick} задницу питомца и начинаешь трахать {npc.his} жаждущую щель.")

		saynn("Вскоре из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} совершенно беспомощной, пока твой член мерно входит и выходит, а смазка делает трение безболезненным.")

		saynn("То, как киска {npc.his} обхватывает твой член, ощущается невероятно — ты уже чувствуешь приближение оргазма.")

		addButton("Кончить внутрь", "Оплодотворить щенка", "fuck_vag_cuminside")
		addButton("Вытащить", "Вместо этого кончить прямо на задницу", "fuck_vag_pullout")
	if(state == "fuck_vag_cuminside"):
		playAnimation(StageScene.PuppySexAllFours, "inside", {pc="pc", npc=npcID, pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты позволяешь оргазму захлестнуть тебя, заталкивая член глубоко в эту сучку, пока головка не касается {npc.his} шейки матки. Из твоего рта вырываются стоны, когда ты заливаешь {npc.his} нутро и наполняешь {npc.his} матку своей густой {pc.cum}, вкачивая всё больше и больше с каждым пульсом.")

		saynn("При этом твой питомец дрожит так сильно, насколько позволяют путы, а {npc.his} киска доя твой член досуха во время {npc.his} собственного оргазма.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твой питомец тяжело дышит, а {npc.his} киска уже течет от твоего семени.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "fuck_vag_pullout"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не осеменять своего питомца и останавливаешься, как только чувствуешь точку невозврата. Из твоего рта вырываются стоны, когда ты забрызгиваешь спину своего питомца своей густой {pc.cum}, оставляя всё более и более похотливую лужу с каждым толчком.")

		saynn("При этом твой питомец дрожит так сильно, насколько позволяют путы, а {npc.his} сочащаяся киска заметно пульсирует и подергивается во время {npc.his} собственного оргазма.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твой питомец тяжело дышит, выглядя теперь немного более... использованной.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "petplay_fuck_ass"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		saynn("Ты занимаешь место позади {npc.him}; твой член уже трется о {npc.his} {npc.analStretch} задницу, и от этих легких ласк она начинает подергиваться.")

		addButton("Трахаться медленно", "Нежно обращайся со своим питомцем", "fuck_ass_slow")
		addButton("Трахаться быстро", "Вжарить своему питомцу", "fuck_ass_fast")
	if(state == "fuck_ass_fast"):
		playAnimation(StageScene.PuppySexAllFours, "fast", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Твои ладони ложатся на задницу питомца, когда ты втискиваешь свой член внутрь, силой раздвигая ожидающее отверстие. Твой питомец дергается вперед... но ты просто оттягиваешь {npc.him} назад, снова всаживаясь внутрь и трахая {npc.his} жадное отверстие.")

		saynn("Несмотря на твою грубость, из уст {npc.name} начинают вырываться стоны; путы делают {npc.him} совершенно беспомощной, пока твой член на бешеной скорости долбит в {npc.his} анус. Ты время от времени плюешь на свой ствол, чтобы обеспечить смазку, что помогает сделать трение более терпимым.")

		saynn("То, как задница {npc.his} обхватывает твой член при каждом толчке, ощущается невероятно; ты уже чувствуешь приближение оргазма.")

		addButton("Кончить внутрь", "Оплодотворить щенка", "fuck_ass_cuminside")
		addButton("Вытащить", "Вместо этого кончить прямо на задницу", "fuck_ass_pullout")
	if(state == "fuck_ass_slow"):
		playAnimation(StageScene.PuppySexAllFours, "sex", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не слишком грубить и действуешь с питомцем медленно. Твоя рука чуть лучше направляет член, когда ты проникаешь в {npc.him}, и головка широко раздвигает {npc.analStretch} анус. После этого ты просто кладешь руки на {npc.thick} ягодицы питомца и начинаешь трахать {npc.his} жадное отверстие.")

		saynn("Вскоре из уст {npc.name} начинают вырываться стоны; путы делают {npc.him} совершенно беспомощной, пока твой член мерно входит и выходит. Ты время от времени плюешь на свой ствол, благодаря чему трение почти не причиняет боли.")

		saynn("То, как задница {npc.his} обхватывает твой член, ощущается невероятно; ты уже чувствуешь приближение оргазма.")

		addButton("Кончить внутрь", "Оплодотворить щенка", "fuck_ass_cuminside")
		addButton("Вытащить", "Вместо этого кончить прямо на задницу", "fuck_ass_pullout")
	if(state == "fuck_ass_cuminside"):
		playAnimation(StageScene.PuppySexAllFours, "inside", {pc="pc", npc=npcID, pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты отдаешься оргазму, заталкивая свой член глубоко в эту сучку, пока самый кончик не достигает {npc.his} кишок. Из твоего рта вырываются стоны, когда ты заливаешь {npc.his} нутро и набиваешь {npc.him} до отказа своей густой {pc.cum}, вкачивая всё больше и больше с каждым пульсирующим толчком.")

		saynn("Всё это время твоя питомица дрожит так сильно, насколько позволяют путы, а {npc.his} хвостное отверстие выжимает из твоего члена всё до последней капли во время {npc.his} собственного оргазма.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твоя питомица тяжело дышит, её {npc.his} задница уже течет от твоего семени.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "fuck_ass_pullout"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не осеменять своего питомца и останавливаешься, как только чувствуешь точку невозврата. Из твоего рта вырываются стоны, когда ты забрызгиваешь спину своего питомца своей густой {pc.cum}, оставляя всё более и более похотливую лужу с каждым толчком.")

		saynn("Всё это время твоя питомица дрожит так сильно, насколько позволяют путы, а её {npc.his} жаждущее хвостное отверстие заметно пульсирует и дергается во время {npc.his} собственного оргазма.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твой питомец тяжело дышит, выглядя теперь немного более... использованной.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "petplay_strapon"):
		playAnimation(StageScene.PuppySexOral, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты знаешь способ куда-куда лучше, чтобы удовлетворить жажду своего питомца.")

		saynn("Ты закрепляешь страпон на талии и даешь своей питомице хорошенько на него полюбоваться.")

		saynn("[say=pc]Давай повеселимся.[/say]")

		saynn("[say=npc]Гав..[/say]")

		saynn("В какую дырку хочешь трахнуться?")

		addButton("В задницу", "Трахнуть их в зад", "petplay_strapon_ass")
		if (npc.hasReachableVagina()):
			addButton("В киску", "Трахнуть их в киску", "petplay_strapon_pussy")
		else:
			addDisabledButton("В киску", "До их киски не добраться")
	if(state == "petplay_strapon_pussy"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		saynn("Ты устраиваешься позади {npc.him}, твой резиновый член уже ласкает складки {npc.his} киски, и от этих легких касаний она становится совсем влажной.")

		addButton("Трахаться медленно", "Нежно обращайся со своим питомцем", "fuck_strapon_slow")
		addButton("Трахаться быстро", "Вжарить своему питомцу", "fuck_strapon_fast")
	if(state == "fuck_strapon_fast"):
		playAnimation(StageScene.PuppySexAllFours, "fast", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Твои руки ложатся на задницу питомицы, когда ты вталкиваешь внутрь резиновую игрушку, силой раздвигая ожидающие лепестки. Твоя питомица дергается вперед... но ты просто притягиваешь {npc.him} назад, снова всаживаясь внутрь и трахая {npc.his} её жаждущую щель.")

		saynn("Несмотря на твою грубость, из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} совершенно беспомощной, пока твой страпон на бешеной скорости долбит её {npc.his} мокрую киску, а смазка покрывает ствол, делая трение хоть сколько-нибудь терпимым.")

		saynn("То, как {npc.his} киска обхватывает твою игрушку при каждом толчке, чертовски приятно; ты уже чувствуешь приближение {npc.his} оргазма.")

		addButton("Заставить их кончить", "Довести свою сучку до оргазма", "fuck_strapon_cuminside")
		addButton("Вытащить", "Откажи своему щеночку", "fuck_strapon_pullout")
	if(state == "fuck_strapon_slow"):
		playAnimation(StageScene.PuppySexAllFours, "sex", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не слишком грубить и действуешь с питомцем медленно. Твоя рука чуть лучше направляет страпон, когда ты проникаешь в {npc.him}, и резиновый наконечник широко раздвигает лепестки. После этого ты просто кладешь руки на {npc.thick} задницу питомца и начинаешь трахать {npc.his} жаждущую щель.")

		saynn("Вскоре из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} совершенно беспомощным, пока твоя резиновая игрушка мерно входит и выходит, а смазка делает трение безболезненным.")

		saynn("То, как киска {npc.his} обхватывает этот ствол, чертовски приятно; ты уже чувствуешь приближение оргазма у {npc.his}.")

		addButton("Заставить их кончить", "Довести свою сучку до оргазма", "fuck_strapon_cuminside")
		addButton("Вытащить", "Откажи своему щеночку", "fuck_strapon_pullout")
	if(state == "fuck_strapon_cuminside"):
		playAnimation(StageScene.PuppySexAllFours, "inside", {pc="pc", npc=npcID, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты позволяешь щенку кончить, заталкивая страпон глубоко в {npc.him}, пока резиновый наконечник не касается шейки матки {npc.his}. Ты тискаешь задницу своего питомца, пока {npc.he} {npc.isAre} дрожит и извивается под тобой, а киска {npc.his} пытается выдоить страпон во время климакса.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твой питомец тяжело дышит, киска {npc.his} всё еще подергивается даже после того, как ты вытащил страпон.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "fuck_strapon_pullout"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь немного помучить питомца и устраиваешь ему отказ, выдергивая страпон именно в тот момент, когда чувствуешь, что {npc.him} близок к пику. Тут же слышится скуление; твой питомец дрожит так сильно, как позволяют путы, а мокрая киска {npc.his} остается без внимания.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("Твой питомец скулит всё сильнее. Тогда ты шлепаешь {npc.his} по заднице.")

		saynn("[say=npc]..г-гав...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "petplay_strapon_ass"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true}})
		saynn("Ты устраиваешься позади {npc.him}, твой резиновый член уже касается ануса {npc.his}, и от этих легких ласк он начинает подергиваться.")

		addButton("Трахаться медленно", "Нежно обращайся со своим питомцем", "fuck_strapon_slow_ass")
		addButton("Трахаться быстро", "Вжарить своему питомцу", "fuck_strapon_fast_ass")
	if(state == "fuck_strapon_fast_ass"):
		playAnimation(StageScene.PuppySexAllFours, "fast", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Твои ладони ложатся на задницу питомца, когда ты впихиваешь внутрь резиновую игрушку, силой раздвигая ожидающее отверстие. Твой питомец дергается вперед... но ты просто тянешь {npc.him} назад, снова всаживаясь внутрь и трахая {npc.his} жадную жопу.")

		saynn("Несмотря на твою грубость, из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} в полной беспомощности, пока твой страпон в бешеном темпе долбит {npc.him}. Время от времени ты плюешь на резиновый ствол, стараясь сделать трение хоть сколько-нибудь терпимым для щенка.")

		saynn("То, как внутренние стенки {npc.his} обхватывают твою игрушку при каждом толчке, приносит удовольствие; ты уже чувствуешь приближение оргазма {npc.his}.")

		addButton("Заставить их кончить", "Довести свою сучку до оргазма", "fuck_strapon_cuminside_ass")
		addButton("Вытащить", "Откажи своему щеночку", "fuck_strapon_pullout_ass")
	if(state == "fuck_strapon_slow_ass"):
		playAnimation(StageScene.PuppySexAllFours, "sex", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь не слишком грубить и действуешь с питомцем медленно. Твоя рука чуть лучше выравнивает страпон, когда ты проникаешь в {npc.him}, и резиновый наконечник широко раздвигает анус. После этого ты просто кладешь руки на {npc.thick} задницу и начинаешь трахать {npc.him}.")

		saynn("Вскоре из рта {npc.name} начинают вырываться стоны; путы оставляют {npc.him} в полной беспомощности, пока твоя резиновая игрушка мерно входит и выходит. Ты время от времени плюешь на ствол, стараясь, чтобы трение было безболезненным.")

		saynn("То, как внутренние стенки {npc.his} обхватывают этот ствол, чертовски приятно; ты уже чувствуешь приближение оргазма {npc.his}.")

		addButton("Заставить их кончить", "Довести свою сучку до оргазма", "fuck_strapon_cuminside_ass")
		addButton("Вытащить", "Откажи своему щеночку", "fuck_strapon_pullout_ass")
	if(state == "fuck_strapon_cuminside_ass"):
		playAnimation(StageScene.PuppySexAllFours, "inside", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты даешь щенку кончить, заталкивая страпон глубоко в {npc.him}, пока резиновый наконечник не достигает самых {npc.his}. Ты сжимаешь задницу своего питомца, пока {npc.he} {npc.isAre} дрожит и извивается под тобой, а {npc.his} пытается выдоить страпон во время оргазма.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("[say=npc]..г-гав...[/say]")

		saynn("Твой питомец тяжело дышит, а {npc.his} дырочка хвоста всё еще подергивается даже после того, как ты вытащил страпон.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "fuck_strapon_pullout_ass"):
		playAnimation(StageScene.PuppySexAllFours, "tease", {pc="pc", npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты решаешь немного помучить питомца и лишаешь его разрядки, выдергивая страпон как раз в тот момент, когда чувствуешь, что {npc.him} близок к пику. Тут же слышится скуление: твой питомец дрожит так сильно, насколько позволяют путы, а {npc.his} мокрая дырочка хвоста остается без внимания.")

		saynn("[say=pc]Было весело?[/say]")

		saynn("Твой питомец скулит всё сильнее. Тогда ты шлепаешь {npc.his} по заднице.")

		saynn("[say=npc]..г-гав...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		GM.pc.unequipStrapon()
		endScene()
		return

	if(_action == "petplay_strapon"):
		var strapon = _args[0]
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(strapon)

	if(_action in ["fuck_vag_cuminside", "fuck_ass_cuminside", "fuck_strapon_cuminside", "fuck_strapon_cuminside_ass"]):
		processTime(10*60)
		
		if(_action == "fuck_strapon_cuminside"):
			npc.cummedInVaginaBy("pc", FluidSource.Strapon)
			npc.gotVaginaFuckedBy("pc")
		elif(_action == "fuck_strapon_cuminside_ass"):
			npc.cummedInAnusBy("pc", FluidSource.Strapon)
			npc.gotAnusFuckedBy("pc")
		else:
			if(_action == "fuck_ass_cuminside"):
				npc.cummedInAnusBy("pc")
				npc.gotAnusFuckedBy("pc")
			else:
				npc.cummedInVaginaBy("pc")
				npc.gotVaginaFuckedBy("pc")
			GM.pc.orgasmFrom(npcID)
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("play")
		if(npcSlavery.rewardBalance > 0):
			npcSlavery.handleReward(1)
			addMessage("This counted as a small reward for your slave")

	if(_action in ["fuck_vag_pullout", "fuck_ass_pullout", "fuck_strapon_pullout", "fuck_strapon_pullout_ass"]):
		processTime(10*60)
		
		if(_action == "fuck_strapon_pullout"):
			npc.cummedOnBy("pc", FluidSource.Strapon)
			npc.gotVaginaFuckedBy("pc")
		elif(_action == "fuck_strapon_pullout_ass"):
			npc.cummedOnBy("pc", FluidSource.Strapon)
			npc.gotAnusFuckedBy("pc")
		else:
			npc.cummedOnBy("pc")
			if(_action == "fuck_ass_pullout"):
				npc.gotAnusFuckedBy("pc")
			else:
				npc.gotVaginaFuckedBy("pc")
			GM.pc.orgasmFrom(npcID)
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("play")
		if(npcSlavery.rewardBalance < 0):
			npcSlavery.handlePunishment(1)
			addMessage("This counted as a small punishment for your slave")

	if(_action == "play_fetch"):
		processTime(10*60)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("play")
		
	if(_action == "feetplay_allowcum"):
		processTime(10*60)
		
		if(npc.isWearingChastityCage() || npc.hasReachablePenis()):
			npc.cummedOnBy(npcID)
		elif(npc.hasReachableVagina()):
			npc.cummedOnBy(npcID, FluidSource.Vagina, RNG.randf_range(0.2, 0.4))
		npc.orgasmFrom("pc")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("play")
		npcSlavery.addTrust(0.05)
		npcSlavery.addLove(0.02)
		npcSlavery.addSpoiling(0.02)
		if(npcSlavery.rewardBalance > 0):
			npcSlavery.handleReward(2)
			addMessage("This counted as a normal reward for your slave")
		
	if(_action == "feetplay_deny"):
		processTime(10*60)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("play")
		npcSlavery.addTrust(-0.05)
		npcSlavery.addBrokenSpirit(0.05)
		npcSlavery.addSpoiling(-0.1)
		npcSlavery.addDespair(0.02)
		npcSlavery.addNeediness(0.5)
		if(npcSlavery.rewardBalance < 0):
			npcSlavery.handlePunishment(2)
			addMessage("This counted as a normal punishment for your slave")
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
