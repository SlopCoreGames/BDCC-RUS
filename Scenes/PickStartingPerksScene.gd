extends "res://Scenes/SceneBase.gd"

var pickedPerksIds = []

func _init():
	sceneID = "PickStartingPerksScene"

func _run():
	if(state == ""):
		saynn("Выбери стартовые перки. Будь осторожен: выбрать их можно только один раз. Можно взять несколько штук или не брать вовсе.")
		
		sayn("Выбранные перки:")
		for perkID in pickedPerksIds:
			var perk: PerkBase = GlobalRegistry.getPerk(perkID)
			sayn("[b]"+perk.getVisibleName()+"[/b]: "+perk.getVisibleDescription())
		if(pickedPerksIds.size() == 0):
			sayn("[b]— Ничего не выбрано[/b]")
		
		for perkID in GlobalRegistry.getPerksIDsBySkill(Skill.Start):
			var perk: PerkBase = GlobalRegistry.getPerk(perkID)
			
			if(perkID in pickedPerksIds):
				addDisabledButton(perk.getVisibleName(), "[Already picked it] "+perk.getVisibleDescription())
			else:
				addButton(perk.getVisibleName(), perk.getVisibleDescription(), "pickperk", [perkID])
				
		addButton("Очистить всё", "Сбросить все выбранные перки", "clearall")
		addButton("Подтвердить", "Ты хочешь выбрать эти перки?", "endthescene")
				
func _react(_action: String, _args):
	if(_action == "clearall"):
		pickedPerksIds.clear()
		setState("")
		return
	
	if(_action == "pickperk"):
		pickedPerksIds.append(_args[0])
		setState("")
		return
	
	if(_action == "endthescene"):
		for perkID in pickedPerksIds:
			var perk: PerkBase = GlobalRegistry.getPerk(perkID)
			if(perk == null):
				continue
			GM.pc.getSkillsHolder().addPerk(perkID)
		
		endScene()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["pickedPerksIds"] = pickedPerksIds
	
	return data
	
func loadData(data):
	.loadData(data)
	
	pickedPerksIds = SAVE.loadVar(data, "pickedPerksIds", [])
