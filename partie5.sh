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

#Je commence par créer des groupes sur le système



for in $usersNiveauUn
do
    #Creation des utilisateurs
    echo $user
done