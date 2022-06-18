docker build -t olivertzee/multi-client:latest -t olivertzee/multi-client:$SHA -f ./client/Dockerfile ./client
docker bulid -t olivertzee/multi-server:latest -t olivertzee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olivertzee/multi-worker:latest -t olivertzee/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push olivertzee/multi-client:latest
docker push olivertzee/multi-server:latest
docker push olivertzee/multi-worker:latest
docker push olivertzee/multi-client:$SHA
docker push olivertzee/multi-server:$SHA
docker push olivertzee/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olivertzee/multi-server:$SHA
kubectl set image deployments/client-deployment client=olivertzee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olivertzee/multi-worker:$SHA
