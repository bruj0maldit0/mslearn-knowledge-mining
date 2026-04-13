#!/bin/bash

# Set values for your Search service
#url="YOUR_SEARCH_URL"
url=https://searchservice60818600.search.windows.net
#admin_key="YOUR_ADMIN_KEY"
admin_key=U1vM2XX68nE66zOcHJaubEEog3QUQ9fNOCOIUaXmRWAPEPEpecas

echo "-----"
echo "Updating the skillset..."
curl -X PUT "${url}/skillsets/margies-skillset?api-version=2020-06-30" \
  -H "Content-Type: application/json" \
  -H "api-key: ${admin_key}" \
  -d @skillset.json

# wait 2 seconds
sleep 2

echo "-----"
echo "Updating the index..."
curl -X PUT "${url}/indexes/margies-index?api-version=2020-06-30" \
  -H "Content-Type: application/json" \
  -H "api-key: ${admin_key}" \
  -d @index.json

# wait 2 seconds
sleep 2

echo "-----"
echo "Updating the indexer..."
curl -X PUT "${url}/indexers/margies-indexer?api-version=2020-06-30" \
  -H "Content-Type: application/json" \
  -H "api-key: ${admin_key}" \
  -d @indexer.json

echo "-----"
echo "Resetting the indexer"
curl -X POST "${url}/indexers/margies-indexer/reset?api-version=2020-06-30" \
  -H "Content-Type: application/json" \
  -H "Content-Length: 0" \
  -H "api-key: ${admin_key}"

# wait 5 seconds
sleep 5

echo "-----"
echo "Rerunning the indexer"
curl -X POST "${url}/indexers/margies-indexer/run?api-version=2020-06-30" \
  -H "Content-Type: application/json" \
  -H "Content-Length: 0" \
  -H "api-key: ${admin_key}"
