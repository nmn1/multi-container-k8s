docker build -t naman01/multi-client:latest -t naman01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naman01/multi-server:latest -t naman01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naman01/multi-worker:latest -t naman01/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push naman01/multi-client:latest
docker push naman01/multi-client:$SHA
docker push naman01/multi-server:latest
docker push naman01/multi-server:$SHA
docker push naman01/multi-worker:latest
docker push naman01/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naman01/multi-server:$SHA
kubectl set image deployments/client-deployment server=naman01/multi-client:$SHA
kubectl set image deployments/worker-deployment server=naman01/multi-worker:$SHA