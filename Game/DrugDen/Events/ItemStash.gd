extends DrugDenEventBase

var trapLevel:int = 0 # 0 = 5% trap, 1 = 50% trap, 2 = 95% trap
var trapType:int = 0 # 0 = pain, 1 = lust, 2 = bdsm
var stashDesc:String = ""

func _init():
	id = "ItemStash"
	eventWeight = 0.5

func onSpawn(_drugDen):
	trapType = RNG.randi_range(0, 2)
	
	trapLevel = 0
	if(RNG.chance(50)):
		if(RNG.chance(70)):
			trapLevel = 1
		else:
			trapLevel = 2
	
	
	var sus1:bool = false
	var sus2:bool = false
	if(trapLevel >= 2):
		sus1 = true
		sus2 = true
	if(trapLevel == 1):
		sus1 = RNG.chance(50)
		sus2 = !sus1
	
	var descsDB:Array = [
		{
			text = "У подножия сломанной трубы стоит старый ржавый ящик для инструментов. Крышка слегка приоткрыта, позволяя заглянуть внутрь. {slot1} Вокруг не шелохнулось ни пылинки, будто он простоял здесь целую вечность. {slot2}",
			slot1sus = [
				"Защелка не заржавела, лишь по краям видны мелкие царапины.",
			],
			slot1 = [
				"Защелка изъедена коррозией и едва удерживает крышку закрытой.",
			],
			slot2sus = [
				"В воздухе вокруг витает слабый химический запах.",
			],
			slot2 = [
				"Воздух здесь застоявшийся, ничего необычного.",
			],
		},
		{
			text = "У стены туннеля прислонен пыльный рюкзак, ремень которого наполовину истлел от старости. {slot1} Молния почти застегнута, хотя кажется, что кто-то уже рылся в нем раньше. {slot2}",
			slot1sus = [
				"Ткань снизу слегка приподнята, будто под ней что-то твердое.",
			],
			slot1 = [
				"Материал просел, прогибаясь под собственным весом.",
			],
			slot2sus = [
				"У молнии торчат несколько ниток, будто их недавно зацепили.",
			],
			slot2 = [
				"Швы полностью целы, хоть и немного потерты.",
			],
		},
		{
			text = "Старый деревянный ящик с припасами прислонен к холодной стене, его поверхность покрыта царапинами и граффити. {slot1} Несколько гвоздей разболтались, намекая на то, что его уже открывали. {slot2}",
			slot1sus = [
				"По краям заметна слабая вмятина, словно крышку вдавлен обратно на место.",
			],
			slot1 = [
				"Крышка лежит неровно: один край чуть выше другого.",
			],
			slot2sus = [
				"Граффити внизу выглядит размазанным, будто по нему недавно что-то провели.",
			],
			slot2 = [
				"Пыль забилась в борозды граффити, сливаясь с текстурой дерева.",
			],
		},
		{
			text = "Помятый металлический шкафчик стоит прямо, его дверца слегка приоткрыта. {slot1} На поверхности выцарапано выцветшее число, которое почти невозможно разобрать. {slot2}",
			slot1sus = [
				"Между ручкой и дверью виден узкий, неровный зазор.",
			],
			slot1 = [
				"Ручка плотно прилегает к поверхности, заржавевшая и неподвижная.",
			],
			slot2sus = [
				"Вокруг петель видны крошечные чешуйки содранной краски.",
			],
			slot2 = [
				"Петли покрыты толстым слоем грязи.",
			],
		},
		{
			text = "В углу стоит коробка, краска на которой облупилась и выцвела. {slot1} Защелка всё еще цела, хотя выглядит довольно изношенной. {slot2}",
			slot1sus = [
				"В пыли вокруг защелки виден слабый контур отпечатка руки.",
			],
			slot1 = [
				"Пыль лежит ровным слоем, её долго никто не трогал.",
			],
			slot2sus = [
				"Крышка прилегает не плотно, оставляя крошечный неровный зазор.",
			],
			slot2 = [
				"Крышка плотно закрыта, края идеально подогнаны друг к другу.",
			],
		},
		{
			text = "За неплотной панелью вы обнаруживаете небольшой тайник. {slot1} Он накрыт обрывком ткани, словно кто-то пытался его спрятать. {slot2}",
			slot1sus = [
				"На ткани с одной стороны видна одна четкая складка, выделяющаяся на фоне остальных морщин.",
			],
			slot1 = [
				"Ткань скомкана и застыла от пыли.",
			],
			slot2sus = [
				"Внутренние края панели выглядят странно гладкими по сравнению с грубым бетоном вокруг.",
			],
			slot2 = [
				"Края панели сколоты и неровны, они почти сливаются со стеной.",
			],
		},
		{
			text = "На куче хлама лежит гладкий металлический кейс, отражающий тусклый свет. {slot1} Замок выглядит просто — обычная защелка. {slot2}",
			slot1sus = [
				"Окружающий хлам слегка отодвинут в стороны, будто кейс поставили сюда совсем недавно.",
			],
			slot1 = [
				"Кейс частично погребен под обломками, словно он пролежал здесь целую вечность.",
			],
			slot2sus = [
				"Рядом с защелкой видна тонкая, едва заметная царапина, которая ловит блики света.",
			],
			slot2 = [
				"Поверхность матовая, потертая от времени, но без свежих царапин.",
			],
		},
		{
			text = "В выдолбленной части бетонной стены спрятан тайник. {slot1} Пространства как раз хватает для небольшого запаса припасов. {slot2}",
			slot1sus = [
				"Пол прямо перед ним чуть менее пыльный, чем остальная поверхность.",
			],
			slot1 = [
				"Пол покрыт толстым, нетронутым слоем пыли.",
			],
			slot2sus = [
				"На дне тайника лежит слегка погнутый кусок металла, который почти не выделяется из общей массы.",
			],
			slot2 = [
				"Дно завалено всяким хламом, ничего примечательного.",
			],
		},
	]
	
	var pickedDescEntry:Dictionary = RNG.pick(descsDB)
	
	stashDesc = pickedDescEntry["text"]
	if(sus1):
		stashDesc = stashDesc.replace("{slot1}", RNG.pick(pickedDescEntry["slot1sus"]))
	else:
		stashDesc = stashDesc.replace("{slot1}", RNG.pick(pickedDescEntry["slot1"]))
	if(sus2):
		stashDesc = stashDesc.replace("{slot2}", RNG.pick(pickedDescEntry["slot2sus"]))
	else:
		stashDesc = stashDesc.replace("{slot2}", RNG.pick(pickedDescEntry["slot2"]))
	

