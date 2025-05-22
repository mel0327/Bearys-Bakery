class_name ItemHealing extends Item

@export var healing_amount := 3

func use(player: Player) -> void:
	player.health += healing_amount
