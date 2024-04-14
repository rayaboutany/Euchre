extends Control

#variables
var current_scene = null
#signal connections to functions in other scripts
signal musicPressed(toggled_on)
signal cardSelected(card)
signal cardPlayed(card)
signal tablePlayCard(card)
signal suitChosen(suit)
signal cardclicked(card)
signal trumpselected(suit)
signal nextPlayer()
signal setPlayer(player)
signal delete()
signal hideme()
signal bruh10()
signal hideno()
signal hideyes()
# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	pass # Replace with function body.

#scene initialization
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
