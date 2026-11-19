extends Control


func updateBuffsText():
	var newtext = "Здесь отображаются ваши текущие баффы и дебаффы\n\n"
	if(GM.main == null || GM.pc == null):
		return
	
	var items = GM.pc.getInventory().getAllEquippedItems()
	for slot in items:
		var item = items[slot]
		var itemBuffs = item.getBuffs()
		if(itemBuffs != null && itemBuffs is Array && itemBuffs.size() > 0):
			newtext += item.getVisibleName()+" экипированный предмет:\n"
			
			for buff in itemBuffs:
				newtext += buff.getVisibleDescriptionColored()+"\n"
			newtext += "\n"
		
		
	var statusEffects = GM.pc.getStatusEffects()
	for statusEffectID in statusEffects:
		var statusEffect = statusEffects[statusEffectID]
		var statusEffectBuffs = statusEffect.getBuffs()
		if(statusEffectBuffs != null && statusEffectBuffs is Array && statusEffectBuffs.size() > 0):
			newtext += statusEffect.getEffectName()+" эффект состояния:\n"
			
			for buff in statusEffectBuffs:
				newtext += buff.getVisibleDescriptionColored()+"\n"
			newtext += "\n"

	var perks = GM.pc.getSkillsHolder().getPerks()
	for perkID in perks:
		var perk = perks[perkID]
		var perkBuffs = perk.getBuffs()
	
		if(perkBuffs != null && perkBuffs is Array && perkBuffs.size() > 0):
			newtext += perk.getVisibleName()+" perk:\n"
			
			for buff in perkBuffs:
				newtext += buff.getVisibleDescriptionColored()+"\n"
			newtext += "\n"
	
	$ScrollContainer/VBoxContainer/RichTextLabel.bbcode_text = newtext
	

func _on_BuffsScreen_visibility_changed():
	if(visible):
		updateBuffsText()
