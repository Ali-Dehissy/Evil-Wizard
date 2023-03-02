extends Area2D


var enter = false	


func _on_Area2D_body_entered(body: PhysicsBody2D):
	enter = true


func _on_Area2D_body_exited(body):
	enter = false
	
func _process(delta):
	if enter == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene("res://Level 2.tscn")
