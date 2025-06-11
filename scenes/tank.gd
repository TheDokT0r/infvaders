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
