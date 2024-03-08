extends Label
var tricks = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(tricks))

# newTurn function, call in another script with get_node()/signals
func newTurn():
	tricks += 1
	set_text(str(tricks))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
