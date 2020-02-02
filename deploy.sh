docker build -t willemdb/multi-client:latest -t willemdb/multie-client:$SHA -f ./client/Dockerfile ./client
docker build -t willemdb/multi-server:latest -t willemdb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t willemdb/multi-worker:latest -t willemdb/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push willemdb/multi-client:latest
docker push willemdb/multi-server:latest
docker push willemdb/multi-worker:latest

docker push willemdb/multi-client:$SHA
docker push willemdb/multi-server:$SHA
docker push willemdb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=willemdb/multi-server:$SHA
kubectl set image deployments/client-deployment client=willemdb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=willemdb/multi-worker:$SHA