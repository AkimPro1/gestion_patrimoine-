# Guide d'Utilisation Exhaustif - Plateforme PATRIS

Bienvenue dans la documentation fonctionnelle complète de la plateforme **PATRIS**. Ce guide est conçu pour vous guider pas à pas à travers toutes les fonctionnalités de l'application, en détaillant chaque écran, formulaire, pop-up, bouton et l'action système associée.

---

## 🔑 1. Accès, URL et Comptes de Connexion

Pour accéder à l'application en mode local de développement, ouvrez votre navigateur et saisissez l'adresse suivante :
* **URL du Frontend** : `http://localhost:5173/`

### 👥 Comptes d'accès par défaut (Générés par les seeders de base de données)

Le système est configuré avec deux comptes d'accès pré-initialisés pour le développement et la validation :

1. **Compte Administrateur (ADMIN)**
   * **Nom d'utilisateur** : `akim`
   * **Mot de passe** : `00000000` (huit zéros)
   * **Rôle** : `ADMIN` (Accès total aux biens, aux mouvements de stock et à l'administration des utilisateurs).
   * **Double Authentification (2FA)** : Désactivée par défaut.

2. **Compte Super Administrateur (SUPERADMIN)**
   * **Nom d'utilisateur** : `brahim`
   * **Mot de passe** : `12345678`
   * **Rôle** : `SUPERADMIN` (Accès root, droit de configurer la sécurité générale et d'accéder au panneau d'audit).
   * **Double Authentification (2FA)** : Désactivée par défaut.

---

## 🖥️ 2. Module d'Authentification (LoginPage)

Cet écran est le point d'entrée sécurisé de la plateforme.

### Éléments d'interface & Actions
* **Formulaire d'identification** :
  * **Champ "Nom d'utilisateur"** (`username`) : Zone de saisie du login de l'agent.
  * **Champ "Mot de passe"** (`password`) : Zone de saisie masquée par défaut.
  * **Icône "Œil" (Afficher/Masquer)** : Permet de basculer l'affichage du mot de passe en clair.
  * **Case à cocher "Se souvenir de moi"** : Persiste la session dans le stockage local du navigateur.
  * **Lien "Mot de passe oublié ?"** : Redirige vers une procédure de récupération (contact administrateur).
* **Boutons d'Action** :
  * **Bouton "Se connecter"** (`submit`) : Valide les identifiants en appelant l'API `/api/auth/login`. Si les identifiants sont corrects et que la double authentification (2FA) n'est pas requise, redirige l'utilisateur vers la page `/biens`. Si le 2FA est activé, bascule vers l'étape de vérification de code.
  * **Bouton "Connexion SSO"** : Bouton de démonstration pour l'intégration future avec l'authentification unique de l'État.
* **Écran optionnel : Code de sécurité 2FA** :
  * **Grille de 6 chiffres (Code OTP)** : Saisie du code à 6 chiffres généré par une application tierce (Google Authenticator, Authy).
  * **Bouton "Vérifier le code"** : Valide le code OTP auprès de `/api/auth/2fa/verify`.
  * **Bouton "Retour à la connexion"** : Annule la saisie 2FA et renvoie au formulaire principal.

---

## 📊 3. Tableau de Bord Général (DashboardPage)

Le centre de contrôle visuel affichant l'état consolidé du patrimoine de la collectivité.

### Éléments d'interface & Actions
* **Indicateurs clés (KPIs)** :
  * **Valeur Globale** : Affiche la somme totale des acquisitions d'actifs non réformés.
  * **Total des Biens** : Nombre exact d'équipements enregistrés.
  * **Biens en Réforme** : Nombre de demandes de déclassement en attente.
  * **Alertes de Maintenance** : Nombre d'équipements avec maintenance dépassée.
* **Graphiques interactifs** :
  * **Camembert de répartition** : Permet de visualiser le pourcentage représenté par chaque type (Immobilier, Mobilier, Roulant, Informatique).
  * **Courbe d'acquisition** : Graphique de l'évolution financière annuelle.
* **Filtre / Boutons** :
  * **Menu latéral (Sidebar)** : Liens directs pour naviguer vers les autres modules (Biens, Stocks, Affectations, Sinistres, Maintenance, Réforme, Rapports, Administration).
  * **Bouton de profil utilisateur (TopBar)** : Affiche le nom de l'agent connecté et contient le bouton **"Se déconnecter"** (vide le stockage local et redirige vers `/login`).

---

## 📦 4. Gestion des Biens & Inventaires (BiensPage)

C'est le module principal pour répertorier, modifier et supprimer les biens du patrimoine.

### 4.1. Mode Galerie (Registre actif)
Affiche tous les actifs de la collectivité sous forme de grille interactive.

* **Boutons & Actions** :
  * **Bouton "+ Nouveau bien"** : Ouvre le formulaire de saisie dans le mode création (`view = "form"`, `activeStep = 0`).
  * **Bouton "Exporter ▼"** (Menu déroulant) :
    * **Livre journal** : Exporte instantanément le registre sous forme de feuille Excel structurée selon les normes comptables.
    * **Grand livre** : Génère un export Excel avancé incluant les amortissements cumulés et VNC.
    * **Rapport PDF** : Télécharge un document PDF officiel prêt pour signature.
  * **Barre de Recherche** : Saisie libre (recherche sur l'IUP, la désignation, le service ou la localisation).
  * **Boutons de filtre rapide (Pills)** : Permettent de filtrer la liste en un clic par catégorie principale : *Tout*, *Immobilier*, *Mobilier*, *Matériel Roulant*.
  * **Sélecteur "Tous états"** : Menu déroulant pour filtrer par état d'usage : *NEUF*, *BON*, *MOYEN*, *DEGRADE*, *HORS_SERVICE*.
  * **Sélecteur "Tous statuts"** : Filtre par statut d'affectation ou opérationnel : *Affecté*, *Non affecté*, *Transféré*, *En maintenance*, *Sinistré*, *Hors service*, *Réformé*.
  * **Sélecteur de Tri** : Permet d'ordonner par *Date d'acquisition*, *Valeur* ou *Ordre alphabétique*.
  * **Cartes d'Actif individuel** :
    * **Mini-bouton "Modifier" (Icône Étoile/Sparkles)** : Charge les données de l'actif et ouvre le formulaire à l'étape 1.
    * **Mini-bouton "Historique" (Icône Loupe)** : Ouvre le tiroir latéral (`AssetDetailDrawer`) détaillant le cycle de vie du bien.
    * **Mini-bouton "Supprimer" (Icône X rouge)** : Ouvre un popover de confirmation sur la carte.
  * **Popover de suppression** :
    * **Bouton "Supprimer" (Rouge)** : Confirme la suppression définitive de l'actif en base via l'API `/api/biens/{id}`.
    * **Bouton "Annuler"** : Ferme le popover sans modifier l'actif.

### 4.2. Formulaire de saisie dynamique (Registration Flow)
Ce formulaire utilise un système d'étapes (Stepper) pour fiabiliser la saisie des données.

* **Étape 0 : Classification**
  * Sélection d'une des 8 catégories (Immobilier, Mobilier, Informatique, Matériel Roulant, Matériel Technique, Incorporels, Œuvres & Collections, Cheptels).
  * *Action* : Cliquer sur une catégorie configure le modèle et ouvre automatiquement l'Étape 1.
* **Étape 1 : Recensement**
  * **Section 1 : Nomenclature** :
    * **Bouton "Changer"** : Revient à l'étape 0.
    * **Sélecteur Nomenclature** (`NomenclatureSelector`) : Permet de choisir l'article exact dans le référentiel d'État (met à jour les codes comptables SYSCOHADA et propose une désignation par défaut).
  * **Section 2 : Identification de base** :
    * **Désignation** (Texte libre - Obligatoire).
    * **Localisation précise** (Texte libre - Obligatoire).
    * **État initial** (Menu : NEUF, BON, MOYEN, DEGRADE, HORS_SERVICE).
  * **Section 3 : Acquisition & Données Comptables** :
    * **Date d'acquisition** (Date).
    * **Mode d'acquisition** (Menu : ACHAT, DON, LEGS, TRANSFERT, PRODUCTION_PROPRE).
    * **Valeur d'acquisition** (Nombre en FCFA - Obligatoire).
    * **Durée d'amortissement** (Nombre d'années).
    * **Valeur Nette Comptable (VNC)** (Lecture seule - Recalculée en temps réel selon la formule d'amortissement linéaire).
    * **Coordonnées GPS** (Texte) + **Bouton "Capturer GPS"** : Utilise le capteur du périphérique pour insérer la latitude et la longitude exactes.
  * **Section 4 : Médias & Observations** :
    * **Quantité** (Nombre) : Indisponible pour la catégorie Immobilier (fixée à 1).
    * **Zone d'Upload Photo** : Permet de prendre une photo sur le terrain ou de joindre un fichier image.
    * **Zone d'Upload Fichiers** : Permet d'associer des justificatifs (Facture d'achat, PV de réception scanné).
    * **Observations** (Zone de texte).
  * **Section 5 : Champs spécifiques (S'affiche dynamiquement selon la catégorie)** :
    * *Pour l'Immobilier* : Numéro de Titre Foncier (obligatoire), Superficie (obligatoire), Statut juridique (PROPRIETE_ETAT, etc.), case à cocher "Permis d'occuper disponible".
    * *Pour le Matériel Roulant* : Immatriculation (obligatoire, vérification d'unicité en temps réel), Numéro de châssis (obligatoire), Marque et Modèle (obligatoires), Puissance fiscale, Type de boîte, Carburant, Charge utile, Prochaine visite technique.
    * *Pour le Mobilier / Technique* : Numéro de série fabricant, Fabricant, Marque, Modèle, Date de fin de garantie, Spécifications techniques.
  * **Bouton "Continuer vers l'identification du bien"** : Valide la conformité comptable des données saisies et bascule à l'Étape 2.

* **Étape 2 : Identification**
  * Cette étape permet d'identifier individuellement chaque unité (notamment si la quantité saisie à l'étape 1 est supérieure à 1).
  * **Bouton "Générer l'IUP Automatiquement"** : Appelle l'API du backend pour générer un Identifiant Unique du Patrimoine (ex: `PATR-ROUL-2026-000004`) basé sur l'article et la date de recensement.
  * **Champ "Identifiant Unique (IUP)"** : Saisie libre ou IUP auto-généré.
  * **Champs de séries spécifiques** : Possibilité de spécifier des numéros de série, de châssis ou de cadastre distincts par unité.
  * **Panneau "Étiquette & QR Code"** :
    * Génère à la volée un QR Code contenant la fiche technique codée du bien.
    * **Bouton "PNG"** : Télécharge l'étiquette au format PNG pour impression.
    * **Bouton "JPG"** : Télécharge l'étiquette au format JPG.
  * **Bouton "Unité suivante"** (Uniquement pour les lots > 1) : Valide l'unité courante et passe à la saisie de l'unité suivante.
  * **Bouton "Finaliser"** : Enregistre l'ensemble des unités en base de données.
  * **Bouton "Recensement" (Retour)** : Permet de revenir à l'Étape 1.

* **Étape 3 : Succès & Affectation**
  * S'affiche après l'enregistrement réussi des biens.
  * **Bouton "Oui, affecter l'actif"** : Redirige vers le module des affectations avec les données du bien pré-remplies.
  * **Bouton "Plus tard, retour à la galerie"** : Redirige l'utilisateur vers la galerie générale des biens.

---

## 🚜 5. Logistique & Gestion des Stocks (StocksPage)

Module de suivi des biens consommables (fournitures, pièces de rechange, carburant).

### 5.1. Tableau de bord du Cockpit (DASHBOARD)
* **Cartes de synthèse** : Stock disponible global, Valeur totale du stock (méthode PMP), Nombre d'articles en alerte sous le seuil critique, Mouvements en attente de validation.
* **Boutons & Actions de navigation rapide** :
  * **Bouton "Nouvelle entrée"** : Ouvre directement le formulaire d'entrée de stock.
  * **Bouton "Nouvelle sortie"** : Ouvre le formulaire de sortie de stock.
  * **Bouton "Fiche article"** : Ouvre la boîte de dialogue de création de consommable.
* **Section "Articles à réapprovisionner"** : Liste les articles dont la quantité réelle est inférieure ou égale au seuil de sécurité.
* **Section "Mouvements en attente"** : Permet aux agents disposant du droit `VALIDATE_STOCKS` (Magasinier, Administrateur) de cliquer sur le bouton **"Valider"** pour approuver le mouvement et mettre à jour le stock physique.

### 5.2. Gestion des Mouvements (MOUVEMENT)
Permet d'ajouter ou de retirer des quantités de stock.

* **Sélecteur de type de mouvement** : Choix entre *Entrée de stock* (Réception d'achats) et *Sortie de stock* (Consommation de services).
* **Bouton "Nouvelle entrée/sortie"** : Ouvre le formulaire contextuel.
* **Champs du formulaire de mouvement** :
  * **Article déjà référencé** (Sélectionner dans le catalogue).
  * **Lieu physique (Magasin)** (Optionnel - Permet de lier le mouvement à un bâtiment/magasin de stockage).
  * **Nombre d'unités** (Nombre supérieur à 0).
  * **Prix unitaire (FCFA)** (Prix d'achat pour recalculer le Prix Moyen Pondéré PMP).
  * **Origine / Fournisseur** (Pour les entrées).
  * **Bénéficiaire enregistré / libre** (Pour les sorties : sélection d'un agent ou saisie libre du service bénéficiaire).
  * **Référence de preuve** (Obligatoire : Bon de livraison, PV de réception, ou numéro de bon de commande).
  * **Note de contrôle** (Observations libres).
* **Calculateur "Montant estimé"** : Affiche automatiquement le coût total de la transaction (Quantité x Prix Unitaire).
* **Bouton de validation finale** : Enregistre le mouvement à l'état "En attente".

### 5.3. Fiches Articles (CATALOGUE)
Registre de personnalisation des consommables.

* **Recherche** : Recherche par nom normalisé, code ou service propriétaire.
* **Tableau des fiches** : Affiche le nom, le code article, le profil, le conditionnement, le niveau de stock actuel et le seuil critique.
  * **Bouton "Exporter la fiche de stock" (Icône Document)** : Télécharge l'historique complet des entrées/sorties de l'article au format Excel.
* **Bouton "Ouvrir la personnalisation article"** : Ouvre la boîte de dialogue de création.
  * *Champs à remplir* :
    1. **Classification** : Sélecteur d'article issu de la nomenclature officielle (Partie B du référentiel).
    2. **Identité** : Code article (généré), Nom (généré), Description usage, Unité de mesure, Conditionnement habituel.
    3. **Règles de gestion** : Profil de l'article (Consommable courant, etc.), Rythme de consommation, Criticité métier, Seuil d'alerte, Prix repère catalogue, Service propriétaire, Emplacement conseillé.
  * **Bouton "Créer la carte article personnalisée"** : Valide et inscrit le nouvel article au catalogue.

### 5.4. Gestion des Magasins (MAGASINS)
Permet de définir les points physiques de dépôt logistique.

* **Tableau des points de stockage** : Affiche la liste des magasins existants avec leur code et responsable.
* **Bouton "Ouvrir la configuration magasin"** : Ouvre le formulaire de création.
  * *Champs* : Nom du magasin, Code interne, Localisation précise, Responsable.
  * **Bouton "Créer le magasin"** : Enregistre le magasin.

---

## 👥 6. Affectations & Mutations (AffectationsPage)

Ce module gère le flux de mise à disposition des actifs auprès des services administratifs et des agents de l'État.

### 6.1. Registre des affectations
* **KPIs** : Affiche le nombre total d'affectations, les affectations en attente et celles validées.
* **Tableau de suivi** : Affiche le bien concerné (IUP), le bénéficiaire, le service affecté, la date d'affectation et le statut de validation.
* **Boutons & Actions** :
  * **Bouton "+ Nouvelle affectation"** : Ouvre le formulaire d'affectation.
  * **Bouton "Valider"** : (Visible pour les profils valideurs) Approuve l'affectation, met à jour le statut opérationnel du bien à "AFFECTE" et l'associe officiellement au service.
  * **Bouton "Retourner" (Icône flèche)** : Permet de notifier la restitution du bien par l'agent.
  * **Bouton "Fiche décharge" (Icône Fichier)** : Génère un procès-verbal d'affectation ou de décharge au format PDF avec signature.

### 6.2. Formulaire d'Affectation / Mutation
* **Champs du formulaire** :
  * **Bien à affecter** (Sélecteur avec recherche intégrée).
  * **Origine du transfert** (Lecture seule : affiche le détenteur actuel, par exemple "MAGASIN CENTRAL").
  * **Type de bénéficiaire** : Boutons commutateurs : *Service / Direction* ou *Agent individuel*.
  * **Mode Agent individuel** :
    * **Saisie du Matricule** : Recherche automatique de l'agent en base de données. Si trouvé, les champs Nom, Prénom, Fonction, Email et Service sont automatiquement pré-remplis.
  * **Mode Service** :
    * **Sélection du Service** dans une liste déroulante (Bouton **"+"** disponible pour créer un service à la volée via un formulaire modal).
    * **Responsable de la réception** (Nom de l'agent qui réceptionne le lot).
  * **Date d'affectation** (Par défaut la date du jour).
  * **Motif de l'affectation** (Texte descriptif).
  * **Zone Signature** : Permet d'apposer une signature électronique sur écran tactile ou à la souris.
  * **Bouton "Valider et enregistrer l'affectation"** : Enregistre l'affectation en base.

---

## 🛠️ 7. Maintenance et Sinistres

Ces deux modules assurent le maintien opérationnel des actifs.

### 7.1. Gestion des Entretiens (EntretiensPage)
* **Formulaire d'enregistrement d'une maintenance** :
  * **Bien concerné** (Sélecteur).
  * **Type de maintenance** (PREVENTIF, CURATIF, REGLEMENTAIRE, REHABILITATION).
  * **Date prévue** et **Date de réalisation**.
  * **Prestataire** (Nom du garage ou de la société technique).
  * **Coût total (FCFA)**.
  * **Rapport / Pièce jointe** (Téléversement du PV de réparation ou de la facture).
  * **Description / Observation** (Détail de l'intervention).

### 7.2. Gestion des Sinistres (SinistresPage)
* **Formulaire de déclaration de sinistre** :
  * **Bien concerné** (Sélectionner le bien endommagé ou volé).
  * **Type de sinistre** (ACCIDENT, VOL, INCENDIE, DEGAT_EAUX, SEISME, AUTRE).
  * **Niveau de gravité** (MINEUR, MOYEN, MAJEUR, CRITIQUE).
  * **Date du sinistre** et **Description de l'incident**.
  * **Montant estimé des dégâts (FCFA)** et **Référence de police (Constat)**.
  * **Pièces jointes** (Photos du sinistre, rapport d'expert).

---

## ⛔ 8. Réformes et Déclassements (ReformePage)

Ce module gère le retrait définitif des biens de l'inventaire physique et comptable de l'État.

### Formulaire de mise à la réforme
* **Bien à réformer** (Sélecteur).
* **Type de réforme** (MISE_AU_REBUT, VENTE_CESSION, TRANSFERT_INTER_MINISTERE, DON, PERTE_SINISTRE).
* **Date de sortie** (Obligatoire).
* **Motif détaillé de la réforme** (Zone texte - Minimum 50 caractères pour éviter les réformes injustifiées).
* **Valeur résiduelle (FCFA)** (Lecture seule ou saisie selon le mode).
* **Champs de Cession (Uniquement pour le type VENTE_CESSION)** : Prix de cession, Nom de l'acheteur, Référence de l'acte de vente.
* **Champs de Transfert (Uniquement pour le type TRANSFERT_INTER_MINISTERE)** : Ministère destinataire, Référence de l'ordre de transfert.
* **Bouton "Soumettre"** : Envoie la demande au statut "En attente de validation".
* **Workflow de validation** :
  * Un utilisateur ayant le droit `VALIDATE_REFORMES` peut cliquer sur **"Valider"** dans le registre. Cela archive définitivement l'actif et recalcule la VNC à 0.
  * Le validateur peut également signer le document via un modal de signature, ce qui génère le procès-verbal de réforme signé au format PDF.

---

## 🛡️ 9. Administration & Journal d'Audit

*Écran exclusivement réservé aux rôles ADMIN et SUPERADMIN.*

### 9.1. Gestion des Utilisateurs (UsersPage)
* Permet de lister les comptes utilisateurs de la plateforme, de les désactiver, ou de réinitialiser leurs accès.
* **Bouton "Créer un utilisateur"** :
  * *Champs* : Nom, Prénom, Nom d'utilisateur (Login), Adresse Email, Téléphone, Fonction, Rôle système (Sélection parmi la matrice RBAC : *ADMIN*, *RESPONSABLE_PATRIMOINE*, *GESTIONNAIRE_TECHNIQUE*, *AGENT_INVENTAIRE*, *MAGASINIER*, *AUDITEUR*, *ELU*).

### 9.2. Journal d'Audit Système (AuditPage)
* Table non éditable traçant chaque action sensible de l'application (Connexions, créations d'actifs, modifications, suppressions, validations).
* Chaque ligne contient : Date & heure précises, Identifiant de l'agent, Adresse IP, Type d'action, et Détails techniques de la modification.
