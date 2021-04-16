extends KinematicBody2D

signal hit

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Add this variable to hold the clicked position.
var target = Vector2()
var animPlay = false

#var parallax_true = false

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
# Change the target whenever a touch event happens.
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		look_at(target)


func _physics_process(_delta):
	var velocity = position.direction_to(target) * speed # The player's movement vector.
	# Move towards the target and stop when close.
	$AnimationPlayer.play("idle")
	if position.distance_to(target) > 15:
		velocity = move_and_slide(velocity)
		$AnimationPlayer.play("walk")
		#parallax_true = true
	#else:
		#parallax_true = false
		
	#var parallax = position.direction_to(target)
	#if parallax_true:
		#get_parent().parralax_play(parallax)
	#elif not parallax_true:
		#get_parent().parralax_play(parallax * 0.001)
	var con = get_parent().score % 35
	if con == 34:
		var i = get_parent().score % 2
		get_parent().change_texture(i)
	
	#position += velocity * delta
	# We still need to clamp the player's position here because on devices that don't
	# match your game's aspect ratio, Godot will try to maintain it as much as possible
	# by creating black borders, if necessary.
	# Without clamp(), the player would be able to move under those borders.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func start(pos):
	position = pos
	# Initial target is the start position.
	target = pos
	show()
	$HitBox/CollisionShape2D.disabled = false
	
func _on_HitBox_body_entered(_body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$HitBox/CollisionShape2D.set_deferred("disabled", true)
