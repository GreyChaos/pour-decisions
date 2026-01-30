extends Node2D

@onready var pour_rate: Timer = $PourRate
@onready var cauldron: Node2D = $Cauldron


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.current_customer.new_customer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Checks to see if should start pour
	if GameManager.held_item == null:
		return
	if GameManager.pouring and pour_rate.is_stopped():
		pour_rate.start()
	elif not GameManager.pouring and not pour_rate.is_stopped():
		pour_rate.stop()
		
		
func update_time():
	if GameManager.current_time >= 18:
		GameManager.day_active = false
		$Clock/TimeSpeed.stop()
		$"Day End".visible = true
		$"Day End/Happy".text = str(GameManager.happy_customers_today)
		$"Day End/Total".text = str(GameManager.happy_customers_today + GameManager.upset_customers_today)
		GameManager.happy_customers_today = 0
		$"Day End/Upset".text = str(GameManager.upset_customers_today)
		GameManager.upset_customers_today = 0
		
		$"Day End/Income".text = str(GameManager.total_money_today)
		GameManager.total_money_today = 0
		$"Day End/Day".text = str(GameManager.current_day)
		return
	GameManager.current_time += 1
	$Clock.text = str(GameManager.current_time) + ":00"

func _on_pour_rate_timeout() -> void:
	if GameManager.held_item == null:
		return
	if GameManager.held_item.potion_type == GameManager.PotionType.EMPTY:
		if cauldron.contents.is_empty():
			return
		GameManager.held_item.fill_potion()
		GameManager.held_item.color = cauldron.color
		GameManager.held_item.potion_type = GameManager.PotionType.EMPTY
		GameManager.held_item.potion = null
		GameManager.held_item.modulate = cauldron.color
		cauldron.empty_into_potion(GameManager.held_item)
	elif GameManager.held_item.amount > 0:
		cauldron.changeSprite(1)
		GameManager.held_item.pour_potion()
		cauldron.add_contents(GameManager.held_item.potion_type)
		cauldron.change_color(GameManager.held_item.color)


func refill_potions():
	for i in range(4):
		$Bottles/Bottle.fill_potion()
		$Bottles/Bottle2.fill_potion()
		$Bottles/Bottle3.fill_potion()
		$Bottles/Bottle5.fill_potion()


func _enlarge_recipe_sheet() -> void:
	if GameManager.held_item == null:
		$"Recipe Sheet".scale = Vector2(2.5,2.5)
		$"Recipe Sheet".z_index = 10
func _shrink_recipe_sheet() -> void:
	$"Recipe Sheet".scale = Vector2(1,1)
	$"Recipe Sheet".z_index = 1


func _start_next_day() -> void:
	GameManager.day_active = true
	$Clock/TimeSpeed.start()
	$Customer.new_customer()
	GameManager.current_day += 1
	GameManager.current_time = 8
	$Clock.text = str(GameManager.current_time) + ":00"
	$"Day End".visible = false


func _on_time_speed_timeout() -> void:
	update_time()


func _on_buy_refills_pressed() -> void:
	if GameManager.money >= 10:
		GameManager.money -= 10
		$Money.text = "$" + str(GameManager.money)
		$"Potion Bag".fill_bag()
		$"Potion Bag2".fill_bag()
	else:
		return


func _buy_2nd_potion_bag() -> void:
	if GameManager.money >= 25:
		GameManager.money -= 25
		$"Potion Bag2".visible = true
		$"Day End/Buy Refills2".queue_free()


func _return_to_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
