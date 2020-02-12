/*1-	Liste des contacts français */
SELECT CompanyName AS 'Société', ContactName AS 'contact', ContactTitle AS 'Fonction', Phone AS 'Téléphone' FROM customers /*Lire Société, contact, Fonction, Téléphone de la table customers*/
WHERE Country = 'France' ;


/*2 - Produits vendus par le fournisseur « Exotic Liquids » */
SELECT ProductName AS 'Produit', UnitPrice AS 'Prix' FROM products /*Lire la colonne ProductName des tables products, suppliers */
JOIN suppliers ON products.SupplierID=suppliers.SupplierID
WHERE CompanyName = 'Exotic Liquids' ;

/*3 - Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant */
SELECT CompanyName AS 'Fournisseur', COUNT(ProductID) AS 'Nbre_produits' FROM suppliers /*Lire les colonnes des tables products, suppliers */
JOIN products ON products.SupplierID=suppliers.SupplierID
WHERE Country = 'France'
GROUP BY CompanyName
ORDER BY Nbre_produits DESC;


/*4 - Liste des clients Français ayant plus de 10 commandes */
SELECT CompanyName AS 'Client', COUNT(OrderID) AS 'Nbre_commandes' FROM customers /*Lire les colonnes des tables orders, customers */
JOIN orders ON customers.CustomerID=orders.CustomerID
WHERE Country = 'France'
GROUP BY CompanyName
HAVING COUNT(OrderID)>10 ;

/*5 - Liste des clients ayant un chiffre d’affaires > 30.000 */
SELECT CompanyName AS 'Client', SUM(UnitPrice*Quantity) AS 'CA', Country AS 'Pays' FROM `order details`AS orderDetails /*Lire la colonne CompanyName et la somme des tables oders détails,orders, customers  */
JOIN orders ON orderDetails.OrderID=orders.OrderID
JOIN customers ON customers.CustomerID=orders.CustomerID
GROUP BY CompanyName
HAVING CA>30000.000
ORDER BY CA DESC;

/*6 – Liste des pays dont les clients ont passé commande de produits fournis par « Exotic Liquids » */
SELECT customers.Country FROM customers /*Lire les colonnes pays des tables customers, products, oders détails, oders */
JOIN orders ON customers.CustomerID=orders.CustomerID
JOIN `order details`AS orderDetails ON orderDetails.OrderID=orders.OrderID
JOIN products ON orderDetails.ProductID=products.ProductID
JOIN suppliers ON products.SupplierID=suppliers.SupplierID
WHERE suppliers.CompanyName = 'Exotic Liquids'
GROUP BY Country
ORDER BY Country ASC;

/*7 – Montant des ventes de 1997 */
SELECT SUM(UnitPrice*Quantity) AS 'Montant Ventes 97' FROM `order details` AS orderDetails /*Lire la somme de la table oders détails */
JOIN orders ON orderDetails.OrderID=orders.OrderID
WHERE (SUBSTR(OrderDate, 1, 4)) ='1997';


/*8 – Montant des ventes de 1997 mois par mois */
SELECT MONTH(SUBSTR(OrderDate, 1, 10)) AS 'Mois', SUM(UnitPrice*Quantity) AS 'Montant Ventes' FROM `order details` AS orderDetails /*Lire la somme et les mois de la table oders détails */
JOIN orders ON orderDetails.OrderID=orders.OrderID
WHERE (SUBSTR(OrderDate, 1, 4)) ='1997'
GROUP BY Mois
ORDER BY Mois ASC;

/*9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ? */
SELECT Max(OrderDate) AS 'Date de dernière commande' FROM customers /*Lire le maximum des dates de commandes de la table customers */
JOIN orders ON customers.CustomerID=orders.CustomerID
WHERE CompanyName ='Du monde entier'; 


/*10 – Quel est le délai moyen de livraison en jours ?*/
SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Délai moyen de livraison en jours' FROM orders;  /*Lire la date moyenne arrondie de la table order*/
