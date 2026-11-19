extends Object
class_name ContentType

const RiskyCondoms = "RiskyCondoms"
const Watersports = "Watersports"
const CumInflation = "CumInflation"
const CumStealing = "CumStealing"
const ForcedPermanentTFs = "ForcedPermanentTFs"

static func getVisibleName(contentType):
	if(contentType == RiskyCondoms):
		return "Рискованные презервативы"
	if(contentType == Watersports):
		return "Уролагния (Watersports)"
	if(contentType == CumInflation):
		return "Инфляция спермы"
	if(contentType == CumStealing):
		return "Кража спермы"
	if(contentType == ForcedPermanentTFs):
		return "Принудительные постоянные ТФ"
	
	return "Error"

static func getDescription(contentType):
	if(contentType == RiskyCondoms):
		return "Если включено, презервативы могут порваться при использовании. Если выключено — они никогда не рвутся."
	if(contentType == Watersports):
		return "Контент, включающий использование мочи в любом виде."
	if(contentType == CumInflation):
		return "Ваш живот будет выглядеть раздутым, если в вас кончит слишком много людей."
	if(contentType == CumStealing):
		return "Позволяет иногда обмениваться спермой с другими во время триббинга."
	if(contentType == ForcedPermanentTFs):
		return "Если включено, NPC будут иногда пытаться насильно скормить вам таблетку (MorphIn), которая сделает ваши трансформации постоянными. Отключение этого режима НЕ отключает ТФ-контент в целом."
	
	return "Описание отсутствует"

static func getAll():
	return [RiskyCondoms, Watersports, CumInflation, CumStealing, ForcedPermanentTFs]

static func isDisabledByDefault(contentType):
	if(contentType == Watersports):
		return true
	if(contentType == ForcedPermanentTFs):
		return true
	
	return false
