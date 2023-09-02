#!/bin/bash

if [ -z $(docker images -q sphinx-latexpdf) ]; then
  docker build -t devhub-sphinx-latexpdf - < .dockerfiles/Dockerfile
fi

docker run -it --rm -v ${PWD}:/docs devhub-sphinx-latexpdf /bin/bash
