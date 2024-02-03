from pydantic import BaseModel
from typing import List, AnyStr


class TrouverRecette(BaseModel):
    list_ingredients: List[str] = None


class AjouterIngredients(BaseModel):
    nom: str
    _id: str
    quantite: str


class AjouterPlanification(BaseModel):
    id_recette: int
    date: str
