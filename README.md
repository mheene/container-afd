# docker-afd
This repository contains a Dockerfile for [afd](https://github.com/holger24/AFD)

# Play with Docker
Perhaps you don't have docker and you simply want to get a glimpse into it. Just try this (Docke\
r account needed - you can create your Docker ID [here](https://hub.docker.com/) ):

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/mheene/docker-afd/master/stack.yml)

It runs docker in your browser and pulls the images and runs the dashboard.


# Build the image
docker build -t mheene/docker-afd .

# Run the image directly my pulling it from docker hub
docker run  -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name afd --mount source=afd_work_dir,target=/home/afd/local --mount source=data,target=/home/afd/data mheene/docker-afd

Idea:
* Store configuration on the host in the volume "afd_work_dir" -- container /home/afd/local
* Store data on the host in the volume "data" -- container /home/afd/data




