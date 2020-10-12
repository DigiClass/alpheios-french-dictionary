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

## Précision (6 octobre 2020)

L'Unicode est redondant, en particulier pour le grec. En effet, il contient une section **Greek** (entre U+0370 et U+03FF) et une section **Extended Greek** (entre U+1F00 et U+1FFF). La première contient les caractères grecs nus et les voyelles avec un accent aigu _with tonos_, ainsi que celles avec trémas (iota et upsilon, _with dialytika_) et les deux. Les voyelles avec un esprit, un iota-souscrit, un accent grave ou un périspomène (ainsi que des combinaisons) sont dans la section **Extended Greek**. Plus surprenant, dans cette section, on (re)trouve les voyelles avec un accent aigu, dit _with oxia_. Le *Consortium Unicode* recommande d'utiliser les _with tonos_ au détriment des _with oxia_. Toutefois, les Éditeurs du Bailly 2020 en ont décidé autrement et je suis en accord avec eux. En effet, vu que les combinaisons esprit + accent n'existent que dans l'extension (_with dasia and oxia_ ou _with psili and oxia_), il est cohérent et logique de porter son choix sur les voyelles _with oxia_ quand elles ne portent pas d'esprit. Je pense qu'il faut entendre la section **Greek** comme étant pour le grec moderne et l'**Extended Greek** pour le grec ancien. Sauf que bien sûr, les caractères nus ou avec des trémas (seuls) ne figurent que dans la section **Greek**.

Cela ne va pas sans causer des problèmes, car bien souvent la saisie au clavier ne vous prévient pas du caractère qu'elle choisit. C'est d'ailleurs la raison qui a poussé Philipp Roelli à me demander de développer Eulexis pour pouvoir consulter les dictionnaires de grec sans buter sur ce problème de redondance (en 2014, nous venions de publier Collatinus). Je pense même que ά et ά sont exactement identiques (**pas** avec le visualiseur de md sur GitHub !) mais un ordinateur ne les verra pas comme tels puisqu'ils ont des codes différents : U+03AC et U+1F71 (je viens de découvrir que dans mon message d'hier soir, ils sont devenus identiques : quelqu'un -probablement Thunderbird-, en recopiant mon message, a remplacé le _alpha with oxia_ par un _alpha with tonos_, ce qui affaiblit ma démonstration).

