#!/bin/bash

printf "Welcome to Tic Tac Toe Game"


printf "1) Play with computer \n 2) Play with 2 player"

read -p "Enter the number to display week day: " number
case $number in 
          1)

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
;;

2)
reset(){
  echo "====================="
  echo "Created by davidhcefx"
  echo "2017.4.4"
  echo "TicTacToe game in bash"
  echo "Wrintten in Ubuntu-XFCE desktop environment"
  Arr=(. . . . . . . . .)
  player=1
  gamestatus=1
  echo "====================="
  echo "Game started"
}

set(){
  idx=$(( $1 * 3 + $2 ))
  if [ ${Arr[$idx]} == "." ]; then
    Arr[$idx]=$3
    player=$((player%2+1))
  else
    echo "You can't place there!"
  fi
}

print(){
  echo "r\c 0 1 2"
  echo "0   ${Arr[0]} ${Arr[1]} ${Arr[2]}"
  echo "1   ${Arr[3]} ${Arr[4]} ${Arr[5]}"
  echo "2   ${Arr[6]} ${Arr[7]} ${Arr[8]}"
}

checkmatch(){
  if [ ${Arr[$1]} != "." ] && [ ${Arr[$1]} == ${Arr[$2]} ] && [ ${Arr[$2]} == ${Arr[$3]} ]; then
    gamestatus=0
  fi
}

checkgame(){
  checkmatch 0 1 2
  checkmatch 3 4 5
  checkmatch 6 7 8
  checkmatch 0 3 6
  checkmatch 1 4 7
  checkmatch 2 5 8
  checkmatch 0 4 8
  checkmatch 2 4 6
}


reset
 # infinit game loop
while [ 1 == 1 ]; do
  echo ""
  if [ $player == 1 ]; then sym=O
  else sym=X; fi
  echo "Player $player's turn: ($sym)"
  print
  echo ""
  echo "  Command:"
  echo " 1. set [row] [column]"
  echo " 2. restart"
  while [ 1 == 1 ]; do
    read -r cmd a b
    if [ $cmd == "set" ]; then
   set $a $b $sym
   break
    elif [ $cmd == "restart" ]; then
   reset
   break
    else
   echo "wrong command, try again."
    fi
  done
  checkgame
  if [ $gamestatus != 1 ]; then
    echo "Gameover"
    player=$((player%2+1))
    echo "Player $player ($sym) win!!"
    while [ 1 == 1 ]; do
      read -r cmd n
      if [ $cmd == "restart" ]; then
     reset
     break
      fi
    done
  fi
done
;;
3)
printf "invalid entry"
;;
esac

