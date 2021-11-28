# docker_homework
# 1 Лекция
Написать Dockerfile для frontend располагается в директории /frontend, собрать и запустить
# 2 Лекция
Написать Dockerfile для backend который располагается в директории /lib_catalog(для сборки контейнера необходимо использовать файл /lib_catalog/requirements.txt), для работы backend необходим postgresql, т.е. необходимо собрать 2 контейнера:
1. backend
2. postgresql

Осуществить сетевые настройки, для работы связки backend и postgresql
# 3 Лекция
Написать docker-compose.yaml, для всего проекта, собрать и запустить

# Критерий оценки финального задания
1. Dockerfile должны быть написаны согласно пройденным best practices
2. Для docker-compose необходимо использовать локальное image registry
3. В docker-compose необходимо сетевые настройки 2 разных интерфейса(bridge), 1 - для фронта, 2 - для бека с postgresql

4.* Осущиствить сборку проекта самим docker-compose команда docker-compose build(при использовании этого подхода необходимо исключить 2 пункт из критерии оценки)

#Docker commands
## ubuntu Docker install
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
docker version
## add user to Docker group (fix vscode: connect EACCES /var/run/docker.sock) need to relogin after command
sudo groupadd docker
sudo usermod -aG docker $USER

## Docker networks
docker network ls
sudo docker network create --driver bridge --subnet 192.168.100.0/24 --ip-range 192.168.100.0/24 backend-network
sudo docker network create --driver bridge --subnet 192.168.101.0/24 --ip-range 192.168.101.0/24 front-backend-network
docker network connect --alias backend front-backend-network backend
sudo docker network inspect front-backend-network
sudo docker network inspect backend-network
## Docker build 
#### Docker build&run frontend
sudo docker build -f Dockerfile.front -t frontend:0.1 .
sudo docker run -p 8080:80 -d --name frontend --network front-backend-network --network-alias frontend  frontend:0.1
curl -i localhost:8080

## Docker build&run db
sudo docker build -f Dockerfile.db -t postgres:0.1 .
sudo docker run --rm --name database -e POSTGRES_PASSWORD=django -e POSTGRES_USER=django -e POSTGRES_DB=django -e USERMAP_UID=999 -e USERMAP_GID=999 -d -p 5432:5432 -v $HOME/postgres:/var/lib/postgresql/data --network backend-network --network-alias database postgres:0.1
## Docker build&run backend
sudo docker build -f Dockerfile.back -t backend:0.1 .
sudo docker run -p 8000:8000 -d --name backend --restart always --network backend-network --network-alias backend backend:0.1
sudo docker logs backend

## Install docker-compose 
sudo curl -L "https://github.com/docker/compose/releases/download/v2.1.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version

## Inspiration
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
https://snyk.io/wp-content/uploads/10-best-practices-to-containerize-Node.js-web-applications-with-Docker.pdf
https://dev.to/nodepractices/docker-best-practices-with-node-js-4ln4
https://dev-gang.ru/article/kak-obsluzhivat-prilozhenija-react-s-pomosczu-nginx-i-docker-mf53hirfey/
https://typeofnan.dev/how-to-serve-a-react-app-with-nginx-in-docker/
https://selectel.ru/blog/postgresql-docker-setup/
https://docs.microsoft.com/ru-ru/visualstudio/docker/tutorials/multi-container-apps
https://mundanecode.com/posts/three-tier-architecture-in-docker/
https://habr.com/ru/post/226419/
https://docs.nginx.com/nginx/admin-guide/web-server/app-gateway-uwsgi-django/
https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/
https://saasitive.com/tutorial/docker-compose-django-react-nginx-let-s-encrypt/
https://stackoverflow.com/questions/22476273/no-access-control-allow-origin-header-is-present-on-the-requested-resource-i
