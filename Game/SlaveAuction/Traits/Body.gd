extends AuctionTrait

func _init():
	ids = [
		"BodySlim",#
		"BodyAverage",#
		"BodyThick",#
		
		"Masculine",#
		"Androgynous",#
		"Feminine",#
		
		"BreastsSmall",#
		"BreastsAverage",#
		"BreastsHuge",#
		
		"PenisSmall",#
		"PenisAverage",#
		"PenisLong",#
		
		"VaginaTight",#
		"VaginaLoose",#
		
		"AnusTight",#
		"AnusLoose",#
		
		"Pregnant",#
	]

func getTraitType(_id:String):
	return AuctionTraitType.Body

func getName(_id:String) -> String:
	if(_id == "BodySlim"):
		return "Худощавое тело"
	if(_id == "BodyAverage"):
		return "Среднее телосложение"
	if(_id == "BodyThick"):
		return "Плотное тело"
	if(_id == "Masculine"):
		return "Мужское"
	if(_id == "Androgynous"):
		return "Андрогинный"
	if(_id == "Feminine"):
		return "Женское"
	if(_id == "BreastsSmall"):
		return "Маленькая грудь"
	if(_id == "BreastsAverage"):
		return "Средняя грудь"
	if(_id == "BreastsHuge"):
		return "Огромная грудь"
	if(_id == "PenisSmall"):
		return "Маленький член"
	if(_id == "PenisAverage"):
		return "Средний член"
	if(_id == "PenisLong"):
		return "Длинный член"
	if(_id == "VaginaTight"):
		return "Узкая киска"
	if(_id == "VaginaLoose"):
		return "Растянутая киска"
	if(_id == "AnusTight"):
		return "Узкий анус"
	if(_id == "AnusLoose"):
		return "Растянутый анус"
	if(_id == "Pregnant"):
		return "Беременная"
	
	return "ERROR"

func calculateScore(_id:String, _char:BaseCharacter) -> float:
	if(_id in ["BreastsSmall", "BreastsAverage", "BreastsHuge"]):
		var breasts = _char.getBodypart(BodypartSlot.Breasts)
		if(breasts == null):
			return 0.0
		var size = breasts.getSize()
		if(_id == "BreastsSmall"):
			if(size <= BreastsSize.B):
				return 1.0
		if(_id == "BreastsAverage"):
			if(size > BreastsSize.B && size <= BreastsSize.D):
				return 1.0
		if(_id == "BreastsHuge"):
			if(size > BreastsSize.D):
				return 1.0
		return 0.0
	
	if(_id in ["PenisSmall", "PenisAverage", "PenisLong"]):
		var penis = _char.getBodypart(BodypartSlot.Penis)
		if(penis == null):
			return 0.0
		var size = penis.getLength()
		if(_id == "PenisSmall"):
			if(size <= 11.0):
				return 1.0
		if(_id == "PenisAverage"):
			if(size > 11.0 && size <= 18.0):
				return 1.0
		if(_id == "PenisLong"):
			if(size > 18.0):
				return 1.0
		return 0.0
	
	if(_id in ["VaginaTight", "VaginaLoose"]):
		var vagina = _char.getBodypart(BodypartSlot.Vagina)
		if(vagina == null):
			return 0.0
		var orifice = vagina.getOrifice()
		if(orifice == null):
			return 0.0
		var looseness:float = orifice.getLooseness()
		if(_id == "VaginaTight"):
			if(looseness <= 2.0):
				return 1.0
		if(_id == "VaginaLoose"):
			if(looseness > 2.0):
				return 1.0
		return 0.0
	
	if(_id in ["AnusTight", "AnusLoose"]):
		var anus = _char.getBodypart(BodypartSlot.Anus)
		if(anus == null):
			return 0.0
		var orifice = anus.getOrifice()
		if(orifice == null):
			return 0.0
		var looseness:float = orifice.getLooseness()
		if(_id == "AnusTight"):
			if(looseness <= 2.0):
				return 1.0
		if(_id == "AnusLoose"):
			if(looseness > 2.0):
				return 1.0
		return 0.0
	
	if(_id == "Pregnant"):
		if(_char.isVisiblyPregnant()):
			return 1.0
	
	if(_id in ["BodySlim", "BodyAverage", "BodyThick"]):
		var thickness:float = _char.getThickness()/100.0
		if(_id == "BodySlim"):
			if(thickness <= 0.33):
				return 1.0
		if(_id == "BodyAverage"):
			if(thickness > 0.33 && thickness <= 0.66):
				return 1.0
		if(_id == "BodyThick"):
			if(thickness > 0.66):
				return 1.0
		return 0.0
			
	if(_id in ["Masculine", "Androgynous", "Feminine"]):
		var femininity:float = _char.getFemininity()/100.0
		if(_id == "Masculine"):
			if(femininity <= 0.4):
				return 1.0
		if(_id == "Androgynous"):
			if(femininity > 0.4 && femininity <= 0.6):
				return 1.0
		if(_id == "Feminine"):
			if(femininity > 0.6):
				return 1.0
		return 0.0
	
	return 0.0

