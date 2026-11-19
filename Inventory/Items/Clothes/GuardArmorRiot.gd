extends "res://Inventory/Items/Clothes/GuardArmor.gd"

func _init():
	id = "GuardArmorRiot"

func getDescription():
	return "Стандартная броня для охранников. Этот вариант предназначен для подавления беспорядков и обеспечивает отличную защиту от физического урона."

func getBuffs():
	return [
		buff(Buff.PhysicalArmorBuff, [30]),
		buff(Buff.StatusEffectImmunityBuff, [StatusEffect.Collapsed, 50]),
		buff(Buff.StatusEffectImmunityBuff, [StatusEffect.Bleeding, 90]),
		]

func getTags():
	return [
		ItemTag.Illegal,
		]
