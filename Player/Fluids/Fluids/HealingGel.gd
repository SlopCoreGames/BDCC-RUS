extends FluidBase

func _init():
	id = "HealingGel"

func getVisibleName():
	return "Лечебный гель"

func getMessyDescription(_pc, _amount):
	if(_amount >= 50.0):
		return "Ты весь покрыт целебным гелем!"
	
	return null

func onSwallow(_pc, _amount):
	var toHeal = Util.mini(int(_amount / 10), 1000)
	
	if(toHeal > 0):
		_pc.addPain(-toHeal)
		return "Употребление целебного геля принесло облегчение "+_pc.getName()+" of "+DamageType.getDamageColoredString(DamageType.Physical, toHeal)+"."
	
	return null

func getCost(_amount) -> int:
	return int(_amount / 100.0) * 1

func getCumOverlayColor():
	return Color.cyan

func canStoreInFluidTank() -> bool:
	return false
