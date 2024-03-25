extends Sprite2D

var suit
var value
var id 
var isSelected = false
var player

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
	if isSelected:
		# Change the appearance of the card to indicate it's selected
		# This is a placeholder, replace it with your own logic
		self.modulate = Color(1, 1, 1, 0.5)
	else:
		self.modulate = Color(1, 1, 1, 1)
	
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
			global.emit_signal("cardPlayed", self)
			print("super bruh")


func _on_card_played():
	global.emit_signal("cardPlayed", self)
	pass # Replace with function body.
