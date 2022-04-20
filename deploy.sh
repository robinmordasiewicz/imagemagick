#!/bin/bash
#

echo "deploy imagemagick container"

kubectl apply -f deployment.yaml --namespace r-mordasiewicz

echo "kubectl exec --namespace r-mordasiewicz -it imagemagick -c imagemagick -- /bin/bash"
