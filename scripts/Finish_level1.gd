extends Area2D


func _on_Finish_level_body_entered(body):
	var global = get_node("/root/Global")
	global.nextLevel = "res://levels/Level2.tscn"
	global.level3Unlocked = true
	body.onLevelFinished()
	queue_free()
