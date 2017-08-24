set -v
image=ocserv
docker rmi $image || true
docker build --rm=true -t $image .
