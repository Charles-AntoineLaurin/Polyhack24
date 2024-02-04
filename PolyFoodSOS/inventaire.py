import sqlite3
import json

def create_inventory_table():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()

    curseur.execute("""
        CREATE TABLE IF NOT EXISTS inventory (
            username TEXT PRIMARY KEY,
            info_product TEXT,
            code_product INTEGER
        )
    """)

    db.commit()
    db.close()

def insert_and_update_inventory(username, info_product, code_product):
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    # Convertir le tuple en chaîne JSON
    info_product_json = json.dumps(info_product)
    
    curseur.execute("""
        INSERT INTO inventory (username, info_product, code_product)
        VALUES (?, ?, ?)
    """, (username, info_product_json, code_product))

    db.commit()
    db.close()

def main(username, info_product, code_product):
    create_inventory_table()
    insert_and_update_inventory(username, info_product, code_product)

if __name__ == "__main__":
    #username = 't135'
    #code_products = 123
    #info_product = ('apple', '2', '08/02/2024')

    # Appel de la fonction principale
    main(username, info_product, code_products=123)