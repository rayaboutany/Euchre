extends Control

var menuVisible = false
var game_paused = false

func _ready():
	# Set z-index
	$NinePatchRect.z_index = 1000  # Adjust this value as needed to ensure it's above other objects
	# Hide the menu initially
	$NinePatchRect.visible = menuVisible
	# Set the pause mode of the UI to process

func _process(delta):
	# Check if the "gameMenu" action has been triggered
	if Input.is_action_just_pressed("gameMenu"):
		# Toggle the visibility of the menu
		menuVisible = not menuVisible
		$NinePatchRect.visible = menuVisible
	
# Function to pause the game
func pause_game():
	get_tree().paused = true
	# Additional pause logic if needed

# Function to resume the game
func resume_game():
	get_tree().paused = false
	# Additional resume logic if needed
	
	
func _on_back_to_game_pressed():
	menuVisible = not menuVisible 
	$NinePatchRect.visible = menuVisible

func _on_pause_pressed():
	if not game_paused:
		pause_game()
		game_paused = true

# Signal handler for Play button
func _on_play_pressed():
	if game_paused:
		resume_game()
		game_paused = false


func _on_main_menu_pressed():
	# Load the main menu scene
	global.goto_scene("res://scenes/mainmenu.tscn")
