extends Object
class_name LustFocus

const Body = "Body"
const Breasts = "Breasts"
const Butt = "Butt"
const Crotch = "Crotch"

static func getAll() -> Array:
	return [Body, Breasts, Butt, Crotch]

static func getButtonName(focus) -> String:
	if(focus == Body):
		return "Представить тело"
	if(focus == Breasts):
		return "Представить грудь"
	if(focus == Butt):
		return "Представить задницу"
	if(focus == Crotch):
		return "Представить промежность"
	
	return "Ошибка?"

static func getButtonDesc(focus) -> String:
	if(focus == Body):
		return "Показать своё тело!"
	if(focus == Breasts):
		return "Показать грудь!"
	if(focus == Butt):
		return "Подставить им свою задницу"
	if(focus == Crotch):
		return "Показать промежность и всё, что между ног"
	
	return "Ошибка?"
