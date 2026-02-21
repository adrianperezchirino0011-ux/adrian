extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var npc: Area2D = $NPC
@onready var hud: CanvasLayer = $HUD

var jobs := JobSystem.new()
var loyalty_points: int = 0
var in_game_minutes: int = 8 * 60
var selected_slot: int = 1

func _ready() -> void:
	add_child(jobs)
	npc.body_exited.connect(npc._on_body_exited)
	npc.interacted.connect(_on_npc_interacted)
	player.health_changed.connect(_on_player_health_changed)
	hud.set_info("Control de barrio: habla con el funcionario (E)")
	hud.set_money(jobs.money)
	hud.set_regime_status("Estado cívico: Observado")
	hud.set_district("Centro Viejo")
	hud.set_health(player.health, player.max_health)
	hud.highlight_slot(selected_slot)
	_update_clock_label()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player.get_meta("near_npc", false):
		var near_npc = player.get_meta("near_npc_ref", null)
		if near_npc:
			near_npc.interact()
	_handle_quickbar_input()
	advance_time(delta)

func _handle_quickbar_input() -> void:
	for i in range(1, 9):
		if Input.is_key_pressed(KEY_0 + i):
			if selected_slot != i:
				selected_slot = i
				hud.highlight_slot(i)
				hud.set_info("Slot %d equipado" % i)

func advance_time(delta: float) -> void:
	in_game_minutes += int(delta * 8.0)
	if in_game_minutes >= 24 * 60:
		in_game_minutes = 0
	_update_clock_label()

func _update_clock_label() -> void:
	var hour := in_game_minutes / 60
	var minute := in_game_minutes % 60
	hud.set_clock(hour, minute)

func _on_npc_interacted() -> void:
	if jobs.current_job == "Desempleado":
		jobs.take_job("Distribución Cívica")
		hud.set_info("Asignado: Distribución Cívica. Entrega raciones.")
	else:
		hud.set_info("Ronda en %s completada." % jobs.current_job)
	var total = jobs.payout(70)
	loyalty_points += 4
	player.heal(1)
	hud.set_money(total)
	hud.set_regime_status("Estado cívico: %d pts de lealtad" % loyalty_points)

func _on_player_health_changed(current: int, max_health: int) -> void:
	hud.set_health(current, max_health)
