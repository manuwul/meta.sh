#!/usr/bin/env bash

META_LANG="python -c"
INPUT_FILE="main.c"
OUTPUT_FILE="gen_main.c"

exec 3<>"$INPUT_FILE"
exec 4<>"$OUTPUT_FILE"

while getopts 'm:i:o:h' OPTION; do
	case "$OPTION" in
		m)
			META_LANG="$OPTARG"
			;;
		i)
			INPUT_FILE="$OPTARG"
			;;
		o)
			OUTPUT_FILE="$OPTARG"
			;;
		h | ?)
			echo "script usage: $(basename $0) [-m metalang] [-o output] input_file"
			echo -e "-m\\tSet metalanguage execution command. Default: python -c"
			echo -e "-i\\tSet input file. Default: main.c"
			echo -e "-o\\tSet output file. Default: gen_main.c"
			echo "Example: $(basename $0) -m \"python -c\" -o gen_main.c main.c"
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: Input file does not exist" >&2
    exit 1	
fi

bt_found=0 
meta=""
while read -u 3 -rN1 char; do
	if (( $bt_found == 0 )) then
		if [[ "$char" == '`' ]]; then
			bt_found=1
		else
			echo -nE "$char" >&4
		fi
	else
		if [[ "$char" == '`' ]]; then
			res=$($META_LANG "$meta")
			echo -nE "$res" >&4
			bt_found=0
			meta=""
		else
			meta+="$char"
		fi
	fi
done

exec 3<&-
