import sqlite3
import hashlib
import re
import produit

def create_user_table():
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()

    curseur.execute("""
        CREATE TABLE IF NOT EXISTS user (
            i INTEGER PRIMARY KEY,
            full_name TEXT NOT NULL,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            password BLOB NOT NULL,
            diete TEXT NOT NULL,
            intolerance TEXT NOT NULL
        )
    """)

    db.commit()
    db.close()

def validate_input(input_value):
    # Validation simple : autorise uniquement les caractères alphanumériques et quelques caractères spécifiques
    if re.match(r'^[\w\s@.-]+$', input_value):
            return True
    else:
        print("Entrée non valide. Utilisez uniquement des caractères alphanumériques et quelques caractères spécifiques.")
        return False
            
def validation_username(username):
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    curseur.execute("""
        SELECT username FROM user
        """)
    usernames=[row[0] for row in curseur.fetchall()]
    db.close()
    if username in usernames:
        return True
    else:
        return False
    


def insert_user(full_name, username, email, password, diete, intolerance):
    db = sqlite3.connect("compte.db")
    curseur = db.cursor()
    request_user = """
        INSERT INTO user (full_name, username, email, password, diete, intolerance)
        VALUES (?, ?, ?, ?, ?, ?)
    """
    hashed_password = hashlib.sha1(password.encode("utf-8")).hexdigest()

    curseur.execute(request_user, (full_name, username, email, hashed_password, diete, intolerance))

    db.commit()
    db.close()



def main():
    create_user_table()

    #faut voir comment récupérer depuis swift
    full_name = input('full_name:')

    while True:
        username = input('username:')
        if validation_username(username)==True:
            print('username already used')
        else:
            break
    email = input('email:')
    password = input("password:")
    diete = input('diete:')
    intolerance = input('intolerance:')
    #vérification qu'il n'y a pas d'injection sql
    if all(validate_input(value) for value in [full_name, username, email, password, diete, intolerance]):
        insert_user(full_name, username, email, password, diete, intolerance)

    return username
    
if __name__ == "__main__":
    main()