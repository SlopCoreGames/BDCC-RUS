extends SceneBase

var npcID = ""
var npcVariation = ""
var gotStripped = false
var strippedItemID = ""
var iterations = 0
var doneWhenIterations = -1
var optionsUsed = []
var lastBodywritingZone = ""
var lastBodywritingID = ""

func _init():
	sceneID = "HypnoEncounterDoll"
	
func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcVariation = "mean"
	if(personality.getStat(PersonalityStat.Mean) < -0.3):
		npcVariation = "kind"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcVariation = "subby"
		
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	var npc: BaseCharacter = GlobalRegistry.getCharacter(npcID)
	npc = npc #dont bother me godot
	addCharacter(npcID)
	
	if(state == "" and (not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body))):
		#skip past stripping
		state = "stripped"
	
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):

			saynn("[say=npc]"+RNG.pick([
				"Это будет только мешать.",
				"Сними это.",
				"Разденься."
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("{npc.He} {npc.verb('grab')} хватает тебя за одежду и грубо притягивает к себе.")
			
			saynn("[say=npc]"+RNG.pick([
				"Сними это, или я сам его с тебя сорву.",
				"Сними это. Живо.",
				"Разденься, сучка."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("{npc.He} {npc.verb('brush', 'brushes')} стряхивает пыль с твоей одежды.")
			saynn("[say=npc]"+RNG.pick([
				"Почему бы тебе не снять это?",
				"Ты ведь не против раздеться для меня, верно?",
				"Можешь раздеться догола для меня?",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("{npc.He} {npc.verb('grip')} твою одежду, явно стремясь поскорее её снять.")
			saynn("[say=npc]"+RNG.pick([
				"Сними это, пожалуйста.",
				"Я хочу видеть [i]всё[/i] твое прекрасное тело!",
				"Тебе совершенно нечего скрывать, красавчик~",
			])+"[/say]")
			
		saynn("Не успеваешь ты оглянуться, как одежда сползает с тебя, пока ты...")
		HypnokinkUtil.addHypnoButtons(self, "stripped", "resist", ["Strip", "Remove"])
		
	if(state == "stripped"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты послушно замираешь, обнаженная и уязвимая как телом, так и разумом.")
		
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Подними руки над головой.",
				"Руки вверх.",
				"Держи руки над головой."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Руки над головой.",
				"Руки вверх, сучка.",
				"Не опускай руки, держи их над головой."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Подними руки над головой, если не сложно?",
				"Руки вверх, пожалуйста.",
				"Можешь держать руки над головой?",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Подними руки, пожалуйста. Я хочу добраться до каждой твоей складочки~.",
				"Руки вверх, а? Просто хочу уткнуться лицом в твою грудь~",
			])+"[/say]")
			
		saynn("Твои руки начинают механически подниматься без всякого осознанного усилия с твоей стороны, и ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Raise"])
	
	if(state == "cuffs_wrists" || state == "cuffs_ankles"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID})
		
		var limb = "wrists" if state == "cuffs_wrists" else "ankles"
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("{npc.He} {npc.verb('grab')} твои "+limb+", зажимая на них что-то.")
			
			saynn("[say=npc]"+RNG.pick([
				"Смотри прямо перед собой. Не двигайся.",
				"Ты слишком много ерзаешь.",
				"Это сделает тебя по-настоящему беспомощной."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("{npc.He} мучительно {npc.verb('squeeze')} твои "+limb+", зажимая на них что-то.")
			
			saynn("[say=npc]"+RNG.pick([
				"Смотри вперед. Дай мне надеть на тебя наручники.",
				"Это поможет тебе не шевелиться.",
				"Немного бондажа — это всегда весело."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("{npc.He} нежно {npc.verb('squeeze')} твой "+limb+", зажимая на них что-то.")
			
			saynn("[say=npc]"+RNG.pick([
				"Тебе ведь нравится быть связанной, правда?",
				"Думаю, тебе бы понравилось быть немного беспомощной~",
				"Тебе нравятся наручники?",
			])+"[/say]")
			
		saynn("Тщетно пытаясь оказать хоть какое-то сопротивление, ты...")
		HypnokinkUtil.addHypnoButtons(self, "cuffs_"+limb+"_post", "resist", ["Hold still", "Wince", "Whine"])
		
	if(state == "bodywriting"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID})
		saynn("{npc.He} {npc.verb('retrieve')} откуда-то черный маркер и с щелчком снимает колпачок.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Давай проясним, кто ты есть на самом деле.",
				"Небольшая реклама будет очень кстати."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Давай сделаем из тебя ту шлюху, которой ты являешься.",
				"Шлюх нужно маркировать.",
				"Не дергайся, сучка."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Ты ведь не против, если я оставлю след, правда?",
				"Тебе действительно стоит заявить о себе~",
				"Просто маленькое напоминание...",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("[say=npc]"+RNG.pick([
				"Ты ведь не против, если я оставлю след, правда?",
				"Просто чтобы ты меня не забыл(а)~",
			])+"[/say]")
		
		saynn("Замирая изо всех сил, ты...")
		HypnokinkUtil.addHypnoButtons(self, "bodywriting_2", "resist", ["Hold still", "Wince", "Whine"])
		
	if(state == "bodywriting_2"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID})
		saynn("{npc.He} {npc.verb('draw')} [b]'"+str(BodyWritings.getWritingText(lastBodywritingID))+"'[/b] на твоем "+BodyWritingsZone.getZoneVisibleName(lastBodywritingZone)+".")
		
		saynn("[say=npc]"+RNG.pick([
			"Тебе идет.",
			"Приятно.",
			"На тебе смотрится отлично.",
		])+"[/say]")
		
		saynn("Не в силах сопротивляться, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Hold still", "Wait", "Whine"])
		
	if(state == "kneel"):
		#only subby version
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="kneel"})
		
		saynn("{npc.He} {npc.verb('kneel')} перед тобой, чтобы рассмотреть тебя поближе.")
		saynn("[say=npc]"+RNG.pick([
				"Ох, как же мне хочется поиграть~",
				"Я могла бы доставить тебе столько удовольствия...",
				"Ммм, мне нравится то, что я вижу!"
			])+"[/say]")
		
		saynn("{npc.He} продолжает стоять на коленях перед тобой, нагое разглядывая твое тело. Смущенная таким пристальным желанием, ты...")
		HypnokinkUtil.addHypnoButtons(self, "kneel_2", "resist", ["Blush", "Pose"])
		
	if(state == "kneel_2"):
		var toOgle = "crotch"
		if(GM.pc.hasPenis()):
			toOgle = "{pc.penis}"
		elif(GM.pc.hasVagina()):
			toOgle = "{pc.vagina}"
		saynn("{npc.He} {npc.verb('explore')} твое тело {npc.his} взглядом, долго задерживаясь на твоем "+toOgle+", но дразняще не предпринимая никаких действий. Ты послушно замираешь, принимая позы для восхищения.")
		saynn("[say=npc]"+RNG.pick([
				"Какое прекрасное зрелище.",
				"Так и хочется...",
				"Какое искушение~"
			])+"[/say]")
			
		saynn("{npc.He} со временем {npc.verb('rise')} встает на {npc.his} ноги, решая пока продолжить игру. Все еще сгорая от смущения, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Blush"])


	if(state == "punch"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="punch"})
		#only mean version
		saynn("Без всякого предупреждения, {npc.he} {npc.verb('sock')} тебя прямо в живот!")
		saynn("[say=npc]"+RNG.pick([
				"Из тебя вышла бы отличная груша для битья!",
				"Не дергайся, сучка.",
				"Тебе всё равно это, скорее всего, понравится."
			])+"[/say]")
		
		saynn("Вздрагивая от боли, ты...")
		HypnokinkUtil.addHypnoButtons(self, "punch_2", "resist", ["Hold still"])
	
	if(state == "punch_2"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="punch"})
		#only mean version
		saynn("{npc.He} раз за разом {npc.verb('jab')} тебя в живот и грудь!")
		saynn("[say=npc]"+RNG.pick([
				"Надо бы сделать это частью моей тренировки.",
				"Синяки тебе к лицу.",
				"Может, стоит бить сильнее? Чтобы ребра хрустели."
			])+"[/say]")
		
		saynn("Весь в синяках, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Suffer", "Endure"])
		
	if(state == "hug"):
		playAnimation(StageScene.Hug, "hug", {npc=npcID})
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("{npc.He} внезапно {npc.verb('draw')} тебя в объятия" + ("." if GM.pc.hasBoundArms() else ", и ты рефлекторно обхватываешь руками {npc.him}."))
		
			saynn("[say=npc]"+RNG.pick([
				"А я ведь могу быть и милой~",
				"Ты ведешь себя [i]очень[/i] послушно..."
			])+"[/say]")
		#no mean version
		# (kind version)
		if(npcVariation == "kind"):
			saynn("{npc.He} нежно {npc.verb('draw')} тебя в объятия" + ("." if GM.pc.hasBoundArms() else ", и после минутного колебания ты обхватываешь руками {npc.him}."))
			
			saynn("[say=npc]"+RNG.pick([
				"Good {pc.boy}...",
				"Тебе ведь нравится, правда?",
				"Вот так, просто расслабься...",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			saynn("{npc.He} обвивает {npc.his} руками тебя" + (" и {npc.verb('nuzzle')} твою грудь." if GM.pc.hasBoundArms() else ". Пока {npc.he} {npc.verb('nuzzle')} твою грудь, ты отвечаешь на объятия."))
			
			saynn("[say=npc]"+RNG.pick([
				"Ммм~",
				"Это ведь нормально, да?",
				"Я хочу, чтобы ты принадлежала только мне...",
			])+"[/say]")
		
		saynn("Спустя некоторое время {npc.he} {npc.verb('let')} уходит. Ты послушно вскидываешь руки, даже не дожидаясь команды, и...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", [])
		
	if(state == "tease"):
		playAnimation(StageScene.ArmsRaisedSex, "tease", {npc=npcID})
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("{npc.He} медленно, дразняще {npc.verb('circle')} за твоей спиной. Ты вздрагиваешь, когда чувствуешь, как руки начинают исследовать всё твое тело.")
			
			saynn("[say=npc]"+RNG.pick([
				"Ты ведь сделаешь всё, чтобы угодить мне, м-м?",
				"Ты ведешь себя [i]очень[/i] послушно...",
			])+"[/say]")
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn("{npc.He} {npc.verb('paces')} стоит позади тебя. Ты вздрагиваешь, когда чувствуешь, как руки начинают бесстыдно ощупывать всё твоё тело.")
			
			saynn("[say=npc]"+RNG.pick([
				"Я могу делать с тобой [i]всё что угодно[/i].",
				"Вот так, сучка. Трясись.",
				"Ты полностью моя, и ты ничего не можешь с этим поделать.",
			])+"[/say]")
			
		# (kind version)
		if(npcVariation == "kind"):
			saynn("{npc.He} медленно и дразняще {npc.verb('circle')} позади тебя. Ты вздрагиваешь, когда чувствуешь, как руки начинают нежно скользить по твоему телу.")
			
			saynn("[say=npc]"+RNG.pick([
				"Good {pc.boy}...",
				"Тебе нравится? О да, еще как...",
				"Вот так, просто расслабься...",
			])+"[/say]")
			
		# (no subby version)
		
		saynn("Когда {npc.he} {npc.verb('continue')} наклоняется, чтобы прошептать тебе на ухо, ты...")
		HypnokinkUtil.addHypnoButtons(self, "tease_2", "resist", ["Shiver", "Whine"])
		
	if(state == "tease_2"):
		playAnimation(StageScene.ArmsRaisedSex, "inside", {npc=npcID})
		saynn("{npc.He} наклоняется ещё ближе, почти касаясь твоих ушей.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Может, оставлю тебя только себе.",
				"Обещаю, мы будем делать это гораздо чаще.",
			])+"[/say]")
			
		# (mean version)
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Сделаю из тебя свою личную шлюшку-игрушку.",
				"Такую шлюху, как ты, нужно использовать по полной.",
				"Ты станешь моей личной шлюхой.",
			])+"[/say]")
			
		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Я могу устроить тебе [i]очень[/i] приятное время.",
				"Такая покорная и послушная~",
				"Хочешь стать моей хорошей [i]игрушкой[/i]?",
			])+"[/say]")
			
		# (no subby version)
		
		saynn("Дыхание {npc.His} и шепот {npc.his}, проносящийся мимо твоего уха, посылают горячую, возбуждающую дрожь по твоему позвоночнику.")
		
		saynn("{npc.He} {npc.verb('let')} обходит тебя, возвращаясь вперед и не сводя с тебя глаз. Ты можешь только...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Shiver", "Whine", "Gulp"])
		
	if(state == "hands_free_orgasm"):
		playAnimation(StageScene.SexFreeStanding, "tease", {pc=npcID, npc="pc"})
		
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("Когда твоя похоть и желание становятся очевидными, {npc.he} {npc.verb('drag')} твои запястья за спиной.")

			saynn("[say=npc]"+RNG.pick([
				"Какая же ты милая шлюшка~",
				"Тебя это заводит, да?",
				"Кто разрешил тебе получать удовольствие?"
			])+"[/say]")
			
			saynn("Когда {npc.he} {npc.verb('continue')} начинает дразнить тебя, ты не можешь не...")
			
		if(npcVariation == "mean"):
			saynn("Когда твоя похоть и желание становятся очевидными, {npc.he} {npc.verb('wrest')} твои запястья за спиной.")
			
			saynn("[say=npc]"+RNG.pick([
				"Вижу, тебя это заводит, сучка.",
				"Наслаждаешься, шлюха?",
				"Весело тебе? Ну и блядь же ты."
			])+"[/say]")
			
			saynn("Когда {npc.he} {npc.verb('continue')} начинает осыпать тебя словесными унижениями, ты не можешь не...")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("Когда твоя похоть и вожделение становятся очевидными, {npc.he} {npc.verb('grab')} твои запястья, мягко отводя их за спину.")
			saynn("[say=npc]"+RNG.pick([
				"О-о, а тебе ведь нравится~",
				"Ну-ну, ты ведь хочешь быть послушной {pc.boy}, верно?",
				"Давай убедимся, что ты всё делаешь правильно...",
			])+"[/say]")
			saynn("Пока {npc.he} {npc.verb('continue')} слова ободрения, ты не можешь удержаться от...")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("Когда твоя похоть и вожделение становятся очевидными, {npc.he} мягко {npc.verb('guide')} тебя, заставляя убрать руки за спину.")
			saynn("[say=npc]"+RNG.pick([
				"О, следующая часть тебе точно понравится!",
				"Вижу, ты вовсю развлекаешься~",
				"Я знаю, что заставит тебя почувствовать себя хорошо!",
			])+"[/say]")
			saynn("Пока {npc.he} {npc.verb('continue')} выражать свои {npc.his} похотливые желания, ты не можешь удержаться от...")
			
		HypnokinkUtil.addHypnoButtons(self, "hands_free_orgasm_2", "resist", ["Tense up", "Squirm"])
		
	if(state == "hands_free_orgasm_2"):
		playAnimation(StageScene.SexFreeStanding, "inside", {pc=npcID, npc="pc"})
		
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("Твои запястья насильно заведены за спину, и всё, что тебе остается — это извиваться.")
			saynn("[say=npc]Слышала, ты так натренировала свой разум, что можешь кончать даже без рук. Это правда?[/say]")
			saynn("Любой протест, который ты могла бы высказать, затихает под волной наслаждения, проносящейся по твоему телу.")
			saynn("[say=npc]Круто! Ладно, на это будет приятно посмотреть. Стань совсем развратной и жаждущей меня.[/say]")
			saynn("Ты напрягаешься и стонешь, когда волна за волной фантомного удовольствия захлестывает тебя. Запястья заведены за спину, и тебе остается только подаваться вперед, пока нарастающее желание стремительно подводит тебя к самому краю...")
			saynn("[say=npc]И... [b]Кончай.[/b][/say]")
			saynn("Уже так близко, одна лишь команда заставляет тебя...")
			
		if(npcVariation == "mean"):
			saynn("Твои запястья мучительно заведены за спину, и всё, что тебе остается — это извиваться.")
			saynn("[say=npc]До меня дошли слухи, что ты такая ненасытная шлюшка, что можешь кончать без помощи рук по одной лишь команде. Глядя на то, как у тебя текут слюни, это кажется вполне правдой.[/say]")
			saynn("Любой протест, который ты могла бы издать, тонет в волне наслаждения, проходящей сквозь твое тело.")
			saynn("[say=npc]Хах. Ладно, это я обязан увидеть. Хочу посмотреть, какой возбужденной и отчаявшейся ты будешь, шлюшка. Покажи мне, как сильно ты этого хочешь.[/say]")
			saynn("Ты напрягаешься и стонешь, когда волна за волной фантомного удовольствия захлестывает тебя. Запястья заведены за спину, и тебе остается только подаваться вперед, пока нарастающее желание стремительно подводит тебя к самому краю...")
			saynn("[say=npc][b]Кончай[/b], "+RNG.pick(["slut", "whore", "bitch"])+".[/say]")
			saynn("Уже так близко, одна лишь команда заставляет тебя...")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("Твои запястья аккуратно, но крепко заведены за спину, и всё, что тебе остается — это извиваться.")
			saynn("[say=npc]Слышал, ты даже можешь кончать по команде, совершенно без рук. Звучит заманчиво, а?[/say]")
			saynn("Любой комментарий, который ты могла бы сделать, тонет в волне наслаждения, проходящей сквозь твое тело.")
			saynn("[say=npc]Думаю, это «да». Раз уж ты так жаждешь, почему бы тебе не стать совсем развратной и изголодавшейся по мне?[/say]")
			saynn("Ты напрягаешься и стонешь, когда волна за волной фантомного удовольствия захлестывает тебя. Запястья заведены за спину, и тебе остается только подаваться вперед, пока нарастающее желание стремительно подводит тебя к самому краю...")
			saynn("[say=npc]А теперь будь хорошей {pc.boy} и [b]кончи[/b] для меня.[/say]")
			saynn("Уже так близко, одна лишь команда заставляет тебя...")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("Хотя хватка {npc.nameS} — это скорее предложение, когда твой разум погружен в послушание, всё, что тебе остается — это извиваться.")
			saynn("[say=npc]Я слышала, что ты можешь даже кончать по команде, совершенно без рук. Хотела бы я уметь так же...[/say]")
			saynn("Любые мысли или предложения, что могли у тебя возникнуть, умирают вместе с волной удовольствия, прокатывающейся по твоему телу.")
			saynn("[say=npc]Ооо! Тебя так легко порадовать. Почему бы тебе не показать мне, как это делается? Вижу, с каждым моим словом ты становишься всё более нетерпеливой...[/say]")
			saynn("Ты напрягаешься и стонешь, когда волна за волной фантомного удовольствия захлестывает тебя. Запястья заведены за спину, и тебе остается только подаваться вперед, пока нарастающее желание стремительно подводит тебя к самому краю...")
			saynn("[say=npc]Так, ты готова? Ты, должно быть, уже совсем близко~ Почувствуй, как удовольствие нарастает, и нарастает... [b]Кончай[/b]![/say]")
			saynn("Уже так близко, одна лишь команда заставляет тебя...")
		
		HypnokinkUtil.addHypnoButtons(self, "hands_free_orgasm_3", "hands_free_orgasm_3_selfdeny", ["Cum", "Orgasm", "Explode"], ["Resist", "Deny", "Stop"])
		
	if(state == "hands_free_orgasm_3"):
		playAnimation(StageScene.SexFreeStanding, "tease", {pc=npcID, npc="pc"})
		#oh, boy!
		var cumDesc = " orgasmic pleasure courses through you"
		var undiesDesc = null
		if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom)):
			undiesDesc = (GM.pc.getInventory().getEquippedItem(InventorySlot.UnderwearBottom).getVisibleName().to_lower())
		elif(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body)):
			undiesDesc = (GM.pc.getInventory().getEquippedItem(InventorySlot.Body).getVisibleName().to_lower())
		if(GM.pc.hasPenis() and GM.pc.hasVagina()):
			cumDesc = "your "+(RNG.pick(["caged", "locked"]) if GM.pc.isWearingChastityCage() else "")+RNG.pick(["dick", "cock", "member"])
			if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom) and not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body)):
				 cumDesc += " dribbles out its load onto the ground"
			else:
				cumDesc += ""
			cumDesc += " and your spasming "+RNG.pick(["pussy", "pussy", "slit", "kitty"])
			if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom) and not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body)):
				 cumDesc += " drips your juices down your thighs"
			else:
				cumDesc += " make your "+undiesDesc+" all sticky and wet"
		elif(GM.pc.hasPenis()):
			cumDesc = "your "+(RNG.pick(["caged", "locked"]) if GM.pc.isWearingChastityCage() else "")+RNG.pick(["dick", "cock", "member"])+" dribbles out its load"
			if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom) and not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body)):
				 cumDesc += " onto the ground"
			else:
				cumDesc += " into your "+undiesDesc
		elif(GM.pc.hasVagina()):
			cumDesc = "your spasming "+RNG.pick(["pussy", "pussy", "slit", "kitty"])
			if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom) and not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Body)):
				 cumDesc += " drips your juices down your thighs."
			else:
				cumDesc += " makes your "+undiesDesc+" all wet"
		
		saynn("Поскольку твои руки надежно зафиксированы вне досягаемости, тебе остается лишь отчаянно стонать и толчками двигаться навстречу пустоте, пока "+cumDesc+".")
		saynn("[say=pc]А-а-ах... Хфф...[/say]")
		saynn("Оргазм физически неудовлетворителен из-за отсутствия стимуляции или ощущений. Но для твоего покорного, послушного разума удовольствие от того, что ты кончаешь по команде — это лучшее чувство на свете. Даже унижение от этого заставляет тебя довольно улыбаться и краснеть.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("[say=npc]"+RNG.pick([
				"Неплохой фокус для вечеринки.",
				"Я прямо чувствую, как ты дрожишь~",
				"Ха, сработало. Без шуток."
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Легко, прямо как сейчас.",
				"Секс-игрушка с голосовым управлением. Мне нравится.",
				"Не привыкай к этому."
			])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"Вот так, прочувствуй это до конца~",
				"Молодец, {pc.boy}, {pc.name}! Очень хорошо!",
				"Похоже, тебе понравилось~",
			])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Выглядит весело! Надо будет научиться так же.",
				"Ой, завидую~",
				"Бьюсь об заклад, это чертовски приятно...",
			])+"[/say]")
			
		saynn("{npc.Name} отпускает твои запястья. Твои руки дрожа поднимаются обратно над головой, и ты...")
			
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Calm down", "Relax"])
	if(state == "hands_free_orgasm_3_selfdeny"):
		playAnimation(StageScene.SexFreeStanding, "tease", {pc=npcID, npc="pc"})
		saynn("Даже когда вспышки удовольствия грозят сбросить тебя с края, тебе каким-то образом удается найти силу воли, чтобы отказать себе в сладком освобождении оргазма. Вместо этого, в отчаянии и от дикого возбуждения, ты замираешь на самом пределе, пока твое тело имитирует физические признаки, которые обычно сопровождают разрядку.")	
		saynn("[say=pc]А-а-ах... Хфф...[/say]")
		saynn("Ты дрожишь, содрогаешься и балансируешь на грани несколько мучительных мгновений.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("[say=npc]"+RNG.pick([
				"Неплохой фокус для вечеринки.",
				"Я прямо чувствую, как ты дрожишь~",
				"Хм. И не говори.",
				"Что, совсем сухой?"
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Легко, прямо как сейчас.",
				"Секс-игрушка с голосовым управлением. Мне нравится.",
				"Не привыкай к этому.",
				"Ты вообще кончил? Да хрен с ним, мне плевать."
			])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"Вот так, прочувствуй это до конца~",
				"Молодец, {pc.boy}, {pc.name}! Очень хорошо!",
				"Похоже, тебе понравилось~",
				"Оу, сухой оргазм? Ничего страшного, в следующий раз точно получится, я уверена."
			])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Мне нужно научиться делать так же.",
				"Ой, завидую~",
				"Спорим, это было очень приятно...",
				"Тоже не получается? Ничего, со временем научишься, я уверена."
			])+"[/say]")
			
		saynn("{npc.Name} отпускает твои запястья. Твои руки дрожа поднимаются обратно над головой, и ты...")
			
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Calm down", "Relax"])
		
	if(state == "finale"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("[say=npc]Ладно, думаю, на этом всё. Можешь опускать руки.[/say]")
			saynn("Ты позволяешь рукам упасть.")
			if(gotStripped):
				saynn("[say=npc]Не знаю как ты, но [i]я[/i] повеселилась. Держи, надень это обратно.[/say]")
				saynn("{npc.He} {npc.verb('hand')} тебе твои "+GM.pc.getInventory().getEquippedItemByID(strippedItemID).getVisibleName().to_lower()+".")
				saynn("Пока твои мысли всё еще затуманены, к тому времени, как ты заканчиваешь одеваться и поднимаешь взгляд, {npc.name} уже исчезает.")
			else:
				saynn("Твои мысли всё еще путаются, и к тому моменту, как ты поднимаешь взгляд, {npc.name} уже нет рядом.")
				
			
		if(npcVariation == "mean"):
			saynn("[say=npc]С меня хватит.[/say]")
			if(gotStripped):
				playAnimation(StageScene.Duo, "defeat", {npc=npcID})
				#not equipped here, hence not getEquippedItemByID
				saynn("{npc.He} {npc.verb('toss', 'tosses')} твой "+GM.pc.getInventory().getFirstOf(strippedItemID).getVisibleName().to_lower()+" у твоих ног.")
				saynn("[say=npc]Подними это.[/say]")
				saynn("Ты наклоняешься, чтобы собрать свои вещи, но вдруг тебя грубо хватают за шиворот и швыряют на колени.")
				saynn("[say=npc]Даже не вздумай надевать это обратно. Демонстрируй то, что ты из себя представляешь. Понятно?[/say]")
				saynn("Всё, на что тебя хватает — это судорожный кивок.")
			else:
				saynn("{npc.He} {npc.verb('shove')} тебя в сторону.")
			saynn("[say=npc]Ты жалкая тварь, но именно поэтому с тобой так весело трахаться. Еще увидимся, "+RNG.pick(["fucktoy", "slut", "whore", "bitch"])+".[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]Мне было весело, а тебе? Опусти руки, пожалуйста.[/say]")
			saynn("Ты позволяешь рукам упасть.")
			if(gotStripped):
				saynn("[say=npc]Ты ведь не против, если я...[/say]")
				saynn("{npc.He} {npc.verb('help')} ты наденешь свои "+GM.pc.getInventory().getEquippedItemByID(strippedItemID).getVisibleName().to_lower()+" обратно.")
			saynn("[say=npc]Спасибо, что поиграл со мной! Нам стоит повторить это как-нибудь еще~[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]Мне даже хочется утащить тебя куда-нибудь, чтобы повеселиться по полной, но...[/say]")
			saynn("{npc.He} мягко {npc.verb('pull')} опускает твои руки.")
			saynn("[say=npc]Ты бы мне больше понравился, если бы полностью всё осознавал и контролировал~[/say]")
			if(gotStripped):
				saynn("[say=npc]Помочь тебе с этим?[/say]")
				saynn("{npc.He} {npc.verb('hand')} тебе твои "+GM.pc.getInventory().getEquippedItemByID(strippedItemID).getVisibleName().to_lower()+" и {npc.verb('help')} ты надеваешь это обратно.")		
			saynn("{npc.He} {npc.verb('sashay')} прочь, напоследок еще пару раз покачивая {npc.his} бедрами специально для тебя.")
			saynn("[say=npc]Ну, тогда до встречи![/say]")
			
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "resist"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("[say=pc]"+RNG.pick(["St-stop...", "W-wait...", "Я не...", "Я не могу—", "Нет!", "Please, I..."])+"[/say]")
		saynn("Тебя пробирает дрожь — ты почти на грани того, чтобы разрушить чары.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("[say=npc]"+RNG.pick([
				"Что?", 
				"В чем дело?", 
				"Ну же, не будь такой..."
				])+"[/say]")
				
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Знай своё место! Последний шанс.", 
				"Как ты смеешь.", 
				"Не делай того, о чем потом пожалеешь."
				])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"Хм? Возникли проблемы?", 
				"Хочешь остановиться?", 
				"Я не слишком сильно надавила?"
				])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Оу, мы больше не играем?", 
				"Нет, не останавливайся...", 
				"Давай еще немного повеселимся?"
				])+"[/say]")
			
		saynn("Ты прервал(а) текущий план действий {npc.nameS}. Раз уж ты это сделал(а), тебе стоит просто...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist_2", [], ["Escape", "Get away", "Resist", "Break away"])
		
	if(state == "resist_2"):
		playAnimation(StageScene.Solo, "walk")
		saynn("Воспользовавшись эффектом неожиданности, ты отталкиваешь {npc.name} и бросаешься наутек.")
		addButton("Бежать", "", "endthescene")
			
