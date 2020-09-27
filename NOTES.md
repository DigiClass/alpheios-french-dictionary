# Alpheios Ancient Greek → French dictionary

## Notes sur les fichiers que je mets dans le dossier "raw_data".

A priori, je vais essayer de dater mes commentaires qu'il faut considérer comme des *mises à jour*, c'est à dire qu'il faudrait les lire *de bas en haut*.

### Remarque générale

Je produis souvent des fichiers **.csv**, où le séparateur est la **tabulation**. Les caractères sont évidemment codés en UTF-8, ce qui pose des problèmes quasiment insurmontables à la _suite de Microsoft®_ et en particulier à _Excel®_ ($$$). _LibreOffice_ ouvre parfaitement ce type de fichiers et je recommande de mettre _Excel®_ à la poubelle dès que possible.

L'intérêt des fichiers **.csv** est qu'ils sont faciles à écrire (c'est du texte). De plus, on peut les lire avec un éditeur de texte banal ou les mettre dans un tableur (sauf Excel®) pour que les champs soient bien alignés. Le tableur permet aussi de trier ou de filtrer les nombreux champs.

## Dimanche 27 septembre 2020

Je mets dans le dossier **raw_data** le vieux fichier de sens (extrait avec un premier programme en avril) qui a conservé les *entrées secondaires*. Ce fichier n'étant pas intéressant en soi, je le zippe et j'en tire trois fichiers qui me semblent utiles : je ne garde que les entrées qui contiennent des *es*. Les trois fichiers ont le même format et se distinguent par le contenu des colonnes pour les sens et les renvois :
- `Bailly_es_sens.csv` : le sens est non-vide et le renvoi est vide
- `Bailly_es_renv.csv` : le sens est vide et le renvoi est non-vide
- `Bailly_es_probl.csv` : le sens est non-vide et le renvoi est non-vide

Le format est composé de 5 champs :
1. Le lemme
2. L'entrée secondaire (éventuellement plusieurs variantes)
3. Le sens trouvé (éventuellement vide)
4. Le renvoi (éventuellement vide)
5. La longueur du sens trouvé (nombre de caractères)

A priori, le fichier le plus simple à utiliser est celui avec des sens et sans renvoi : il est plus ou moins équivalent à un renvoi de la variante (deuxième colonne) vers l'entrée (première colonne). Le fichier avec des renvois (et pas de sens) peut être compliqué par les renvois multiples que je mentionnais plus tôt (le 17 septembre). Dans les cas simples, il est équivalent à un renvoi de la variante vers le renvoi (4e colonne). Le fichier problématique doit être regardé avec attention, car en principe il ne devrait pas y avoir, dans un même article, un sens et un renvoi.

## Vendredi 25 septembre 2020

J'ai fini une relecture rapide des *entrées vides* et récupéré quelques liens et sens. J'ai parcouru également la liste des substantifs et éliminé les cas aberrants.

## Lundi 21 septembre 2020

L'exemple donné vendredi dernier a soulevé des questions intéressantes liés aux formes contractes (et au choix du dialecte). Helma a fait une entorse au LSJ en choisissant ζήω comme lemme. Bastien est d'avis que ζάω est le lemme.
Un cas plus anodin de choix de lemmes est reproduit ci-dessous :

````LSJ 1940 :
 
ἀστροβολησία ἡ, sun-scorch, in plants, Thphr. CP 5.9.4 (nisi leg. ἀστροβλησία). 

ἀστροβλησία ἡ, prob. l. for -βολησία.```` 

````Bailly 2020 : 

ἀστροϐολησία, var. p. ἀστροϐλησία.

ἀστροϐλησία, ας (ἡ) insolation, TH. C.P. 5, 9, 4
    Étym. : ἀστρόϐλητος.````

On a bien un cas où le LSJ a choisi **ἀστροβολησία** comme lemme alors que Bailly donne **ἀστροϐλησία**, chacun donnant un renvoi de l'autre forme vers le lemme retenu. Cela dit, Eulexis ne connaît que la forme du LSJ. Pape lui ne connaît que la 2e forme (le lemme du Bailly)


## Vendredi 18 septembre 2020

L'exemple qui me manquait hier (peut-être pas le meilleur, mais le premier que je trouve)

````LSJ 1940 :

ζάω v. ζῶ. 

ζῶ (contr. fr. ζώω ; ζάω only in Gramm., EM 410.38), ζῇς (Choerob. in Theod. 2.28), ζῇ, ζῆτε (but ζῆς, ζῆ acc. to Anon. ap. EM 410.48, ...````

````Bailly 2020 :

ζάω-ῶ ou mieux ζήω-ῶ (avec contract. en η, d’où prés. ζῶ, ζῇς, ζῇ ; impér. ζῆ, opt. ζῴην ; inf. ζῆν ; impf. ἔζων, ἔζης, ἔζη, ἐζῶμεν, ἐζῆτε, ἔζων ; fut. ζήσω ou ζήσομαι ; ao. ἔζησα, pf. ἔζηκα, pl. q. pf. ἐζήκειν ; ttef. au lieu d’ ἔζησα, ἔζηκα, ἐζήκειν, les ...

ζῶ, contr. de ζήω.

ζήω, v. ζάω.````


## Jeudi 17 septembre 2020

Avant les vacances, j'ai traité l'ensemble du **Bailly 2020** pour en extraire automatiquement les sens, tout en conservant la structure des articles en *sections, rubriques et paragraphes* (quand ils existent !). J'ai aussi essayé de trouver les mots "cachés" dans les articles, en particulier les adjectifs substantivés qui prennent un sens spécial.

Maintenant, j'ai mouliné ces données pour séparer les cas *simples* des cas *plus compliqués*. Je considère comme simples les articles dans lesquels il n'y a pas de structure (un seul sens) ou ceux pour lesquels un sens général est donné avant toute structure `(par exemple, "θρίξ,	poil" qui est ensuite détaillé en cheveux, poils du corps, crins etc...)`. Pour l'instant, je n'ai traité que ces entrées-là. Ce qui m'a donné 72 600 sens et 2500 substantifs ou adverbes dérivés. Il reste environ 16 700 articles qui présentent une structure plus ou moins élaborée qu'il me faut encore mouliner. Se cachent aussi environ 3000 substantifs ou adverbes dans ces articles complexes. Ce dernier chiffre est approximatif car, dans les cas de polysémie, un même substantif (féminin singulier, par exemple) peut apparaître dans plusieurs rubriques, donc avec des sens différents.

Deux cas particuliers sont apparus dans le traitement des cas simples : les renvois et les "articles vides". Ces derniers correspondent bien souvent à des formes verbales (adj. verb., part., futur, etc.) non-triviales ou des crases. Je pense donc que nous pouvons les ignorer, mais il faudrait sans doute qu'un helléniste parcourt le fichier pour vérifier qu'il n'y a pas d'oubli (il y a environ 3300 entrées dans ce fichier). Dans un premier temps, il y avait un certain nombre de sens comme "autre n. de la plante xxx" ou "dim. de yyy' qui avaient échappé au traitement (il doit en rester).

Les renvois posent un problème sérieux, car ils sont nombreux (~15 200) et il y en a de plusieurs types (au moins trois) : 

- les variantes (ortho)graphiques `(par exemple, ἅϐα	> ἥϐη)`
- des formes verbales qui renvoient au lemme `(par exemple, ἀάσθην	> ἀάω)`
- un substantif renvoie à un adjectif, parce que ledit subst. est mentionné dans l'article de l'adjectif `(par exemple, Αἰγεῖον	> Αἰγεῖος et dans cet article on lit τὸ Αἰγεῖον, DIN. (Bkk. 354) temple d’Égée)` ou réciproquement, `(δμήτειρα, adj. f.	> δμητήρ, subst. masc.)`.

Il y a une autre famille de renvois que je n'ai pas encore relevés (du moins pas ici) : il s'agit des variantes (ortho)graphiques ou dialectales données par Bailly dans l'article même. Elles sont repérées dans le fichier TeX par la commande **\es{...}** et il y en a 3900. Par exemple, `"\entree{ἀκοστάω} \ital{ou} \es{ἀκοστέω}"` et on n'a pas d'entrée *"ἀκοστέω"* qui renverrait au lemme *"ἀκοστάω"*. Évidemment, il y a aussi des cas où le renvoi explicite existe `(par exemple, βροῦλλον,	> βρύλλον et plus loin, "βρύλλον ou βροῦλλον, ου (τὸ) c. σπάρτον," ; exemple qui illustre aussi le problème des doubles renvois)`.

Au mois d'avril, j'avais essayé une *autre* méthode pour extraire les sens, qui conservait les entrées secondaires. Mais sur laquelle je n'ai pas beaucoup retravaillé. Il faut se méfier des cas où il y a un renvoi et des entrées secondaires, car bien souvent il s'agit d'une collection de mots présentant une variation graphique commune et le renvoi est en réalité une collection de renvois (explicites ou résumés par un *etc.*). Par exemple : `ἀγλαΐη, Ἀγλαΐη, ἀγλαΐηφι, v. ἀγλαΐα, Ἀγλαΐα`.

Pour répondre à Helma qui faisait remarquer que, comme on passe par un outil de lemmatisation, les formes verbales qui renvoient sur le verbe ne serviront pas et ne gênent pas : oui, un outil de lemmatisation renvoie à un **lemme standardisé**. Mais la question qui peut se poser est de savoir **lequel**. Il me semble avoir vu des cas où Bailly et LSJ ont fait des choix opposés. Je n'ai pas d'exemple concret, mais on va considérer deux entrées A et B : il me semble avoir vu dans le LSJ un article complet pour A et un renvoi de B vers A, alors que Bailly donne un renvoi de A vers B et l'article complet est pour B. Comme l'outil de lemmatisation est basé sur le LSJ, le lemme standardisé sera A qui dans le Bailly ne donne qu'un renvoi. Si je retrouve un exemple, je vous l'enverrai. Et j'évite de parler des cas où les accents ou esprits se déplacent ou des cas où les avis divergent (j'ai vu des diminutifs que le LSJ et le Bailly ne rattachent pas au même mot). Mais à ce caveat près, je suis d'accord avec le fait que les renvois liés à des formes verbales ne sont pas utiles, mais probablement pas nuisibles non plus.

