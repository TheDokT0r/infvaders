class_name Tank
extends CharacterBody2D

@export var speed = 1000
@onready var bullet = preload("res://scenes/bullet.tscn")

# In _physics_process
func _physics_process(delta):
	# Get the mouse position
	var mouse_position = get_viewport().get_mouse_position()
	
	self.position.x = mouse_position.x
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is bullet and area.shot_by_enemy:
		call_deferred("free")
