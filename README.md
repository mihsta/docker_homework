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
## Docker build 
#### frontend
sudo docker build -f Dockerfile.front -t frontend:0.1 frontend
## Docker run
sudo docker run -p 8080:80 -d --name frontend frontend:0.1
curl -i localhost:8080

## Inspiration
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
https://snyk.io/wp-content/uploads/10-best-practices-to-containerize-Node.js-web-applications-with-Docker.pdf
https://dev.to/nodepractices/docker-best-practices-with-node-js-4ln4
https://dev-gang.ru/article/kak-obsluzhivat-prilozhenija-react-s-pomosczu-nginx-i-docker-mf53hirfey/
https://typeofnan.dev/how-to-serve-a-react-app-with-nginx-in-docker/