extends ItemBase

func _init():
	id = "RingOfDevotion"

func getVisibleName():
	return "Кольцо преданности"
	
func getDescription():
	return "Простое металлическое кольцо. На нем выгравирована короткая надпись: «Ключ к моему сердцу. Навеки чиста».\n\n\"[i]Прими этот дар как скромный знак моей признательности. Надеюсь, он станет приятным напоминанием о твоем выборе <3. [/i]\"\n"

func getClothingSlot():
	return InventorySlot.Ring

func getBuffs():
	return [
		buff(Buff.SkillExperienceBuff, [Skill.BDSM, 50])
		]

func getPrice():
	return 20

func canSell():
	return true
