from ast import List
import requests


# yes we don't care about safety in that case
AUTH="?apiKey=41060f320bce43e58f5908ffca8dde76"

RECIPE_URL = "https://api.spoonacular.com/recipes/complexSearch"

def getInformationsFromUrl(url: str):
    return (requests.get(url+AUTH)).json()

def getRecipesWithIngredients(ingredients: List[str]):
    include_ingredients = "?includeIngredients=" + ",".join(ingredients)
    return (requests.get(RECIPE_URL+ include_ingredients +AUTH)).json()