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
		eliza = "Ну надо же! Посмотрите-ка, что у нас тут... Похоже, эта таблетка насыщена хроматическими усилителями и пигментомодифицирующими агентами, способными полностью преобразить твою внешность. При приеме она, скорее всего, изменит цвет и узор твоей кожи или меха на что-то поистине уникальное. Только представь, какие возможности открываются! Назову её... «CoLore»!",
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат будет постепенно менять твою кожу и цвета на новые случайные оттенки.\n\nПервая стадия наступит примерно через 15 минут. После этого последующие будут происходить в среднем каждые 2 часа. Процесс можно ускорить, только используя препарат QuickShift.\n\nУ этого препарата 5 стадий. Если у тебя есть продвинутое лабораторное оборудование, препарат можно модифицировать для воздействия на конкретные типы кожи и цвета."

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
