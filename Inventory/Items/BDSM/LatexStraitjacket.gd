extends ItemBase

var chastity:bool = true

func _init():
	id = "LatexStraitjacket"

func getVisibleName():
	return "Латексная смирительная рубашка"

func getDescription():
	if(chastity):
		return "Очень модная смирительная рубашка, в комплекте с поясом целомудрия и отверстиями для груди\nПояс целомудрия: [b]Включен[/b]"
	return "Очень модная смирительная рубашка с отверстиями для груди\nПояс целомудрия: [b]Выключен[/b]"

func getClothingSlot():
	return InventorySlot.Body

func getBuffs():
	if(chastity):
		return [
			buff(Buff.BlockedHandsBuff),
			buff(Buff.RestrainedArmsBuff),
			buff(Buff.ChastityVaginaBuff),
			buff(Buff.ChastityPenisBuff),
			]
	return [
		buff(Buff.BlockedHandsBuff),
		buff(Buff.RestrainedArmsBuff),
		]

func getTags():
	return [ItemTag.BDSMRestraint]

func getPrice():
	return 30

func getSellPrice():
	return 25

func isRestraint():
	return true

func coversBodyparts():
	if(chastity):
		return {
			BodypartSlot.Body: true,
			BodypartSlot.Vagina: true,
			BodypartSlot.Penis: true,
			}
	return {
		BodypartSlot.Body: true,
		}

func generateRestraintData():
	restraintData = RestraintStraitjacket.new()
	restraintData.setLevel(5)

func getRiggedParts(_character):
	if(chastity):
		return {
			"straitjacket": "res://Inventory/RiggedModels/StraitJacket/StraitJacket.tscn",
		}
	return {
		"straitjacket": "res://Inventory/RiggedModels/StraitJacket/StraitJacketNoBelt.tscn",
	}

func getHidesParts(_character):
	if(chastity):
		return {
			BodypartSlot.Penis: true,
			BodypartSlot.Arms: true,
		}
	return {
		BodypartSlot.Arms: true,
	}

func getHidesAttachments(_character):
	return {
		"wrist.R": true,
		"wrist.L": true,
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/jacket.png"

func getPossibleActions():
	if(isWornByWearer()): # Can only toggle the belt off if we're not wearing the thing
		return []
	return [
		{
			"name": "Застегнуть ремень",
			"scene": "UseItemLikeInCombatScene",
			"description": "Выбрать, хотите ли вы дополнить смирительную рубашку поясом целомудрия",
		},
	]

func useInCombat(_attacker, _receiver):
	var text:String= ""
	chastity = !chastity
	if(chastity):
		text = "Теперь вы будете носить пояс целомудрия вместе с этой смирительной рубашкой!"
	else:
		text = "Вы не будете носить пояс целомудрия вместе с этой смирительной рубашкой."
	
	if(isWornByWearer()):
		updateWearerAppearance()
	
	return text
