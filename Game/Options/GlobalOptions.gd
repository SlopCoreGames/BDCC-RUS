extends Node

const TAB_GAMEPLAY = 0
const TAB_GAME = 1
const TAB_DISPLAY = 2
const TAB_INTERFACE = 3

const LAYOUT_AUTO = 0
const LAYOUT_NORMAL = 1
const LAYOUT_TOUCH_HORIZONTAL = 2
const LAYOUT_TOUCH_VERTICAL = 3

const SCREEN_HORIZONTAL = 0
const SCREEN_VERTICAL = 1

const ANDROID_SAVE_FOLDER_DOCUMENTS := 0
const ANDROID_SAVE_FOLDER_GAME_DATA := 1
const ANDROID_SAVE_FOLDER_DOWNLOADS := 2
var androidSaveFolder:int = ANDROID_SAVE_FOLDER_DOWNLOADS

var currentSupportsVertical:bool = false
var currentScreenOrientation:int = SCREEN_HORIZONTAL # not saved
signal onScreenOrientationChange
signal onLayoutChange

var myProjectSettings

var enabledContent = {}
const optionsFilepath = "user://options.json"
var fetchNewRelease = true
var fullscreen:bool = false
var fpsLimit:int = 0
var profilerEnabled:bool = false
var webTextInputFallback:bool = false
# Pregnancy options
var menstrualCycleLengthDays: int
var eggCellLifespanHours: int
var playerPregnancyTimeDays: int
var npcPregnancyTimeDays: int
var impregnationChanceModifier: int
var bellySizeDependsOnLitterSize: bool = false
var bellyMaxSizeModifier: float = 1.0
var optimizeChilds:bool = true
var maxKeepPCKids:int = 50
var maxKeepNPCKids:int = 30
var bigEggsGrowthMult:float = 2.0

# Sandbox options
var sandboxPawnCount:int = 30
var sandboxBreeding:String = "rare" # normal reduced rare veryrare never
var sandboxNpcLeveling:float = 1.0
var sandboxSeeChances:bool = true

# Difficulty options
var hardStruggleEnabled: bool = false
var smartLockRarity: String = "normal" # never veryrare rare normal often veryoften bdsmslut always
var overstimulationEnabled: bool = true
var savingInDungeons: bool = false

# Datapack editor
var blockCatcherPanelHeight: int = 8

var uiLayout:int = LAYOUT_AUTO
var uiLayoutRightHanded:bool = true
var shouldScaleUI: bool = true
var uiScaleMultiplier = 1.0
var requireDoubleTapOnMobile = false
var uiButtonSize:int = 0

var showSpeakerName = true
var fontSize = "normal"
var showShortcuts = true
var showSceneCreator = true
var inventoryIconsSize = "small"

var measurementUnits = "metric"

var debugPanel = false
var showMapArt = false
var developerCommentary = false

var showCharacterArt = true
var showSceneArt = true
var imagePackOrder = []

var rollbackEnabled = false
var rollbackSlots = 5
var rollbackSaveEvery = 1
var rollbackThread:bool = true

var showModdedLauncher = false

var jigglePhysicsBreastsEnabled = true
var jigglePhysicsBellyEnabled = true
var jigglePhysicsButtEnabled = true
var jigglePhysicsGlobalModifier = 1.0

var advancedShadersEnabled = true
var chainsEnabled = true
var cumEnabled = true
var cumDependsOnBallsSize = true
var cumIntensityMult = 1.0
var visibleWritings:bool = true

var autosaveEnabled = true

var genderNamesOverrides = {}

func resetToDefaults():
	fetchNewRelease = true
	fpsLimit = 0
	profilerEnabled = false
	webTextInputFallback = false
	menstrualCycleLengthDays = 7
	eggCellLifespanHours = 48
	bigEggsGrowthMult = 2.0
	playerPregnancyTimeDays = 5
	npcPregnancyTimeDays = 5
	bellySizeDependsOnLitterSize = false
	impregnationChanceModifier = 100
	bellyMaxSizeModifier = 1.0
	optimizeChilds = true
	maxKeepPCKids = 50
	maxKeepNPCKids = 30
	hardStruggleEnabled = false
	smartLockRarity = "normal"
	overstimulationEnabled = true
	savingInDungeons = false
	uiLayout = LAYOUT_AUTO
	uiLayoutRightHanded = true
	shouldScaleUI = true
	uiScaleMultiplier = 1.0
	showSpeakerName = true
	fontSize = "normal"
	showShortcuts = true
	measurementUnits = "metric"
	requireDoubleTapOnMobile = false
	uiButtonSize = 0
	debugPanel = false
	showMapArt = false
	#imagePackOrder = []
	showCharacterArt = true
	showSceneArt = true
	showSceneCreator = true
	rollbackEnabled = false
	rollbackThread = true
	rollbackSlots = 5
	rollbackSaveEvery = 1
	showModdedLauncher = false
	developerCommentary = false
	jigglePhysicsBreastsEnabled = true
	jigglePhysicsBellyEnabled = true
	jigglePhysicsButtEnabled = true
	jigglePhysicsGlobalModifier = 1.0
	advancedShadersEnabled = true
	chainsEnabled = true
	autosaveEnabled = true
	inventoryIconsSize = "small"
	genderNamesOverrides = {}
	sandboxPawnCount = 30
	sandboxBreeding = "rare"
	sandboxNpcLeveling = 1.0
	sandboxSeeChances = true
	blockCatcherPanelHeight = 8
	
	enabledContent.clear()
	for contentType in ContentType.getAll():
		enabledContent[contentType] = !ContentType.isDisabledByDefault(contentType)
		
	call_deferred("applySettingsEffect")

func _init():
	myProjectSettings = load("res://Game/Options/MyProjectSettings.gd").new()
	myProjectSettings.save()

	resetToDefaults()
	
	loadFromFile()

func getGenderOverrideName(theGender, defaultValue):
	if(!genderNamesOverrides.has(theGender) || genderNamesOverrides[theGender] == ""):
		return defaultValue
	return genderNamesOverrides[theGender]

func isContentEnabled(contentType):
	if(!enabledContent.has(contentType)):
		return !ContentType.isDisabledByDefault(contentType)
	
	return enabledContent[contentType]

func shouldFetchGithubRelease():
	return fetchNewRelease

func getMenstrualCycleLengthDays():
	return menstrualCycleLengthDays

func getEggCellLifespanHours():
	return eggCellLifespanHours

func getBigEggsGrowthMult() -> float:
	return bigEggsGrowthMult

func getPlayerPregnancyTimeDays():
	return playerPregnancyTimeDays
	
func getNPCPregnancyTimeDays():
	return npcPregnancyTimeDays

func getImpregnationChanceModifier() -> float:
	var resultValue:float = float(impregnationChanceModifier) / 100.0
	resultValue = clamp(resultValue, 0.0, 1000.0)
	return resultValue

