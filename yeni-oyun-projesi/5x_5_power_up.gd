extends Area2D

@onready var _5x_5: Sprite2D = $"../5x5"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_5x_5.visible = true
		print_debug("hello")
