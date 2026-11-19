extends PerkBase

func _init():
	id = Perk.BreedExtraTooltipInfo
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Твое озарение"

func getVisibleDescription():
	return "Ваше обоняние эволюционировало в совершенное шестое чувство, позволяющее улавливать тончайшие нюансы запахов, по которым можно определить текущую фазу менструального цикла самки. Теперь эта информация отображается в подсказках к частям тела. Также вы можете примерно определить, сколько детенышей носит в утробе та или иная особь (эффект суммируется с перком «Материнская интуиция»)."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/flowers.png"

func getBuffs():
	return [
	]
