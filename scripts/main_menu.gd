extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_effect_h_slider_value_changed($"Options Menu/EffectHSlider".value)
	_on_music_h_slider_value_changed($"Options Menu/MusicHSlider".value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	$Click.play()
	$Arrow.visible = not $Arrow.visible


func _on_options_pressed() -> void:
	$Click.play()
	$"Options Menu".visible = not $"Options Menu".visible



func _on_effect_h_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Effects")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_music_h_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
