from fastapi import FastAPI
from models.request_body import *

app = FastAPI()


# ********* GET ************

@app.get("/")
def read_root():
    return {"message": "Hello, World!"}


@app.get("/food/{user_id}")
def read_inventory_user(user_id: int, query_param: str = None):
    # get food list from user_id
    # init default_values
    # for everyfood on the list: 
    # ajouter a la liste retournee
    return None  # return la liste finale


@app.get("/epicerie/{user_id}")
def read_epicerie_user(user_id: int, query_param: str = None):
    # get food list from user_id
    # init default_values
    # for everyfood on the list: 
    # ajouter a la liste retournee
    return None  # return la liste finale


@app.get("/recette/{user_id}")
def read_recette_user(user_id: int, query_param: str = None):
    # get recette_list from user_id
    # init default_values
    # for everyfood on the list: 
    # ajouter a la liste retournee
    return None  # return la liste finale


@app.get('/find/recette/{user_id}')
def trouver_recette(user_id: int, ingredients: TrouverRecette):
    # get les ingredients voulu
    return None


@app.get('/propose/recette/{user_id}')
def trouver_recette_inventaire(user_id: int):
    return None

@app.get('/propose/optimisation/{user_id}')
def optimiser_recette(user_id:int):
    return None

# ********* POSTS ************ 
@app.posts('/ajouter/ingredients/{user_id}')
def ajouter_ingredients(user_id: int, ingredient: AjouterIngredients):
    return None


@app.posts('/ajouter/planification/{user_id}')
def ajouter_planification(user_id: int, recette: AjouterPlanification):
    return None

# ********* Exemples ************ 

@app.get("/items/{item_id}")
def read_item(item_id: int, query_param: str = None):
    return {"item_id": item_id, "query_param": query_param}


@app.post("/items/")
def create_item(item: dict):
    # Logique pour créer un nouvel élément
    return {"item": item}
