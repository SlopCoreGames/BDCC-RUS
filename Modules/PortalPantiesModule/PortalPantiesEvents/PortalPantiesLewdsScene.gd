extends "res://Scenes/SceneBase.gd"

var cockType = "canine"
var npcID = ""

func _init():
	sceneID = "PortalPantiesLewdsScene"

func _reactInit():
	cockType = RNG.pick([
		"canine",
		"feline",
		"dragon",
		"equine",
		"generic",
	])

	var possible = [
		"anal",
	]
	if(GM.pc.hasVagina()):
		possible.append("vaginal")
	if(GM.pc.hasPenis() && !GM.pc.isWearingChastityCage() && !GM.pc.hasReachablePenis()):
		possible.append("cock")
		possible.append("cock")

	setState(RNG.pick(possible))
	
	if(state == "cock"):
		setState(RNG.pick([
			"cockSuck",
			"cockTeaseThighs",
			"cockVaginal",
			"cockAnal",
			"cockCondom",
			"cockStroking",
			"cockWarming",
		]))
	
	if(state in ["anal", "vaginal"]):
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [[NpcCon.HasPenis], [NpcCon.NoChastity]], InmateGenerator.new(), {NpcGen.HasPenis: true, NpcGen.NoChastity: true})
	elif(state in ["cockTeaseThighs", "cockVaginal", "cockCondom"]):
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [[NpcCon.HasReachableVagina]], InmateGenerator.new(), {NpcGen.HasVagina: true})
	else:
		npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {})
	if(npcID == null || npcID == ""):
		npcID = "inmateMaleCanine"
	GM.main.updateCharacterUntilNow(npcID)
	
	var theChar:BaseCharacter = getCharacter(npcID)
	if(theChar != null):
		if(theChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisRidges)):
			cockType = "dragon"
		elif(theChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisFlare)):
			cockType = "equine"
		elif(theChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisBarbs)):
			cockType = "feline"
		elif(theChar.bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisKnot)):
			cockType = "canine"
		else:
			cockType = "generic"
		
	GM.pc.addCredits(1)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():

	if(state == "vaginal"):
		playAnimation(StageScene.SexPortal, RNG.pick(["sex", "fast"]), {pc=npcID, npc="pc", bodyState={exposedCrotch=true,hard=true}})
		
		# (if has pussy)
		if(cockType == "canine"):
			saynn(RNG.pick([
				"A canine cock is brushing against your pussy folds before finding the pussy hole and sliding inside! You feel the knot slapping against your slit as they try to shove it in too.",
				"Oh, you were busy with something when a knotted canine cock decided to penetrate your pussy through the portal panties!",
				"A gasp escapes from your lips as you feel your private pussy folds get spread by a canine cock, someone has found the fleshlight!",
			]))
		if(cockType == "feline"):
			saynn(RNG.pick([
				"Someone’s cock suddenly gets thrusted into your pussy slit! It has barbs, causing you to let out a muffled noise of surprise.",
				"Some person has found a fleshlight with your pussy sticking out and decided to shove their feline cock in! You feel the barbs brushing against your soft flesh.",
				"A barbed feline cock gets shoved into your {pc.pussyStretch} pussy, spreading its folds! You try to find a good spot nearby to wait it out.",
			]))
		if(cockType == "dragon"):
			saynn(RNG.pick([
				"A dragon cock teasingly grinds against your pussy folds, letting you feel its ribbed texture, before roughly thrusting inside!",
				"Your lips let out a moan as a dragon cock finds your pussy and starts fucking you raw!",
				"Someone’s cock rubs against your pussy before stretching it open and sliding inside! You feel its rubbed texture massaging your soft inner walls.",
			]))
		if(cockType == "equine"):
			saynn(RNG.pick([
				"A bulky flared cock’s tip is suddenly putting pressure on your {pc.pussyStretch} pussy! You don’t believe that it will fit but the horse cock proves you wrong by stretching you out enough to slide in.",
				"A huge horse cock is brushing its flared head against your slit before suddenly forcibly spreading the petals aside and proceeding to fuck you through the portal panties!",
				"Someone has picked up the fleshlight and is now teasing your pussy with their horse cock. The flared head is leaking pre all over your folds before sinking in and stretching your slit  enough to start pounding it.",
			]))
		if(cockType == "generic"):
			saynn(RNG.pick([
				"A {npc.penis} is rubbing against your sex, making the folds moist before sliding inside and proceeding to fuck you through the portal panties!",
				"You feel that the fleshlight with your pussy sticking out was picked up by someone! A {npc.penis} is then pressed against your sensitive folds, spreading them open before sliding in and fucking you!",
				"Someone’s hard cock suddenly gets shoved deep into your pussy through your portal panties!",
			]))
			
		if(GM.pc.getLust() >= 50):
			saynn("Ты похотливо шепчешь себе под нос.")
			
			saynn(RNG.pick([
				"[say=pc]F-fuck.. yeah..[/say]",
				"[say=pc]Yes-s~..[/say]",
				"[say=pc]Please, fuck me~[/say]",
				"[say=pc]Yes, go raw on me~[/say]",
				"[say=pc]I need this so much..[/say]",
				"[say=pc]My pussy is getting used like a fleshlight~[/say]",
			]))
		else:
			saynn("Ты тихо шепчешь себе под нос.")
			
			saynn(RNG.pick([
				"[say=pc]It’s happening again..[/say]",
				"[say=pc]I’m getting fucked..[/say]",
				"[say=pc]Oh fuck..[/say]",
				"[say=pc]Oh no..[/say]",
				"[say=pc]I’m not a fleshlight..[/say]",
				"[say=pc]It will never stop, will it..[/say]",
			]))

		addButton("Продолжить", "Тебя трахают!", "vaginal_cum")
		
	if(state == "vaginal_cum"):
		playAnimation(StageScene.SexPortal, RNG.pick(["inside", "fast"]), {pc=npcID, npc="pc", bodyState={exposedCrotch=true,hard=true}})
		
		saynn(RNG.pick([
			"The cock gradually picks up the pace, fucking your sex through the portal panties while you can’t do anything about it. Your pussy becomes slick with your juices, allowing your sex to be pounded nice and rough!",
			"You can’t do anything to stop them even if you wanted to, their eager cock is using your slit as if it's a real fleshlight, delivering you all the pleasure in the process.",
			"Portal panties means you can’t even see who is fucking you. All you feel is their cock pounding your slit with zero concerns about your opinion. And the pleasure it offers slowly drives you insane. Who would have thought that portal panties can be so hot.",
			"You can’t help but to moan while having your fuckhole used like you are some kind of fucktoy. A slight bump is moving up and down on your belly as the cock slides inside.",
			"More pleasure noises escape from you as the cock starts pounding your slit faster. You really hope no one sees you like this.",
			"You look around, hoping no one sees you getting pounded out in the public like that. Your cheeks blush red, you feel yourself getting close to an orgasm.",
		]))
		
		if(cockType == "canine"):
			saynn(RNG.pick([
				"The canine cock ravages your pussy and then shoves its knot inside. You gasp and cover your mouth while your slit clenches around the meaty orb and squirts with your female juices. A second later you feel your womb getting stuffed with someone’s cum! Someone is breeding you and you don’t even know who!",
				"The cock pounds at your cervix, quickly sending you over the edge. You cum as your body starts to squirm and shiver from the pleasure waves. And at the same time, you’re getting knotted! The whole canine member fits inside you, twitching and throbbing as it stuffs your womb full of its cum!",
			]))
		if(cockType == "feline"):
			saynn(RNG.pick([
				"The feline cock rakes at your inner walls as it thrusts in and out, causing extra sensations. It doesn’t take long until you feel the peak coming close. And the dick seems to be about to cum too, you feel it throbbing and then suddenly bursting with seed. You shut your mouth and cover it as your pussy starts clenching around the shaft, milking it for all its cum. It feels so good, being bred by some stranger’s cock.",
				"The cock smashes your cervix and tries to break through it, you feel the barbs getting stiffer as the dick is about to cum. You clench and shut your legs as the orgasm overwhelms you, not making any noises is so hard right now. And a second later, you feel the feline cock penetrating your natural barricade and scratching at your womb as it starts stuffing it full of its virile seed. Fuck, did someone just breed you, thinking your pussy was just a part of a fleshlight?",
			]))
		if(cockType == "dragon"):
			saynn(RNG.pick([
				"The dragon cock’s thrusts become faster and more powerful, its ribbed structure is quickly sending you over the edge. You bite your lip and let out a passionate moan as your pussy starts clenching around the intruding member. And soon enough, you feel hot sticky cum getting stuffed into your womb completely unceremoniously. Someone really just used you like you were some kind of pleasure toy.",
				"The cock starts thrusting harder against your cervix, smashing it each time and making your eyes roll up from a sure amount of pleasure. Little shivers quickly turn into full blown squirming, you let out a muffled moan as the orgasmic waves hit your poor mind. Your pussy walls feel the shaft’s ribbed texture as they clench around it, a few seconds later you feel something hot and sticky stuffing your womb full, it’s dragon cum! The cock then quickly gets pulled out, leaving your slit to leak cum until somebody else decides to use you. You just got fucked by some stranger.",
			]))
		if(cockType == "equine"):
			saynn(RNG.pick([
				"The horse cock is pounding at your cervix and smashes your pleasure point each time it slides in. You feel like you won’t be able to endure it for long, your pussy walls start clenching around the fat flared shaft as you both cum! The stranger starts emptying their balls inside you, quickly stuffing your womb to the brim and causing your belly to suddenly look very bumpy. And it feels good, you let your tongue out and drool while some stud is breeding you rough.",
				"The flared tip of the cock is pounding your cervix, causing a huge spike of pleasure. Your poor {pc.pussyStretch} pussy is stretched open wide for that stallion cock while it slides in and out. You hide your face from everyone and start moaning lustfully as your sex squirts from overstimulation. And a second later you feel the horse cock inflating even more as it starts shooting its sticky virile seed directly into your womb, claiming it. Your legs shake and really want to give up, you’re being bred by someone you can’t see! And just as quick, the flared cock is pulled out of your used fuckhole, leaving the fleshlight to leak cum.",
			]))
		if(cockType == "generic"):
			saynn(RNG.pick([
				"The {npc.penis} ravages your slit nice and fast, the tip is brushing against your natural barricade while also rubbing your pleasure point. You put a palm on your belly and feel it move inside you. You can’t stop the moans from escaping your lips, the orgasm creeps closer until finally overwhelming your body, making you squirm and shiver. The cock cums inside you soon after, stuffing your womb with its seed. Someone just used you as a cum dump.",
				"You can’t endure it for long, the {npc.penis} quickly pushes you over the edge and causes your climax to overwhelm you. Your legs shiver and shake while your pussy gets tight around the shaft, causing it to cum soon after, stuffing your womb full of its seed. Then it just gets pulled out, leaving your {pc.pussyStretch} slit to slowly tighten up and leak jizz.",
			]))
		
		addButton("Продолжить", "Так много спермы...", "endthescene")


	if(state == "anal"):
		playAnimation(StageScene.SexPortal, RNG.pick(["sex", "fast"]), {pc=npcID, npc="pc", bodyState={exposedCrotch=true,hard=true}})
		
		if(cockType == "canine"):
			saynn(RNG.pick([
				"You grab onto your panties when you realize that someone’s cock has found the portal with your {pc.analStretch} tailhole sticking out. Its canine pointy head is prodding at your sensitive flesh and then applies enough pressure to slide in and start fucking you!",
				"You feel something happening inside your panties, someone’s knotted cock is brushing against your {pc.analStretch} anus. You let out a small gasp as your butt then gets violated without much prelude.",
				"Someone has found the fleshlight with your anus! You feel somebody spit on your tailhole soon followed by a canine cock roughly shoving itself down your nethers.",
			]))
		if(cockType == "feline"):
			saynn(RNG.pick([
				"Someone’s cock is prodding at your tailhole, finding the right angle just to then roughly thrust inside, stretching you out! You feel its tip having barbs, they scratch at your soft inner walls.",
				"Some person has found a fleshlight that features your anus on it! You feel the barbs brushing against your soft flesh as someone’s cock starts to slide in and out, fucking you.",
				"You grasp onto the nearby wall as you feel someone suddenly shoving their feline cock down your {pc.analStretch} tailhole, they clearly want to fuck you rough!",
			]))
		if(cockType == "dragon"):
			saynn(RNG.pick([
				"A dragon cock teasingly prods at your tailhole before stretching it open and sliding inside, letting you feel its ribbed texture!",
				"Your lips let out a moan as a dragon cock finds your {pc.analStretch} butthole and starts fucking you raw!",
				"Someone’s cock rubs against your backdoor, covering it with pre. It then gets pressed against your star and applies enough pressure to sink inside, violating your butt! You feel its rubbed texture massaging your soft inner walls as it starts fucking you.",
			]))
		if(cockType == "equine"):
			saynn(RNG.pick([
				"A muffled gasp escapes from your lips as you feel a flared cock pressed against your tailhole. Its tip is huge but they got enough strength to shove their fat shaft down your star and start fucking it!",
				"A bulky horse cock is brushing its flared head against your anus before forcibly spreading it wide open and fucking you through the portal in your panties!",
				"You feel a warm string of pre landing on your butthole a few seconds before someone's horse cock is forcing itself inside, stretching your star wide open.",
			]))
		if(cockType == "generic"):
			saynn(RNG.pick([
				"Someone’s {npc.penis} is rubbing against your backdoor, making it moist from precum before sliding inside and proceeding to fuck you through the portal panties!",
				"A {npc.penis} is pressed against your tailhole, spreading it open before sliding in and proceeding to rail you!",
				"A hard cock suddenly gets shoved deep into your butthole through your portal panties!",
			]))
			
		if(GM.pc.getLust() >= 50):
			saynn("Ты похотливо шепчешь себе под нос.")
			
			saynn(RNG.pick([
				"[say=pc]F-fuck.. yeah..[/say]",
				"[say=pc]Yes-s~..[/say]",
				"[say=pc]Please, fuck me~[/say]",
				"[say=pc]Oh no, I’m getting fucked raw again~[/say]",
				"[say=pc]Yeah, stretch my fuckhole..[/say]",
				"[say=pc]Yeah, use that fleshlight~[/say]",
			]))
		else:
			saynn("Ты тихо шепчешь себе под нос.")
			
			saynn(RNG.pick([
				"[say=pc]It’s happening again..[/say]",
				"[say=pc]My hole is getting used like I’m some fucktoy..[/say]",
				"[say=pc]Oh fuck..[/say]",
				"[say=pc]Oh.. wa-ait..[/say]",
				"[say=pc]I’m not a fleshlight..[/say]",
				"[say=pc]It will never stop, will it..[/say]",
			]))

		addButton("Продолжить", "Тебя трахают!", "anal_cum")

	if(state == "anal_cum"):
		playAnimation(StageScene.SexPortal, RNG.pick(["inside", "fast"]), {pc=npcID, npc="pc", bodyState={exposedCrotch=true,hard=true}})
		
		saynn(RNG.pick([
			"The cock gradually picks up the pace, fucking your sex through the portal panties while you can’t do anything about it. Your inner walls become slick with all the precum, allowing your sex to be pounded nice and rough!",
			"You can’t do anything to stop them even if you wanted to, their eager cock is using your tailhole as if it's attached to a real fleshlight, delivering you all the pleasure in the process.",
			"Portal panties means you can’t even see who is fucking you. All you feel is their cock pounding your ass with very little consideration about it. And the pleasure it offers slowly drives you insane. Who would have thought that portal panties can be so hot.",
			"You can’t help but to moan while having your fuckhole used like you are some kind of fucktoy. A slight bump is moving up and down on your belly as the cock slides inside.",
			"More pleasure noises escape from you as the cock starts pounding your butt faster. You really hope no one sees you like this.",
			"You look around, hoping no one sees you getting pounded out in the public like that. Your cheeks blush red, you feel yourself getting close to an orgasm.",
		]))
		
		if(cockType == "canine"):
			saynn(RNG.pick([
				"The canine cock eagerly pounds your tailhole and even shoves its knot inside with its last thrust. You gasp and try to cover your mouth while your insides are clenching around the meaty orb. You feel your nethers getting stuffed with someone’s seed, they are cumming inside you!",
				"The knotted cock pounds your butt rough, quickly sending you past the peak. Your body squirms and quivers from the pleasure waves. And at the same time, the round fat orb slips in too, knotting you! The whole canine member fits inside you, twitching and throbbing as it stuffs your ass full of cum!",
			]))
		if(cockType == "feline"):
			saynn(RNG.pick([
				"The feline cock rakes at your soft anal walls as it thrusts in and out, causing extra sensations. You can’t endure that onslaught on your ass for long, sneaky moans escape from you as your tailhole starts pulsating and clenching around the cock. And very soon after, you feel hot sticky cum flowing deep into your nethers, stuffing your ass! The stranger then pulls his dick out, causing the barbs to scratch at your insides for the last time before leaving the fleshlight alone.",
				"You feel the barbs getting stiffer as the dick inside your butt is about to cum. You clench and close your legs shut as the climax overwhelms you. And as you cum yourself, you feel the feline cock doing a few rough thrusts before stuffing your nethers full of its virile seed. Fuck, did someone just cum inside you, thinking your butthole was just a part of a fleshlight?",
			]))
		if(cockType == "dragon"):
			saynn(RNG.pick([
				"The dragon cock’s thrusts become faster and more powerful, you feel its ribbed texture brush against your inner walls so much, sending you over the edge. That's when the intruding member starts stuffing you full of its seed. You bite your lip and let out a passionate moan as your butt starts clenching around the shaft, milking it hard.",
				"The pace becomes faster, the ribbed cock is fucking you so rough your stretched tailhole probably makes sloppy wet noises. You feel the cock getting twitchy a second before it starts cumming in you, shooting its seed deep down your insides, breeding your ass.",
			]))
		if(cockType == "equine"):
			saynn(RNG.pick([
				"The horse cock gets rammed deep down your fuckhole, stretching the inner walls so much as it slides inside. The flared fat head is brushing against your pleasure point, making you whine from pleasure. Suddenly you feel its glands inflate even more as it starts cumming inside, stuffing your tailhole full to the brim with its seed. Then, just as the quick, the cock gets pulled out, leaving you to gape and leak through the portal panties.",
				"The flared tip of the cock is pounding your ass, providing you with so much pleasure as it smashes your pleasure point. Your poor {pc.analStretch} tailhole is stretched open wide for that stud cock as it rails you. And a second later you feel the horse cock shooting its sticky virile seed deep inside you. Your legs shake and really want to give up, you’re being bred by someone you can’t see! The flared cock is then pulled out of your used fuckhole, leaving the fleshlight to leak cum. Your belly is now way more bumpy than it was.",
			]))
		if(cockType == "generic"):
			saynn(RNG.pick([
				"The {npc.penis} picks up the pace and fucks you at a crazy speed, sliding in and out and not even giving your insides enough time to tighten up before they are spread wide open again. You drop a few rouge moans as you cum from so much stimulation on your pleasure point. The inner walls clench around the shaft as it starts shooting its load deep inside you. You both came at roughly the same moment!",
				"The hard cock throbs and twitches as it fucks you, a few thrusts later it starts to fill your bowels full of its seed. It was too much for you, your body squirms hard while your tailhole clenches around the shaft, milking it.",
			]))
		
		addButton("Продолжить", "Так много спермы...", "endthescene")
		
		
		
	if(state == "cockSuck"):
		playAnimation(StageScene.SexPortalOral, RNG.pick(["suck", "suckfast"]), {pc=npcID, npc="pc", npcBodyState={hard=true}})
		
		saynn("Ты почти забыла, что на тебе надеты эти портальные трусики. Но ты вспоминаешь о них, когда внезапно чувствуешь, как чьи-то губы обхватывают кончик твоего {pc.cock} и начинают нежно посасывать его.")
		
		saynn("Такое дразнение заставляет тебя возбуждаться и жаждать большего. Ты оглядываешься по сторонам, надеясь, что никто не смотрит. Кажется, губы замечают, как твой член наполняется кровью, и слегка целуют его, прежде чем широко раскрыться, позволяя члену пройти между зубами. Ты чувствуешь, как теплые, влажные стенки чьего-то рта смыкаются вокруг твоего достоинства, а язык начинает его вылизывать.")
		
		saynn("Твой член сочится предэякулятом, и язык ловит каждую каплю. Затем ты чувствуешь, как губы начинают скользить по всей длине твоего члена, высасывая тебя так мастерски, что ты невольно задумываешься: а понимают ли они вообще, что сосут настоящий член, а не какой-то реалистичный секс-игрушку?")
		
		addButton("Кончай!", "Ты почти не можешь это контролировать", "cockSuckCum")
		
	if(state == "cockSuckCum"):
		playAnimation(StageScene.SexPortalOral, RNG.pick(["hold", "suck", "suckfast"]), {pc=npcID, npc="pc", npcBodyState={hard=true}})
		
		saynn("Ты пытаешься сохранять спокойствие, но невольные стоны удовольствия вырываются сами собой, когда губы внезапно заходят очень глубоко, достигая самого основания твоего члена, заглатывая его целиком. Твои пальцы ног поджимаются от ощущения того, как узкие стенки горла доят твой член. Это быстро подводит тебя к краю: твой {pc.cock} выстреливает порцией глубоко в чье-то горло, пока ты выгибаешься в спине, издавая сдавленные звуки.")
		
		saynn(RNG.pick([
			"[say=pc]Oh fuck..[/say]",
			"[say=pc]Cumming..[/say]",
			"[say=pc]It’s so tight.[/say]",
		]))
		
		saynn("Кто бы это ни был, этот человек с жадностью заглатывает твой {pc.cum}, а затем вылизывает твой член дочиста, собирая всю смазку.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")


	if(state == "cockTeaseThighs"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["tease"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Чьи-то пальцы скользят по поверхности твоего {pc.cock}. Затем они сосредотачиваются на стимуляции головки, быстро заставляя тебя встать колом от похоти; ты чувствуешь, как пальцы собирают предэякулят и размазывают его по стволу.")
		
		saynn("После таких дразнящих ласк пальцы убираются, а им на смену приходит нечто гораздо более мягкое. Ты чувствуешь, как твой член оказывается зажат между чьих-то бедер, которые начинают двигаться вперед-назад, доставляя тебе невероятное наслаждение. Они трутся своей киской о твой член, и чувствительные лепестки покрывают его соками, делая ствол еще более скользким. Ты чувствуешь, что долго не продержишься: твой член уже пульсирует, готовый извергнуть свою порцию.")
		
		if(RNG.chance(50)):
			addButton("Кончай!", "Это просто слишком сильно", "cockTeaseThighsCumInside")
		else:
			addButton("Кончай!", "Это просто слишком сильно", "cockTeaseThighsCumOutside")
		
	if(state == "cockTeaseThighsCumInside"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["sex", "fast", "inside"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Бедра всё еще трутся о твой член. Но как раз в тот момент, когда ты готов кончить, ты чувствуешь, как их киска смещается и прижимается к твоему стволу; этого резкого движения хватает, чтобы ты вошел в складки их плоти и скользнул внутрь. Влажные мягкие стенки обволакивают твой член, заставляя тебя издать стон, когда ты мощно кончаешь; твоя {pc.cock} начинает извергать волны {pc.cum} прямо в их «машинку для детей», набивая её до краев. Невольно задумываешься: неужели они ожидали кончить в себя от случайного члена, прикрепленного к портативным трусикам?")
		
		saynn("Стенки киски с силой доят твой член, выжимая последнюю каплю. Но как только их оргазм затихает, они просто вытаскивают твой член из набитой спермой щели и оставляют тебя где-то в стороне.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
		
	if(state == "cockTeaseThighsCumOutside"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["tease"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Бедра сильнее прижимаются к твоему члену; ты чувствуешь, как киска заливает всю твою длину смазкой, когда незнакомка на той стороне начинает кончать. И именно в этот момент ты достигаешь пика и тоже кончаешь; твоя {pc.cock} начинает выстреливать струями {pc.cum} куда-то, куда ты не видишь — вероятно, заливая пол и заставая врасплох того, кто решит воспользоваться этой игрушкой.")
		
		saynn("Когда оргазм утихает, ты чувствуешь, что «флешлайт» с твоим членом просто где-то оставили.")
	
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
	
	
	if(state == "cockVaginal"):
		playAnimation(StageScene.SexPortalRide, RNG.pick(["sex", "fast"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Тихий звук срывается с твоих губ, когда ты чувствуешь, как чей-то язык внезапно начинает лизать твою {pc.cock} сквозь портальные трусики. К члену быстро приливает кровь, подготавливая его и заставляя наливаться еще сильнее.")
		
		saynn("Затем ты чувствуешь, как твой член прижимается к киске! Твой член раздвигает влажные, жаждущие складки, когда ты ощущаешь, как кто-то опускается на этот «флешлайт», на который насажен твой член. Хм, похоже, они очень хотят, чтобы их киску набили до отказа.")
		
		saynn("Затем они начинают прыгать на твоем члене вверх и вниз. Они седлают тебя так мастерски, что ты быстро начинаешь тяжело дышать и выгибать спину — их внутренние стенки так приятно обхватывают твой ствол.")
		
		saynn("Головка твоего члена долбит прямо в шейку матки, и кажется, что ты вот-вот кончишь!")
		
		addButton("Кончить внутрь", "У тебя всё равно нет выбора", "cockVaginalCum")
	
	if(state == "cockVaginalCum"):
		playAnimation(StageScene.SexPortalRide, RNG.pick(["inside", "fast", "tease"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Кем бы они ни были, их, кажется, не волнует возможность получить кремпи, забитый семенем. Или, может, они не ожидают, что случайно найденная игрушка сможет их оплодотворить, поэтому они продолжают скакать на тебе, пока твой член начинает пульсировать и извергать {pc.cum} прямо им в матку, наполняя её до краев. Ты плотно сжимаешь губы и изо всех сил стараешься не шевелиться, пока твои яйца опустошаются этой дергающейся киской.")
		
		saynn("Затем они просто вытаскивают твой член из своей использованной дырки и оставляют «флешлайт» в покое.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
		
	
	if(state == "cockAnal"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["sex", "fast"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Ты замираешь, чувствуя, как кто-то хватает «флешлайт» с торчащим из него членом и начинает ласкать твои яйца. Затем они используют язык, чтобы ты встал еще тверже и у тебя выступила предэякулятина — и всё это лишь для того, чтобы секунду спустя засунуть твой член себе в задницу.")
		
		saynn("Ты издаешь тихий стон, когда твой {pc.cock} растягивает их тугое кольцо и скользит всё глубже. Рука начинает двигать твой член туда-сюда, так что твой ствол вбивается в их задницу грубо и быстро, размазывая их точку удовольствия.")
		
		addButton("Кончай!", "Ты долго это не выдержишь", "cockAnalCum")
	
	if(state == "cockAnalCum"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["tease", "inside", "fast"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Внутренние стенки этой ануса начинают сжиматься вокруг твоего члена в совершенно хаотичном ритме — ты чувствуешь, как они кончают! Вскоре после этого трение и ощущение тесноты доводят и тебя до предела: твой член выбрасывает порцию внутрь чьих-то недр, забивая их задницу твоим {pc.cum}.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
		
		
	if(state == "cockCondom"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["sex", "fast"]), {pc=npcID, npc="pc", npcBodyState={hard=true, condom=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Внезапно ты чувствуешь, как какой-то резиновый объект скользит по твоему члену. Тебе что, надевают презерватив? Да, похоже на то: пальцы растягивают резину по всей твоей длине, а затем несколько раз проводят по стволу, поглаживая и растирая его. Эти дразнящие ласки делают своё дело, постепенно заставляя тебя вставать ещё тверже.")
		
		saynn("Затем незнакомка хватает твой член, словно флэшлайт, и начинает использовать его как дилдо, втискивая в свою киску и двигая им туда-сюда. Её узкая щель дарит невероятное удовольствие, а презерватив обильно смазан лубрикантом, так что ей очень легко использовать твой член для своего наслаждения.")
		
		if(RNG.chance(50)):
			addButton("Кончай!", "Засунь этот презерватив", "cockCondomCumBreak")
		else:
			addButton("Кончай!", "Засунь этот презерватив", "cockCondomCumNoBreak")
		
	if(state == "cockCondomCumBreak"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["inside", "tease"]), {pc=npcID, npc="pc", npcBodyState={hard=true, condom=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Ты сможешь терпеть лишь недолго, прежде чем кончишь; твой {pc.cock} пульсирует, наполняя презерватив твоим {pc.cum}, пока ты внутри кого-то. Стенки её киски сжимаются ещё сильнее, когда оргазм накрывает и её, и этой дополнительной стимуляции хватает, чтобы продлить твой климакс; твой член продолжает набивать презерватив, пока он [b]внезапно не рвётся, выплескивая всё содержимое[/b]. Ой, похоже, ты случайно её оплодотворил. Надеемся, она не против.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
		
	if(state == "cockCondomCumNoBreak"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["inside", "fast"]), {pc=npcID, npc="pc", npcBodyState={hard=true, condom=true}, bodyState={exposedCrotch=true, hard=true}})
		
		saynn("Ты сможешь терпеть это лишь недолго, прежде чем кончишь; твой {pc.cock} пульсирует, наполняя презерватив твоей {pc.cum}, пока ты внутри кого-то. Стенки их киски сжимаются еще сильнее, когда оргазм накрывает и их тоже — по крайней мере, ты их не оплодотворишь.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")


	if(state == "cockStroking"):
		playAnimation(StageScene.SexPortalOral, RNG.pick(["hold"]), {pc=npcID, npc="pc", npcBodyState={hard=true}})
		
		saynn("Чьи-то пальцы внезапно обхватывают твой член и мягко проводят по нему, словно проверяя на прочность. Хватка довольно нежная, и ты не можешь удержаться от того, чтобы не налиться еще сильнее, пока они ласкают твой {pc.cock}. Один из пальцев находит головку и начинает тереть её, а другая рука присоединяется, чтобы поиграть с твоими яйцами, заставляя тебя поджимать пальцы на ногах от удовольствия.")
		
		saynn("Затем ладонь замечает твою реакцию и сжимается вокруг твоего члена крепче, прежде чем начать дразнящую мастурбацию. Эти движения слишком хороши; ты пытаешься податься навстречу руке, но ничего не можешь с собой поделать — у тебя нулевой контроль над происходящим. У тебя выделяется всё больше смазки, и рука размазывает её по всей длине, постепенно ускоряясь и подготавливая тебя к самому пику.")
		
		addButton("Кончай!", "Надеемся, они не собираются тебя обделять", "cockStrokingCum")

	if(state == "cockStrokingCum"):
		playAnimation(StageScene.SexPortalOral, RNG.pick(["hold"]), {pc=npcID, npc="pc", npcBodyState={hard=true}})
		
		saynn("Ты чувствуешь, как давление нарастает; тебе плевать, что ты ни в кого не трахаешься — одной руки достаточно, чтобы тебе стало чертовски хорошо. Твой {pc.cock} начинает дергаться всё сильнее, а затем внезапно выстреливает мощной густой струей {pc.cum} в воздух, за которой следуют еще несколько более мелких. Ты стонешь и слегка корчишься, пока рука выжимает из твоих яиц всё до последней капли.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")
		
	
	if(state == "cockWarming"):
		playAnimation(StageScene.SexPortalMasturbation, RNG.pick(["inside"]), {pc=npcID, npc="pc", npcBodyState={hard=true}, bodyState={exposedCrotch=true}})
		
		saynn("А? Ты чувствуешь, как кто-то обхватил твой член, словно мастурбатор, и прижимает его к своей заднице. От этого твой орган начинает постепенно твердеть. Незнакомец водит твоим стволом между своих ягодиц, лаская его таким образом, отчего ты тихонько стонешь. Когда твой член так «горяче» зажимают, это приносит слишком много удовольствия, и ты заливаешь их задницу предэякулятом.")
		
		saynn("А затем они просто засовывают твой {pc.cock} себе в задницу и оставляют там. Ни движений, ни траха — они просто используют свою узкую дырку, чтобы согреть твой член; возможно, они просто искали хорошую пробку. Их внутренние стенки время от времени сжимаются вокруг твоего ствола, поддерживая эрекцию — похоже, они собираются побыть твоей грелкой для члена еще какое-то время.")
		
		addButton("Продолжить", "Веселое времяпровождение", "endthescene")

	
func _react(_action: String, _args):

	if(_action in ["vaginal_cum"]):
		GM.pc.gotVaginaFuckedBy(npcID)
		GM.pc.cummedInVaginaBy(npcID)
		GM.pc.orgasmFrom(npcID)
	
	if(_action in ["anal_cum"]):
		GM.pc.gotAnusFuckedBy(npcID)
		GM.pc.cummedInAnusBy(npcID)
		GM.pc.orgasmFrom(npcID)
	
	if(_action == "cockSuckCum"):
		getCharacter(npcID).gotThroatFuckedBy("pc", false)
		getCharacter(npcID).cummedInMouthBy("pc")
	
	if(_action == "cockCondomCumBreak"):
		getCharacter(npcID).gotVaginaFuckedBy("pc", false)
		getCharacter(npcID).cummedInVaginaBy("pc")
	
	if(_action == "cockAnalCum"):
		getCharacter(npcID).gotAnusFuckedBy("pc", false)
		getCharacter(npcID).cummedInAnusBy("pc")
	
	if(_action == "cockVaginalCum"):
		getCharacter(npcID).gotVaginaFuckedBy("pc", false)
		getCharacter(npcID).cummedInVaginaBy("pc")
	
	if(_action == "cockTeaseThighsCumInside"):
		getCharacter(npcID).gotVaginaFuckedBy("pc", false)
		getCharacter(npcID).cummedInVaginaBy("pc")
	
	if(_action == "cockTeaseThighsCumOutside"):
		getCharacter(npcID).cummedOnBy("pc")
	
	if(_action in ["cockSuckCum", "cockStrokingCum", "cockCondomCumNoBreak", "cockCondomCumBreak", "cockAnalCum", "cockVaginalCum", "cockTeaseThighsCumInside", "cockTeaseThighsCumOutside"]):
		GM.pc.orgasmFrom(npcID)
	
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["cockType"] = cockType
	data["npcID"] = npcID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	cockType = SAVE.loadVar(data, "cockType", "canine")
	npcID = SAVE.loadVar(data, "npcID", "inmateMaleCanine")
