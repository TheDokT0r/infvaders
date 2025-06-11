class_name enemy
extends Area2D

signal	died(enemy_instance: enemy)

const base_speed = 10

func _on_area_entered(area: Area2D) -> void:
	if area is bullet:
		area.destroy()
		emit_signal("died", self)
		call_deferred("free")
