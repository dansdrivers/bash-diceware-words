#!/bin/bash

LIST=diceware.wordlist.asc
LIST2=diceware.wordlist.8.asc.txt
WORDS=7
if [ "$1" != "" ]; then
	WORDS=$1
fi
 
# Generate $WORDS random word string
echo
echo "using bash random"
START=0
while [ $START -lt $WORDS ]; do
	BASHRAND=
	RANDI=1
	while [ $RANDI -lt 6 ]; do 
		BASHRAND=${BASHRAND}$((1 + RANDOM % 6))
		RANDI=$(( RANDI + 1 ))
	done
	#echo $NRAND
	echo $(grep $BASHRAND $LIST)
	START=$(( START + 1 ))
done

echo
echo "using commandlinefu random"
START=0
while [ $START -lt $WORDS ]; do
	CLFRAND=
	RANDI=1
	while [ $RANDI -lt 6 ]; do 
		# Use a guess method touted to be worthy of diceware
		# http://www.commandlinefu.com/commands/view/11309/true-random-dice-roll
		CLFRAND=${CLFRAND}$(LC_CTYPE=C tr -cd '1-6' < /dev/urandom | head -c 1; echo)
		RANDI=$(( RANDI + 1 ))
	done
	#echo $NRAND
	echo $(grep $CLFRAND $LIST)
	START=$(( START + 1 ))
done


echo
echo "using a bash random line in the original file"
NLINES=$(wc -l $LIST | awk '{print $1}' | tr -d '\n' )
START=0
while [ $START -lt $WORDS ]; do
	RLINE=$(( 1 + RANDOM % NLINES ))
	head -n $RLINE $LIST | tail -n 1
	#sed "${RLINE}q;d" $LIST
	START=$(( START + 1 ))
done


echo
echo "using a bash random line in the word larger file"
NLINES=$(wc -l $LIST | awk '{print $1}' | tr -d '\n' )
START=0
while [ $START -lt $WORDS ]; do
	RLINE=$(( 1 + RANDOM % NLINES ))
	head -n $RLINE $LIST2 | tail -n 1
	#sed "${RLINE}q;d" $LIST2
	START=$(( START + 1 ))
done



