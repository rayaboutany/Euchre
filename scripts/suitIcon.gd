extends Sprite2D

var woof = 0
var textureURLs = [
	"res://assets/cards/Hearts.png",
	"res://assets/cards/Clubs.png",
	"res://assets/cards/Diamonds.png",
	"res://assets/cards/Spades.png"
	]

func _unhandled_input(texture):
	if texture is InputEventMouseButton and texture.pressed and texture.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(texture.position)):
			global.emit_signal("suitChosen", self)
			print("arf arf bark")
			global.emit_signal("bruh10")

	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setTexture():
	texture = load(textureURLs[woof])

