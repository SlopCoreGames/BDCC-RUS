extends ItemBase

func _init():
	id = "vaginalplug"

func getVisibleName():
	return "Вагинальная пробка"
	
func getDescription():
	return "Классическая пробка из черного силикона; имеет стандартный размер и оснащена встроенным вибромотором"

func getClothingSlot():
	return InventorySlot.Vagina

func getRequiredBodypart():
	return BodypartSlot.Vagina

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.MinLoosenessVaginaBuff, [2.0]),
		buff(Buff.SensitivityGainBuff, [25.0]),
		buff(Buff.BlocksVaginaLeakingBuff),
		]

func getPrice():
	return 4

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks]#[ItemTag.BDSMRestraint]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintVaginalplug.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "плавно вытаскивает вагинальную пробку из твоей киски"
	else:
		return "вытащи вагинальную пробку из своей киски"

func getPuttingOnStringLong(withS):
	if(withS):
		return "вставляет вагинальную пробку в твою киску"
	else:
		return "вставь вагинальную пробку в свою киску"

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" была затолкана в твою "+RNG.pick(["pussy", "pussy", "cunt", "slit"])+". Она может внезапно начать вибрировать!"
	else:
		return getAStackNameCapitalize()+" была затолкана в {receiver.nameS} "+RNG.pick(["pussy", "pussy", "cunt", "slit"])+". Она может внезапно начать вибрировать!"

func getInventoryImage():
	return "res://Images/Items/bdsm/plug.png"
