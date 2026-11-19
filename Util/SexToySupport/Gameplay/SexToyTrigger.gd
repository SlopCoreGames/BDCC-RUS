extends Object
class_name SexToyTrigger

enum TYPE {
	Passive,
	Event,
}

enum {
	Lust,
	Pain,
	Stamina,
	Arousal,
	
	OnPainGain,
	OnLustGain,
	OnArousalGain,
	OnOrgasm,
	OnThroatPenetrated,
	OnHolePenetrated,
	OnPenetratingSomeone,
	OnHoleStretchedPainfully,
	OnWounded,
	OnLoseConsciousness,
	OnFightDefeat,
	OnFightWin,
	OnGivingBirth,
	OnBondageLocked,
	
	TOTAL_AMOUNT,
}

const NAMES:Array = [
	["Lust (passive)", "Чем выше уровень похоти вашего персонажа, тем сильнее будут эффекты. Пассивные триггеры срабатывают бесконечно.", "Чем ниже уровень похоти вашего персонажа, тем сильнее будут эффекты."],
	["Pain (passive)", "Чем выше уровень боли вашего персонажа, тем сильнее будут эффекты. Пассивные триггеры срабатывают бесконечно.", "Чем ниже уровень боли вашего персонажа, тем сильнее будут эффекты."],
	["Exhaustion (passive)", "Чем ниже уровень выносливости вашего персонажа, тем сильнее будут эффекты. Пассивные триггеры срабатывают бесконечно.", "Чем выше уровень выносливости вашего персонажа, тем сильнее будут эффекты."],
	["Arousal (passive)", "Чем выше уровень возбуждения вашего персонажа, тем сильнее будут эффекты. Пассивные триггеры срабатывают бесконечно.", "Чем ниже уровень возбуждения вашего персонажа, тем сильнее будут эффекты."],
	
	["Прирост боли", "Активировать эффекты, когда ваш персонаж получает боль."],
	["Прирост похоти", "Активирует эффекты, когда ваш персонаж испытывает похоть."],
	["Прирост возбуждения", "Активирует эффекты, когда ваш персонаж испытывает возбуждение."],
	["Orgasm", "Активирует эффекты при оргазме персонажа."],
	["Проникновение в горло", "Активирует эффекты при проникновении в горло персонажа. Срабатывает только в секс-движке."],
	["Проникновение в отверстие", "Активирует эффекты при проникновении во влагалище или анус (все, кроме горла). Срабатывает только в секс-движке."],
	["Проникающее отверстие", "Активирует эффекты, когда ваш персонаж проникает в чьи-то отверстия своим членом или страпоном. Работает только в секс-движке."],
	["Болезненное растяжение отверстия", "Активирует эффекты, когда одно из отверстий вашего персонажа болезненно растягивается."],
	["Wounded", "Активирует эффекты при получении статуса «Ранен»."],
	["Потеря сознания", "Активирует эффекты, когда вы полностью теряете сознание во время секса."],
	["Поражение в бою", "Активирует эффекты, когда ваш персонаж проигрывает бой."],
	["Победа в бою", "Активирует эффекты, когда ваш персонаж выигрывает бой."],
	["Роды / Откладывание яиц", "Активирует эффекты, когда ваш персонаж рожает или откладывает яйцо."],
	["Bondage'd", "Активирует эффекты, когда на персонаже надета заблокированная экипировка для бондажа."],
]

static func getName(_trigger:int) -> String:
	if(_trigger < 0 || _trigger >= NAMES.size()):
		return "UNKNOWN:"+str(_trigger)
	return NAMES[_trigger][0]

static func getDesc(_trigger:int) -> String:
	if(_trigger < 0 || _trigger >= NAMES.size()):
		return "UNKNOWN:"+str(_trigger)
	if(!isPassive(_trigger)):
		return NAMES[_trigger][1]
	return NAMES[_trigger][1]

static func isPassive(_trigger:int) -> bool:
	if(_trigger == Lust):
		return true
	if(_trigger == Pain):
		return true
	if(_trigger == Stamina):
		return true
	if(_trigger == Arousal):
		return true
	return false

static func supportsScaleWithValue(_trigger:int) -> bool:
	if(_trigger == OnPainGain):
		return true
	if(_trigger == OnLustGain):
		return true
	if(_trigger == OnArousalGain):
		return true
	
	return false

static func supportsScaleWithValueTexts(_trigger:int) -> Array:
	if(_trigger == OnPainGain):
		return ["Масштабируется от получения боли", "pain"]
	if(_trigger == OnLustGain):
		return ["Масштабируется от получения похоти", "lust"]
	if(_trigger == OnArousalGain):
		return ["Масштабируется от получения возбуждения", "arousal %"]
	
	return []
