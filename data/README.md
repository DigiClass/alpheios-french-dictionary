# About the data in this folder

## Alpheios dictionary data

* **[data/bailly-grc-defs.dat](../data/bailly-grc-defs.dat)** contains an initial pass of the Alpheios Bailly data file, for all of the lemmas found in the Bailly files with the French definitions, and for any other lemmas from LSJ that were not found, the English definitions from LSJ.

* **[test/index.html](../test/index.html)**  can be used to test the defs file with Alpheios . You should see  a page with a small excerpt from Sophocles Ajax, and Alpheios embedded with a build of the code that has the Bailly+LSJ short defs file. (This should automatically be selected as the default short definition lexicon, if it's not for some reason you can select that by going to the resources tab of the Alpheios options dialog).  Not many of the words from that passage were among the ones that have French definitions, but you can see how they look if you double-click on "σε" . You can also enter any greek word in the lookup box. I threw a quick credits statement together, but this will need to be polished and expanded upon.

## Eulexis alignment data

* **[data/Eulexis_Bailly_align.csv](Eulexis_Bailly_align.csv)** contient le résultat de l'alignement des *lemmes* d'Eulexis (i.e. de Diogenes) avec les divers fichiers extraits du Bailly. Le contenu des colonnes est indiqué sur la première ligne :
    1. lemme (d'Eulexis) en unicode
    2. le même en betacode
    3. le mot s'il est trouvé dans le fichier `Bailly_sens.csv`
    4. le mot s'il est trouvé dans le fichier `Bailly_renv.csv`
    5. le mot s'il est trouvé dans le fichier `Bailly_subst.csv`
    6. le mot s'il est trouvé dans le fichier `Bailly_es_sens.csv`
    7. le mot s'il est trouvé dans le fichier `Bailly_es_renv.csv`
    8. le nombre de mots trouvés dans les fichiers
Si le *lemme* n'a été trouvé dans aucun des fichiers, je fais une deuxième tentative en supprimant les signes diacritiques et l'éventuelle majuscule. Pour distinguer les lignes issues de cette deuxième tentative, je les fais commencer par un point d'interrogation et le nombre de mots trouvés est augmenté de 100. 
Une majorité des *lemmes* a maintenant un candidat unique : **67 505 = 58%** (voir les détails en date du 12 octobre dans [NOTES.md](../NOTES.md)).

* **[data/index_LSJ_Bailly.csv](index_LSJ_Bailly.csv)** est l'index commun du LSJ (version de Chaeréphon) et du Bailly. La première colonne est la base commune : l'entrée sans diacritique, ni majuscule, ni indice d'homonymie. La deuxième colonne donne l'entrée du LSJ et la troisième l'entrée du Bailly. En cas d'entrées multiples, j'utilise autant de ligne que nécessaire.

* **[data/betunicode_gr.csv](betunicode_gr.csv)** est le tableau de conversion betacode-Unicode que j'utilise dans Eulexis. Les lignes contenant un point d'exclamation "!" sont des commentaires et doivent être ignorées. Il s'agit de remplacer séquentiellement les éléments de la première colonne par ceux de la troisième, ou réciproquement. L'ordre a son importance et le β initial (si on utilise le ϐ) ou le ς final doivent être traités à part.

## Raw data

Data contained in `data/raw/` are intermediate data produced to import Bailly's short definitions into Eulexis and Alpheios.

### Alpheios (`raw/alpheios/*`)

(data produced by @balmas)

Files of interest:

* **[raw/alpheios/matched.csv](raw/alpheios/matched.csv)**: this contains the lemmas for which I could find an exact match (or exact match excluding initial capital) in the Alpheios LSJ index

* **[raw/alpheios/nolsj.csv](raw/alpheios/nolsj.csv)**: this contains the lemmas from the Bailly files that I could not match in the Alpheios LSJ index.

* **[raw/alpheios/nobailly.csv](raw/alpheios/nobailly.csv)**: this contains the lemmas from the Alpheios LSJ index that I could not match in the Bailly files.

* **[raw/alpheios/morphdiff.csv](raw/alpheios/morphdiff.csv)**: this contains a subset of the lemmas in nolsj.csv (i.e the lemmas found in Bailly and not in the LSJ index) that morpheus parsed as a different lemma (and the corresponding LSJ short def for that lemma) (TargetWord is the lemma from Bailly, LemmaWord is the lemma from LSJ)

* **[raw/alpheios/propernouns.csv](raw/alpheios/propernouns.csv)**: this contains a subset of the lemmas in nolsj.csv that morpheus parsed as a different lemma that are likely to be proper nouns. In some cases, the initial sense of the propernoun WAS found in the LSJ index but additional senses were not (if a lemma in here has sense indicators and the plain lemma without the sense isn't listed, then a single sense was matched in the LSJ index)

### Eulexis (`raw/eulexis/*`)

(data produced by @PhVerkerk)

@PhVerkerk a déposé une série de fichiers qui correspondent au traitement des informations extraites du Bailly (Nouvelle édition revue et corrigée, dite
BAILLY 2020
Version Hugo Chávez, établie sous la direction de
GÉRARD GRÉCO
ingénieur,
avec le concours spécial de
André CHARBONNET (Chaeréphon), Mark DE WILDE
et
Bernard MARÉCHAL, aimablement fournie à @PhVerkerk au format TeX par Gérard Gréco). 
Les fichiers **txt** contiennent des données brutes, alors que les **csv** sont le résultat d'un traitement (en réalité, les fichiers txt sont aussi issus du traitement de mon fichier intermédiaire). Les fichiers zippés, [`Bailly_tout.txt.zip`](raw/eulexis/Bailly_tout.txt.zip) et [`Bailly_complex.txt.zip`](raw/eulexis/Bailly_complex.txt.zip) (qui étaient un peu trop gros et assez inutiles), correspondent respectivement à mon fichier intermédiaire, dans lequel j'ai explicité les substantifs abrégés (sous la forme *{ὁ ἀγ.}*) et remplacé les renvois au mot suivant ou précédent par ledit mot et aux cas complexes que j'ai traités dans un second temps. Le fichier [`Bailly_vide.txt`](raw/eulexis/Bailly_vide.txt) contient les entrées simples pour lesquelles je n'ai pas su isoler de sens (il y en a 2 975). Elles semblent correspondre à des formes verbales qui se contentent de renvoyer au verbe (en précisant les temps et mode). Le fichier [`Bailly_vide_c.txt`](raw/eulexis/Bailly_vide_c.txt) contient les entrées complexes pour lesquelles je n'ai pas su isoler de sens (il y en a 18). Il s'agit exclusivement d'entrées du Bailly qui contiennent la même forme à deux genres différents, que j'ai dû considérer comme deux mots distincts.
```TSV
Βουκολίων,	160239	
	160240	@		1	{ὁ Βουκολίων} Boukoliôn (h.)
	160244	@		2	{ἡ Βουκολίων} Boukoliôn, (v.)
gens : ωνος	
OK
<<	160240	@		1	
<<	160244	@		2	
```
Les dernières lignes (qui commencent par "<<") sont issues de mon traitement (voir le fichier [NOTES.md](../NOTES.md)).

#### Anciens fichiers avec les entrées secondaires :

Le format des données CSV (Tab comme séparateur) est composé de 5 champs :
1. Le lemme
2. L'entrée secondaire (éventuellement plusieurs variantes)
3. Le sens trouvé (éventuellement vide)
4. Le renvoi (éventuellement vide)
5. La longueur du sens trouvé (nombre de caractères)

- [`Bailly_es_sens.csv`](raw/eulexis/Bailly_es_sens.csv) : le sens est non-vide et le renvoi est vide
- [`Bailly_es_renv.csv`](raw/eulexis/Bailly_es_renv.csv) : le sens est vide et le renvoi est non-vide
- [`Bailly_es_probl.csv`](raw/eulexis/Bailly_es_probl.csv) : le sens est non-vide et le renvoi est non-vide (ce sont quelques cas qui posent problème puisqu'en principe sens et renvois sont exclusifs)

#### Fichiers extraits du Bailly :

- Le fichier [`Bailly_renv.csv`](raw/eulexis/Bailly_renv.csv) contient les entrées identifiées comme des renvois (il y en a 15 436 -il n'a quasiment pas changé car les renvois des cas complexes sont restés dans les sens puisque, la plupart du temps, ce n'est qu'une acception parmi d'autres qui donne un renvoi). Les lignes contiennent trois champs : l'entrée, le renvoi et les indications trouvées. Ces dernières sont : désinences (*des*), génitif (*gens*) et article (entre parenthèses), éventuellement aussi quelques mots clefs. Elles sont maintenant groupées dans un seul champ (éventuellement vide). Il faut noter que je n'ai pas vérifié si le renvoi existe, comme entrée ou sous-entrée. Mais il n'est pas nécessaire de vérifier que tous les renvois mènent quelque part, puisqu'on n'est pas sûr que tous les renvois soient utiles (une première estimation dit qu'environ un tiers des renvois sera utile). Quand on fera la recherche d'un lemme (du **lexique**) et qu'on trouvera un renvoi ne menant nulle part, il sera temps de s'en occuper...
```TSV
ἀϐόατος	> ἀϐόητος	
ἀϐόηθος	> ἀϐοήθητος	des : ος, ον, 
ἀϐουλί	> ἀϐουλήτως	adv. 
ἁϐροσύνη	> ἁϐρότης	gens : ης (ἡ) 
ἁϐροχαίτης	> ἁϐροκόμης	gens : ου, adj. m. 
Ἀϐυδηνοκόμης	> Ἀϐυδοκόμης	
```
- Le fichier [`Bailly_sens.csv`](raw/eulexis/Bailly_sens.csv) est le fichier principal. Comme son nom l'indique, il contient les entrées pour lesquelles je pense avoir réussi à isoler un sens (il y en a 89 374). Il contient les entrées (première colonne), le sens trouvé (2e colonne), le nombre de caractères que compte le sens (3e colonne, uniquement pour repérer facilement les sens qui sont trop longs et qui mériteraient d'être abrégés). Viennent ensuite les indications relevées (4e colonne).
```TSV
ἀασμός	exhalaison, souffle	19	gens : οῦ (ὁ) 
1 ἄατος	insatiable de	13	des : ος, ον 
2 ἄατος	pernicieux, funeste	19	des : ος, ον 
2 ἀάω	rassasier	9	
ἀϐαθής	sans profondeur	15	des : ής, ές 
...
ᾠώδης	qui ressemble à un œuf, ovale, ovoïde	37	des : ης, ες, 
ἀάατος	inviolable ; invincible ; très pénible	38	des : ος, ον 
1 ἀάω	troubler l'esprit, frapper de vertige ou de folie, avoir l'esprit égaré ; frapper d'une calamité, causer un malheur ; troubler l'esprit, égarer, tromper ; commettre une faute par aveuglement d'esprit	199	tr. intr. 
```
    Les sens tirés des cas complexes ont été ajoutés à la fin du fichier obtenu avec les cas simples. Dans l'exemple ci-dessus, on voit à la fin deux mots qui devraient s'intercaler parmi ceux du début. On voit aussi que **1 ἀάω** est formé du groupement des divers sens (séparés par un ";") et qu'il est devenu trop long.
- Le fichier [`Bailly_subst.csv`](raw/eulexis/Bailly_subst.csv) contient les substantifs et les adverbes qui sont perdus dans d'autres articles (souvent des adjectifs, parfois des verbes). Il y a 5 243 lignes (un même mot peut apparaître plusieurs fois ; je n'ai pas encore fait de tri -s'il faut en faire un). Elles donnent :
    1. l'article (pour les substantifs) ou le mot-clef *adv.* (pour les adverbes)
    2. la forme (comme elle était parfois abrégée, je l'ai reconstituée à la main, en espérant ne pas avoir écrit trop d'horreurs -je n'ai aucune connaissance en Grec)
    3. le sens
    4. le lemme (l'entrée du Bailly) où j'ai trouvé ce mot
    5. les indications relatives à l'entrée du dico et **pas** au mot trouvé
```TSV
οἱ	ἐπίλεκτοι	soldats d'élite	ἐπίλεκτος	des : ος, ον, 
τὰ	ἐπίλυτρα	la rançon	ἐπίλυτρος	des : ος, ον, 
ἡ	ἐπιμελητική	l'art de prendre soin de, diligence, vigilance	ἐπιμελητικός	des : ή, όν, 
adv.	ἐπίμεστα	en surabondance	ἐπίμεστος	des : ος, ον, adv. 
τὸ	ἐπιμόριον	nombre contenant un entier plus une fraction avec 1 pour numérateur	ἐπιμόριος	des : ος, ον, 
adv.	ἐπίμοχθον	laborieusement	ἐπίμοχθος	des : ος, ον adv. 
ὁ	ἐπίνικος	chant de victoire	ἐπίνικος	des : ος, ον 
...
τὸ	ἐπίκωπον	navire muni de rames	ἐπίκωπος	des : ος, ον 
τὸ	ἐπιμελές	soin ou sollicitude pour	ἐπιμελής	des : ής, ές 
τὰ	ἐπιμήνια	sacrifices mensuels ; provisions ou dépenses mensuelles ; menstrues	ἐπιμήνιος	des : ος, ον subst. adj. 
...
τὰ	ἐπιφερόμενα	les offrandes qu'on dépose sur un autel ou sur une tombe en l'honneur d'un mort	ἐπιφέρω	tr. intr. 
τὰ	ἐπιφερόμενα	les événements futurs, l'avenir	ἐπιφέρω	tr. intr. 
```
    Ici aussi, les mots dérivés issus des cas complexes viennent en deuxième partie. Je donne aussi un exemple où le même mot apparaît avec deux sens différents *τὰ ἐπιφερόμενα*.

    Ce dernier fichier [`Bailly_subst.csv`](raw/eulexis/Bailly_subst.csv) est probablement le plus *discutable*. D'une part, il contient peut-être des horreurs dues à mon ignorance de Grec. D'autre part, il pose une question plus fondamentale de savoir quand un adjectif substantivé devient un lemme à part entière. Y a-t-il un critère objectif pour trancher la question ? On peut souvent estimer qu'il y a un substantif sous-entendu (pour donner le genre) et que l'adjectif reste un qualificatif de ce nom inexistant (pas sûr que ça aide beaucoup un étudiant débutant).
