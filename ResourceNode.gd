extends Area2D

enum ResourceType { WOOD, STONE, KNIFE, FLASHLIGHT }
@export var type: ResourceType = ResourceType.WOOD

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		match type:
			ResourceType.WOOD:
				Global.wood_count += 1
				print("Sebráno dřevo! Celkem: ", Global.wood_count)
			ResourceType.STONE:
				Global.stone_count += 1
				print("Sebrán kámen! Celkem: ", Global.stone_count)
			ResourceType.KNIFE:
				Global.has_knife = true
				print("Našel jsi nůž! Nyní můžeš oostřit klacky na ostnaté kůly.")
			ResourceType.FLASHLIGHT:
				Global.has_flashlight = true
				body.equip_flashlight()
				print("Našel jsi baterku!")
		
		queue_free() # Odstraní objekt ze světa po sebrání
