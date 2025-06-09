#!/bin/bash
fqdn=$1
VERISIGN_API_URL="https://webwhois.verisign.com/webwhois-ui/rest/whois"
query="?q=$fqdn&tld=com&type=nameserver"
request="$VERISIGN_API_URL$query"
response=$(
  curl -s "$request" | 
  jq -r ".message" | 
  sed -n \
    -e "/For more information on Whois status codes/q" \
    -e "s/>>>/  /" \
    -e "s/<<<//" \
    -e "s/^   //" \
    -e "p"
)

echo "==========GLUE Record Check=========="
echo -e "Request Endpoint: $request\n$response\n"