En bref, il est toujours dangereux de comparer des mots grecs écrits en Unicode. Mieux vaut les convertir en betacode (c'est ce que je fais dans Eulexis). Je mets dans le répertoire `data` le fichier qui me sert à la conversion. Dans le sens Unicode vers betacode, les deux betas, les deux sigmas et les deux variétés de voyelles accentuées sont remplacés par le même betacode (b, s, a/ etc.). Dans le sens inverse (betacode -> Unicode) l'ordre des lignes correspondantes à son importance et il faut réserver un traitement spécial au beta initial et au sigma final. J'ai même ajouté le µ (micro sign, U+00B5) qui se distingue du μ (mu minuscule, U+03BC), parce que j'ai eu entre les mains un texte où les mu étaient codés avec ce U+00B5. Je n'y ai pas mis le _Ohm sign_ Ω (U+2126) qui n'est guère différent du Ω (U+03A9), car personne n'a encore pensé à l'utiliser.

Pour ceux que ça intéresse, on peut trouver des infos sur les [formes normalisées D, C, KC et KD](https://unicode.org/reports/tr15/). Il faudrait d'ailleurs regarder en détail, car il y a peut-être des *méthodes* pour comparer efficacement des chaines de caractères (sans passer par le betacode). Cela dit, ce n'est pas nécessairement plus simple, ni plus économique (en terme de calcul).

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

## Lundi 12 octobre 2020

J'ai fait mon programme d'extraction des cas complexes. Il commence par prélever tous les substantifs et adverbes qui sont entre accolades. Parmi les lignes qui restent, il cherche la plus courte (en nombre de tab.) qui contient des informations pertinentes (qui ne se termine pas par une tabulation), puis collecte toutes les infos qu'il trouve sur les lignes de même longueur. J'ai en cela abaissé mes objectifs, puisque si une ligne de la bonne longueur est vide, je ne vais pas chercher les sens donnés dans les sous-rubriques. Une entrée qui ne donne que des substantifs sera considérée comme vide (dans le fichier `Bailly_vide_c.txt`).
```TSV
Βουκολίων,	160239	
	160240	@		1	{ὁ Βουκολίων} Boukoliôn (h.)
	160244	@		2	{ἡ Βουκολίων} Boukoliôn, (v.)
gens : ωνος	
OK
<<	160240	@		1	
<<	160244	@		2	
```
Les lignes précédées de "<<" sont ce qui me reste quand j'ai extrait les substantifs. Ici, la même forme aux deux genres (masculin et féminin) correspond à deux objets différents : je pense qu'il faut les considérer comme deux lemmes différents.

Le fichier `Bailly_complex.txt` ayant perdu de son intérêt, puisque je l'ai traité, a été zippé. J'ai créé des fichiers intermédiaires `Bailly_sens_c.txt` et `Bailly_subst_c.txt` dont j'ai recollé le contenu à la fin des fichier `Bailly_sens.csv` et `Bailly_subst.csv`. Je n'ai pas rétabli l'ordre alphabétique, donc ce qui est issu des cas complexes peut se retrouver (il est après la fin des premiers oméga). Je n'ai pas considéré les renvois qui apparaissent dans les cas complexes. On aura par exemple :
```TSV
ἀγεληΐς	> ἀγελαῖος ; > ἀγελείη	22	gens : ΐδος (ἡ) 
ἄγκυρα	ancre ; croc de laboureur ; > αἰδοῖον	37	gens : ας (ἡ) 
```
Il y a plus de 300 tels renvois. Il n'est probablement pas urgent de se demander quoi en faire, puisqu'il y a de fortes chances pour que ces entrées ne servent pas.

Pour les nombres, je suis maintenant à 89 374 entrées avec une (ou des) traduction(s) dans `Bailly_sens.csv` et 5 243 dérivés dans `Bailly_subst.csv` (dans ce dernier, un même mot peut apparaître plusieurs fois ; je n'ai pas encore fait de tri -s'il faut en faire un).

## Dimanche 11 octobre 2020

J'ai fait quelques modifs dans mon fichier d'origine et dans mon programme d'extraction. En particulier, j'ai supprimé les tabulations dans les indications morphologiques, si bien que le nombre de colonnes dans les fichiers est constant. J'ai aussi supprimé les virgules, points-virgules et deux-points à la fin des traductions. Il reste des points en fin de traduction, il y en a qui sont nécessaires (dans "ch." ou "J.C.", par exemple). Les modifs faites dans le fichier d'origine a permis d'ajouter 36 lignes à mon fichier `Bailly_sens.csv` (72 688).

## Samedi 10 octobre 2020

Au hasard de mes explorations, j'ai constaté deux choses assez intéressantes :
1. Les accents et les esprits ne sont pas toujours les mêmes dans le LSJ et dans le Bailly.
2. Un certain nombre de traductions restées blanches dans Eulexis correspondent à des entrées du LSJ qui se résument à un renvoi. Par exemple, `ἅρπασις εως, ἡ, = ἁρπαγμός, Phryn. PS p. 65B.` ou `ἄρομα ατος, τό, f.l. for ἄρωμα, Luc. Lex. 2, Ael. NA 7.8, cf. AB 450.`. Il serait peut-être astucieux (et pas trop coûteux) d'organiser une chasse pour retrouver ces renvois et insérer la traduction correspondante. Je pourrais faire ça en modifiant ma fonction spéciale `void Lemmat::repairTransl(QString nom)` appelée provisoirement par `void MainWindow::majT()` dans Eulexis.

Les exemples pour les différents esprits ne manquent pas : `ἁμός2 (LSJ) = ἀμός (Bailly)` ou `ἄρμα2 (LSJ) = 2 ἅρμα (Bailly)`. Ce dernier ne figure pas dans les lemmes que j'ai dans Eulexis. Mais c'est évidemment faux car sous le lemme ** ἄρμα** sont rangées des formes neutres `ἄρμα ¹ ατος, τό, (< αἴρω) that which one takes ; food` et des formes féminines `ἄρμα ² ἡ, (< ἀραρίσκω) union, love`. C'est étrange, je ne retrouve pas ce lemme dans la liste de Logeion des lemmes les plus fréquents (nb d'occ. ≥ 5), pourtant mon tableau de flexion me donne au moins 30 formes différentes (et plus de 5 pour chacun des genres).

## Vendredi 9 octobre 2020

Pour que mes fichiers csv soient plus normalisés, j'ai décidé de grouper toutes les indications collectées dans un seule colonne. Mais du coup, tous les fichiers vont changer. J'ai découvert qu'il était imprudent de faire certaines modifs. Par exemple, j'ai relevé :
```TSV
κλισιάς,	463844	{αἱ κλισιάδες} grande porte :
```
que j'avais envie de transformer en :
```TSV
κλισιάς,	463844	(d'ord. au plur. αἱ κλισιάδες) grande porte :
```
Toutefois, ce serait une erreur car parmi mes *lemmes* j'ai **κλισιάδες**, mais pas **κλισιάς**. Je décide donc de repasser ces cas modifiés en cas complexes que je vais traiter en trichant : la même traduction sera donnée au singulier κλισιάς (dans Bailly_sens) et au pluriel αἱ κλισιάδες (dans Bailly_subst). C'est d'autant plus intéressant que ça va donner une traduction à un mot qui n'en avait pas, car dans le LSJ κλισιάδες se résume à un renvoi vers κλεισιάδες.

Plutôt que de chercher directement des traductions comme l'a fait Bridget, j'ai préféré aligner les fichiers au préalable. L'idée est que ça me permettra de choisir les candidats quand il y en a plus d'un (ou quand il n'y en a pas d'exact).

## Jeudi 8 octobre 2020

Je commence à réfléchir à l'étape *d'après*, à savoir la vérification des traductions. En réalité, pour les traductions françaises, il y aura un choix à faire en même temps que la correction. En effet, j'ai traduit en français les traductions anglaises et les traductions obtenues sont parfois meilleures que celles que je tire du Bailly. Par exemple, pour **ὁράω**, mon algo pour les cas complexes va donner simplement **voir** (il y a un "A intr. voir" et un "B tr. voir"), alors qu'actuellement j'ai dans mon fichier de traductions **voir, regarder, pouvoir voir**. Sans rien savoir du grec, j'ai l'impression que cette dernière est plus intéressante. Évidemment, il y en a aussi des complètement foireuses.

Je vais bien sûr m'appuyer sur ce que j'ai déjà fait pour les traductions anglaises d'Eulexis. Mais plusieurs questions se posent :
- Ajouter un bouton (4 au lieu de 3) pour choisir la traduction déjà existante ou celle du Bailly ?
- Donner la traduction anglaise seulement comme guide ou donner la possibilité de l'éditer ?
- En profiter pour revoir les traductions en allemand ? Ou réserver ça pour une autre entreprise d'envergure ? Le problème majeur étant que tous les hellénistes ne sont pas germanophones. Si on met la traduction en allemand éditable, comment saura-t-on après coup si la traduction a été jugée acceptable ou si elle n'a pas été évaluée ? Inversement, relira-t-on jamais les traductions, si ce n'est pas maintenant.

## Mercredi 7 octobre 2020

Un petit commentaire sur une des dernières phrases de Bridget : _Not many of the words from that passage were among the ones that have French definitions, but you can see how they look if you double-click on "σε"_. J'espère que plus de traductions viendront des cas complexes. On peut penser que les mots fréquents acquièrent plus souvent des sens variés et conduisent donc à des articles avec rubriques et sous-rubriques. Et on revient à ma dernière phrase du 3 octobre : traiter les cas complexes !

## Mardi 6 octobre 2020 (Bridget)

Here are the results of the first pass through matching the Bailly lemmas in Bailly_sens.csv and Bailly_renv.csv with the Alpheios LSJ short defs index. I was able to match 46,598 entries (some of which are duplicates for the weird Alpheios capitalization handling).  48,815 out of 93,557 entries in the Alpheios LSJ index were NOT matched.  So we're about half-way there :-)

I've included the various scripts I've used as well, just to keep everything in one place -- these are not anything I would recommend anyone try to use, particularly the perl scripts :-). Possibly of interest is the XSLT for converting from unicode->betacode->unicode -- this is what we've used for years with Alpheios, including for our LSJ short defs index, so I ran the Bailly_sens.csv and Bailly_renv.csv files through them to ensure consistency.

