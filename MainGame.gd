extends Node2D

@export var zombie_scene: PackedScene
@onready var day_night_timer: Timer = $DayNightTimer
@onready var global_light: DirectionalLight2D = $GlobalLight

var wave_number: int = 1
var is_night: bool = false

func _ready() -> void:
	$Campfire.add_to_group("Campfire")
	start_day()

func start_day() -> void:
	is_night = false
	global_light.energy = 1.0 # Plné denní světlo
	print("--- DEN ", wave_number, " (5 min na stavbu a sběr) ---")
	day_night_timer.start(300.0) # 5 minut

func start_night() -> void:
	is_night = true
	global_light.energy = 0.15 # Tma
	print("--- NOC ", wave_number, " (Začíná útok!) ---")
	
	# Spuštění spawnování zombie
	spawn_wave()
	day_night_timer.start(120.0) # 2 minuty noc

func spawn_wave() -> void:
	# Počet zombie roste s každou nocí
	var zombie_count = 5 + (wave_number * 3)
	
	for i in range(zombie_count):
		await get_tree().create_timer(1.5).timeout # Odstup mezi spawny
		if not is_night or Global.is_game_over:
			break
			
		var zombie = zombie_scene.instantiate()
		# Náhodný spawn na okraji mapy
		var angle = randf() * TWO_PI
		var spawn_pos = $Campfire.global_position + Vector2(cos(angle), sin(angle)) * 800
		zombie.global_position = spawn_pos
		add_child(zombie)

func _on_day_night_timer_timeout() -> void:
	if is_night:
		wave_number += 1
		start_day()
	else:
		start_night()

# Volá se, pokud zombie útočí přímo na ohniště
func take_damage(amount: int, _attacker = null) -> void:
	Global.base_hp -= amount
	print("Ohniště napadeno! Zbývá HP: ", Global.base_hp)
	if Global.base_hp <= 0:
		Global.is_game_over = true
		print("GAME OVER! Ohniště bylo zničeno.")
