extends Node2D


#var load_table = preload("res://table.tscn").instantiate()
#var load_options = preload("res://options.tscn").instantiate()

func _add_a_scene_manually(scene):
	get_tree().root.add_child(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
