#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MIAN_MENU(){
  # check if run with arguement
  if [[ -z $1 ]]
  then
    # if no arguement given
    echo -e "\nPlease provide an element as an argument."
  # if there is arguement
  # if the arguement is number
  else if [[ $1 =~ ^[0-9]+$ ]]
  then
    SERCH_RESULT=$($PSQL "SELECT name FROM properties WHERE atomic_number=$1")
    # if the number matches any atomic_number
    echo $SERCH_RESULT
  
  fi
}

MAIN_MENU

