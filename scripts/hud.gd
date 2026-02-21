extends CanvasLayer

@onready var info_label: Label = $MarginContainer/VBoxContainer/InfoLabel
@onready var money_label: Label = $MarginContainer/VBoxContainer/MoneyLabel

func set_info(text: String) -> void:
	info_label.text = text

func set_money(value: int) -> void:
	money_label.text = "Dinero: $%d" % value
