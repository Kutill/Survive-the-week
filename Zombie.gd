extends CharacterBody2D

@export var speed: float = 60.0
@export var hp: int = 30
@export var damage: int = 10

var target_position: Vector2 = Vector2.ZERO # Pozice ohniště

func _ready() -> void:
	add_to_group("Enemies")
	# Využije pozici ohniště ze scény
	var camp = get_tree().get_first_node_in_group("Campfire")
	if camp:
		target_position = camp.global_position

func _physics_process(_delta: float) -> void:
	if Global.is_game_over:
		return

	# Pohyb směrem k ohništi
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	
	var collision = move_and_collide(velocity * _delta)
	
	# Pokud narazí na barikádu nebo ohniště
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			collider.take_damage(damage, self)

func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		queue_free() # Zombie umírá
