extends ItemBase

func _init():
	id = "caninedildogag"

func getVisibleName():
	return "Собачий дилдо-кляп"
	
func getDescription():
	return "Состоит из шлейки и узловатого резинового дилдо, который плотно затыкает рот"

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		buff(Buff.GagBuff),
		buff(Buff.AmbientLustBuff, [20]),
		buff(Buff.MinLoosenessThroatBuff, [2.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 8

func getSellPrice():
	return 2

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBallGag.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" плотно затянулся на твоей голове. Резиновый член в форме собачьей морды растягивает твое горло!"
	else:
		return getAStackNameCapitalize()+" плотно затянулся на голове {receiver.nameS}. Резиновый член в форме собачьей морды растягивает горло {receiver.his}!"

func updateDoll(doll: Doll3D):
	doll.setState("mouth", "ballgag")

func getInventoryImage():
	return "res://Images/Items/bdsm/ballgag.png"
