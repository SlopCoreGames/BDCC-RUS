extends EventBase

var sneakyPaths = {
	"eng_airventskip": {
		"text": "Вентиляционная шахта",
		"desc": "Пролезь через вентиляцию и посмотри, куда она тебя выведет",
		"newloc": "eng_firstjunction",
		"arive": "Ты пробираешься через вентиляционную шахту и оказываешься рядом со входом в инженерный блок"
	}
}

func _init():
	id = "PrisonPathShortcutsEvent"

func registerTriggers(es):
	for theloc in sneakyPaths:
		es.addTrigger(self, Trigger.EnteringRoom, theloc)

func run(_triggerID, _args):
	if(_args.size() > 0 && sneakyPaths.has(_args[0])):
		var thepath = sneakyPaths[_args[0]]
		addButton(thepath["text"], thepath["desc"], "goto", [_args[0]])

func getPriority():
	return 1

func onButton(_method, _args):
	if(_method == "goto"):
		var thepath = sneakyPaths[_args[0]]
		GM.pc.setLocation(thepath["newloc"])
		GM.main.addMessage(thepath["arive"])
		GM.main.reRun()
		
