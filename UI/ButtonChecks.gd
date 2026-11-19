extends Object
class_name ButtonChecks

enum {
	NotLate,
	NotGagged,
	NotOralBlocked,
	NotHandsBlocked,
	NotArmsRestrained,
	NotLegsRestrained,
	NotBlindfolded,
	NotCollapsed,
	SkillCheck,
	StatCheck,
	PerkCheck,
	HasCondoms,
	HasReachablePenis,
	HasReachableVagina,
	HasReachableAnus,
	HasReachableVaginaOrAnus,
	HasPenis,
	HasVagina,
	NotStunned,
	HasStamina,
	HasCredits,
	ContentEnabled,
	CanWearStrapon,
	HasStraponAndCanWear,
	HasStrapons,
	IsWearingChastityCage,
	HasChastityCageInInventory,
	HasItemID,
	HasReachablePenisOrVaginaOrHasStrapon,
	HasBreastPump,
	HasPenisPump,
	NotWearingItem,
	CanStartSex,
	HasReachableOrCagedPenisOrReachableVagina,
	HasItemWithTag,
	
	CHECKSAMMOUNT,
}

const ChecksTexts = [
	"NotLate",
	"NotGagged",
	"NotOralBlocked",
	"NotHandsBlocked",
	"NotArmsRestrained",
	"NotLegsRestrained",
	"NotBlindfolded",
	"NotCollapsed",
	"SkillCheck",
	"StatCheck",
	"PerkCheck",
	"HasCondoms",
	"HasReachablePenis",
	"HasReachableVagina",
	"HasReachableAnus",
	"HasReachableVaginaOrAnus",
	"HasPenis",
	"HasVagina",
	"NotStunned",
	"HasStamina",
	"HasCredits",
	"ContentEnabled",
	"CanWearStrapon",
	"HasStraponAndCanWear",
	"HasStrapons",
	"IsWearingChastityCage",
	"HasChastityCageInInventory",
	"HasItemID",
	"HasReachablePenisOrVaginaOrHasStrapon",
	"HasBreastPump",
	"HasPenisPump",
	"NotWearingItem",
	"CanStartSex",
	"HasReachableOrCagedPenisOrReachableVagina",
	"HasItemWithTag",
]

static func getAllWithNames():
	var result = []
	for _i in range(CHECKSAMMOUNT):
		result.append([_i, getName(_i)])
	return result

static func getName(thecheck:int):
	if(thecheck < 0 || thecheck >= ChecksTexts.size()):
		return "Ошибка?"
	return ChecksTexts[thecheck]

static func getEditVars(thecheck:int):
	if(thecheck == PerkCheck):
		return {
			"1": {
				name = "Название перка",
				type = "advancedSelector",
				value = Perk.StartInfertile,
				values = GlobalRegistry.getPerks().keys(),
			},
		}
	if(thecheck == StatCheck):
		return {
			"1": {
				name = "Название стата",
				type = "advancedSelector",
				value = Stat.Agility,
				values = GlobalRegistry.getStats().keys(),
			},
			"2": {
				name = "Мин. стат",
				type = "number",
				value = 5,
				int = true,
			},
		}
	if(thecheck == SkillCheck):
		return {
			"1": {
				name = "Название навыка",
				type = "advancedSelector",
				value = Skill.BDSM,
				values = GlobalRegistry.getSkills().keys(),
			},
			"2": {
				name = "Мин. уровень",
				type = "number",
				value = 5,
				int = true,
			},
		}
	if(thecheck == HasCredits):
		return {
			"1": {
				name = "Мин. кредитов",
				type = "number",
				value = 5,
				int = true,
			},
		}
	if(thecheck == ContentEnabled):
		return {
			"1": {
				name = "Контент",
				type = "advancedSelector",
				value = ContentType.Watersports,
				values = ContentType.getAll(),
			},
		}
	if(thecheck in [HasItemID, NotWearingItem]):
		return {
			"1": {
				name = "ID предмета",
				type = "advancedSelector",
				value = "appleitem",
				values = GlobalRegistry.getItemRefs().keys(),
			},
		}
	if(thecheck == HasItemWithTag):
		return {
			"1": {
				name = "Тег предмета",
				type = "advancedSelector",
				value = ItemTag.BDSMRestraint,
				values = ItemTag.getNamesAndValues(),
			},
		}
	
	return {}

