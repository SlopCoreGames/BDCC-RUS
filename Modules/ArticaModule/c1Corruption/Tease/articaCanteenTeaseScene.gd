extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaCanteenTeaseScene"

func _run():
	if(state == ""):
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		saynn("Вы приглашаете Артику пойти поесть в столовую.")

		if (nakedAndShy):
			saynn("[say=artica]Ох.. ммм.. но я же голая.. Все же увидят мо-мои.. ой![/say]")

			saynn("Вы решаете не слушать её оправдания и просто хватаете её за воротник.")

		elif (isLusty):
			saynn("[say=artica]Ох.. ну-у.. мы мо-о-ожем..[/say]")

			if (isNaked):
				saynn("Её твердый, выставленный напоказ {artica.penis} говорит о том, что она может проголодаться по чему-то большему, чем просто перекус.")

			else:
				saynn("Её натянутые шорты намекают, что она может жаждать чего-то большего, чем просто перекус.")

		else:
			saynn("[say=artica]Звучит неплохо.. назад на моё старое место, ха-ха.[/say]")

		addButton("Столовая", "Пойти поесть!", "go_eat")
	if(state == "go_eat"):
		playAnimation(StageScene.PawJobUnderTable, "start", {npc="pc", pc="artica"})
		if (nakedAndShy):
			saynn("Вы берете два подноса с безвкусной питательной пастой. Из-за подноса Артика вынуждена держать свой {artica.penis} на виду, и её щеки густо краснеют, пока она спешит к их обычному столику.")

			saynn("[say=artica]Все на меня с-смотрят..[/say]")

		elif (isNaked && isVerySlut):
			saynn("Ты берешь два подноса с безвкусной питательной пастой и направляешься к привычному столику. Артика вовсю виляет задом, наслаждаясь твоим голодным взглядом, прикованным к её обнаженным интимным местам.")

			saynn("[say=artica]Все смотрят, ха-ха..[/say]")

		elif (isNaked && isSlut):
			saynn("Ты берешь два подноса с безвкусной питательной пастой и идешь к привычному столику. Кажется, Артика уже не так сильно стыдится своего тела — она просто непринужденно проходит мимо остальных заключенных, которые пялятся на её киску.")

			saynn("[say=artica]Я такая.. открытая..[/say]")

		else:
			saynn("Ты берешь два подноса с безвкусной питательной пастой и садишься за привычный столик.")

			saynn("[say=artica]"+str(RNG.pick(["How's you?..", "Looks tasty.. a bit..", "I'm doing okay.. What about you?"]))+"[/say]")

		saynn("Время летит незаметно, пока вы болтаете и едите.")

		addButton("Скрытый дразнящий жест", "Потереться ногой о её промежность под столом", "stealth_tease")
		if (corruption >= 0.1):
			addButtonWithChecks("Нюхать её промежность", "Заставить Артику нюхать твою промежность", "force_crotchsniff", [], [[ButtonChecks.HasReachableOrCagedPenisOrReachableVagina]])
		else:
			addDisabledButton("Нюхать её промежность", "Уровень развращенности Артики должен быть выше 10%")
		if (corruption >= 0.2):
			addButton("Предложить ножку", "Предложить Артике поклоняться твоей ножке", "tease_offerfoot")
		else:
			addDisabledButton("Предложить ножку", "Уровень развращенности Артики должен быть выше 20%")
		addButton("Просто ням-ням", "Ты просто хотел поесть вместе с Артикой", "just_nom")
	if(state == "just_nom"):
		saynn("Ты решаешь не дразнить Артику, а просто мило поболтать с ней.")

		if (isSlut && isLusty):
			saynn("Она очень много болтала о сексе и лапках...")

		else:
			saynn("Ты всё время болтаешь о тюремной жизни.")

		saynn("Закончив трапезу, ты возвращаешься на главную платформу.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "force_crotchsniff"):
		if (isLusty):
			playAnimation(StageScene.ChairCrotchSniff, "grind", {pc="artica", npc="pc", pcCum=true, bodyState={hard=true}, npcBodyState={hard=true}})
			saynn("Когда ты резко прерываешь обед и встаешь, сердце Артики уже бешено колотится от предвкушения. Прежде чем она успевает осознать происходящее, ты хватаешь её за волосы... и с силой прижимаешь её лицом к своему паху, вжимая её нос в свой "+str("{pc.penis}" if GM.pc.hasPenis() else "wet pussy")+"!")

			saynn("Глаза Артики широко распахиваются от изумления, а с губ срывается тихий стон, когда она делает глубокий вдох, захлебываясь опьяняющим ароматом. С каждым вдохом волна удовольствия проносится по её телу, а её член пульсирует от жажды"+str(" inside of its cage" if isCaged else "")+".")

			saynn("[say=artica]Я.. я.. мм.м-м.. ах-х.. А!..[/say]")

			saynn("Внезапно её тело сотрясает конвульсия удовольствия! Потоки горячей липкой спермы извергаются из её пульсирующего члена"+str(", splattering onto the floor beneath in a messy puddle" if isNaked else ", most of it caught by the fabric of her shorts.. but some is seeping through already..")+"")

			saynn("Тяжело дыша, Артика бессильно прижимается к тебе, всё ещё дрожа всем телом.")

			saynn("[say=pc]Какая милая девочка.[/say]")

		else:
			playAnimation(StageScene.ChairCrotchSniff, "sniff", {pc="artica", npc="pc", bodyState={hard=true}, npcBodyState={hard=true}})
			saynn("Ты знаешь лучший способ завести Артику...")

			saynn("Не говоря ни слова, ты встаешь и подходишь к её скамье. Видя тебя и твой полный намерения взгляд, пушинка слегка отодвигается, увеличивая дистанцию...")

			saynn("[say=artica]М-м... что ты... Ой![/say]")

			if (GM.pc.isWearingChastityCage()):
				saynn("Но ты не медлишь: хватаешь её за волосы и с силой вжимаешь лицом себе в пах, проводя её мордой по яйцам и вдоль холодной клетки целомудрия, пачкая её мех своей предсеменной жидкостью. Она кажется, пытается вырваться...")

			elif (GM.pc.hasReachablePenis()):
				saynn("Но ты не медлишь: хватаешь её за волосы и с силой вжимаешь лицом себе в пах, проводя её мордой по яйцам и вдоль {pc.penis}, пачкая её мех своей предсеменной жидкостью. Она кажется, пытается вырваться...")

			else:
				saynn("Но ты не медлишь: хватаешь её за волосы и с силой вжимаешь лицом себе в пах, проводя её мордой по своей влажной киске, пачкая её мех своими соками. Она кажется, пытается вырваться...")

			saynn("[say=pc]Вдыхай![/say]")

			saynn("У неё перехватывает дыхание, когда она делает глубокий вдох, наполняя ноздри опьяняющим ароматом. По спине Артики пробегает дрожь, когда её собачий член начинает твердеть и сочиться от возбуждения."+str(" inside of its cage" if isCaged else "")+".")

			saynn("[say=pc]Хорошо. Продолжай.[/say]")

			saynn("Её тело жадно откликается... Из пасти вырываются тихие стоны... С каждым вдохом она возбуждается всё сильнее, её разум затуманивается похотью, а щеки заливает румянец желания.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "tease_offerfoot"):
		#var isDigi = GM.pc.bodypartHasTrait(BodypartSlot.Legs, PartTrait.LegsDigi)
		#var isHoofs = GM.pc.bodypartHasTrait(BodypartSlot.Legs, PartTrait.LegsHoofs)
		#var pawname = ("foot" if (!isDigi  && !isHoofs) else ("paw" if isDigi else "hoof"))
		#var toesname = ("toes" if !isHoofs else "sole")
		if (isLusty):
			playAnimation(StageScene.CheckPaw, "crotch", {pc="pc", npc="artica", npcCum=true, npcBodyState={hard=true}})
			saynn("Ты замечаешь её голодный взгляд, прикованный к твоему {pc.feet}... Похоже, она изрядно зажата... так почему бы не помочь ей?")

			saynn("[say=pc]На колени. Под стол.[/say]")

			if (isSlut):
				saynn("Без лишних раздумий пушинка с готовностью забирается под стол и повинуется твоим словам, опускаясь на колени настолько низко, насколько позволяет стол.")

			else:
				saynn("Пушинка явно борется сама с собой, её широко раскрытые глаза сканируют комнату... чертовски оживленную комнату... Но в конце концов похоть берет верх... Артика забирается под стол и повинуется твоим словам, опускаясь на колени настолько низко, насколько позволяет стол.")

			if (isNaked):
				if (isCaged):
					saynn("Медленно ты протягиваешь свою {pc.foot} вперед... и заставляешь Артику раздвинуть ноги, надавливая на её бёдра... прежде чем приложить её к её промежности. Она ахает, когда ты начинаешь тереть открытую металлическую клетку своей {pc.toes}... Циановый член внутри почти всегда твердый, отчаянно желающий выбраться наружу...")

					saynn("[say=artica]Нх-х.. э-это.. о-очень интенсивно..[/say]")

					saynn("Хм, ты едва играешь с этой штукой, просто слегка дёргаешь и тянешь её... Но ты чувствуешь, как внутри нарастает сильное давление... похоже, Артика вот-вот...")

					saynn("[say=artica]Ах!.. ах-х..ах.ах..аах-х..[/say]")

					saynn("Инстинктивно она сжимает ноги вокруг твоей {pc.foot}, пока её мышцы напрягаются... Артика мило стонет, пока её запертый внутри член сильно пульсирует... прежде чем кончить и оставить настоящий беспорядок на её меху и твоей {pc.foot}...")

					saynn("[say=pc]Ого. Быстро же ты~. А теперь убери всё это.[/say]")

					saynn("Она тяжело дышит... оргазм заставляет её тело содрогаться... но она обхватывает твою {pc.foot} руками и подносит её к своей пасти... после чего начинает слизывать языком весь тот беспорядок, что она устроила... Очень мило.")

				else:
					saynn("Медленно ты подаешь свой {pc.foot} вперед... заставляя Артику раздвинуть ноги, надавливая на ее бедра... а затем прижимаешь его к ее промежности. Она ахает, когда ты начинаешь тереть ее обнаженный твердый клыкастый член своим {pc.toes}... дразня сочащийся кончик и яички.")

					saynn("[say=artica]Нх-х.. э-это.. о-очень интенсивно..[/say]")

					saynn("Хм, ты едва играешь с этой штукой, просто слегка поглаживая её... Но ты чувствуешь, как нарастает сильное давление... Девушка сильно ерзает, её яички подергиваются, а узел заметно раздувается... похоже, Артика вот-вот...")

					saynn("[say=artica]Ах!.. ах-х..ах.ах..аах-х..[/say]")

					saynn("Инстинктивно она сжимает ноги вокруг твоего {pc.foot}, и её мышцы напрягаются... Артика мило стонет, пока её член сильно пульсирует... кончая и оставляя настоящий беспорядок на её меху и твоем {pc.foot}...")

					saynn("[say=pc]Ого. Быстро же ты~. А теперь убери всё это.[/say]")

					saynn("Она тяжело дышит... оргазм заставляет её тело содрогаться... но она обхватывает твою {pc.foot} руками и подносит её к своей пасти... после чего начинает слизывать языком весь тот беспорядок, что она устроила... Очень мило.")

			else:
				if (isCaged):
					saynn("Медленно ты подаешь свой {pc.foot} вперед... заставляя Артику раздвинуть ноги, надавливая на ее бедра... а затем прижимаешь его к её промежности. Она ахает, когда ты начинаешь тереть металлическую клетку в её шортах своим {pc.toes}...")

					saynn("[say=artica]Нх-х.. э-это.. о-очень интенсивно..[/say]")

					saynn("Хм, ты едва играешь с этой штукой, просто слегка дёргаешь и тянешь её... Но ты чувствуешь, как внутри нарастает сильное давление... похоже, Артика вот-вот...")

					saynn("[say=artica]Ах!.. ах-х..ах.ах..аах-х..[/say]")

					saynn("Инстинктивно она сжимает ноги вокруг твоего {pc.foot}, и её мышцы напрягаются... Артика мило стонет, пока её запертый в клетке член пульсирует внутри шорт... кончая и оставляя после себя жуткий беспорядок...")

					saynn("[say=pc]Ого. Это было быстро~.[/say]")

				else:
					saynn("Медленно ты подаешь свой {pc.foot} вперед... заставляя Артику раздвинуть ноги, надавливая на ее бедра... а затем прижимаешь его к её промежности. Она ахает, когда ты начинаешь тереть твердый член в её шортах, проводя своим {pc.toes} по его контурам...")

					saynn("[say=artica]Нх-х.. э-это.. о-очень интенсивно..[/say]")

					saynn("Хм, ты едва играешь с этим членом, просто слегка поглаживаешь его... Но ты чувствуешь, как внутри нарастает давление... столько судорог... и узел тоже раздувается... похоже, Артика вот-вот...")

					saynn("[say=artica]Ах!.. ах-х..ах.ах..аах-х..[/say]")

					saynn("Инстинктивно она сжимает ноги вокруг твоего {pc.foot}, и её мышцы напрягаются... Артика мило стонет, пока её член пульсирует внутри шорт... кончая и оставляя после себя настоящий беспорядок...")

					saynn("[say=pc]Ого. Это было быстро~.[/say]")

		else:
			if (RNG.chance(50)):
				playAnimation(StageScene.CheckPaw, "lick", {pc="pc", npc="artica", npcBodyState={hard=true}})
				saynn("Медленно ты закидываешь одну ногу на другую... И в этот момент замечаешь заинтригованный взгляд Артики. Её глаза следят за тем, как ты шевелишь своим {pc.foot}... у неё текут слюнки.")

				saynn("[say=pc]Давай же~[/say]")

				if (isSlut):
					saynn("Без лишних раздумий пушистая девчонка жадно ныряет под стол... прежде чем придвинуться вплотную к твоему {pc.feet}.")

				else:
					saynn("Пушистая явно борется сама с собой, её широко распахнутые глаза сканируют комнату... чертовски оживленную комнату... Но в конце концов она решает залезть под стол... и прижаться к твоему {pc.feet}.")

				saynn("Она быстро обтирает их руками, смахивая пыль и грязь... после чего слегка облизывает твой {pc.toes}... Ха, щекотно, твой {pc.foot} инстинктивно дергается назад. Артика осторожно тянет его обратно и утыкается в него лицом, шумно втягивая запах носом... прежде чем снова начать водить своим собачьим языком по чувствительной поверхности...")

				saynn("[say=pc]Тебе ведь нравится, правда?[/say]")

				saynn("Девчонка лишь тихо тявкнула, прежде чем разомкнуть губы и впустить часть твоего {pc.foot} внутрь, нежно посасывая его...")

				saynn("Ты замечаешь "+str("her shorts getting tight.." if !isNaked else "her cock leaving her sheath..")+" значит, это работает.")

				saynn("Когда она закончит боготворить этот {pc.foot}.. ты опускаешь его и поднимаешь другой, чтобы она его облизала. Какая же голодная лапосушка.. Её глаза так и светятся похотью.."+str(" there is a visible wet spot on her shorts where her crotch is.." if !isNaked else " Her member is fully hard and dripping by now..")+"")

				saynn("[say=pc]Хорошо.. На время хватит. Не хочу, чтобы ты слишком раззадорилась.[/say]")

			else:
				playAnimation(StageScene.CheckPaw, "beans", {pc="pc", npc="artica", npcBodyState={hard=true}})
				saynn("Медленно ты поднимаешь одну ногу и кладешь её поверх другой.. И в этот момент ты замечаешь заинтригованный взгляд Артики. Её глаза следят за тем, как ты шевелишь своим {pc.foot}.. её собственные лапки поджимаются от восхищения твоими..")

				saynn("[say=pc]Я тебя не останавливаю~.[/say]")

				if (isSlut):
					saynn("Без лишних раздумий пушистая девчонка жадно ныряет под стол... прежде чем придвинуться вплотную к твоему {pc.feet}.")

				else:
					saynn("Пушистая явно борется сама с собой, её широко распахнутые глаза сканируют комнату... чертовски оживленную комнату... Но в конце концов она решает залезть под стол... и прижаться к твоему {pc.feet}.")

				saynn("Она быстро обтирает их руками, смахивая пыль и грязь.. после чего принимается делать легкий массаж, нежно разминая твои {pc.toes}. Приятное чувство..")

				saynn("[say=pc]У тебя начинает получаться.[/say]")

				saynn("Девушка лишь тихо тявкает, прежде чем начать ласкать твой {pc.foot} своими когтистыми пальчиками, поглаживая ладонями его нижнюю часть..")

				saynn("Ты замечаешь "+str("her shorts getting tight.." if !isNaked else "her cock leaving her sheath..")+" значит, это её возбуждает.")

				saynn("Когда она закончит боготворить этот {pc.foot}.. ты опускаешь его и поднимаешь другой, чтобы она сделала массаж. И она принимается за дело, глядя на тебя с нескрываемой похотью, пока делает ещё один массаж.."+str(" there is a visible wet spot on her shorts where her crotch is.." if !isNaked else " Her member is fully hard and dripping by now..")+"")

				saynn("[say=pc]Хорошо.. На время хватит. Не хочу, чтобы ты слишком раззадорилась.[/say]")

		saynn("Ты заканчиваешь трапезу... и после этого возвращаешься на главную платформу.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "stealth_tease"):
		playAnimation(StageScene.PawJobUnderTable, "fast", {npc="pc", pc="artica", pcCum=isLusty, bodyState={hard=true}})
		saynn("В столовой, как обычно, кипит жизнь... никто и не заметит, если ты замутишь что-нибудь эдакое...")

		if (isLusty):
			var theCockDesc = ("hard cock" if !isCaged else "caged up cock")
			saynn("С едва заметной ухмылкой ты вытягиваешь ногу под столом, стремясь нежно "+str("brush Artica's crotch through the bulging shorts" if !isNaked else "stroke her "+theCockDesc)+" подошвой своей стопы.")

			saynn("Артика ахает, её глаза расширяются от неожиданности, а щеки заливает густой румянец. Она начинает ерзать на стуле, а дыхание перехватывает от волнения...")

			saynn("[say=artica]О-ой.. эм-м.. ах.. ип!.. ах.. ах..[/say]")

			if (isNaked):
				saynn("Вскоре её тихий скулёж сменяется милыми стонами — член Артики становится всё тверже и тверже."+str(", the knot filling with blood.." if !isCaged else ".. well, trying to. The chastity cage prevents any kind of erection..")+"")

				saynn("[say=artica]П-погоди.. я сейчас.. ах-х.. это сл-лишком.. ах.. ах.. х-х~..[/say]")

				saynn("Пушинка уже была в предвкушении... так что эти ласки оказались для неё чересчур сильными.")

				saynn("С восторженным вскриком бедра Артики непроизвольно дернулись, всё её тело задрожало, когда мощный оргазм захлестнул её. Из её уст вырывается всё больше стонов, когда её член извергается, выбрасывая горячие струи спермы, которые разлетаются по всей нижней стороне стола...")

			else:
				saynn("Вскоре её тихие всхлипы сменяются милыми стонами, "+str("the cock in her shorts seems to be getting bigger and bigger, its pulsing knot filling with blood.." if !isCaged else "the locked cock in her shorts seems to be twitching quite a bit, desperately trying to fight the chastity cage..")+"")

				saynn("[say=artica]П-погоди.. я сейчас.. ах-х.. это сл-лишком.. ах.. ах.. х-х~..[/say]")

				saynn("Пушинка уже была в предвкушении... так что эти ласки оказались для неё чересчур сильными.")

				saynn("С судорожным вздохом удовольствия бёдра Артики непроизвольно дёрнулись, а всё её тело задрожало от мощного прилива оргазма. Из её губ вырывается всё больше стонов, когда её член извергается, выбрасывая горячие струи спермы, которые забрызгивают её собственные шорты и мех... Ой... может, тебе стоит стащить с неё одежду, чтобы она не испачкалась!")

		else:
			var theCockDesc = ("sheath" if !isCaged else "caged up cock")
			saynn("С едва заметной ухмылкой ты вытягиваешь ногу под столом, стремясь нежно "+str("brush Artica's crotch through the bulging shorts" if !isNaked else "stroke her "+theCockDesc)+" подошвой своей стопы.")

			saynn("Артика ахает, её глаза расширяются от неожиданности, а щеки заливает густой румянец. Она начинает ерзать на стуле, а дыхание перехватывает от волнения...")

			saynn("[say=artica]О-ой.. эм-м.. ах.. ип!.. ах.. ах..[/say]")

			if (isCaged):
				saynn("Ты продолжаешь дразнить её сочащийся член, пока тот не станет совсем твёрдым... ну... насколько это возможно внутри её милой маленькой клетки целомудрия. Лучше остановиться сейчас, иначе она кончит и потеряет желание.")

			else:
				saynn("Ты продолжаешь дразнить её сочащийся член, пока тот не станет совсем твёрдым... Лучше остановиться сейчас, иначе она кончит и потеряет желание.")

			if (isSlut):
				saynn("[say=artica]Нх-х.. п-почему ты з-замер?..[/say]")

				saynn("[say=pc]Потому что~.[/say]")

			else:
				saynn("[say=artica]Нх-х.. теперь я такая.. ах..[/say]")

				saynn("[say=pc]Умница.[/say]")

		saynn("После этого ты возвращаешься на привычное место Артики.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "go_eat"):
		processTime(15*60)
		GM.pc.afterEatingAtCanteen()
		setFlag("Canteen_PlayerAteToday", true)

	if(_action == "stealth_tease"):
		processTime(6*60)
		if(isLusty):
			getModule("ArticaModule").triggerCorruption(0.01)
			getCharacter("artica").cummedOnBy("artica")
		else:
			getModule("ArticaModule").makeLusty()

	if(_action == "force_crotchsniff"):
		processTime(10*60)
		if(isLusty):
			getModule("ArticaModule").triggerCorruption(0.01)
			getCharacter("artica").cummedOnBy("artica")
		else:
			getModule("ArticaModule").makeLusty()

	if(_action == "tease_offerfoot"):
		processTime(5*60)
		GM.pc.addLust(20)
		if(isLusty):
			getModule("ArticaModule").triggerCorruption(0.02)
			if(isNaked):
				getCharacter("artica").cummedInMouthBy("artica", FluidSource.Penis, 0.4)
			getCharacter("artica").cummedOnBy("artica")
		else:
			getModule("ArticaModule").makeLusty()

	if(_action == "just_nom"):
		processTime(20*60)

	setState(_action)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy

	return data

func loadData(data):
	.loadData(data)

	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
