/*1-	Liste des contacts français */
SELECT CompanyName AS 'Société', ContactName AS 'contact', ContactTitle AS 'Fonction', Phone AS 'Téléphone' FROM customers /*Lire les colonnes CompanyName, ContactName, ContactTitle, Phone de la table customers*/
WHERE Country = 'France' ; /*Extraction des lignes qui respectent la condition "Country = 'France'"*/


/*2 - Produits vendus par le fournisseur « Exotic Liquids » */
SELECT ProductName AS 'Produit', UnitPrice AS 'Prix' FROM products /*Lire la colonne ProductName de la table products */
JOIN suppliers ON products.SupplierID=suppliers.SupplierID /* Association de la table suppliers*/
WHERE CompanyName = 'Exotic Liquids' ; /*Extraction des lignes qui respectent la condition "CompanyName = 'Exotic Liquids' "*/

/*3 - Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant */
SELECT CompanyName AS 'Fournisseur', COUNT(ProductID) AS 'Nbre_produits' FROM suppliers /*Lire le colonne "CompanyName" et le compte de la colonne "ProductID" de la table suppliers */
JOIN products ON products.SupplierID=suppliers.SupplierID /* Association de la table products*/
WHERE Country = 'France' /*Extraction des lignes qui respectent la condition "Country = 'France'"*/
GROUP BY CompanyName /*Regroupement par "CompanyName "*/
ORDER BY Nbre_produits DESC; /*Trie de "Nbre_produits" par ordre descendant*/


/*4 - Liste des clients Français ayant plus de 10 commandes */
SELECT CompanyName AS 'Client', COUNT(OrderID) AS 'Nbre_commandes' FROM customers /*Lire la colonne "CompanyName" et le compte de la colonne "OrderID" de la table customers */
JOIN orders ON customers.CustomerID=orders.CustomerID /* Association de la table orders*/
WHERE Country = 'France' /*Extraction des lignes qui respectent la condition "Country = 'France'"*/
GROUP BY CompanyName /*Regroupement par "CompanyName"*/
HAVING COUNT(OrderID)>10 ; /*Filtre avec la fonction COUNT la colonne "OrderID" supérieur à 10*/

/*5 - Liste des clients ayant un chiffre d’affaires > 30.000 */
SELECT CompanyName AS 'Client', SUM(UnitPrice*Quantity) AS 'CA', Country AS 'Pays' FROM `order details`AS orderDetails /*Lire la colonne "CompanyName" et la somme de la table oders détails */
JOIN orders ON orderDetails.OrderID=orders.OrderID /* Association de la table orders*/
JOIN customers ON customers.CustomerID=orders.CustomerID /* Association de la table customers*/
GROUP BY CompanyName /*Regroupement par "CompanyName"*/
HAVING CA>30000.000 /*Filtre du "CA" supérieur à 30000000*/
ORDER BY CA DESC; /*Trie de "CA" par ordre descendant*/

/*6 – Liste des pays dont les clients ont passé commande de produits fournis par "Exotic Liquids" */
SELECT customers.Country FROM customers /*Lire les colonnes "Country" de la table customers */
JOIN orders ON customers.CustomerID=orders.CustomerID /* Association de la table orders*/
JOIN `order details`AS orderDetails ON orderDetails.OrderID=orders.OrderID /* Association de la table orders details*/
JOIN products ON orderDetails.ProductID=products.ProductID /* Association de la table products*/
JOIN suppliers ON products.SupplierID=suppliers.SupplierID /* Association de la table suppliers*/
WHERE suppliers.CompanyName = 'Exotic Liquids' /*Extraction des lignes qui respectent la condition "CompanyName = 'Exotic Liquids'"*/
GROUP BY Country /*Regroupement par "Country"*/
ORDER BY Country ASC; /*Trie de "Country" par ordre ascendant*/

/*7 – Montant des ventes de 1997 */
SELECT SUM(UnitPrice*Quantity) AS 'Montant Ventes 97' FROM `order details` AS orderDetails /*Lire la somme de la table oders détails */
JOIN orders ON orderDetails.OrderID=orders.OrderID /* Association de la table orders*/
WHERE (SUBSTR(OrderDate, 1, 4)) ='1997'; /*Extraction des lignes qui respectent la condition 


/*8 – Montant des ventes de 1997 mois par mois */
SELECT MONTH(SUBSTR(OrderDate, 1, 10)) AS 'Mois', SUM(UnitPrice*Quantity) AS 'Montant Ventes' FROM `order details` AS orderDetails /*Lire la somme et les mois de la table oders détails */
JOIN orders ON orderDetails.OrderID=orders.OrderID /* Association de la table orders*/
WHERE (SUBSTR(OrderDate, 1, 4)) ='1997' /*Extraction des lignes qui respectent la condition ligne "OrderDate" segmenté ='1997'*/
GROUP BY Mois /*Regroupement par "Mois"*/
ORDER BY Mois ASC;

/*9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ? */
SELECT Max(OrderDate) AS 'Date de dernière commande' FROM customers /*Lire le maximum des dates de commandes de la table customers */
JOIN orders ON customers.CustomerID=orders.CustomerID /* Association de la table orders*/
WHERE CompanyName ='Du monde entier';  /*Extraction des lignes qui respectent la condition "CompanyName = 'Du monde entier'"*/


/*10 – Quel est le délai moyen de livraison en jours ?*/
SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Délai moyen de livraison en jours' FROM orders;  /*Lire la date moyenne arrondie de la table order*/
