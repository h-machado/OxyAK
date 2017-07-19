#!/bin/bash
cd /home/oxy/oxy-node
OXYTAIL=$(yes | ./oxy_manager.bash rebuild | awk {'print $NF'})
echo \{\"timestamp\":\"`date +%Y-%m-%dT%H:%M:%S%z`\", \"success\":true, \"msg\": \"Blockchain snapshot downloaded\"\}
HEIGHT="nan"
TIMEOUT=60
FAILURES=1

for h in ${OXYTAIL}; do
  HEIGHT=${h}
done

if [[ ${HEIGHT} =~ ^-?[0-9]+$ ]]; then
  stdbuf -i0 -o0 -e0 tail -f logs/oxycoin.log | while read -r line; do
    if echo $line | grep height > /dev/null; then
      height=$(echo $line | awk {'print $NF'})
      if [ "${height}" -gt "${HEIGHT}" ]; then
        echo \{\"timestamp\":\"`date +%Y-%m-%dT%H:%M:%S%z`\", \"height\":${HEIGHT}, \"upto\":${height}, \"success\":true, \"msg\": \"Blockchain loaded and oxynode running\"\}
        exit 0
      fi
    else
      height=-1
      if ! (( FAILURES % 30 )); then
        echo \{\"timestamp\":\"`date +%Y-%m-%dT%H:%M:%S%z`\", \"height\":${HEIGHT}, \"upto\":${height}, \"success\":false, \"msg\": \"No new blocks read for ${FAILURES} lines\"\}
      fi
      FAILURES=$((FAILURES+1))
    fi
  done
else
  echo \{\"timestamp\":\"`date +%Y-%m-%dT%H:%M:%S%z`\", \"success\":true, \"msg\": \"Invalid height read from rebuild command\"\}
  exit 1
fi


