extends KinematicBody2D

var is_moving_left = true
var gravity  = 10
var velocity = Vector2(0, 0)

var speed = 100

func _ready():
	$AnimationPlayer.play("walk")
	
func _process(delta):
	if $AnimationPlayer.current_animation == "attack":
		return
		
	move_character()
	detect_turn_around()
	
func move_character():
	velocity.x = -speed if is_moving_left else speed
	
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		
func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false
	
func start_walk():
	$AnimationPlayer.play("walk")

func _on_PlayerDetector_body_entered(body):
	$AnimationPlayer.play("attack")

func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()
	
func take_damage():
	$AnimatedSprite.animation = "takehit"
	var t = Timer.new()
	t.set_wait_time(0.3)
	t.set_one_shot(false)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$AnimatedSprite.animation = "dead"
	t.set_wait_time(0.3)
	t.set_one_shot(false)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
