extends RestraintData
class_name HK_HypnoRestraint

func _init():
	npcDodgeDifficultyMod = 10.0
	restraintType = "HypnoRestraint"

func resetOnNewDay():
	var item = getItem()
	if(item.isWornByWearer()):
		item.getWearer().getInventory().removeEquippedItem(item)

func canInspectWhileBlindfolded():
	return true

func canUnlockWithKey():
	return false
	
func alwaysSavedWhenStruggledOutOf():
	return false

func alwaysBreaksWhenStruggledOutOf():
	return true
	
func canStruggle():
	var item = getItem()
	if(!item.isWornByWearer()):
		return true
		
	var wearer = getItem().getWearer()
	if(HypnokinkUtil.isHypnotized(wearer)):
		return false
	else:
		return true
	
func shouldDoStruggleMinigame(_pc):
	return false
	
func doStruggle(_pc, _minigame:MinigameResult):
	var text = "ошибка?"
	var lust = 0
	var pain = 0
	var damage = 0
	var stamina = 0
	
	if(HypnokinkUtil.isHypnotized(_pc)):
		text = "{user.Name} никак не может снять эти наручники."
		damage = 0.0
	else:
		text = "{user.Name} осознаёт, что никаких наручников нет."
		damage = 1.0
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}
