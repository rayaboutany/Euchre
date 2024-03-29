extends TextureRect
signal trumpselected
var suit
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]
var textureURLs = [
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
# Called when the node enters the scene tree for the first time.
func _ready():
	suit = suits[int(RandomNumberGenerator.new().randf_range(0,3))]
	match (suit):
		"HEARTS":
			texture = load(textureURLs[0])
			texture = load(textureURLs[1])
			texture = load(textureURLs[2])
			texture = load(textureURLs[3])
			texture = load(textureURLs[4])
			texture = load(textureURLs[5])
			global.emit_signal("trumpselected", suit)
			print(suit + " is trump")
		"DIAMONDS":
			texture = load(textureURLs[6])
			texture = load(textureURLs[7])
			texture = load(textureURLs[8])
			texture = load(textureURLs[9])
			texture = load(textureURLs[10])
			texture = load(textureURLs[11])
			global.emit_signal("trumpselected", suit)
			print(suit + " is trump")
		"CLUBS":
			texture = load(textureURLs[12])
			texture = load(textureURLs[13])
			texture = load(textureURLs[14])
			texture = load(textureURLs[15])
			texture = load(textureURLs[16])
			texture = load(textureURLs[17])
			global.emit_signal("trumpselected", suit)
			
			print(suit + " is trump")
		"SPADES":
			texture = load(textureURLs[18])
			texture = load(textureURLs[19])
			texture = load(textureURLs[20])
			texture = load(textureURLs[21])
			texture = load(textureURLs[22])
			texture = load(textureURLs[23])
			global.emit_signal("trumpselected", suit)

			print(suit + " is trump")
			#will change to forward loop, brain 404 not found, works tho!
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
