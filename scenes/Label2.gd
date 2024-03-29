extends Label
var meow
var poo
# Called when the node enters the scene tree for the first time.
func _ready():
	global.trumpselected.connect(_on_texture_rect_2_trumpselected)
	global.delete.connect(farewell)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_2_trumpselected(suits):
	meow = suits
	set_text(str(meow))
	 # Replace with function body.

func farewell():
	set_text(str(""))
