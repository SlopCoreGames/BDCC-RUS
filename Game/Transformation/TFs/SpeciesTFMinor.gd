extends "res://Game/Transformation/TFs/SpeciesTF.gd"

func _init():
	id = "SpeciesTFMinor"
	
	canStack = false
	
	pointsOnUnlock = 15

func getName() -> String:
	return "Создает гибрида"

func getPillName() -> String:
	return "Hybridizer"

func getUnlockData() -> Dictionary:
	return {
		eliza = "Интересно. В этой таблетке содержится ДНК какого-то вида. Но недостаточно, чтобы полностью всё переписать... Думаю, эта таблетка создаст своего рода... гибрид. Смесь двух видов. Разве это не круто? Пожалуй, назову её... «Гибридизатор»",
		tryOptions = [
			{
				name = "Заставить Элизу сожрать это",
				desc = "Спросить, хватит ли ей смелости попробовать собственный продукт. Это может быть либо смешно, либо грустно — кто знает.",
				sceneID = "ElizaDrugTestHybridScene",
			},
		],
	}

func getPillDatabaseDesc() -> String:
	return "Этот препарат превратит тебя в гибрида, трансформируя некоторые части твоего тела в части другого вида. Препарат попытается постепенно изменить следующие части:\n- Уши\n- Рога\n- Хвост\n- Пенис\n- Ноги\n\nПервая стадия наступит примерно через 15 минут. После этого последующие будут происходить примерно каждые 10 часов. Каждая следующая стадия будет длиться дольше предыдущей. Ускорить процесс можно только с помощью препарата «QuickShift».\n\nУ этого препарата нет фиксированного количества стадий. Он достигнет финальной стадии, когда трансформировать будет больше нечего. С помощью продвинутого лабораторного оборудования препарат можно модифицировать, чтобы выбрать целевой вид."

func getTFCheckTags() -> Dictionary:
	return {
		"species": true,
	}

func getPillFluidsRequired() -> Dictionary:
	return {
		"Milk": 2000.0,
		"GirlCum": 1000.0,
		"Cum": 200.0,
	}

func getSlotsToTransform() -> Array:
	return [
		BodypartSlot.Ears,
		BodypartSlot.Horns,
		BodypartSlot.Tail,
		BodypartSlot.Penis,
		BodypartSlot.Legs,
	]

func allowsRemovingParts() -> bool:
	return false

func getPillOptions() -> Dictionary:
	var speciesArray:Array = []
	for speciesID in GlobalRegistry.getAllPlayableSpecies():
		speciesArray.append([speciesID, GlobalRegistry.getSpecies(speciesID).getVisibleName()])
	var result:Dictionary = {
		"species": {
			name = "Вид",
			desc = "В какой вид должен превратить тебя препарат?",
			value = Species.Canine,
			values = speciesArray,
		},
	}
	
	return result
