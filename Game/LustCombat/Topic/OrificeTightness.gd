extends TopicBase

func _init():
	handles_ids = [
		InterestTopic.LooseAnus,
		InterestTopic.LoosePussy,
		InterestTopic.TightAnus,
		InterestTopic.TightPussy,
	]

func getTopicValue(_topicID, _pc):
	if(_topicID == InterestTopic.LooseAnus):
		if(!_pc.hasBodypart(BodypartSlot.Anus)):
			return 0.0
		var anus:BodypartAnus = _pc.getBodypart(BodypartSlot.Anus)
		var orifice:Orifice = anus.getOrifice()
		var looseness = orifice.getLooseness()
		
		return constantIfAbove(looseness, 15.0, 1.0, linearCloseness(looseness, 15.0, 14.5))
	if(_topicID == InterestTopic.LoosePussy):
		if(!_pc.hasBodypart(BodypartSlot.Vagina)):
			return 0.0
		var pussy:BodypartVagina = _pc.getBodypart(BodypartSlot.Vagina)
		var orifice:Orifice = pussy.getOrifice()
		var looseness = orifice.getLooseness()
		
		return constantIfAbove(looseness, 15.0, 1.0, linearCloseness(looseness, 15.0, 14.5))
	
	if(_topicID == InterestTopic.TightAnus):
		if(!_pc.hasBodypart(BodypartSlot.Anus)):
			return 0.0
		var anus:BodypartAnus = _pc.getBodypart(BodypartSlot.Anus)
		var orifice:Orifice = anus.getOrifice()
		var looseness = orifice.getLooseness()
		
		return constantIfBelow(looseness, 0.5, 0.0, linearCloseness(looseness, 0.0, 8.0))
	
	if(_topicID == InterestTopic.TightPussy):
		if(!_pc.hasBodypart(BodypartSlot.Vagina)):
			return 0.0
		var pussy:BodypartVagina = _pc.getBodypart(BodypartSlot.Vagina)
		var orifice:Orifice = pussy.getOrifice()
		var looseness = orifice.getLooseness()
		
		return constantIfBelow(looseness, 0.5, 0.0, linearCloseness(looseness, 0.0, 8.0))
	
	return 0.0

func getVisibleName(_topicID):
	if(_topicID == InterestTopic.LooseAnus):
		return "растянутый анус"
	if(_topicID == InterestTopic.LoosePussy):
		return "растянутая киска"
	if(_topicID == InterestTopic.TightAnus):
		return "узкий анус"
	if(_topicID == InterestTopic.TightPussy):
		return "узкая киска"
	
	return "error:"+str(_topicID)

func getChatName(_topicID) -> String:
	if(_topicID == InterestTopic.LooseAnus):
		return "растянутые анусы"
	if(_topicID == InterestTopic.LoosePussy):
		return "растянутые киски"
	if(_topicID == InterestTopic.TightAnus):
		return "узкие анусы"
	if(_topicID == InterestTopic.TightPussy):
		return "узкие киски"
	
	return .getChatName(_topicID)

func getAddsToFocus(_topicID, _focus) -> float:
	if(_topicID == InterestTopic.LooseAnus):
		if(_focus == LustFocus.Butt):
			return 1.0
	if(_topicID == InterestTopic.LoosePussy):
		if(_focus == LustFocus.Crotch):
			return 1.0
	if(_topicID == InterestTopic.TightAnus):
		if(_focus == LustFocus.Butt):
			return 1.0
	if(_topicID == InterestTopic.TightPussy):
		if(_focus == LustFocus.Crotch):
			return 1.0
	
	return 0.0
