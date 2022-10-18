extends Area2D


func _on_Finish_level_body_entered(body):
	body.onGameFinished()
	queue_free()
