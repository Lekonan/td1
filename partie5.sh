#!/bin/bash

# Recuperation des parametres
#NIVEAU 1
usersNiveauUn=$(cat organisation.json | jq -r '.niveau_1.utilisateurs[] | .nom' )
droitUsersNiveauUn=$(cat organisation.json | jq -r '.niveau_1.utilisateurs[] | .droit' )
dossiersNiveauUn=$(cat organisation.json | jq -r '.niveau_1.dossiers[] | .' )

#NIVEAU 2
usersNiveauDeux=$(cat organisation.json | jq -r '.niveau_2.utilisateurs[] | .nom' )
droitUsersNiveauDeux=$(cat organisation.json | jq -r '.niveau_2.utilisateurs[] | .droit' )
dossiersNiveauDeux=$(cat organisation.json | jq -r '.niveau_2.dossiers[] | .' )

#NIVEAU 3
usersNiveauTrois=$(cat organisation.json | jq -r '.niveau_3.utilisateurs[] | .nom' )
droitUsersNiveauTrois=$(cat organisation.json | jq -r '.niveau_3.utilisateurs[] | .droit' )
dossiersNiveauTrois=$(cat organisation.json | jq -r '.niveau_3.dossiers[] | .' )

#CREATION DE GROUPES SUR LE SYSTEME
sudo groupadd niveau_1
sudo groupadd niveau_2
sudo groupadd niveau_3

#CREATION ET AJOUT DES DOSSIERS DANS LES GROUPES RESPECTIFS
#NIVEAU 1

#NIVEAU 2

#NIVEAU 3


for user in $usersNiveauUn
do
    #Creation des utilisateurs
    echo $user
done