-- Table des utilisateurs du systeme 
CREATE TABLE "Utilisateurs"(
    "id_user" BIGINT NOT NULL,              -- Identifiant unique de l'utilisateur
    "prenom" VARCHAR(255) NOT NULL,         -- Prenom de l'utilisateur
    "nom" VARCHAR(255) NOT NULL,            -- Nom de l'utilisateur
    "email" VARCHAR(255) NOT NULL,          -- Adresse email unique de l'utilisateur
    "mot_de_passe" VARCHAR(255) NOT NULL,   -- Mot de passe (hashe)
    "telephone" BIGINT NOT NULL,            -- Numero de telephone unique
    "addresse" VARCHAR(255) NOT NULL,       -- Adresse associee a un lieu
    "recompense" BIGINT NOT NULL            -- Identifiant du niveau de recompense
);
-- Ajout de la cle primaire a la table Utilisateurs
ALTER TABLE
    "Utilisateurs" ADD PRIMARY KEY("id_user");

-- Ajout de contraintes d'unicite pour l'email et le telephone
ALTER TABLE
    "Utilisateurs" ADD CONSTRAINT "utilisateurs_email_unique" UNIQUE("email");
ALTER TABLE
    "Utilisateurs" ADD CONSTRAINT "utilisateurs_telephone_unique" UNIQUE("telephone");

-- Table des trajets disponibles dans le systeme
CREATE TABLE "Trajets"(
    "id_trajet" BIGINT NOT NULL,            -- Identifiant unique du trajet
    "id_lieu_arrivee" VARCHAR(255) NOT NULL,-- Lieu d'arrivee (reference vers Lieu)
    "id_lieu_depart" VARCHAR(255) NOT NULL, -- Lieu de depart (reference vers Lieu)
    "date_arrive" DATE NOT NULL,            -- Date d'arrivee prevue
    "date_depart" DATE NOT NULL,            -- Date de depart prevue
    "nombre_passager" INTEGER NOT NULL,     -- Nombre de passagers pour le trajet
    "prix" DECIMAL(8, 2) NOT NULL,          -- Prix du trajet
    "statut_trajet" VARCHAR(255) NOT NULL   -- Statut du trajet (ex: "actif", "annule")
);

-- Ajout de la cle primaire a la table Trajets
ALTER TABLE
    "Trajets" ADD PRIMARY KEY("id_trajet");

-- Table des vehicules associes aux utilisateurs
CREATE TABLE "Voitures"(
    "id_voiture" BIGINT NOT NULL,           -- Identifiant unique du vehicule
    "id_user" BIGINT NOT NULL,              -- Identifiant de l'utilisateur proprietaire
    "modele" VARCHAR(255) NOT NULL,         -- Modele du vehicule
    "couleur" VARCHAR(255) NOT NULL,        -- Couleur du vehicule
    "immatriculation" VARCHAR(255) NOT NULL,-- Plaque d'immatriculation unique
    "capacite" INTEGER NOT NULL             -- Capacite maximale en passagers
);

-- Ajout de la cle primaire a la table Voitures
ALTER TABLE
    "Voitures" ADD PRIMARY KEY("id_voiture");

-- Ajout d'une contrainte d'unicite pour l'immatriculation
ALTER TABLE
    "Voitures" ADD CONSTRAINT "voitures_immatriculation_unique" UNIQUE("immatriculation");

-- Table des transactions financieres
CREATE TABLE "Transaction"(
    "id_transaction" BIGINT NOT NULL,       -- Identifiant unique de la transaction
    "id_user" BIGINT NOT NULL,              -- Reference a l'utilisateur effectuant la transaction
    "id_trajet" BIGINT NOT NULL,            -- Reference au trajet concerne
    "montant" DECIMAL(8, 2) NOT NULL,       -- Montant de la transaction
    "date" DATE NOT NULL,                   -- Date de la transaction
    "mode_paiment" VARCHAR(255) NOT NULL    -- Mode de paiement (ex: "CB", "PayPal")
);

