# 4a-isi-projet-db
Base de données pour le tp 5 de ISI


Schéma pour conception de BDD (via Draw.io) :

<img width="564" height="499" alt="image" src="https://github.com/user-attachments/assets/1b365dae-fef5-4f7a-8155-b12281405d3a" />



Base de données minimaliste pour le projet d'ISI, comportant la table user qui définit l'utilisateur, la table order, reliée à l'utilisateur et à l'ensemble des éléments dans la commande de l'utilisateur, chaque élément de order (order_line) peut être soit un produit, soit un menu, dans ce cas ce dernier sera relié à l'ensemble des produits qu'il contient via la table de liaison menu_product.
La table closure_day correspond à la liste des jours de fermeture renseigné par les gérants.

Lien vers le Frontend : https://github.com/timy0139/4a-isi-projet-front

Lien vers le Backend : https://github.com/timy0139/4a-isi-projet-back

