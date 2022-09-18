extends Area2D

func _on_move_camera_top_body_entered(body):
	body.camera_animation_y()
	queue_free()