func getMaxPerFloor() -> int:
	return 1

func getCooldown() -> int:
	return 0 #RNG.randi_range(1, 2)

func getInteractInfo() -> Dictionary:
	return {
		text = "Вы замечаете кое-что интересное..\n\n"+stashDesc+"\n\nХочешь попробовать его обшарить?",
		actions = [
			{
				id = "loot",
				name = "Обыскать",
				desc = "Посмотри, вдруг удастся найти что-нибудь полезное!",
				args = [],
				disabled = false,
			},
		],
	}

func doInteract(_actionID:String, _args:Array = []) -> Dictionary:
	var trapChance:float = 5.0
	if(trapLevel == 1):
		trapChance = 50.0
	if(trapLevel >= 2):
		trapChance = 95.0
		
	if(RNG.chance(trapChance)):
		var beginText:String = "[b]Оно застряло ("+str(Util.roundF(trapChance, 1))+"% chance)![/b] "
		if(trapType == 0):
			GM.pc.addPain(RNG.randi_range(20, 40))
			return {text=beginText+"Как только ты коснулся тайника, тебя ударило током. Ай!", ended=true, anim=[StageScene.Solo, "hurt"]}
		elif(trapType == 1):
			GM.pc.addLust(RNG.randi_range(40, 80))
			return {text=beginText+"Тебя окутывает облако афродизиакающего газа, от которого ты мгновенно начинаешь дико хотеть секса!", ended=true, anim=[StageScene.Solo, "stand"]}
		else:
			GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, 2)
			return {text=beginText+"Тебя насильно заковывают в кандалы!", ended=true, anim=[StageScene.Solo, "hurt"]}
	else:
		return {text="Ты проверяешь тайник на наличие чего-нибудь полезного...", noLootText="К сожалению, здесь пусто.", lootTable="junkieStash", ended=true}

func getMapIcon():
	return RoomStuff.RoomSprite.IMPORTANT

func saveData() -> Dictionary:
	return {
		trapLevel = trapLevel,
		stashDesc = stashDesc,
		trapType = trapType,
	}

func loadData(_data:Dictionary):
	trapLevel = SAVE.loadVar(_data, "trapLevel", 0)
	stashDesc = SAVE.loadVar(_data, "stashDesc", "")
	trapType = SAVE.loadVar(_data, "trapType", 0)
