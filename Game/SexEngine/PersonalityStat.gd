extends Object
class_name PersonalityStat

const Brat = "Brat"
const Mean = "Mean"
const Subby = "Subby"
const Impatient = "Impatient"
const Naive = "Naive"
const Coward = "Coward"

static func getAll():
	return [Brat, Mean, Subby, Impatient, Naive, Coward]

static func statExists(stat):
	return (stat in getAll())

static func getVisibleName(stat):
	if stat == Brat:
		return "Brat"
	elif stat == Mean:
		return "Mean"
	elif stat == Subby:
		return "Subby"
	elif stat == Impatient:
		return "Impatient"
	elif stat == Naive:
		return "Naive"
	elif stat == Coward:
		return "Coward"
	else:
		return "Error"

static func getVisibleDesc(stat, value):
	var texts = ["Ошибка"]
	
	match(stat):
		Brat:
			texts = ["Полная противоположность капризульки", "Полная противоположность капризульки", "Не капризная", "Не капризная", "Не капризная", "Немного капризная", "Капризная", "Очень капризная", "Та самая капризулька"]
		Mean:
			texts = ["Невероятно добрая", "Очень добрая", "Добрый", "Довольно добрая", "Слегка стервозная", "Злобность", "Очень стервозная", "Невероятно стервозная"]
		Subby:
			texts = ["Супер доминантная", "Доминант", "Довольно доминантная", "Свитч", "Слегка сабмиссивная", "Сабби", "Очень сабмиссивная"]
		Impatient:
			texts = ["Сверхтерпеливый", "Терпеливый", "Довольно терпеливый", "Довольно нетерпеливый", "Нетерпеливый", "Очень нетерпеливый"]
		Naive:
			texts = ["Очень проницательный", "Проницательная", "Слегка проницательный", "Слегка наивный", "Наивная", "Сверхнаивный"]
		Coward:
			texts = ["Сверхсмелый", "Очень смелый", "Смелый", "Немного смелый", "Слегка трусливый", "Трус", "Очень трусливый", "Запредельно трусливый"]
		
	var indx = Util.mini(int(floor((clamp(value, -1.0, 1.0)+1.0) / 2.0 * texts.size())), texts.size()-1)
	
	return texts[indx]
