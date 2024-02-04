import user
import inventaire
import produit
import liste_epicerie
import sqlite3
import json
def main():
    username = user.main()
    produit.main()

    # Sélectionner la recette
    # Demander les produits disponibles
    dispo = []
    produit1=[]
    code_products1=[]
    date_dexp='7j'
    
    while True:
        produit_dispo =str(input('Le produit disponible : '))
        produit1.append(produit_dispo)
        quantite_dispo = input("Quantité disponible : ")
        date_dexp = input("Quelle est la date d'expiration du produit (format jour/mois/année) : ")
        request = input('Tu as encore des produits? (oui/non) ')
        dispo.append((produit_dispo,quantite_dispo,date_dexp))
        if request.lower() != 'oui':
            break

    inventaire.main(username, dispo, code_product=123)

    # liste_epicerie.main()

if __name__ == "__main__":
    main()
