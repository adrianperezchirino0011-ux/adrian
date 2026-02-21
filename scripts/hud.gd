extends CanvasLayer

@onready var info_label: Label = $TopPanel/MarginContainer/VBoxContainer/InfoLabel
@onready var money_label: Label = $TopPanel/MarginContainer/VBoxContainer/MoneyLabel
@onready var regime_label: Label = $TopPanel/MarginContainer/VBoxContainer/RegimeLabel
@onready var health_bar: ProgressBar = $TopPanel/MarginContainer/VBoxContainer/HealthBar

func set_info(text: String) -> void:
	info_label.text = text

func set_money(value: int) -> void:
	money_label.text = "Dinero: $%d" % value

func set_regime_status(text: String) -> void:
	regime_label.text = text

func set_health(current: int, max_health: int) -> void:
	health_bar.max_value = max_health
	health_bar.value = current
	health_bar.get_node("HealthText").text = "Salud: %d/%d" % [current, max_health]
