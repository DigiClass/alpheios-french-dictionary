# Projet Alpheios-Eulexis pour l'ajout de traduction en Français aux lemmes grecs

## Introduction

### Historique

Les lemmes d'Eulexis sont _grosso modo_ ceux du LSJ et ils ont été utilisés 
pour la lemmatisation des formes par **Perseus** (et ses héritiers). 
Il y a déjà quelques années (lorsque j'ai développé la version résidente d'Eulexis), 
j'ai éprouvé le besoin de traduire en Français les traductions anglaises proposées 
par **Diogenes**, avec un succès assez mitigé.
Depuis, une équipe de bénévoles a mené à bien, sous la direction de Gérard Gréco, 
le passage en TeX du **Bailly**. 
Il m'a semblé naturel de partir de cette version du Bailly pour améliorer
les traductions françaises d'Eulexis. 
J'ai été rejoint sur ce sujet par Bridget Almas qui souhaite ajouter des traductions 
en Français dans Alpheios.

La magie de l'informatique a permis de mouliner le fichier TeX du Bailly.
J'en ai extrait les traductions françaises de beaucoup de lemmes
que j'ai ensuite alignées avec les traductions existantes dans Eulexis.
Le plus difficile reste à faire : **choisir** la _bonne_ traduction pour 
les ≈100 000 lemmes grecs qu'Eulexis connaît.

### Objectifs

L'objectif **principal** est de choisir la _bonne_ traduction. 
Le choix est à faire entre la traduction existante dans Eulexis, si elle existe, 
et la traduction, ou une des traductions, issues du Bailly.
**Toutefois**, pour atteindre ce but, il est clair qu'il faudra relire également
les traductions anglaises (et éventuellement allemandes) et il serait _dommage_ 
de ne pas profiter de l'occasion pour les améliorer également.

### Méthode

Pour atteindre ces objectifs, nous misons sur un travail reparti sur 
plusieurs **volontaires**. L'idée est de partager l'ensemble des données 
en petits fichiers que chacun peut corriger indépendamment et à son rythme.
Pour ne pas devoir d'emblée affronter les 100 000 lemmes du lexique d'Eulexis, 
j'ai utilisé un fichier d'Helma Dik (de Logeion) qui donne le nombre d'occurrences 
relevées dans le corpus traité pour les divers lemmes. 
En se limitant aux lemmes qui apparaissent plus de *cinq* fois, on couvre presque 
**99%** du corpus avec *seulement* ≈20 000 lemmes. 
C'est donc ce premier lot qu'il faut traiter pour commencer.

## L'outil dans Eulexis

Pour revoir et corriger l'ensemble des traductions d'Eulexis, j'ai développé 
un outil spécial que l'on trouve dans le menu "Extra/Vérifier les traductions".
S'ouvre alors une boîte de dialogue pour choisir le fichier à traiter.
On voit alors apparaître une fenêtre d'édition comme celle-ci :
![fenêtre d'édition initiale](images_MdE/Image1.png)
En même temps, s'affichent dans la fenêtre principale l'Eulexis les articles
de dictionnaire correspondant au lemme traité.
Le choix des dictionnaires à afficher se fait dans le menu "Dicos".
Personnellement, je recommande de les afficher **tous** :
en effet, ils peuvent contenir des informations complémentaires et précieuses.

### Description

Les quatre premières lignes sont informatives et ne peuvent pas être modifiées.
Elles contiennent :
1. un indicateur de progression (_ici 1/9_) qui donne le numéro du lemme et le nombre total de lemmes à traiter dans ce fichier
2. les lemmes précédent (à gauche, _ici il est vide_) et suivant (à droite)
3. le lemme à examiner en caractères grecs
4. le lemme à examiner en betacode

Viennent ensuite une ligne de titre `Eulexis` et trois lignes avec les traductions 
qui sont déjà dans Eulexis. Dans l'ordre, elles sont en Anglais, Français et Allemand. 
Ces deux dernières ont été obtenues par traduction automatique de la traduction 
anglaise, sauf quand je les ai corrigées manuellement. 
Ces trois traductions sont éditables. 
Chaque ligne peut contenir une cinquantaine de caractères et 
c'est un maximum pour une définition courte.

La situation avec le Bailly est un peu plus compliquée, 
car il peut y avoir plusieurs candidats pour un même lemme.
Après le titre `Bailly`, j'ai mis une **comboBox** qui donne la ou les solutions trouvée(s). Par convention, je mets un fond de couleur quand cette comboBox requiert
une attention redoublée. 
Si le fond est blanc, il n'y a qu'une solution et elle est _exacte_. 
Il n'y a pas lieu de s'en soucier.

### Détails

#### La comboBox

#### Les boutons-radios

#### Le bouton de "Validation"

#### Le bouton de retour

#### Le bouton "Save"

#### Le bouton "Undo"
