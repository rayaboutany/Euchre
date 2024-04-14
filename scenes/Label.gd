extends Label
var meow
var bruh
var trumpsuit
signal plz
signal hideme
var ugh
var x
var id
signal bruh10
var texture
var texture_rect 
var load_icon = preload("res://scenes/suitIcon.tscn")
var textureURLs = ["res://assets/Screenshot 2024-04-13 at 4.50.32 PM.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str("waiting on player 1..."))
	#set_text(str(meow))
	global.trumpselected.connect(meowplz)
	global.suitChosen.connect(woofplz)
	x=false
	global.bruh10.connect(hideicons)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttoncard_2_pressed():
	if (x == false):
		trumpsuit = meow
		set_text(str(meow) + " is now trump")
	if (x == true):
		global.emit_signal("delete")
		set_text("what would like trump to be?")
		$Timer.stop()
		for i in range(4):
			var texture_rect = load_icon.instantiate()
			texture_rect.woof = i
			texture_rect.setTexture()
			#texture_rect.set_size(Vector2(100, 150))
			texture_rect.scale = Vector2(2,2)
			texture_rect.position = Vector2(i *170 , 160)
			add_child(texture_rect)
		#where all the thingies go
	pass
	
func hideicons():
	for child in get_children():
		child.queue_free()
			
	
	
func woofplz(suit):
	match (suit.woof):
		0: 
			set_text("hearts is trump")
			trumpsuit = "HEARTS"
		1: 
			set_text("clubs is trump")
			trumpsuit = "CLUBS"
		2: 
			set_text("diamonds is trump")
			trumpsuit = "DIAMONDS"
		3: 
			set_text("spades is trump")
			trumpsuit = "SPADES"
	print(suit)
	pass
		
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
	global.emit_signal("hideme")
	set_text("would you like to call a suit?")
	x =true
