cls
docker rm -f Ubuntu-Webserver
docker rmi -f sadaindonesia/ubuntu-webserver:0242ac120003
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/ubuntu-webserver:0242ac120003 "."
docker run -d -it --name Ubuntu-Webserver -p 80:80 -p 443:443 -p 7080:7080 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged sadaindonesia/ubuntu-webserver:0242ac120003
pause