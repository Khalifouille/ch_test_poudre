# Gestion des Douilles et Test de Poudre pour FiveM

Ce script ajoute une mécanique réaliste de gestion des tirs et de lavage des mains dans votre serveur FiveM, permettant notamment d'utiliser des tests de poudre pour détecter si un joueur a récemment tiré avec une arme.

## Fonctionnalités

### Client-side

- **Détection de tir :**
  - Lorsque le joueur tire, un état est enregistré pour indiquer qu'il a récemment utilisé une arme.
  
- **Commande `/selaver` :**
  - Permet de laver ses mains si le joueur est près de l'eau et possède du savon dans son inventaire.

- **Commande `/poudretest` :**
  - Permet d'utiliser un test de poudre sur un autre joueur pour vérifier s'il a récemment tiré.
  
### Server-side

- **Gestion de l'état de tir :**
  - Enregistre si un joueur a tiré récemment.
  - L'état de tir d'un joueur est automatiquement réinitialisé après une heure (3600 secondes).

- **Vérification et utilisation d'objets :**
  - Vérifie la présence d'un test de poudre ou de savon dans l'inventaire du joueur avant de permettre une interaction.
  - Retire l'objet correspondant après utilisation.

## Objets

Les objets nécessaires pour le script doivent être définis dans la base de données de votre ressource **ox_inventory**. Voici les configurations à ajouter :

```lua
-- Douille
["douille"] = {
    label = "Douille",
    weight = 1,
    stack = false,
    close = true,
    client = {
        image = 'douille.png',
    },
},

-- Test de poudre
["test_de_poudre"] = {
    label = "Test de poudre",
    weight = 1,
    stack = false,
    close = true,
    client = {
        image = 'test_de_poudre.png',
    },
},

-- Savon
["savon"] = {
    label = "Savon",
    weight = 1,
    stack = false,
    close = true,
    client = {
        image = 'savon.png',
    },
},
