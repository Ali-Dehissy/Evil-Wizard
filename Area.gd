extends Area2D


var enter = false

func _on_Area2D_body_entered(body: PhysicsBody2D):
	enter = true
	
func _process(delta):
	if enter == true:
		if Input.is_action_just_pressed("ui_page_up"):
			get_tree().change_scene("res://Level 2.tscn")
