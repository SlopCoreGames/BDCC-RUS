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
				"This'll just get in the way.",
				"Take this off.",
				"Strip."
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("{npc.He} {npc.verb('grab')} хватает тебя за одежду и грубо притягивает к себе.")
			
			saynn("[say=npc]"+RNG.pick([
				"Take this off or I'll rip it off.",
				"Take this off. Now.",
				"Strip, slut."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("{npc.He} {npc.verb('brush', 'brushes')} стряхивает пыль с твоей одежды.")
			saynn("[say=npc]"+RNG.pick([
				"Why don't you take this off?",
				"You wouldn't mind stripping for me, right?",
				"Can you strip down for me?",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("{npc.He} {npc.verb('grip')} твою одежду, явно стремясь поскорее её снять.")
			saynn("[say=npc]"+RNG.pick([
				"Take these off, please?",
				"I want to see [i]all[/i] of your beatiful body!",
				"You've got nothing that needs hiding, handsome~",
			])+"[/say]")
			
		saynn("Не успеваешь ты оглянуться, как одежда сползает с тебя, пока ты...")
		HypnokinkUtil.addHypnoButtons(self, "stripped", "resist", ["Strip", "Remove"])
		
	if(state == "stripped"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты послушно замираешь, обнаженная и уязвимая как телом, так и разумом.")
		
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Raise your arms above your head.",
				"Hands up.",
				"Keep your arms above your head."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Arms above your head.",
				"Hands up, bitch.",
				"Keep your arms above your head."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"Arms above your head, if you could?",
				"Hands up, please.",
				"Could you keep your arms above your head?",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Can you please raise your arms? I want access to all of you~.",
				"Hands up please? I just wanna bury my face in that chest~",
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
				"Eyes forward. Dont move.",
				"You squirm too much.",
				"This'll keep you properly helpless."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("{npc.He} мучительно {npc.verb('squeeze')} твои "+limb+", зажимая на них что-то.")
			
			saynn("[say=npc]"+RNG.pick([
				"Eyes forward. Let me cuff you.",
				"This should help keep you still.",
				"A bit of bondage can be fun."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("{npc.He} нежно {npc.verb('squeeze')} твой "+limb+", зажимая на них что-то.")
			
			saynn("[say=npc]"+RNG.pick([
				"You like being restrained, don't you?",
				"I think you'd like to be a bit helpless~",
				"Are you a fan of cuffs?",
			])+"[/say]")
			
		saynn("Тщетно пытаясь оказать хоть какое-то сопротивление, ты...")
		HypnokinkUtil.addHypnoButtons(self, "cuffs_"+limb+"_post", "resist", ["Hold still", "Wince", "Whine"])
		
	if(state == "bodywriting"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID})
		saynn("{npc.He} {npc.verb('retrieve')} откуда-то черный маркер и с щелчком снимает колпачок.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Let's make it clear what you are.",
				"A little advertisement seems appropriate."
			])+"[/say]")
		
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Let's make you look like the slut you are.",
				"Whores should be labeled.",
				"Hold still, bitch."
			])+"[/say]")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"You don't mind if I leave a mark, right?",
				"You really need to advertise yourself~",
				"Just a little reminder...",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("[say=npc]"+RNG.pick([
				"You don't mind if I leave a mark, right?",
				"Just so you don't forget me~",
			])+"[/say]")
		
		saynn("Замирая изо всех сил, ты...")
		HypnokinkUtil.addHypnoButtons(self, "bodywriting_2", "resist", ["Hold still", "Wince", "Whine"])
		
	if(state == "bodywriting_2"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID})
		saynn("{npc.He} {npc.verb('draw')} [b]'"+str(BodyWritings.getWritingText(lastBodywritingID))+"'[/b] на твоем "+BodyWritingsZone.getZoneVisibleName(lastBodywritingZone)+".")
		
		saynn("[say=npc]"+RNG.pick([
			"Suits you.",
			"Nice.",
			"Looks great on you.",
		])+"[/say]")
		
		saynn("Не в силах сопротивляться, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Hold still", "Wait", "Whine"])
		
	if(state == "kneel"):
		#only subby version
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="kneel"})
		
		saynn("{npc.He} {npc.verb('kneel')} перед тобой, чтобы рассмотреть тебя поближе.")
		saynn("[say=npc]"+RNG.pick([
				"Ooh, I really want to play~",
				"I could make you feel so good...",
				"Mmm, I like what I see!"
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
				"What a lovely sight.",
				"I could just...",
				"So tempting~"
			])+"[/say]")
			
		saynn("{npc.He} со временем {npc.verb('rise')} встает на {npc.his} ноги, решая пока продолжить игру. Все еще сгорая от смущения, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Blush"])


	if(state == "punch"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="punch"})
		#only mean version
		saynn("Без всякого предупреждения, {npc.he} {npc.verb('sock')} тебя прямо в живот!")
		saynn("[say=npc]"+RNG.pick([
				"You'd make a good punching bag!",
				"Hold still, bitch.",
				"You're probably gonna enjoy this anyway."
			])+"[/say]")
		
		saynn("Вздрагивая от боли, ты...")
		HypnokinkUtil.addHypnoButtons(self, "punch_2", "resist", ["Hold still"])
	
	if(state == "punch_2"):
		playAnimation(StageScene.ArmsRaisedDuo, "idle", {npc=npcID, npcAction="punch"})
		#only mean version
		saynn("{npc.He} раз за разом {npc.verb('jab')} тебя в живот и грудь!")
		saynn("[say=npc]"+RNG.pick([
				"I should make this part of my workout routine.",
				"Bruises look good on you.",
				"Maybe I should hit harder. Crack some ribs."
			])+"[/say]")
		
		saynn("Весь в синяках, ты...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", ["Suffer", "Endure"])
		
	if(state == "hug"):
		playAnimation(StageScene.Hug, "hug", {npc=npcID})
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("{npc.He} внезапно {npc.verb('draw')} тебя в объятия" + ("." if GM.pc.hasBoundArms() else ", and you reflexively wrap your arms around {npc.him}."))
		
			saynn("[say=npc]"+RNG.pick([
				"I can be nice~",
				"You are being [i]very[/i] obedient..."
			])+"[/say]")
		#no mean version
		# (kind version)
		if(npcVariation == "kind"):
			saynn("{npc.He} нежно {npc.verb('draw')} тебя в объятия" + ("." if GM.pc.hasBoundArms() else ", and after a brief moment of hesitation, you wrap your arms around {npc.him}."))
			
			saynn("[say=npc]"+RNG.pick([
				"Good {pc.boy}...",
				"You're enjoying yourself, right?",
				"That's it, just relax...",
			])+"[/say]")
			
		# (subby version)
		if(npcVariation == "subby"):
			saynn("{npc.He} обвивает {npc.his} руками тебя" + (" and {npc.verb('nuzzle')} your chest." if GM.pc.hasBoundArms() else ". As {npc.he} {npc.verb('nuzzle')} your chest, you return the hug."))
			
			saynn("[say=npc]"+RNG.pick([
				"Mmm~",
				"This is okay, right?",
				"I want you all to myself...",
			])+"[/say]")
		
		saynn("Спустя некоторое время {npc.he} {npc.verb('let')} уходит. Ты послушно вскидываешь руки, даже не дожидаясь команды, и...")
		HypnokinkUtil.addHypnoButtons(self, "pick_subscene", "resist", [])
		
	if(state == "tease"):
		playAnimation(StageScene.ArmsRaisedSex, "tease", {npc=npcID})
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("{npc.He} медленно, дразняще {npc.verb('circle')} за твоей спиной. Ты вздрагиваешь, когда чувствуешь, как руки начинают исследовать всё твое тело.")
			
			saynn("[say=npc]"+RNG.pick([
				"You'd do just about anything to please me, hm?",
				"You are being [i]very[/i] obedient...",
			])+"[/say]")
			
		# (mean version)
		if(npcVariation == "mean"):
			saynn("{npc.He} {npc.verb('paces')} стоит позади тебя. Ты вздрагиваешь, когда чувствуешь, как руки начинают бесстыдно ощупывать всё твоё тело.")
			
			saynn("[say=npc]"+RNG.pick([
				"I could do [i]anything[/i] I want to you.",
				"That's it, slut. Squirm.",
				"You're all mine, and there's nothing you can do about it.",
			])+"[/say]")
			
		# (kind version)
		if(npcVariation == "kind"):
			saynn("{npc.He} медленно и дразняще {npc.verb('circle')} позади тебя. Ты вздрагиваешь, когда чувствуешь, как руки начинают нежно скользить по твоему телу.")
			
			saynn("[say=npc]"+RNG.pick([
				"Good {pc.boy}...",
				"Enjoying yourself? Yes you are...",
				"That's it, just relax...",
			])+"[/say]")
			
		# (no subby version)
		
		saynn("Когда {npc.he} {npc.verb('continue')} наклоняется, чтобы прошептать тебе на ухо, ты...")
		HypnokinkUtil.addHypnoButtons(self, "tease_2", "resist", ["Shiver", "Whine"])
		
	if(state == "tease_2"):
		playAnimation(StageScene.ArmsRaisedSex, "inside", {npc=npcID})
		saynn("{npc.He} наклоняется ещё ближе, почти касаясь твоих ушей.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			
			saynn("[say=npc]"+RNG.pick([
				"Maybe I'll just keep you to myself.",
				"We'll be doing this a lot more often, I promise you that.",
			])+"[/say]")
			
		# (mean version)
		if(npcVariation == "mean"):
			
			saynn("[say=npc]"+RNG.pick([
				"Gonna make you into my personal fuckpet.",
				"A slut like you should be used.",
				"You're gonna be my personal whore.",
			])+"[/say]")
			
		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("[say=npc]"+RNG.pick([
				"I can make you have a [i]very[/i] good time.",
				"So very submissive and obedient~",
				"Want to a good [i]toy[/i] for me?",
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
				"What a cute slut you are~",
				"Getting off on this, huh?",
				"Who said you could enjoy yourself?"
			])+"[/say]")
			
			saynn("Когда {npc.he} {npc.verb('continue')} начинает дразнить тебя, ты не можешь не...")
			
		if(npcVariation == "mean"):
			saynn("Когда твоя похоть и желание становятся очевидными, {npc.he} {npc.verb('wrest')} твои запястья за спиной.")
			
			saynn("[say=npc]"+RNG.pick([
				"I see you're getting off on this, bitch.",
				"Enjoying yourself, slut?",
				"Having fun? What a whore."
			])+"[/say]")
			
			saynn("Когда {npc.he} {npc.verb('continue')} начинает осыпать тебя словесными унижениями, ты не можешь не...")

		# (kind version)
		if(npcVariation == "kind"):
			
			saynn("Когда твоя похоть и вожделение становятся очевидными, {npc.he} {npc.verb('grab')} твои запястья, мягко отводя их за спину.")
			saynn("[say=npc]"+RNG.pick([
				"Aw, you're enjoying yourself~",
				"Now now, you want to be a good {pc.boy}, right?",
				"Let's make sure you do this right...",
			])+"[/say]")
			saynn("Пока {npc.he} {npc.verb('continue')} слова ободрения, ты не можешь удержаться от...")
			
		# (subby version)
		if(npcVariation == "subby"):
			
			saynn("Когда твоя похоть и вожделение становятся очевидными, {npc.he} мягко {npc.verb('guide')} тебя, заставляя убрать руки за спину.")
			saynn("[say=npc]"+RNG.pick([
				"Oh, you'll love this next part!",
				"You're having a lot of fun, I see~",
				"I know what'll make you feel good!",
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
				"Not a bad party trick.",
				"I can feel you shivering~",
				"Hah, it worked. No kidding."
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Easy, just like you are.",
				"Voice controlled fucktoy. I like it.",
				"Don't get used to it."
			])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"That's it, ride it out~",
				"Good {pc.boy}, {pc.name}! Very good!",
				"You look like you enjoyed that~",
			])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"That looks fun! I've got to learn how to do that.",
				"Aw, I'm jealous~",
				"I bet that feels real good...",
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
				"Not a bad party trick.",
				"I can feel you shivering~",
				"Hm. No kidding.",
				"What, all dry?"
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Easy, just like you are.",
				"Voice controlled fucktoy. I like it.",
				"Don't get used to it.",
				"Did you even actually cum? Whatever, I don't care."
			])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"That's it, ride it out~",
				"Good {pc.boy}, {pc.name}! Very good!",
				"You look like you enjoyed that~",
				"Aw, a dry orgasm? That's okay, you'll get it right next time, I'm sure."
			])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"I've got to learn how to do that.",
				"Aw, I'm jealous~",
				"I bet that feels pretty good...",
				"Can't manage it either? You'll get there, I'm sure."
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
		saynn("[say=pc]"+RNG.pick(["St-stop...", "W-wait...", "I don't...", "I can't-", "No!", "Please, I..."])+"[/say]")
		saynn("Тебя пробирает дрожь — ты почти на грани того, чтобы разрушить чары.")
		
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn("[say=npc]"+RNG.pick([
				"What?", 
				"What is it?", 
				"No, don't be like that..."
				])+"[/say]")
				
		if(npcVariation == "mean"):
			saynn("[say=npc]"+RNG.pick([
				"Know your place! Last chance.", 
				"How dare you.", 
				"Don't do something I'll make you regret."
				])+"[/say]")
			
		if(npcVariation == "kind"):
			saynn("[say=npc]"+RNG.pick([
				"Hm? Is there a problem?", 
				"Do you want to stop?", 
				"Did I push too hard?"
				])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc]"+RNG.pick([
				"Aw, are we not playing anymore?", 
				"No, don't stop yet...", 
				"Let's have just a little more fun?"
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
