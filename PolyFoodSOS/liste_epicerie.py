import sqlite3

def create_table_liste_epicerie():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    
    curseur.execute("""
        CREATE TABLE IF NOT EXISTS liste_epicerie (
            code_product INTEGER PRIMARY KEY,
            name_product TEXT,
            quantity FLOAT,
            FOREIGN KEY (code_product) REFERENCES liste_produit(code_product) 
        )
    """)

    db.commit()
    db.close()

def add_produit(code_product, quantity):
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    
    # Correction de la requête SELECT
    curseur.execute("""
        SELECT name_product FROM liste_produit WHERE code_product = ?
    """, (code_product,))

    # Récupération du résultat de la requête
    result = curseur.fetchone()

    if result:
        # Si le produit avec le code spécifié existe, ajouter à la table liste_epicerie
        name_product = result[0]
        curseur.execute("""
            INSERT INTO liste_epicerie (code_product, name_product, quantity)
            VALUES (?, ?, ?)
        """, (code_product, name_product, quantity))
        db.commit()
    else:
        print("Le produit avec le code spécifié n'existe pas dans la table liste_produit.")

    db.close()

def main(code_product, quantity):
    create_table_liste_epicerie()

    # Exemple d'utilisation de la fonction add_produit
    add_produit(code_product, quantity)


if __name__ == "__main__":
    main()
