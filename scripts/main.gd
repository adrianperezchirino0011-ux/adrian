extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var npc: Area2D = $NPC
@onready var hud: CanvasLayer = $HUD

var jobs := JobSystem.new()

func _ready() -> void:
	add_child(jobs)
	npc.body_exited.connect(npc._on_body_exited)
	npc.interacted.connect(_on_npc_interacted)
	hud.set_info("Bienvenido: busca al NPC rosa y presiona E")
	hud.set_money(jobs.money)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player.get_meta("near_npc", false):
		var near_npc = player.get_meta("near_npc_ref", null)
		if near_npc:
			near_npc.interact()

func _on_npc_interacted() -> void:
	if jobs.current_job == "Desempleado":
		jobs.take_job("Taxi")
		hud.set_info("Trabajo asignado: Taxi. Recibiste pago inicial.")
	else:
		hud.set_info("Turno completado en %s. Pago recibido." % jobs.current_job)
	var total = jobs.payout(50)
	hud.set_money(total)
