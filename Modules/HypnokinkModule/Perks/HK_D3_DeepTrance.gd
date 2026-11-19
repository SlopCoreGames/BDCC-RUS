extends PerkBase

func _init():
	id = Perk.HypnosisDeepTranceDrawback
	skillGroup = Skill.Hypnosis

func getVisibleName():
	return "Глубокий транс"

func getVisibleDescription():
	return "Теперь вы погружаетесь в более глубокий гипнотический транс и выходите из него гораздо труднее."
	
func getMoreDescription():
	return 	"Теперь боль снижает ваш уровень гипноза лишь на 25% o часть полученной боли, вместо прежних 150%."+"\n\n"+ \
			"Additionaly, your hypnosis level can stack up to 125%." +"\n\n"+\
			"Keyword Fixation is now [b]always[/b] in effect."

func getSkillTier():
	return 2

func getCost():
	return 0
	
func unlockable() -> bool:
	return false

func toggleable() -> bool:
	var ch = npc if npc != null else GM.pc
	return !(ch.getSkillsHolder().hasPerk(self.id))

func hiddenWhenLocked() -> bool:
	return true;
	
func getPicture():
	return "res://Modules/HypnokinkModule/Icons/Perks/deep.png"

