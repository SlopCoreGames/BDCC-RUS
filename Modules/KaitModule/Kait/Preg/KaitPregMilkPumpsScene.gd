extends SceneBase

var breastPumpID = ""
var milkAm = 0.0

func _init():
	sceneID = "KaitPregMilkPumpsScene"

func _run():
	if(state == ""):
		addCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("Выбери, какой молокоотсос ты хочешь использовать... если вообще хочешь.")

		addButton("Отмена", "Вы передумали", "endthescene")
		addButton("Использовать руки", "Никакая помпа использоваться не будет", "do_pick_nobreastpump")
		addPumpButtons("do_pick_breastpump")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_pick_breastpump")
	if(state == "do_milk"):
		playAnimation(StageScene.Grope, "tease", {pc="kait", npc="pc"})
		saynn("Ты быстро и жадно осматриваешь Кейт с ног до головы.")

		saynn("Её футболка сидит очень плотно... в основном из-за её беременного живота, но её заметно увеличившаяся грудь тоже не помогает.")

		saynn("Ты замечаешь два тёмных влажных пятна на ткани... прямо там, где у неё грудь.")

		saynn("[say=pc]Как твоя грудь?[/say]")

		saynn("[say=kait]Чешется... и кажется такой налитой.[/say]")

		saynn("[say=pc]Я могу с этим помочь. Иди сюда.[/say]")

		saynn("Ты достаёшь молокоотсосы и показываешь их ей.")

		saynn("Её ушки приподнимаются, она закусывает губу.")

		saynn("[say=pc]Придется раздеться. Сквозь одежду не получится.[/say]")

		saynn("[say=kait]Хорошо.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_put_pump_on")
	if(state == "do_put_pump_on"):
		#addCharacter("kait", ["naked"])
		playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="kait", npcBodyState={hard=true}})
		saynn("Она медленно расстегивает пуговицы и распахивает рубашку, обнажая свои набухшие груди. Они тяжелые и полные, покоятся на ее огромном животе. Ее темные соски выглядят упругими и блестящими. Идеально.")

		saynn("Вы осторожно берете одну из ее грудей в ладонь, заставляя ее тихо вдохнуть. Вы накрываете сосок первой чашей молокоотсоса, следя за тем, чтобы она держалась сама по себе. Затем делаете то же самое со второй. Она наблюдает за вами, ее дыхание становится чуть чаще.")

		saynn("[say=kait]Ладно... ладно... Можешь включать.[/say]")

		saynn("Какая нетерпеливая кошечка.")

		saynn("[say=pc]Не хочу, чтобы ты упала. Иди сюда.[/say]")

		saynn("Вы обнимаете снежную леопардицу сзади и помогаете ей опустить свою пушистую попку на пол.")

		saynn("Затем вы, наконец, щелкаете переключателями. Начинается мягкое жужжание. Насосы выкачивают весь лишний воздух, плотно обхватывая грудь Кейт... а затем они начинают свой размеренный ритм, потягивая соски Кейт. Ее спина слегка выгибается.")

		saynn("[say=kait]Ах... ммм...[/say]")

		saynn("Ты просто поддерживаешь её сзади, твои руки ложатся на её пухлые бёдра.")

		saynn("Кейт зажмуривается, она снова прикусывает губу. Насосы тщетно пытаются вытянуть молоко из её груди... но лишь на мгновение.")

		saynn("Вскоре в чашку начинает течь первая тонкая струйка. А затем к ней присоединяется вторая, вытягиваемая из её набухших сосков.")

		saynn("[say=kait]Ах.. оно так сильно идет..[/say]")

		saynn("[say=pc]Слишком сильно?[/say]")

		saynn("[say=kait]Нет.. всё хорошо.. очень хорошо..[/say]")

		saynn("Она откидывается на тебя, обвивая своим хвостом твою талию. Ты кладешь подбородок ей на плечо и просто наблюдаешь за её телом и реакциями. Её состояние мечется от сильного напряжения к расслаблению, а губы издают милые тихие стоны, пока насосы продолжают свою работу.")

		saynn("Насосы вытягивают всё больше и больше этого сладкого нектара, наполняя бутылочки капля за каплей. Струйки молока, которые раньше были тонкими, теперь стали гораздо толще и ровнее. Кейт тихонько дышит, ерзая в твоих руках и отдаваясь ощущениям.")

		saynn("[say=kait]Ммм.. чувствую, как оно.. вытягивается.. соски так покалывает.. ах..[/say]")

		saynn("Вся комната наполнена ароматом возбужденной кошечки, а также жужжанием насосов и милыми вздохами и стонами.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_actually_milk_pumps")
	if(state == "do_actually_milk_pumps"):
		saynn("Насосам удалось сцедить из груди Кейт "+str(Util.roundF(milkAm))+" мл молока!")

		saynn("Ты крепко прижимаешь Кейт к себе. Её грудь кажется мягче, она больше не выглядит так мучительно налитой. Поток молока замедляется, превращаясь в тонкую струйку... а затем всего лишь в несколько капель... Её соски выглядят очень чувствительными.")

		saynn("[say=pc]Думаю, это всё.[/say]")

		saynn("[say=kait]Ммм... Думаю, ты прав... ах...[/say]")

		saynn("Ты выключаешь насосы и начинаешь осторожно их снимать. Кейт слегка морщится, когда прохладный воздух проникает под чашечки, обволакивая её темные соски.")

		saynn("Кейт смотрит на результат... в бутылочках насоса теперь плещется много молока.")

		saynn("[say=kait]Я сделала это... моё тело сделало это... хах...[/say]")

		saynn("[say=pc]И скоро оно сможет сделать это снова.[/say]")

		saynn("Она посмеивается.")

		saynn("[say=kait]Спасибо. Это... именно то, что мне было нужно.[/say]")

		saynn("[say=pc]Не за что.[/say]")

		saynn("Ты убираешь молокоотсосы. Сцеживание окончено!")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene_getbackpump")
	if(state == "milk_no_pump"):
		playAnimation(StageScene.GropeBehind, "idle", {pc="kait", npc="pc"})
		saynn("Ты быстро и жадно осматриваешь Кейт с ног до головы.")

		saynn("Её футболка сидит очень плотно... в основном из-за её беременного живота, но её заметно увеличившаяся грудь тоже не помогает.")

		saynn("Ты замечаешь два тёмных влажных пятна на ткани... прямо там, где у неё грудь.")

		saynn("[say=pc]Как твоя грудь?[/say]")

		saynn("[say=kait]Чешется... и кажется такой налитой.[/say]")

		saynn("[say=pc]Я могу с этим помочь. Иди сюда.[/say]")

		saynn("Ты обнимаешь снежную леопардицу сзади и начинаешь расстегивать её рубашку... пуговицу за пуговицей.")

		addButton("Продолжить", "Смотреть, что будет дальше", "grope_floor")
	if(state == "grope_floor"):
		#addCharacter("kait", ["naked"])
		playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="kait", npcBodyState={hard=true}})
		saynn("Когда её грудь оказывается на виду, ты помогаешь ей плавно опуститься на колени, прижимая её спиной к своей груди. Так надежнее, чем рисковать тем, что у неё подкосятся ноги.")

		saynn("Закончив с рубашкой, ты обхватываешь её руками, и твои ладони ложатся на её набухшую грудь. Под твоими пальцами она кажется теплой и мягкой. Кейт издает тихий вздох.")

		saynn("[say=kait]Это так приятно...[/say]")

		saynn("Ты начинаешь с того, что осторожно обхватываешь её грудь, поначалу просто удерживая её. Твои пальцы выписывают маленькие круги вокруг сосков, заставляя её вздрагивать в твоих руках.")

		saynn("[say=kait]Они такие... чувствительные...[/say]")

		saynn("Ты продолжаешь ласкать её изгибы, проводя пальцами по соскам, которые твердеют под твоими прикосновениями.")

		saynn("[say=pc]Стало чуть лучше?[/say]")

		saynn("[say=kait]Да... но... всё равно чешутся...[/say]")

		saynn("Похоже на приглашение.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_grope_breasts")
	if(state == "do_grope_breasts"):
		playAnimation(StageScene.BreastGroping, "grope", {pc="pc", npc="kait", npcBodyState={hard=true}})
		saynn("Ты перестаешь нежно ласкать её грудь и вместо этого начинаешь по-настоящему её мять; твои пальцы вжимаются в мягкие молочные железы, слегка погружаясь в мех. Кейт тут же издает короткий вздох, прижимаясь спиной к тебе.")

		saynn("[say=kait]Охх.. да.. вот так..[/say]")

		saynn("Ты продолжаешь сжимать её грудь, снова и снова... пока это не случается.")

		saynn("Из одного из её сосков вырывается крошечный фонтанчик молока. Кейт стонет.")

		saynn("[say=kait]Ах..[/say]")

		saynn("Ты продолжаешь, и вскоре из второго соска бьет похожий фонтан. Разумеется, ты не останавливаешься, твои руки так и работают над её грудью. Каждый раз, когда ты сжимаешь её, вылетает еще одна маленькая струйка молока — мощная, но тонкая. Чем сильнее ты разминаешь её грудь, тем сильнее она течет.")

		saynn("[say=kait]Ммм.. ах.. хах.. я такая молочная..[/say]")

		saynn("Теперь она начинает немного ерзать, её дыхание учащается.")

		saynn("Ты продолжаешь доить её, массируя руками... стимулируя поток... И это работает: молоко Кейт течет всё быстрее, тонкие струйки стекают с её увеличившихся темных ареол, капая на пол. Кейт запрокидывает голову и стонет в пустоту.")

		saynn("[say=kait]Так.. так приятно.. ах.. ммм.. да-а..[/say]")

		saynn("Так продолжается какое-то время.. Ты чувствуешь, как её грудь в твоих руках постепенно теряет объём, наполненность уходит. Руки устают, но ты не останавливаешься.")

		saynn("[say=kait]Ммм.. ах..[/say]")

		saynn("В конце концов поток начинает замедляться.. струйки превращаются в редкие капли..")

		saynn("[say=kait]Кажется, это всё..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "grope_after")
	if(state == "grope_after"):
		playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="kait", npcBodyState={naked=true, hard=true}})
		saynn("Ты делаешь последнее мягкое сжатие её груди.. и останавливаешься.")

		saynn("Кейт удовлетворенно вздыхает.")

		saynn("[say=kait]Так гораздо лучше.. спасибо..[/say]")

		saynn("Ты убираешь руки.. но они всё ещё влажные от её молока. Ты быстро слизываешь его, почему бы и нет.. на вкус сладкое.")

		saynn("После этого ты помогаешь Кейт натянуть рубашку обратно на её беременный живот.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addPumpButtons(go_id):
	var pumps = GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump)
	for pump in pumps:
		addButton(pump.getVisibleName(), pump.getVisibleDescription(), go_id, [pump])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		fixUniform("kait")
		endScene()
		return

	if(_action == "do_pick_nobreastpump"):
		breastPumpID = ""
		setState("milk_no_pump")
		return

	if(_action == "do_pick_breastpump"):
		var pump = _args[0]
		breastPumpID = pump.getUniqueID()
		#GM.pc.getInventory().removeItem(pump)
		#getCharacter("kait").getInventory().forceEquipRemoveOther(pump)
		setState("do_milk")
		return

	if(_action == "do_put_pump_on"):
		processTime(15*60)
		openShirt("kait")
		var pump = GM.pc.getInventory().getItemByUniqueID(breastPumpID)
		if(pump):
			GM.pc.getInventory().removeItem(pump)
			getCharacter("kait").getInventory().forceEquipRemoveOther(pump)

	if(_action == "grope_floor"):
		openShirt("kait")

	if(_action == "grope_after"):
		fixUniform("kait")

	if(_action == "do_actually_milk_pumps"):
		var pump = getCharacter("kait").getInventory().getItemByUniqueID(breastPumpID)
		var howMuchTransferred = getCharacter("kait").getBodypart(BodypartSlot.Breasts).getFluids().transferTo(pump, 1.0)
		#addMessage("The pump managed to milk Kait's breasts for "+str(Util.roundF(howMuchTransferred))+" ml")
		milkAm = howMuchTransferred
		GM.pc.addSkillExperience(Skill.Milking, 30)
		getCharacter("kait").addEffect(StatusEffect.SoreNipplesAfterMilking)
		getCharacter("kait").updateAppearance()

	if(_action == "endthescene_getbackpump"):
		fixUniform("kait")
		var pump = getCharacter("kait").getInventory().getItemByUniqueID(breastPumpID)
		getCharacter("kait").getInventory().removeEquippedItem(pump)
		GM.pc.getInventory().addItem(pump)
		endScene()
		return

	if(_action == "do_grope_breasts"):
		processTime(15*60)

	if(_action == "grope_after"):
		getCharacter("kait").milk(1.0)
		GM.pc.addSkillExperience(Skill.Milking, 30)
		getCharacter("kait").addEffect(StatusEffect.SoreNipplesAfterMilking)

	setState(_action)

func saveData():
	var data = .saveData()

	data["breastPumpID"] = breastPumpID
	data["milkAm"] = milkAm

	return data

func loadData(data):
	.loadData(data)

	breastPumpID = SAVE.loadVar(data, "breastPumpID", "")
	milkAm = SAVE.loadVar(data, "milkAm", 0.0)
