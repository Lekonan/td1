#! bin/bash

#RECUPERATION DU NOM DE UTILISATEUR ET DU FICHIER EN PARAMETRES
user=$1
fichier=$2


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
if [[ $usersNiveauUn =~ $user ]]; then
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

#LEVEL 2
elif [[ $usersNiveauDeux =~ $user ]]; then
    #ON RECUPERE LE DROIT DE L'UTILISATEUR DANS LE NIVEAU 1
    droitUser=$(cat $fichier | jq -r '.niveau_2.utilisateurs[] | select(.nom=="'$user'") | .droit' )
    #ON VERIFIE SI LES DROITS DE L'UTILISATEUR CORRESPONDENT A CEUX DEFINIS DANS LES ACL SUR LES DOSSIERS DE NIVEAU 1
    #CHECKING RIGHTS FOR LEVEL 2
    echo "Checking rights for user "$user""
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
elif [[ $usersNiveauTrois =~ $user ]]; then
    #ON RECUPERE LE DROIT DE L'UTILISATEUR DANS LE NIVEAU 1
    droitUser=$(cat $fichier | jq -r '.niveau_3.utilisateurs[] | select(.nom=="'$user'") | .droit' )
    #ON VERIFIE SI LES DROITS DE L'UTILISATEUR CORRESPONDENT A CEUX DEFINIS DANS LES ACL SUR LES DOSSIERS DE NIVEAU 1
    #CHECKING RIGHTS FOR LEVEL 3
    echo "Checking rights for user "$user""
    for i in $dossiersNiveauTrois; do
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

