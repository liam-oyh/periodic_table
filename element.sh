#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
INPUT=$1

MAIN_MENU(){
  # check if run with arguement
  if [[ -z $INPUT ]]
  then
    # if no arguement given
    echo Please provide an element as an argument.
  # if there is arguement
  # if the arguement is number
  elif [[ $INPUT =~ ^[0-9]+$ ]]
  then
    E_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')
    # if the number matches any atomic_number
    if [[ -z $E_NAME ]]
    then
      echo I could not find that element in the database.
    else
      # get other properties of the element
      E_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')
      E_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')
      E_MPOINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')
      E_BPOINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')
      E_TYPE=$(echo $($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT") | sed -r 's/^ *| *$//g')

      # return output
      echo "The element with atomic number $INPUT is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $E_MASS amu. $E_NAME has a melting point of $E_MPOINT celsius and a boiling point of $E_BPOINT celsius."
    fi
  else
    # check if the input string is symbol
    if [[ ${#INPUT} < 3 ]]
    then
       E_SYMBOL=$(echo $INPUT | sed -r 's/^ *| *$//g')
       E_ATOMICNUM=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$INPUT'") | sed -r 's/^ *| *$//g')
       if [[ -z $E_ATOMICNUM ]]
       then
         echo I could not find that element in the database.
       else
         # get other properties of the element
         E_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_MPOINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_BPOINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_TYPE=$(echo $($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')

         # return output
         echo "The element with atomic number $E_ATOMICNUM is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $E_MASS amu. $E_NAME has a melting point of $E_MPOINT celsius and a boiling point of $E_BPOINT celsius."
       fi
    else
       E_NAME=$(echo $INPUT | sed -r 's/^ *| *$//g')
       E_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE name='$INPUT'") | sed -r 's/^ *| *$//g')
       if [[ -z $E_SYMBOL ]]
       then
         echo I could not find that element in the database.
       else
         # get other properties of the element
         E_ATOMICNUM=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name='$INPUT'") | sed -r 's/^ *| *$//g')
         E_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_MPOINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_BPOINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')
         E_TYPE=$(echo $($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$E_ATOMICNUM") | sed -r 's/^ *| *$//g')

         # return output
         echo "The element with atomic number $E_ATOMICNUM is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $E_MASS amu. $E_NAME has a melting point of $E_MPOINT celsius and a boiling point of $E_BPOINT celsius."
        fi
    fi
    
  fi
}

MAIN_MENU