func getBidderOutbidReactions(_id:String, _char:BaseCharacter) -> Array:
	if(_id == "BodySlim"):
		return [
			"Эта стройная фигурка будет идеально смотреться в моем ошейнике.",
			"Мне понравится подчинять это изящное тело своей воле.",
			"Это тугое маленькое тельце теперь полностью мое.",
			"Эта тонкая талия будет идеально смотреться в моих объятиях.",
		]
	if(_id == "BodyAverage"):
		return [
			"Сильное и гибкое — как раз в моем вкусе.",
			"Это тело — именно то, что мне нужно.",
		]
	if(_id == "BodyThick"):
		return [
			"Это пышное тело создано для наслаждения, и оно будет моим.",
			"Эти бедра будут идеально ощущаться под моими руками.",
			"Эта задница и эти бедра принадлежат мне, и больше никому.",
		]
	if(_id == "Masculine"):
		return [
			"Это сильное мужское тело скоро склонится предо мной.",
			"Я заставлю эту гору мышц преклонить передо мной колени.",
			"Мне нужно это тело.",
		]
	if(_id == "Androgynous"):
		return [
			"Мне нужно это тело.",
			"Я буду смаковать это.",
		]
	if(_id == "Feminine"):
		return [
			"Эта красотка скоро окажется подо мной.",
			"Никто не прикоснется к этому нежному, изысканному телу, кроме меня.",
			"Эта девчачья фигурка будет моей.",
			"Именно я буду наслаждаться {slave.him}.",
		]
	if(_id == "BreastsSmall"):
		return [
			"Эти маленькие сиськи просто созданы для моих рук.",
			"Эта миниатюрная грудь — именно то, что мне нужно.",
			"Эта крошечная грудь будет только моей.",
			"Эти маленькие, упругие сиськи будут идеально смотреться под моим телом.",
		]
	if(_id == "BreastsAverage"):
		return [
			"Эти идеальные сиськи скоро станут моими.",
			"Эта грудь будет полностью моей.",
			"Идеальные сиськи, и скоро они будут в моих руках.",
		]
	if(_id == "BreastsHuge"):
		return [
			"Эти огромные сиськи — мои.",
			"Именно я буду наслаждаться этими гигантскими сиськами.",
			"Эти сиськи стоят каждого кредита, так что отвалите.",
			"Эти большие, мягкие сиськи скоро будут принадлежать мне.",
		]
	if(_id == "PenisSmall"):
		return [
			"Этим крошечным членом будет весело помыкать.",
			"Этот крошечный член я сломаю лично.",
			"Эта малявка будет умолять о разрядке.",
			"Я найду этому маленькому члену достойное применение.",
		]
	if(_id == "PenisAverage"):
		return [
			"Этот член будет служить мне идеально.",
			"Этот член принадлежит мне, и я буду делать с ним всё, что захочу.",
			"Я заставлю этот член запомнить, кому он принадлежит.",
			"Такой крепкий член скоро будет повиноваться любому моему капризу.",
		]
	if(_id == "PenisLong"):
		return [
			"Этот член будет полностью под моим контролем.",
			"Никто больше не прикоснётся к этому сочному члену.",
			"Этот толстый длинный член станет моим.",
			"Я буду скакать на этом длинном члене, пока он полностью не станет моим.",
		]
	if(_id == "VaginaTight"):
		return [
			"Эта узкая киска скоро будет принадлежать мне.",
			"Я растяну эту тесную киску, пока она не станет моей.",
			"Я заберу эту узкую киску себе.",
			"Эта киска будет идеально сжиматься вокруг меня.",
			"Именно я заберу эту тесную щель.",
		]
	if(_id == "VaginaLoose"):
		return [
			"Эта киска будет идеальна для меня.",
			"Эта киска примет меня целиком и полностью.",
			"Я буду торговаться за эту щель, пока она не станет моей.",
			"Эта киска скоро узнает, для чего она была создана.",
		]
	if(_id == "AnusTight"):
		return [
			"Эта тугая жопка теперь принадлежит мне.",
			"Я подчиню себе это узкое отверстие.",
			"Эта крошечная дырочка будет умолять о добавке.",
			"Эта задница прочувствует каждый мой дюйм.",
		]
	if(_id == "AnusLoose"):
		return [
			"Эта жопка примет всё, что я ей дам.",
			"Я заставлю эту дырочку запомнить этот день.",
			"Эту задницу растянут до совершенства.",
			"Эта дырка будет моей, без вариантов.",
		]
	if(_id == "Pregnant"):
		return [
			"Такая беременная шлюха — редкость, и она будет моей.",
			"Я скоро займусь этим беременным тельцем.",
			"Беременная и покорная? Она полностью моя.",
			"Этот круглый животик и налитая грудь будут принадлежать только мне.",
		]
		
	return []
