extends Area2D

@export var effect_duration := 5.0
@onready var effect_timer: Timer = $EffectTimer
@onready var timer: Timer = $Timer

# Reference to the affected player
var affected_body: Node2D = null
var affected_collider: Node2D = null
func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerBody":
		print("Power-up collected")
		# Save reference to player
		affected_body = body
		affected_collider = body
		# 🔻 Disable player's Area2D
		if affected_body.has_node("Area2D"):
			affected_body.get_node("Area2D").set_deferred("monitoring", false)
		affected_body.get_node("PlayerCollider").set_deferred("disabled", true)
		effect_timer.start(effect_duration)
		position = Vector2(50, 50) # Optional: hide/move while effect is active
		timer.stop()
func _on_effect_timer_timeout() -> void:
	# 🔼 Re-enable player's Area2D
	if affected_body and affected_body.has_node("Area2D"):
		affected_body.get_node("Area2D").monitoring = true
	if affected_collider and affected_collider.has_node("PlayerCollider"):
		affected_collider.get_node("PlayerCollider").disabled = false
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
