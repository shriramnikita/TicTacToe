#!/bin/bash

echo "Welcome to Tic Tac Toe Game"

#uc1 function for reset board
function resetBoard(){
	for (( i=1; i<=9; i++ ))
	do
		ticTacToe[$i]=$i
	done
}
resetBoard


#uc2 assign letter X or O
assignLetter=$((RANDOM%2))
if [ $assignLetter -eq 1 ]
then
	player="X"
else
	player="O"
fi
