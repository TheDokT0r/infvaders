class_name enemy
extends Area2D

@onready var bullet := preload("res://scenes/bullet.tscn")

signal	died(enemy_instance: enemy)

const base_speed = 10

func _on_area_entered(area: Area2D) -> void:
	if area is bullet and !area.shot_by_enemy:
		area.destroy()
		emit_signal("died", self)
		call_deferred("free")

func shoot(parent: Node2D):
	var bullet_instance = bullet.instantiate()
	bullet_instance.direction = Vector2.DOWN
	bullet_instance.position = position
	bullet_instance.shot_by_enemy = true
	parent.add_child(bullet_instance)
