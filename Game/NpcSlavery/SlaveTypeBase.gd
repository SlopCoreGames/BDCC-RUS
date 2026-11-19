extends Reference
class_name SlaveTypeBase

var id = "ERROR"

func getVisibleName():
	return "ИЗМЕНИ МЕНЯ"

func getVisibleDesc():
	return "ИЗМЕНИ МЕНЯ"

func getMinimalSlaveLevel():
	return 0

func canEnslaveAs():
	return getMinimalSlaveLevel() <= 0

func canTeach(_npc):
	return true

func getEnslaveText(_npc):
	return "[say=pc]МЯУ-МЯУ![/say]"

# F- F  F+ D- D  D+ C- C  B- B  A- A  S- S  S+ S++
# 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
func getTrainText(_npc, _skillLevel):
	return RNG.pick([
		"Ты тренируешь {npc.him}.",
		"Ты очень усердно тренируешь {npc.him}.",
	])

func getFailedTrainTextGreatSuccess(_npc):
	return "{npc.name} делает огромные успехи!"

func getFailedTrainTextSomeSuccess(_npc):
	return "{npc.name} делает определенные успехи."

func getFailedTrainTextResist(_npc):
	return "{npc.name} активно сопротивляется любым попыткам дрессировки. Это заслуживает наказания."

func getFailedTrainTextWeak(_npc):
	return "{npc.name} едва понимает твои инструкции, выглядя крайне слабой и изнуренной."

func getFailedTrainTextBad(_npc):
	return "{npc.name} из рук вон плохо справляется с твоим уроком."

func getUnlockHints(_npc):
	return [
#		{
#			unlocksAt = 1,
#			name = "Cuteness",
#			text = "You unlocked cuteness!!!",
#		},
#		{
#			unlocksAt = 13,
#			name = "Cuteness V2",
#			text = "You unlocked cuteness EVEN MORE!!!",
#		}
	]
