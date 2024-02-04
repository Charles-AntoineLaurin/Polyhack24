from typing import List
from pydantic import BaseModel


class Ingredients(BaseModel):
    ingredients: List[str]

