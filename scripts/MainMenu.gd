extends Control

func _on_Play_button_down():
	get_tree().change_scene("res://levels/Level0.tscn")


func _on_Quit_button_down():
	get_tree().quit()


func _on_Control_ready():
	var global = get_node("/root/Global")
	$PlayButton.disabled = !global.level1Unlocked
	$PlayButton2.disabled = !global.level2Unlocked
	$PlayButton3.disabled = !global.level3Unlocked


func _on_PlayButton2_button_down():
	get_tree().change_scene("res://levels/Level1.tscn")
