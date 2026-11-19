extends Character

func _init():
	id = "novaArena"
	
	pickedSkin="NovaSkin"
	pickedSkinRColor=Color("ffc5c4c4")
	pickedSkinGColor=Color("ff414241")
	pickedSkinBColor=Color("ff747474")
	npcSkinData={
	"hair": {"r": Color("ffd9d9d9"),"g": Color("ff0f5fdb"),"b": Color("ff0f5fdb"),},
	"ears": {"r": Color("ff737373"),"g": Color("ffb5b5b5"),"b": Color("ffb8b8b8"),},
	"penis": {"g": Color("ffd12020"),"b": Color("ff8b0000"),},
	}
	
	npcArmor = {
		DamageType.Physical: 30,
	}
	npcLevel = 10
	npcBasePain = 200
	npcBaseLust = 150
	npcCharacterType = CharacterType.Guard

	
	
func getAmbientLust():
	return 40
	
func _getName():
	return "Nova"

func getGender():
	return Gender.Androgynous
	
func getPronounGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Серая хаски в высокотехнологичной броне охраны. Среднего роста, подтянутое телосложение"

func getSpecies():
	return ["canine"]

func _getAttacks():
	return ["stunbatonAttack", "stunbatonOverchargeAttack", "AIHumiliateMommy", "shoveattack", "trygetupattack"]

func getFightIntro(_battleName):
	if(_battleName == "arenafight"):
		var mes = "Увидеть среди бойцов арены кого-то из персонала — довольно странно; Нова выхватывает свой верный электрошокер и переводит взгляд на толпу."
		mes += "\n\n"
		mes += "[say=nova]Всё кончено! А теперь все живо на колени и ждите моего правосудия![/say]"
		mes += "\n\n"
		mes += "Толпа отвечает в основном тишиной. Но тут какой-то смельчак выкрикивает: «Да иди ты нахуй, сучка!»"
		mes += "\n\n"
		mes += "[say=nova]Надо было смотреть на ваши рожи. Хех, на самом деле волноваться стоит только тебе.[/say]"
		mes += "\n\n"
		mes += "Сексуальная воительница наводит на тебя оружие, а затем принимает боевую стойку. Она также щелкает каким-то переключателем на своей продвинутой силовой броне, отчего та начинает светиться, как новогодняя ёлка. Похоже, сейчас она защищена куда лучше, чем обычно."
		mes += "\n\n"
		mes += "[say=nova]Что-то я сегодня чертовски возбуждена, милашка. Поможешь собачке зарыть косточку?[/say]"
		return mes
	var mes = "Силовая броня Новы вспыхивает огнями, когда она сжимает верный электрошокер и устремляет свой взгляд на тебя."
	mes += "\n\n"
	return mes+formatSay("У тебя нет права молчать: всё, что я скажу, будет использовано против тебя. Иди сюда, сладенькая~")

func getChatColor():
	return '#90A9F4'

func createBodyparts():
	var mybreasts: BodypartBreasts = GlobalRegistry.createBodypart("humanbreasts")
	mybreasts.size = BreastsSize.G
	giveBodypartUnlessSame(mybreasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("shorthair"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	var penis:BodypartPenis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 21
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("huskytail"))

func getThickness():
	return 115


func getLootTable(_battleName):
	return GuardLoot.new()

func getParentCharacterID():
	return "nova"

func getDefaultEquipment():
	return ["GuardArmor"]

func getCombatStance() -> int:
	return CombatStance.STANCE_UNIQUE_STUNBATON
