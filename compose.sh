echo && echo "PikWi says: docker-compose stop" && \
    docker-compose stop && \
        echo "PikWi says: docker-compose rm ..." && \
    docker-compose rm -f --all && \    
        echo "PikWi says: docker-compose pull" && \
    docker-compose pull && \
        echo "PikWi says: docker-compose build ..." && \
    docker-compose build && \
        echo "PikWi says: docker-compose up ..." && \
    docker-compose up -d --force-recreate --remove-orphans
