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

function validateCell(){
	displayBoard
	count=0
	read -p "Enter cell position between 1 to 9:- " position
	ticTacToe[$(($position))]="X"
	count=$(($count+1))
}

function rowCheckforWinning(){
	for (( i=1; i<=9; i=$((i+3)) ))
	do
		if [[ ${ticTacToe[$i]} -eq ${ticTacToe[(($i+1))]} && ${ticTacToe[$i]} -eq ${ticTacToe[(($i+2))]} ]]
		then
			row=0
			break;
		else
			row=1
		fi
	done
		echo $row
}

function columnCheckforWinning()
{
	column=0
	for (( i=1; i<4; i++ ))
	do
		if [[ ${ticTacToe[$i]} -eq ${ticTacToe[(($i+3))]} && ${ticTacToe[$i]} -eq ${ticTacToe[(($i+6))]} ]]
		then
				column=0
				break;
		else
				column=1
		fi
	done
	echo $column
}

function diagonalCheckforWinning()
{
	if [[ ${ticTacToe[1]} -eq ${ticTacToe[5]} && ${ticTacToe[1]} -eq ${ticTacToe[9]} || ${ticTacToe[3]} -eq ${ticTacToe[5]} && ${ticTacToe[3]} -eq ${ticTacToe[7]} ]]
	then
			diagonal=0
	else
			diagonal=1
	fi
	echo $diagonal
}

function winner(){
	toss
	count=0
	while [ $count -ne 9 ]
	do
		validateCell
		row=$(rowCheckforWinning)
		column=$(columnCheckforWinning)
		diagonal=$(diagonalCheckforWinning)
		if [[ $row -eq 0 || $column -eq 0 || $diagonal -eq 0 ]]
		then
			echo "You Win"
			break
		fi
	done
}
winner
