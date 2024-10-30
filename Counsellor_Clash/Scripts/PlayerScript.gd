extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var state : String = "idle"
var player : String = ""
var isAttacking : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta



	if name == "Player2": # Check if Player1 or Player2
		player = "P2" # Set name (This adds on to the required button inputs, so moveLeft would become P2moveLeft)

	# Handle jump.
	if Input.is_action_just_pressed(player + "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#state = "jump"









	# Move character and handle inputs
	var direction := Input.get_axis(player + "moveLeft", player + "moveRight") # Check if movement left or right
	if direction:
		if $AnimationPlayer.is_playing() && isAttacking: return # Check that player isn't locked in to attack
		velocity.x = direction * SPEED # Move player
		state = "running" # Play Animation
		$AttackZone/attack1Collision.disabled = true # Disable Hit Detection
		$AttackZone/attack2Collision.disabled = true # Disable Hit Detection
	else: # If not moving
		if $AnimationPlayer.is_playing() && isAttacking: return # Check that player isn't locked in to attack
		velocity.x = move_toward(velocity.x, 0, SPEED) # Slow down Player
		state = "idle" # Play Animation
		$AttackZone/attack1Collision.disabled = true # Disable Hit Detection
		$AttackZone/attack2Collision.disabled = true # Disable Hit Detection

	if Input.is_action_just_pressed(player + "attack1"): # If Player presses attack1
		state = "attack1" # Play Animation
		$AttackZone/attack1Collision.disabled = false # Enable Hit Detection
	if Input.is_action_just_pressed(player + "attack2"): # If Player presses attack2
		state = "attack2" # Play Animation
		$AttackZone/attack2Collision.disabled = false # Enable Hit Detection









# Turning Player Around
	if direction < 0 : # If going left
		$SpritePlayer1.flip_v = true # Flip Sprite
		$".".rotation_degrees = 180 # Flip Hitboxes
	elif direction > 0 : # If going Right
		$SpritePlayer1.flip_v = false # Unflip Sprite
		$".".rotation_degrees = 0 # Unflip Hitboxes

	move_and_slide() # Move Player (Built in Godot Script)









	if state == ("idle"): # Check if Idle
		$AnimationPlayer.play("Idle") # Play Idle Animation
		isAttacking = false
	elif state == ("running"): # Check if Running
		$AnimationPlayer.play("Running") # Play Running Animation
		isAttacking = false
	elif state == ("attack1"): # Check if Attacking with attack1
		$AnimationPlayer.play("Attack1") # Play Attack1
		isAttacking = true
	elif state == ("attack2"): # Check if Attacking with attack2
		$AnimationPlayer.play("Attack2") # Play Attack2
		isAttacking = true



func _on_attack_zone_body_entered(body: Node2D) -> void: # When AttackZone collides with something
	if body.is_in_group("Player"): # Checks if in Group Player
		print("Hit") # DEBUG TEMP
		
