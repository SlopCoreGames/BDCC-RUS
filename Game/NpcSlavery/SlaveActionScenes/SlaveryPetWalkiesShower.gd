extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter


func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func _reactInit():
	processTime(10*60)
	npc.afterTakingAShower()
	
	var npcSlavery:NpcSlave = npc.getNpcSlavery()
	if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
		npcSlavery.getActivity().satisfyWant("shower")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "SlaveryPetWalkiesShower"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppySexOral, "tease", {pc="pc", npc=npcID, npcBodyState={naked=true, leashedBy="pc"}})

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(GM.pc.getLocation() == "main_dressing2"):
			aimCameraAndSetLocName("main_shower2")
		else:
			aimCameraAndSetLocName("main_shower1")
		
		saynn("Вы подводите своего питомца под одну из свободных душевых головок и начинаете мыть {npc.him} под струями холодной воды, нежно расчесывая руками {npc.his} шерсть.")
		
		saynn("[say=pc]Время купания![/say]")
		
		if(npcSlavery.isActivelyResisting()):
			saynn("Ваш питомец ворчит и пытается сопротивляться, но благодаря щенячьим фиксаторам {npc.him} остается почти беспомощным.")
		elif(npcSlavery.getFear() >= 40):
			saynn("Ваш питомец дрожит и прижимает {npc.his} голову.")
		else:
			saynn("Ваш питомец виляет {npc.his} задом и игриво лает.")
			
		saynn("Вскоре вся грязь, что была на вашем драгоценном щенке, исчезает.")
		
		addButton("Хватит", "Это было весело", "endthescene")
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 5):
			addButton("Помыть внутри", "Вымыть их дырочки", "clean_inside")
		else:
			addDisabledButton("Помыть внутри", "Требуется навык питомца D+ или выше")
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 8):
			addButtonWithChecks("Накормить кончой", "Трахать в глотку своего питомца", "start_feed_cum", [], [[ButtonChecks.HasReachablePenis]])
			addButtonWithChecks("Накормить девичьей кончой", "Втирать кончу в лицо питомца", "start_feed_girlcum", [], [[ButtonChecks.HasReachableVagina]])
		else:
			addDisabledButton("Накормить кончой", "Требуется навык «Ласка» уровня B- или выше")
		
	if(state == "start_feed_cum"):
		playAnimation(StageScene.PuppySexOral, "sex", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true, leashedBy="pc"}, bodyState={naked=true,hard=true}})
		
		saynn("Вид чистого и довольного питомца заставляет тебя захотеть немного больше извращений с {npc.him}.")
		
		saynn("Ты решаешь угостить своего питомца лакомством... лакомством особого рода. Твой питомец с огромным интересом наблюдает, как ты выключаешь воду и опускаешься на колени рядом. У {npc.His} текут слюнки в предвкушении, когда ты обнажаешь свой {pc.penis} и подносишь {npc.his} голову ближе.")
		
		saynn("[say=pc]Будь хорошей {npc.boy} и открой ротик.[/say]")
		
		saynn("Твердой, но нежной рукой ты направляешь свой член к ожидающим губам питомца. Твой питомец послушно принимает твой твердый орган, пропуская его сквозь {npc.his} клыки, пока головка не упирается в {npc.his} горло.")
		
		saynn("[say=pc]Хочешь вкусняшку — соси хорошо.[/say]")
		
		saynn("Твой питомец смыкает {npc.his} губы вокруг твоего члена, когда ты начинаешь трахать {npc.his} рот, проталкивая головку глубоко в {npc.his} горло, проверяя рвотный рефлекс!")
		
		addButton("Покормить", "Корми их хорошо", "do_feed_cum")
		
	if(state == "do_feed_cum"):
		playAnimation(StageScene.PuppySexOral, "fast", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true, leashedBy="pc"}, bodyState={naked=true,hard=true}})
		
		saynn("Твой питомец так усердно работает {npc.his} языком, что проходит всего пара минут, прежде чем твой член начинает пульсировать внутри {npc.his} рта.")
		
		saynn("Ты кряхтишь, когда твой {pc.penis} изливается прямо внутрь. Твоё семя, густое и кремовое, обволакивает {npc.his} язык и начинает плавно соскальзывать в {npc.his} горло, волна за волной. Твой питомец послушно всё проглатывает, а {npc.his} горло обхватывает твой член своими стенками.")
		
		saynn("[say=pc]Умница {npc.boy}, держи вкусняшку.[/say]")
		
		saynn("Когда вы закончите скармливать своему питомцу свой {pc.cum}, вы предложите {npc.him} немного ласки и почесушек.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "start_feed_girlcum"):
		playAnimation(StageScene.PuppySexOral, "grind", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true, leashedBy="pc"}, bodyState={naked=true,hard=true}})
		
		saynn("Вид чистого и довольного питомца заставляет тебя захотеть немного больше извращений с {npc.him}.")
		
		saynn("Вы решаете угостить своего питомца лакомством... лакомством совсем другого рода. Ваш питомец с огромным интересом наблюдает за тем, как вы выключаете воду и встаете рядом. {npc.His} рот наполняется слюной в предвкушении, пока вы обнажаете свою {pc.pussyStretch} киску и подносите {npc.his} голову ближе.")
		
		saynn("[say=pc]Будь хорошей {npc.boy} и используй свой язычок.[/say]")
		
		saynn("Сказав это, ты прижимаешься щелью своей киски к {npc.his} губам, задевая их влажными складками. Почувствовав, как {npc.his} язык начинает исследовать твои лепестки, ты начинаешь медленно тереться лицом о {npc.his}, проглаживая своей киской {npc.his} язык и черты лица.")
		
		saynn("С каждым движением ты помечаешь своего питомца своими соками, вбивая свой запах в {npc.him}. Это чертовски приятно, и твои милые стоны начинают наполнять комнату...")
		
		addButton("Покормить", "Корми их хорошо", "do_feed_girlcum")
		
	if(state == "do_feed_girlcum"):
		playAnimation(StageScene.PuppySexOral, "grind", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true, leashedBy="pc"}, bodyState={naked=true,hard=true}})
		
		saynn("Ты вжимаешь лицо своего питомца в себя всё быстрее и сильнее, твоя киска судорожно пульсирует вокруг этого языка... пока тебя не накрывает оргазм.")
		
		saynn("Твое тело начинает корчиться, когда сжимающаяся киска извергает фонтан {pc.girlcum} прямо в рот твоему питомцу. Твои теплые соки стекают по {npc.his} языку и горлу, пока {npc.he} жадно слизывает их. Оргазмические ощущения прошивают тебя дрожью, и из тебя вырывается еще больше милых стонов.")
		
		saynn("[say=pc]Вкусные {npc.boy}.. Слизывай всё до капли.. да, именно так.[/say]")
		
		saynn("Накормив своего питомца своими {pc.girlcum}, ты ласкаешь {npc.him}, почесывая за ушком.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "clean_inside"):
		playAnimation(StageScene.PuppyPinned, "pinned", {pc="pc", npc=npcID, npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		
		if(npc.hasReachableVagina()):
			saynn("Тебе также хочется промыть дырочки внутри своего питомца, поэтому ты встаешь и ставишь ногу на голову {npc.his}, прижимая {npc.him} к холодному мокрому полу и заставляя {npc.him} задрать {npc.his} задницу повыше, так чтобы {npc.his} киска и анус оказались прямо под струями душа.")
			
			saynn("[say=pc]Нужно отмыть тебя везде, щеночек.[/say]")
			
			saynn("Вода начинает стекать по интимным местам твоего питомца, смывая всю грязь. Немного унизительно... но не для послушных щенков.")
			
			saynn("Твой питомец тихо стонет, когда вода струится по {npc.his} чувствительным складкам киски.")
		else:
			saynn("Вы также хотите промыть внутри хвостового отверстия вашего питомца, поэтому встаете и ставите ногу на голову {npc.his}, прижимая {npc.him} к холодному мокрому полу и заставляя {npc.him} высоко задирать {npc.his}, так чтобы задница оказалась прямо под струями душа.")
			
			saynn("[say=pc]Нужно отмыть тебя везде, щеночек.[/say]")
			
			saynn("Вода начинает стекать по интимным местам твоего питомца, смывая всю грязь. Немного унизительно... но не для послушных щенков.")
			
			if(npc.isWearingChastityCage()):
				saynn("Ваш питомец тихо стонет, пока вода стимулирует хвостовое отверстие {npc.his}, а зажатый в клетке член {npc.his} слегка подергивается.")
			elif(npc.hasReachablePenis()):
				saynn("Ваш питомец тихо стонет, пока вода стимулирует хвостовое отверстие {npc.his}, а {npc.his} {npc.penis} твердый и слегка подергивается.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "clean_inside"):
		processTime(10*60)
		if(!npc.clearOrificeFluidsCheckBlocked()):
			addMessage("Something prevented you from clearing every hole")

	if(_action == "start_feed_cum"):
		processTime(5*60)
	
	if(_action == "start_feed_girlcum"):
		processTime(5*60)
	
	if(_action == "do_feed_cum"):
		processTime(5*60)
		npc.gotThroatFuckedBy("pc")
		npc.cummedInMouthBy("pc")
		GM.pc.orgasmFrom(npcID)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")
		
	if(_action == "do_feed_girlcum"):
		processTime(5*60)
		npc.cummedInMouthBy("pc", FluidSource.Vagina)
		GM.pc.orgasmFrom(npcID)
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
