extends Area2D

signal interacted

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.set_meta("near_npc", true)
		body.set_meta("near_npc_ref", self)

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		body.set_meta("near_npc", false)
		body.set_meta("near_npc_ref", null)

func interact() -> void:
	emit_signal("interacted")
