extends Reference
class_name SexVoice

static func domReactToSubBodypart(_bodypart, _sexEngine, _domInfo, _subInfo) -> String:
	var _dom = _domInfo.getChar()
	var _sub = _subInfo.getChar()
	var domIsAngry = _domInfo.isAngry()
	var domIsMean = _domInfo.personalityScore({PersonalityStat.Mean:1.0})>0.4
	
	var possible = []
	
	if(_bodypart is BodypartBreasts):
		var lustInterets:LustInterests = _dom.getLustInterests()
		var likesBigBreasts = lustInterets.getTopicValue(InterestTopic.BigBreasts, _sub)
		var likesAverageBreasts = lustInterets.getTopicValue(InterestTopic.MediumBreasts, _sub)
		var likesSmallBreasts = lustInterets.getTopicValue(InterestTopic.SmallBreasts, _sub)
		var likesLactation = lustInterets.getTopicValue(InterestTopic.LactatingBreasts, _sub)
		#var likesFlatBreasts = lustInterets.getTopicValue(InterestTopic.NoBreasts, _sub)
		
		if(likesLactation > 0.2):
			possible.append_array([
				"Ого, какие же у тебя красивые "+RNG.pick(["breasts", "tits"])+" наливные груди!",
				"Обожаю то, как течет твое молоко, это просто завораживает.",
				"Меня всегда тянуло к кормящей груди.",
				"Лактирующая грудь — это невероятно сексуально.",
				"Меня всегда заводила "+RNG.pick(["breasts", "tits"])+".",
			])
		elif(likesLactation < -0.2):
			possible.append_array([
				"Тебе должно быть стыдно за то, что ты кормишься на людях. Это просто мерзко.",
				"Лактация меня не особо прельщает. Не моё.",
				"Терпеть не могу вид сочащейся груди. Это так противно.",
				"Никогда не понимал, чем так привлекательна грудь с молоком.",
			])
		
		if(likesBigBreasts > 0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Ну надо же, посмотрите на их размер! Да ими можно всю космическую станцию накормить "+RNG.pick(["melons", "tits", "гигантские сиськи", "breasts", "гигантская грудь"])+".",
					"Ого, не думала, что у кого-то могут быть такие огромные "+RNG.pick(["tits", "breasts", "melons"])+". С таким богатством тебе точно не скучно.",
					"Даже не знаю, впечатлиться мне или испугаться твоих этих массивных молочных желез.",
					"Спорим, у этих крошек есть собственное гравитационное поле.",
					"Бьюсь об заклад, эти штучки могут проломить мужской череп, если ты обнимешь слишком сильно. Осторожнее с этим оружием массового отвлечения внимания.",
					"У тебя, должно быть, спина постоянно болит от "+RNG.pick(["breasts", "tits"])+" такого размера. Но они мне чертовски нравятся.",
				])
			else:
				possible.append_array([
					"О да. Я бы с удовольствием посмотрела, на что способны эти лапочки.",
					"О да, от больших, прыгучих просто невозможно оторваться "+RNG.pick(["tits", "breasts", "jugs"])+".",
					"Я мог бы пялиться на эти гиганты "+RNG.pick(["tits", "breasts", "jugs"])+" целый день.",
					"Вот это другое дело. Шикарные изгибы.",
					"Боже мой, твоя грудь просто сногсшибательна!",
					"А у тебя впечатляющие формы.",
					"Знаешь, что говорят про "+RNG.pick(["breasts", "tits"])+"? Чем больше, тем лучше.",
					"Не знаю, в чем твой секрет, но эти "+RNG.pick(["breasts", "tits"])+" просто великолепны. Я в восторге.",
				])
		if(likesBigBreasts < -0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Бьюсь об заклад, тебе тяжело даже двигаться с такой тяжестью.",
					"Серьезно, избавься от этих чудовищ. Без них тебе будет куда лучше.",
					"Терпеть не могу пялиться на эту огромную грудь. Она просто гротескная.",
					"Эти гигантские молочные железы — просто какой-то абсурд. Избавься от них.",
					"Ну почему у некоторых женщин такие огромные сиськи? Это же противно.",
					"Просто не могу смотреть на эти "+RNG.pick(["giant", "large"])+" "+RNG.pick(["tits", "breasts"])+". Мерзость.",
				])
			else:
				possible.append_array([
					"Не фанат гигантских "+RNG.pick(["tits", "breasts"])+". Выглядят так неудобно и неестественно.",
					"Large "+RNG.pick(["tits", "breasts"])+" — это сплошная морока, которая только мешается.",
					"Ого. А мне больше нравится естественный и скромный вид.",
					"I don't like "+RNG.pick(["giant", "large"])+" "+RNG.pick(["tits", "breasts"])+". Они просто слишком огромные для меня.",
					RNG.pick(["Гигантский", "Большой"])+" "+RNG.pick(["tits", "breasts"])+" , к сожалению, меня не заводят.",
					"Гигантские дуры — это уже перебор на мой вкус.",
				])
		
		if(likesAverageBreasts > 0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Наконец-то кто-то с "+RNG.pick(["normal", "average"])+" "+RNG.pick(["tits", "breasts"])+". Мне надоело видеть либо плоские груди, либо просто необъятные "+RNG.pick(["ones", "melons"])+".",
					"Терпеть не могу эти фальшивые, раздутые сиськи, которые сейчас у всех на слуху. Дайте мне обычную пару "+RNG.pick(["tits", "breasts"])+" в любой день.",
					"Наконец-то пара "+RNG.pick(["tits", "breasts"])+" которые не размером с арбуз.",
					"Пора бы уже появиться кому-то с нормальной грудью.",
					"Так надоели эти огромные, фальшивые "+RNG.pick(["tits", "breasts"])+". Но твои — как раз по моим стандартам.",
				])
			else:
				possible.append_array([
					"У меня слабость к средним по размеру "+RNG.pick(["tits", "breasts"])+", и твои просто прелестны.",
					"Your "+RNG.pick(["tits", "breasts"])+" очень красивые. Не слишком большие и не слишком маленькие. В самый раз.",
					"Oh, great "+RNG.pick(["tits", "breasts"])+". Лучше и не пожелаешь.",
					"Не слишком острые, не слишком круглые, в самый раз наполненные.",
					"В подтянутой груди есть что-то невероятно манящее.",
					"Я просто таю от хорошенькой "+RNG.pick(["tits", "breasts"])+".",
					"Я большой фанат пропорциональной "+RNG.pick(["tits", "breasts"])+".",
				])
		elif(likesAverageBreasts < -0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Поверить не могу, что некоторых устраивает такая посредственная "+RNG.pick(["размер груди", "tits", "breasts"])+". Это просто жалко.",
					"Зачем вообще соглашаться на средненькую "+RNG.pick(["размер груди", "tits", "breasts"])+"? Такое ощущение, что им вообще плевать на сексуальность.",
					"Your "+RNG.pick(["tits", "breasts"])+" такие... заурядные. И чего я вообще ожидала.",
					"Лучше уж быть плоской, чем иметь среднюю "+RNG.pick(["tits", "breasts"])+". Это хотя бы выглядело бы уникально и интересно, а не как этот скучный и унылый средний размер.",
				])
			else:
				possible.append_array([
					"Дай мне хоть что-то интересное для глаз, а не эти стандартные "+RNG.pick(["tits", "breasts"])+".",
					"Знаю, кому-то твоя грудь может показаться привлекательной, но для меня она просто пресная и неинтересная.",
					"Хм. Ничего особенного, глаз совсем не цепляет.",
					"Не фанат твоих "+RNG.pick(["tits", "breasts"])+".",
				])
		
		if(likesSmallBreasts > 0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Не расстраивайся, дорогуша. Уверена, у тебя есть другие достоинства, которые компенсируют отсутствие пышного бюста. Ну, или нет, но какая разница?",
					"I adore "+RNG.pick(["tiny", "small"])+" "+RNG.pick(["tits", "breasts"])+". Они такие милые и очаровательные, прямо как маленькие игрушки, с которыми можно поиграть.",
					"Спорим, их едва можно удержать в ладонях. Ха-ха.",
					"Им вообще нужен лифчик? Они такие крошечные.",
					"Я всегда думала, что чем больше, тем лучше, но эти малюсенькие сиськи такие милые.",
					"Спорим, они не мешаются так, как большие. Везучая.",
					"Они вообще хоть когда-нибудь мешают? Они такие крошечные.",
				])
			else:
				possible.append_array([
					"Я обожаю маленькую грудь. Это так сексуально и женственно.",
					"Не могу налюбоваться этими упругими маленькими сиськами. Они просто прелесть.",
					"Естественные и красивые, просто супер "+RNG.pick(["tits", "breasts"])+".",
					"Меня всегда тянуло к миниатюрным "+RNG.pick(["tits", "breasts"])+".",
					"Никогда не понимал этой одержимости огромными "+RNG.pick(["tits", "breasts", "melons"])+". Мне кажется, маленькие куда более элегантные и изящные.",
					"Обожаю маленькие "+RNG.pick(["tits", "breasts"])+".",
					"Small "+RNG.pick(["tits", "breasts"])+" такие милашки.",
					"Твои маленькие "+RNG.pick(["tits", "breasts"])+" идеального размера.",
					"Маленькие, да удаленькие, да?",
				])
		elif(likesSmallBreasts < -0.2):
			if(domIsAngry || domIsMean):
				possible.append_array([
					"Эти крошечные штучки? Удивлен, что их вообще можно назвать грудью.",
					"Фу, это ещё что? Комары у тебя на груди?",
					"Твою грудь почти не видно. Как прямая линия на кардиограмме.",
					"Тебя, должно быть, оставили на распродаже в магазине нижнего белья.",
					"Спорим, тебе приходится набивать лифчик, чтобы хоть как-то создать видимость?",
					"Да их даже грудью назвать сложно... "+RNG.pick(["tits", "breasts"])+"... Это скорее похоже на комариные укусы.",
					"Бьюсь об заклад, ты мечтаешь о размере побольше, "+RNG.pick(["tits", "breasts"])+"... Жаль только, что тебе достались эти крохи.",
				])
			else:
				possible.append_array([
					"Хорошо бы они были побольше. Но ладно, что поделать.",
					"Мне нужно за что-то ухватиться.",
					"Мне больше нравятся фигуры попышнее.",
					"Ой, да ладно, ничего особенного.",
					"Small "+RNG.pick(["tits", "breasts"])+" просто не делай это ради меня.",
					"Aw. Small "+RNG.pick(["tits", "breasts"])+" не сексуальны для меня.",
				])
		
	if(_bodypart is BodypartAnus && RNG.chance(30)):
		var lustInterets:LustInterests = _dom.getLustInterests()
		var likesTightAnus = lustInterets.getTopicValue(InterestTopic.TightAnus, _sub)
		var likesLooseAnus = lustInterets.getTopicValue(InterestTopic.LooseAnus, _sub)
		
		if(likesTightAnus > 0.3):
			possible.append_array([
				"Твоя узкая "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" чертовски соблазняет, врать не буду.",
				RNG.pick(["Приятно", "Отлично"])+" "+RNG.pick(["butt", "butthole", "ass"])+" у тебя. Люблю, когда дырки тугие.",
				"Ohh. Your "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" такая узкая и идеальная.",
			])
		elif(likesTightAnus < -0.3):
			possible.append_array([
				"Не фанат этой чрезмерной узкости. Мне больше нравится, когда анус выглядит растянутым.",
				"Не понравится: твоя дырка слишком узкая на мой вкус.",
				"В чем вообще прикол "+RNG.pick(["anuses", "buttholes", "butts", "asses"])+" узких?",
			])
		
		if(likesLooseAnus > 0.3):
			possible.append_array([
				"Твоя растянутая "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" чертовски горячая, не буду врать.",
				"Huh, your "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" выглядит очень сочной, обожаю.",
				"О, а мне нравятся широкие, раззявленные, "+RNG.pick(["anuses", "buttholes", "butts", "asses"])+".",
				"О да, туда "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" влезет куча "+RNG.pick(["dicks", "cocks"])+".",
			])
		elif(likesLooseAnus < -0.3):
			possible.append_array([
				"Зачем кому-то хотеть, чтобы их "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+" выглядело вот так?",
				"Не понимаю, чем так притягательна "+RNG.pick(["растянутая", "gaping"])+" "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"]),
				"Сколько там было членов? "+RNG.pick(["anus", "tailhole", "ass", "butt", "butthole"])+"? Выглядит так, будто всё разболтано.",
				"Не фанат таких расхлябанных "+RNG.pick(["anuses", "buttholes", "butts", "asses"])+".",
				"Не уверена, насколько это сексуально, "+RNG.pick(["stretched", "loose"])+" "+RNG.pick(["anuses", "buttholes", "butts", "asses"])+" look.",
			])
	
	if(_bodypart is BodypartVagina && RNG.chance(80)):
		var lustInterets:LustInterests = _dom.getLustInterests()
		var likesTightVagina = lustInterets.getTopicValue(InterestTopic.TightPussy, _sub)
		var likesLooseVagina = lustInterets.getTopicValue(InterestTopic.LoosePussy, _sub)
		
		if(likesTightVagina > 0.3):
			possible.append_array([
				"Твоя узкая "+RNG.pick(["pussy", "slit", "щель киски"])+" чертовски соблазняет, врать не буду.",
				RNG.pick(["Приятно", "Отлично"])+" "+RNG.pick(["pussy", "slit", "щель киски"])+" какой он у тебя. Мне нравятся узкие.",
				"Ohh. Your "+RNG.pick(["pussy", "slit", "щель киски"])+" такая узкая и идеальная.",
			])
		elif(likesTightVagina < -0.3):
			possible.append_array([
				"Не люблю этот эффект чрезмерной тесноты. Мне нравится, когда киска выглядит растянутой.",
				"Вряд ли понравится, твоя киска слишком узкая на мой вкус.",
				"В чем вообще прикол "+RNG.pick(["pussies", "slits"])+" узких?",
			])
		
		if(likesLooseVagina > 0.3):
			possible.append_array([
				"Твоя растянутая "+RNG.pick(["snatch", "pussy", "щель киски"])+" чертовски горячая, не буду врать.",
				"Huh, your "+RNG.pick(["pussy", "vulva"])+" выглядит очень сочной, обожаю.",
				"О, а мне нравятся широкие, раззявленные, "+RNG.pick(["cunts", "pussies", "slits"])+".",
				"О да, туда "+RNG.pick(["pussy", "slit", "cunt"])+" влезет куча "+RNG.pick(["dicks", "cocks"])+".",
			])
		elif(likesLooseVagina < -0.3):
			possible.append_array([
				"Зачем кому-то хотеть, чтобы их "+RNG.pick(["labia", "pussy", "щель киски", "складки киски"])+" выглядело вот так?",
				"Не понимаю, чем так притягательна "+RNG.pick(["растянутая", "gaping"])+" "+RNG.pick(["pussy", "slit", "щелочка"]),
				"Сколько там было членов? "+RNG.pick(["cunt", "щель киски", "pussy"])+"? Выглядит так, будто всё разболтано.",
				"Не фанат таких расхлябанных "+RNG.pick(["pussies", "vaginas", "slits", "cunts"])+".",
				"Не уверена, насколько это сексуально, "+RNG.pick(["stretched", "loose"])+" "+RNG.pick(["pussies", "cunts", "slits"])+" look.",
			])

	if(_bodypart is BodypartPenis):
		var lustInterets:LustInterests = _dom.getLustInterests()
		
		var likesBigCock = lustInterets.getTopicValue(InterestTopic.BigCock, _sub)
		var likesAverageCock = lustInterets.getTopicValue(InterestTopic.AverageCock, _sub)
		var likesSmallCock = lustInterets.getTopicValue(InterestTopic.SmallCock, _sub)
		
		if(_sub.isWearingChastityCage()):
			if(domIsMean || domIsAngry):
				possible.append_array([
					"Это что, девственная клетка? Ха! Спорим, ты даже без ключа её не снимешь. Лузер.",
					"Поверить не могу, что ты разгуливаешь с этой штукой. Должно быть, тебе дико стыдно. Так тебе и надо, извращенец.",
					"Похоже, чьи-то причиндалы под замком. Наверное, это кайф — быть таким подавленным и несчастным.",
					"Какая трата металла. Хотя, должно быть, ты в отчаянии. И это хорошо.",
					"Ну, полагаю, это один из способов гарантировать, что ты случайно не размножишься.",
					"Ха! Похоже, кто-то был плохой шлюшкой и заслужил наказание. Так тебе и надо.",
				])
			else:
				possible.append_array([
					"Спорим, эта клетка отлично помогает держать тебя в узде.",
					"Клетка сидит на тебе идеально.",
				])
				if(likesBigCock > 0.1 || likesAverageCock > 0.1 || likesSmallCock > 0.1):
					possible.append_array([
						"Ого, а у тебя симпатичная девственная клетка.",
						"Не могу не любоваться тем, как эта клетка обхватывает твой член. Это очень сексуально.",
						"Мне нравится твой "+RNG.pick(["cock", "dick"])+". Жаль только, что он в клетке.",
						"Классная клетка для классного "+RNG.pick(["cock", "dick"])+". Выглядит так, будто её сделали специально для тебя.",
						"Обычно я не фанатка девайсов для целомудрия, но на тебе это смотрится отлично."
					])
				else:
					possible.append_array([
						"Должна сказать, мне это не очень нравится. По-моему, это слишком сковывает и доставляет дискомфорт.",
						"Славная клетка. Не скажу, что мне нравится твой "+RNG.pick(["dick", "cock"])+" , так что я рада, что ты заперт.",
					])
		
		if(likesBigCock > 0.1):
			possible.append_array([
				"Ого, а это впечатляющий "+RNG.pick(["dick", "cock", "монструозный член"]),
				"Просто поверить не могу, какой ты огромный. Я впечатлена.",
				"Не думала, что они такие огромные. Ого.",
				"Спорим, с ними очень весело возиться.",
				"Не знала, что они бывают такими большими. Я впечатлена.",
				"Мне нравится твой "+RNG.pick(["dick", "cock"])+"... Это просто идеально.",
				"Ох, размер в самый раз. Класс.",
				"Мне нравится твой размер. Мне он идеально подходит.",
				"Nice "+RNG.pick(["cock", "dick"])+" у тебя там.",
				"Мне нравится твой "+RNG.pick(["cock", "dick"])+".",
			])
		elif(likesBigCock < -0.1):
			if(domIsMean || domIsAngry):
				possible.append_array([
					"Чем ты пытаешься компенсировать эту штуковину? У тебя, должно быть, серьезные комплексы.",
					"Бьюсь об заклад, ты привык отпугивать людей этим агрегатом. Должно быть, непросто найти того, кого это реально заводит.",
					"Я думала, размер не так уж важен, но теперь вижу, что это всё, что у тебя есть. Жалкое зрелище.",
					"Не знала, что они бывают такими огромными. Честно говоря, я в шоке.",
				])
			else:
				possible.append_array([
					"Видела и побольше, так что не пытайся впечатлить меня этим.",
					"У меня были и покрупнее, так что не думай, что ты какой-то особенный.",
					"Не особо люблю огромные члены, от них скорее больно, чем приятно.",
					"Хм. Твой член ничего особенного. Но сойдет.",
				])
		if(likesAverageCock > 0.1):
			possible.append_array([
				"Мне нравится твой "+RNG.pick(["dick", "cock"])+"... Это просто идеально.",
				"Ох, размер в самый раз. Класс.",
				"Мне нравится твой размер. Мне он идеально подходит.",
				"Nice "+RNG.pick(["cock", "dick"])+" у тебя там.",
				"Мне нравится твой "+RNG.pick(["cock", "dick"])+".",
			])
		elif(likesAverageCock < 0.1):
			if(domIsMean || domIsAngry):
				possible.append_array([
					"Meh. Your "+RNG.pick(["dick", "cock"])+" — ну такой себе, средненький.",
					"Видела стволы и получше, и поверь, твой не так уж впечатляет.",
					"Не фанатка среднего размера. "+RNG.pick(["dicks", "cocks"])+". Мда. Так себе.",
				])
			else:
				possible.append_array([
					"Your "+RNG.pick(["dick", "cock"])+" в лучшем случае — средний.",
					"Хм. Твой член ничего особенного. Но сойдет.",
					"Не то чтобы я фанатка среднего, "+RNG.pick(["dicks", "cocks"])+"но посмотрим.",
				])
		if(likesSmallCock > 0.1):
			if(domIsMean || domIsAngry):
				possible.append_array([
					"Ой, посмотрите на этого малыша, который пытается строить из себя крутого.",
					"Так мило, что ты считаешь эту крошку чем-то впечатляющим. Мечтай дальше, дружок.",
					"Ой, бедняжка. Бьюсь об заклад, тебя постоянно задирают из-за того, какой он маленький.",
					"Ого, осторожнее с презервативами на своем крошечном члене. Один неверный шаг, и он просто соскользнет.",
				])
			else:
				possible.append_array([
					"О-о-о, какой у тебя миленький член~.",
					"Мне нравится твой "+RNG.pick(["cock", "dick"])+"... Это просто идеально.",
					"Кому-то нравятся размеры побольше, но лично мне в маленьких пенисах есть что-то невероятно очаровательное.",
					"Вау, это самая милая крошка, которую я когда-либо видела! Обожаю, какой он крошечный и прелестный. Просто само очарование.",
					"О боже, я просто не могу налюбоваться этой твоей малюткой. Это так мило!",
					"Мне нравится твой "+RNG.pick(["dick", "cock"])+"... Это просто идеально.",
					"Ох, размер в самый раз. Класс.",
					"Мне нравится твой размер. Мне он идеально подходит.",
					"Nice "+RNG.pick(["cock", "dick"])+" у тебя там.",
					"Мне нравится твой "+RNG.pick(["cock", "dick"])+".",
				])
		elif(likesSmallCock < -0.1):
			if(domIsMean || domIsAngry):
				possible.append_array([
					"Не думаю, что смогу принять твой "+RNG.pick(["dick", "cock"])+" seriously.",
					"Ух, это совсем не то, чего я ожидала.",
					"Меня не впечатлило. Видела и побольше.",
					"Что это вообще такое? Это же почти не член!",
					"Отсюда его едва видно. И это всё, на что ты способен?",
					"Должно быть, ты очень комплексуешь из-за этой крохи.",
					"Похоже, чей-то "+RNG.pick(["dick", "cock"])+" сжался после стирки!"
				])
			else:
				possible.append_array([
					"Хм. Твой член ничего особенного. Но сойдет.",
					"Честно говоря, маленькие члены — это не моё.",
					"Ну, ты не то чтобы впечатляешь. Скорее наоборот.",
				])
			
	if(possible.size() > 0):
		return RNG.pick(possible)
	return ""

