extends TextureRect
var suit
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]
var textureURLs = [
<<<<<<< HEAD
"res://assets/cards/English_pattern_9_of_hearts.svg.png",
"res://assets/cards/English_pattern_10_of_hearts.svg.png",
"res://assets/cards/English_pattern_jack_of_hearts.svg.png",
"res://assets/cards/English_pattern_queen_of_hearts.svg.png",
"res://assets/cards/English_pattern_king_of_hearts.svg.png",
"res://assets/cards/English_pattern_ace_of_hearts.svg.png",
"res://assets/cards/English_pattern_9_of_diamonds.svg.png",
"res://assets/cards/English_pattern_10_of_diamonds.svg.png",
"res://assets/cards/English_pattern_jack_of_diamonds.svg.png",
"res://assets/cards/English_pattern_queen_of_diamonds.svg.png",
"res://assets/cards/English_pattern_king_of_diamonds.svg.png",
"res://assets/cards/English_pattern_ace_of_diamonds.svg.png",
"res://assets/cards/English_pattern_9_of_clubs.svg.png",
"res://assets/cards/English_pattern_10_of_clubs.svg.png",
"res://assets/cards/English_pattern_jack_of_clubs.svg.png",
"res://assets/cards/English_pattern_queen_of_clubs.svg.png",
"res://assets/cards/English_pattern_king_of_clubs.svg.png",
"res://assets/cards/English_pattern_ace_of_clubs.svg.png",
"res://assets/cards/English_pattern_9_of_spades.svg.png",
"res://assets/cards/English_pattern_10_of_spades.svg.png",
"res://assets/cards/English_pattern_jack_of_spades.svg.png",
"res://assets/cards/English_pattern_queen_of_spades.svg.png",
"res://assets/cards/English_pattern_king_of_spades.svg.png",
"res://assets/cards/English_pattern_ace_of_spades.svg.png"
]
=======
"res://assets/cards/English_pattern_jack_of_hearts.svg.png",
"res://assets/cards/English_pattern_jack_of_diamonds.svg.png",
"res://assets/cards/English_pattern_jack_of_clubs.svg.png",
"res://assets/cards/English_pattern_jack_of_spades.svg.png"
]

>>>>>>> f59b974ceee74639d719f59bcf7b0aa255a37b88
# Called when the node enters the scene tree for the first time.
func _ready():
	suit = suits[int(RandomNumberGenerator.new().randf_range(0,3))]
	match (suit):
		"HEARTS":
			texture = load(textureURLs[0])
		"DIAMONDS":
			texture = load(textureURLs[1])
		"CLUBS":
			texture = load(textureURLs[2])
		"SPADES":
			texture = load(textureURLs[3])

<<<<<<< HEAD
=======

>>>>>>> f59b974ceee74639d719f59bcf7b0aa255a37b88
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
