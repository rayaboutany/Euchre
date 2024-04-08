extends Label
var meow
var bruh
signal plz
var ugh
var x
var id
var texture
var texture_rect 
var load_icon = preload("res://scenes/suitIcon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str("waiting on player 1..."))
	#set_text(str(meow))
	global.trumpselected.connect(meowplz)
	global.suitChosen.connect(woofplz)
	x=false
	

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
	
func woofplz(suit):
	match (suit.woof):
		0: 
			set_text("hearts is trump")
		1: 
			set_text("clubs is trump")
		2: 
			set_text("diamonds is trump")
		3: 
			set_text("spades is trump")
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
	set_text("would you like to call a suit?")
	x =true
