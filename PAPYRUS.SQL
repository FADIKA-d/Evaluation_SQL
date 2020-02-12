DROP DATABASE IF EXISTS papyrus;
CREATE DATABASE papyrus;
USE papyrus;

DROP TABLE IF EXISTS PRODUIT;
CREATE TABLE PRODUIT 
(
    codart char(4) NOT NULL, 
    libart varchar(30) NOT NULL, 
    unimes char(5) NOT NULL,
    stkale int(10) NOT NULL, 
    stkphy int(10) NOT NULL, 
    qteann int(10) NOT NULL, 
    CONSTRAINT PK_PRODUIT PRIMARY KEY (codart)
);
DROP TABLE IF EXISTS FOURNIS;
CREATE TABLE FOURNIS 
(
    numfou int(10) NOT NULL, 
    nomfou varchar(25) NOT NULL, 
    ruefou varchar(25) NOT NULL,
    posfou char(5) NOT NULL, 
    vilfou varchar(30) NOT NULL, 
    confou varchar(15) NOT NULL,
    satisf tinyint(10),
    CONSTRAINT PK_FOURNIS PRIMARY KEY (numfou)
);
DROP TABLE IF EXISTS VENTE;
CREATE TABLE VENTE 
(
    numfou int(10) NOT NULL,
    codart char(4) NOT NULL,
    delliv smallint NOT NULL,
    qte1 int(10) NOT NULL,
    prix1 varchar(50) NOT NULL, 
    qte2 int(10), 
    prix2 varchar(50), 
    qte3 int(10), 
    prix3 varchar(50),
    CONSTRAINT PK_VENTE PRIMARY KEY (numfou,codart), 
    CONSTRAINT FK_VENTE_FOURNIS FOREIGN KEY (numfou) REFERENCES FOURNIS (numfou), 
    CONSTRAINT FK_VENTE_PRODUIT FOREIGN KEY (codart) REFERENCES PRODUIT (codart)
);
DROP TABLE IF EXISTS ENTCOM;
CREATE TABLE ENTCOM 
(
    numcom int(10) NOT NULL AUTO_INCREMENT,
    obscom varchar(50) ,
    datcom datetime NOT NULL,
    numfou int(10),
    CONSTRAINT PK_ENTCOM PRIMARY KEY (numcom),
    CONSTRAINT FK_ENTCOM_FOURNIS FOREIGN KEY (numfou) REFERENCES FOURNIS (numfou)
);
DROP TABLE IF EXISTS LIGCOM;
CREATE TABLE LIGCOM 
(
    numlig int(10) NOT NULL,
    numcom int(10) NOT NULL,
    codart char(4) NOT NULL,
    qtecde int(10) NOT NULL,
    priuni varchar(50) NOT NULL,
    qteliv int(10),
    derliv datetime NOT NULL,
    CONSTRAINT PK_LIGCOM PRIMARY KEY (numlig), 
    CONSTRAINT FK_LIGCOM_PRODUIT FOREIGN KEY (codart) REFERENCES PRODUIT (codart),
    CONSTRAINT FK_LIGCOM_ENTCOM FOREIGN KEY (numcom) REFERENCES ENTCOM (numcom)
); 
CREATE INDEX IX_ENTCOM_NUMFOU ON ENTCOM (numfou) ;