static func domReactionWhenUndressing(_bodypart, _sexEngine, _domInfo, _subInfo) -> String:
	var possible = []
	
	var domIsAngry = _domInfo.isAngry()
	var domIsMean = _domInfo.personalityScore({PersonalityStat.Mean:1.0})>0.4
	#var domIsVeryMean = _domInfo.personalityScore({PersonalityStat.Mean:1.0})>0.7
	
	if(_bodypart is BodypartPenis && RNG.chance(30)):
		if(domIsAngry || domIsMean):
			possible.append_array([
				"Видишь мой член? Хочешь поклоняться ему, как послушная шлюшка?",
				"Я заставлю тебя влюбиться в мой "+RNG.pick(["dick", "cock"])+", сучка.",
				"Уже слюни пускаешь, шлюшка?",
				"Вот так, а вот и мой член.",
				"Да ладно тебе, не стесняйся. Я же вижу, как тебе любопытно.",
			])
		else:
			possible.append_array([
				"Нравится то, что видишь? Это мой "+RNG.pick(["dick", "cock"])+".",
				"Нравится мой "+RNG.pick(["dick", "cock"])+"?",
				"Вот так-то лучше.",
				"Зацени мой "+RNG.pick(["dick", "cock"])+" out.",
			])
	
	if(possible.size() > 0):
		return RNG.pick(possible)
	return ""
