# Fichier de test pour Eulexis et l'outil d'édition (15 octobre 2020).

J'ai sélectionné à la main une centaine de lemmes d'Eulexis (qui commencent par "a)/s" de **ἄσακτος** et débordent sur "a)/t" jusqu'à **ἄτολμος**) et j'ai joint ce que j'ai tiré du Bailly pour ces lemmes. J'ai dû supprimer arbitrairement une des lignes dans les cas où j'avais deux candidats pour un lemme, sauf bien sûr pour les homonymes **ἄσκοπος1** et **ἄσκοπος2** qui étaient faciles à aligner. Je n'ai pas fait de tri en fréquence, donc il est possible que parmi ces 138 lemmes il y en ait des rarissimes.

Le fichier est comme d'habitude un format CSV avec la tabulation comme séparateur. Provisoirement, il est composé de 7 champs :
- le lemme d'Eulexis en caractères grecs
- le même en betacode
- la traduction anglaise (le LSJ + améliorations d'Helma Dik, Logeion)
- le lemme trouvé dans le Bailly (attention, il peut être différent du lemme cherché : les ? du fichier [Eulexis_Bailly_sens.csv](../Eulexis_Bailly_sens.csv))
- la traduction française trouvée dans le Bailly
- la traduction (automatique) en français de la traduction anglaise
- la traduction (automatique) en allemand de la traduction anglaise

L'objectif de l'outil d'édition/sélection est de créer un fichier test0_revu.csv à partir de ce fichier test0.csv en donnant au relecteur la **possibilité** de modifier les traductions anglaise et française de chaque lemme (la question de la traduction en Allemand doit être discutée) et le **devoir** de choisir entre les deux traductions françaises si elles existent simultanément. Le fichier revu ne contiendra que 5 colonnes, éventuellement une 6e pour indiquer s'il s'agit d'un simple choix (par défaut), si une erreur a été trouvée et corrigée ou si la traduction a été améliorée ou raccourcie (et par qui ?). On aura donc :
- le lemme d'Eulexis en caractères grecs
- le même en betacode
- la traduction anglaise éventuellement éditée
- la traduction française choisie et/ou éditée
- la traduction (automatique) en allemand de la traduction anglaise
- des indications supplémentaires ?


Si je suis très fort, je pourrais ne pas infliger l'étape préliminaire de sélection des lignes adéquates mais mettre un menu déroulant (combo-box) en cas de prétendants multiples : il faut juste trouver comment mettre l'information dans le fichier à mouliner (et écrire le code correspondant). S'il y a plusieurs prétendants, le correcteur choisira le bon (ou le meilleur) et la traduction à éditer sera mise à jour automatiquement. Il faudra expliquer clairement que seule la ligne éditée, affichée au moment de la validation, est sauvée.

Mais, du coup, cela signifie que je dois développer en parallèle le module d'édition et la routine de construction du fichier à éditer. Je dois en effet décider ce que je veux faire et choisir un format qui permette de le faire. Il sera le même à l'écriture et à la lecture.
