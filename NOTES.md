# Alpheios Ancient Greek → French dictionary

## "Théorie", ce qu'il faudra faire


Le but n'est pas de **constituer un lexique** mais seulement de **donner des traductions** à un lexique existant. Cela simplifie notablement le problème et, en particulier, ne nécessite pas de faire le tri entre les entrées qui sont des *vrais lemmes* et celles qui donnent des formes verbales ou dialectales. Il convient toutefois de conserver toutes les entrées du Bailly pour avoir le maximum d'informations.

On a donc, d'une part, un **lexique** avec les *lemmes* auxquels on souhaite donner une traduction et, d'autre part, une **collection de fichiers** contenant les *entrées* et les *sous-entrées* du Bailly. On a plusieurs fichiers pour des raisons techniques ou des raisons d'organisation des données (voir plus bas). On pourrait regrouper ces fichiers en un seul, mais cela n'apporterait pas grand chose. 

Le but du jeu est de mettre en face de chaque *lemme* du lexique **toutes** les entrées qui correspondent à cette forme. Pour cela, on tient compte des diacritiques et de l'éventuelle majuscule, mais pas des numéros d'homonymie. En effet, des lemmes avec ou sans majuscule, comme **Κάρ** et **κάρ**, ou avec un accent différent, comme **ποσός, ή, όν** et **πόσος, η, ον**, sont clairement distincts et les numéros d'homonymie ne sont pas nécessairement les mêmes dans le lexique et dans les dictionnaires. C'est donc une recherche simple d'une forme dans plusieurs listes et qui peut conduire à diverses situations en fonction du nombre de résultats.
- une seule entrée correspond au *lemme* recherché : on va supposer que c'est la bonne et donner la traduction trouvée, éventuellement en suivant les renvois (attention, je n'ai pas vérifié si les renvois menaient quelque part).
- aucune entrée ne correspond au *lemme* : la traduction restera vide, à moins qu'un Helléniste n'identifie la bonne entrée ou donne une traduction.
- plusieurs entrées correspondent au *lemme* : il faut faire le tri...

## Remarque générale

Je produis souvent des fichiers **.csv**, où le séparateur est la **tabulation**. Les caractères sont évidemment codés en UTF-8, ce qui pose des problèmes quasiment insurmontables à la _suite de Microsoft®_ et en particulier à _Excel®_ ($$$). _LibreOffice_ ouvre parfaitement ce type de fichiers et je recommande de mettre _Excel®_ à la poubelle dès que possible.

