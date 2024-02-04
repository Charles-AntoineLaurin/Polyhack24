import sqlite3

def create_table_recette():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    
    curseur.execute("""
        CREATE TABLE IF NOT EXISTS recette (
            id INTEGER PRIMARY KEY,
            name_recette TEXT NOT NULL,
            ingredient JSON NOT NULL,
            code_product INTEGER NOT NULL,
            FOREIGN KEY (code_product) REFERENCES liste_produit(code_product) 
        )
    """)

    db.commit()
    db.close()

def compare_ingredient(name_product):
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    
    recette = []
    
    curseur.execute("""
        SELECT code_product FROM liste_produit WHERE name_product = ?
    """, (name_product,))

    # Récupération du résultat de la requête
    code_product = [row[0] for row in curseur.fetchall()]


    if code_product:
        # Si le produit avec le nom spécifié existe dans la table liste_produit
        # Insérer une nouvelle entrée dans la table recette
        curseur.execute("""
            INSERT INTO recette (name_recette, ingredient, code_product)
            VALUES (?, ?, ?)
        """, ("Nom de la recette", ingrediant, code_product[0]))  # Remplacez les valeurs par celles que vous avez

        db.commit()
    else:
        print("Le produit avec le nom spécifié n'existe pas dans la table liste_produit.")

    db.close()

def main(name_product):
    create_table_recette()

    # Exemple d'utilisation de la fonction compar_ingredient
    compar_ingredient(name_product)

if __name__ == "__main__":
    main()
