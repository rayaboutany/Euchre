extends Label
signal trumpselected
var meow
var poo
# Called when the node enters the scene tree for the first time.
func _ready():
	global.trumpselected.connect(_on_texture_rect_2_trumpselected)
	global.delete.connect(farewell)
	global.hideno.connect(wehiding)
	global.hideyes.connect(wehiding)
	global.hidewords.connect(wehiding)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_2_trumpselected(suits):
	meow = suits
	set_text("Would you like " + str(meow) + " to be trump?")
	 # Replace with function body.
	
func wehiding():
	set_text(str(""))
	self.visible = false

func farewell():
	set_text(str(""))
