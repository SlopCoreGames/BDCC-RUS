extends SceneBase

var npcID = ""
var npc = null
var masType = "penis"
var didABrat = false

func _init():
	sceneID = "SlaveryEventCaughtMasturbating"

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func _reactInit():
	var possible = []
	if(npc.hasReachablePenis()):
		possible.append("penis")
	if(npc.hasReachableVagina()):
		possible.append("vag")
	if(possible.size() <= 0):
		endScene()
		return
	masType = RNG.pick(possible)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("Ты подходишь к своей рабыне... и замечаешь, что {npc.he} {npc.isAre} ласкает {npc.his} {npc.penis}. Да еще и как жадно.")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("Ты подходишь к своей рабыне... и замечаешь, что {npc.he} {npc.isAre} трет {npc.his} {npc.pussyStretch} киску. Да еще и как жадно.")

		saynn("Поощрение может заставить {npc.him} любить тебя сильнее... но это также может разбаловать {npc.him}. Если ты не хочешь, чтобы твоя рабыня мастурбировала, возможно, стоит сковать {npc.his} руки..."+str(" Или надеть девственную клетку на {npc.his} член." if (masType == "penis") else "")+"")

		addButton("Поощрить", "Дать ей кончить", "do_encourage_check")
		addButton("Приказать остановиться", "Приказать ей остановиться", "do_orderstop_check")
		addButtonWithChecks("Заставить остановиться", "Ты не можешь допустить подобного ни при каких обстоятельствах", "force_stop_check", [], [[ButtonChecks.NotHandsBlocked], [ButtonChecks.NotArmsRestrained]])
		addButton("Предложить себя", "Предложить им трахнуть тебя вместо этого", "do_offerself_check")
	if(state == "do_forcetostop_fail"):
		playAnimation(StageScene.Duo, "hurt", {npc=npcID, npcAction="shove"})
		saynn("Ты не можешь допустить такого ни при каких обстоятельствах. Поэтому ты даже не отдаешь приказ рабыне. Вместо этого ты бросаешься к {npc.him} и силой заламываешь {npc.his} руки за {npc.his} спину.")

		saynn("Но твоей рабыне удается вырваться!")

		saynn("[say=npc]"+str(RNG.pick(["Да пошел ты! Я должен кончить! Я сейчас кончу!", "К черту всё, сегодня я точно кончу!", "Отъебись, мне это нужно!"]))+"[/say]")

		saynn("Похоже, назревает драка.")

		addButton("Драться", "Начать бой", "do_fight_slave")
	if(state == "lost_slavecums"):
		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("{npc.name} победила... а значит, {npc.he} делает то, что хочет {npc.he}.")

			saynn("[say=npc]Да пошел ты!..[/say]")

			saynn("Твоя рабыня начинает быстро ласкать член {npc.his}, стремительно доводя {npc.himself} до оргазма. Лучше держаться на небольшом расстоянии и наблюдать, чем рискнуть и попасть... под раздачу.")

			saynn("{npc.name} кряхтит и выгибает {npc.his} спину, когда пульсирующий {npc.penis} {npc.his} выбрасывает густые струи {npc.cum}, заливая пол липкой массой. Твоя рабыня остается тяжело дышащей и удовлетворенной.")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("{npc.name} победила... а значит, {npc.he} делает то, что хочет {npc.he}.")

			saynn("[say=npc]Да пошел ты!..[/say]")

			saynn("Твоя рабыня начинает быстро перебирать пальцами в щели {npc.his}, стремительно доводя {npc.himself} до оргазма. Лучше держаться на небольшом расстоянии и наблюдать, чем рискнуть и попасть... под раздачу.")

			saynn("{npc.name} стонет и выгибает {npc.his} спину, когда из ее дергающейся {npc.pussyStretch} {npc.his} киски вырывается фонтан прозрачной {npc.girlcum}, делая пол влажным и липким. Твоя рабыня остается тяжело дышащей и удовлетворенной.")

		saynn("Похоже, твой раб заслужил наказание. Надеемся, для {npc.him} оно того стоило.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "won_antihornyfight"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcAction="defeat", npcBodyState={leashedBy="pc"}})
		saynn("Вы победили. Ваша рабыня, {npc.name}, падает на пол, не в силах продолжать борьбу.")

		if (masType == "penis"):
			saynn("Похоже, {npc.him} больше не разрешено ласкать себя; {npc.he} {npc.isAre} вынуждена терпеть сильное желание, не имея возможности его удовлетворить.")

		elif (masType == "vag"):
			saynn("Похоже, {npc.him} мастурбировать запрещено, и {npc.he} {npc.isAre} приходится терпеть сильное желание, не имея возможности его удовлетворить.")

		saynn("Твой раб выглядит еще более отчаявшимся, чем прежде. {npc.He} наверняка станет доверять тебе меньше. Может, тебе и самому не стоит слишком доверять {npc.him} и надеть на руки {npc.his}..")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_forcetostop"):
		playAnimation(StageScene.Grope, "tease", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
		saynn("Ты не можешь допустить такого ни при каких обстоятельствах. Поэтому ты даже не отдаешь приказ рабыне. Вместо этого ты бросаешься к {npc.him} и силой заламываешь {npc.his} руки за {npc.his} спину.")

		saynn("[say=npc]"+str(RNG.pick(["Э-эй!.. Я был так близок!", "Нет! Дай мне кончить!", "Нет, не надо, пожалуйста!"]))+"[/say]")

		if (masType == "penis"):
			saynn("Не-а. Ты заставляешь {npc.him} смотреть, как {npc.his} {npc.penis} начинает вянуть без всякой стимуляции.")

		elif (masType == "vag"):
			saynn("Не-а. Ты заставляешь {npc.him} смотреть, как {npc.his} сочная, влажная киска сохнет без малейшей стимуляции.")

		saynn("Кризис миновал... но после такого твоя рабыня вряд ли будет тебе доверять... это также повлияет на {npc.his} психическое состояние.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_orderstop"):
		playAnimation(StageScene.Grope, "tease", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
		saynn("Твой раб, кажется, близок к разрядке... но это не помешает тебе лишить его {npc.him}.")

		saynn("[say=pc]А ну стоять! Живо прекращай, а то пожалеешь.[/say]")

		if (masType == "penis"):
			saynn("{npc.name} слышит тебя.. {npc.his} рука поглаживает {npc.his} член всё медленнее и медленнее, пока {npc.he} раздумывает..")

			saynn("[say=npc]Да, {npc.pcOwner}..[/say]")

			saynn("Ты буквально чувствуешь отчаяние в звуках, которые издает {npc.his}, когда {npc.he} лишает {npc.himself} {npc.his} собственный оргазм, убирая {npc.his} руку от {npc.his} твердого, сочащегося смазкой члена.. и просто позволяя ему обмякнуть.")

			saynn("Похоже, твоя рабыня только что проскочила; особо-то и наказывать {npc.him} не за что.")

		elif (masType == "vag"):
			saynn("{npc.name} слышит тебя.. {npc.his} рука ласкает {npc.his} киску всё медленнее и медленнее, пока {npc.he} раздумывает..")

			saynn("[say=npc]Да, {npc.pcOwner}..[/say]")

			saynn("Ты буквально чувствуешь отчаяние в звуках, которые издает {npc.his}, когда {npc.he} лишает {npc.himself} {npc.his} собственный оргазм, убирая {npc.his} руку от {npc.his} влажной, сочащейся щели.. и просто оставляя {npc.his} чувствительные, жаждущие лепестки без внимания.")

			saynn("Похоже, твоя рабыня только что проскочила; особо-то и наказывать {npc.him} не за что.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_orderstop_fail"):
		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})

		
		saynn("Твой раб, кажется, близок к разрядке... но это не помешает тебе лишить его {npc.him}.")

		saynn("[say=pc]А ну стоять! Живо прекращай, а то пожалеешь.[/say]")

		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("{npc.name} слышит тебя.. {npc.his} рука поглаживает {npc.his} член всё медленнее и медленнее, пока {npc.he} раздумывает..")

			saynn("[say=npc]Да пошел ты!..[/say]")

			saynn("Вместо того чтобы отрицать {npc.himself}, твой раб решает пойти наперекор твоим словам и начинает быстро ласкать {npc.his} член, стремительно доводя {npc.himself} до климакса. Лучше держаться на небольшом расстоянии и просто наблюдать, чем рискнуть и самому... попасть под раздачу.")

			saynn("{npc.name} кряхтит и выгибает {npc.his} спину, когда пульсирующий {npc.penis} {npc.his} выбрасывает густые струи {npc.cum}, заливая пол липкой массой. Твоя рабыня остается тяжело дышащей и удовлетворенной.")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("{npc.name} слышит тебя.. {npc.his} рука ласкает {npc.his} киску всё медленнее и медленнее, пока {npc.he} раздумывает..")

			saynn("[say=npc]Да пошел ты!..[/say]")

			saynn("Вместо того чтобы отрицать {npc.himself}, твой раб решает пойти наперекор твоим словам и начинает быстро перебирать пальцами {npc.his} щель, стремительно доводя {npc.himself} до климакса. Лучше держаться на небольшом расстоянии и просто наблюдать, чем рискнуть и самой... попасть под раздачу.")

			saynn("{npc.name} стонет и выгибает {npc.his} спину, когда из ее дергающейся {npc.pussyStretch} {npc.his} киски вырывается фонтан прозрачной {npc.girlcum}, делая пол влажным и липким. Твоя рабыня остается тяжело дышащей и удовлетворенной.")

		saynn("Похоже, твой раб заслужил наказание. Надеемся, для {npc.him} оно того стоило.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_encourage"):
		saynn("Ты решаешь просто... наблюдать за происходящим. {npc.name} замечает твой любопытный взгляд... и продолжает, когда ты молча даешь {npc.him} разрешение продолжать.")

		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("Ваши взгляды то и дело пересекаются, пока твой раб водит {npc.his} ладонью по {npc.his} стволу, а кончик обильно сочится предэякулятом. {npc.He} ничего не отвечает, просто пытаясь насладиться моментом, прежде чем ты в конечном итоге решишь остановить {npc.him}.")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			saynn("Ваши взгляды то и дело пересекаются, пока твой раб трет {npc.his} киску {npc.his} пальцами, время от времени переходя на клитор и лаская его, а {npc.his} чувствительные складки выглядят влажными и скользкими. {npc.He} ничего не отвечает, просто пытаясь насладиться моментом, прежде чем ты в конечном итоге решишь остановить {npc.him}.")

		saynn("Судя по тому, как тяжело дышит {npc.name}, {npc.he} уже совсем близко.")

		addButton("Просто наблюдай", "Дай им кончить", "do_encourage_cum")
		addButtonWithChecks("Помоги им", "Предложи помощь", "do_encourage_help", [], [[ButtonChecks.NotHandsBlocked], [ButtonChecks.NotArmsRestrained]])
	if(state == "do_encourage_help"):
		if (masType == "penis"):
			playAnimation(StageScene.Grope, "strokefast", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("Это выглядело так весело, что ты решил(а) присоединиться и помочь своему рабу! Твоя рука оттесняет {npc.his}, когда ты начинаешь ласкать член {npc.his} вместо этого. Любые протесты заглушаются тихим...")

			saynn("[say=pc]Тссс... Просто наслаждайся.[/say]")

			saynn("И {npc.he} повинуется, яички {npc.his} уже напряжены. Ты чувствуешь, как ствол {npc.his} пульсирует в твоей руке, пока ты ведешь ею вдоль всей длины... пока из него не вырываются густые струи семени!")

			if (didABrat):
				saynn("Ты не стоял(а) прямо в... зоне поражения... Но твой раб намеренно повернулся в последнюю секунду, не оставив тебе времени среагировать, прежде чем порция {npc.his} приземлилась на тебя! Ого!")

				saynn("[say=pc]ЭЙ![/say]")

				saynn("В ответ ты слышишь лишь стоны и хихиканье. Это определенно заслуживает [b]серьезного[/b] наказания. Ты крепко сжимаешь яички {npc.his}, заставляя {npc.him} замолчать.")

			else:
				saynn("Ты стоял(а) чуть в стороне, стараясь сделать так, чтобы порция {npc.his} не попала на тебя, а приземлилась на пол.")

				saynn("Похоже, твой раб отлично разрядился. {npc.He} кажется, доволен этим — ты замечаешь легкую улыбку."+str(" Надеюсь, это немного поможет от депрессии {npc.his}." if npc.getNpcSlavery().getDespair() > 0.6 else "")+"")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "gropefast", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("Это выглядело так весело, что ты решил(а) присоединиться и помочь своему рабу! Твоя рука оттесняет {npc.his}, когда ты начинаешь ласкать киску {npc.his} вместо этого. Любые протесты заглушаются тихим...")

			saynn("[say=pc]Тссс... Просто наслаждайся.[/say]")

			saynn("И так {npc.he} и делает, можно уже услышать некоторые из {npc.his} новых милых стонов. Твой большой палец сосредоточен на потирании этой маленькой бусинки, пока два пальца раздвигают складки и начинают быстро ласкать это влагалище... пока из него не вырывается настоящий фонтан соков!")

			if (didABrat):
				saynn("Ты не стоял прямо в... зоне поражения... Но твоя рабыня намеренно развернулась в последнюю секунду, не оставив тебе ни единого шанса среагировать, прежде чем на тебя приземлится {npc.his} {npc.girlcum}! Ого!")

				saynn("[say=pc]ЭЙ![/say]")

				saynn("В ответ слышны лишь стоны и хихиканье. Это определенно заслуживает [b]большого[/b] наказания. Ты начинаешь с того, что слегка шлепаешь {npc.his} киску, заставляя {npc.him} замолчать.")

			else:
				saynn("Ты стоял чуть в стороне, следя за тем, чтобы {npc.his} {npc.girlcum} не приземлились на тебя, а упали на пол.")

				saynn("Похоже, твой раб отлично разрядился. {npc.He} кажется, доволен этим — ты замечаешь легкую улыбку."+str(" Надеюсь, это немного поможет от депрессии {npc.his}." if npc.getNpcSlavery().getDespair() > 0.6 else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_encourage_cum"):
		if (masType == "penis"):
			playAnimation(StageScene.Grope, "watchstroke", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("Ты наблюдаешь, как твой раб начинает кряхтеть и стонать, {npc.his} яички напрягаются, а член в {npc.his} руках пульсирует... пока из него не вырывается целая серия густых струй семени!")

			if (didABrat):
				saynn("Ты не стоял(а) прямо в... зоне поражения... Но твой раб намеренно повернулся в последнюю секунду, не оставив тебе времени среагировать, прежде чем порция {npc.his} приземлилась на тебя! Ого!")

				saynn("[say=pc]ЭЙ![/say]")

				saynn("В ответ слышны лишь стоны и хихиканье. Это определенно заслуживает [b]большого[/b] наказания.")

			else:
				saynn("Ты стоял(а) чуть в стороне, стараясь сделать так, чтобы порция {npc.his} не попала на тебя, а приземлилась на пол.")

				saynn("Похоже, твой раб отлично разрядился. {npc.He} кажется, доволен этим — ты замечаешь легкую улыбку."+str(" Надеюсь, это немного поможет от депрессии {npc.his}." if npc.getNpcSlavery().getDespair() > 0.6 else "")+"")

		elif (masType == "vag"):
			playAnimation(StageScene.Grope, "watchrub", {pc=npcID, npc="pc", pcCum=true, bodyState={exposedCrotch=true, hard=true}})
			saynn("Ты наблюдаешь, как твоя рабыня начинает слегка ерзать и издавать милые стоны, {npc.his} движения рук становятся всякими дрожащими и прерывистыми, {npc.his} щель киски сжимается... пока из неё не вырывается настоящий фонтан соков!")

			if (didABrat):
				saynn("Ты не стоял прямо в... зоне поражения... Но твоя рабыня намеренно развернулась в последнюю секунду, не оставив тебе ни единого шанса среагировать, прежде чем на тебя приземлится {npc.his} {npc.girlcum}! Ого!")

				saynn("[say=pc]ЭЙ![/say]")

				saynn("В ответ слышны лишь стоны и хихиканье. Это определенно заслуживает [b]большого[/b] наказания.")

			else:
				saynn("Ты стоял чуть в стороне, следя за тем, чтобы {npc.his} {npc.girlcum} не приземлились на тебя, а упали на пол.")

				saynn("Похоже, твой раб отлично разрядился. {npc.He} кажется, доволен этим — ты замечаешь легкую улыбку."+str(" Надеюсь, это немного поможет от депрессии {npc.his}." if npc.getNpcSlavery().getDespair() > 0.6 else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_encourage_fail"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("Ты решаешь просто... наблюдать за процессом. {npc.name} замечает твой любопытный взгляд... и останавливается.")

		saynn("[say=npc]"+str(RNG.pick(["..что?", "Чего уставился?", "Что-то нужно?", "Не видишь, что я тут теку?"]))+"[/say]")

		saynn("[say=pc]Продолжай.[/say]")

		if (masType == "penis"):
			saynn("{npc.He} еще несколько раз ласкает член {npc.his}... но затем замирает.")

		else:
			saynn("{npc.He} еще несколько раз трет киску {npc.his}... но затем замирает.")

		saynn("[say=npc]Отводи взгляд![/say]")

		saynn("Ого, ты явно не собираешься слушаться приказов своей рабыни. Вместо этого ты принимаешь суровый вид.")

		saynn("[say=npc]Ну, тогда я не буду...[/say]")

		saynn("Похоже, {npc.he} заслужила для {npc.himself} небольшое наказание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "offerself_toosubby"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("Похоже, {npc.He} весело проводит время... в одиночку. Почему бы не предложить {npc.him} повеселиться вместе с тобой?")

		saynn("[say=pc]Почему бы тебе просто не трахнуть меня? Хотя бы один разок.[/say]")

		saynn("Твой раб замечает твой интерес и тут же останавливается.")

		saynn("[say=npc]"+str(RNG.pick(["Oh, uhh..", "Твою мать..."]))+"[/say]")

		saynn("[say=pc]Да ладно тебе, будет весело![/say]")

		saynn("{npc.He} понуро опускает {npc.his} голову.")

		saynn("[say=npc]Прости... Кажется, у меня нет на это сил...[/say]")

		saynn("Похоже, твой раб слишком уж покорный для такого! Ну да ладно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "offerself_nofetish"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("Похоже, {npc.He} весело проводит время... в одиночку. Почему бы не предложить {npc.him} повеселиться вместе с тобой?")

		saynn("[say=pc]Почему бы тебе просто не трахнуть меня? Хотя бы один разок.[/say]")

		saynn("Твой раб замечает твой интерес и тут же останавливается.")

		saynn("[say=npc]"+str(RNG.pick(["Oh, uhh..", "Твою мать..."]))+"[/say]")

		saynn("[say=pc]Да ладно тебе, будет весело![/say]")

		saynn("{npc.He} пожимает плечами.")

		saynn("[say=npc]Знаешь, секс — это не совсем моё...[/say]")

		saynn("Странно, да? Похоже, твоему рабу не особо интересны занятия сексом.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "do_offerself"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("Похоже, {npc.He} весело проводит время... в одиночку. Почему бы не предложить {npc.him} повеселиться вместе с тобой?")

		saynn("[say=pc]Почему бы тебе просто не трахнуть меня? Хотя бы один разок.[/say]")

		saynn("Твой раб замечает твой интерес и тут же останавливается.")

		saynn("[say=npc]"+str(RNG.pick(["А?", "Что?", "Ты серьезно?"]))+"[/say]")

		saynn("[say=pc]Да ладно тебе, будет весело![/say]")

		saynn("{npc.He} разглядывает тебя... и прикусывает {npc.his} губу.")

		saynn("[say=npc]Ладно, только потом не ной![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "start_sex")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_encourage_check"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		var failChance = (npcSlavery.personalityScore({PersonalityStat.Coward: 1.0, PersonalityStat.Brat: 1.0}) - 0.2 )* 30.0 + 30.0 - npcSlavery.getObedience() * 30.0 + npcSlavery.fetishScore({Fetish.Exhibitionism:-1.0}) * 40.0
		
		if(!RNG.chance(failChance)):
			setState("do_encourage")
		else:
			setState("do_encourage_fail")
			npcSlavery.deservesPunishment(1)
		return

	if(_action == "do_orderstop_check"):
		processTime(6*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		var failChance = (npcSlavery.personalityScore({PersonalityStat.Coward: -1.0, PersonalityStat.Brat: 1.0, PersonalityStat.Impatient: 1.0}) + 0.2 )* 40.0 * (1.0 - npcSlavery.getObedience()*1.5)
		
		if(!RNG.chance(failChance)):
			setState("do_orderstop")
			npcSlavery.addDespair(0.01)
			npcSlavery.addAwareness(0.05)
			npcSlavery.addLove(-0.05)
			npcSlavery.addTrust(0.02)
			npcSlavery.addSpoiling(-0.1)
			npcSlavery.addNeediness(0.5)
		else:
			npcSlavery.addObedience(-0.02)
			npcSlavery.addDespair(-0.03)
			npcSlavery.addLove(-0.02)
			setState("do_orderstop_fail")
			npcSlavery.deservesPunishment(2)
			npcSlavery.addSpoiling(0.05)
			npc.orgasmFrom(npcID)
		return

	if(_action == "force_stop_check"):
		processTime(6*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		var failChance = (npcSlavery.personalityScore({PersonalityStat.Coward: -1.0, PersonalityStat.Brat: 1.0, PersonalityStat.Impatient: 1.0}) + 0.2 )* 20.0 * (1.0 - npcSlavery.getObedience()*0.5)
		failChance = max(10, failChance)
		
		if(!RNG.chance(failChance)):
			setState("do_forcetostop")
			npcSlavery.addDespair(0.04)
			npcSlavery.addAwareness(-0.02)
			npcSlavery.addTrust(-0.05)
			npcSlavery.addSpoiling(-0.1)
			npcSlavery.addNeediness(0.5)
		else:
			setState("do_forcetostop_fail")
		return

	if(_action == "do_offerself_check"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.addBrokenSpirit(-0.05)
		npcSlavery.addTrust(0.05)
		var subbyness = npcSlavery.personalityScore({PersonalityStat.Subby: 1.0})
		
		if(subbyness > 0.15):
			setState("offerself_toosubby")
			return
		var needsAtLeastOneFetish = [Fetish.AnalSexGiving, Fetish.AnalSexReceiving, Fetish.VaginalSexGiving, Fetish.VaginalSexReceiving, Fetish.OralSexGiving, Fetish.OralSexReceiving, Fetish.RimmingGiving, Fetish.RimmingReceiving, Fetish.FeetplayGiving, Fetish.FeetplayReceiving]
		for theFetish in needsAtLeastOneFetish:
			if(npcSlavery.fetishScore({theFetish:1.0}) >= 0.0):
				setState("do_offerself")
				return
		setState("offerself_nofetish")
		return

	if(_action == "do_fight_slave"):
		runScene("FightScene", [npcID], "antihornyfight")
		return

	if(_action == "do_encourage_cum"):
		processTime(5*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.addLove(0.05)
		npcSlavery.addAwareness(0.02)
		npcSlavery.addSpoiling(0.05)
		npcSlavery.addDespair(-0.05)
		if(RNG.chance(npcSlavery.getBratScore() * 40.0)):
			didABrat = true
			if(masType == "penis"):
				GM.pc.cummedOnBy(npcID)
			if(masType == "vag"):
				GM.pc.cummedOnBy(npcID, FluidSource.Vagina)
			npcSlavery.deservesPunishment(3)
		npc.orgasmFrom(npcID)

	if(_action == "do_encourage_help"):
		processTime(5*60)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		npcSlavery.addLove(0.03)
		npcSlavery.addAwareness(0.02)
		npcSlavery.addObedience(0.02)
		npcSlavery.addSpoiling(0.05)
		npcSlavery.addDespair(-0.05)
		if(RNG.chance(npcSlavery.getBratScore() * 40.0)):
			didABrat = true
			if(masType == "penis"):
				GM.pc.cummedOnBy(npcID)
			if(masType == "vag"):
				GM.pc.cummedOnBy(npcID, FluidSource.Vagina)
			npcSlavery.deservesPunishment(3)
		npc.orgasmFrom("pc")

	if(_action == "start_sex"):
		runScene("GenericSexScene", [npcID, "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "sex_with_slave")
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "antihornyfight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(battlestate == "win"):
			setState("won_antihornyfight")
			addExperienceToPlayer(10)
			npcSlavery.afterBeatenUp()
			npcSlavery.addDespair(0.04)
			npcSlavery.addAwareness(0.02)
			npcSlavery.addTrust(-0.05)
			npcSlavery.addSpoiling(-0.1)
			npcSlavery.addNeediness(0.5)
		else:
			setState("lost_slavecums")
			npcSlavery.addObedience(-0.02)
			npcSlavery.addDespair(-0.1)
			npcSlavery.addBrokenSpirit(-0.1)
			npcSlavery.addLove(0.02)
			npcSlavery.deservesPunishment(2)
			npc.orgasmFrom(npcID)

	if(_tag == "sex_with_slave"):
		endScene()
		return

func saveData():
	var data = .saveData()

	data["npcID"] = npcID
	data["npc"] = npc
	data["masType"] = masType
	data["didABrat"] = didABrat

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	masType = SAVE.loadVar(data, "masType", "penis")
	didABrat = SAVE.loadVar(data, "didABrat", false)
