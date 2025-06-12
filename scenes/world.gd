extends Node2D

@onready var tank = $tank
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var enemies: Array[enemy] = []
@onready var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_enemeis()
	
#	Center the tank
	var center = get_viewport_rect().size / 2
	tank.position.x = center.x
	tank.position.y = get_viewport_rect().size.y - 20
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = tank.position
		bullet_instance.connect("bullet_freed", on_bullet_freed)
		add_child(bullet_instance)
		can_shoot = false

# I should probably change that later lol
@onready var columns := 8
@onready var rows := 10
@onready var spacing_x := 100
@onready var spacing_y := 50
@onready var screen_size = get_viewport_rect().size
@onready var total_width := (columns - 1) * spacing_x
@onready var total_height := (rows - 1) * spacing_y
@onready var start_x = (screen_size.x - total_width) / 2
@onready var start_y := 50  # fixed offset from the top
@onready var enemy_scale := Vector2(2, 2)

func create_enemeis():
	for x in columns:
		for y in rows:
			var new_enemy = enemy.instantiate()
			new_enemy.position = Vector2(start_x + x * spacing_x, start_y + y * spacing_y)
			new_enemy.scale = enemy_scale
			new_enemy.connect("died", on_enemy_died)
			enemies.append(new_enemy)
			add_child(new_enemy)
			
func spawn_enemies_top_row():
	for x in columns:
		var new_enemy = enemy.instantiate()
		new_enemy.position = Vector2(start_x * x * spacing_x, start_y)
		new_enemy.scale = enemy_scale
		new_enemy.connect("died", on_enemy_died)
		enemies.append(new_enemy)
		add_child(new_enemy)
	

func on_enemy_died(enemy_instance: enemy):
	enemies.erase(enemy_instance)
	
func on_bullet_freed():
	can_shoot = true

var enemies_direction := Vector2.RIGHT
var step_count := 0
var steps_before_down := 5
var speed_mult := 1

func _on_timer_timeout() -> void:
	enemy_shoot()
	step_count += 1

	if step_count < steps_before_down:
		move_enemies(enemies_direction)
	elif step_count == steps_before_down:
		move_enemies(Vector2.DOWN)
		spawn_enemies_top_row()
		speed_mult += .1
		enemies_direction *= -1  # reverse direction
		step_count = 0
		
func move_enemies(dir: Vector2) -> void:
	for e in enemies:
		e.position += dir * 10 * speed_mult
		

func enemy_shoot():
	var r = randf()
	if r >= 0.8:
		enemies.pick_random().shoot(self)
