extends "res://scripts/table.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Function to handle card press
func on_Card_pressed():
	emit_signal("userclick")

