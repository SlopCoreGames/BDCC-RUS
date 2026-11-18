extends TopicBase

func _init():
	handles_ids = [
		InterestTopic.FeminineBody,
		InterestTopic.AndroBody,
		InterestTopic.MasculineBody,
	]

func getTopicValue(_topicID, _pc):
	var thickness = _pc.getFemininity()/100.0
	
	if(_topicID == InterestTopic.FeminineBody):
		return linearCloseness(thickness, 1.0, 0.3, 0.05)
	
	if(_topicID == InterestTopic.AndroBody):
		return linearCloseness(thickness, 0.5, 0.3, 0.05)
	
	if(_topicID == InterestTopic.MasculineBody):
		return linearCloseness(thickness, 0.0, 0.3, 0.05)
	
	return 0

func getVisibleName(_topicID):
	if(_topicID == InterestTopic.FeminineBody):
		return "женственное тело"
	if(_topicID == InterestTopic.AndroBody):
		return "андрогинное тело"
	if(_topicID == InterestTopic.MasculineBody):
		return "мужественное тело"
	
	return "error:"+str(_topicID)

func getChatName(_topicID) -> String:
	if(_topicID == InterestTopic.FeminineBody):
		return "femininity"
	if(_topicID == InterestTopic.AndroBody):
		return "androgyny"
	if(_topicID == InterestTopic.MasculineBody):
		return "masculinity"
	
	return .getChatName(_topicID)

func getAddsToFocus(_topicID, _focus) -> float:
	if(_focus == LustFocus.Body):
		return 1.0
	return 0.0
