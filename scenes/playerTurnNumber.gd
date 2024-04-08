#extends "res://scenes/turnlabel.gd"
extends Label
signal cardPlayed
var turn = 0

#
# Called when the node enters the scene tree for the first time.
func _ready():
	#global.cardPlayed.connect(_onemitclick)
	set_text(str(turn))

# newTurn function, call in another script with get_node()/signals
func newTurn():
	turn += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttoncard_1_pressed():
	visible = true
	turn = 1
	set_text(str(turn))
	 # Replace with function body.

func _on_buttoncard_2_pressed():
	visible = true
	turn = 1
	set_text(str(turn))  # Replace with function body.

func _onemitclick(card):

	turn = 2
	set_text(str(turn))
	print("hi")
	

func _on_node_2d_work():
	var turn = 2
	set_text(str(turn))
	print("hi") # Replace with function body.
