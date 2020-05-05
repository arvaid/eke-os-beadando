#!/bin/bash
API_KEY="8649b5fcc1mshd7b3e2fbc4f0314p1b04b7jsnba05517620bb"
API_HOST="currency-exchange.p.rapidapi.com"
quantity=1

function help() {
    echo "Valuta átváltás"
    echo "Használat: $(basename $0) -q MENNYIT -f MIBŐL -t MIBE"
    echo "Példa: $(basename $0) -q 100 -f USD -t EUR"
    echo "A támogatott valuták a '$(basename $0) -l' paranccsal írathatók ki."
}

function list() {
    echo -n 'Támogatott valuták: '
    local API_URL="https://currency-exchange.p.rapidapi.com/listquotes"
    local x=$(curl -s --request GET --url $API_URL --header "x-rapidapi-host $API_HOST" --header "x-rapidapi-key: $API_KEY")
    echo "${x//\"}"
}

function exchange() {
    local API_URL="https://currency-exchange.p.rapidapi.com/exchange?q=1&from=$from&to=$to"
    local rate=$(curl -s --request GET --url $API_URL --header "x-rapidapi-host: $API_HOST" --header "x-rapidapi-key: $API_KEY")
    local result=$(echo "$rate * $quantity" | bc)
    echo $quantity $from = $result $to
}

while getopts "hlf:t:q:" option; do
    case "$option" in
        l)
           list
           exit
           ;;
        h)
           help
           exit
           ;;
        t)
           to=$OPTARG
           ;;
        f)
           from=$OPTARG
           ;;
        q)
           quantity=$OPTARG
           ;;
    esac
done

if [ -z "$to" ] || [ -z "$from" ]; then
    echo Hibás paraméterezés!
    help
else
    exchange
fi

