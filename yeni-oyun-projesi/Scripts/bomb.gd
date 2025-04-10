extends CharacterBody2D

func _ready() -> void:
	velocity = Vector2(0,500)

func _process(delta: float) -> void:
	position += velocity * delta
