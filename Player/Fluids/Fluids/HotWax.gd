extends FluidBase

func _init():
	id = "HotWax"

func getVisibleName():
	return "Горячий воск"

func getStatusEffectColor():
	return Color.red

func getStatusEffectPicture():
	return "res://Images/StatusEffects/leak.png"

func getMessyDescription(_pc, _amount):
	return "Раскаленный воск обжигает твое тело."

func getMessyBuffs(_pc, _amount):
	if(_amount >= 500.0):
		return [
			buff(Buff.AmbientLustBuff, [60]),
			buff(Buff.AmbientPainBuff, [50]),
		]
	if(_amount >= 100.0):
		return [
			buff(Buff.AmbientLustBuff, [50]),
			buff(Buff.AmbientPainBuff, [30]),
		]
	return [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.AmbientPainBuff, [10]),
	]

func getCost(_amount) -> int:
	return int(_amount / 100.0) * 1

func onGettingHitWith(_pc, _amount):
	var text = ""
	text += _pc.getName()+" обжегся горячим воском!"
	
	return {
		text = text,
		pain = int(_amount / 100.0),
	}

func getCumOverlayColor():
	return Color.red

func canStoreInFluidTank() -> bool:
	return false
