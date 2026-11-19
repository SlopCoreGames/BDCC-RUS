extends AuctionTrait

func _init():
	ids = [
		"FetishSexBottom",#
		"FetishSexTop",#
		"FetishSexExotic",#
		
		"FetishBDSM",#
		"FetishMilking",#
		"FetishExhibitionism",#
		"FetishDrugUse",#
	]

func getTraitType(_id:String):
	return AuctionTraitType.Fetish

func getName(_id:String) -> String:
	if(_id == "FetishSexBottom"):
		return "Секс-игрушка (Низ)"
	if(_id == "FetishSexTop"):
		return "Секс-игрушка (Верх)"
	if(_id == "FetishSexExotic"):
		return "Секс-игрушка (Экзотика)"
		
	if(_id == "FetishBDSM"):
		return "БДСМ-фетиш"
	if(_id == "FetishMilking"):
		return "Фетиш на дойку"
	if(_id == "FetishExhibitionism"):
		return "Эксгибиционист"
	if(_id == "FetishDrugUse"):
		return "Наркоман"
	
	return "ERROR"

func calculateScore(_id:String, _char:BaseCharacter) -> float:
	if(_id == "FetishSexBottom"):
		var fetishes:Dictionary = {
			Fetish.AnalSexReceiving: 1.0,
			Fetish.OralSexReceiving: 1.0,
		}
		if(_char.hasAnyWomb()):
			fetishes[Fetish.BeingBred] = 1.0
		if(_char.hasVagina()):
			fetishes[Fetish.VaginalSexReceiving] = 1.0
		
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishSexTop"):
		var fetishes:Dictionary = {
			Fetish.AnalSexGiving: 1.0,
			Fetish.VaginalSexGiving: 1.0,
			Fetish.StraponSexAnal: 1.0,
			Fetish.StraponSexVaginal: 1.0,
			Fetish.OralSexGiving: 1.0,
		}
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishSexExotic"):
		var fetishes:Dictionary = {
			Fetish.FeetplayGiving: 1.0,
			Fetish.FeetplayReceiving: 1.0,
			Fetish.RimmingGiving: 1.0,
			Fetish.RimmingReceiving: 1.0,
			Fetish.Tribadism: 1.0,
			Fetish.UnconsciousSex: 1.0,
			Fetish.Condoms: 1.0,
		}
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishBDSM"):
		var fetishes:Dictionary = {
			Fetish.Bondage: 1.0,
			Fetish.Rigging: 1.0,
			Fetish.Bodywritings: 0.5,
			Fetish.Choking: 0.5,
			Fetish.Masochism: 1.0,
			Fetish.Sadism: 1.0,
			Fetish.HypnosisHypnotist: 0.3,
			Fetish.HypnosisSubject: 0.3,
		}
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishMilking"):
		var fetishes:Dictionary = {
			Fetish.SeedMilking: 1.0,
			Fetish.Lactation: 1.0,
		}
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishExhibitionism"):
		var fetishes:Dictionary = {
			Fetish.Exhibitionism: 1.0,
		}
		return calculateFetishScore(_char, fetishes)
	if(_id == "FetishDrugUse"):
		var fetishes:Dictionary = {
			Fetish.DrugUse: 1.0,
		}
		return calculateFetishScore(_char, fetishes)

	
	return 0.0

func getBidderOutbidReactions(_id:String, _char:BaseCharacter) -> Array:
	if(_id == "FetishSexBottom"):
		return [
			'Я как следует сломаю {slave.him}.',
			'Эта жопа будет принадлежать мне для траха.',
			'{slave.HeShe} станет идеальной секс-игрушкой.',
			'Я буду трахать {slave.him} до тех пор, пока {slave.he} не начнет умолять.',
			'{slave.HeShe} принадлежит мне, чтобы её осеменили.',
			'Я лично позабочусь о дырочках {slave.his}.',
		]
	if(_id == "FetishSexTop"):
		return [
			'{slave.HeShe} будет главной в моей постели.',
			'{slave.HeShe} может трахать меня когда угодно.',
			'Мне нужно, чтобы {slave.him} была сверху.',
			'{slave.HeShe} будет доминировать надо мной, когда я сам того пожелаю.',
			'{slave.HeShe} станет идеальной служанкой для минета.',
			'Мне бы пригодился такой отличный заводчик.',
		]
	if(_id == "FetishSexExotic"):
		return [
			'Мне понравится исследовать каждый дюйм {slave.him}.',
			'{slave.HeShe} — это уникальное лакомство.',
			'{slave.HeShe} должна стать частью моей коллекции.',
			'{slave.HeShe} удовлетворит мои редкие вкусы.',
		]
		
	if(_id == "FetishBDSM"):
		return [
			'Я покажу {slave.him}, что такое настоящая дисциплина.',
			'{slave.HeShe} будет умолять о новой порции боли.',
			'{slave.HeShe} станет моей личной мазохисткой.',
			'Посмотрим, сколько сможет вытерпеть {slave.he}.',
			'{slave.HeShe} будет обожать плеть в моих руках.',
			'Я приучу {slave.him} жаждать боли.',
		]
	if(_id == "FetishMilking"):
		return [
			'Я буду доить {slave.him} досуха каждый божий день.',
			'{slave.HeShe} станет моей личной молочной фермой.',
			'Не терпится увидеть, как {slave.him} течет.',
			'{slave.HeShe} идеально подходит для дойки.',
			'Я превращу {slave.him} в настоящую молочную машину.',
		]
	if(_id == "FetishExhibitionism"):
		return [
			'Я выставлю {slave.him} на всеобщее обозрение.',
			'{slave.HeShe} будет в центре всеобщего внимания.',
			'Я заставлю {slave.him} выступать перед каждым.',
			'{slave.HeShe} станет моей публичной игрушкой.',
			'{slave.HeShe} обожает, когда на неё смотрят, и я позабочусь о том, чтобы {slave.he} смотрел.',
			'Все увидят, как сильно {slave.he} это нравится.',
		]
	if(_id == "FetishDrugUse"):
		return [
			'Я подсажу {slave.him} на крючок на всю жизнь.',
			'Я буду постоянно подпитывать зависимость {slave.his}.',
			'{slave.HeShe} долго не протянет без моей «дозы».',
			'{slave.HeShe} будет каждый день умолять меня о новой порции.',
		]
		
	return []