func pickSubscene() -> String:
	if(iterations >= doneWhenIterations):
		setState("finale")
		return "finale"
	iterations += 1
	var options = []
	options.append(["bodywriting",1.0])
	if(GM.pc.getLustLevel() > 0.6 and iterations > 0):
		options.append(["hands_free_orgasm",2.0 * GM.pc.getLustLevel()])
	if(npcVariation == "mean"):
		options.append(["punch",1.0])
	if(npcVariation != "mean"):
		options.append(["hug",1.0])
	if(npcVariation == "subby"):
		options.append(["kneel",1.0])
	if(npcVariation != "subby"):
		options.append(["tease",1.0])
		if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Wrists)):
			options.append(["cuffs_wrists", 1.0])
		if(not GM.pc.getInventory().hasSlotEquipped(InventorySlot.Ankles)):
			options.append(["cuffs_ankles", 1.0])
	var unusedOptions = []
	for optionPair in options:
		if(not optionsUsed.has(optionPair[0])):
			unusedOptions.append(optionPair)
	if(unusedOptions.size() == 0):
		setState("finale")
		return "finale"
	var option = RNG.pickWeightedPairs(unusedOptions)
	optionsUsed.append(option)
	setState(option)
	return option

func _react(_action: String, _args):
	var npc: BaseCharacter = GlobalRegistry.getCharacter(npcID)
	var pcInventory = GM.pc.getInventory()
	npc = npc #dont bother me godot
	
	if(doneWhenIterations == -1):
		doneWhenIterations = RNG.randi_range(2,4)
	
	if(_action == "pick_subscene"):
		_action = pickSubscene()
	
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == ""):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		GM.pc.addLust(RNG.randi_range(3,6))
		processTime(1 * 60)
			
	if(_action == "stripped"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		GM.pc.addLust(RNG.randi_range(3,6))
		processTime(1 * 60)
		strippedItemID = pcInventory.getEquippedItem(InventorySlot.Body).id
		pcInventory.unequipSlot(InventorySlot.Body)
		gotStripped = true

	if(_action == "cuffs_wrists_post"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		GM.pc.addLust(RNG.randi_range(3,6))
		processTime(1 * 60)
		var cuff
		if(npcVariation == "mean"):
			cuff = GlobalRegistry.createItem("inmatewristcuffs")   #meanies always use the real deal
		elif(npcVariation == "kind"):
			cuff = GlobalRegistry.createItem("ImaginaryWristCuffs") #kind inmates always fake it
		else:
			cuff = GlobalRegistry.createItem("inmatewristcuffs") if RNG.chance(35) else GlobalRegistry.createItem("ImaginaryWristCuffs")
		pcInventory.forceEquipStoreOther(cuff) #just in case, though its checked to be empty earlier.
		_action = pickSubscene()
		
	if(_action == "cuffs_ankles_post"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		GM.pc.addLust(RNG.randi_range(3,6))
		processTime(1 * 60)
		var cuff
		if(npcVariation == "mean"):
			cuff = GlobalRegistry.createItem("inmateanklecuffs")   #meanies always use the real deal
		elif(npcVariation == "kind"):
			cuff = GlobalRegistry.createItem("ImaginaryAnkleCuffs") #kind inmates always fake it
		else:
			cuff = GlobalRegistry.createItem("inmateanklecuffs") if RNG.chance(35) else GlobalRegistry.createItem("ImaginaryAnkleCuffs")
		pcInventory.forceEquipStoreOther(cuff) #just in case, though its checked to be empty earlier.
		_action = pickSubscene()

	if(_action == "bodywriting"):
		GM.pc.addLust(RNG.randi_range(3,6))
		
	if(_action == "bodywriting_2"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(5,10))
		GM.pc.addLust(RNG.randi_range(5,10))
		processTime(1 * 60)
		lastBodywritingZone = BodyWritingsZone.getRandomZone()
		if(npcVariation == "subby"):
			lastBodywritingID = RNG.pick(["cute","cutie","lessthanthree","cutefacesymbol"])
		elif(npcVariation == "kind"):
			lastBodywritingID = RNG.pick(["makemecum","publictoy","publicpet","submissive","subby","lessthanthree"])
		elif(npcVariation == ""):
			lastBodywritingID = RNG.pick(["useme","freeuse","stripme","slave","slut","publictoy","publicpet","submissive","subby","subbyslut"])
		elif(npcVariation == "mean"):
			lastBodywritingID = BodyWritings.getRandomWritingIDForZone(lastBodywritingZone)
		GM.pc.addBodywriting(lastBodywritingZone, lastBodywritingID, false, npcID)
		
	if(_action == "kneel"):
		GM.pc.addLust(RNG.randi_range(5,10))
		
	if(_action == "kneel_2"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(5,10))
		GM.pc.addLust(RNG.randi_range(5,10))
		processTime(1 * 60)
		
	if(_action == "punch"):
		GM.pc.addLust(RNG.randi_range(3,6))
		GM.pc.addPain(RNG.randi_range(4,10))
		
	if(_action == "punch_2"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(5,10))
		GM.pc.addLust(RNG.randi_range(3,6))
		GM.pc.addPain(RNG.randi_range(12,25))
		processTime(1 * 60)
	
	if(_action == "tease"):
		GM.pc.addLust(RNG.randi_range(5,10))
		
	if(_action == "tease_2"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(5,10))
		GM.pc.addLust(RNG.randi_range(5,10))
		processTime(1 * 60)

	if(_action == "hands_free_orgasm"):
		GM.pc.addLust(RNG.randi_range(10,15))
		
	if(_action == "hands_free_orgasm_2"):
		GM.pc.addLust(RNG.randi_range(15,20))
		
	if(_action == "hands_free_orgasm_3"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(20,30))
		GM.pc.cumOnFloor()
		GM.pc.addArousal(-1.0)
		GM.pc.addLust(-int(GM.pc.getLust()/2.0))
		processTime(2 * 60)
		
	if(_action == "hands_free_orgasm_3_selfdeny"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(10,20))
		GM.pc.addArousal(-0.1)
		GM.pc.addLust(-10)
	
	if(_action == "finale"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		processTime(2 * 60)
		if(gotStripped and npcVariation != "mean"):
			var item = pcInventory.getFirstOf(strippedItemID)
			pcInventory.equipItem(item)
		GM.pc.addSkillExperience(Skill.Hypnosis, 10)
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	pass
	
func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npcVariation"] = npcVariation
	data["gotStripped"] = gotStripped
	data["strippedItemID"] = strippedItemID
	data["iterations"] = iterations
	data["doneWhenIterations"] = doneWhenIterations
	data["optionsUsed"] = optionsUsed
	data["lastBodywritingZone"] = lastBodywritingZone
	data["lastBodywritingID"] = lastBodywritingID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	gotStripped = SAVE.loadVar(data, "gotStripped", false)
	strippedItemID = SAVE.loadVar(data, "strippedItemID", "")
	iterations = SAVE.loadVar(data, "iterations", 0)
	doneWhenIterations = SAVE.loadVar(data, "doneWhenIterations", -1)
	optionsUsed = SAVE.loadVar(data, "optionsUsed", [])
	lastBodywritingZone = SAVE.loadVar(data, "lastBodywritingZone", "")
	lastBodywritingID = SAVE.loadVar(data, "lastBodywritingID", "")
