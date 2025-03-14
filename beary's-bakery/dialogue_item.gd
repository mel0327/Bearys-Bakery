class_name DialogueItem extends SlideShowEntry


@export_group("Choices")

func set_choices(new_choices: Array[DialogueChoice]) -> void:
	for index in new_choices.size():
		if new_choices[index] == null:
			new_choices[index] = DialogueChoice.new()
	choices = new_choices
