Steps to merge Eulexis corrections to Alpheios

1. Run `corrtoxml.pl <batch-dir-name>` to convert the files in the corrected batch directory to an aggregate XML file (will create a file named `<batch-dir-name>.xml` in `data/raw/alpheios/corrections`
2. Run the `raw-beta-to-uni.xsl` to normalize the Greek unicode in the batch xml file and create a csv file named `<batch-dir-name>.csv` in `data/raw/alpheios/corrections`
3. Run `merge-corr.pl <batch-dirname>` to update `data/bailly-grc-defs.dat` with the corrected data
4. Commit and push changes to GitHub
