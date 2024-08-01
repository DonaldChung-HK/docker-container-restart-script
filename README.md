# docker-container-restart-script
This script is for use with cron job to monitor a container by name and restart the container when it is unhealthy

Some containers have software that will fail while container will keep on running. While docker have `HEALTHCHECK`but the restart when unhealthy, it is limited to docker swarm. 

Thus, this script is to replicate that feature but using cron to assist in monitoring the health of container and restart when needed.

## Comparison with existing solution
Other cleaner solutions such as [willfarrell/docker-autoheal](https://github.com/willfarrell/docker-autoheal) exist. However, it requireses mounting the docker socket to docker container which may increase the attack surface if the docker socket is exposed even if it is not ment to be.

## Usage
Make sure the script has execution permission and add it to `crontab`
```
* * * * * /path/to/check_container_health_restart.sh <container-name> # this runs the script every minutes
```

## Limitation
- This checks for container name so it might be useful to pin the container name of a service so that it stays the same after recreate or restart
- Please audit the script to make sure that it fits the security requirements of your service
- The maximum resolution of a cron job is running every minute. There are workarounds but they are not recommended
