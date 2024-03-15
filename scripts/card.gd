extends Sprite2D

signal cardSelected
signal cardPlayed

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
	isSelected = !isSelected
	setTexture()
	global.emit_signal("cardSelected", self)

func playCard():
	isSelected = false
	setTexture()
	global.emit_signal("cardPlayed", self)

func isInPlayArea(pos):
# Check if the given position is in the middle of the board
# This is a placeholder, replace it with your own logic
	return pos.x > 100 && pos.x < 200 && pos.y > 100 && pos.y < 200

func _input(event):
	if event is InputEventMouseButton:
		var mouse_pos = get_global_mouse_position()
		var card_size = texture.get_size()
		var card_rect = Rect2(global_position - card_size / 2, card_size)
		if card_rect.has_point(mouse_pos):
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				selectCard()
			elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT and isSelected and isInPlayArea(mouse_pos):
				playCard()
				
