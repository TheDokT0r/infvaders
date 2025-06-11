extends Node2D

@onready var tank = $tank
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var enemies: Array[enemy] = []
@onready var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_enemeis()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = tank.position
		bullet_instance.connect("bullet_freed", on_bullet_freed)
		add_child(bullet_instance)
		can_shoot = false

func create_enemeis():
	for x in 10:
		for y in 5:
			var new_enemy = enemy.instantiate()
			new_enemy.position = Vector2(x * 100, y * 50)
			new_enemy.scale = Vector2(2, 2)
			new_enemy.connect("died", on_enemy_died)
			enemies.append(new_enemy)
			add_child(new_enemy)

func on_enemy_died(enemy_instance: enemy):
	enemies.erase(enemy_instance)
	
func on_bullet_freed():
	can_shoot = true

var enemies_direction := Vector2.RIGHT
var step_count := 0
var steps_before_down := 10
var speed_mult := 1

func _on_timer_timeout() -> void:
	step_count += 1

	if step_count < steps_before_down:
		move_enemies(enemies_direction)
	elif step_count == steps_before_down:
		move_enemies(Vector2.DOWN)
		enemies_direction *= -1  # reverse direction
		step_count = 0
		
func move_enemies(dir: Vector2) -> void:
	for e in enemies:
		e.position += dir * 10 * speed_mult
		
