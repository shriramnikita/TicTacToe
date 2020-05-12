#!/bin/bash

echo "Welcome to Tic Tac Toe Game"


PLAYER_1="Human"
PLAYER_2="Computer"

positions=(- - - - - - - - -)  # initial positions

player_one=true  # player switch init
gamefinished=false  # is the game finished
stall=false  # stall - if an invalid or empty move was input



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

function readMove(){

	 positions_str=$(printf "%s" "${positions[@]}")

  	test_position_str $positions_str  # finish the game if all postiions have been taken or a player has won

  if [ "$gamefinished" = false ] ; then

    if [ "$stall" = false ] ; then
      if [ "$player_one" = true ] ; then
        prompt="Your move, "$player_1_str"?"
      fi
    else
      stall=false
    fi

    if [ "$player_one" = true ] ; then
      echo -e $prompt
      read -d'' -s -n1 input  # read input

      index=10  # init with nonexistent
      case $input in
            q) index=0;;
            a) index=3;;
            z) index=6;;
            w) index=1;;
            s) index=4;;
            x) index=7;;
            e) index=2;;
            d) index=5;;
            c) index=8;;
      esac

      if [ "${positions["$index"]}" == "-" ]; then
        positions["$index"]="X"
        player_one=false
      else
     stall=true  # prevent player switch
      fi

    else
      # computer, choose your position!
      set_next_avail_pos_index "O"
      player_one=true
    fi

    init_game  # reinit, because positions persist
  fi




}

function rowCheckforWinning(){
	for (( i=1; i<=9; i=$((i+3)) ))
	do
		if [[ ${ticTacToe[$i]} -eq ${ticTacToe[(($i+1))]} && ${ticTacToe[$i]} -eq ${ticTacToe[(($i+2))]} ]]
		then
			row=0
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


function init_game 
{
  displayBoard
  readMove
}

function end_game {
  gamefinished=true
  displayBoard
}



function testPosition
 {
  rows=$(rowCheckforWinning)
  cols=$(columnCheckforWinning)
  diagonals=$(diagonalCheckforWinning)

  if [[ $rows =~ [X]{3,} || $cols =~ [X]{3,} || $diagonals =~ [X]{3,} ]]; then
    end_game
    printf $Player_1" wins! \n"
    return
  fi
  if [[ $rows =~ [O]{3,} || $cols =~ [O]{3,} || $diagonals =~ [O]{3,} ]]; then
    end_game
   printf $PLAYER_2" wins! \n"
    return
  fi
  if [[ ! $positions_str =~ [-] ]]; then
    end_game
    printf "Ends with a draw"$reset"\n"
  fi
}

# get next available position and set it to value of argument
function set_next_avail_pos_index {
  available=()
  for (( i = 0; i < ${#positions[@]}; i++ )); do
    if [[ ${positions[$i]} == '-' ]]; then
      available+=($i)
    fi
  done

  rand=$(jot -r 1 0 $(( ${#available[@]}-1 )))  # random in range 0 to available_len
  positions[${available[$rand]}]=$1
}

init_game
