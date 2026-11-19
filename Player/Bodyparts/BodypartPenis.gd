extends Bodypart
class_name BodypartPenis

var lengthCM: float = 15
var ballsScale: float = 1.0
var fluidType:String = "Cum"

func _init():
	limbSlot = LimbTypes.Penis
	initFluidProduction()
	setupSensitiveZone()
	needsProcessing = true

func initFluidProduction():
	fluidProduction = CumProduction.new()
	fluidProduction.bodypart = weakref(self)

func setupSensitiveZone():
	sensitiveZone = preload("res://Player/SensitiveZone/SensitivePenis.gd").new()
	sensitiveZone.setBodypart(self)

func getSlot():
	return BodypartSlot.Penis

func getTooltipInfo():
	var result = []
	result.append("length: " + Util.cmToString(lengthCM))
	if(getFluidProduction() != null):
		result.append("Capacity: " + str(round(getFluidProduction().getFluidAmount() * 10.0)/10.0)+"/"+ str(round(getFluidProduction().getCapacity() * 10.0)/10.0)+" ml")
		result.append_array(getFluidProduction().getTooltipInfo())
	var theChar = getCharacter()
	if(GM.pc != null && GM.pc.hasPerk(Perk.BreedExtraTooltipInfo) && theChar != null):
		result.append("Virility: "+str(Util.roundF(theChar.getVirility()*100.0, 1))+"%")
	if(sensitiveZone != null):
		result.append_array(sensitiveZone.getInfo())
	
	return Util.join(result, "\n")

func applyTFData(_data):
	.applyTFData(_data)
	
	lengthCM = loadTFVar(_data, "lengthCM", lengthCM)
	ballsScale = loadTFVar(_data, "ballsScale", ballsScale)
	fluidType = loadTFVar(_data, "fluidType", fluidType)

func saveData():
	var data = .saveData()
	data["lengthCM"] = lengthCM
	data["ballsScale"] = ballsScale
	data["fluidType"] = fluidType
	
	return data

func loadData(_data):
	lengthCM = SAVE.loadVar(_data, "lengthCM", 15.0)
	ballsScale = SAVE.loadVar(_data, "ballsScale", 1.0)
	fluidType = SAVE.loadVar(_data, "fluidType", "Cum")
	
	.loadData(_data)

func getLewdSizeAdjective():
	var theCharacter = getCharacter()
	if(theCharacter != null && theCharacter.isWearingChastityCage()):
		return RNG.pick(["в клетке", "заперт"])
	
	if(lengthCM <= 5.0):
		return RNG.pick(["tiny", "minuscule"])
	if(lengthCM <= 9.0):
		return RNG.pick(["small", "little", "short"])
	if(lengthCM <= 14.0):
		return RNG.pick(["average", "average-sized", "fair-sized"])
	if(lengthCM <= 21.0):
		return RNG.pick(["impressive", "lengthy", "large"])
	if(lengthCM <= 31.0):
		return RNG.pick(["massive", "enormous", "giant"])
	if(lengthCM <= 51.0):
		return RNG.pick(["hyper-sized", "monstrous", "colossal", "massive"])
	
	return RNG.pick(["hyper-sized", "gigantic", "monumental", "colossal", "massive"])

func getLewdAdjective():
	return RNG.pick(["human"])
	
func getLewdName():
	return RNG.pick(["cock", "cock", "dick", "dick", "member", "shaft"])

func getPickableAttributes():
	var result = .getPickableAttributes()
	result["cocksize"] = {
		"text": "Выберите длину своего члена",
		"textButton": "Length",
		"buttonDesc": "Выберите длину члена",
		"options": [
			[5, Util.cmToString(5), "Выбери эту длину"],
			[8, Util.cmToString(8), "Выбери эту длину"],
			[10, Util.cmToString(10), "Выбери эту длину"],
			[13, Util.cmToString(13), "Выбери эту длину"],
			[15, Util.cmToString(15), "Выбери эту длину"],
			[18, Util.cmToString(18), "Выбери эту длину"],
			[22, Util.cmToString(22), "Выбери эту длину"],
			[25, Util.cmToString(25), "Выбери эту длину"],
			[30, Util.cmToString(30), "Выбери эту длину"],
			[40, Util.cmToString(40), "Выбери эту длину"],
			[50, Util.cmToString(50), "Выбери эту длину"],
		],
		"default": 15,
		"floatinput": true,
	}
	result["ballsscale"] = {
		"text": "Выберите размер яичек",
		"textButton": "Balls",
		"buttonDesc": "Выберите размер яичек и члена",
		"options": [
			[0.0, "0%", "Выберите этот размер"],
			[0.3, "30%", "Выберите этот размер"],
			[0.5, "50%", "Выберите этот размер"],
			[0.8, "80%", "Выберите этот размер"],
			[1.0, "100%", "Выберите этот размер"],
			[1.2, "120%", "Выберите этот размер"],
			[1.5, "150%", "Выберите этот размер"],
			[1.8, "180%", "Выберите этот размер"],
			[2.0, "200%", "Выберите этот размер"],
			[2.5, "250%", "Выберите этот размер"],
			[3.0, "300%", "Выберите этот размер"],
			[4.0, "400%", "Выберите этот размер"],
			[5.0, "500%", "Выберите этот размер"],
		],
		"default": 1.0,
		"floatinput": true,
	}
	return result
	
