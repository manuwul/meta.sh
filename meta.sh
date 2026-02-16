#!/usr/bin/env bash

META_LANG="python"
INPUT_FILE="main.c"
OUTPUT_FILE="gen_main.c"
PAREN='`'

while getopts 'm:p:i:o:h' OPTION; do
	case "$OPTION" in
		m)
			META_LANG="$OPTARG"
			;;
		p)
			PAREN="$OPTARG"
			;;
		i)
			INPUT_FILE="$OPTARG"
			;;
		o)
			OUTPUT_FILE="$OPTARG"
			;;
		h | ?)
			echo "script usage: $(basename $0) [-m metalang] [-p paren_char] [-i input_file] [-o output_file]"
			echo -e "-m\\tSet metalanguage execution command. Default: python"
			echo -e "-p\\tSet parenthesis character around metacode block. Default: \`"
			echo -e "-i\\tSet input file. Default: main.c"
			echo -e "-o\\tSet output file. Default: gen_main.c"
			echo "Example: $(basename $0) -m python -p \` -i main.c -o gen_main.c"
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: Input file does not exist" >&2
    exit 1	
fi

echo -n "" > "$OUTPUT_FILE"
content=$(<"$INPUT_FILE")
metablock=0
while [[ "$content" == *"$PAREN"* ]]; do
	content="${content#"$PAREN"}"
	part="${content%%"$PAREN"*}"
	if (( $metablock )); then
		res=$(eval "$META_LANG" <<< "$part" 2>&1)
		echo -n "$res" >> "$OUTPUT_FILE"
	else
		echo -n "$part" >> "$OUTPUT_FILE"
	fi
	content="${content#*"$PAREN"}"
	metablock=$(( 1 - $metablock ))
done
if (( $metablock )); then
	res=$($META_LANG "$content")
	echo -n "$res" >> "$OUTPUT_FILE"
else
	echo -n "$content" >> "$OUTPUT_FILE"
fi
