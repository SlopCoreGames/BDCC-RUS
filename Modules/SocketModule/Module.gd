extends Module

func getFlags():
	return {
		"socketIntroduced": flag(FlagType.Bool),
		"askedWhyWorkHere": flag(FlagType.Bool),
		"touchedPussy": flag(FlagType.Bool),
		"punishLineShouldSay": flag(FlagType.Bool),
		
		"removedWombImplant": flag(FlagType.Bool),
		"socketWillPunish": flag(FlagType.Bool),
		"punishReason": flag(FlagType.Text), # stuckroughfuck stuckroughassfuck spikeddrink hadcumafterbrainwash
		
		"ch1HelpedTimes": flag(FlagType.Number),
		
		"h3BeatRisha": flag(FlagType.Bool),
		
		"hasPortalPussy": flag(FlagType.Bool),
		
		"h1completed": flag(FlagType.Bool),
		"h2completed": flag(FlagType.Bool),
		"h3completed": flag(FlagType.Bool),
		"h4completed": flag(FlagType.Bool),
		"h5completed": flag(FlagType.Bool),
		
		"fastTravelMedical": flag(FlagType.Bool),
		"fastTravelGym": flag(FlagType.Bool),
		"fastTravelUnder": flag(FlagType.Bool),
		"fastTravelMedicalCorridor": flag(FlagType.Bool),
		"fastTravelMineshaft": flag(FlagType.Bool),
		"fastTravelWorkshop": flag(FlagType.Bool),
		"fastTravelCanteen": flag(FlagType.Bool),
		"fastTravelBathroom1": flag(FlagType.Bool),
		"fastTravelBathroom2": flag(FlagType.Bool),
		"fastTravelEngBreakroom": flag(FlagType.Bool),
	}

func _init():
	id = "SocketModule"
	author = "Rahi"
	
	scenes = [
		"res://Modules/SocketModule/SocketIntroScene.gd",
		"res://Modules/SocketModule/SocketTalkScene.gd",
		"res://Modules/SocketModule/SocketPunishmentScene.gd",
		"res://Modules/SocketModule/SocketBuyFastTravelScene.gd",
		"res://Modules/SocketModule/SocketFastTravelScene.gd",
		
		"res://Modules/SocketModule/HelpScenes/SocketHelp1Mineshaft.gd",
		"res://Modules/SocketModule/HelpScenes/SocketHelp2Scene.gd",
		"res://Modules/SocketModule/HelpScenes/SocketHelp3Scene.gd",
		"res://Modules/SocketModule/HelpScenes/SocketHelp4Scene.gd",
		"res://Modules/SocketModule/HelpScenes/SocketHelp5Scene.gd",
		]
	characters = [
		"res://Modules/SocketModule/SocketCharacter.gd",
	]
	items = []
	events = [
		"res://Modules/SocketModule/SocketIntroEvent.gd",
		"res://Modules/SocketModule/SocketPunishmentEvent.gd",
		"res://Modules/SocketModule/SocketFastTravelEvent.gd",
	]

func resetFlagsOnNewDay():
	pass

func getFastTravelData():
	var result = {}

	result["fastTravelCanteen"] = {
		cost = 10,
		name = "Столовая",
		location = "hall_canteen",
		buydesc = "Вентиляция, ведущая в столовую на главном этаже",
	}
	result["fastTravelGym"] = {
		cost = 10,
		name = "Тренажерный зал",
		location = "gym_nearbathroom",
		buydesc = "Вентиляция, ведущая прямиком в спортзал со всем тренировочным оборудованием",
	}
	result["fastTravelBathroom1"] = {
		cost = 10,
		name = "Главная уборная",
		location = "main_bathroom1",
		buydesc = "Вентиляция, ведущая в туалет, соединенный с главным залом",
	}
	result["fastTravelBathroom2"] = {
		cost = 10,
		name = "Уборная в спортзале",
		location = "main_bathroom2",
		buydesc = "Вентиляция, ведущая в туалет рядом со спортзалом",
	}
	result["fastTravelMedical"] = {
		cost = 15,
		name = "Вестибюль медпункта",
		location = "med_lobby_start",
		buydesc = "Вентиляция, ведущая прямиком в вестибюль медицинского крыла",
	}
	result["fastTravelMineshaft"] = {
		cost = 15,
		name = "Шахты",
		location = "mining_shafts_entering",
		buydesc = "Вентиляция, ведущая к шахтам",
	}
	result["fastTravelWorkshop"] = {
		cost = 15,
		name = "Мастерская",
		location = "eng_workshop",
		buydesc = "Вентиляция, ведущая в инженерную мастерскую",
	}
	if(getFlag("SocketModule.h4completed")):
		result["fastTravelMedicalCorridor"] = {
			cost = 25,
			name = "Коридор медпункта",
			location = "med_nearmilking",
			buydesc = "Вентиляция, которая позволяет миновать двери только для персонала в медицинском крыле и ведет в один из его коридоров",
		}
		# If can enter it normally
		if(GM.QS.isCompleted("Ch2AlexQuest") || getFlag("AlexRynardModule.ch2CanEnterEngineering")):
			result["fastTravelEngBreakroom"] = {
				cost = 25,
				name = "Комната отдыха инженеров",
				location = "eng_breakroom",
				buydesc = "Вентиляция, которая позволяет миновать двери только для персонала в инженерном крыле и ведет в комнату отдыха",
			}
	if(getFlag("SocketModule.h4completed") && getFlag("FightClubModule.BulldogBypassed")):
		result["fastTravelUnder"] = {
			cost = 30,
			name = "Подземелье",
			location = "fight_neararena",
			buydesc = "Вентиляция, ведущая в заброшенную техническую зону. Сокет не понимает, зачем вам может быть интересна именно эта дыра, но она готова рискнуть ради лишней кредитки.",
		}
	
	return result

func hasAnyVentsUnlocked():
	var ventData = getFastTravelData()
	
	for ventID in ventData:
		if(getFlag("SocketModule."+ventID, false)):
			return true
	return false
