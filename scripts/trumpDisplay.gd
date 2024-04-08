extends TextureRect
var suit
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]
var textureURLs = [
"res://assets/cards/English_pattern_jack_of_hearts.svg.png",
"res://assets/cards/English_pattern_jack_of_diamonds.svg.png",
"res://assets/cards/English_pattern_jack_of_clubs.svg.png",
"res://assets/cards/English_pattern_jack_of_spades.svg.png"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("/root/table/ControlNode").connect("bid_made", self, "_on_bid_made")
	#line above is used to connect the signal to this function? ignore for mow
	global.bid_made.connect(_on_bid_made) #how i set up card selection
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#for this to work I need erin to have the following
# signal bid_made(suit) at the top
# it should be emitted when the button is pressed:
	#emit_signal("bid_made", chosen_suit)
#likely will be in global. use card selection as reference
func _on_bid_made(new_suit):
	suit = new_suit
	match (suit):
		"HEARTS":
			texture = load(textureURLs[0])
		"DIAMONDS":
			texture = load(textureURLs[1])
		"CLUBS":
			texture = load(textureURLs[2])
		"SPADES":
			texture = load(textureURLs[3])
