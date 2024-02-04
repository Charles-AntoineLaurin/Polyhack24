from pydantic import BaseModel
import requests
from auth.auth import AUTH
from typing import List

from models.Recipe import Recipe


class FinderApi:
    endpoint = "https://api.spoonacular.com/recipes/findByIngredients"
    def FindFromIngredient(self, user: int, ingredients: List[str]) -> List[Recipe]: 
        ingredients = ",".join(ingredients)
        url = self.endpoint + f"?ingredients={ingredients}&{AUTH}"

        result = requests.get(url)
        if result.status_code == 200:
            data = result.json()
            recipe_list = []

            for recipe_data in data:
                recipe = Recipe(recipe_data["id"], recipe_data["image"], recipe_data["title"])
                recipe_list.append(recipe)

            return recipe_list

        return None

    