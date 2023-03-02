extends Control





func _on_Start_pressed():
	get_tree().change_scene("res://Level 1.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://Controls.tscn")


func _on_Quit_pressed():
	get_tree().quit()
