extends Node

enum PotionType { RED, BLUE, GREEN, EMPTY, YELLOW}
var held_item = null
var pouring = false
var current_customer = null
var money = 0
var current_time = 8
var happy_customers_today = 0
var upset_customers_today = 0
var total_money_today = 0
var current_day = 1
var day_active = true

var all_recipes: Array[PotionRecipe] = [
	preload("res://potions/health_potion.tres"),
	preload("res://potions/energy_potion.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func identify_potion(contents: Dictionary) -> PotionRecipe:
	for recipe in all_recipes:
		if ingredients_match(contents, recipe.ingredients):
			return recipe
	return null

func ingredients_match(dict: Dictionary, recipe_ingredients: Array[IngredientAmount]) -> bool:
	  # Check same number of ingredient types
	if dict.size() != recipe_ingredients.size():
		return false

	  # Check each recipe ingredient exists with correct amount
	for ing in recipe_ingredients:
		if not dict.has(ing.type):
			return false
		if dict[ing.type] != ing.amount:
			return false

	return true
