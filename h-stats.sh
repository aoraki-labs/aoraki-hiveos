#!/usr/bin/env bash

#set -ex


khs=0
stats=
algo='aleo'

stats_raw=`curl -s --connect-timeout 5 --location --request POST '127.0.0.1:7777' --header 'Content-Type: application/json' --data-raw '{"jsonrpc":"2.0","method":"info","id":"1"}'`

if [[ $? -ne 0 || -z $stats_raw ]]; then
  echo -e "curl error"
else
  #echo $stats_raw
  readarray -t arr < <(echo "$stats_raw" | jq -cr '.jsonrpc, .result, .id ' 2>/dev/null)
  result="${arr[1]}"

  #test data below
  uptime=()
  uptime[0]=1
  uptime[1]=2

  algo="test"
  hs_units="khs"
  version="1.2.1"

  temp=()
  temp[0]=3
  temp[1]=4

  fan=()
  fan[0]=1
  fan[1]=2

  bus_numbers=()
  bus_numbers[0]=1
  bus_numbers[1]=2

  hs=0
  air=()
  air[0]=1
  air[1]=2

  fan_1=`printf '%s\n' "${fan[@]}"  | jq -cs '.'`
  temp_2=`printf '%s\n' "${temp[@]}"  | jq -cs '.'`


  stats=$(jq -nc --arg uptime "$uptime" \
                 --arg algo "$algo" \
                 --arg hs_units "$hs_units" \
                 --arg khs "$khs" \
                 --arg ver "$version" \
                 --argjson temp "$temp_2" \
                 --argjson fan "$fan_1" \
                 --argjson bus_numbers "$bus_numbers" \
                 --argjson hs "$hs" \
                 --argjson ar "$air" \
		 --arg hashrate "$result" \
                 '{"total_khs": $khs|tonumber, $hs, $hs_units, "uptime":$uptime|tonumber|floor, $algo, $ar, $temp, $fan, $bus_numbers, $ver, $hashrate}')

  echo -e $stats

fi
