extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "EatInCanteenScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "sit")
		
		saynn("Вы встаете в очередь и ждете. В столовой всегда полно голодных заключенных: кто-то сидит в одиночку, но есть и довольно большие компании.")
		
		saynn("Наконец вы подходите к стойке. За ней — кухня, где несколько поваров делают свою работу. Толстое окно отделяет заключенных от персонала.")

		saynn("Меню не особо обширное, точнее, меню как такового нет — заключенным просто подают какую-то серую кашицу на тарелке.")

		saynn("Вы берете предложенную тарелку и обычную ложку. Оглядевшись, вы замечаете свободный стол. Вы садитесь и начинаете раздумывать, достаточно ли вы голодны.")

		addButton("Скушать", "Вкусно", "doeat")
		addButton("Не есть", "Фу", "donteat")

			
	if(state == "doeat"):
		saynn("Вы не спеша поедаете эту массу; на вкус она практически никакая, но это всё же лучше, чем ничего.")
		
		addButton("Продолжить", "Встать и идти дальше", "endthescene")
		GM.ES.triggerRun(Trigger.EatingInCanteen)
		
	if(state == "donteat"):
		saynn("Ты оставляешь тарелку, так и не сделав ни единого укуса.")
		
		addButton("Продолжить", "Уйти", "endthescene")
		GM.ES.triggerRun(Trigger.EatingInCanteen)

func _react(_action: String, _args):
	if(_action == "doeat"):		
		GM.pc.afterEatingAtCanteen()
		processTime(60 * 5)
		
		setFlag("Canteen_PlayerAteToday", true)
		
		if(GM.ES.triggerReact(Trigger.EatingInCanteen)):
			endScene()
			return
		
		addMessage("Вы получили заряд энергии, и чувство голода притупилось.")


	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
