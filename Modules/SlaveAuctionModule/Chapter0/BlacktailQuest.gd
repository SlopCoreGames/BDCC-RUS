extends QuestBase

func _init():
	id = "BlacktailQuest"

func getVisibleName():
	return "Рынок Блэктейл"

func getProgress():
	var result = []
	
	result.append("Тебя чуть было не продала Агент Синдиката. Она предложила сделку: приведи ей рабыню на продажу, и она заплатит тебе.\n\nВыбрать, кого именно продать, можно в меню «Рабыни». Помни, что проданная рабыня исчезнет навсегда.")

	if(getFlag("SlaveAuctionModule.s2hap")):
		result.append("Продавай больше рабынь и помогай Мирри повышать её ранг работорговца, чтобы продвинуться по сюжету. Используй меню «Рабыни», чтобы телепортироваться на рынок Блэктейла.")

	if(getFlag("SlaveAuctionModule.repLevel", 0) >= 5):
		result.append("Мирри достигла 5-го ранга работорговца. Учти, что следующий ранг — последний, и после этого некоторые действия будет уже не отменить.")

	if(getFlag("SlaveAuctionModule.repLevel", 0) >= 6):
		var r6out = getFlag("SlaveAuctionModule.r6outcome", "")
		if(r6out == "mirrislave"):
			result.append("Вы помогли Люксу продать Мирри в рабство. С глаз долой — из сердца вон! Вы всё ещё можете участвовать в черном рынке, но теперь уже в роли ведущего!")
		if(r6out == "mirrigone"):
			result.append("Вы избавились от Мирри окончательно. Эта сучка получила по заслугам. Вы всё ещё можете участвовать в черном рынке, но теперь уже в роли ведущего!")
		if(r6out == "luxedead"):
			result.append("Люкс мертв. Теперь Мирри — глава семьи Блэктейл! Если хотите, вы всё ещё можете продавать рабов на рынке Блэктейл.")
		if(r6out == "middleground"):
			result.append("Вам удалось помочь Мирри и Люксу найти компромисс! Мирри больше не часть семьи Блэктейл, но Люкс больше не будет терроризировать её. Если хотите, вы всё ещё можете продавать рабов на рынке Блэктейл.")

	return result

func isVisible():
	return getFlag("SlaveAuctionModule.s1hap")

func isCompleted():
	return getFlag("SlaveAuctionModule.repLevel", 0) >= 6

func isMainQuest():
	return false