func applyAttribute(_attrID: String, _attrValue):
	.applyAttribute(_attrID, _attrValue)
	if(_attrID == "cocksize"):
		lengthCM = _attrValue
	if(_attrID == "ballsscale"):
		ballsScale = _attrValue

func getAttributesText():
	return [
		["Длина пениса", Util.cmToString(lengthCM)],
		["Размер яичек", str(Util.roundF(ballsScale*100.0, 1))+"%"],
	]
	
func getCharCreatorData():
	return [
		["lengthCM", lengthCM],
		["ballsScale", ballsScale],
	]

func getLength():
	return lengthCM

func safeWhenExposed():
	return false

func getPenisScale():
	return max(0.5 + (lengthCM - 5.0) / 26.0, 0.5)

func getBallsScale():
	return ballsScale

func getRevealMessage():
	return Util.capitalizeFirstLetter(getLewdDescriptionAndName()) + " был обнажен."

func generateDataFor(_dynamicCharacter):
	lengthCM = RNG.randf_range(10.0, 25.0)
	if(RNG.chance(5)):
		lengthCM = RNG.randf_range(5.0, 10.0)
	if(RNG.chance(5)):
		lengthCM = RNG.randf_range(25.0, 30.0)
	lengthCM = Util.roundF(lengthCM, 1)
	
	if(fluidProduction != null):
		fluidProduction.fillPercent(min(1.0, RNG.randf_range(0.8, 1.2)))
	generateRandomColors(_dynamicCharacter)

func hasCustomSkinPattern():
	return true

func generateRandomColors(_dynamicCharacter):
	var theHue = RNG.randf_range(0.0, 0.1)
	if(_dynamicCharacter != null):
		theHue = _dynamicCharacter.pickedSkinRColor.h
	if(RNG.chance(30)):
		pickedGColor = Color.from_hsv(RNG.randf_rangeX2(-0.1, 0.1), RNG.randf_range(0.7, 0.9), RNG.randf_range(0.5, 0.9))
		pickedBColor = pickedGColor
		pickedBColor.v = RNG.randf_rangeX2(0.3, 0.6)
	elif(RNG.chance(30) && _dynamicCharacter!=null):
		pickedGColor = RNG.pick([_dynamicCharacter.pickedSkinRColor, _dynamicCharacter.pickedSkinGColor, _dynamicCharacter.pickedSkinBColor])
		pickedGColor.h += RNG.randf_rangeX2(-0.1, 0.1)
		pickedGColor.s = RNG.randf_range(0.7, 0.9)
		pickedGColor.v = RNG.randf_range(0.7, 0.9)
		pickedBColor = pickedGColor
		pickedBColor.v = RNG.randf_rangeX2(0.3, 0.6)
	else:
		pickedGColor = ColorUtils.generateRandomVibrantColor()
		pickedBColor = pickedGColor
		pickedBColor.v = RNG.randf_rangeX2(0.3, 0.6)

	if(RNG.chance(30)):
		pickedGColor = Color.from_hsv(theHue, RNG.randf_range(0.3, 0.6), RNG.randf_rangeX2(0.1, 0.3))
		pickedBColor.v = RNG.randf_rangeX2(0.7, 0.95)
		pickedBColor.s = RNG.randf_rangeX2(0.7, 0.95)

func getCustomPumpScene(_isAdvanced = false):
	return null

func shouldUseBigPump():
	return false

func getFluidType(_fluidSource) -> String:
	return fluidType

func getTransformAwayMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} внезапно {npc.youHeVerb('feel')} волна тепла окутывает {npc.yourHis} низ тела, и по {npc.youHim} пробегает поток энергии. Пенис {npc.YourHis} начинает растворяться, его плоть размягчается и втягивается, словно он тает. {npc.YouHe} чувствует, как кожа стягивается — это ощущение одновременно будоражит и тревожит. Дюйм за дюймом, {npc.youHe} {npc.youAreHeIs} теряет {npc.yourHis} своей длины... пока не остается ничего, кроме плоской промежности."

func getTransformGrowMessage(_context:Dictionary) -> String:
	return "Странное, покалывающее ощущение разливается по паху {npc.yourHis}, и {npc.youHe} {npc.youHeVerb('sense')} внутри {npc.youHim} начинает формироваться нечто новое. Кожа растягивается и меняет форму, будто что-то мощное давит изнутри. Контуры новой анатомии {npc.yourHis} начинают обретать форму, и {npc.youHe} чувствует, как под {npc.youHim} формируются и оседают яички. Начинает расти ствол, утолщаясь и удлиняясь, кожа растягивается, подстраиваясь под его размер. Наконец, когда последние остатки трансформации утихают, {npc.youHe} {npc.youHeVerb('realize')} понимает, что {npc.youHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+" висит между ногами {npc.yourHis}, пульсируя новообретенной мужественностью и силой."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает странное волнение в {npc.yourHis} паху, и вдруг пенис {npc.yourHis} начинает меняться и трансформироваться, принимая совершенно иную форму. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
