# Alpheios Ancient Greek → French dictionary

## Notes sur les fichiers que je mets dans le dossier "data".

A priori, je vais essayer de dater mes commentaires qu'il faut considérer comme des *mises à jour*, c'est à dire qu'il faudrait les lire *de bas en haut*.

## Vendredi 25 septembre 2020

## Jeudi 17 septembre 2020

Avant les vacances, j'ai traité l'ensemble du **Bailly 2020** pour en extraire automatiquement les sens, tout en conservant la structure des articles en *sections, rubriques et paragraphes* (quand ils existent !). J'ai aussi essayé de trouver les mots "cachés" dans les articles, en particulier les adjectifs substantivés qui prennent un sens spécial.

Maintenant, j'ai mouliné ces données pour séparer les cas *simples* des cas *plus compliqués*. Je considère comme simples les articles dans lesquels il n'y a pas de structure (un seul sens) ou ceux pour lesquels un sens général est donné avant toute structure `(par exemple, "θρίξ,	poil" qui est ensuite détaillé en cheveux, poils du corps, crins etc...)`. Pour l'instant, je n'ai traité que ces entrées-là. Ce qui m'a donné 72 600 sens et 2500 substantifs ou adverbes dérivés. Il reste environ 16 700 articles qui présentent une structure plus ou moins élaborée qu'il me faut encore mouliner. Se cachent aussi environ 3000 substantifs ou adverbes dans ces articles complexes. Ce dernier chiffre est approximatif car, dans les cas de polysémie, un même substantif (féminin singulier, par exemple) peut apparaître dans plusieurs rubriques, donc avec des sens différents.

Deux cas particuliers sont apparus dans le traitement des cas simples : les renvois et les "articles vides". Ces derniers correspondent bien souvent à des formes verbales (adj. verb., part., futur, etc.) non-triviales ou des crases. Je pense donc que nous pouvons les ignorer, mais il faudrait sans doute qu'un helléniste parcourt le fichier pour vérifier qu'il n'y a pas d'oubli (il y a environ 3300 entrées dans ce fichier). Dans un premier temps, il y avait un certain nombre de sens comme "autre n. de la plante xxx" ou "dim. de yyy' qui avaient échappé au traitement (il doit en rester).

Les renvois posent un problème sérieux, car ils sont nombreux (~15 200) et il y en a de plusieurs types (au moins trois) : 

- les variantes (ortho)graphiques `(par exemple, ἅϐα	> ἥϐη)`
- des formes verbales qui renvoient au lemme `(par exemple, ἀάσθην	> ἀάω)`
- un substantif renvoie à un adjectif, parce que ledit subst. est mentionné dans l'article de l'adjectif `(par exemple, Αἰγεῖον	> Αἰγεῖος et dans cet article on lit τὸ Αἰγεῖον, DIN. (Bkk. 354) temple d’Égée)` ou réciproquement, `(δμήτειρα, adj. f.	> δμητήρ, subst. masc.)`.

Il y a une autre famille de renvois que je n'ai pas encore relevés (du moins pas ici) : il s'agit des variantes (ortho)graphiques ou dialectales données par Bailly dans l'article même. Elles sont repérées dans le fichier TeX par la commande **\es{...}** et il y en a 3900. Par exemple, `"\entree{ἀκοστάω} \ital{ou} \es{ἀκοστέω}"` et on n'a pas d'entrée *"ἀκοστέω"* qui renverrait au lemme *"ἀκοστάω"*. Évidemment, il y a aussi des cas où le renvoi explicite existe `(par exemple, βροῦλλον,	> βρύλλον et plus loin, "βρύλλον ou βροῦλλον, ου (τὸ) c. σπάρτον," ; exemple qui illustre aussi le problème des doubles renvois)`.

Au mois d'avril, j'avais essayé une *autre* méthode pour extraire les sens, qui conservait les entrées secondaires. Mais sur laquelle je n'ai pas beaucoup retravaillé. Il faut se méfier des cas où il y a un renvoi et des entrées secondaires, car bien souvent il s'agit d'une collection de mots présentant une variation graphique commune et le renvoi est en réalité une collection de renvois. Par exemple : `ἀγλαΐη, Ἀγλαΐη, ἀγλαΐηφι, v. ἀγλαΐα, Ἀγλαΐα.`

