extends CanvasLayer

@onready var info_label: Label = $TopLeftPanel/Margin/VBox/InfoLabel
@onready var money_label: Label = $TopLeftPanel/Margin/VBox/MoneyLabel
@onready var regime_label: Label = $TopLeftPanel/Margin/VBox/RegimeLabel
@onready var district_label: Label = $TopRightPanel/Margin/VBox/DistrictLabel
@onready var time_label: Label = $TopRightPanel/Margin/VBox/TimeLabel
@onready var health_bar: ProgressBar = $TopLeftPanel/Margin/VBox/HealthBar
@onready var slot_panels: Array[Panel] = [
	$BottomQuickbar/Margin/Slots/Slot1,
	$BottomQuickbar/Margin/Slots/Slot2,
	$BottomQuickbar/Margin/Slots/Slot3,
	$BottomQuickbar/Margin/Slots/Slot4,
	$BottomQuickbar/Margin/Slots/Slot5,
	$BottomQuickbar/Margin/Slots/Slot6,
	$BottomQuickbar/Margin/Slots/Slot7,
	$BottomQuickbar/Margin/Slots/Slot8,
]

func _ready() -> void:
	highlight_slot(1)

func set_info(text: String) -> void:
	info_label.text = text

func set_money(value: int) -> void:
	money_label.text = "Efectivo: $%d" % value

func set_regime_status(text: String) -> void:
	regime_label.text = text

func set_district(name: String) -> void:
	district_label.text = "Distrito: %s" % name

func set_clock(hour: int, minute: int) -> void:
	time_label.text = "Hora: %02d:%02d" % [hour, minute]

func set_health(current: int, max_health: int) -> void:
	health_bar.max_value = max_health
	health_bar.value = current
	health_bar.get_node("HealthText").text = "Salud %d/%d" % [current, max_health]

func highlight_slot(slot_index: int) -> void:
	for i in range(slot_panels.size()):
		slot_panels[i].modulate = Color(0.24, 0.24, 0.24, 0.95)
	if slot_index >= 1 and slot_index <= slot_panels.size():
		slot_panels[slot_index - 1].modulate = Color(0.65, 0.55, 0.24, 1.0)
