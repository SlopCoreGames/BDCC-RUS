extends Object
class_name BodilyFluids

static func getFluidName(fluidID):
	var fluid = GlobalRegistry.getFluid(fluidID)
	if(fluid == null):
		return "ERROR:BADFLUID"
	return fluid.getVisibleName()

static func getFluidLewdName(fluidID):
	var fluid = GlobalRegistry.getFluid(fluidID)
	if(fluid == null):
		return "ERROR:BADFLUID"
	return fluid.getLewdName()

enum MessinessLevel {
	Clean = 0,
	SlightlyMessy = 1,
	Messy = 2,
	VeryMessy = 3,
	CumRag = 4,
	CumDump = 5,
}
const MaxMessinessLevel = 5

static func getOutsideMessinessMessage(messLevel, fluids: Array):
	var names = []
	for fluid in fluids:
		names.append(getFluidName(fluid))
	var humanReadableString = Util.humanReadableList(names)
	if(names.size() == 0):
		humanReadableString = "nothing"
		
	if(messLevel <= MessinessLevel.Clean):
		return "Ты абсолютно чист(а)"
	if(messLevel == MessinessLevel.SlightlyMessy):
		return "Ты весь/вся покрыт(а) "+humanReadableString
	if(messLevel == MessinessLevel.Messy):
		return "Некоторые части твоего тела и лица покрыты "+humanReadableString+", ну ты и мокрое недоразумение"
	if(messLevel == MessinessLevel.VeryMessy):
		return "Почти всё твоё тело и лицо покрыты "+humanReadableString+". Волосы, уши, руки, ноги — всё в этом, ты просто ходячая катастрофа"
	if(messLevel == MessinessLevel.CumRag):
		return "Свободного места нет, ты весь/вся залеплен(а) " + humanReadableString+". Всё это так и стекает с тебя при каждом шаге!"
	if(messLevel >= MessinessLevel.CumDump):
		return "Твоё тело покрыто слоями "+ humanReadableString+", тонкие струйки свисают с ушей и подбородка, волосы насквозь промокли. Ты чувствуешь вкус жидкости, когда она стекает по лицу, губам и прямо в рот"
