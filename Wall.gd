extends StaticBody2D

@export var max_hp: int = 50
var current_hp: int
var is_spiked: bool = false # Zda byla zábrana naostřena nožem

func _ready() -> void:
	current_hp = max_hp

func take_damage(amount: int, attacker: Node2D = null) -> void:
	current_hp -= amount
	
	# Pokud jsou kůly naostřené, vrátí útočníkovi poškození
	if is_spiked and attacker and attacker.has_method("take_damage"):
		attacker.take_damage(10)

	if current_hp <= 0:
		queue_free() # Zničení barikády