L'intérêt des fichiers **.csv** est qu'ils sont faciles à écrire (c'est du texte). De plus, on peut les lire avec un éditeur de texte banal ou les mettre dans un tableur (sauf Excel®) pour que les champs soient bien alignés. Le tableur permet aussi de trier ou de filtrer les nombreux champs.

## Un ou deux mots

C'est une question qui va se poser souvent. Par exemple, lorsqu'un mot peut venir de deux racines différentes (?) :

```
αἱρετός, ή, όν : 
I (αἱρέω, prendre) 
1 qui peut être pris, HDT. 4, 201 
2 fig. qui peut être saisi par l’intelligence ou compris, PLAT. Phæd. 81 b 
II (αἱρέομαι, choisir) 
1 choisi, élu : δικασταὶ αἱρ. PLAT. Leg. 759 b, etc. juges élus (p. opp. à κληρωτοί) ; αἱρ. ἀρχή, ISOCR. 265 a ; ARSTT. Pol. 2, 12, 2, magistrature élective ; οἱ αἱρετοί, XÉN. An. 1, 3, 21, hommes choisis ou élus (pour une délégation), délégués, commissaires 
2 qu’on peut ou qu’on doit choisir, souhaitable, HDT. 1, 126 ; ARSTT. Nic. 1, 7, 4, etc. ; p. opp. à φευκτός, PLAT. Phil. 21 d ║ Cp. -ώτερος, HDT. 7, 46 ; XÉN. Cyr. 2, 1, 2, etc. Sup. -ώτατος, PLAT. Crat. 415 d, etc. 
```

ou peut avoir deux genres différents :

```
κώμυς, υθος (ὁ, ἡ) [ῡθ] 
1 ἡ κ. botte de fourrage, CRAT. (Com. fr. 2, 226) ; THCR. Idyl. 4, 18 
2 ὁ κ. lieu planté de roseaux, TH. H.P. 4, 11, 1.
```
Pour ce dernier exemple, Bastien a confirmé qu'il fallait le traiter comme deux lemmes différents. 

Il y a aussi un grand nombre de mots avec un préfixe pouvant avoir des sens différents. Pour reprendre mon exemple préféré, ἀλέκτωρ : faut-il considérer que le *(ἀ priv.)* et le *(ἀ cop.)* sont le même lemme et conduisent à un seul lemme `1 ἀ·λέκτωρ` (pour mémoire, Bailly a aussi `2 ἀλέκτωρ, le coq`) ?

# Notes sur les fichiers que je mets dans le dossier "raw_data".


A priori, je vais essayer de dater mes commentaires qu'il faut considérer comme des *mises à jour*, c'est à dire qu'il faudrait les lire *de bas en haut*. Je ne garantis pas que je n'ajouterai pas quelque chose dans un paragraphe déjà écrit à une date antérieure.

## Vendredi 2 octobre 2020

Hier soir, j'ai poussé sur GitHub mes fichiers et je me suis aperçu ce matin que les dernières modifs dans mon code me faisaient perdre les sens du premier substantif dans une série de deux. Cela ne concerne que 92 cas, mais je l'ai corrigé.

## Mercredi 30 septembre 2020

Je dépose une série de fichiers qui correspondent au traitement des cas simples (définis plus bas). Les fichiers **txt** contiennent des données brutes, alors que les **csv** sont le résultat d'un traitement (en réalité, les fichiers txt sont aussi issus du traitement de mon fichier intermédiaire). Le fichier zippé, `Bailly_tout.txt.zip` (qui était un peu trop gros et assez inutile), correspond à mon fichier intermédiaire, dans lequel j'ai explicité les substantifs abrégés (sous la forme *{ὁ ἀγ.}*) et remplacé les renvois au mot suivant ou précédent par ledit mot. Le fichier `Bailly_vide.txt` contient les entrées pour lesquelles je n'ai pas su isoler de sens (il y en a 2 975). Elles semblent correspondre à des formes verbales qui se contentent de renvoyer au verbe (en précisant les temps et mode). Le troisième fichier, `Bailly_complex.txt`, contient les entrées que j'ai considérées comme complexes et que je dois encore traiter. Il y en a 16 740...

Les trois fichiers **csv** sont, a priori, les plus intéressants. Comme je l'ai déjà dit, c'est des fichiers texte en UTF-8 et les champs sont séparés par des tabulations. Le nombre de champs dépend du fichier, et même de l'entrée.
- Le fichier `Bailly_renv.csv` contient les entrées identifiées comme des renvois (il y en a 15 434). Les lignes contiennent deux champs principaux : l'entrée et le renvoi. Viennent ensuite les indications trouvées : désinences (*des*), génitif (*gens*) et article (entre parenthèses), éventuellement aussi quelques mots clefs. Elles sont aussi, en général, séparées par des tabulations, mais je pourrais modifier mon code pour que tout ce qui relève des *indications* soit dans un seul champ. Il faut noter que je n'ai pas vérifié si le renvoi existe, comme entrée ou sous-entrée. Mais il n'est pas nécessaire de vérifier que tous les renvois mènent quelque part, puisqu'on n'est pas sûr que tous les renvois soient utiles. Quand on fera la recherche d'un lemme (du **lexique**) et qu'on trouvera un renvoi ne menant nulle part, il sera temps de s'en occuper...
```TSV
ἀϐουλί	> ἀϐουλήτως	adv. 
ἁϐροσύνη	> ἁϐρότης	gens : ης	(ἡ) 
ἁϐροχαίτης	> ἁϐροκόμης	gens : ου,	adj. m. 
Ἀϐυδηνοκόμης	> Ἀϐυδοκόμης	
```
- Le fichier `Bailly_sens.csv` est le fichier principal. Comme son nom l'indique, il contient les entrées pour lesquelles je pense avoir réussi à isoler un sens (il y en a 72 652). Il contient les entrées (première colonne), le sens trouvé (2e colonne), le nombre de caractères que compte le sens (3e colonne, uniquement pour repérer facilement les sens qui sont trop longs et qui mériteraient d'être abrégés). Viennent ensuite les indications relevées (en nombre variable, comme dans le cas des renvois). On pourra donc avoir des lignes avec trois champs peuplés (typiquement pour un verbe), quatre (souvent pour les adjectifs, avec seulement un *des*), cinq (généralement les noms, avec un *gens* et un article pour donner le genre) et, plus rarement, six (un adjectif avec un *des*, un *gens* et un ou plusieurs mots-clefs, parce qu'il a donné un adverbe ou un substantif).
```TSV
ἀασμός	exhalaison, souffle,	20	gens : οῦ	(ὁ) 
1 ἄατος	insatiable de,	14	des : ος, ον	
2 ἄατος	pernicieux, funeste,	20	des : ος, ον	
2 ἀάω	rassasier,	10	
ἀϐαθής	sans profondeur,	16	des : ής, ές	
Ἄϐαι	Abes, (v.)	10	gens : ῶν	(αἱ) 
```
- Le fichier `Bailly_subst.csv` contient les substantifs et les adverbes qui sont perdus dans d'autres articles (souvent des adjectifs, parfois des verbes). Comme je n'ai traité que les cas simples, il n'y a que 2 454 lignes. Les lignes sont une fois de plus de longueur variable. Elles donnent :
    1. l'article (pour les substantifs) ou le mot-clef *adv.* (pour les adverbes)
    2. la forme (comme elle était parfois abrégée, je l'ai reconstituée à la main, en espérant ne pas avoir écrit trop d'horreurs -je n'ai aucune connaissance en Grec)
    3. le sens
    4. le lemme (l'entrée du Bailly) où j'ai trouvé ce mot
    5. les indications relatives à l'entrée du dico et **pas** au mot trouvé
```TSV
ἡ	ἐπίτομος	 chemin le plus court ou direct	ἐπίτομος	des : ος, ον,	
ὁ	ἐπιτυχών	 le premier venu	ἐπιτυγχάνω	
τὰ	ἐπιτετευγμένα	 les succès	ἐπιτυγχάνω	
τὸ	ἐπίχαρι	 le charme, la grâce	ἐπίχαρις	des : ις, ι,	gens : ιτος	
```

Ce dernier fichier `Bailly_subst.csv` est probablement le plus *discutable*. D'une part, il contient peut-être des horreurs dues à mon ignorance de Grec. D'autre part, il pose une question plus fondamentale de savoir quand un adjectif substantivé devient un lemme à part entière. Y a-t-il un critère objectif pour trancher la question ? On peut souvent estimer qu'il y a un substantif sous-entendu (pour donner le genre) et que l'adjectif reste un qualificatif de ce nom inexistant (pas sûr que ça aide beaucoup un étudiant débutant).

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

J'ai fini une relecture rapide des *entrées vides* et récupéré quelques liens et sens. J'ai parcouru également la liste des substantifs et éliminé des cas aberrants.

## Lundi 21 septembre 2020

L'exemple donné vendredi dernier a soulevé des questions intéressantes liés aux formes contractes (et au choix du dialecte). Helma a fait une entorse au LSJ en choisissant ζήω comme lemme. Bastien est d'avis que ζάω est le lemme.
Un cas plus anodin de choix de lemmes est reproduit ci-dessous :

```
LSJ 1940 :
 
ἀστροβολησία ἡ, sun-scorch, in plants, Thphr. CP 5.9.4 (nisi leg. ἀστροβλησία). 

ἀστροβλησία ἡ, prob. l. for -βολησία.
``` 

```
Bailly 2020 : 

ἀστροϐολησία, var. p. ἀστροϐλησία.

ἀστροϐλησία, ας (ἡ) insolation, TH. C.P. 5, 9, 4
    Étym. : ἀστρόϐλητος.
```

On a bien un cas où le LSJ a choisi **ἀστροβολησία** comme lemme alors que Bailly donne **ἀστροϐλησία**, chacun donnant un renvoi de l'autre forme vers le lemme retenu. Cela dit, Eulexis ne connaît que la forme du LSJ. Pape lui ne connaît que la 2e forme (le lemme du Bailly).


## Vendredi 18 septembre 2020

L'exemple qui me manquait hier (peut-être pas le meilleur, mais le premier que je trouve)

```
LSJ 1940 :

ζάω v. ζῶ. 

ζῶ (contr. fr. ζώω ; ζάω only in Gramm., EM 410.38), ζῇς (Choerob. in Theod. 2.28), ζῇ, ζῆτε (but ζῆς, ζῆ acc. to Anon. ap. EM 410.48, ...
```

```
Bailly 2020 :

ζάω-ῶ ou mieux ζήω-ῶ (avec contract. en η, d’où prés. ζῶ, ζῇς, ζῇ ; impér. ζῆ, opt. ζῴην ; inf. ζῆν ; impf. ἔζων, ἔζης, ἔζη, ἐζῶμεν, ἐζῆτε, ἔζων ; fut. ζήσω ou ζήσομαι ; ao. ἔζησα, pf. ἔζηκα, pl. q. pf. ἐζήκειν ; ttef. au lieu d’ ἔζησα, ἔζηκα, ἐζήκειν, les ...

ζῶ, contr. de ζήω.

ζήω, v. ζάω.
```


## Jeudi 17 septembre 2020

Avant les vacances, j'ai traité l'ensemble du **Bailly 2020** pour en extraire automatiquement les sens, tout en conservant la structure des articles en *sections, rubriques et paragraphes* (quand ils existent !). J'ai aussi essayé de trouver les mots "cachés" dans les articles, en particulier les adjectifs substantivés qui prennent un sens spécial.

Maintenant, j'ai mouliné ces données pour séparer les cas *simples* des cas *plus compliqués*. Je considère comme simples les articles dans lesquels il n'y a pas de structure (un seul sens) ou ceux pour lesquels un sens général est donné avant toute structure `(par exemple, "θρίξ,	poil" qui est ensuite détaillé en cheveux, poils du corps, crins etc...)`. Pour l'instant, je n'ai traité que ces entrées-là. Ce qui m'a donné 72 600 sens et 2500 substantifs ou adverbes dérivés. Il reste environ 16 700 articles qui présentent une structure plus ou moins élaborée qu'il me faut encore mouliner. Se cachent aussi environ 3000 substantifs ou adverbes dans ces articles complexes. Ce dernier chiffre est approximatif car, dans les cas de polysémie, un même substantif (féminin singulier, par exemple) peut apparaître dans plusieurs rubriques, donc avec des sens différents.

Deux cas particuliers sont apparus dans le traitement des cas simples : les renvois et les "articles vides". Ces derniers correspondent bien souvent à des formes verbales (adj. verb., part., futur, etc.) non-triviales ou des crases. Je pense donc que nous pouvons les ignorer, mais il faudrait sans doute qu'un helléniste parcourt le fichier pour vérifier qu'il n'y a pas d'oubli (il y a environ 3300 entrées dans ce fichier). Dans un premier temps, il y avait un certain nombre de sens comme "autre n. de la plante xxx" ou "dim. de yyy' qui avaient échappé au traitement (il doit en rester).

Les renvois posent un problème sérieux, car ils sont nombreux (~15 200) et il y en a de plusieurs types (au moins trois) : 

- les variantes (ortho)graphiques `(par exemple, ἅϐα	> ἥϐη)`
- des formes verbales qui renvoient au lemme `(par exemple, ἀάσθην	> ἀάω)`
- un substantif renvoie à un adjectif, parce que ledit subst. est mentionné dans l'article de l'adjectif `(par exemple, Αἰγεῖον	> Αἰγεῖος et dans cet article on lit τὸ Αἰγεῖον, DIN. (Bkk. 354) temple d’Égée)` ou réciproquement, `(δμήτειρα, adj. f.	> δμητήρ, subst. masc.)`.

Il y a une autre famille de renvois que je n'ai pas encore relevés (du moins pas ici) : il s'agit des variantes (ortho)graphiques ou dialectales données par Bailly dans l'article même. Elles sont repérées dans le fichier TeX par la commande **\es{...}** et il y en a 3900. Par exemple, `"\entree{ἀκοστάω} \ital{ou} \es{ἀκοστέω}"` et on n'a pas d'entrée *"ἀκοστέω"* qui renverrait au lemme *"ἀκοστάω"*. Évidemment, il y a aussi des cas où le renvoi explicite existe `(par exemple, βροῦλλον,	> βρύλλον et plus loin, "βρύλλον ou βροῦλλον, ου (τὸ) c. σπάρτον," ; exemple qui illustre aussi le problème des doubles renvois)`.

Au mois d'avril, j'avais essayé une *autre* méthode pour extraire les sens, qui conservait les entrées secondaires. Mais sur laquelle je n'ai pas beaucoup retravaillé. Il faut se méfier des cas où il y a un renvoi et **des** entrées secondaires, car bien souvent il s'agit d'une collection de mots présentant une variation graphique commune et le renvoi est en réalité une collection de renvois (explicites ou résumés par un *etc.*). Par exemple : `ἀγλαΐη, Ἀγλαΐη, ἀγλαΐηφι, v. ἀγλαΐα, Ἀγλαΐα`.

Pour répondre à Helma qui faisait remarquer que, comme on passe par un outil de lemmatisation, les formes verbales qui renvoient sur le verbe ne serviront pas et ne gênent pas : oui, un outil de lemmatisation renvoie à un **lemme standardisé**. Mais la question qui peut se poser est de savoir **lequel**. Il me semble avoir vu des cas où Bailly et LSJ ont fait des choix opposés. Je n'ai pas d'exemple concret, mais on va considérer deux entrées A et B : il me semble avoir vu dans le LSJ un article complet pour A et un renvoi de B vers A, alors que Bailly donne un renvoi de A vers B et l'article complet est pour B. Comme l'outil de lemmatisation est basé sur le LSJ, le lemme standardisé sera A qui dans le Bailly ne donne qu'un renvoi. Si je retrouve un exemple, je vous l'enverrai. Et j'évite de parler des cas où les accents ou esprits se déplacent ou des cas où les avis divergent (j'ai vu des diminutifs que le LSJ et le Bailly ne rattachent pas au même mot). Mais à ce caveat près, je suis d'accord avec le fait que les renvois liés à des formes verbales ne sont pas utiles, mais probablement pas nuisibles non plus.

