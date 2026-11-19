extends "res://Inventory/Items/GuardHelmet.gd"

func _init():
	id = "GuardHelmetRiot"

func getDescription():
	return "Бронированный шлем. Это вариант для подавления беспорядков, обеспечивающий отличную защиту от физического урона."

func getBuffs():
	return [
		buff(Buff.PhysicalArmorBuff, [20]),
		buff(Buff.StatusEffectImmunityBuff, [StatusEffect.Stunned, 30]),
		]

func getTags():
	return [
		ItemTag.Illegal,
		]
