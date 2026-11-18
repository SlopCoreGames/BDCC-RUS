extends TopicBase

func _init():
	handles_ids = [
		InterestTopic.ThickBody,
		InterestTopic.AverageMassBody,
		InterestTopic.SlimBody,
		InterestTopic.ThickButt,
		InterestTopic.AverageButt,
		InterestTopic.SlimButt,
	]

func getTopicValue(_topicID, _pc):
	var thickness = _pc.getThickness()/100.0
	
	if(_topicID in [InterestTopic.ThickBody, InterestTopic.ThickButt]):
		return linearCloseness(thickness, 1.0, 0.3, 0.1)
	
	if(_topicID in [InterestTopic.AverageMassBody, InterestTopic.AverageButt]):
		return linearCloseness(thickness, 0.5, 0.3, 0.1)
	
	if(_topicID in [InterestTopic.SlimBody, InterestTopic.SlimButt]):
		return linearCloseness(thickness, 0.0, 0.3, 0.1)
	
	return 0

func getVisibleName(_topicID):
	if(_topicID == InterestTopic.ThickBody):
		return "пышное тело"
	if(_topicID == InterestTopic.AverageMassBody):
		return "тело среднего телосложения"
	if(_topicID == InterestTopic.SlimBody):
		return "стройное тело"
	if(_topicID == InterestTopic.ThickButt):
		return "пышная задница"
	if(_topicID == InterestTopic.AverageButt):
		return "задница среднего размера"
	if(_topicID == InterestTopic.SlimButt):
		return "узкая задница"
	
	return "error:"+str(_topicID)

func getChatName(_topicID) -> String:
	if(_topicID == InterestTopic.ThickBody):
		return "thick bodies"
	if(_topicID == InterestTopic.AverageMassBody):
		return "average bodies"
	if(_topicID == InterestTopic.SlimBody):
		return "thin bodies"
	if(_topicID == InterestTopic.ThickButt):
		return "thick butts"
	if(_topicID == InterestTopic.AverageButt):
		return "average butts"
	if(_topicID == InterestTopic.SlimButt):
		return "slim butts"
	
	return .getChatName(_topicID)

func getAddsToFocus(_topicID, _focus) -> float:
	if(_topicID in [InterestTopic.ThickBody, InterestTopic.AverageMassBody, InterestTopic.SlimBody]):
		if(_focus == LustFocus.Body):
			return 1.0
	if(_topicID in [InterestTopic.ThickButt, InterestTopic.AverageButt, InterestTopic.SlimButt]):
		if(_focus == LustFocus.Body):
			return 1.0
	return 0.0
