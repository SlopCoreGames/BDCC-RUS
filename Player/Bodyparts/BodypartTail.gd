extends Bodypart
class_name BodypartTail

var tailScale: float = 1.0

func _init():
	limbSlot = LimbTypes.Tail

func getSlot():
	return BodypartSlot.Tail

func getLewdSizeAdjective():
	return RNG.pick(["long"])

func getLewdAdjective():
	return RNG.pick(["fluffy"])
	
func getLewdName():
	return RNG.pick(["tail"])

func applyTFData(_data):
	.applyTFData(_data)
	
	tailScale = loadTFVar(_data, "tailScale", tailScale)

func saveData():
	var data = .saveData()
	data["tailScale"] = tailScale
	
	return data

func loadData(_data):
	tailScale = SAVE.loadVar(_data, "tailScale", 1.0)
	
	.loadData(_data)
	

func getPickableAttributes():
	var result = .getPickableAttributes()
	result["tailscale"] = {
		"text": "Выберите масштаб хвоста",
		"textButton": "Размер хвоста",
		"buttonDesc": "Выберите масштаб хвоста",
		"options": [
			[0.3, "30%", "Выберите этот размер"],
			[0.4, "40%", "Выберите этот размер"],
			[0.5, "50%", "Выберите этот размер"],
			[0.8, "80%", "Выберите этот размер"],
			[0.9, "90%", "Выберите этот размер"],
			[1.0, "100%", "Выберите этот размер"],
			[1.1, "110%", "Выберите этот размер"],
			[1.2, "120%", "Выберите этот размер"],
			[1.3, "130%", "Выберите этот размер"],
			[1.5, "150%", "Выберите этот размер"],
			[1.8, "180%", "Выберите этот размер"],
			[2.0, "200%", "Выберите этот размер"],
			[2.5, "250%", "Выберите этот размер"],
			[3.0, "300%", "Выберите этот размер"],
		],
		"default": 1.0,
		"floatinput": true,
	}
	return result
	
func applyAttribute(_attrID: String, _attrValue):
	.applyAttribute(_attrID, _attrValue)
	if(_attrID == "tailscale"):
		tailScale = _attrValue

func getAttributesText():
	return [
		["Размер хвоста", str(Util.roundF(tailScale*100.0, 1))+"%"],
	]
	
func getCharCreatorData():
	return [
		["tailScale", tailScale],
	]

func getTailScale():
	return tailScale

func getTransformAwayMessage(_context:Dictionary) -> String:
	return "По спине {npc.yourHis} разливается покалывание. Это {npc.yourHis} хвост! Он начинает стремительно уменьшаться и втягиваться в {npc.yourHis} тело, а мышцы и кости постепенно растворяются... пока {npc.youHe} {npc.youHeVerb('lose')} его полностью."

func getTransformGrowMessage(_context:Dictionary) -> String:
	var isFlexible:bool = hasTrait(PartTrait.TailFlexible)
	return "{npc.YouHe} {npc.youHeVerb('feel')} странное тянущее ощущение у основания {npc.yourHis} позвоночника, и вдруг, новый"+(", flexible" if isFlexible else "")+" хвост начинает прорастать. Он разворачивается позади {npc.youHim} и уже начинает покачиваться при каждом движении."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "Хвост {npc.YourHis} начинает трансформироваться! Его структура и силуэт резко меняются, принимая новую форму. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
