#!/bin/bash
API_KEY="8649b5fcc1mshd7b3e2fbc4f0314p1b04b7jsnba05517620bb"
API_HOST="currency-exchange.p.rapidapi.com"

if [ $# -eq 3 ]; then
    API_URL="https://currency-exchange.p.rapidapi.com/exchange?q=1&from=$2&to=$3"
    x1=$(curl -s --request GET --url $API_URL --header "x-rapidapi-host: $API_HOST" --header "x-rapidapi-key: $API_KEY")
    x2=$(echo "$x1 * $1" | bc)
    echo $1 $2 = $x2 $3
elif [ $# -eq 1 ] && [ $1 = "-l" ] || [ $1 = "--list" ]; then
    echo -n 'Támogatott valuták: '
    API_URL="https://currency-exchange.p.rapidapi.com/listquotes"
    x=$(curl -s --request GET --url $API_URL --header "x-rapidapi-host $API_HOST" --header "x-rapidapi-key: $API_KEY")
    echo "${x//\"}"
else
    echo "Valuta átváltás"
    echo "Használat: $(basename $0) MENNYIT MIBŐL MIBE"
    echo "Példa: $(basename $0) 100 USD EUR"
    echo "A támogatott valuták a '$(basename $0) -l' vagy a '$(basename $0) --list' paranccsal írathatók ki."
fi


