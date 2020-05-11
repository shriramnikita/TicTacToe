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


#uc3 bbegin with toss to choose between player or computer
function beginWithTtoss()
{
	#uc2 assign letter X or O
	assignLetter=$((RANDOM%2))

		if [ $assignLetter -eq 1 ]
		then
			player="X"
			printf "Player will play first"
		else
			player="O"
			printf "Computer will  play first"
		fi
}
beginWithTtoss
