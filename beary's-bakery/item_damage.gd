class_name ItemDamage extends Item

@export var damage_amount := 1

func use(player: Player) -> void:
	player.damage += damage_amount
