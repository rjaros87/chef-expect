#!/bin/bash

echo "Would you like to delete your all files (yes/no)?"
read answer
if [[ "$answer" = "yes" ]] ;then touch $1/yes.txt; fi
if [[ "$answer" = "no" ]] ;then touch $1/no.txt; fi
