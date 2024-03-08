extends Sprite2D
var suit
var value
var id 

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

func setTexture():
	texture = load(textureURLs[id])
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func selectCard():
	# card playing logic here
		emit_signal("cardSelected", self)

func playCard():
	# card playing logic here
		emit_signal("cardPlayed", self)
		
func ClickCard():
	emit_signal("cardclicked", self)
	print("card clicked")

func _unhandled_input(texture):
	if texture is InputEventMouseButton and texture.pressed and texture.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(texture.position)):
			emit_signal("personclick", self)
			print("super bruh")
