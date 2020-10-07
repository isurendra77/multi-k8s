docker build -t ikalpana82/multi-client:latest -t ikalpana82/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ikalpana82/multi-server:latest -t ikalpana82/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ikalpana82/multi-worker:latest -t ikalpana82/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ikalpana82/multi-client:latest
docker push ikalpana82/multi-server:latest
docker push ikalpana82/multi-worker:latest

docker push ikalpana82/multi-client:$SHA
docker push ikalpana82/multi-server:$SHA
docker push ikalpana82/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ikalpana82/multi-server:$SHA
kubectl set image deployments/client-deployment client=ikalpana82/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ikalpana82/multi-worker:$SHA