-- Ajout de la cle primaire a la table Transaction
ALTER TABLE
    "Transaction" ADD PRIMARY KEY("id_transaction");

-- Table des evaluations des trajets
CREATE TABLE "evaluation"(
    "id_evaluation" BIGINT NOT NULL,        -- Identifiant unique de l'evaluation
    "id_evaluee" BIGINT NOT NULL,           -- Reference a l'utilisateur evalue
    "id_evaluateur" BIGINT NOT NULL,        -- Reference a l'utilisateur evaluateur
    "id_trajet" BIGINT NOT NULL,            -- Reference au trajet concerne
    "note" INTEGER NOT NULL,                -- Note attribuee
    "commentaire" VARCHAR(255) NOT NULL,    -- Commentaire de l'evaluateur
    "date" DATE NOT NULL                    -- Date de l'evaluation
);

-- Ajout de la cle primaire a la table evaluation
ALTER TABLE
    "evaluation" ADD PRIMARY KEY("id_evaluation");

-- Table pour stocker l'historique des trajets des utilisateurs
CREATE TABLE "historique_trajet"(
    "id_historique" BIGINT NOT NULL,        -- Identifiant unique de l'entree historique
    "id_user" BIGINT NOT NULL,              -- Reference a l'utilisateur
    "id_trajet" BIGINT NOT NULL             -- Reference au trajet
);

-- Ajout de la cle primaire a la table historique_trajet
ALTER TABLE
    "historique_trajet" ADD PRIMARY KEY("id_historique");

-- Table des roles des utilisateurs dans un trajet
CREATE TABLE "Role"(
    "id_role" BIGINT NOT NULL,              -- Identifiant unique du role
    "id_user" BIGINT NOT NULL,              -- Reference a l'utilisateur
    "id_trajet" BIGINT NOT NULL,            -- Reference au trajet
    "role_utilisateur" VARCHAR(255) NOT NULL-- Role (ex: "conducteur", "passager")
);

-- Ajout de la cle primaire a la table Role
ALTER TABLE
    "Role" ADD PRIMARY KEY("id_role");

-- Ajout d'une contrainte d'unicite pour les roles
ALTER TABLE
    "Role" ADD CONSTRAINT "role_role_utilisateur_unique" UNIQUE("role_utilisateur");

-- Table des lieux geographiques
CREATE TABLE "Lieu"(
    "id_lieu" BIGINT NOT NULL,              -- Identifiant unique du lieu
    "addresse" VARCHAR(255) NOT NULL,       -- Adresse complete
    "ville" VARCHAR(255) NOT NULL,          -- Ville du lieu
    "code_postal" VARCHAR(255) NOT NULL     -- Code postal
);

-- Ajout de la cle primaire a la table Lieu
ALTER TABLE
    "Lieu" ADD PRIMARY KEY("id_lieu");

-- Ajout d'une contrainte d'unicite pour le code postal
ALTER TABLE
    "Lieu" ADD CONSTRAINT "lieu_code_postal_unique" UNIQUE("code_postal");

-- Table des niveaux de recompense
CREATE TABLE "Echellon_recompense"(
    "id_echellon" BIGINT NOT NULL,          -- Identifiant unique de l'echelon
    "nom_echellon" VARCHAR(255) NOT NULL,   -- Nom de l'echelon
    "recompense" BIGINT NOT NULL            -- Recompense associee
);

-- Ajout de la cle primaire a la table Echellon_recompense
ALTER TABLE
    "Echellon_recompense" ADD PRIMARY KEY("id_echellon");

-- Ajout de contraintes d'unicite pour les noms et recompenses
ALTER TABLE
    "Echellon_recompense" ADD CONSTRAINT "echellon_recompense_nom_echellon_unique" UNIQUE("nom_echellon");
ALTER TABLE
    "Echellon_recompense" ADD CONSTRAINT "echellon_recompense_recompense_unique" UNIQUE("recompense");

-- Ajout des cles etrangeres pour assurer la coherence des relations
ALTER TABLE
    "Trajets" ADD CONSTRAINT "trajets_id_lieu_depart_foreign" FOREIGN KEY("id_lieu_depart") REFERENCES "Lieu"("id_lieu");
