class_name Pickup extends Area2D

@export var item: Item = null: set = set_item

@onready var _sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	set_item(item)

	body_entered.connect(func (body: Node2D) -> void:
		if body is Player:
			item.use(body)
			set_deferred("monitoring", false)
			queue_free()
		)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if item == null:
		warnings.append("The pickup has no item assigned. Please assign an item to the pickup in the inspector.")
	return warnings


func set_item(value: Item) -> void:
	item = value
	if _sprite_2d != null:
		_sprite_2d.texture = item.texture
