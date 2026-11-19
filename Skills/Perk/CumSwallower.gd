extends PerkBase

func _init():
	id = Perk.CumSwallower
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Глотательница"

func getVisibleDescription():
	return "Ты так обожаешь сперму, что можешь вылизать себя дочиста прямо во время боя и проглотить всё до последней капли!"

func getMoreDescription():
	return "Вы открываете новую способность «Вылизать себя», которую можно использовать в бою. Проглатывание различных жидкостей дает разные эффекты. Например, слизывание спермы восстанавливает часть выносливости в зависимости от её количества."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/stomach.png"