ALTER TABLE
    "Transaction" ADD CONSTRAINT "transaction_id_user_foreign" FOREIGN KEY("id_user") REFERENCES "Utilisateurs"("id_user");
ALTER TABLE
    "historique_trajet" ADD CONSTRAINT "historique_trajet_id_user_foreign" FOREIGN KEY("id_user") REFERENCES "Utilisateurs"("id_user");
ALTER TABLE
    "Utilisateurs" ADD CONSTRAINT "utilisateurs_addresse_foreign" FOREIGN KEY("addresse") REFERENCES "Lieu"("id_lieu");
ALTER TABLE
    "evaluation" ADD CONSTRAINT "evaluation_id_trajet_foreign" FOREIGN KEY("id_trajet") REFERENCES "Trajets"("id_trajet");
ALTER TABLE
    "Transaction" ADD CONSTRAINT "transaction_id_trajet_foreign" FOREIGN KEY("id_trajet") REFERENCES "Trajets"("id_trajet");
ALTER TABLE
    "Trajets" ADD CONSTRAINT "trajets_id_lieu_arrivee_foreign" FOREIGN KEY("id_lieu_arrivee") REFERENCES "Lieu"("id_lieu");
ALTER TABLE
    "Role" ADD CONSTRAINT "role_id_user_foreign" FOREIGN KEY("id_user") REFERENCES "Utilisateurs"("id_user");
ALTER TABLE
    "evaluation" ADD CONSTRAINT "evaluation_id_evaluateur_foreign" FOREIGN KEY("id_evaluateur") REFERENCES "Utilisateurs"("id_user");
ALTER TABLE
    "Utilisateurs" ADD CONSTRAINT "utilisateurs_recompense_foreign" FOREIGN KEY("recompense") REFERENCES "Echellon_recompense"("id_echellon");
ALTER TABLE
    "historique_trajet" ADD CONSTRAINT "historique_trajet_id_trajet_foreign" FOREIGN KEY("id_trajet") REFERENCES "Trajets"("id_trajet");
ALTER TABLE
    "Voitures" ADD CONSTRAINT "voitures_id_user_foreign" FOREIGN KEY("id_user") REFERENCES "Utilisateurs"("id_user");
ALTER TABLE
    "Role" ADD CONSTRAINT "role_id_trajet_foreign" FOREIGN KEY("id_trajet") REFERENCES "Trajets"("id_trajet");
ALTER TABLE
    "evaluation" ADD CONSTRAINT "evaluation_id_evaluee_foreign" FOREIGN KEY("id_evaluee") REFERENCES "Utilisateurs"("id_user");

CREATE OR REPLACE FUNCTION ConfirmerAjoutTrajet()
RETURNS BOOLEAN
LANGUAGE plpgsql AS
$$
BEGIN
    IF NEW.date_arrive < CURRENT_DATE THEN
        RETURN FALSE; -- La date du trajet est dans le passé
    ELSE
        RETURN TRUE; -- La date du trajet est valide (présente ou future)
    END IF;
END
$$;

CREATE OR REPLACE TRIGGER VerifierDateTrajet
BEFORE INSERT ON Trajets
FOR EACH ROW
EXECUTE FUNCTION ConfirmerAjoutTrajet();

--Unitests:
--Passe
INSERT INTO Trajets (id_trajet, id_lieu_depart, id_lieu_arrivee, date_arrive, nombre_passager, prix, statut_trajet, id_user)
VALUES (1, 'Montreal', 'Sherbrooke', '2023-12-01', 4, 50.00, 'actif', 1);

--Futur
INSERT INTO Trajets (id_trajet, id_lieu_depart, id_lieu_arrivee, date_arrive, nombre_passager, prix, statut_trajet, id_user)
VALUES (2, 'Sherbrooke', 'Montreal', '2025-12-01', 4, 50.00, 'actif', 1);



--Un trigger qui sert à ajouter un trajet à l'historique des trajets. Gère 2 tableaux.

