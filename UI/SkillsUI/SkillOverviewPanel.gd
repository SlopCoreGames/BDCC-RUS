extends PanelContainer

var skillID = null

onready var nameLabel = $VBoxContainer/NameLabel
onready var levelBar = $VBoxContainer/HBoxContainer/LevelBar
onready var descLabel = $VBoxContainer/DescLabel
onready var learnedPerksLabel = $VBoxContainer/LearnedPerksLabel
onready var freePerksLabel = $VBoxContainer/FreePerksLabel
onready var perksButton = $VBoxContainer/HBoxContainer/PerksButton

signal perksButton(skillID)

func setSkillID(newskillid):
	skillID = newskillid
	
	updateInfo()

func updateInfo():
	if(skillID == null):
		return
	var skill: SkillBase = GM.pc.getSkillsHolder().getSkill(skillID)
	if(skill == null):
		return
	
	#nameLabel.text = skill.getVisibleName()
	#descLabel.text = skill.getVisibleDescription()
	var totalPerkCount = GlobalRegistry.getPerksIDsBySkill(skillID).size()
	var learnedPerkCount = GM.pc.getSkillsHolder().getLearnedPerkAmount(skillID)
	
	#levelBar.setTextLeft("Level "+str(skill.getLevel()))
	#levelBar.setText(str(skill.getExperience())+" / "+str(skill.getRequiredExperienceNextLevel())+" exp")
	
	if(skill.scripted()):
		levelBar.setTextLeft(skill.getVisibleName())
		levelBar.setText("")
		levelBar.setProgressBarValue(0)
	else:
		levelBar.setTextLeft(skill.getVisibleName() +" (ур. "+str(skill.getLevel())+")")
		levelBar.setText(""+str(skill.getExperience())+" / "+str(skill.getRequiredExperienceNextLevel())+" опыта, очки: "+str(GM.pc.getSkillsHolder().getFreePerkPoints(skillID)))
		levelBar.setProgressBarValue(skill.getLevelProgress())
	perksButton.text = "Перки ("+str(learnedPerkCount)+"/"+str(totalPerkCount)+")"

func _on_PerksButton_pressed():
	emit_signal("perksButton", skillID)
