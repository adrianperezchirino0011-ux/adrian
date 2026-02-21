extends CharacterBody2D

signal health_changed(current: int, max_health: int)

@export var speed: float = 190.0
@export var max_health: int = 100
var health: int = max_health

func _ready() -> void:
	health_changed.emit(health, max_health)

func _physics_process(_delta: float) -> void:
	var input_vec := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vec * speed
	move_and_slide()

func heal(amount: int) -> void:
	health = mini(max_health, health + amount)
	health_changed.emit(health, max_health)

func take_damage(amount: int) -> void:
	health = maxi(0, health - amount)
	health_changed.emit(health, max_health)
