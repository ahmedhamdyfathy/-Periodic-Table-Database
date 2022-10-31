#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#enter input in terminal
if [[ $1 ]]
  then
   #check the input number or not >> first if statment
   if [[ ! $1 =~ ^[0-9]+$ ]]
      then # not number
      # fetch information by query on database 
      ELEMENT=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.name LIKE '$1%' ORDER BY atomic_number LIMIT 1")
      else # input is number
      # fetch information by query on database 
      ELEMENT=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.atomic_number=$1")
   fi
   # check variable ELEMENT is empty >> second if statment
    if [[ -z $ELEMENT ]]
        then # the input not exit database
          echo "I could not find that element in the database."
        else # the input exit database
         #display information element 
         #display the result exact program >> remove the space by IFS=' | '
         echo $ELEMENT | while IFS=' | ' read ATOMIC_NUMBER ATOMIC_MASS MPC BPC SY NAME TYPE
            do
             echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SY). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
            done
    fi 
   else
   echo "Please provide an element as an argument."
fi   