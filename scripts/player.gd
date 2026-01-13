extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 100.0
const SPRINT = 1.75
const dash_speed = 400
var current_direction = 'none'
var direction = 1

# my custom physics process
func _physics_process(delta):
	_player_movement(delta)

func _player_movement(delta):	
	# movement
	if Input.is_action_pressed('move_right'):
		direction = 1
		animated_sprite.flip_h = false
		animated_sprite.play('running_side')
		current_direction = 'right'
		if Input.is_action_pressed('sprint'):
			velocity.x = SPEED * direction * SPRINT
			velocity.y = 0
		else:
			velocity.x = SPEED * direction
			velocity.y = 0
	elif Input.is_action_pressed('move_left'):
		if Input.is_action_pressed('sprint'):
			current_direction = 'left'
			animated_sprite.flip_h = true
			animated_sprite.play('running_side')
			direction = -1
			velocity.x = SPEED * direction * SPRINT
			velocity.y = 0
		else:
			current_direction = 'left'
			animated_sprite.flip_h = true
			animated_sprite.play('running_side')
			direction = -1
			velocity.x = SPEED * direction
			velocity.y = 0
	elif Input.is_action_pressed('move_down'):
		if Input.is_action_pressed('sprint'):
			current_direction = 'down'
			animated_sprite.play('running_front')
			direction = 1
			velocity.x = 0
			velocity.y = SPEED * direction * (SPRINT - 0.25)
		else:
			current_direction = 'down'
			animated_sprite.play('running_front')
			direction = 1
			velocity.x = 0
			velocity.y = SPEED * direction
	elif Input.is_action_pressed('move_up'):
		if Input.is_action_pressed('sprint'):
			current_direction = 'up'
			animated_sprite.play('running_back')
			direction = -1
			velocity.x = 0
			velocity.y = SPEED * direction * SPRINT
		else:
			current_direction = 'up'
			animated_sprite.play('running_back')
			direction = -1
			velocity.x = 0
			velocity.y = SPEED * direction
	# plays idle animations
	else:
		if current_direction == 'right':
			animated_sprite.flip_h = false
			animated_sprite.play('side_idle')
		elif current_direction == 'left':
			animated_sprite.flip_h = true
			animated_sprite.play('side_idle')
		elif current_direction == 'down':
			animated_sprite.play('front_idle')
		else:
			animated_sprite.play("back_idle")
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
