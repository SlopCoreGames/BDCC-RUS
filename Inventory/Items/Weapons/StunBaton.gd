extends ItemBase

var charges:int = 3

func useCharge(amount = 1):
	charges -= amount
	if(charges <= 0):
		destroyMe()

func getCharges():
	return charges

func getDamageRange():
	return [30, 40]

func _init():
	id = "StunBaton"

func getVisibleName():
	return "Электрошокер"

func getDescription():
	var text = "Стандартное оружие охранника.\nНаносит "+Util.dmgRangeArrayStr(getDamageRange())+" физический урон.\nИмеет "+str(charges)+" "+Util.multipleOrSingularEnding(charges, "charge")+" left"

	return text

func saveData():
	var data = .saveData()
	
	data["charges"] = charges
	
	return data
	
func loadData(data):
	.loadData(data)
	
	charges = SAVE.loadVar(data, "charges", 3)

func getAttacks():
	return ["StunBatonPCAttack", "StunBatonStunPCAttack"]

func getTags():
	return [ItemTag.Illegal]

func getItemCategory():
	return ItemCategory.Weapons
	
func getInventoryImage():
	return "res://Images/Items/weapon/stunbaton.png"
