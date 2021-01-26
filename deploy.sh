docker build -t aaysenur/multi-client:latest -t aaysenur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aaysenur/multi-server:latest -t aaysenur/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t aaysenur/multi-worker:latest -t aaysenur/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push aaysenur/multi-client:latest
docker push aaysenur/multi-server:latest
docker push aaysenur/multi-worker:latest

docker push aaysenur/multi-client:$SHA
docker push aaysenur/multi-server:$SHA
docker push aaysenur/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aaysenur/multi-server:$SHA
kubectl set image deployments/client-deployment client=aaysenur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aaysenur/multi-worker:$SHA