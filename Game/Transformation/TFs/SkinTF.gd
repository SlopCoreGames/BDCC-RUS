extends TFBase

var prog:float = 0
var pickedColors:Array = []
var pickedSkin:String = ""

func _init():
	id = "SkinTF"
	#pillGenWeight = 0.0
	
	canStack = true
	
	pointsOnUnlock = 10

func getName() -> String:
	return "Меняет цвета"

func getPillName() -> String:
	return "CoLore"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Well, well! Look what we have here.. This pill seems to be infused with chromatic enhancers and pigment-modifying agents that could completely transform your appearance. When taken, it will probably change your skin or fur colors and patterns to something truly unique. Just think of the possibilities! I will call it.. 'CoLore'!",
	}

func getPillDatabaseDesc() -> String:
	return "This drug will gradually change your skin and colors to new random ones.\n\nThe first stage will happen after about 15 minutes. After that, the next ones will happen roughly every 2 hours. This could be accelerated only by using the QuickShift drug.\n\nThis drug has 5 stages. It’s possible to modify the drug to target specific skin and colors if you have advanced lab equipment."

func getTFCheckTags() -> Dictionary:
	return {
		"skin": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Cum": 1000.0,
	}

func start(_args:Dictionary):
	var theChar = getChar()
	
	if(_args.has("color_r") && _args.has("color_g") && _args.has("color_b")):
		pickedColors = [
			(Color(_args["color_r"]) if (_args["color_r"] is String) else _args["color_r"]),
			(Color(_args["color_g"]) if (_args["color_g"] is String) else _args["color_g"]),
			(Color(_args["color_b"]) if (_args["color_b"] is String) else _args["color_b"]),
			]
	elif(!_args.has("colors")):
		pickedColors = TFUtil.getRandomColorsForSpecies(theChar.getSpecies())
	else:
		pickedColors = _args["colors"]
	
	if(!_args.has("skin")):
		pickedSkin = TFUtil.getRandomSkinForSpecies(theChar.getSpecies())
	else:
		pickedSkin = _args["skin"]

func getPillOptions() -> Dictionary:
	var skinsArray:Array = []
	for skinID in GlobalRegistry.getSkinsAllKeys():
		var theSkin:SkinBase = GlobalRegistry.getSkin(skinID)
		skinsArray.append([skinID, theSkin.getName()])
	
	return {
		"skin": {
			name = "Кожа",
			desc = "Новая кожа.",
			value = "EmptySkin",
			values = skinsArray,
		},
		"color_r": {
			name = "Основной цвет",
			desc = "Основной цвет.",
			value = "#FF0000",
			color = true,
		},
		"color_g": {
			name = "Вторичный цвет",
			desc = "Вторичный цвет.",
			value = "#FFFF00",
			color = true,
		},
		"color_b": {
			name = "Третий цвет",
			desc = "Третий цвет.",
			value = "#FF00FF",
			color = true,
		},
	}

func getMaxStage() -> int:
	return 5

func canTransformFurther() -> bool:
	if(prog < 1.0):
		return true
	return false
	
func getTimerForStage(_theStage:int) -> int:
	if(_theStage == 0):
		return 500
	return 60*60*2
	
func doProgress(_context:Dictionary) -> Dictionary:
	prog += 0.2
	if(prog > 1.0):
		prog = 1.0
	return {
		effects = [
			charEffect("skin", "SkinSet", [pickedSkin if prog >= 0.5 else "", pickedColors, prog]),
		]
	}


func reactProgressShort(_context:Dictionary, _result:TFResult):
	reactProgress(_context, _result)

func reactProgress(_context:Dictionary, _result:TFResult):
	if(isFirstTime()):
		addText("Прямо на глазах у {npc.yourHis} цвета кожи {npc.yourHis} начинают меняться. Едва заметно... но всё же очевидно. Внутри {npc.youHim} пульсирует теплое сияние... И это, вероятно, только начало.")
	elif(prog >= 1.0):
		addText("Цвета кожи {npc.yourHis} смещаются... и сияние гаснет, сигнализируя о том, что трансформация завершена.")
	else:
		addText("Цвета кожи {npc.yourHis} меняются всё сильнее, медленно приближаясь к своему финальному состоянию.")
	
	playAnim(StageScene.TFLook, "hands", {bodyState={naked=true}})
	
func getBuffs() -> Array:
	return []

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["ps"] = pickedSkin
	var pickedColorsStrs:Array = []
	for color in pickedColors:
		pickedColorsStrs.append(color.to_html())
	data["pcs"] = pickedColorsStrs
	data["prog"] = prog
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	pickedSkin = SAVE.loadVar(_data, "ps", "")
	var pickedColorsStrs = SAVE.loadVar(_data, "pcs", [])
	pickedColors = []
	for colorStr in pickedColorsStrs:
		pickedColors.append(Color(colorStr))
	prog = SAVE.loadVar(_data, "prog", 0.0)
