#VALEURS EN PARAMETRES
level=$1
file=$2


#VERFIICATION DE L'EXISTENCE DE USER ET DE FICHIER EN PARAMETRES
if [ -z $level ] || [ -z $file] ; then
    echo "Erreur: il faut entrer un niveau et un fichier en parametres"
    exit 1
fi

#CREATTION DU NIVEAU
niveau_courant="niveau_"$level
echo $niveau_courant
#RECUPERATION DES LOGS D'AUDIT SUR LES DOSSIERS 