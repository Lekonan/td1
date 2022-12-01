#! bin/bash

#RECUPERATION DU NOM DE UTILISATEUR ET DU FICHIER EN PARAMETRES
user=$1
fichier=$2
existuser=0
#VERFIICATION DE L'EXISTENCE DE USER ET DE FICHIER EN PARAMETRES
if [ -z $user ] || [ -z $fichier ];then
    echo "Erreur: il faut entrer un nom d'utilisateur et un fichier en parametres"
    exit 1
fi

#NIVEAU 1
usersNiveauUn=$(cat $fichier | jq -r '.niveau_1.utilisateurs[] | .nom' )
droitUsersNiveauUn=$(cat $fichier | jq -r '.niveau_1.utilisateurs[] | .droit' )
dossiersNiveauUn=$(cat $fichier | jq -r '.niveau_1.dossiers[] | .' )

#NIVEAU 2
usersNiveauDeux=$(cat $fichier | jq -r '.niveau_2.utilisateurs[] | .nom' )
droitUsersNiveauDeux=$(cat $fichier | jq -r '.niveau_2.utilisateurs[] | .droit' )
dossiersNiveauDeux=$(cat $fichier | jq -r '.niveau_2.dossiers[] | .' )

#NIVEAU 3
usersNiveauTrois=$(cat $fichier | jq -r '.niveau_3.utilisateurs[] | .nom' )
droitUsersNiveauTrois=$(cat $fichier | jq -r '.niveau_3.utilisateurs[] | .droit' )
dossiersNiveauTrois=$(cat $fichier | jq -r '.niveau_3.dossiers[] | .' )


#ON VERIFIE SI L'UTILISATEUR EXISTE DANS LE NIVEAU 1 OU 2 OU 3
#LEVEL 1
for i in $usersNiveauUn; do
    if [[ $i == $user ]]; then
        existuser=1
        #ON RECUPERE LE DROIT DE L'UTILISATEUR DANS LE NIVEAU 1
        droitUser=$(cat $fichier | jq -r '.niveau_1.utilisateurs[] | select(.nom=="'$user'") | .droit' )
        #ON VERIFIE SI LES DROITS DE L'UTILISATEUR CORRESPONDENT A CEUX DEFINIS DANS LES ACL SUR LES DOSSIERS DE NIVEAU 1
        echo "Checking rights for user "$user""
        for i in $dossiersNiveauUn; do
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
    fi
done

#LEVEL 2
for i in $usersNiveauDeux; do
    if [[ $usersNiveauDeux == $user ]]; then
        existuser=1
        #ON RECUPERE LE DROIT DE L'UTILISATEUR DANS LE NIVEAU 1
        droitUser=$(cat $fichier | jq -r '.niveau_2.utilisateurs[] | select(.nom=="'$user'") | .droit' )
        #ON VERIFIE SI LES DROITS DE L'UTILISATEUR CORRESPONDENT A CEUX DEFINIS DANS LES ACL SUR LES DOSSIERS DE NIVEAU 1
        #CHECKING RIGHTS FOR LEVEL 2
        echo "Checking rights for user "$user""
        for i in $dossiersNiveauDeux; do
            #ATTENTION : LE TEST SE FERA AVEC UNE SPECIFICATION DU DOSSIER DE DESTINATION
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
        #CHECKING RIGHTS FOR LEVEL 1
        for i in $dossiersNiveauUn; do
            #ATTENTION : LE TEST SE FERA AVEC UNE SPECIFICATION DU DOSSIER DE DESTINATION
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
    fi
done

#LEVEL 3
for i in $usersNiveauTrois; do
    if [[ $usersNiveauTrois == $user ]]; then
        existuser=1
        #ON RECUPERE LE DROIT DE L'UTILISATEUR DANS LE NIVEAU 1
        droitUser=$(cat $fichier | jq -r '.niveau_3.utilisateurs[] | select(.nom=="'$user'") | .droit' )
        #ON VERIFIE SI LES DROITS DE L'UTILISATEUR CORRESPONDENT A CEUX DEFINIS DANS LES ACL SUR LES DOSSIERS DE NIVEAU 1
        #CHECKING RIGHTS FOR LEVEL 3
        echo "Checking rights for user "$user""
        for i in $dossiersNiveauTrois; do
            #ATTENTION : LE TEST SE FERA AVEC UNE SPECIFICATION DU DOSSIER DE DESTINATION
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
        #CHECKING RIGHTS FOR LEVEL 2
        for i in $dossiersNiveauDeux; do
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
        #CHECKING RIGHTS FOR LEVEL 1
        for i in $dossiersNiveauUn; do
            droitDossier=$(getfacl /home/orphee/ESIR/semestre_1/srio/td-srio/$i | grep $user | awk -F ":" '{print $3}')
            if [[ $droitDossier == $droitUser ]]; then
                echo "Access rigth for "$i" =======> OK with $droitUser"
            else
                echo "Access rigth for "$i" =======> KO Please check the rigth for $user"
                echo "The rigth for $user is $droitDossier But it should be $droitUser"
            fi
        done
    fi
done
#CHECKING IF THE USER EXIST
if [[ $existuser == 0 ]]; then
    echo "The user $user doesn't exist"
    echo "Check finished" 
    echo "Please check Printed logs"
else
    echo "Check finished" 
    echo "Please check Printed logs"
fi