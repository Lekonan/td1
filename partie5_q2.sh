#!/bin/bash

# Recuperation des parametres
#NIVEAU 1
usersNiveauUn=$(cat partie5_q1.json | jq -r '.niveau_1.utilisateurs[] | .nom' )
droitUsersNiveauUn=$(cat partie5_q1.json | jq -r '.niveau_1.utilisateurs[] | .droit' )
dossiersNiveauUn=$(cat partie5_q1.json | jq -r '.niveau_1.dossiers[] | .' )

#NIVEAU 2
usersNiveauDeux=$(cat partie5_q1.json | jq -r '.niveau_2.utilisateurs[] | .nom' )
droitUsersNiveauDeux=$(cat partie5_q1.json | jq -r '.niveau_2.utilisateurs[] | .droit' )
dossiersNiveauDeux=$(cat partie5_q1.json | jq -r '.niveau_2.dossiers[] | .' )

#NIVEAU 3
usersNiveauTrois=$(cat partie5_q1.json | jq -r '.niveau_3.utilisateurs[] | .nom' )
droitUsersNiveauTrois=$(cat partie5_q1.json | jq -r '.niveau_3.utilisateurs[] | .droit' )
dossiersNiveauTrois=$(cat partie5_q1.json | jq -r '.niveau_3.dossiers[] | .' )

#CREATION DE GROUPES SUR LE SYSTEME
sudo groupadd niveau_1
sudo groupadd niveau_2
sudo groupadd niveau_3

#CREATION ET AJOUT DES DOSSIERS DANS LES GROUPES RESPECTIFS
#NIVEAU 1
for dossier in $dossiersNiveauUn
do
    sudo mkdir /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chown root:niveau_1 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chmod -R 700 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
done

#NIVEAU 2
for dossier in $dossiersNiveauDeux
do
    sudo mkdir /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chown root:niveau_2 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chmod -R 700 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
done

#NIVEAU 3
for dossier in $dossiersNiveauTrois
do
    sudo mkdir /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chown root:niveau_3 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    sudo chmod -R 700 /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
done


#GESTION DES UTILISATEURS DU NIVEAU 1 : CREATION, AJOUT AU GROUPE, AJOUT DES DROITS D'UN UTILISATEUR SUR UN DOSSIER
for user in $usersNiveauUn
do
    #Les droit d'un utilisateur
    droit=$(cat partie5_q1.json | jq --arg u "$user" -r '.niveau_1.utilisateurs[]| select(.nom==$u) | .droit')
    #Creation de l'utilisateur, ajout au groupe
    sudo useradd -g niveau_1 -s /bin/bash $user
    #Ajout des droits d'un utilisateur sur un dossier avec des ACL
    for dossier in $dossiersNiveauUn
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
done

#GESTION DES UTILISATEURS DU NIVEAU 2 : CREATION, AJOUT AU GROUPE, AJOUT DES DROITS D'UN UTILISATEUR SUR UN DOSSIER
for user in $usersNiveauDeux
do
    #Les droit d'un utilisateur
    droit=$(cat partie5_q1.json | jq --arg u "$user" -r '.niveau_2.utilisateurs[]| select(.nom==$u) | .droit')
    #Creation de l'utilisateur, ajout au groupe
    sudo useradd -g niveau_2 -s /bin/bash $user
    #Ajout des droits d'un utilisateur sur un dossier avec des ACL
    for dossier in $dossiersNiveauDeux
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
    #DROIT SUR LE NIVEAU INFERIEUR (NIVEAU 1)
    for dossier in $dossiersNiveauUn
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
done


#GESTION DES UTILISATEURS DU NIVEAU 3 : CREATION, AJOUT AU GROUPE, AJOUT DES DROITS D'UN UTILISATEUR SUR UN DOSSIER
for user in $usersNiveauTrois
do
    #Les droit d'un utilisateur
    droit=$(cat partie5_q1.json | jq --arg u "$user" -r '.niveau_3.utilisateurs[]| select(.nom==$u) | .droit')
    #Creation de l'utilisateur, ajout au groupe
    sudo useradd -g niveau_3 -s /bin/bash $user
    #Ajout des droits d'un utilisateur sur un dossier avec des ACL
    for dossier in $dossiersNiveauTrois
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
    #CONTROLE SUR LE NIVEAU 2
    for dossier in $dossiersNiveauDeux
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
    #CONTROLE SUR LE NIVEAU 1
    for dossier in $dossiersNiveauUn
    do
        sudo setfacl -m u:$user:$droit /home/orphee/ESIR/semestre_1/srio/td-srio/$dossier
    done
done