static func getReasonText(reason):
	var args = reason
	if(reason is Array):
		reason = reason[0]
	
	if(reason == NotLate):
		return "Уже слишком поздно это делать"
	if(reason in [NotGagged, NotOralBlocked]):
		return "Так нельзя, когда рот забит кляпом"
	if(reason == NotHandsBlocked):
		return "Так нельзя, когда руки заблокированы"
	if(reason == NotArmsRestrained):
		return "Так нельзя, когда руки связаны"
	if(reason == NotLegsRestrained):
		return "Так нельзя, когда ноги связаны"
	if(reason == NotBlindfolded):
		return "Так нельзя, когда на глазах повязка"
	if(reason == HasCondoms):
		return "У тебя нет презервативов"
	if(reason == HasReachablePenis):
		return "Нужно, чтобы до члена можно было дотянуться"
	if(reason == HasReachableVagina):
		return "Нужно, чтобы до киски можно было дотянуться"
	if(reason == HasReachableAnus):
		return "Нужно, чтобы до ануса можно было дотянуться"
	if(reason == HasReachableVaginaOrAnus):
		return "Нужно, чтобы киска или анус были доступны"
	if(reason == HasPenis):
		return "Тебе нужен член"
	if(reason == HasVagina):
		return "Тебе нужна киска"
	if(reason == SkillCheck):
		return ""
	if(reason == StatCheck):
		return ""
	if(reason == PerkCheck):
		return ""
	if(reason == NotStunned):
		return "Нельзя делать это в состоянии оглушения"
	if(reason == HasStamina):
		return "У тебя не хватает выносливости для этого"
	if(reason == HasCredits):
		return "Нужно больше кредитов!"
	if(reason == ContentEnabled):
		return ""
	if(reason == CanWearStrapon):
		return "Ты не можешь носить страпон"
	if(reason == HasStraponAndCanWear):
		return "У тебя нет страпонов или ты не можешь его надеть"
	if(reason == HasStrapons):
		return "Для этого в инвентаре должен быть страпон"
	if(reason == IsWearingChastityCage):
		return "На тебе нет клетки целомудрия"
	if(reason == NotCollapsed):
		return "Нельзя делать это в состоянии обморока"
	if(reason == HasChastityCageInInventory):
		return "В вашем инвентаре нет девственных клеток"
	if(reason == HasItemID):
		return "У вас нет необходимого предмета"
	if(reason == HasReachablePenisOrVaginaOrHasStrapon):
		return "В инвентаре должен быть доступный пенис, вагина или страпон"
	if(reason == HasBreastPump):
		return "В вашем инвентаре нет молокоотсосов"
	if(reason == HasPenisPump):
		return "В вашем инвентаре нет пенисных помп"
	if(reason == NotWearingItem):
		return "Нужно избавиться от "+GlobalRegistry.getItemRef(args[1]).getVisibleName()
	if(reason == CanStartSex):
		return "Вы не можете начать секс, пока на вас надеты смирительные устройства"
	if(reason == HasReachableOrCagedPenisOrReachableVagina):
		return "У вас должен быть пенис или доступная вагина"
	if(reason == HasItemWithTag):
		return "У вас нет предмета нужного типа"
	return "Ошибка?"

