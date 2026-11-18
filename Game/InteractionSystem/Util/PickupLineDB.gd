extends Object
class_name PickupLineDB

const DB = [
	{
		text = "Ты случайно не фокусник? Потому что каждый раз, когда я смотрю на тебя, ___.",
		correct = [
			"everyone else disappears",
		],
		wrong = [
			"you disappear like my problems",
			"I want to pull a rabbit out of a hat",
			"I believe in fairy tales again",
		],
	},
	{
		text = "Ты сделана из меди и теллура? Потому что ___.",
		correct = [
			"you're Cu-Te",
		],
		wrong = [
			"I feel static around you",
			"your atomic number is my favorite",
			"I conduct electricity near you",
		],
	},
	{
		text = "Если бы ты была овощем, то была бы ___.",
		correct = [
			"a cute-cumber",
		],
		wrong = [
			"a kale chip",
			"a sweet potato",
			"too fresh for the fridge",
		],
	},
	{
		text = "У тебя есть карта? Потому что ___.",
		correct = [
			"I keep getting lost in your eyes",
		],
		wrong = [
			"I keep getting lost in your Slutagram",
			"I need to find a way into your pants",
			"I’m not great with directions",
		],
	},
	{
		text = "Твое имя — Wi-Fi? Потому что ___.",
		correct = [
			"I feel a connection",
		],
		wrong = [
			"you boost my signal",
			"I wanna reboot you",
			"I can’t stop buffering when I see you",
		],
	},
	{
		text = "Должно быть, я снежинка, потому что ___.",
		correct = [
			"I've fallen for you",
		],
		wrong = [
			"I’m unique, just like everyone else",
			"I melt under pressure",
			"I wanna melt on your tongue",
		],
	},
	{
		text = "Твоя рука кажется тяжелой. ___",
		correct = [
			"Can I hold it for you?",
		],
		wrong = [
			"Do you need help?",
			"Wanna smash?",
			"Maybe you should see a doctor.",
		],
	},
	{
		text = "Ты случайно не штраф за парковку? Потому что ___.",
		correct = [
			"you've got FINE written all over you",
		],
		wrong = [
			"I lost my spaceship because of you",
			"you're expired but still hot",
			"I’ll pay whatever it takes",
		],
	},
	{
		text = "Твой папа боксер? Потому что ___.",
		correct = [
			"you’re a knockout",
		],
		wrong = [
			"you fight like a champ",
			"you’ve got me on the ropes",
			"my heart can’t dodge you",
		],
	},
	{
		text = "Ты веришь в любовь с первого взгляда, или мне нужно ___",
		correct = [
			"walk by again?",
		],
		wrong = [
			"take off my sunglasses?",
			"offer you credits?",
			"just grab your neck?",
		],
	},
	{
		text = "Ты что, костер? Потому что ___.",
		correct = [
			"you’re hot and I want s’more",
		],
		wrong = [
			"you smell like the outdoors",
			"I burn every time I see you",
			"we should tell ghost stories",
		],
	},
	{
		text = "Будь я котом, я бы все 9 жизней провел(а) ___.",
		correct = [
			"loving you",
		],
		wrong = [
			"climbing trees",
			"avoiding dogs",
			"chasing red dots",
		],
	},
	{
		text = "Ты что, Смугл? Потому что ___.",
		correct = [
			"you’ve got everything I’m searching for",
		],
		wrong = [
			"you track me everywhere",
			"you autocomplete my sentences",
			"I’m feeling lucky",
		],
	},
	{
		text = "Если бы красота была временем, ты бы был(а) ___.",
		correct = [
			"eternity",
		],
		wrong = [
			"a fleeting moment",
			"yesterday and tomorrow",
			"a broken clock",
		],
	},
	{
		text = "Ты что, банковский кредит? Потому что ___.",
		correct = [
			"you have my interest",
		],
		wrong = [
			"I’m in deep debt for you",
			"your terms are irresistible",
			"you’ve got good credit",
		],
	},
	{
		text = "Ты что, пришелец? Потому что ___.",
		correct = [
			"you just abducted my heart",
		],
		wrong = [
			"your presence is out of this world",
			"you belong in Area 51",
			"your signals are unearthly",
		],
	},
	{
		text = "Ты что, солнце? Потому что ___.",
		correct = [
			"you brighten my day",
		],
		wrong = [
			"I can’t look directly at you",
			"you burn my retinas",
			"you rise too early",
		],
	},
	{
		text = "У тебя есть пластырь? Потому что ___.",
		correct = [
			"I just scraped my knee falling for you",
		],
		wrong = [
			"your beauty is a little dangerous",
			"I'm bleeding compliments",
			"my heart needs mending",
		],
	},
	{
		text = "Ты что, клавиатура? Потому что ___.",
		correct = [
			"you’re just my type",
		],
		wrong = [
			"I can’t press the right buttons",
			"you spell perfection",
			"you make me want to enter you",
		],
	},
	{
		text = "Будь ты треугольником, ты бы был(а) ___.",
		correct = [
			"acute one",
		],
		wrong = [
			"an isosceles lover",
			"the right one",
			"pointless without me",
		],
	},
	{
		text = "Ты звезда? Потому что ___.",
		correct = [
			"your beauty lights up the night",
		],
		wrong = [
			"you're part of my horoscope",
			"you burn from far away",
			"I'm lost in your constellation",
		],
	},
	{
		text = "Ты зарядное устройство? Потому что ___.",
		correct = [
			"without you, I’d die",
		],
		wrong = [
			"you light up my socket",
			"my battery’s 1%",
			"I want to plug in",
		],
	},
	{
		text = "Ты из антиматерии? Потому что ___.",
		correct = [
			"you annihilate my loneliness",
		],
		wrong = [
			"you repel everything else",
			"I can’t touch you without exploding",
			"you’re highly unstable",
		],
	},
	{
		text = "Ты из другой галактики? Потому что ___.",
		correct = [
			"my world isn’t the same since you arrived",
		],
		wrong = [
			"you travel light-years to avoid me",
			"you orbit someone else",
			"I can't pronounce your planet",
		],
	},
	{
		text = "Ты черная дыра? Потому что ___.",
		correct = [
			"I’m drawn to you irresistibly",
		],
		wrong = [
			"you crushed my confidence",
			"you warped my schedule",
			"you swallowed my snacks",
		],
	},
	{
		text = "Ты варп-двигатель? Потому что ___.",
		correct = [
			"you make my heart go faster than light",
		],
		wrong = [
			"you’re illegal in this quadrant",
			"I get motion sickness around you",
			"you keep breaking down",
		],
	},
	{
		text = "Если бы за каждую мысль о тебе у меня была звезда, то ___.",
		correct = [
			"I’d have a galaxy",
		],
		wrong = [
			"my ship would crash",
			"I'd 100% the game by now",
			"I'd form a constellation",
		],
	},
	{
		text = "Ты кусочек пазла? Потому что ___.",
		correct = [
			"you complete me",
		],
		wrong = [
			"I keep looking for you everywhere",
			"you keep hiding from me",
			"I wanna align my knob with your hole",
		],
	},
	{
		text = "Ты робот? Потому что ___.",
		correct = [
			"you compute perfectly with me",
		],
		wrong = [
			"you’re too cold to love",
			"I need to update your firmware",
			"you speak in binary",
		],
	},
	{
		text = "Ты ИИ? Потому что ___.",
		correct = [
			"you stole my h-art",
		],
		wrong = [
			"you’re becoming self-aware",
			"you hacked my server",
			"you keep doing dumb stuff",
		],
	},
	{
		text = "Ты что, пространство-время? Потому что ___.",
		correct = [
			"you bend my reality",
		],
		wrong = [
			"you give me headaches",
			"you’re too complicated",
			"I can’t calculate your curves",
		],
	},
	{
		text = "Ты что, стоп-слово? Потому что ___.",
		correct = [
			"you make me want to push all my limits",
		],
		wrong = [
			"you make everything stop",
			"you’re hard to remember",
			"I wanna use you when I'm bored",
		],
	},
	{
		text = "Ты что, верёвка? Потому что ___.",
		correct = [
			"I feel tied up with you",
		],
		wrong = [
			"I want you wrapped around me",
			"you keep dragging me along",
			"I like knots",
		],
	},
	{
		text = "Тебе нравится боль? Потому что ___.",
		correct = [
			"I can make you feel good",
		],
		wrong = [
			"I wanna bite your neck",
			"I can make your doctor rich",
			"I wanna hurt you",
		],
	},
	{
		text = "Ты что, данж? Потому что ___.",
		correct = [
			"I want to explore every inch",
		],
		wrong = [
			"I’m scared of the dark",
			"you have too many traps",
			"you need you in my basement",
		],
	},
	{
		text = "Ты что, капризная сучка? Потому что ___.",
		correct = [
			"I wanna tame you",
		],
		wrong = [
			"you cry when corrected",
			"you clearly need a nap and a snack",
			"you hate discipline",
		],
	},
	{
		text = "Ты что, паддл? Потому что ___.",
		correct = [
			"you've left your impact on me",
		],
		wrong = [
			"you’re hard to carry around",
			"you only work on boats",
			"you bring pain",
		],
	},
	{
		text = "Ты что, ошейник? Потому что ___.",
		correct = [
			"you fit me so perfectly",
		],
		wrong = [
			"I wanna lock you",
			"you go with any leash",
			"you’re a little tight, but I like the pressure",
		],
	},
	{
		text = "Ты что, доминант? Потому что ___.",
		correct = [
			"I'm into Big Doms Snuggling Me",
		],
		wrong = [
			"you like yelling too much",
			"you make too many spreadsheets",
			"I already wanna use a safe-word",
		],
	},
	{
		text = "Ты что, вибратор на максимуме? Потому что ___.",
		correct = [
			"I wanna come with you",
		],
		wrong = [
			"you make too much noise",
			"I can't handle you for very long",
			"I want you between my legs",
		],
	},
	{
		text = "Ты что, словарь? Потому что ___.",
		correct = [
			"you add meaning to my life",
		],
		wrong = [
			"you spell trouble",
			"you’re hard to understand",
			"you’re full of words",
		],
	},
	{
		text = "Ты что, фотоаппарат? Потому что ___.",
		correct = [
			"I wanna smile looking at you",
		],
		wrong = [
			"you remind me of the good times",
			"you develop my feelings",
			"you captured my soul",
		],
	},
	{
		text = "Ты что, лампочка? Потому что ___.",
		correct = [
			"you brighten up my world",
		],
		wrong = [
			"you need constant screwing",
			"I can't stare at you for too long",
			"you make weird noises when turned on",
		],
	},
	{
		text = "Ты что, художник? Потому что ___.",
		correct = [
			"you are drawing me in",
		],
		wrong = [
			"you brush me off",
			"I'm ready to get messy with you",
			"you’re clearly good with strokes",
		],
	},
	{
		text = "Ты что, шоколадка? Потому что ___.",
		correct = [
			"you make life sweeter",
		],
		wrong = [
			"you’re bittersweet",
			"you just gave me diabetes",
			"you’re best in small doses",
		],
	},
]
