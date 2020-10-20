docker build -t ankitcagarwal/multi-client:latest -t ankitcagarwal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ankitcagarwal/multi-server:latest -t ankitcagarwal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ankitcagarwal/multi-worker:latest -t ankitcagarwal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ankitcagarwal/multi-client:latest
docker push ankitcagarwal/multi-server:latest
docker push ankitcagarwal/multi-worker:latest

docker push ankitcagarwal/multi-client:$SHA
docker push ankitcagarwal/multi-server:$SHA
docker push ankitcagarwal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ankitcagarwal/multi-server:$SHA
kubectl set image deployments/client-deployment server=ankitcagarwal/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ankitcagarwal/multi-worker:$SHA