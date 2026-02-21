extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var npc: Area2D = $NPC
@onready var hud: CanvasLayer = $HUD

var jobs := JobSystem.new()
var loyalty_points: int = 0

func _ready() -> void:
	add_child(jobs)
	npc.body_exited.connect(npc._on_body_exited)
	npc.interacted.connect(_on_npc_interacted)
	player.health_changed.connect(_on_player_health_changed)
	hud.set_info("Barrio Centro: busca al funcionario y presiona E")
	hud.set_money(jobs.money)
	hud.set_regime_status("Estado cívico: Neutral")
	hud.set_health(player.health, player.max_health)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player.get_meta("near_npc", false):
		var near_npc = player.get_meta("near_npc_ref", null)
		if near_npc:
			near_npc.interact()

func _on_npc_interacted() -> void:
	if jobs.current_job == "Desempleado":
		jobs.take_job("Reparto Estatal")
		hud.set_info("Trabajo asignado: Reparto Estatal. Cumple tu turno.")
	else:
		hud.set_info("Turno completado en %s. Cobro aprobado." % jobs.current_job)
	var total = jobs.payout(65)
	loyalty_points += 5
	player.heal(2)
	hud.set_money(total)
	hud.set_regime_status("Estado cívico: %d pts lealtad" % loyalty_points)

func _on_player_health_changed(current: int, max_health: int) -> void:
	hud.set_health(current, max_health)
