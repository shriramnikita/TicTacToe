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
			echo "Player will play first"
		else
			player="O"
			echo "Computer will  play first"
		fi
}
beginWithTtoss

#uc4 display tic tac toe board
function displayBoard(){
	echo "+---+---+---+"
	echo "| ${ticTacToe[1]} | ${ticTacToe[2]} | ${ticTacToe[3]} |"
	echo "+---+---+---+"
	echo "| ${ticTacToe[4]} | ${ticTacToe[5]} | ${ticTacToe[6]} |"
	echo "+---+---+---+"
	echo "| ${ticTacToe[7]} | ${ticTacToe[8]} | ${ticTacToe[9]} |" 
	echo "+---+---+---+"
}

function validateCell()
{
	displayBoard
	count=0
	read -p "enter a cell position between 1 to 9 " position
	for (( counter=1;counter<=9;counter++ ))
	do
		if [ $position -eq $counter ]
		then
			count=1
			break
		else
			count=0
		fi
	done

	if [ $count -eq 1 ]
	then
	 	ticTacToe[$i]=X
		displayBoard  ${ticTacToe[$i]} 

	else
		validateCell

	fi
}
validateCell