Files of interest:

* **raw_data/alpheios/matched.csv**: this contains the lemmas for which I could find an exact match (or exact match excluding initial capital) in the Alpheios LSJ index

* **raw_data/alpheios/nolsj.csv**: this contains the lemmas from the Bailly files that I could not match in the Alpheios LSJ index.

* **raw_data/alpheios/nobailly.csv**: this contains the lemmas from the Alpheios LSJ index that I could not match in the Bailly files.

* **raw_data/alpheios/morphdiff.csv**: this contains a subset of the lemmas in nolsj.csv (i.e the lemmas found in Bailly and not in the LSJ index) that morpheus parsed as a different lemma (and the corresponding LSJ short def for that lemma) (TargetWord is the lemma from Bailly, LemmaWord is the lemma from LSJ)

* **raw_data/alpheios/propernouns.csv**: this contains a subset of the lemmas in nolsj.csv that morpheus parsed as a different lemma that are likely to be proper nouns. In some cases, the initial sense of the propernoun WAS found in the LSJ index but additional senses were not (if a lemma in here has sense indicators and the plain lemma without the sense isn't listed, then a single sense was matched in the LSJ index)

Finally, 

* **data/bailly-grc-defs.dat** contains an initial pass of the Alpheios Bailly data file, for all of the lemmas found in the Bailly files with the French definitions, and for any other lemmas from LSJ that were not found, the English definitions from LSJ.

* **test/index.html**  can be used to test the defs file with Alpheios . You should see  a page with a small excerpt from Sophocles Ajax, and Alpheios embedded with a build of the code that has the Bailly+LSJ short defs file. (This should automatically be selected as the default short definition lexicon, if it's not for some reason you can select that by going to the resources tab of the Alpheios options dialog).  Not many of the words from that passage were among the ones that have French definitions, but you can see how they look if you double-click on "σε" . You can also enter any greek word in the lookup box. I threw a quick credits statement together, but this will need to be expanded upon (and typos fixed :-) ).

## Samedi 3 octobre 2020

Le fichier `data/Eulexis_Bailly_align.csv` contient le résultat de l'alignement des *lemmes* d'Eulexis (i.e. de Diogenes) avec les divers fichiers extraits du Bailly (seulement les cas simples). Le contenu des colonnes est indiqué sur la première ligne :
1. lemme (d'Eulexis) en unicode
2. le même en betacode
3. le mot s'il est trouvé dans le fichier `Bailly_sens.csv`
4. le mot s'il est trouvé dans le fichier `Bailly_renv.csv`
5. le mot s'il est trouvé dans le fichier `Bailly_subst.csv`
6. le mot s'il est trouvé dans le fichier `Bailly_es_sens.csv`
7. le mot s'il est trouvé dans le fichier `Bailly_es_renv.csv`
8. le nombre de mots trouvés dans les fichiers

Si le *lemme* n'a été trouvé dans aucun des fichiers, je fais une deuxième tentative en supprimant les signes diacritiques et l'éventuelle majuscule. Pour distinguer les lignes issues de cette deuxième tentative, je les fais commencer par un point d'interrogation et le nombre de mots trouvés est augmenté de 100.

J'ai ajouté une comparaison sans diacritique et sans majuscule pour les *lemmes* non-trouvés. Ça me permets de repêcher 4 144 correspondances. Mais certaines ne sont pas convaincantes, car elles associent un mot avec majuscule à un mot sans. Toutefois, on pourrait admettre `? Ὕψιστος	uyistos	ὕψιστος`, d'autant que le LSJ dit *one of the gates of Thebes was called Ὕψισται from his temple there*. Il y a des esprits opposés `? Ἅλυκος	alukos	Ἄλυκος, Ἄλυκος, ἁλυκός` (le premier avec _*(/a_ et les autres avec _*)/a_). Qui a raison ? Qui a tort ?

Je reprends l'index commun aux quatre dicos que j'utilise dans Eulexis_web et je le réduis à l'alignement des LSJ et Bailly 2020. Je mets le résultats dans `data/index_LSJ_Bailly.csv`. Je le vois comme un moyen d'évaluer les richesses comparées des deux dicos. J'ai 158 643 lignes dont 30 782 vides dans la colonne du LSJ et 47 399 dans celle du Bailly. On peut donc tabler sur un recouvrement des dicos sur 80 462 mots. Deux mots qui diffèrent par leurs signes diacritiques peuvent de retrouver sur une même ligne puisque l'alignement ne tient pas compte des signes diacritiques. Cela ne devrait se produire que quand plusieurs mots ne diffèrent que par les diacritiques. Ça pourrait permettre de repérer des conflits d'accents entre les deux dicos...

La première colonne est la base commune : l'entrée sans diacritique, ni majuscule, ni indice d'homonymie. La deuxième colonne donne l'entrée du LSJ et la troisième l'entrée du Bailly. En cas d'entrées multiples, j'utilise autant de ligne que nécessaire. Le cas d'ἄατος est intéressant
```TSV
αατος	ἄατος	ἄατος1
αατος	ἄατος ²	ἄατος2
αατος		ἄατος3
```
En effet, `ἄατος ² = ἄατος3` et `ἄατος ≈ ἄατος1` sauf que `ἄατος2`, qui donne un sens assez différent de `ἄατος1`, renvoie à la même citation que le LSJ dans `ἄατος` (A. Rh. 1, 459).

Il faudrait que j'essaie avec la liste des lemmes de Logeion dont la fréquence est supérieure à 5 (strictement, 19 844 et égale à 5, 1 958 suplémentaires).

Clairement, il faut aussi que je traite les cas complexes.

## Vendredi 2 octobre 2020

Hier soir, j'ai poussé sur GitHub mes fichiers et je me suis aperçu ce matin que les dernières modifs dans mon code me faisaient perdre les sens du premier substantif dans une série de deux. Cela ne concerne que 92 cas, mais je l'ai corrigé.

Je pirate une de mes fonctions dans Eulexis pour aligner son lexique avec les fichiers que j'ai déjà créés. Pour cela, je charge les entrées de ces fichiers dans autant de multiMap que nécessaire et ensuite, pour chaque lemme du lexique d'Eulexis, je regarde les entrées qui correspondent (je les compte et les indique). En travaillant seulement avec ce que j'ai (je n'ai pas encore traité les cas complexes), j'ai 1 218 *lemmes* pour lesquels j'ai plusieurs candidats. Et 61 648 qui n'ont pas trouvé de candidat. Ça me semble trop, même sur mes 116 350 lemmes : plus de la moitié... Évidemment, ça pourra s'améliorer avec le traitement des cas complexes, mais ils ne sont que 16 740.

Les lemmes ayant trouvé un et un seul candidat sont 53 683, dont 47 628 dans le fichier avec un sens. Les autres sont 5 298 renvois, 155 substantifs, 384 entrées secondaires avec un sens et 218 entrées secondaires avec renvoi. Si on regarde ça de l'autre point de vue, on arrive à la conclusion que plus d'un tiers des entrées du Bailly pour lesquelles on a un sens n'est pas utilisé dans Perseus (ou ne figure pas dans le LSJ ?).

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

