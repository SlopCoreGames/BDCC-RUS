extends Bodypart
class_name BodypartBreasts


var size = 0
var cached_size = 0
var fluidType:String = "Milk"

func _init():
	limbSlot = LimbTypes.Breasts
	initFluidProduction()
	setupSensitiveZone()
	needsProcessing = true

func initFluidProduction():
	fluidProduction = Lactation.new()
	fluidProduction.bodypart = weakref(self)

func setupSensitiveZone():
	sensitiveZone = preload("res://Player/SensitiveZone/SensitiveBreasts.gd").new()
	sensitiveZone.setBodypart(self)
	
func applyTFData(_data):
	.applyTFData(_data)
	
	size = loadTFVar(_data, "size", size)
	cached_size = getSize()
	fluidType = loadTFVar(_data, "fluidType", fluidType)
	
func saveData():
	var data = .saveData()
	data["size"] = size
	data["fluidType"] = fluidType
	
	return data

func loadData(_data):
	size = SAVE.loadVar(_data, "size", 0)
	fluidType = SAVE.loadVar(_data, "fluidType", "Milk")
	
	.loadData(_data)
	cached_size = getSize()

func loadDataNPC(_data):
	.loadDataNPC(_data)
	cached_size = getSize()

func getTraits():
	return {
		PartTrait.BreastsFemale: true,
	}

func getSlot():
	return BodypartSlot.Breasts

func getTooltipInfo():
	var result = []
	result.append("size: " + BreastsSize.breastSizeToCupString(getSize()))
	if(getFluidProduction() != null):
		result.append("Capacity: " + str(round(getFluidProduction().getFluidAmount() * 10.0)/10.0)+"/"+ str(round(getFluidProduction().getCapacity() * 10.0)/10.0)+" ml")
		result.append_array(getFluidProduction().getTooltipInfo())
	if(sensitiveZone != null):
		result.append_array(sensitiveZone.getInfo())
	
	return Util.join(result, "\n")

func getLewdSizeAdjective():
	if(size <= BreastsSize.FLAT):
		return "flat"
	if(size <= BreastsSize.A):
		return RNG.pick(["tiny", "miniature", "little", "petite", "delicate"])
	if(size <= BreastsSize.C):
		return RNG.pick(["small", "modest", "cute", "average", "natural", "bouncy"])
	if(size <= BreastsSize.DD):
		return RNG.pick(["perky", "generous", "ample", "rounded", "plump", "curvy"])
	if(size <= BreastsSize.G):
		return RNG.pick(["curvy", "rounded", "huge", "big", "generous", "alluring"])
	if(size <= BreastsSize.H):
		return RNG.pick(["curvy", "rounded", "huge", "big", "lavish", "voluminous", "heavy"])
	if(size <= BreastsSize.J):
		return RNG.pick(["large", "weighty", "curvy", "heavy", "impressive", "voluminous"])
	if(size <= BreastsSize.M):
		return RNG.pick(["massive", "heavy", "enormous"]) 
	return RNG.pick(["gigantic", "ginormous", "colossal"])
		

func getLewdAdjective():
	return RNG.pick(["soft", "squishy", "nice"])
	
func getLewdName():
	if(size <= BreastsSize.FLAT):
		return "breasts"
	
	if(size <= BreastsSize.D):
		return RNG.pick(["breasts", "boobs", "tits"])
	if(size <= BreastsSize.H):
		return RNG.pick(["breasts", "boobs", "tits", "funbags"])
	
	return RNG.pick(["breasts", "boobs", "tits", "melons", "jugs", "milkies", "milkers", "globes"])

func getLewdDescriptionAndName():
	var text = getLewdAdjective() + " " + getLewdSizeAdjective() + " " + getLewdName()
	return text

func getPickableAttributes():
	var result = .getPickableAttributes()
	var breastVariants = [
		[BreastsSize.FOREVER_FLAT, "Навсегда плоские", "Твоя грудь никогда не будет вырабатывать молоко или увеличиваться в размере"],
		[BreastsSize.FLAT, "Flat", "Плоская грудь"],
	]
	for breastSize in BreastsSize.getAll():
		if(breastSize <= BreastsSize.FLAT || breastSize > BreastsSize.J):
			continue
		breastVariants.append([breastSize, BreastsSize.breastSizeToString(breastSize), BreastsSize.breastSizeToCupString(breastSize)])
	
	result["breastsize"]= {
		"text": "Изменить размер груди",
		"textButton": "Размер груди",
		"buttonDesc": "Выбрать размер груди",
		"options": breastVariants,
		"default": size,
	}
	return result
	
func setBreastSizeSafe(newValue):
	size = newValue
	
func applyAttribute(_attrID: String, _attrValue):
	.applyAttribute(_attrID, _attrValue)
	if(_attrID == "breastsize"):
		size = _attrValue

func getAttributesText():
	return [
		["Размер груди", BreastsSize.breastSizeToString(getSize())],
	]

func getCharCreatorData():
	return [
		["size", size],
	]

func getBaseSize():
	return size

func getSize():
	var resultSize = getBaseSize()
	
	if(size != BreastsSize.FOREVER_FLAT && fluidProduction != null):
		resultSize = fluidProduction.getOptimalBreastsSize()
	return resultSize

func safeWhenExposed():
	return false

func induceLactation():
	if(fluidProduction != null && fluidProduction.has_method("induceLactation")):
		fluidProduction.induceLactation()

func processTime(_seconds: int):
	.processTime(_seconds)
	
	var newSize = getSize()
	if(cached_size != newSize):
		cached_size = newSize
		updateAppearance()

func getBreastsScale():
	return 1.0

# For animations
func getBreastsAdjustScale():
	var theSize = getSize()
	if(theSize <= BreastsSize.FLAT):
		return 0.0
	if(theSize >= BreastsSize.L):
		return 1.0
	var aScale = BreastsSize.breastSizeToBoneScale(BreastsSize.A)
	return (BreastsSize.breastSizeToBoneScale(theSize) - aScale) / (BreastsSize.breastSizeToBoneScale(BreastsSize.L) - aScale)

func getRevealMessage():
	return Util.capitalizeFirstLetter(getLewdDescriptionAndName()) + " был обнажен."

func getFluidType(_fluidSource) -> String:
	return fluidType

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} тепло разливается по {npc.yourHis} груди, и внезапно {npc.yourHis} грудь начинает набухать и менять форму, меняя свои контуры и текстуру. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
