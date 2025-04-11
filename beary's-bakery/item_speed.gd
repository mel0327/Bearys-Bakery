class_name ItemSpeedBoost extends Item


@export var speed_amount := 1000

func use(player: Player) -> void:
	player.speed += speed_amount