func getBellyMaxSizeDependsOnLitterSize() -> bool:
	return bellySizeDependsOnLitterSize

func getBellyMaxSizeModifier() -> float:
	return bellyMaxSizeModifier

func shouldOptimizeKids() -> bool:
	return optimizeChilds

func getMaxKeepPCKids() -> int:
	return maxKeepPCKids

func getMaxKeepNPCKids() -> int:
	return maxKeepNPCKids

func isHardStruggleEnabled():
	return hardStruggleEnabled

func getSmartLockRarity():
	return smartLockRarity

func isOverstimulationEnabled():
	return overstimulationEnabled

func canSaveInDungeons() -> bool:
	return savingInDungeons

func shouldShowSpeakerName():
	return showSpeakerName

func getFontSize():
	return fontSize

func shouldShowShortcuts():
	return showShortcuts

func getMeasurementUnits():
	return measurementUnits

func shouldRequireDoubleTapOnMobile():
	return requireDoubleTapOnMobile

func getUiButtonSize():
	return uiButtonSize

func isDebugPanelEnabled():
	return debugPanel

func shouldShowCharacterArt():
	return showCharacterArt

func shouldShowSceneArt():
	return showSceneArt

func shouldShowSceneCreator():
	return showSceneCreator

func shouldShowMapArt():
	return showMapArt

func isRollbackEnabled():
	return rollbackEnabled

func isRollbackThreadEnabled() -> bool:
	if(OS.get_name() == "HTML5"): # Doesn't work on web, no thread support?
		return false
	return rollbackThread

func getRollbackSlotsAmount():
	return rollbackSlots

func getRollbackSaveEveryXChoices():
	return rollbackSaveEvery

func shouldShowModdedLauncher():
	return showModdedLauncher

func developerCommentaryEnabled():
	return developerCommentary

func isJigglePhysicsBreastsEnabled():
	return jigglePhysicsBreastsEnabled

func isJigglePhysicsBellyEnabled():
	return jigglePhysicsBellyEnabled
	
func isJigglePhysicsButtEnabled():
	return jigglePhysicsButtEnabled

func getJigglePhysicsGlobalModifier():
	return jigglePhysicsGlobalModifier

func shouldUseAdvancedShaders():
	return advancedShadersEnabled

func shouldAutosave():
	return autosaveEnabled

func shouldSpawnChains():
	return chainsEnabled

func isVisibleCumShotsEnabled():
	return cumEnabled

func getCumShotsDependOnBallsVolume():
	return cumDependsOnBallsSize

func getCumShotsIntensityMult():
	return cumIntensityMult

func isVisibleBodywritingsEnabled() -> bool:
	return visibleWritings

func getBlockCatcherPanelHeight():
	return blockCatcherPanelHeight

func getSandboxPawnCount() -> int:
	return sandboxPawnCount

func getSandboxNpcLeveling() -> float:
	return sandboxNpcLeveling

func getSandboxOffscreenBreedingMult() -> float:
	if(sandboxBreeding == "normal"):
		return 1.0
	if(sandboxBreeding == "reduced"):
		return 0.5
	if(sandboxBreeding == "rare"):
		return 0.2
	if(sandboxBreeding == "veryrare"):
		return 0.05
	if(sandboxBreeding == "never"):
		return 0.0
	
	return 1.0

func shouldSeePawnActionChances() -> bool:
	return sandboxSeeChances

func getInventoryIconSize():
	if(inventoryIconsSize == "small"):
		return 32
	if(inventoryIconsSize == "normal"):
		return 40
	if(inventoryIconsSize == "big"):
		return 64
	return 32

