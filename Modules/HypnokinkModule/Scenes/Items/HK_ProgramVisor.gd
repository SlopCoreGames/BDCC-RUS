extends SceneBase

var savedText = ""
var uniqueItemID = ""

func _init():
	sceneID = "ProgramVisorScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func _run():
	if(state == ""):
		var visor = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		
		if(visor.programmedToSuppressPerk() == ""):
			saynn("В этом визоре сейчас запущена стандартная программа.")
		elif(visor.programmedToSuppressPerk() == Perk.HypnosisKeywordsDrawback):
			saynn("Этот визор настроен на подавление вашей фиксации на ключевых словах.")
		elif(visor.programmedToSuppressPerk() == Perk.HypnosisFamousDrawback):
			saynn("Этот визор настроен на подавление ваших общеизвестных триггеров.")
		elif(visor.programmedToSuppressPerk() == Perk.HypnosisDeepTranceDrawback):
			saynn("Этот визор настроен на общее снижение вашей уязвимости к гипнозу.")
			
		saynn("Обладая небольшими познаниями, вы сможете изменить программу и, как следствие, собственный разум.")
		
		if(visor.programmedToSuppressPerk() != ""):
			addButton("Сброс", "Сбросить визор до заводских настроек", "reset")
		if(GM.pc.hasPerk(Perk.HypnosisKeywordsDrawback)):
			addButton("Ключевые слова", "Настроить визор на подавление фиксации на ключевых словах", "keywords")
		if(GM.pc.hasPerk(Perk.HypnosisFamousDrawback)):
			addButton("Известные", "Настройте визор так, чтобы он подавлял ваши общеизвестные триггеры.", "famous")
		if(GM.pc.hasPerk(Perk.HypnosisDeepTranceDrawback)):
			addButton("Глубокий транс", "Настройте визор, чтобы снизить вашу общую уязвимость к гипнозу", "deep_trance")
		addButton("Отмена", "Вообще-то, это может быть опасно", "endthescene")
		
	if(state == "post_program"):
		saynn("Вы программируете визор.")
		
		addButton("Продолжить", "У тебя получилось", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "reset"):
		var visor = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		visor.programToSuppressPerk("")
		setState("post_program")
		return
	if(_action == "keywords"):
		var visor = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		visor.programToSuppressPerk(Perk.HypnosisKeywordsDrawback)
		setState("post_program")
		return
	if(_action == "famous"):
		var visor = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		visor.programToSuppressPerk(Perk.HypnosisFamousDrawback)
		setState("post_program")
		return
	if(_action == "deep_trance"):
		var visor = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		visor.programToSuppressPerk(Perk.HypnosisDeepTranceDrawback)
		setState("post_program")
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["savedText"] = savedText
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedText = SAVE.loadVar(data, "savedText", "")
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")

func resolveCustomCharacterName(_charID):
	if(_charID == "attacker"):
		return "pc"
	
	return null