CREATE OR REPLACE FUNCTION AjouterHistoriqueTrajet()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    -- Ajoute un enregistrement dans la table historique_trajet après l'insertion du trajet
    INSERT INTO historique_trajet (id_user, id_trajet)
    VALUES (NEW.id_user, NEW.id_trajet);

    -- Retourne NEW pour maintenir l'intégrité de l'insertion
    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER Trigger_AfterInsert_AjouterHistorique
AFTER INSERT ON Trajets
FOR EACH ROW
EXECUTE FUNCTION AjouterHistoriqueTrajet();

--Unitests:

INSERT INTO Trajets (id_trajet, id_lieu_depart, id_lieu_arrivee date_arrive, nombre_passager, prix, statut_trajet, id_user)
VALUES (1, 'Sherbrooke', 'New York', '2024-12-01', 4, 50.00, 'actif', 2);
VALUES (2, 'Sherbrooke', 'New York', '2024-12-02', 4, 50.00, 'actif', 2);

SELECT * FROM historique_trajet;


--Une fonction qui permet de calculer la moyenne de l'evaluation trajet.
DELIMITER $$
CREATE FUNCTION calculer_moyenne_evaluation(id_trajet BIGINT)
RETURNS DECIMAL(3, 2)
DETERMINISTIC
BEGIN
   	    DECLARE moyenne DECIMAL(3, 2);
    	    SELECT AVG(note) INTO moyenne
   	    FROM evaluation
   	    WHERE id_trajet = id_trajet;
    	    RETURN moyenne;
END $$
DELIMITER ;

--Unitest:
INSERT INTO evaluation (id_evaluation, id_evaluee, id_evaluateur, id_trajet, note, commentaire, date)
VALUES 
    (1, 101, 102, 1001, 4, 'Bon trajet', '2024-12-10'),
    (2, 101, 103, 1001, 5, 'Excellent trajet', '2024-12-11'),
    (3, 101, 104, 1001, 3, 'Satisfaisant', '2024-12-12');

-- Test : Calculer la moyenne des évaluations pour le trajet 1001
SELECT calculer_moyenne_evaluation(1001) AS moyenne;

--On s'attend a avoir: La moyenne devrait être (4 + 5 + 3) / 3 = 4.00

-- Test cas limite: Calculer la moyenne pour un trajet qui n’existe pas
SELECT calculer_moyenne_evaluation(9999) AS moyenne;

--On s’attend a avoir: NULL ou une valeur par défaut

--Une fonction qui ajoute une evaluation.
DELIMITER $$
CREATE PROCEDURE ajouter_evaluation(
    IN p_id_trajet BIGINT,
    IN p_id_evaluee BIGINT,
    IN p_id_evaluateur BIGINT,
    IN p_note INT,
    IN p_commentaire VARCHAR(255)
)
BEGIN
    INSERT INTO evaluation (id_trajet, id_evaluee, id_evaluateur, note, commentaire, date)
    VALUES (p_id_trajet, p_id_evaluee, p_id_evaluateur, p_note, p_commentaire, CURDATE());
END $$
DELIMITER ;

-- Appel de fonction pour ajouter une evaluation
CALL ajouter_evaluation(1002, 201, 202, 4, 'Très bon trajet');

-- Ajout de l'évaluation
SELECT * FROM evaluation WHERE id_trajet = 1002 AND id_evaluee = 201;

-- On s’attend a avoir: Une ligne avec les détails {id_trajet: 1002, id_evaluee: 201, id_evaluateur: 202, note: 4, commentaire: 'Très bon trajet'}

-- Tentative d'ajouter une évaluation avec une note invalide (par exemple, 6, hors de l'échelle 1-5)
CALL ajouter_evaluation(1003, 203, 204, 6, 'Note invalide');

-- Vérification : La contrainte sur la note doit empêcher l'ajout
SELECT * FROM evaluation WHERE id_trajet = 1003 AND id_evaluee = 203;

-- on s’attend : Aucune ligne ne doit être insérée, et une erreur de contrainte doit être générée.
