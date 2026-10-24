extends Node

# Hráčův inventář
var wood_count: int = 0
var stone_count: int = 0
var has_knife: bool = false
var has_flashlight: bool = false

# Stav hry
var base_hp: int = 100
var is_game_over: bool = false

func reset_game() -> void:
	wood_count = 0
	stone_count = 0
	has_knife = false
	has_flashlight = false
	base_hp = 100
	is_game_over = false
