extends Node2D

@export var wall_scene: PackedScene # Připojte scénu Wall.tscn v editoru

func _unhandled_input(event: InputEvent) -> void:
	# Stavění vyvoláte stisknutím tlačítka stavby na mobilu / PC
	if event.is_action_pressed("build_wall"):
		try_build_wall()

func try_build_wall() -> void:
	# Pokud má hráč nůž, staví ostřené kůly (levněji nebo účinněji)
	var wood_required = 2 if Global.has_knife else 3
	
	if Global.wood_count >= wood_required:
		Global.wood_count -= wood_required
		
		var new_wall = wall_scene.instantiate()
		new_wall.global_position = global_position # Postaví zábranu na místě hráče
		
		# Pokud byl použit nůž, nastavíme vyšší odolnost / trny
		if Global.has_knife:
			new_wall.is_spiked = true
			
		get_tree().current_scene.add_child(new_wall)
		print("Postavena barikáda!")
	else:
		print("Nedostatek dřeva! Potřebuješ: ", wood_required)
