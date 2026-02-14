#!/usr/bin/env bash

META_LANG="python -c"
INPUT_FILE="main.c"
OUTPUT_FILE="gen_main.c"
DELIMITER='`'

while getopts 'm:d:i:o:h' OPTION; do
	case "$OPTION" in
		m)
			META_LANG="$OPTARG"
			;;
		d)
			DELIMITER="$OPTARG"
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
			echo -e "-d\\tSet quotes character around metacode block. Default: \`"
			echo -e "-i\\tSet input file. Default: main.c"
			echo -e "-o\\tSet output file. Default: gen_main.c"
			echo "Example: $(basename $0) -m \"python -c\" -d '\`' -o gen_main.c main.c"
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: Input file does not exist" >&2
    exit 1	
fi

echo "" > "$OUTPUT_FILE"
content=$(<"$INPUT_FILE")
metablock=0
while [[ "$content" == *"$DELIMITER"* ]]; do
	content="${content#"$DELIMITER"}"
	part="${content%%"$DELIMITER"*}"
	if (( $metablock )); then
		res=$($META_LANG "$part")
		echo -n "$res" >> "$OUTPUT_FILE"
	else
		echo -n "$part" >> "$OUTPUT_FILE"
	fi
	content="${content#*"$DELIMITER"}"
	metablock=$(( 1 - $metablock ))
done
if (( $metablock )); then
	res=$($META_LANG "$content")
	echo -n "$res" >> "$OUTPUT_FILE"
else
	echo -n "$content" >> "$OUTPUT_FILE"
fi
