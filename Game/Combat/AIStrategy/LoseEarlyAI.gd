extends AIStrategyBase
class_name LoseEarlyAI

func getNextAttacksWeighted(_enemy):
	return getBestAttackIDsWeighted(_enemy)

func turnPassed(_enemy):
	var charObject: BaseCharacter = getCharacter()
	if(charObject.getPainLevel() >= 0.5):
		charObject.addLust(charObject.lustThreshold())
	
		return charObject.getName() + " внезапно громко стонет и падает на " + charObject.hisHer() +" колени!"
