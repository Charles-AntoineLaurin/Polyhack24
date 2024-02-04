import sqlite3

def create_table_liste_produit():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    
    curseur.execute("""
        CREATE TABLE IF NOT EXISTS liste_produit (
            code_product INTEGER PRIMARY KEY,
            name_product TEXT NOT NULL
            
        )
    """)

    db.commit()
    db.close()

def insert_product():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()

    request_produit = """
        INSERT INTO liste_produit (code_product, name_product)
        VALUES (?, ?)
    """
    legumes = ["Oignons", "Ail", "Tomates", "Pommes de terre", "Carottes", "Poivrons rouges", "Poivrons verts", "Poivrons jaunes", "Courgettes", "Champignons", "Épinards", "Brocolis", "Haricots verts", "Céleri", "Concombres"]
    viande = ["Bœuf", "Poulet", "Porc", "Agneau", "Veau", "Canard", "Dinde", "saumon", "thon", "cabillaud", "truite", "crevettes", "moules", "calmars"]
    epice = ["Sel", "Poivre noir", "Paprika doux", "Paprika fumé", "Paprika fort", "Cumin", "Coriandre en poudre", "Curcuma", "Gingembre en poudre", "Cannelle", "Romarin séché"]
    code = [8279, 7619, 3550, 1776, 1421, 2843, 9572, 9653, 2470, 2123, 4793, 9314, 7785, 7746, 6304, 6073, 2181, 8497, 1037, 2152, 6754, 6410, 8963, 6786, 8928, 7471, 8090, 8898, 3414, 1267, 8346, 1178, 4066, 4133, 4332, 4278, 8833, 6608, 2876, 5610]
    ingredients = legumes + viande + epice
    ingredients = [i.lower() for i in ingredients]
    produit = dict(zip(code, ingredients))

    for h, k in produit.items():
        # Vérifier si le code_product existe déjà dans la table avant l'insertion
        curseur.execute("SELECT code_product FROM liste_produit WHERE code_product=?", (h,))
        existing_code = curseur.fetchone()

        if existing_code is None:
            # Si le code_product n'existe pas, alors faire l'insertion
            curseur.execute(request_produit, (h, k))

    db.commit()
    db.close()

def main():
    create_table_liste_produit()
    insert_product()

if __name__ == "__main__":
    main()
