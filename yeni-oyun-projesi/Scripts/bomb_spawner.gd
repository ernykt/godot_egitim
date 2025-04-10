extends Node2D

var bomb = preload("res://Scenes/Bomb.tscn")

func _on_timer_timeout() -> void:
	var bombInstance = bomb.instantiate()
	add_child(bombInstance, true)
	bombInstance.position = Vector2(100,100)
	print_debug(bombInstance.name)
