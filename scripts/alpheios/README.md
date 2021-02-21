Steps used to create the initial bailly-grc-defs.dat file:

1. Normalized all the greek unicode via the csvtoxml.pl and raw-beta-to-uni.xsl scripts 
2. align_bailly_lsj_eul.pl: Compared the LSJ lemmas from index_LSJ_Bailly.csv with the lemmas in the Alpheios grc-lsj-defs.dat file. (I found only 3796 entries from the Alpheios file that did not match with any in the index_LSJ_Bailly.csv. This discrepancy seems reasonable to me, given that the sources were not identical. (We extracted ours directly from the LSJ TEI XML file).) Since index_LSJ_Bailly.csv gives me the mapping of Eulexis LSJ lemma to Bailly lemma and  Eulexis_Bailly_align.csv gives me the mappping of Bailly lemma to Eulexis Lemma, I used these to create a mapping from Eulexis lemma to Eulexis LSJ lemma.  I found 681 lemmas in Eulexis that were different from the corresponding Eulexis LSJ lemma. 
3. align_eulexis.pl: processed the Eulexis_Bailly_sens.csv file and the Alpheios grc-lsj-defs.dat file to create the bailly-grc-defs.dat file. For every lemma found in Eulexis_Bailly_sens.csv, I used the Bailly definitions when it had one or more, otherwise I used the english definition from grc-lsj-defs.dat for the corresponding lemma. 

Steps to merge Eulexis corrections to Alpheios

1. Run `corrtoxml.pl <batch-dir-name>` to convert the files in the corrected batch directory to an aggregate XML file (will create a file named `<batch-dir-name>.xml` in `data/raw/alpheios/corrections`
2. Run the `raw-beta-to-uni.xsl` to normalize the Greek unicode in the batch xml file and create a csv file named `<batch-dir-name>.csv` in `data/raw/alpheios/corrections`
3. Run `merge-corr.pl <batch-dirname>` to update `data/bailly-grc-defs.dat` with the corrected data
4. Run 'update_ajax.pl to update the list of ajax definitions
5. Commit and push changes to GitHub
