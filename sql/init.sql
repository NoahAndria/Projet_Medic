create table Patient(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE NOT NULL,
    CIN VARCHAR(20) NOT NULL,
    sexe VARCHAR(5) NOT NULL
);