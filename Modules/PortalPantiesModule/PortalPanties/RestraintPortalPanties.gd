extends RestraintData

func canStruggle():
	return false

func canUnlockWithKey():
	return false

func alwaysSavedWhenStruggledOutOf():
	return true

func getVisibleLevel(_isBlind = false):
	return "999, impossible to remove"

func saveData():
	var data = {}

	return data
	
func loadData(_data):
	pass

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(RNG.chance(10) && (GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsGotStolen") || !_pc.isPlayer())):
		var possible = ["anus"]
		if(_pc.hasVagina()):
			possible.append("vag")
		if(_pc.hasPenis()):
			possible.append("penis")
		
		var randPart = RNG.pick(possible)
		if(randPart == "vag"):
			var texts = [
				"Кто-то дразнит {user.Your} {user.pussyStretch} киску через портальные трусики!",
				"Кто-то трется своим членом о щелочку {user.your} через портальные трусики!",
				"Чьи-то пальцы раздвигают складки киски {user.your} и дразнят тебя через портальные трусики!",
				"Чьи-то пальцы скользят туда-сюда в кошачьей щелке {user.your} через портальные трусики!",
				"Ты чувствуешь, как член находит киску {user.your} и входит в нее через портальные трусики!",
			]
		
			return {"text": RNG.pick(texts), "lust": scaleDamage(5)}
		if(randPart == "anus"):
			var texts = [
				"{user.Your} {user.analStretch} анус дразнят через портальные трусики!",
				"Кто-то трется своим членом об анус {user.your} через портальные трусики!",
				"Чьи-то пальцы тычут в анус {user.your} и дразнят тебя через портальные трусики!",
				"Чьи-то пальцы скользят туда-сюда в анусе {user.your} {user.analStretch} через портальные трусики!",
				"Ты чувствуешь, как член находит анус {user.your} и входит в него через портальные трусики!",
			]
		
			return {"text": RNG.pick(texts), "lust": scaleDamage(5)}
		if(randPart == "penis"):
			var texts = [
				"{user.Your} {user.cock} дразнят через портальные трусики!",
				"Чьи-то губы смыкаются на кончике члена {user.your} через портальные трусики!",
				"Чей-то язык лижет {user.your} {user.cock} через портальные трусики!",
				"Чьи-то пальцы обхватывают {user.your} {user.cock} и ласкают его через портальные трусики!",
				"Кто-то терется киской о член {user.your} через портальные трусики!",
			]
		
			return {"text": RNG.pick(texts), "lust": scaleDamage(5)}
