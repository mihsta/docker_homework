docker rm database --force
docker rm backend --force
docker rm frontend --force
docker run -p 80:80 -d --name frontend --network front-backend-network --network-alias frontend  frontend:0.1
docker run --rm --name database -e POSTGRES_PASSWORD=django -e POSTGRES_USER=django -e POSTGRES_DB=django -e USERMAP_UID=999 -e USERMAP_GID=999 -d -p 5432:5432 -v $HOME/postgres:/var/lib/postgresql/data --network backend-network --network-alias database postgres:0.1
docker run -p 8000:8000 -d --name backend --restart always --network backend-network --network-alias backend backend:0.1
docker network connect --alias backend front-backend-network backend
sudo docker network inspect front-backend-network
sudo docker network inspect backend-network

