extends SceneBase

var npcID = ""
var npcVariation = ""
var iterations = 0
var doneWhenIterations = -1
var gotGagged = false
var removedOtherGag = ""

func _init():
	sceneID = "HypnoEncounterKneel"

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
		# there is no subby version
		
func getSceneCreator():
	return "PTS + LewDevy"
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	var npc: BaseCharacter = GlobalRegistry.getCharacter(npcID)
	var dickWord = "{npc.cock}"
	if(!npc.hasPenis()):
		dickWord = "strapon"
	
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Solo, "kneel")
		
		# (default)
		if(!(npcVariation in ["mean", "kind"])):

			saynn("[say=npc]"+RNG.pick([
				"А теперь — на колени.",
				"Будь хорошей {pc.boy} и преклони колени перед мной.",
				"Встань на колени.",
				"Твое место — на коленях.",
				"На коленях ты будешь смотреться куда лучше."
			])+"[/say]")
			
			saynn("Ты медленно опускаешься на колени перед {npc.him}.")
			
			saynn("[say=npc]"+RNG.pick([
				"Я скоро вернусь. Жди здесь.",
				"А теперь — стой смирно.",
				"Жди прямо здесь.",
				"Никуда не уходи.",
			])+"[/say]")
			
			saynn("{npc.Name} разворачивается и уходит, оставляя тебя стоять на коленях на земле.")
			
		# (mean version)
		if(npcVariation == "mean"):

			saynn("[say=npc]"+RNG.pick([
				"А теперь — на колени.",
				"Будь хорошей игрушкой и встань на колени.",
				"На колени, сучка.",
				"На колени, шлюха.",
				"На колени, блядь.",
				"Твое место — на коленях.",
			])+"[/say]")
			
			saynn("{npc.He} {npc.verb('push', 'pushes')} тебя на колени.")

			saynn("[say=npc]"+RNG.pick([
				"Жди здесь, если не хочешь проблем.",
				"Даже не вздумай куда-то уходить.",
				"А теперь сиди смирно, шлюшка.",
				"Будь послушным питомцем и стой прямо здесь.",
				"Не смей двигаться, иначе пожалеешь.",
			])+"[/say]")
			
			saynn("{npc.Name} разворачивается и вальяжно уходит.")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Будешь хорошей {pc.boy} и встанешь предо мной на колени?",
				"Разве тебе не хочется опуститься передо мной на колени?",
				"Будь паинькой и встань на колени.",
				"Встань на колени, пожалуйста.",
			])+"[/say]")
			
			saynn("Ты чувствуешь непреодолимое желание подчиниться, когда {npc.he} мягко направляет тебя на колени.")
				
			saynn("[say=npc]"+RNG.pick([
				"Я вернусь быстрее, чем ты успеешь моргнуть, идет?",
				"Вернусь через мгновение!",
				"А теперь просто жди здесь...",
				"И не вздумай уйти, пока меня нет!",
				"Будь послушной и жди меня здесь."
			])+"[/say]")
			
			saynn("{npc.He} {npc.verb('shoot')} тебе улыбку и {npc.verb('run')} куда-то прочь.")
			
		# (subby version)
		# there is no subby version
			
		saynn("Ты вовсе не [i]должен[/i] подчиняться. Тебе, наверное, стоит просто встать, но тебе хочется исполнить приказ {npc.his} и...")
		HypnokinkUtil.addHypnoButtons(self, "kneel", "resist", ["Kneel", "Remain", "Stay", "Not move"], ["Get up", "Resist", "Stand"])
			
		
	if(state == "kneel"):
		removeCharacter(npcID)
		playAnimation(StageScene.Solo, "kneel")
		
		saynn(RNG.pick([
				"Ты остаешься на коленях.",
				"Ты могла бы встать и уйти в любой момент, но продолжаешь стоять на коленях.",
				"Ты опускаешься на колени.",
				"Ты остаешься на коленях.",
				"Кажется, ты никак не можешь подняться.",
			]))
		
		saynn(RNG.pick([
				"Почему ты всё еще здесь? Тебе стоит встать и идти дальше, но ты...",
				"В любой момент ты могла бы...",
				"Сейчас. Самое время...",
				"Ты хочешь быть послушной {pc.boy} для {npc.him} и...",
				"Тебе действительно стоит просто...",
			]))
			
		HypnokinkUtil.addHypnoButtons(self, "kneel", "resist", ["Kneel", "Remain", "Stay", "Not move"], ["Get up", "Resist", "Stand"])
	
	if(state == "kneeled_enough"):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "kneel", {npc=npcID})
		
		saynn("{npc.Name} наконец возвращается.")
	
		# (default)
		if(!(npcVariation in ["mean", "kind"])):

			saynn("[say=npc]"+RNG.pick([
				"Всё еще здесь? Хорошая {pc.boy}.",
				"Ты довольно глубоко зашла, а?",
				"Вижу, ты умеешь сидеть смирно."
			])+"[/say]")
			
			
			if(!(GM.pc.buffsHolder.hasBuff(Buff.RingGagBuff))):
				saynn("{npc.He} {npc.verb('dangle')} набор ремней, прикрепленных к металлическому кольцу перед тобой.")
				saynn("[say=npc]Я принесла тебе небольшой подарок.[/say]")
				if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)):
					saynn("{npc.He} {npc.verb('remove')} — это твой нынешний кляп.")
					saynn("[say=npc]Он бы только мешался. Тебе повезло.[/say]")
				saynn("{npc.He} {npc.verb('grab')} берет тебя за челюсть.")
				saynn("[say=npc]Открой рот.[/say]")
				saynn("Может, ты всё ещё могла бы остановиться, но тебе хочется быть послушной только для {npc.him}, и поэтому ты...")
				HypnokinkUtil.addUnresistableHypnoButtons(self, "get_gagged", ["Open", "Open up"])
			else:
				saynn("{npc.He} {npc.verb('look')} нависает над тобой.")
				saynn("[say=npc]Нужно было кое-чем заняться. Но теперь у меня полно времени для моего питомца.[/say]")
				saynn("{npc.He} {npc.verb('grab')} берет тебя за челюсть.")
				saynn("[say=npc]Я заставлю твой ротик поработать на славу.[/say]")
				saynn("Может, ты всё ещё могла бы остановиться, но тебе хочется быть послушной только для {npc.him}, и поэтому ты...")
				HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_1", ["Whimper", "Get ready", "Gulp"])
			
		# (mean version)
		if(npcVariation == "mean"):

			saynn("[say=npc]"+RNG.pick([
				"Знала, что ты еще та сучка.",
				"Все еще здесь? Хорошая зверушка.",
				"Хех. Ну ты и шлюшка.",
			])+"[/say]")
			
			if(!(GM.pc.buffsHolder.hasBuff(Buff.RingGagBuff))):
				saynn("{npc.He} {npc.verb('dangle')} набор ремней, прикрепленных к металлическому кольцу перед тобой.")
				saynn("[say=npc]Таким шлюхам, как ты, болтать необязательно.[/say]")
				if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)):
					saynn("{npc.He} грубо дёргает за {npc.verb('remove')} твой нынешний кляп.")
					saynn("[say=npc]Какой толк от кляпа, если я не могу использовать твою глотку как следует?[/say]")
				saynn("{npc.He} {npc.verb('grab')} хватает тебя за челюсть, явно намереваясь силой разжать её.")
				saynn("[say=npc]Открывай рот, или я заставлю тебя.[/say]")
				saynn("Ты попыталась бы сопротивляться, но манера {npc.nameS} настолько властная, что ты просто...")
				HypnokinkUtil.addUnresistableHypnoButtons(self, "get_gagged", ["Open", "Open up"])
			else:
				saynn("{npc.He} {npc.verb('look')} нависает над тобой.")
				saynn("[say=npc]Убедился, что нам не помешают. А теперь...[/say]")
				saynn("{npc.He} {npc.verb('grab')} берет тебя за челюсть.")
				saynn("[say=npc]Я буду использовать твою глотку, пока ты не начнёшь задыхаться.[/say]")
				saynn("На этом этапе ты хочешь открыть рот только для того, чтобы {npc.him} и попробовать на вкус {npc.his}"+dickWord+". Ты высовываешь язык для {npc.him} и...")
				HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_1", ["Whimper", "Get ready", "Gulp"])
				
		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Какая послушная {pc.boy}!",
				"Прямо там, где я тебя оставила.",
				"Оу, все еще ждешь меня? Умница, {pc.boy}!",
				"Я вернулась! Скучала?",
			])+"[/say]")
			
			saynn("[say=npc]Если будешь послушной, я приготовила для тебя небольшой приз.[/say]")
			if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth) && !(GM.pc.buffsHolder.hasBuff(Buff.RingGagBuff))):
				saynn("{npc.He}осторожно {npc.verb('remove')} твой кляп.")
				saynn("[say=npc]Не хочется же, чтобы он тебе мешал, верно?[/say]")
			saynn("{npc.He} {npc.verb('cup')} твою челюсть в {npc.his} руке.")
			saynn("[say=npc]А теперь давай заставим твой ротик поработать, м?[/say]")
			
			saynn("Ты ведь знаешь, что можешь остановиться в любой момент, но тебе просто не [i] хочется[/i]. На самом деле ты просто хочешь открыть рот и...")
			HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_1", ["Nod", "Get ready", "Gulp"])
			
		# (subby version)
		# there is no subby version
	
	if(state == "get_gagged"):
		playAnimation(StageScene.Duo, "kneel", {npc=npcID})
		
		# (default)
		if(!(npcVariation in ["mean"])):
			saynn("{npc.He} {npc.verb('buckle')} кольцо-кляп между зубами.")
			saynn("[say=pc]Ннх...[/say]")
			saynn("[say=npc]Безопасность превыше всего~[/say]")
			saynn("{npc.He} {npc.verb('reach', 'reaches')} вниз, к {npc.his} промежности.")
			saynn("[say=npc]А теперь за работу.[/say]")
			saynn("Тебе действительно стоит остановиться. Но вместо этого ты готовишь рот и высовываешь язык — ты вовсе не [i] хочешь[/i] прекращать, ты хочешь...")
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn("{npc.He} грубо {npc.verb('wrap')} затягивает ремни вокруг твоей головы, плотно фиксируя кольцо-кляп между зубами.")
			saynn("[say=pc]Ннх! Не... так туго...[/say]")
			saynn("[say=npc]Как будто я доверяю сучке, что она не укусит.[/say]")
			saynn("{npc.He} {npc.verb('reach', 'reaches')} вниз, к {npc.his} промежности.")
			saynn("[say=npc]Я буду использовать твою глотку, пока ты не начнёшь задыхаться.[/say]")
			saynn("На этом этапе ты хочешь только одного: чтобы тебе {npc.him} использовали рот и позволили почувствовать вкус {npc.his}"+dickWord+". Ты высовываешь язык для {npc.him}, смотришь на {npc.him} умоляющим взглядом и...")
					
		# (kind version)
		# there is no kind version
			
		# (subby version)
		# there is no subby version
		
		HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_1", ["Whimper", "Get ready", "Gulp"])
		
	if(state == "get_fucked_oral_1"):
		var sucking = true
		
		if(!(npcVariation in ["mean", "kind"])):
			if(npc.hasPenis()):
				saynn("{npc.He} {npc.verb('place')} {npc.his} "+dickWord+" прямо перед твоим ртом, совершенно не заботясь о твоем комфорте, с силой втискивается внутрь. {npc.His}"+dickWord+" легко скользит по твоему языку и уже через несколько мгновений упирается в заднюю стенку горла.")
				saynn("[say=npc]"+RNG.pick([
					"Не останавливайся, ты можешь лучше.",
					"Открой ротик пошире, шлюшка~",
					"Всё будет куда глубже, чем это.",
					"Будь послушной и заглоти поглубже для меня."
					])+"[/say]")
				saynn("Твой разум погружается в океан покорности. Ты жаждешь продолжать пробовать на вкус {npc.his}"+dickWord+", это так приятно...")
			else:
				saynn("{npc.He} {npc.verb('place')} {npc.his} подставляет свою мокрую киску прямо перед твоим ртом, совершенно не заботясь о твоем комфорте, и {npc.verb('clamp')} твою голову между своих {npc.his} бедер. Поняв намек, ты высовываешь язык и начинаешь слизывать влагу.")
				saynn("[say=npc]"+RNG.pick([
					"Ещё. Ты можешь лучше.",
					"Работай язычком, сучка~",
					"Я сделаю тебя своей личной игрушкой.",	
					])+"[/say]")
				saynn("Твой разум погружается в океан покорности. Тебе хочется продолжать пробовать {npc.his} киску, это так приятно...")
				sucking = false
				
		# (mean version)
		if(npcVariation == "mean"):
			#always uses strapon
			saynn("Не теряя ни секунды, {npc.he} {npc.verb('thrust')} {npc.his} "+dickWord+"прямо тебе в рот. Не тратя времени впустую, {npc.he} {npc.verb('begin')} начинает вколачивать свой член тебе в лицо, с каждым толчком заталкивая его всё глубже в твое горло.")
			saynn("[say=npc]"+RNG.pick([
				"Давись им, сука.",
				"Принимай глубоко, шлюшка.",
				"Сидит как влитой. Я прав, питомец?",
				"Теперь ты моя личная дырка для траха."
				])+"[/say]")
			saynn("Ты чувствуешь, как {npc.his} "+dickWord+"скользит в твоем рту, а нити слюны стекают на пол. Твой разум сдается под натиском удовольствия, когда ты...")
				
		# (kind version)
		if(npcVariation == "kind"):
			if(npc.hasPenis()):
				saynn("{npc.He} осторожно {npc.verb('position')} {npc.his} "+dickWord+"перед твоим ртом, и медленно, нежно {npc.verb('push', 'pushes')} вводит его, давая тебе массу времени, чтобы ласкать его языком и наслаждаться вкусом. Когда {npc.he} {npc.isAre} удовлетворена, {npc.he} запускает пальцы в твои волосы на затылке, чтобы привлечь твое внимание.")
				saynn("[say=npc]"+RNG.pick([
					"Ты готова ко мне?",
					"А теперь давай зайдём чуть глубже.",
					"Ты ведь справишься, верно?",
					"А теперь широко~",
					"Сейчас будет...",
					])+"[/say]")
			else:
				saynn("{npc.He} {npc.verb('place')} {npc.his} подставляет свою мокрую киску перед твоим ртом и мягко {npc.verb('pulls')} твою голову между своих {npc.his} бедер. Поняв намек, ты высовываешь язык и начинаешь вылизывать {npc.his} влажные складки.")
				saynn("[say=npc]"+RNG.pick([
					"Сразу же принялась за дело, какая послушная {pc.boy}!",
					"Покажи мне, на что способен твой язычок.",
					"Очень хорошо, вот так...",
					])+"[/say]")
				sucking = false
			saynn("Ты пускаешь в ход язык. Твои мысли растворяются в блаженном послушании, и вскоре всё, что ты можешь — это...")
			
		# (subby version)
		# there is no subby version
		
		if(sucking):
			playAnimation(StageScene.SexOral, "sex", {pc= npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_2", ["Take it", "Gag", "Get fucked", "Suck"])
		else:
			playAnimation(StageScene.SexOral, "lick", {pc= npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_2", ["Lick"])
		
	if(state == "get_fucked_oral_2"):
		var sucking = true
		
		if(!(npcVariation in ["mean", "kind"])):
			if(npc.hasPenis()):
				saynn("Ты обретаешь подобие сознания, когда {npc.nameS} рука сжимает затылок.")
				saynn("[say=npc]"+RNG.pick([
					"Есть кто дома?",
					"Там совсем темно...",
					"Только не говори мне, что ты уже отключилась.",
					"Уходишь глубже? Я тоже!",
				])+"[/say]")		
				saynn("{npc.He} {npc.verb('pick')} темп, каждый толчок становится всё настойчивее. Пока кончик {npc.his} "+dickWord+"проникает всё глубже и глубже в твое горло, за ним следует приятное онемение, позволяющее принимать это с удивительной легкостью и без протеста. Где-то на подсознательном уровне ты понимаешь, что в какой-то момент тебе, вероятно, придется вдохнуть...")			
			else:
				saynn("{npc.He} {npc.verb('shiver')} и крепко {npc.verb('squeeze')} твою голову между {npc.his} {npc.masc} бедер, вжимая твое лицо так, что ты едва можешь дышать. Потерявшись в моменте, ты усердно облизываешь {npc.his} складки и сосешь {npc.his} клитор.")
				saynn("[say=npc]"+RNG.pick([
					"Ты... ты чертовски хороша в этом~",
					"О-о, прямо в точку!",
					"Только попробуй, блять, остановиться, сучка.",
					])+"[/say]")
				sucking = false	
			saynn("Ты просто не можешь остановиться! Ты хочешь и дальше быть хорошей {pc.boy} для {npc.him}! Ты хочешь...")
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn("Ты обретаешь подобие сознания, когда {npc.nameS} рука болезненно сжимает твой затылок.")
			saynn("[say=npc]"+RNG.pick([
				"Не вздумай отключаться, питомец.",
				"Я еще даже близко не закончил, шлюха.",
				"Эй, шлюха, не дрыхни на работе, соси давай!",
				"Будь хорошей сучкой и работай языком!",
			])+"[/say]")
			saynn("Ты чувствуешь, как {npc.him} заходит еще глубже, чем прежде. Тебе нравится ощущение того, что тебя используют исключительно для [i]{npc.his}[/i] удовольствия. Ты могла бы это прекратить, но ты хочешь быть хорошей сучкой для {npc.him}, ты хочешь...")
				
		# (kind version)
		if(npcVariation == "kind"):
			if(npc.hasPenis()):
				saynn("Ты обретаешь подобие сознания, когда {npc.nameS} рука поглаживает твой затылок.")
				saynn("[say=npc]"+RNG.pick([
					"Просыпайся, соня...",
					"Ну же, не отключайся прямо на мне.",
					"Ты в порядке? Хочешь продолжать, да?",
					"Похоже, тебе весело~",
				])+"[/say]")
				saynn("{npc.He} {npc.verb('pick')} темп, каждый толчок становится всё настойчивее. Пока кончик {npc.his} "+dickWord+"проникает всё глубже и глубже в твое горло, за ним следует приятное онемение, позволяющее принимать это с удивительной легкостью и без протеста. Где-то на подсознательном уровне ты понимаешь, что в какой-то момент тебе, вероятно, придется вдохнуть...")
			else:
				saynn("{npc.He} {npc.verb('shiver')} и крепко {npc.verb('squeeze')} твою голову между {npc.his} {npc.masc} бедер, вжимая твое лицо так, что ты едва можешь дышать. Потерявшись в моменте, ты усердно облизываешь {npc.his} складки и сосешь {npc.his} клитор.")
				saynn("[say=npc]"+RNG.pick([
						"А ты неплохо справляешься~",
						"О-о, прямо в точку!",
						"П-продолжай, вот так же.",
					])+"[/say]")
				sucking = false
			saynn("Ты просто не можешь остановиться! Ты хочешь и дальше быть хорошей {pc.boy} для {npc.him}! Ты хочешь...")
			
		# (subby version)
		# there is no subby version
		
		if(sucking):
			playAnimation(StageScene.SexOral, "fast", {pc= npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_3", ["Take it", "Gag", "Get fucked", "Suck", "Swallow"])
		else:
			playAnimation(StageScene.SexOral, "grind", {pc= npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
			HypnokinkUtil.addUnresistableHypnoButtons(self, "get_fucked_oral_3", ["Lick"])
		
	if(state == "get_fucked_oral_3"):
		
		if(!(npcVariation in ["mean", "kind"])):
			if(npc.hasPenis()):
				saynn("[say=npc]"+RNG.pick([
					"Я сейчас...",
					"Приготовься...",
					"Нннх! Глотай для меня!",
				])+"[/say]")
				saynn("Края твоего зрения начинают расплываться. {npc.He} {npc.verb('grip')} твою голову, и последним мощным толчком он кончает тебе прямо в глотку. Покорно ты сглатываешь, пока {npc.he} {npc.verb('pump')} глубоко внутри тебя; всё происходит почти механически, ты инстинктивно заглатываешь каждую каплю. Прямо перед тем, как ты теряешь сознание от нехватки воздуха, {npc.name} наконец {npc.verb('pull')}. Ты остаешься тяжело дышать, всё еще стоя на коленях и выглядя как жадная шлюшка, а остатки спермы стекают с твоего языка.")	
			else:
				saynn("[say=npc]"+RNG.pick([
					"Ах! Т-ты меня сейчас доведешь!",
					"Так держать! Я сейчас кончу!",
					"Готовься, я сейчас кончу!",
				])+"[/say]")
				saynn("Ты готовишься, когда {npc.he} {npc.verb('grip')} твою голову, вжимая тебя в {npc.his} похотливую влажность, пока {npc.he} {npc.verb('cum')} наотмашь. {npc.His} соки вливаются тебе в глотку, а несколько капель вырываются по краям твоего кляпа; {npc.name} крепко сжимает затылок, пока {npc.he} {npc.verb('orgasm')}, оставляя тебя тяжело дышащей и жаждущей добавки...")	
			saynn("Ты сделала это! Надеешься, что была хорошей {pc.boy} для {npc.him}, проглотив всю эту вкусную влагу, пока ты продолжаешь...")		
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Охуеть! Твой рот-писька меня сейчас сведет с ума!",
				"...",
				"Готова принять мой груз, тупая ты кукла?",
				"А теперь будь хорошей сучкой в течке и доведи меня до конча!",
				"Принимай всё до последней капли, шлюха!",
				"Я заставлю тебя умолять о добавке!",
			])+"[/say]")
			if(npc.hasPenis()):
				saynn("У тебя почти нет времени подготовиться, как {npc.he} {npc.verb('shove')} {npc.his} "+dickWord+" так глубоко в твой рот, насколько он физически может, отчего твои глаза закатываются, когда ты чувствуешь, как {npc.his} член начинает пульсировать, посылая одну волну спермы за другой глубоко в твою глотку. Ты инстинктивно всё заглатываешь — ты хочешь удовлетворить {npc.him}.")	
			else:
				saynn("Ты чувствуешь, как сознание слегка уплывает, когда {npc.he} {npc.verb('push', 'pushes')} {npc.his} заталкивает тебе глубоко в глотку, заставляя давиться. Пока твое лицо вжато в {npc.his} промежность, {npc.he} наконец {npc.verb('explode')}, и {npc.his} соки текут по твоим щекам, а {npc.his} дрожащий оргазм заставляет твою голову вибрировать.")	
			saynn("Проходит мучительно долгое мгновение, прежде чем {npc.he} {npc.verb('decide')}, чтобы наконец вытащить стрэп-он и дать тебе глотнуть драгоценного воздуха.")
			saynn("Ты смотришь на {npc.him} с похотливым выражением лица, все еще приходя в себя после этого выносящего мозг опыта. Ты не хотел, чтобы {npc.him} прекращалась. Тебе хотелось...")
			
		# (kind version)
		if(npcVariation == "kind"):
			if(npc.hasPenis()):
				saynn("[say=npc]"+RNG.pick([
					"Сглотни для меня, красавица~",
					"Готовься принять всё подчистую!",
					"Ах! Я сейчас кончу, готовься!",
				])+"[/say]")
				saynn("Края твоего зрения начинают расплываться. {npc.He} {npc.verb('grip')} прижимает твою голову крепче и последним мощным толчком {npc.verb('cum')} вгоняет прямо тебе в глотку. Послушно ты сглатываешь, когда {npc.he} {npc.verb('pump')} глубоко в тебя; это движение почти механическое — ты инстинктивно заглатываешь каждую каплю. Стараясь не дать тебе отключиться от нехватки воздуха, {npc.name} быстро вытаскивает стрэп-он. Ты остаешься тяжело дышать, все еще стоя на коленях и выглядя как изрядно использованный питомец, с остатками спермы, стекающими с твоего языка.")
			else:
				saynn("[say=npc]"+RNG.pick([
					"Ааа! Ты чертовски приятная!",
					"Готовься принять всё до капли!",
					"Ах! Сейчас кончу!",
				])+"[/say]")
				saynn("Ты готовишься, пока {npc.he} {npc.verb('grip')} твою голову, вжимая тебя в {npc.his} похотливую влагу, пока {npc.he} {npc.verb('cum')} твердеет. {npc.His} соки заставляют глотать, пара капель вырывается из уголков твоего кляпа, {npc.name} поглаживая затылок, пока {npc.he} {npc.verb('orgasm')}, пока наконец ты не остаешься тяжело дышащей и жаждущей добавки...")	
			saynn("Ты сделала это! Надеюсь, ты была хорошей {pc.boy} для {npc.him}, проглотив всю эту вкусную влагу. Ты смотришь вверх на {npc.him}, на твоем лице читается полная покорность, пока ты продолжаешь...")	
			
		# (subby version)
		# there is no subby version	
		
		playAnimation(StageScene.SexOral, "start", {pc= npcID, npc="pc", bodyState={exposedCrotch=true, hard=true}})
		HypnokinkUtil.addUnresistableHypnoButtons(self, "oral_afterward")
		
	if(state == "oral_afterward"):
		playAnimation(StageScene.Duo, "kneel", {npc=npcID})
		
		if(!(npcVariation in ["mean", "kind"])):
			if(gotGagged):
				saynn("[say=npc]А теперь я заберу кляп...[/say]")
				saynn("{npc.He} {npc.verb('unbuckle')} кольцевой кляп. Ты несколько раз разминаешь челюсть.")
				if(removedOtherGag):
					saynn("[say=npc]Но этот можешь забрать себе.[/say]")
					saynn("{npc.He} {npc.verb('replace')} его своим предыдущим.")
			saynn("[say=npc]Это было весело. Нам стоит повторить это как-нибудь еще.[/say]")
			saynn("Затем {npc.he} {npc.verb('walk')} прочь, оставляя тебя на коленях, пускающую слюни с похотливым и удовлетворенным выражением лица.")
			saynn("Спустя некоторое время ты с трудом поднимаешься на дрожащих ногах, а остатки твоего влажного приключения всё еще стекают по подбородку.")
			
		# (mean version)
		if(npcVariation == "mean"):
			if(removedOtherGag):
				saynn("[say=npc]Можешь забрать это обратно.[/say]")
				saynn("{npc.He} {npc.verb('remove')} лишь для того, чтобы заменить его на твой прежний.")
			elif(gotGagged):
				saynn("[say=npc]Кляп можно оставить.[/say]")
				saynn("{npc.He} {npc.verb('grin')} злорадно, пока {npc.he} еще раз затягивает пряжки.")
			saynn("Теперь удовлетворенная, {npc.he} {npc.verb('strut')}, оставляя тебя стоять на коленях с выражением ошеломленного наслаждения на лице. В конце концов ты замечаешь, что твой язык всё еще высунут, и убираешь его.")
			saynn("Проходит немало времени, прежде чем ты с трудом поднимаешься на дрожащих ногах, всё еще находясь под влиянием {npc.his} властного, commanding присутствия.")
				
		# (kind version)
		if(npcVariation == "kind"):
			saynn("[say=npc]Аах~ Нам стоит повторить это как-нибудь еще. О, и прежде чем я забуду...[/say]")
			saynn("{npc.He} {npc.verb('hand')} тебе кредитный чип.")
			saynn("Подмигнув, {npc.he} {npc.verb('walk')}, оставляя тебя всё еще на коленях.")
			saynn("Требуется несколько мгновений, прежде чем ты осознаешь, что можешь встать, а твои мысли всё еще заняты {npc.nameS} сильным ароматом.")
			
		# (subby version)
		# there is no subby version	
		
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "resist"):
		saynn("Ты начинаешь подниматься, находясь на грани того, чтобы разрушить чары.")
		saynn("[say=pc]"+RNG.pick([
			"Погоди, что я...", 
			"Где я...", 
			"Почему я...", 
			"Погоди-ка...", 
			"Но почему это я должен..."
			])+"[/say]")
		
		saynn("Но теперь, когда ты знаешь, что [i]можешь[/i] уйти, тебе действительно стоит просто...")
		HypnokinkUtil.addHypnoButtons(self, "kneel", "resist_2", ["Kneel", "Remain", "Stay", "Not move"], ["Get up", "Resist", "Stand"])
	if(state == "resist_2"):
		removeCharacter(npcID)
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Тебе удается стряхнуть оцепенение и заставить себя подняться на ноги. Лучше уходить, пока {npc.name} не вернулся(ась).")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")

func _react(_action: String, _args):
	var npc: BaseCharacter = GlobalRegistry.getCharacter(npcID)

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "kneel"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		processTime(5 * 60)
		if(doneWhenIterations == -1):
			doneWhenIterations = RNG.randi_range(3,6)
		iterations += 1
		if(iterations >= doneWhenIterations):
			setState("kneeled_enough")
			return
			
	if(_action == "get_gagged"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(2,6))
		processTime(1 * 60)
		GM.pc.addLust(RNG.randi_range(2,6))
		if(GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)):
			var preexistingGag = GM.pc.getInventory().removeItemFromSlot(InventorySlot.Mouth)
			removedOtherGag = preexistingGag.id
		GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("ringgag"))
		gotGagged = true
		
	if(_action == "get_fucked_oral_1"):
		GM.pc.addLust(RNG.randi_range(10,15))
		if(npcVariation == "kind" && GM.pc.getInventory().hasSlotEquipped(InventorySlot.Mouth)):
			GM.pc.getInventory().removeItemFromSlot(InventorySlot.Mouth)
		if(!npc.hasPenis() && npcVariation == "mean"):
			npc.getInventory().equipItem(GlobalRegistry.createItem("StraponFeeldoe"))
			npc.getInventory().removeItemFromSlot(InventorySlot.UnderwearBottom)
		
	if(_action == "get_fucked_oral_2"):
		GM.pc.addLust(RNG.randi_range(10,15))
		
	if(_action == "get_fucked_oral_3"):
		GM.pc.addLust(RNG.randi_range(20,25))
		if(npc.hasPenis()):
			GM.pc.cummedInMouthBy(npcID)
		else:
			if(npcVariation == "mean"):
				npc.cumOnFloor()
			else:
				GM.pc.cummedInMouthBy(npcID, FluidSource.Vagina)
				
	if(_action == "oral_afterward"):
		HypnokinkUtil.changeSuggestibilityBy(GM.pc, RNG.randi_range(20,30))
		processTime(10 * 60)
		if(removedOtherGag != ""):
			GM.pc.getInventory().removeEquippedItemsWithBuff(Buff.RingGagBuff)
			GM.pc.getInventory().equipItem(GlobalRegistry.createItem(removedOtherGag))
		else:
			if(npcVariation != "mean" && gotGagged):
				GM.pc.getInventory().removeEquippedItemsWithBuff(Buff.RingGagBuff)		
		if(npcVariation == "kind"):
			GM.pc.addCredits(1)
		GM.pc.addSkillExperience(Skill.Hypnosis, 10)
		
		
	if(_action == "resist"):
		pass

	setState(_action)


func _react_scene_end(_tag, _result):
	pass

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npcVariation"] = npcVariation
	data["iterations"] = iterations
	data["doneWhenIterations"] = doneWhenIterations
	data["gotGagged"] = gotGagged
	data["removedOtherGag"] = removedOtherGag
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	iterations = SAVE.loadVar(data, "iterations", 0)
	doneWhenIterations = SAVE.loadVar(data, "doneWhenIterations", -1)
	gotGagged = SAVE.loadVar(data, "gotGagged", false)
	removedOtherGag = SAVE.loadVar(data, "removedOtherGag", "")

