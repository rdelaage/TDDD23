extends Node2D

func _ready():
	var global = get_node("/root/Global")
	global.currentLevel = "res://levels/Level0.tscn"
