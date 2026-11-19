extends SceneBase

var npcID = ""
var rideMode = ""
var isFirstRide = true

func _init():
	sceneID = "SybianRidingScene"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		playAnimation(StageScene.Sybian, "idle", {pc="pc", bodyState={naked=true}})
		saynn("Почувствовав возбуждение, ты решаешь опробовать свой сибиан.")

		if (GM.pc.hasReachableVagina()):
			saynn("Маленькие силиконовые дилдо скользят в твои отверстия, когда ты опускаешься на него, и мягкая текстура ласкает твою чувствительную плоть.")

			saynn("Твой клитор покоится на маленькой ребристой платформе, и от этих ощущений по спине уже пробегает дрожь.")

		elif (GM.pc.isWearingChastityCage()):
			saynn("Маленький силиконовый дилдо скользит в твой анус, когда ты опускаешься на него, и мягкая текстура ласкает твою чувствительную плоть.")

			saynn("Твой промежность покоится на маленькой ребристой платформе, вызывая дрожь во всем теле.")

		elif (GM.pc.hasReachablePenis()):
			saynn("Маленький силиконовый дилдо скользит в твой анус, когда ты опускаешься на него, и мягкая текстура ласкает твою чувствительную плоть.")

			saynn("Твоя промежность покоится на маленькой ребристой платформе, отчего по спине пробегает дрожь, а твой член начинает слегка подергиваться.")

		else:
			saynn("Маленький силиконовый дилдо скользит в твой анус, когда ты опускаешься на него, и мягкая текстура ласкает твою чувствительную плоть.")

			saynn("Твоя промежность покоится на маленькой ребристой платформе, вызывая дрожь во всем теле.")

		addButton("Включить", "Начни наслаждаться вибрацией", "turn_on_slave_check")
	if(state == "slave_wants_help"):
		playAnimation(StageScene.SybianOral, "idle", {pc="pc", npc=npcID, bodyState={naked=true}})
		saynn("Ты хватаешь маленький пульт от сибиана и щелкаешь выключателем.")

		if (GM.pc.hasReachableVagina()):
			saynn("Машина под тобой оживает, дилдо начинают вибрировать внутри тебя в размеренном темпе... твоя щель уже начинает слегка увлажняться вокруг игрушек, а платформа под твоим клитором едва заметно смещается, стимулируя тебя.")

		elif (GM.pc.isWearingChastityCage()):
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе; он изогнут так, чтобы идеально массировать твою маленькую простату...")

			saynn("Твой запертый член пытается встать, но металл удерживает его в узде, а платформа под твоим промежностью едва заметно смещается, стимулируя тебя.")

		elif (GM.pc.hasReachablePenis()):
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе; он изогнут так, чтобы идеально массировать твою маленькую простату...")

			saynn("Этого достаточно, чтобы твоя {pc.penis} начала течь от предвкушения, а платформа под твоей промежностью едва заметно смещается, стимулируя тебя.")

		else:
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе.")

			saynn("Этого достаточно, чтобы ты издала милый вздох, а платформа под твоей промежностью едва заметно сместилась, стимулируя тебя.")

		saynn("Одна из твоих рабынь, {npc.name}, кажется, не может оторвать от тебя {npc.his} глаз.")

		saynn("Ты можешь приказать {npc.him} подойти поближе, чтобы повеселиться с {npc.him}... или просто оседлать машину в одиночку.")

		var theNpc = getCharacter(npcID)
		if (theNpc.hasReachablePenis()):
			addButtonWithChecks("Отсосать им", "Отсасывать им член, пока скачешь на сибиане", "do_ride_while_suck", [], [[ButtonChecks.NotOralBlocked]])
		if (theNpc.hasReachableVagina()):
			addButtonWithChecks("Отлизать им", "Лизать им киску, пока скачешь на сибиане", "do_ride_while_lick", [], [[ButtonChecks.NotOralBlocked]])
		addButton("Просто скакать", "Игнорировать их", "just_ride")
		addButton("Трахнуть сибиан", "Игнорировать их и трахать сибиан", "just_hump")
		if (GM.pc.hasReachablePenis() && GM.pc.getWornCondom() == null):
			addButtonWithChecks("Надеть презерватив", "Надеть презерватив во время процесса", "put_a_condom_on", [], [[ButtonChecks.HasCondoms]])
	if(state == "alone_pick_how_ride"):
		saynn("Ты хватаешь маленький пульт от сибиана и щелкаешь выключателем.")

		if (GM.pc.hasReachableVagina()):
			saynn("Машина под тобой оживает, дилдо начинают вибрировать внутри тебя в размеренном темпе... твоя щель уже начинает слегка увлажняться вокруг игрушек, а платформа под твоим клитором едва заметно смещается, стимулируя тебя.")

		elif (GM.pc.isWearingChastityCage()):
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе; он изогнут так, чтобы идеально массировать твою маленькую простату...")

			saynn("Твой запертый член пытается встать, но металл удерживает его в узде, а платформа под твоим промежностью едва заметно смещается, стимулируя тебя.")

		elif (GM.pc.hasReachablePenis()):
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе; он изогнут так, чтобы идеально массировать твою маленькую простату...")

			saynn("Этого достаточно, чтобы твоя {pc.penis} начала течь от предвкушения, а платформа под твоей промежностью едва заметно смещается, стимулируя тебя.")

		else:
			saynn("Машина под тобой оживает, дилдо начинает вибрировать внутри тебя в размеренном темпе.")

			saynn("Этого достаточно, чтобы ты издала милый вздох, а платформа под твоей промежностью едва заметно сместилась, стимулируя тебя.")

		saynn("Как именно ты хочешь это отыметь?")

		addButton("Просто скакать", "Игнорировать их", "just_ride")
		addButton("Трахнуть сибиан", "Игнорировать их и трахать сибиан", "just_hump")
		if (GM.pc.hasReachablePenis() && GM.pc.getWornCondom() == null):
			addButtonWithChecks("Надеть презерватив", "Надеть презерватив во время процесса", "put_a_condom_on", [], [[ButtonChecks.HasCondoms]])
		addDisabledButton("Рабыни", "У вас нет рабынь, готовых присоединиться")
	if(state == "sybian_loop"):
		var pcArousal = GM.pc.getArousal()
		var isHighArousal = (pcArousal < 0.5)
		if (rideMode == ""):
			if (isHighArousal):
				playAnimation(StageScene.Sybian, "ride", {pc="pc", bodyState={naked=true}})
			else:
				playAnimation(StageScene.Sybian, "intense", {pc="pc", bodyState={naked=true}})
			if (isFirstRide):
				if (GM.pc.hasReachableVagina()):
					saynn("Машина гудит, когда вы начинаете медленно и размеренно двигаться на ней, её игрушки доставляют удовольствие вашим жадным отверстиям. Уже становится хорошо...")

				elif (GM.pc.hasReachablePenis()):
					saynn("Машина гудит, когда вы начинаете медленно и размеренно двигаться на ней, её игрушка ласкает ваше жадное ебало, а ваш {pc.penis} дергается и течет предэякулятом. Уже становится хорошо...")

				else:
					saynn("Машина гудит, когда вы начинаете медленно и размеренно двигаться на ней, её игрушка ласкает ваше жадное ебало. Уже становится хорошо...")

			else:
				if (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Ваша киска сжимается вокруг силиконового стержня, ребра и бугорки дразнят чувствительный клитор при каждом движении, в то время как анальный дилдо заставляет вас чувствовать себя набитой до отказа.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ваш {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока ваша простата стимулируется, а ребра и бугорки дразнят промежность при каждом движении, и ваш {pc.penis} сочится предэякулятом.")

					else:
						saynn("Ваш {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока ваша точка удовольствия стимулируется, а ребра и бугорки дразнят промежность при каждом движении.")

				elif (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Ваши бедра качаются вперед-назад, вгоняя вибрирующие дилдо глубже в вашу влажную, жадную киску и {pc.analStretch}, а анус сжимается, пока вы теряетесь в экстазе удовольствия.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ваши бедра качаются вперед-назад, вгоняя вибрирующий дилдо глубже в ваш голодный, жадный анус, пока вы теряетесь в экстазе удовольствия, а ваш {pc.penis} дико дергается.")

					else:
						saynn("Твои бедра ходят ходуном, вбивая вибрирующий дилдо всё глубже в твой жадный, изголодавшийся анус, пока ты тонешь в пучине наслаждения.")

				else:
					if (GM.pc.hasReachableVagina()):
						saynn("Ребристая платформа прижимается к твоему клитору, и с каждым движением на сибиане волны удовольствия разливаются по всему телу, погружая тебя в туман экстаза.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ребристая платформа прижимается к твоему промежности, и с каждым движением на сибиане волны удовольствия разливаются по всему телу, погружая тебя в туман экстаза.")

					else:
						saynn("Ребристая платформа прижимается к твоему промежности, и с каждым движением на сибиане волны удовольствия разливаются по всему телу, погружая тебя в туман экстаза.")

				if (RNG.chance(20)):
					saynn("Твои стоны становятся всё громче, наполняя воздух сладкими звуками твоего наслаждения.")

				elif (RNG.chance(20)):
					saynn("Твое тело не может унять дрожь и ерзанье, каждое движение приближает тебя всё ближе и ближе к пределу...")

				if (pcArousal > 0.8):
					if (RNG.chance(33)):
						saynn("Твое тело трепещет от предвкушения, оргазм становится всё ближе и ближе.")

					elif (RNG.chance(33)):
						saynn("Ты чувствуешь, как внутри нарастает напряжение, когда ты приближаешься к точке невозврата.")

					else:
						saynn("Твои мышцы напряжены от предвкушения, каждое нервное окончание в теле будто в огне, когда ты чувствуешь, что стоишь на пороге разрядки.")

		elif (rideMode == "hump"):
			if (isHighArousal):
				playAnimation(StageScene.Sybian, "hump", {pc="pc", bodyState={naked=true}})
			else:
				playAnimation(StageScene.Sybian, "humpfast", {pc="pc", bodyState={naked=true}})
			if (isFirstRide):
				if (GM.pc.hasReachableVagina()):
					saynn("Вместо того чтобы спокойно скакать на сибиане, ты решаешь вжариться на нем по полной: два вибрирующих дилдо скользят внутри твоих влажных дырочек, пока ты неистово скачешь на машине.")

				elif (GM.pc.hasReachablePenis()):
					saynn("Вместо того чтобы спокойно кататься на сибиане, ты решаешь вжариться в него вовсю: вибрирующий дилдо скользит внутри твоей жаждущей дырки, заставляя твою {pc.penis} течь, пока ты скачешь на машине.")

				else:
					saynn("Вместо того чтобы спокойно кататься на сибиане, ты решаешь вжариться в него вовсю: вибрирующий дилдо скользит внутри твоей жаждущей дырки, пока ты скачешь на машине.")

			else:
				if (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Вибрирующие дилдо входят и выходят из твоей влажной, нетерпеливой киски и {pc.analStretch} ануса, пока твоя рука ласкает клитор.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Вибрирующие дилдо входят и выходят из твоего жаждущего {pc.analStretch} ануса, пока твоя рука трет твой {pc.penis}.")

					else:
						saynn("Вибрирующие дилдо входят и выходят из твоего жаждущего {pc.analStretch} ануса, пока твоя рука трет промежность.")

				elif (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Силиконовые стержни глубоко вонзаются в твои голодные дырки, наполняя тебя ненасытной жаждой большего, пока ты скачешь на сибиане, потерявшись в собственном желании.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Силиконовые стержни глубоко вонзаются в твою голодную дырку, наполняя тебя ненасытной жаждой большего, пока ты скачешь на сибиане, а твоя {pc.penis} ходит вверх-вниз, пока ты растворяешься в своем желании.")

					else:
						saynn("Силиконовые стержни глубоко вонзаются в твою голодную дырку, наполняя тебя ненасытной жаждой большего, пока ты скачешь на сибиане, потерявшись в собственном желании.")

				else:
					if (GM.pc.hasReachableVagina()):
						saynn("Твои {pussy} и {anus} сжимаются вокруг силиконовых стержней, высасывая из них всё до последней капли, пока ты скачешь на сибиане.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Твой {pc.analStretch} {anus} сжимается вокруг силиконового стержня, высасывая из него всё до последней капли, пока ты скачешь на сибиане.")

					else:
						saynn("Твой {pc.analStretch} {anus} сжимается вокруг силиконового стержня, высасывая из него всё до последней капли, пока ты скачешь на сибиане.")

				if (RNG.chance(20)):
					saynn("Твои стоны становятся всё громче, наполняя воздух сладкими звуками твоего наслаждения... пока ты продолжаешь усердно двигаться, оседлав сибиан.")

				elif (RNG.chance(20)):
					saynn("Твое тело не может унять дрожь и ерзанье, каждое движение приближает тебя всё ближе и ближе к пределу...")

				if (pcArousal > 0.8):
					if (RNG.chance(33)):
						saynn("Твое тело трепещет от предвкушения, оргазм становится всё ближе и ближе.")

					elif (RNG.chance(33)):
						saynn("Ты чувствуешь, как внутри нарастает напряжение, когда ты приближаешься к точке невозврата.")

					else:
						saynn("Твои мышцы напряжены от предвкушения, каждое нервное окончание в теле будто в огне, когда ты чувствуешь, что стоишь на пороге разрядки.")

		elif (rideMode == "suck"):
			if (isHighArousal):
				playAnimation(StageScene.SybianOral, "blowjob", {pc="pc", npc=npcID, bodyState={naked=true}, npcBodyState={exposedCrotch=true, hard=true}})
			else:
				playAnimation(StageScene.SybianOral, "blowjobfast", {pc="pc", npc=npcID, bodyState={naked=true}, npcBodyState={exposedCrotch=true, hard=true}})
			if (isFirstRide):
				saynn("Ты зовешь {npc.name} поближе... а затем вытаскиваешь {npc.his} {npc.penis} и отправляешь его в рот, лаская его языком...")

				if (GM.pc.hasReachableVagina()):
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушки доставляют удовольствие твоим жаждущим отверстиям. Так приятно чувствовать, что все твои дырочки забиты...")

				elif (GM.pc.hasReachablePenis()):
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушка ласкает твою жаждущую дырку, а твоя {pc.penis} дергается и течет от предэякулята. Так приятно чувствовать, что все твои дырочки забиты...")

				else:
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушка ласкает твою жаждущую дырку. Так приятно чувствовать, что все твои дырочки забиты...")

			else:
				if (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Ты жадно сосешь этот член, проводя языком по всей его длине. Твоя киска сжимается вокруг силиконового стержня, а выступы и бугорки дразнят твой чувствительный клитор при каждом движении, пока анальный дилдо дает ощущение полной наполненности.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ты жадно сосешь этот член, проводя языком по всей его длине. Твоя {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока твоя простата стимулируется, а выступы и бугорки дразнят твою промежность при каждом движении, и твоя {pc.penis} течет от предэякулята.")

					else:
						saynn("Ты жадно сосёшь этот член, проводя языком по всей его длине. Твой {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока твоя точка удовольствия стимулируется, а рельефные выступы дразнят твою промежность каждым движением.")

				elif (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Твои бёдра ходят взад-вперед, заталкивая вибрирующие дилдо глубже в твою влажную, жаждущую киску и {pc.analStretch}, сжимающийся анус, пока твое горло растягивается этим классным членом.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Твои бёдра ходят взад-вперед, заталкивая вибрирующий дилдо глубже в твой голодный, жаждущий анус, пока твое горло растягивается этим классным членом, а твой {pc.penis} дико дёргается.")

					else:
						saynn("Твои бёдра ходят взад-вперед, заталкивая вибрирующий дилдо глубже в твой голодный, жаждущий анус, пока твое горло растягивается этим классным членом.")

				else:
					if (GM.pc.hasReachableVagina()):
						saynn("Рельефная платформа прижимается к твоему клитору, посылая волны наслаждения по всему телу с каждым движением, пока ты скачешь на сибиане и одновременно доставляешь удовольствие члену своего раба.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Рельефная платформа прижимается к твоей промежности, посылая волны наслаждения по всему телу с каждым движением, пока ты скачешь на сибиане и одновременно доставляешь удовольствие члену своего раба.")

					else:
						saynn("Рельефная платформа прижимается к твоей промежности, посылая волны наслаждения по всему телу с каждым движением, пока ты скачешь на сибиане и одновременно доставляешь удовольствие члену своего раба.")

				if (RNG.chance(20)):
					saynn("Твои приглушенные стоны становятся громче, наполняя воздух сладкими звуками твоего наслаждения, смешанными с влажным хлюпаньем.")

				elif (RNG.chance(20)):
					saynn("Твое тело не может унять дрожь и ерзанье, каждое движение приближает тебя всё ближе и ближе к пределу...")

				if (pcArousal > 0.8):
					if (RNG.chance(33)):
						saynn("Твое тело дрожит от предвкушения, оргазм становится всё ближе и ближе. Член, который ты сосёшь, кажется, тоже вот-вот лопнет...")

					elif (RNG.chance(33)):
						saynn("Ты чувствуешь, как внутри нарастает напряжение по мере приближения к точке невозврата. Прямо как член у тебя во рту...")

					else:
						saynn("Твои мышцы напряжены от предвкушения, каждая нервная клетка в теле горит, когда ты чувствуешь, что находишься на грани разрядки. {npc.penis} пульсирует у тебя во рту.")

		elif (rideMode == "lick"):
			if (isHighArousal):
				playAnimation(StageScene.SybianOral, "lick", {pc="pc", npc=npcID, bodyState={naked=true}, npcBodyState={exposedCrotch=true, hard=true}})
			else:
				playAnimation(StageScene.SybianOral, "lickfast", {pc="pc", npc=npcID, bodyState={naked=true}, npcBodyState={exposedCrotch=true, hard=true}})
			if (isFirstRide):
				saynn("Ты зовешь {npc.name} поближе... а затем, когда {npc.his} {npc.pussyStretch} киска обнажена, ты прижимаешься к ней лицом, высунув язык и готовая доставить удовольствие.")

				if (GM.pc.hasReachableVagina()):
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушки ласкают твои жаждущие отверстия. Так приятно, когда все твои дырочки заняты...")

				elif (GM.pc.hasReachablePenis()):
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушка ласкает твою жаждущую дырку, а твой {pc.penis} подергивается и течет от предэякулята. Так приятно, когда все твои дырочки заняты...")

				else:
					saynn("В то же время ты начинаешь ритмично двигаться на жужжащей машине медленными, размеренными движениями, пока её игрушка ласкает твою жаждущую дырку. Так приятно, когда все твои дырочки заняты...")

			else:
				if (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Ты жадно поедаешь этот {pussy}, проводя языком по лепесткам и слизывая смазку с клитора. Твоя собственная киска сжимается вокруг силиконового стержня, а ребра и бугорки дразнят твой чувствительный клитор каждым движением, пока анальный дилдо дает ощущение полной наполненности.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ты жадно поедаешь эту {pussy}, проводя языком по лепесткам и вылизывая клитор. Твой {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока твою простату стимулируют, а выступы и бугорки при каждом движении дразнят твою промежность, и твоя {pc.penis} сочится предэякулятом.")

					else:
						saynn("Ты жадно поедаешь эту {pussy}, проводя языком по лепесткам и вылизывая клитор. Твой {pc.analStretch} {anus} сжимается вокруг силиконового стержня, пока твою эрогенную зону стимулируют, а выступы и бугорки при каждом движении дразнят твою промежность.")

				elif (RNG.chance(33)):
					if (GM.pc.hasReachableVagina()):
						saynn("Твои бедра ходят взад-вперед, вгоняя вибрирующие дилдо глубже в твою влажную, жаждущую киску и {pc.analStretch}; твой анус сжимается, пока язык исследует внутренние стенки чужого мокрого разреза.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Твои бедра ходят взад-вперед, вгоняя вибрирующий дилдо глубже в твой голодный, жаждущий анус, пока твой язык исследует скользкие внутренние стенки этой {pussy}, а твой {pc.penis} дико дергается.")

					else:
						saynn("Твои бедра ходят взад-вперед, вгоняя вибрирующий дилдо глубже в твой голодный, жаждущий анус, пока твой язык исследует скользкие внутренние стенки этой {pussy}.")

				else:
					if (GM.pc.hasReachableVagina()):
						saynn("Ребристая платформа прижимается к твоему клитору, посылая волны удовольствия по всему телу при каждом движении, пока ты скачешь на сибиане и одновременно ласкаешь {npc.pussyStretch} {pussy} своего раба.")

					elif (GM.pc.hasReachablePenis()):
						saynn("Ребристая платформа прижимается к твоему промежности, и с каждым движением на сибиане по твоему телу расходятся волны удовольствия, пока ты одновременно ласкаешь {npc.pussyStretch} {pussy} своего раба.")

					else:
						saynn("Ребристая платформа прижимается к твоему промежности, и с каждым движением на сибиане по твоему телу расходятся волны удовольствия, пока ты одновременно ласкаешь {npc.pussyStretch} {pussy} своего раба.")

				if (RNG.chance(20)):
					saynn("Твои приглушенные стоны становятся громче, наполняя воздух сладкими звуками твоего наслаждения, смешанными с влажным хлюпаньем.")

				elif (RNG.chance(20)):
					saynn("Твое тело не может унять дрожь и ерзанье, каждое движение приближает тебя всё ближе и ближе к пределу...")

				if (pcArousal > 0.8):
					if (RNG.chance(33)):
						saynn("Твое тело дрожит от предвкушения, оргазм становится всё ближе и ближе. Киска, которую ты лижешь, кажется, тоже на пределе...")

					elif (RNG.chance(33)):
						saynn("Ты чувствуешь, как внутри нарастает напряжение по мере приближения к точке невозврата. Прямо как складки киски, к которым прижаты твои губы...")

					else:
						saynn("Твои мышцы напряжены от предвкушения, каждый нерв в теле горит, когда ты чувствуешь, что находишься на грани разрядки. Киска дико подергивается от твоих языков.")

		if (pcArousal >= 1.0):
			saynn("Ты сейчас кончишь...")

			addButton("Кончай!", "Пора кончать", "do_cum")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "do_next_loop")
	if(state == "do_cum"):
		if (rideMode == ""):
			playAnimation(StageScene.Sybian, "ride", {pc="pc", pcCum=true, bodyState={naked=true, hard=true}})
		elif (rideMode == "hump"):
			playAnimation(StageScene.Sybian, "hump", {pc="pc", pcCum=true, bodyState={naked=true, hard=true}})
		if (GM.pc.hasReachableVagina()):
			saynn("Все твое тело дрожит от силы оргазма, твоя киска и задница спазмируют вокруг дилдо, пока ты поддаешься сокрушительным волнам нахлынувшего удовольствия.")

		elif (GM.pc.hasReachablePenis()):
			saynn("Все твое тело дрожит от силы оргазма, задница спазмирует вокруг дилдо, а промежность подергивается, пока ты поддаешься сокрушительным волнам нахлынувшего удовольствия.")

		if (rideMode == "suck"):
			playAnimation(StageScene.SybianOral, "blowjob", {pc="pc", pcCum=true, npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
			saynn("Вкус горячих, густых {npc.cum} твоего раба наполняет твой рот, пока ты жадно глотаешь, и это ощущение посылает искры удовольствия по всему твоему телу.")

		elif (rideMode == "lick"):
			playAnimation(StageScene.SybianOral, "lick", {pc="pc", pcCum=true, npc=npcID, bodyState={naked=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
			saynn("Киска твоей рабыни извергает сладкий нектар; её соки обволакивают твоё лицо, пока ты жадно слизываешь влагу из её сочащейся щели, теряясь в пьянящем вкусе её возбуждения.")

		if (GM.pc.isWearingChastityCage()):
			saynn("Твой запертый член пульсирует, выстреливая {pc.cum} сквозь отверстие в маленькой девственной клетке, пока твою простату нещадно доят!")

		elif (GM.pc.hasReachablePenis() && GM.pc.getWornCondom() != null):
			saynn("Твой {pc.penis} пульсирует, выстреливая {pc.cum} в презерватив, который быстро наполняется, пока твою простату нещадно доят!")

		elif (GM.pc.hasReachablePenis()):
			saynn("Твой {pc.penis} пульсирует, выстреливая струями {pc.cum} и оставляя после себя настоящий беспорядок на полу, пока твою простату нещадно доят!")

		saynn("После этого мощного оргазма ты остаешься тяжело дышащим.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_recovercondom")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "turn_on_slave_check"):
		processTime(5*60)
		
		var possibleSlaveIDs = []
		var slaves = GM.main.getPCSlavesIDs()
		for slaveID in slaves:
			var theChar:DynamicCharacter = getCharacter(slaveID)
			if(theChar == null || !theChar.isSlaveToPlayer()):
				continue
			var npcSlavery:NpcSlave = theChar.getNpcSlavery()
			if(npcSlavery.isDoingActivity()):
				continue
			if(npcSlavery.isActivelyResisting() || npcSlavery.isMindBroken()):
				continue
			if(theChar.hasReachablePenis() || theChar.hasReachableVagina()):
				possibleSlaveIDs.append(slaveID)
		
		GM.pc.addLust(10)
		GM.pc.addArousal(GM.pc.getLustLevel() * 0.2)
		
		if(RNG.chance(100) && possibleSlaveIDs.size() > 0):
			npcID = RNG.pick(possibleSlaveIDs)
			addCharacter(npcID)
			setState("slave_wants_help")
			return	
		
		setState("alone_pick_how_ride")
		return

	if(_action == "do_ride_while_suck"):
		setState("sybian_loop")
		rideMode = "suck"
		return

	if(_action == "do_ride_while_lick"):
		setState("sybian_loop")
		rideMode = "lick"
		return

	if(_action == "just_ride"):
		if(npcID != ""):
			removeCharacter(npcID)
		setState("sybian_loop")
		rideMode = ""
		return

	if(_action == "just_hump"):
		if(npcID != ""):
			removeCharacter(npcID)
		setState("sybian_loop")
		rideMode = "hump"
		return

	if(_action == "put_a_condom_on"):
		var breakChance = GM.pc.useWorstCondom()
		var condomItem:ItemBase = GlobalRegistry.createItem("UsedCondom")
		condomItem.breakChance = breakChance
		GM.pc.getInventory().forceEquipStoreOther(condomItem)
		addMessage("Ты надеваешь пустой презерватив!")
		return

	if(_action == "do_cum"):
		processTime(5*60)
		GM.pc.orgasmFrom("pc")
		GM.pc.setArousal(0.0)
		if(rideMode == "suck"):
			var theNpc = getCharacter(npcID)
			GM.pc.gotThroatFuckedBy(npcID)
			GM.pc.cummedInMouthBy(npcID)
			theNpc.orgasmFrom("pc")
			if(theNpc.isSlaveToPlayer()):
				theNpc.getNpcSlavery().addUnhappiness(-10.0)
		if(rideMode == "lick"):
			var theNpc = getCharacter(npcID)
			GM.pc.cummedInMouthBy(npcID, FluidSource.Vagina, RNG.randf_range(0.3, 0.7))
			GM.pc.cummedOnBy(npcID, FluidSource.Vagina, RNG.randf_range(0.3, 0.7))
			theNpc.orgasmFrom("pc")
			if(theNpc.isSlaveToPlayer()):
				theNpc.getNpcSlavery().addUnhappiness(-10.0)

	if(_action == "do_next_loop"):
		processTime(1*60)
		isFirstRide = false
		GM.pc.addLust(10)
		GM.pc.addArousal(GM.pc.getLustLevel() * 0.2)
		setState("sybian_loop")
		return

	if(_action == "endthescene_recovercondom"):
		if(GM.pc.getWornCondom() != null):
			GM.pc.getInventory().unequipItem(GM.pc.getWornCondom())
			addMessage("Ты сохраняешь использованный презерватив!")
		playAnimation(StageScene.Solo, "stand")
		GM.pc.setArousal(0.0)
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["npcID"] = npcID
	data["rideMode"] = rideMode
	data["isFirstRide"] = isFirstRide

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
	rideMode = SAVE.loadVar(data, "rideMode", "")
	isFirstRide = SAVE.loadVar(data, "isFirstRide", true)