static func check(checks: Array):
	for reason in checks:
		var args = reason
		if(reason is Array):
			reason = reason[0]
		
		if(reason == NotLate):
			if(GM.main.isVeryLate()):
				return reason
		if(reason == NotGagged):
			if(GM.pc.isGagged()):
				return reason
		if(reason == NotOralBlocked):
			if(GM.pc.isOralBlocked()):
				return reason
		if(reason == NotArmsRestrained):
			if(GM.pc.hasBoundArms()):
				return reason
		if(reason == NotHandsBlocked):
			if(GM.pc.hasBlockedHands()):
				return reason
		if(reason == NotLegsRestrained):
			if(GM.pc.hasBoundLegs()):
				return reason
		if(reason == NotBlindfolded):
			if(GM.pc.isBlindfolded()):
				return reason
		if(reason == SkillCheck):
			var skill: SkillBase = GM.pc.getSkillsHolder().getSkill(args[1])
			if(skill == null || skill.getLevel() < args[2]):
				return args
		if(reason == StatCheck):
			if(GM.pc.getStat(args[1]) < args[2]):
				return args
		if(reason == PerkCheck):
			if(!GM.pc.hasPerk(args[1])):
				return args
		if(reason == HasCondoms):
			if(!GM.pc.hasCondoms()):
				return reason
		if(reason == HasReachablePenis):
			if(!GM.pc.hasReachablePenis()):
				return reason
		if(reason == HasReachableVagina):
			if(!GM.pc.hasReachableVagina()):
				return reason
		if(reason == HasReachableAnus):
			if(!GM.pc.hasReachableAnus()):
				return reason
		if(reason == HasReachableVaginaOrAnus):
			if(!GM.pc.hasReachableAnus() && !GM.pc.hasReachableVagina()):
				return reason
		if(reason == HasPenis):
			if(!GM.pc.hasPenis()):
				return reason
		if(reason == HasVagina):
			if(!GM.pc.hasVagina()):
				return reason
		if(reason == NotStunned):
			if(GM.pc.hasEffect(StatusEffect.Stunned)):
				return reason
		if(reason == HasStamina):
			if(GM.pc.getStamina() <= 0):
				return reason
		if(reason == HasCredits):
			if(GM.pc.getCredits() < args[1]):
				return reason
		if(reason == ContentEnabled):
			if(!OPTIONS.isContentEnabled(args[1])):
				return args
		if(reason == CanWearStrapon):
			if(!GM.pc.canWearStrapon()):
				return args
		if(reason == HasStraponAndCanWear):
			if(!GM.pc.canWearStrapon()):
				return args
			if(!GM.pc.hasStrapons()):
				return args
		if(reason == HasStrapons):
			if(!GM.pc.hasStrapons()):
				return args
		if(reason == IsWearingChastityCage):
			if(!GM.pc.isWearingChastityCage()):
				return args
		if(reason == NotCollapsed):
			if(GM.pc.hasEffect(StatusEffect.Collapsed)):
				return args
		if(reason == HasChastityCageInInventory):
			if(!GM.pc.hasChastityCages()):
				return args
		if(reason == HasItemID):
			if(!GM.pc.getInventory().hasItemID(args[1])):
				return args
		if(reason == HasReachablePenisOrVaginaOrHasStrapon):
			if(!GM.pc.hasReachablePenis() && !GM.pc.hasReachableVagina() && !GM.pc.hasStrapons()):
				return args
		if(reason == HasBreastPump):
			if(GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump).size() <= 0):
				return args
		if(reason == HasPenisPump):
			if(GM.pc.getInventory().getItemsWithTag(ItemTag.PenisPump).size() <= 0):
				return args
		if(reason == NotWearingItem):
			if(GM.pc.getInventory().hasItemIDEquipped(args[1])):
				return args
		if(reason == CanStartSex):
			if(GM.pc.hasBoundArms()):
				return NotArmsRestrained
			if(GM.pc.hasBlockedHands()):
				return NotHandsBlocked
			if(GM.pc.hasBoundLegs()):
				return NotLegsRestrained
			if(GM.pc.isOralBlocked()):
				return NotOralBlocked
		if(reason == HasReachableOrCagedPenisOrReachableVagina):
			if(!GM.pc.hasReachablePenis() && !GM.pc.isWearingChastityCage() && !GM.pc.hasReachableVagina()):
				return reason
		if(reason == HasItemWithTag):
			if(GM.pc.getInventory().getItemsWithTag(args[1]).size() <= 0):
				return args
			
	return null

static func getPrefix(checks: Array):
	var result = ""
	for reason in checks:
		var args = reason
		if(reason is Array):
			reason = reason[0]
		
		if(reason == SkillCheck):
			var skill: SkillBase = GlobalRegistry.createSkill(args[1])
			result += "["+skill.getVisibleName()+" "+str(args[2])+"+]"
			
		if(reason == StatCheck):
			var stat: StatBase = GlobalRegistry.getStat(args[1])
			result += "["+stat.getVisibleName()+" "+str(args[2])+"+]"
			
		if(reason == PerkCheck):
			var perk: PerkBase = GlobalRegistry.createPerk(args[1])
			result += "[перк: "+perk.getVisibleName()+"]"
			
		if(reason == ContentEnabled):
			var contentName = ContentType.getVisibleName(args[1])
			result += "[контент: "+str(contentName)+"]"
	
	if(result != ""):
		result += " "
	return result
