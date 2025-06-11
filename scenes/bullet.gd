class_name bullet

extends Area2D

var speed = 600
var direction : Vector2 = Vector2.UP

signal bullet_freed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	emit_signal("bullet_freed")
	call_deferred("free")

func destroy():
	emit_signal("bullet_freed")
	call_deferred("free")
