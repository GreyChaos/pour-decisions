extends Node2D

func _enlarge_recipe_sheet() -> void:
	if GameManager.held_item == null:
		scale = Vector2(2.5,2.5)
		z_index = 10
		
func _shrink_recipe_sheet() -> void:
	scale = Vector2(1,1)
	z_index = 1
