# About the data in this folder

## Alpheios dictionary data

* **[data/bailly-grc-defs.dat](../data/bailly-grc-defs.dat)** contains an initial pass of the Alpheios Bailly data file, for all of the lemmas found in the Bailly files with the French definitions, and for any other lemmas from LSJ that were not found, the English definitions from LSJ.

* **[test/index.html](../test/index.html)**  can be used to test the defs file with Alpheios . You should see  a page with a small excerpt from Sophocles Ajax, and Alpheios embedded with a build of the code that has the Bailly+LSJ short defs file. (This should automatically be selected as the default short definition lexicon, if it's not for some reason you can select that by going to the resources tab of the Alpheios options dialog).  Not many of the words from that passage were among the ones that have French definitions, but you can see how they look if you double-click on "σε" . You can also enter any greek word in the lookup box. I threw a quick credits statement together, but this will need to be polished and expanded upon.

## Eulexis alignment data

* **[data/Eulexis_Bailly_align.csv](Eulexis_Bailly_align.csv)** contient le résultat de l'alignement des *lemmes* d'Eulexis (i.e. de Diogenes) avec les divers fichiers extraits du Bailly (seulement les cas simples). Le contenu des colonnes est indiqué sur la première ligne :
1. lemme (d'Eulexis) en unicode
2. le même en betacode
3. le mot s'il est trouvé dans le fichier `Bailly_sens.csv`
4. le mot s'il est trouvé dans le fichier `Bailly_renv.csv`
5. le mot s'il est trouvé dans le fichier `Bailly_subst.csv`
6. le mot s'il est trouvé dans le fichier `Bailly_es_sens.csv`
7. le mot s'il est trouvé dans le fichier `Bailly_es_renv.csv`
8. le nombre de mots trouvés dans les fichiers

Si le *lemme* n'a été trouvé dans aucun des fichiers, je fais une deuxième tentative en supprimant les signes diacritiques et l'éventuelle majuscule. Pour distinguer les lignes issues de cette deuxième tentative, je les fais commencer par un point d'interrogation et le nombre de mots trouvés est augmenté de 100.



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

@PhVerkerk a déposé une série de fichiers qui correspondent au traitement des cas simples (définis plus bas). Les fichiers **txt** contiennent des données brutes, alors que les **csv** sont le résultat d'un traitement (en réalité, les fichiers txt sont aussi issus du traitement de mon fichier intermédiaire). Le fichier zippé, [`Bailly_tout.txt.zip`](raw/eulexis/Bailly_tout.txt.zip) (qui était un peu trop gros et assez inutile), correspond à mon fichier intermédiaire, dans lequel il a explicité les substantifs abrégés (sous la forme *{ὁ ἀγ.}*) et remplacé les renvois au mot suivant ou précédent par ledit mot. Le fichier [`Bailly_vide.txt`](raw/eulexis/Bailly_vide.txt) contient les entrées pour lesquelles je n'ai pas su isoler de sens (il y en a 2 975). Elles semblent correspondre à des formes verbales qui se contentent de renvoyer au verbe (en précisant les temps et mode). Le troisième fichier, [`Bailly_complex.txt`](raw/eulexis/Bailly_complex.txt), contient les entrées que @PhVerkerk a considérées comme complexes et que doivent encore être traitées. Il y en a 16 740...

Le format de donnés CSV est composé de 5 champs :
1. Le lemme
2. L'entrée secondaire (éventuellement plusieurs variantes)
3. Le sens trouvé (éventuellement vide)
4. Le renvoi (éventuellement vide)
5. La longueur du sens trouvé (nombre de caractères)

Fichiers:

- [`Bailly_es_sens.csv`](raw/eulexis/Bailly_es_sens.csv) : le sens est non-vide et le renvoi est vide
- [`Bailly_es_renv.csv`](raw/eulexis/Bailly_es_renv.csv) : le sens est vide et le renvoi est non-vide
- [`Bailly_es_probl.csv`](raw/eulexis/Bailly_es_probl.csv) : le sens est non-vide et le renvoi est non-vide
- Le fichier [`Bailly_renv.csv`](raw/eulexis/Bailly_renv.csv) contient les entrées identifiées comme des renvois (il y en a 15 434). Les lignes contiennent deux champs principaux : l'entrée et le renvoi. Viennent ensuite les indications trouvées : désinences (*des*), génitif (*gens*) et article (entre parenthèses), éventuellement aussi quelques mots clefs. Elles sont aussi, en général, séparées par des tabulations, mais je pourrais modifier mon code pour que tout ce qui relève des *indications* soit dans un seul champ. Il faut noter que je n'ai pas vérifié si le renvoi existe, comme entrée ou sous-entrée. Mais il n'est pas nécessaire de vérifier que tous les renvois mènent quelque part, puisqu'on n'est pas sûr que tous les renvois soient utiles. Quand on fera la recherche d'un lemme (du **lexique**) et qu'on trouvera un renvoi ne menant nulle part, il sera temps de s'en occuper...
```TSV
ἀϐουλί	> ἀϐουλήτως	adv.
ἁϐροσύνη	> ἁϐρότης	gens : ης	(ἡ)
ἁϐροχαίτης	> ἁϐροκόμης	gens : ου,	adj. m.
Ἀϐυδηνοκόμης	> Ἀϐυδοκόμης
```
- Le fichier [`Bailly_sens.csv`](raw/eulexis/Bailly_sens.csv) est le fichier principal. Comme son nom l'indique, il contient les entrées pour lesquelles je pense avoir réussi à isoler un sens (il y en a 72 652). Il contient les entrées (première colonne), le sens trouvé (2e colonne), le nombre de caractères que compte le sens (3e colonne, uniquement pour repérer facilement les sens qui sont trop longs et qui mériteraient d'être abrégés). Viennent ensuite les indications relevées (en nombre variable, comme dans le cas des renvois). On pourra donc avoir des lignes avec trois champs peuplés (typiquement pour un verbe), quatre (souvent pour les adjectifs, avec seulement un *des*), cinq (généralement les noms, avec un *gens* et un article pour donner le genre) et, plus rarement, six (un adjectif avec un *des*, un *gens* et un ou plusieurs mots-clefs, parce qu'il a donné un adverbe ou un substantif).
```TSV
ἀασμός	exhalaison, souffle,	20	gens : οῦ	(ὁ)
1 ἄατος	insatiable de,	14	des : ος, ον
2 ἄατος	pernicieux, funeste,	20	des : ος, ον
2 ἀάω	rassasier,	10
ἀϐαθής	sans profondeur,	16	des : ής, ές
Ἄϐαι	Abes, (v.)	10	gens : ῶν	(αἱ)
```
- Le fichier [`Bailly_subst.csv`](raw/eulexis/Bailly_subst.csv) contient les substantifs et les adverbes qui sont perdus dans d'autres articles (souvent des adjectifs, parfois des verbes). Comme je n'ai traité que les cas simples, il n'y a que 2 454 lignes. Les lignes sont une fois de plus de longueur variable. Elles donnent :
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

Ce dernier fichier [`Bailly_subst.csv`](raw/eulexis/Bailly_subst.csv) est probablement le plus *discutable*. D'une part, il contient peut-être des horreurs dues à mon ignorance de Grec. D'autre part, il pose une question plus fondamentale de savoir quand un adjectif substantivé devient un lemme à part entière. Y a-t-il un critère objectif pour trancher la question ? On peut souvent estimer qu'il y a un substantif sous-entendu (pour donner le genre) et que l'adjectif reste un qualificatif de ce nom inexistant (pas sûr que ça aide beaucoup un étudiant débutant).
