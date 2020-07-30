docker build -t sanchitverma/multi-client:latest -t sanchitverma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanchitverma/multi-server:latest -t sanchitverma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanchitverma/multi-worker:latest -t sanchitverma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sanchitverma/multi-client:latest
docker push sanchitverma/multi-server:latest
docker push sanchitverma/multi-worker:latest

docker push sanchitverma/multi-client:$SHA
docker push sanchitverma/multi-server:$SHA
docker push sanchitverma/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=sanchitverma/multi-server:$SHA
kubectl set image deployments/client-deployment client=sanchitverma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sanchitverma/multi-worker:$SHA
