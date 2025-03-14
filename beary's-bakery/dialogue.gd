extends Control


@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var character: TextureRect = %Character

var current_item_index := 0

var characters := {
	"BunBun": preload("res://bunny.png"),
	"Beary": preload("res://bear.png"),
	"Dexter": preload("res://dog.png"),
	"Hammy": preload("res://hamster.png"),
	"James": preload("res://cats.png"),
	"Jeorge": preload("res://cats.png"),
	#add townsfolk
}


func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)

var dialogue_items: Array[Dictionary] = [
	{
		"character": characters["BunBun"],
		"text": "Hello my name is BunBun"
	},
	{
		"character": characters["Beary"],
		"text": "beary"
	},
	{
		"character": characters["Dexter"],
		"text": "dog",
	},
	{
		"character": characters["Hammy"],
		"text": "hammy",
	},
	{
		"character": characters["James"],
		"text": "james",
	},
	{
		"character": characters["Jeorge"],
		"text": "jeorge",
	},
]

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	character.texture = current_item["character"]
	
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration := 1.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	slide_in()

	next_button.disabled = true
	tween.finished.connect(func() -> void:
		next_button.disabled = false
	)


func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()


func slide_in() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	character.position.x = 200.0
	tween.tween_property(character, "position:x", 0.0, 0.3)
	character.modulate.a = 0.0
	tween.parallel().tween_property(character, "modulate:a", 1.0, 0.2)