func getChangeableOptions():
	var settings = [
		{
			"name": "Моддинг",
			"id": "modding",
			"options": [
				{
					"name": "Включить модифицированный лаунчер BDCC",
					"description": "Перезапустите игру, чтобы увидеть изменения. Позволяет управлять модами и скачивать новые",
					"id": "showModdedLauncher",
					"type": "checkbox",
					"value": showModdedLauncher,
					"tab": TAB_GAME,
				},
				{
					"name": "(Android) Папка с модами",
					"description": "На Android-устройствах игра будет использовать эту папку для поиска модов. Экспортированные сохранения также будут попадать сюда.",
					"id": "androidSaveFolder",
					"type": "list",
					"value": androidSaveFolder,
					"values": [
						[ANDROID_SAVE_FOLDER_DOCUMENTS, "Папка документов"],
						[ANDROID_SAVE_FOLDER_DOWNLOADS, "Папка «Загрузки»"],
						[ANDROID_SAVE_FOLDER_GAME_DATA, "data/org.rahimew.bdcc/files"],
					],
					"tab": TAB_GAME,
					"hide": (OS.get_name() != "Android"),
				},
			],
		},
		{
			"name": "Песочница",
			"id": "sandbox",
			"options": [
				{
					"name": "Количество пешек",
					"description": "Сколько пешек должно обычно бродить по тюрьме...",
					"id": "sandboxPawnCount",
					"type": "int",
					"value": sandboxPawnCount,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Размножение за кадром",
					"description": "Как часто пешки могут размножаться друг с другом, пока вы не смотрите",
					"id": "sandboxBreeding",
					"type": "list",
					"value": sandboxBreeding,
					"values": [
						["normal", "Нормально (100%)"],
						["reduced", "Редко (50%)"],
						["rare", "Очень редко (20%)"],
						["veryrare", "На редкость (5%)"],
						["never", "Никогда (0%)"],
					],
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Ускоренная автопрокачка пешек",
					"description": "Пешки получают больше или меньше опыта в зависимости от уровня игрока. Этот параметр регулирует силу модификатора. При обычном уровне NPC получают фиксированное количество опыта за бои.",
					"id": "sandboxNpcLeveling",
					"type": "list",
					"value": sandboxNpcLeveling,
					"values": [
						[-1.0, "Отключить прокачку NPC"],
						[0.0, "Обычная прокачка"],
						[0.05, "5%"],
						[0.1, "10%"],
						[0.25, "25%"],
						[0.5, "50%"],
						[0.75, "75%"],
						[1.0, "100%"],
						[1.5, "150%"],
						[2.0, "200%"],
					],
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Отображать шансы действий пешек",
					"description": "Включить отображение относительных шансов действий пешек во время взаимодействия с ними.",
					"id": "sandboxSeeChances",
					"type": "checkbox",
					"value": sandboxSeeChances,
					"tab": TAB_GAMEPLAY,
				},
			],
		},
		{
			"name": "Настройки беременности",
			"id": "pregnancy",
			"options": [
				{
					"name": "Длительность менструального цикла (дни)",
					"description": "Продолжительность женского менструального цикла. Женщины могут забеременеть только после овуляции, которая происходит раз в цикл. Реалистичное значение — 30. Значение по умолчанию — 7.",
					"id": "menstrualCycleLengthDays",
					"type": "int",
					"value": menstrualCycleLengthDays,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Жизненный цикл яйцеклетки (часы)",
					"description": "Сколько часов живет яйцеклетка после овуляции. Реалистичное значение — 18. Значение по умолчанию — 48.",
					"id": "eggCellLifespanHours",
					"type": "int",
					"value": eggCellLifespanHours,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Длительность беременности игрока (дни)",
					"description": "Сколько дней должно пройти, прежде чем игрок будет готов к родам. Реалистичное значение для людей — 270. Реалистичное значение для кошачьих — 30. Значение по умолчанию — 5.",
					"id": "playerPregnancyTimeDays",
					"type": "int",
					"value": playerPregnancyTimeDays,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Длительность беременности NPC (дни)",
					"description": "Сколько дней проходит до рождения детей у NPC. Реалистичное значение для людей — 270. Для кошачьих — 30. Значение по умолчанию — 5",
					"id": "npcPregnancyTimeDays",
					"type": "int",
					"value": npcPregnancyTimeDays,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Модификатор шанса оплодотворения (%)",
					"description": "Чем выше шанс, тем легче забеременеть. Должно быть больше нуля",
					"id": "impregnationChanceModifier",
					"type": "int",
					"value": impregnationChanceModifier,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Множитель роста больших яиц",
					"description": "Насколько быстрее должны развиваться большие яйца по сравнению с обычной беременностью. Большие яйца — это те, которые вам придется откладывать.",
					"id": "bigEggsGrowthMult",
					"type": "list",
					"value": bigEggsGrowthMult,
					"values": [
						[0.25, "25%"],
						[0.5, "50%"],
						[1.0, "100% (как у яйцеклеток)"],
						[1.5, "150%"],
						[2.0, "200% (по умолчанию)"],
						[3.0, "300%"],
						[4.0, "400%"],
						[5.0, "500%"],
					],
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Размер живота зависит от количества плодов",
					"description": "Если включено, беременные животы будут казаться больше в зависимости от количества детей. Например, при 16 плодах живот будет выглядеть примерно в два раза больше",
					"id": "bellySizeDependsOnLitterSize",
					"type": "checkbox",
					"value": bellySizeDependsOnLitterSize,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Размер беременного живота (%)",
					"description": "Чисто визуальный параметр. Если собираетесь включать опцию выше, лучше оставить его на 100%.",
					"id": "bellyMaxSizeModifier",
					"type": "list",
					"value": bellyMaxSizeModifier,
					"values": [
						[0.0, "0%"],
						[0.25, "25%"],
						[0.5, "50%"],
						[0.7, "70%"],
						[0.8, "80%"],
						[0.9, "90%"],
						[1.0, "100%"],
						[1.10, "110%"],
						[1.25, "125%"],
						[1.5, "150%"],
						[1.75, "175%"],
						[2.0, "200%"],
					],
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Автоматический оптимизатор записей о детях",
					"description": "Если включено, игра будет автоматически «архивировать» старые записи о детях, когда их количество превысит заданное число за день. Вся лишняя информация (имя, вид, пол) будет утеряна, но общее количество детей от каждого NPC сохранится. Полезно для автоматической защиты от раздувания файлов сохранений.",
					"id": "optimizeChilds",
					"type": "checkbox",
					"value": optimizeChilds,
					"tab": TAB_GAME,
				},
				{
					"name": "Макс. записей о детях игрока",
					"description": "При включенном «Автоматическом оптимизаторе» игра будет хранить столько самых свежих записей о детях игрока. Старые записи будут «архивированы».",
					"id": "maxKeepPCKids",
					"type": "int",
					"value": maxKeepPCKids,
					"tab": TAB_GAME,
				},
				{
					"name": "Макс. записей о чужих детях",
					"description": "При включенном «Автоматическом оптимизаторе» игра будет хранить столько самых свежих записей о детях, не принадлежащих игроку. Старые записи будут «архивированы».",
					"id": "maxKeepNPCKids",
					"type": "int",
					"value": maxKeepNPCKids,
					"tab": TAB_GAME,
				},
			]
		},
		{
			"name": "Настройки сложности",
			"id": "difficulty",
			"options": [
				{
					"name": "Тяжелое выживание",
					"description": "Снимать путы станет сложнее. Включайте эту опцию, только если чувствуете себя Гудини.",
					"id": "hardStruggleEnabled",
					"type": "checkbox",
					"value": hardStruggleEnabled,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Редкость умных замков",
					"description": "Как часто NPC будут надевать на игрока специальное BDSM-снаряжение с умными замками.",
					"id": "smartLockRarity",
					"type": "list",
					"value": smartLockRarity,
					"values": [
						["never", "Никогда"],
						["veryrare", "Очень редко"],
						["rare", "Редко"],
						["normal", "Обычный"],
						["often", "Часто"],
						["veryoften", "Очень часто"],
						["bdsmslut", "BDSM-ШЛЮХА"],
						["always", "Всегда"],
					],
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Механика гиперстимуляции",
					"description": "Позволяет перестимулировать любую эрогенную зону во время секса. Перестимулированные зоны теряют чувствительность при дальнейшем воздействии. Соски можно перестимулировать, даже если эта опция выключена.",
					"id": "overstimulationEnabled",
					"type": "checkbox",
					"value": overstimulationEnabled,
					"tab": TAB_GAMEPLAY,
				},
				{
					"name": "Сохранение в подземельях",
					"description": "Включите это, чтобы иметь возможность сохраняться или откатываться во время игровых подземелий (наркопритонов). Включение этой опции облегчит прохождение подземелий.",
					"id": "savingInDungeons",
					"type": "checkbox",
					"value": savingInDungeons,
					"tab": TAB_GAMEPLAY,
				},
			]
		},
		{
			"name": "Рендеринг (перезапустите игру после изменений)",
			"id": "render",
			"options": [
				{
					"name": "Рендерер",
					"description": "GLES3 = Высокая графика, GLES2 = Максимальная совместимость",
					"id": "renderer",
					"type": "list",
					"value": ProjectSettings.get_setting("rendering/quality/driver/driver_name"),
					"values": [
						["GLES3", "GLES3"],
						["GLES2", "GLES2"],
					],
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Ограничитель FPS",
					"description": "Какая максимальная частота кадров должна быть у игры? Низкие значения снижают нагрузку на устройство.",
					"id": "fpsLimit",
					"type": "list",
					"value": fpsLimit,
					"values": [
						[10, "10 fps"],
						[25, "25 fps"],
						[30, "30 fps"],
						[45, "45 fps"],
						[60, "60 fps"],
						[75, "75 fps"],
						[90, "90 fps"],
						[120, "120 fps"],
						[0, "V-Sync"],
						[9999, "Без ограничений"],
					],
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Принудительный программный скиннинг",
					"description": "Включите это, если кожа куклы отображается некорректно. Может снизить производительность.",
					"id": "softwareSkinning",
					"type": "checkbox",
					"value": ProjectSettings.get_setting("rendering/quality/skinning/force_software_skinning"),
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Шейдеры кожи",
					"description": "Выключите это, если игра тормозит или вылетает. Отключает все текстуры кожи.",
					"id": "advancedShadersEnabled",
					"type": "checkbox",
					"value": advancedShadersEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Видимые цепи",
					"description": "Отображать цепи, когда персонаж в наручниках или на поводке. Отключение может повысить производительность.",
					"id": "chainsEnabled",
					"type": "checkbox",
					"value": chainsEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Видимые надписи на теле",
					"description": "Включает надписи на телах кукол. Потребляет довольно много видеопамяти; выключите, если игра тормозит.",
					"id": "visibleWritings",
					"type": "checkbox",
					"value": visibleWritings,
					"tab": TAB_DISPLAY,
				},
			]
		},
		{
			"name": "Физика колыхания",
			"id": "jigglephysics",
			"options": [
				{
					"name": "Физика груди",
					"description": "Должна ли грудь трястись?",
					"id": "jigglePhysicsBreastsEnabled",
					"type": "checkbox",
					"value": jigglePhysicsBreastsEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Физика живота",
					"description": "Должен ли живот колыхаться?",
					"id": "jigglePhysicsBellyEnabled",
					"type": "checkbox",
					"value": jigglePhysicsBellyEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Физика ягодиц",
					"description": "Должна ли задница трястись?",
					"id": "jigglePhysicsButtEnabled",
					"type": "checkbox",
					"value": jigglePhysicsButtEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Коэффициент колыхания",
					"description": "Насколько сильно всё должно трястись",
					"id": "jigglePhysicsGlobalModifier",
					"type": "list",
					"value": jigglePhysicsGlobalModifier,
					"values": [
						[0.1, "10%"],
						[0.25, "25%"],
						[0.5, "50%"],
						[0.6, "60%"],
						[0.7, "70%"],
						[0.8, "80%"],
						[0.9, "90%"],
						[1.0, "100%"],
						[1.10, "110%"],
						[1.2, "120%"],
						[1.35, "135%"],
						[1.5, "150%"],
						[2.0, "200%"],
					],
					"tab": TAB_DISPLAY,
				},
			]
		},
		{
			"name": "Сохранения",
			"id": "saves",
			"options": [
				{
					"name": "Автосохранение после сна",
					"description": "Сохранять ли игру автоматически после сна",
					"id": "autosaveEnabled",
					"type": "checkbox",
					"value": autosaveEnabled,
					"tab": TAB_GAME,
				}
			],
		},
		{
			"name": "Кончить",
			"id": "cum",
			"options": [
				{
					"name": "Видимые кончёрты",
					"description": "Видимые частицы, когда кто-то кончает внутрь или просто заливает всё вокруг",
					"id": "cumEnabled",
					"type": "checkbox",
					"value": cumEnabled,
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Множитель интенсивности кончания",
					"description": "Множитель количества частиц спермы и их скорости во время кончания",
					"id": "cumIntensityMult",
					"type": "list",
					"value": cumIntensityMult,
					"values": [
						[0.1, "10%"],
						[0.3, "30%"],
						[0.5, "50%"],
						[0.7, "70%"],
						[0.9, "90%"],
						[1.0, "100%"],
						[1.1, "110%"],
						[1.3, "130%"],
						[1.5, "150%"],
						[1.7, "170%"],
						[2.0, "200%"],
						[3.0, "300%"],
						[5.0, "500%"],
					],
					"tab": TAB_DISPLAY,
				},
				{
					"name": "Зависимость кончания от объема яичек",
					"description": "Если выключено, интенсивность кончания всегда будет одинаковой. Если включено, она будет зависеть от объема яичек.",
					"id": "cumDependsOnBallsSize",
					"type": "checkbox",
					"value": cumDependsOnBallsSize,
					"tab": TAB_DISPLAY,
				},
			]
		},
		{
			"name": "Расположение интерфейса",
			"id": "layout",
			"options": [
				{
					"name": "Расположение элементов UI",
					"description": "Какой макет интерфейса использовать в игре. «Автоматический» выбирает горизонтальный макет, удобный для сенсорных экранов, если они обнаружены, в противном случае — «Обычный».",
					"id": "uiLayout",
					"type": "list",
					"value": uiLayout,
					"values": [
						[LAYOUT_AUTO, "Автоматический"],
						[LAYOUT_NORMAL, "Обычный"],
						[LAYOUT_TOUCH_HORIZONTAL, "Сенсорный (горизонтальный)"],
						[LAYOUT_TOUCH_VERTICAL, "Сенсорный (вертикальный)"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Масштабирование интерфейса",
					"description": "Должна ли игра масштабировать интерфейс под разные разрешения. Отключите, если текст становится размытым.",
					"id": "shouldScaleUI",
					"type": "checkbox",
					"value": shouldScaleUI,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Множитель масштаба интерфейса",
					"description": "Будьте осторожны при изменении этого значения.",
					"id": "uiScaleMultiplier",
					"type": "list",
					"value": uiScaleMultiplier,
					"values": [
						[0.5, "50%"],
						[0.6, "60%"],
						[0.7, "70%"],
						[0.8, "80%"],
						[0.9, "90%"],
						[1.0, "100%"],
						[1.05, "105%"],
						[1.10, "110%"],
						[1.15, "115%"],
						[1.2, "120%"],
						[1.25, "125%"],
						[1.35, "135%"],
						[1.5, "150%"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Размер шрифта вывода",
					"description": "Размер шрифта для вывода текста сцены",
					"id": "fontSize",
					"type": "list",
					"value": fontSize,
					"values": [
						["small", "Маленький"],
						["normal", "Обычный"],
						["big", "Большой"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Размер кнопок",
					"description": "Изменяет размер кнопок на главном экране игры",
					"id": "uiButtonSize",
					"type": "list",
					"value": uiButtonSize,
					"values": [
						[0, "По умолчанию"],
						[1, "Чуть больше"],
						[2, "Большой"],
						[3, "Очень большой"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Иконки инвентаря",
					"description": "Изменяет размер кнопок на главном экране игры",
					"id": "inventoryIconsSize",
					"type": "list",
					"value": inventoryIconsSize,
					"values": [
						["small", "Маленький"],
						["normal", "Обычный"],
						["big", "Большой"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Высота панели ловушки блоков",
					"description": "(Создатель сцен датапаков) Изменить размер (высоту) панели ловушки блоков",
					"id": "blockCatcherPanelHeight",
					"type": "list",
					"value": blockCatcherPanelHeight,
					"values": [
						[4, "4p"],
						[8, "8p"],
						[16, "16p"],
						[32, "32p"],
					],
					"tab": TAB_INTERFACE,
				},
			],
		},
		
		{
			"name": "Другой",
			"id": "other",
			"options": [
				{
					"name": "Проверить наличие новой версии",
					"description": "Загружать ли информацию о последнем обновлении с GitHub при запуске игры",
					"id": "fetchLatestRelease",
					"type": "checkbox",
					"value": fetchNewRelease,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Показывать имя говорящего",
					"description": "Добавляет имя говорящего перед репликой",
					"id": "showSpeakerName",
					"type": "checkbox",
					"value": showSpeakerName,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Показывать горячие клавиши",
					"description": "Отображать клавишу быстрого доступа на кнопке",
					"id": "showShortcuts",
					"type": "checkbox",
					"value": showShortcuts,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Двойное нажатие для выбора варианта (мобильные устройства)",
					"description": "Первое нажатие показывает описание, второе — выбирает вариант. Работает только на сенсорных экранах",
					"id": "requireDoubleTapOnMobile",
					"type": "checkbox",
					"value": requireDoubleTapOnMobile,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Единицы измерения",
					"description": "Выберите способ отображения длины",
					"id": "measurementUnits",
					"type": "list",
					"value": measurementUnits,
					"values": [
						["metric", "Метрическая (см)"],
						["imperial", "Имперская (дюймы)"],
						["metricimperial", "Метрическая и имперская"],
					],
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Показывать арт персонажей",
					"description": "Показывать большой арт вместо маленького",
					"id": "showCharacterArt",
					"type": "checkbox",
					"value": showCharacterArt,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Показывать арт сцены",
					"description": "Отображать арт текущей сцены (если есть)",
					"id": "showSceneArt",
					"type": "checkbox",
					"value": showSceneArt,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Наборы изображений",
					"description": "Выберите приоритет художников",
					"id": "imagePackOrder",
					"type": "prioritylist",
					"imagePacks": true,
					"value": "",
					"values": imagePackOrder,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Показать редактор сцен",
					"description": "Под миникартой отображается текст «сцена [имя автора]»",
					"id": "showSceneCreator",
					"type": "checkbox",
					"value": showSceneCreator,
					"tab": TAB_INTERFACE,
				},
				{
					"name": "Комментарий разработчика",
					"description": "Включает комментарии разработчиков для сцен, которые их поддерживают",
					"id": "developerCommentary",
					"type": "checkbox",
					"value": developerCommentary,
					"tab": TAB_INTERFACE,
				},
#				{
#					"name": "Show map art (WIP)",
#					"description": "(WORK IN PROGRESS) Shows props and walls on the minimap when supported",
#					"id": "showMapArt",
#					"type": "checkbox",
#					"value": showMapArt,
#				},
				{
					"name": "[WEB] Резервное поле ввода текста",
					"description": "Только для HTML5. Используйте всплывающее окно для ввода текста в браузерах, которые не поддерживают стандартные текстовые поля Godot.",
					"id": "webTextInputFallback",
					"type": "checkbox",
					"value": webTextInputFallback,
					"tab": TAB_INTERFACE,
				},
			],
		},
		{
			"name": "Настройки отката (экспериментально)",
			"id": "rollback",
			"options": [
				{
					"name": "Откат включен",
					"description": "Если включено, вы сможете откатывать состояние игры, отменяя любые сделанные игроком выборы. Может потреблять много оперативной памяти. Отключите, если игра начинает тормозить.",
					"id": "rollbackEnabled",
					"type": "checkbox",
					"value": rollbackEnabled,
					"tab": TAB_GAME,
				},
				{
					"name": "Отдельный поток",
					"description": "Если включено, игра будет сохранять состояние отката в отдельном потоке. Это должно сделать геймплей плавнее, но может привести к самым разным странным багам. Отключите, если игра вылетает без видимых причин. В HTML5-версии не работает.",
					"id": "rollbackThread",
					"type": "checkbox",
					"value": rollbackThread,
					"tab": TAB_GAME,
				},
				{
					"name": "Размер истории откатов",
					"description": "Сколько действий вы хотите иметь возможность отменить",
					"id": "rollbackSlots",
					"type": "int",
					"value": rollbackSlots,
					"tab": TAB_GAME,
				},
				{
					"name": "Делать снимок каждые X выборов",
					"description": "Как часто сохранять состояние отката. 1 = после каждого выбора",
					"id": "rollbackSaveEvery",
					"type": "int",
					"value": rollbackSaveEvery,
					"tab": TAB_GAME,
				},
			]
		},
		{
			"name": "Отладка",
			"id": "debug",
			"options": [
				{
					"name": "Панель отладки/читов",
					"description": "Добавляет кнопку для вызова панели отладки",
					"id": "debugPanel",
					"type": "checkbox",
					"value": debugPanel,
					"tab": TAB_GAME,
				},
			]
		},
	]
	
	var contentSettings = []
	for contentType in ContentType.getAll():
		contentSettings.append({
			"name": ContentType.getVisibleName(contentType),
			"description": ContentType.getDescription(contentType),
			"id": contentType,
			"type": "checkbox",
			"value": isContentEnabled(contentType),
			"tab": TAB_GAMEPLAY,
		})
	settings.append({
		"name": "Включить фетиш-контент",
		"id": "enabledContent",
		"options": contentSettings,
	})
	
	var genderNamesSettings = []
	for gender in NpcGender.getAll():
		var genderExplanation = NpcGender.getGenderExplanation(gender)
		if(genderExplanation == null):
			genderExplanation = ""
		
		genderNamesSettings.append({
			"name": NpcGender.getOptionsDesc(gender),
			"description": genderExplanation,
			"id": gender,
			"type": "string",
			"value": getGenderOverrideName(gender, ""),
			"placeholder": NpcGender.getDefaultVisibleName(gender),
			"tab": TAB_GAME,
		})
	settings.append({
		"name": "Переопределение имен самоидентификации NPC",
		"id": "gendernames",
		"options": genderNamesSettings,
	})
	
	return settings

func applyOption(categoryID, optionID, value):
	if(categoryID == "gendernames"):
		if(value == "" && genderNamesOverrides.has(optionID)):
			genderNamesOverrides.erase(optionID)
		if(value != ""):
			genderNamesOverrides[optionID] = value
	
	if(categoryID == "render"):
		if(optionID == "fpsLimit"):
			fpsLimit = value
			applySettingsEffect()
	
	if(categoryID == "sandbox"):
		if(optionID == "sandboxPawnCount"):
			sandboxPawnCount = value
			if(sandboxPawnCount < 0):
				sandboxPawnCount = 0
		if(optionID == "sandboxBreeding"):
			sandboxBreeding = value
		if(optionID == "sandboxNpcLeveling"):
			sandboxNpcLeveling = value
		if(optionID == "sandboxSeeChances"):
			sandboxSeeChances = value
	
	if(categoryID == "jigglephysics"):
		if(optionID == "jigglePhysicsBreastsEnabled"):
			jigglePhysicsBreastsEnabled = value
		if(optionID == "jigglePhysicsBellyEnabled"):
			jigglePhysicsBellyEnabled = value
		if(optionID == "jigglePhysicsButtEnabled"):
			jigglePhysicsButtEnabled = value
		if(optionID == "jigglePhysicsGlobalModifier"):
			jigglePhysicsGlobalModifier = value

	if(categoryID == "cum"):
		if(optionID == "cumEnabled"):
			cumEnabled = value
		if(optionID == "cumDependsOnBallsSize"):
			cumDependsOnBallsSize = value
		if(optionID == "cumIntensityMult"):
			cumIntensityMult = value

	if(categoryID == "saves"):
		if(optionID == "autosaveEnabled"):
			autosaveEnabled = value

	if(categoryID == "modding"):
		if(optionID == "showModdedLauncher"):
			showModdedLauncher = value
			if(showModdedLauncher):
				var _ok = OS.request_permissions()
		if(optionID == "androidSaveFolder"):
			androidSaveFolder = value
	
	
	if(categoryID == "pregnancy"):
		if(optionID == "menstrualCycleLengthDays"):
			menstrualCycleLengthDays = value
		if(optionID == "eggCellLifespanHours"):
			eggCellLifespanHours = value
		if(optionID == "playerPregnancyTimeDays"):
			playerPregnancyTimeDays = value
		if(optionID == "npcPregnancyTimeDays"):
			npcPregnancyTimeDays = value
		if(optionID == "impregnationChanceModifier"):
			impregnationChanceModifier = value
		if(optionID == "bellySizeDependsOnLitterSize"):
			bellySizeDependsOnLitterSize = value
		if(optionID == "bellyMaxSizeModifier"):
			bellyMaxSizeModifier = value
		if(optionID == "optimizeChilds"):
			optimizeChilds = value
		if(optionID == "maxKeepPCKids"):
			maxKeepPCKids = value
		if(optionID == "maxKeepNPCKids"):
			maxKeepNPCKids = value
		if(optionID == "bigEggsGrowthMult"):
			bigEggsGrowthMult = value
	
	if categoryID == "difficulty":
		if optionID == "hardStruggleEnabled":
			hardStruggleEnabled = value
		if optionID == "smartLockRarity":
			smartLockRarity = value
		if optionID == "overstimulationEnabled":
			overstimulationEnabled = value
		if optionID == "savingInDungeons":
			savingInDungeons = value
	
	if(categoryID == "layout"):
		if(optionID == "blockCatcherPanelHeight"):
			blockCatcherPanelHeight = value
		if(optionID == "uiLayout"):
			uiLayout = value
			applySettingsEffect()
		if(optionID == "shouldScaleUI"):
			shouldScaleUI = value
			applySettingsEffect()
		if(optionID == "uiScaleMultiplier"):
			uiScaleMultiplier = value
			applySettingsEffect()
		if(optionID == "fontSize"):
			fontSize = value
		if(optionID == "uiButtonSize"):
			uiButtonSize = value
		if(optionID == "inventoryIconsSize"):
			inventoryIconsSize = value
	
	if(categoryID == "other"):
		if(optionID == "webTextInputFallback"):
			webTextInputFallback = value
		if(optionID == "fetchLatestRelease"):
			fetchNewRelease = value
		if(optionID == "showSpeakerName"):
			showSpeakerName = value
		if(optionID == "showShortcuts"):
			showShortcuts = value
		if(optionID == "measurementUnits"):
			measurementUnits = value
		if(optionID == "requireDoubleTapOnMobile"):
			requireDoubleTapOnMobile = value
		if(optionID == "showCharacterArt"):
			showCharacterArt = value
		if(optionID == "showSceneArt"):
			showSceneArt = value
		if(optionID == "showSceneCreator"):
			showSceneCreator = value
		if(optionID == "showMapArt"):
			showMapArt = value
		if(optionID == "developerCommentary"):
			developerCommentary = value
		
	if(categoryID == "render"):
		if(optionID == "renderer"):
			myProjectSettings.setDriverName(value)
			myProjectSettings.save()
		if(optionID == "softwareSkinning"):
			myProjectSettings.setForceSoftwareSkinning(value)
			myProjectSettings.save()
		if(optionID == "advancedShadersEnabled"):
			advancedShadersEnabled = value
		if(optionID == "visibleWritings"):
			visibleWritings = value
		if(optionID == "chainsEnabled"):
			chainsEnabled = value
			
	if(categoryID == "debug"):
		if(optionID == "debugPanel"):
			debugPanel = value
	
	if(categoryID == "rollback"):
		if(optionID == "rollbackEnabled"):
			rollbackEnabled = value
		if(optionID == "rollbackThread"):
			rollbackThread = value
		if(optionID == "rollbackSlots"):
			rollbackSlots = Util.maxi(value, 1)
		if(optionID == "rollbackSaveEvery"):
			rollbackSaveEvery = Util.maxi(value, 1)
			
	if(categoryID == "enabledContent"):
		enabledContent[optionID] = value
	print("SETTING "+categoryID+":"+optionID+" TO "+str(value))

func applySettingsEffect():
	checkScreenOrientation()
	applyUIScale()
	
	OS.window_fullscreen = fullscreen
	Engine.target_fps = fpsLimit
	if(fpsLimit == 0):
		OS.vsync_enabled = true
	elif(fpsLimit < 30 || fpsLimit > 999):
		OS.vsync_enabled = false
	else:
		OS.vsync_enabled = true
	
	emit_signal("onLayoutChange")
	
func applyUIScale():
	var idealSize := Vector2(1280,720) if currentScreenOrientation == SCREEN_HORIZONTAL else Vector2(720, 1280)
	
	if(shouldScaleUI):
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_EXPAND,idealSize, uiScaleMultiplier)
	else:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_EXPAND,idealSize)

func getUILayoutRaw() -> int:
	return uiLayout

func getUILayoutFinal() -> int:
	if(uiLayout == LAYOUT_AUTO):
		if(OS.has_feature("mobile") || OS.has_feature("web_android") || OS.has_feature("web_ios")):
			return LAYOUT_TOUCH_HORIZONTAL
		return LAYOUT_NORMAL
	return uiLayout

func onSceneChange():
	checkScreenOrientation()

func setSupportsVertical(_supportsVertical:bool):
	currentSupportsVertical = _supportsVertical
	checkScreenOrientation()

func getCurrentScreenOrientation() -> int:
	return currentScreenOrientation

func isVerticalOrientation() -> bool:
	return currentScreenOrientation == SCREEN_VERTICAL

func isTouchFriendlyUI() -> bool:
	var theFinalLayout:int = getUILayoutFinal()
	return theFinalLayout == LAYOUT_TOUCH_HORIZONTAL || theFinalLayout == LAYOUT_TOUCH_VERTICAL

func checkScreenOrientation():
	var finalLayout:int = getUILayoutFinal()
	var newOrientation:int = 0
	
	if(finalLayout == LAYOUT_TOUCH_VERTICAL && currentSupportsVertical):
		newOrientation = SCREEN_VERTICAL
	else:
		newOrientation = SCREEN_HORIZONTAL
	
	if(newOrientation != currentScreenOrientation):
		var _oldOr:int = currentScreenOrientation
		
		currentScreenOrientation = newOrientation
		
		if(currentScreenOrientation == SCREEN_HORIZONTAL):
			OS.screen_orientation = OS.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
		else:
			OS.screen_orientation = OS.SCREEN_ORIENTATION_SENSOR_PORTRAIT
		
		applyUIScale()
		
		# Only do this on desktop
#		var screenSize:Vector2 = OS.get_screen_size()-Vector2(0.0, 100.0)
#		var newSize:Vector2 = Vector2(OS.window_size.y, OS.window_size.x)
#		#print(newSize)
#		if(newSize.x > screenSize.x):
#			var howMuchScale:float = newSize.x / screenSize.x
#			newSize.x /= howMuchScale
#			newSize.y /= howMuchScale
#		if(newSize.y > screenSize.y):
#			var howMuchScale:float = newSize.y / screenSize.y
#			newSize.x /= howMuchScale
#			newSize.y /= howMuchScale
#		#print(newSize)
#
#		OS.window_size = newSize
		
		#if(get_tree().root && get_tree().root.has_method("onScreenOrientationChange")):
		#	get_tree().root.onScreenOrientationChange(oldOr, newOrientation)
		emit_signal("onScreenOrientationChange")

func isUILayoutRightHanded() -> bool:
	return uiLayoutRightHanded

func toggleUILayoutRightHanded():
	uiLayoutRightHanded = !uiLayoutRightHanded
	saveToFile()

func shouldSoloDollLookRight() -> bool:
	if(getUILayoutFinal() == LAYOUT_TOUCH_HORIZONTAL && uiLayoutRightHanded && GM.ui):
		return true
	return false

func saveData():
	var data = {
		"optionsVersion": 1,
		"enabledContent": enabledContent,
		"fpsLimit": fpsLimit,
		"fetchNewRelease": fetchNewRelease,
		"menstrualCycleLengthDays": menstrualCycleLengthDays,
		"eggCellLifespanHours": eggCellLifespanHours,
		"bigEggsGrowthMult": bigEggsGrowthMult,
		"playerPregnancyTimeDays": playerPregnancyTimeDays,
		"npcPregnancyTimeDays": npcPregnancyTimeDays,
		"impregnationChanceModifier": impregnationChanceModifier,
		"bellySizeDependsOnLitterSize": bellySizeDependsOnLitterSize,
		"bellyMaxSizeModifier": bellyMaxSizeModifier,
		"optimizeChilds": optimizeChilds,
		"maxKeepPCKids": maxKeepPCKids,
		"maxKeepNPCKids": maxKeepNPCKids,
		"hardStruggleEnabled": hardStruggleEnabled,
		"smartLockRarity": smartLockRarity,
		"overstimulationEnabled": overstimulationEnabled,
		"savingInDungeons": savingInDungeons,
		"uiLayout": uiLayout,
		"uiLayoutRightHanded": uiLayoutRightHanded,
		"shouldScaleUI": shouldScaleUI,
		"uiScaleMultiplier": uiScaleMultiplier,
		"uiButtonSize": uiButtonSize,
		"showSpeakerName": showSpeakerName,
		"fontSize": fontSize,
		"showShortcuts": showShortcuts,
		"measurementUnits": measurementUnits,
		"requireDoubleTapOnMobile": requireDoubleTapOnMobile,
		"debugPanel": debugPanel,
		"imagePackOrder": imagePackOrder,
		"showCharacterArt": showCharacterArt,
		"showSceneArt": showSceneArt,
		"showSceneCreator": showSceneCreator,
		"showMapArt": showMapArt,
		"rollbackEnabled": rollbackEnabled,
		"rollbackThread": rollbackThread,
		"rollbackSlots": rollbackSlots,
		"rollbackSaveEvery": rollbackSaveEvery,
		"showModdedLauncher": showModdedLauncher,
		"developerCommentary": developerCommentary,
		"jigglePhysicsBreastsEnabled": jigglePhysicsBreastsEnabled,
		"jigglePhysicsBellyEnabled": jigglePhysicsBellyEnabled,
		"jigglePhysicsButtEnabled": jigglePhysicsButtEnabled,
		"jigglePhysicsGlobalModifier": jigglePhysicsGlobalModifier,
		"advancedShadersEnabled": advancedShadersEnabled,
		"chainsEnabled": chainsEnabled,
		"autosaveEnabled": autosaveEnabled,
		"inventoryIconsSize": inventoryIconsSize,
		"genderNamesOverrides": genderNamesOverrides,
		"cumEnabled": cumEnabled,
		"cumDependsOnBallsSize": cumDependsOnBallsSize,
		"cumIntensityMult": cumIntensityMult,
		"visibleWritings": visibleWritings,
		"sandboxPawnCount": sandboxPawnCount,
		"sandboxBreeding": sandboxBreeding,
		"sandboxNpcLeveling": sandboxNpcLeveling,
		"sandboxSeeChances": sandboxSeeChances,
		"blockCatcherPanelHeight": blockCatcherPanelHeight,
		"webTextInputFallback": webTextInputFallback,
		"fullscreen": fullscreen,
		"profilerEnabled": profilerEnabled,
		"androidSaveFolder": androidSaveFolder,
	}
	
	return data

func loadData(data):
	enabledContent = loadVar(data, "enabledContent", {})
	fetchNewRelease = loadVar(data, "fetchNewRelease", true)
	fpsLimit = loadVar(data, "fpsLimit", 0)
	menstrualCycleLengthDays = loadVar(data, "menstrualCycleLengthDays", 7)
	eggCellLifespanHours = loadVar(data, "eggCellLifespanHours", 48)
	bigEggsGrowthMult = loadVar(data, "bigEggsGrowthMult", 2.0)
	playerPregnancyTimeDays = loadVar(data, "playerPregnancyTimeDays", 5)
	npcPregnancyTimeDays = loadVar(data, "npcPregnancyTimeDays", 5)
	impregnationChanceModifier = loadVar(data, "impregnationChanceModifier", 100)
	bellySizeDependsOnLitterSize = loadVar(data, "bellySizeDependsOnLitterSize", false)
	bellyMaxSizeModifier = loadVar(data, "bellyMaxSizeModifier", 1.0)
	optimizeChilds = loadVar(data, "optimizeChilds", false)
	maxKeepPCKids = loadVar(data, "maxKeepPCKids", 50)
	maxKeepNPCKids = loadVar(data, "maxKeepNPCKids", 30)
	hardStruggleEnabled = loadVar(data, "hardStruggleEnabled", false)
	smartLockRarity = loadVar(data, "smartLockRarity", "normal")
	overstimulationEnabled = loadVar(data, "overstimulationEnabled", true)
	savingInDungeons = loadVar(data, "savingInDungeons", false)
	uiLayout = loadVar(data, "uiLayout", LAYOUT_AUTO)
	uiLayoutRightHanded = loadVar(data, "uiLayoutRightHanded", true)
	shouldScaleUI = loadVar(data, "shouldScaleUI", true)
	uiScaleMultiplier = loadVar(data, "uiScaleMultiplier", 1.0)
	uiButtonSize = loadVar(data, "uiButtonSize", 0)
	showSpeakerName = loadVar(data, "showSpeakerName", true)
	fontSize = loadVar(data, "fontSize", "normal")
	showShortcuts = loadVar(data, "showShortcuts", true)
	measurementUnits = loadVar(data, "measurementUnits", "metric")
	requireDoubleTapOnMobile = loadVar(data, "requireDoubleTapOnMobile", false)
	debugPanel = loadVar(data, "debugPanel", false)
	imagePackOrder = loadVar(data, "imagePackOrder", [])
	showCharacterArt = loadVar(data, "showCharacterArt", true)
	showSceneArt = loadVar(data, "showSceneArt", true)
	showSceneCreator = loadVar(data, "showSceneCreator", true)
	showMapArt = loadVar(data, "showMapArt", false)
	rollbackEnabled = loadVar(data, "rollbackEnabled", false)
	rollbackThread = loadVar(data, "rollbackThread", true)
	rollbackSlots = loadVar(data, "rollbackSlots", 5)
	rollbackSaveEvery = loadVar(data, "rollbackSaveEvery", 1)
	showModdedLauncher = loadVar(data, "showModdedLauncher", false)
	developerCommentary = loadVar(data, "developerCommentary", false)
	jigglePhysicsBreastsEnabled = loadVar(data, "jigglePhysicsBreastsEnabled", true)
	jigglePhysicsBellyEnabled = loadVar(data, "jigglePhysicsBellyEnabled", true)
	jigglePhysicsButtEnabled = loadVar(data, "jigglePhysicsButtEnabled", true)
	jigglePhysicsGlobalModifier = loadVar(data, "jigglePhysicsGlobalModifier", 1.0)
	advancedShadersEnabled = loadVar(data, "advancedShadersEnabled", true)
	chainsEnabled = loadVar(data, "chainsEnabled", true)
	autosaveEnabled = loadVar(data, "autosaveEnabled", true)
	inventoryIconsSize = loadVar(data, "inventoryIconsSize", "small")
	genderNamesOverrides = loadVar(data, "genderNamesOverrides", {})
	cumEnabled = loadVar(data, "cumEnabled", true)
	cumDependsOnBallsSize = loadVar(data, "cumDependsOnBallsSize", true)
	cumIntensityMult = loadVar(data, "cumIntensityMult", 1.0)
	visibleWritings = loadVar(data, "visibleWritings", true)
	sandboxPawnCount = loadVar(data, "sandboxPawnCount", 30)
	sandboxBreeding = loadVar(data, "sandboxBreeding", "rare")
	sandboxNpcLeveling = loadVar(data, "sandboxNpcLeveling", 1.0)
	sandboxSeeChances = loadVar(data, "sandboxSeeChances", true)
	blockCatcherPanelHeight = loadVar(data, "blockCatcherPanelHeight", 16)
	webTextInputFallback = loadVar(data, "webTextInputFallback", false)
	fullscreen = loadVar(data, "fullscreen", false)
	profilerEnabled = loadVar(data, "profilerEnabled", false)
	androidSaveFolder = loadVar(data, "androidSaveFolder", ANDROID_SAVE_FOLDER_DOCUMENTS if data.has("showModdedLauncher") else ANDROID_SAVE_FOLDER_DOWNLOADS)

func saveToFile():
	var saveData = saveData()
	var save_game = File.new()
	save_game.open(optionsFilepath, File.WRITE)
	
	save_game.store_line(JSON.print(saveData, "\t", true))
	
	save_game.close()

func loadFromFile():
	var save_game = File.new()
	if not save_game.file_exists(optionsFilepath):
		print("GlobalOptions: No saved options found, default values will be used")
		return
	
	save_game.open(optionsFilepath, File.READ)
	#var saveData = parse_json(save_game.get_as_text())
	var jsonResult = JSON.parse(save_game.get_as_text())
	if(jsonResult.error != OK):
		Log.printerr("GlobalOptions: Error while loading the options file, the file is not a valid json")
		return
	
	var saveData = jsonResult.result
	loadData(saveData)
	save_game.close()

func loadVar(data: Dictionary, key, nullvalue = null):
	if(!data.has(key)):
		Log.printerr("Warning: Options file doesn't have key "+key+". Using "+str(nullvalue)+" as default value. File: "+Util.getStackFunction())
		return nullvalue
		
	if(nullvalue != null && typeof(data[key]) != typeof(nullvalue) && !(typeof(data[key]) == TYPE_REAL && typeof(nullvalue) == TYPE_INT)):
		Log.printerr("Warning: value mismatch when loading an options file. Key '"+key+"' has type "+Util.variantTypeToString(typeof(data[key]))+" and default value has type "+Util.variantTypeToString(typeof(nullvalue))+". Is that an error? "+Util.getStackFunction())
		
	if(data[key] == null && nullvalue != null):
		Log.printerr("Warning: loaded value is null while the default value isn't. Is that correct? "+Util.getStackFunction())
		
	return data[key]

func resetRenderSettings():
	myProjectSettings.resetToDefault()

func checkImagePackOrder(imagePacks):
	var newImagePackOrder = []
	
	for imagePackID in imagePackOrder:
		if (imagePacks.has(imagePackID)):
			newImagePackOrder.append(imagePackID)
	
	for imagePackID in imagePacks:
		if(!newImagePackOrder.has(imagePackID)):
			newImagePackOrder.push_front(imagePackID)
	
	imagePackOrder = newImagePackOrder
	#print("checkImagePackOrder DONE ",imagePackOrder)

func getImagePackOrder():
	return imagePackOrder

func isFullscreen() -> bool:
	return fullscreen

func shouldProfile() -> bool:
	return profilerEnabled

func shouldUseFallbackTextInputs() -> bool:
	return webTextInputFallback

func _process(_delta:float):
	if(Input.is_action_just_pressed("window_fullscreen")):
		OS.window_fullscreen = !OS.window_fullscreen
		fullscreen = OS.window_fullscreen
		saveToFile()

func toggleShouldProfile():
	profilerEnabled = !profilerEnabled
	GM.createProfiler()
	saveToFile()

func _ready() -> void:
	get_viewport().connect("gui_focus_changed", self, "_on_focus_changed")

func _on_focus_changed(control:Control) -> void:
	if(!OPTIONS.shouldUseFallbackTextInputs()):
		return
	if control == null || !is_instance_valid(control):
		return
	if((control is LineEdit) || (control is TextEdit)):
		if(!OS.has_feature('JavaScript')):
			return
		control.text = JavaScript.eval("""window.prompt('Please Input Text')""")
		control.release_focus()
