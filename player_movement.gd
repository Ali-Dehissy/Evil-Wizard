extends KinematicBody2D

var velocity : Vector2

export var max_speed : int = 200
export var gravity : float = 35
export var jump_force : int = 800

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		$Area2D/CollisionShape2D.disabled = false
		$AnimatedSprite.play("attack")
	else:
		$Area2D/CollisionShape2D.disabled = true
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 2000:
			velocity.y = 2000
	if Input.is_action_just_pressed("ui_page_down"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("ui_right"):
		velocity.x = max_speed
		$AnimatedSprite.flip_h = false
		get_node("Area2D").set_scale(Vector2(1, 1))
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -max_speed
		$AnimatedSprite.flip_h = true
		get_node("Area2D").set_scale(Vector2(-1, 1))
		$AnimatedSprite.play("run")
	else:
		velocity.x = 0
		$AnimatedSprite.play("standing")
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("jump")
		if is_on_floor():
			velocity.y = -jump_force
	velocity = move_and_slide(velocity, Vector2.UP)		

func _on_Area2D_body_entered(body):
	if body.is_in_group("hit"):
		body.take_damage()
	else:
		pass

