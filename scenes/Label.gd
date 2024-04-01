extends Label
var meow
var bruh
signal plz
var ugh
var x
var id
var texture
var texture_rect 
var textureURLs = [
	"res://assets/cards/Hearts.png",
	"res://assets/cards/Clubs.png",
	"res://assets/cards/Diamonds.png",
	"res://assets/cards/Spades.png"
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str("waiting on player 1..."))
	#set_text(str(meow))
	global.trumpselected.connect(meowplz)
	x=false
	
	 # Replace with function body.
func setTexture():
	texture = load(textureURLs[id])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttoncard_2_pressed():
	if (x == false):
		set_text(str(meow) + " is now trump")
	if (x == true):
		global.emit_signal("delete")
		set_text("what would like trump to be?")
		$Timer.stop()
		for i in range(textureURLs.size()):
			var texture_rect = TextureRect.new()
			texture_rect.texture = load(textureURLs[i])
			texture_rect.set_size(Vector2(100, 150))
			texture_rect.position = Vector2(i *170 , 160)
			add_child(texture_rect)
		#where all the thingies go
	pass
	
func _unhandled_input(texture):
	if texture is InputEventMouseButton and texture.pressed and texture.button_index == MOUSE_BUTTON_LEFT:
		print(texture)
		for i in range(textureURLs.size()):
			match textureURLs[i]:
				"res://assets/cards/Hearts.png":
					set_text("hearts is trump")
					print(texture)
				"res://assets/cards/Clubs.png":
					set_text("clubs")
					print(texture)
				"res://assets/cards/Diamonds.png":
					set_text("diamonds")
					print(texture + "diamonds")
					
				"res://assets/cards/Spades.png":
					set_text("spades")
					print(texture +"spades")
					
			break
		
		#the 
func meowplz(suits):
	meow =suits
	set_text("waiting on player 1..." )


func _on_buttoncard_1_pressed():
	if (x==false):
		ugh = "waiting on other players..."
		set_text(ugh)
	if(x==true):
		set_text("Game will begin shortly")
		$Timer.stop()
	$Timer.start()
	
	

func _on_timer_timeout():
	set_text("would you like to call a suit?")
	x =true
