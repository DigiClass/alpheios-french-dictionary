/* Routine d'alignement écrite dans Eulexis en Qt 5. (13 octobre 2020)
*
* Les fonctions appelées font ce que leur nom indique :
* beta2unicode convertit la chaine en argument en elle-même avec des caractères grecs.
* uni2betacode fait l'inverse de la précédente
* nettoie convertit d'unicode en betacode et supprime tous les signes bizarres.
* nettoie2 suppose que la chaine est déjà en betacode et supprime les signes bizarres.
* initData charge le lexique et tout le nécessaire pour l'analyse et la traduction.
*
*/
void Lemmat::indexCommun()
{
    // Je pirate la construction de l'index commun pour faire un outil d'alignement
    if (_toInit) initData();
    QString racine = "/Users/Philippe/Documents/GIT/Alpheios_Bailly/data/raw/eulexis/";
    QMultiMap<QString,QString> sens;
    QMultiMap<QString,QString> subst;
    QMultiMap<QString,QString> renv;
    QMultiMap<QString,QString> es_sens;
    QMultiMap<QString,QString> es_renv;
    QMultiMap<QString,QString> sens_sd; // sans diacritique, ni majuscule.
    QMultiMap<QString,QString> subst_sd;
    QMultiMap<QString,QString> renv_sd;
    QMultiMap<QString,QString> es_sens_sd;
    QMultiMap<QString,QString> es_renv_sd;
    QString lg;
    QString lem;
    QString beta;
    QFile fichier (racine + "Bailly_sens.csv");
    fichier.open(QFile::ReadOnly | QFile::Text);
    while (!fichier.atEnd())
    {
        lg = fichier.readLine();
        if (lg.isEmpty()) continue;
        lem = lg.section("\t",0,0);
        beta = lem;
        if (beta[0].isDigit()) beta = beta.mid(2);
        if (beta[0] == '*') beta = beta.mid(1);
        if (beta.contains(" ")) beta = beta.section(" ",0,0);
        sens.insert(uni2betacode(beta),lem);
        sens_sd.insert(nettoie(beta),lem);
    }
    fichier.close();
    qDebug() << "Sens chargés";
    fichier.setFileName(racine + "Bailly_renv.csv");
    fichier.open(QFile::ReadOnly | QFile::Text);
    while (!fichier.atEnd())
    {
        lg = fichier.readLine();
        if (lg.isEmpty()) continue;
        lem = lg.section("\t",0,0);
        beta = lem;
        if (beta[0].isDigit()) beta = beta.mid(2);
        if (beta[0] == '*') beta = beta.mid(1);
        if (beta.contains(" ")) beta = beta.section(" ",0,0);
        renv.insert(uni2betacode(beta),lem);
        renv_sd.insert(nettoie(beta),lem);
    }
    fichier.close();
    qDebug() << "Renv chargés";
    fichier.setFileName(racine + "Bailly_subst.csv");
    fichier.open(QFile::ReadOnly | QFile::Text);
    while (!fichier.atEnd())
    {
        lg = fichier.readLine();
        if (lg.isEmpty()) continue;
        lem = lg.section("\t",1,1);
        beta = lem;
        if (beta[0].isDigit()) beta = beta.mid(2);
        if (beta[0] == '*') beta = beta.mid(1);
        if (beta.contains(" ")) beta = beta.section(" ",1,1);
        subst.insert(uni2betacode(beta),lem);
        subst_sd.insert(nettoie(beta),lem);
    }
    fichier.close();
    qDebug() << "Subst chargés";
    fichier.setFileName(racine + "Bailly_es_renv.csv");
    fichier.open(QFile::ReadOnly | QFile::Text);
    while (!fichier.atEnd())
    {
        lg = fichier.readLine();
        if (lg.isEmpty()) continue;
        lem = lg.section("\t",1,1);
        if (lem.contains(","))
        {
            // Il y en a plusieurs
            QStringList e = lem.split(", ");
            foreach (beta, e)
            {
                if (beta[0].isDigit()) beta = beta.mid(2);
                if (beta[0] == '*') beta = beta.mid(1);
                if (beta.contains(" ")) beta = beta.section(" ",1,1);
                es_renv.insert(uni2betacode(beta),lem);
                es_renv_sd.insert(nettoie(beta),lem);
            }
        }
        else
        {
            beta = lem;
            if (beta[0].isDigit()) beta = beta.mid(2);
            if (beta[0] == '*') beta = beta.mid(1);
            if (beta.contains(" ")) beta = beta.section(" ",0,0);
            es_renv.insert(uni2betacode(beta),lem);
            es_renv_sd.insert(nettoie(beta),lem);
        }
    }
    fichier.close();
    qDebug() << "Es Renv chargés";
    fichier.setFileName(racine + "Bailly_es_sens.csv");
    fichier.open(QFile::ReadOnly | QFile::Text);
    while (!fichier.atEnd())
    {
        lg = fichier.readLine();
        if (lg.isEmpty()) continue;
        lem = lg.section("\t",1,1);
        if (lem.contains(","))
        {
            // Il y en a plusieurs
            QStringList e = lem.split(", ");
            foreach (beta, e)
            {
                if (beta[0].isDigit()) beta = beta.mid(2);
                if (beta[0] == '*') beta = beta.mid(1);
                if (beta.contains(" ")) beta = beta.section(" ",1,1);
                es_sens.insert(uni2betacode(beta),lem);
                es_sens_sd.insert(nettoie(beta),lem);
            }
        }
        else
        {
            beta = lem;
            if (beta[0].isDigit()) beta = beta.mid(2);
            if (beta[0] == '*') beta = beta.mid(1);
            if (beta.contains(" ")) beta = beta.section(" ",1,1);
            es_sens.insert(uni2betacode(beta),lem);
            es_sens_sd.insert(nettoie(beta),lem);
        }
    }
    fichier.close();
    qDebug() << "es Sens chargés";
    int nbre;
    fichier.setFileName("/Users/Philippe/Documents/GIT/Alpheios_Bailly/data/Eulexis_Bailly_align.csv");
    fichier.open(QFile::WriteOnly | QFile::Text);
    QTextStream flux (&fichier);
    flux.setCodec("UTF-8");
    flux << "lemme\tbetacode\tsens\trenv\tsubst\tes_sens\tes_renv\tnombre\n";
    foreach (beta, _trad.keys())
    {
        // Je prends chaque lemme de mon lexique
        lem = beta2unicode(beta);
        if (beta[beta.size()-1].isDigit()) beta.chop(1);
        nbre = 0;
        flux << lem << "\t" << beta << "\t";
        if (sens.contains(beta))
        {
            // Combien ?
            QStringList ls = sens.values(beta);
            nbre += ls.size();
            flux << ls.join(", ") << "\t";
        }
        else flux << "\t";
        if (renv.contains(beta))
        {
            // Combien ?
            QStringList ls = renv.values(beta);
            nbre += ls.size();
            flux << ls.join(", ") << "\t";
        }
        else flux << "\t";
        if (subst.contains(beta))
        {
            // Combien ?
            QStringList ls = subst.values(beta);
            nbre += ls.size();
            flux << ls.join(", ") << "\t";
        }
        else flux << "\t";
        if (es_sens.contains(beta))
        {
            // Combien ?
            QStringList ls = es_sens.values(beta);
            nbre += ls.size();
            flux << ls.join(", ") << "\t";
        }
        else flux << "\t";
        if (es_renv.contains(beta))
        {
            // Combien ?
            QStringList ls = es_renv.values(beta);
            nbre += ls.size();
            flux << ls.join(", ") << "\t";
        }
        else flux << "\t";
        flux << nbre << "\n";
        if (nbre == 0)
        {
            nbre = 100;
            beta = nettoie2(beta);
            flux << "? " << lem << "\t" << beta << "\t";
            if (sens_sd.contains(beta))
            {
                // Combien ?
                QStringList ls = sens_sd.values(beta);
                nbre += ls.size();
                flux << ls.join(", ") << "\t";
            }
            else flux << "\t";
            if (renv_sd.contains(beta))
            {
                // Combien ?
                QStringList ls = renv_sd.values(beta);
                nbre += ls.size();
                flux << ls.join(", ") << "\t";
            }
            else flux << "\t";
            if (subst_sd.contains(beta))
            {
                // Combien ?
                QStringList ls = subst_sd.values(beta);
                nbre += ls.size();
                flux << ls.join(", ") << "\t";
            }
            else flux << "\t";
            if (es_sens_sd.contains(beta))
            {
                // Combien ?
                QStringList ls = es_sens_sd.values(beta);
                nbre += ls.size();
                flux << ls.join(", ") << "\t";
            }
            else flux << "\t";
            if (es_renv_sd.contains(beta))
            {
                // Combien ?
                QStringList ls = es_renv_sd.values(beta);
                nbre += ls.size();
                flux << ls.join(", ") << "\t";
            }
            else flux << "\t";
            flux << nbre << "\n";
        }
    }
    fichier.close();
}
