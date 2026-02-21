extends Node
class_name JobSystem

var money: int = 0
var current_job: String = "Desempleado"

func take_job(job_name: String) -> void:
	current_job = job_name

func payout(amount: int) -> int:
	money += amount
	return money
