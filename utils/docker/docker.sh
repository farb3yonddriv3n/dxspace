d=$(date +%s)
docker commit `docker ps -lq` user/$d
echo "docker run -ti --cap-add=SYS_PTRACE --entrypoint=/bin/bash user/$d"

# rc:
echo "docker exec -ti `docker ps -lq` /bin/bash"
