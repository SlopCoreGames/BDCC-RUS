extends ItemBase

var whoGaveBirth = ""

func _init():
	id = "PlantEgg"

func getVisibleName():
	return "Яйцо растения"
	
func getDescription():
	var byWho = ""
	if(whoGaveBirth != ""):
		var theChar = GlobalRegistry.getCharacter(whoGaveBirth)
		if(theChar == null):
			byWho = "\n\nThis egg was laid by someone unknown.."
		elif(whoGaveBirth == "pc"):
			byWho = "\n\nThis egg was laid by you!"
		else:
			byWho = "\n\nThis egg was laid by "+str(theChar.getName())
	
	return "Очень питательное семя с невероятно сладким вкусом. Поедание убирает 50 единиц боли и добавляет 50 единиц выносливости... но также добавляет 20 единиц похоти."+byWho

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	_attacker.addPain(-50)
	_attacker.addStamina(50)
	_attacker.addLust(20)
	removeXOrDestroy(1)
	return _attacker.getName() + " ate a plant egg! Very crunchy.."

func getPossibleActions():
	return [
		{
			"name": "Съесть!",
			"scene": "UseItemLikeInCombatScene",
			"description": "Съесть яйцо",
		},
	]

func getPrice():
	return 0

func canSell():
	return true

func canCombine():
	return true

func tryCombine(_otherItem):
	if(whoGaveBirth != _otherItem.whoGaveBirth):
		return false
	return .tryCombine(_otherItem)

func getTags():
	return []

func getItemCategory():
	return ItemCategory.Medical

func createEggCellForOviposition() -> EggCell:
	var newEggCell := EggCell.new()
	newEggCell.lifeSpan = 12*60*60 # 12 hours before having to lay it
	newEggCell.bigEggType = BigEggType.Plant
	newEggCell.bigEgg = true
	return newEggCell

func saveData():
	var data = .saveData()
	
	data["whoGaveBirth"] = whoGaveBirth
	
	return data
	
func loadData(data):
	.loadData(data)
	
	whoGaveBirth = SAVE.loadVar(data, "whoGaveBirth", "")
	
func getInventoryImage():
	return "res://Images/Items/medical/pkantegg.png"
