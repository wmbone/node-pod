FROM node:latest

ARG IMAGE_CREATE_DATE
ARG IMAGE_VERSION
ARG IMAGE_SOURCE_REVISION

# Metadata as defined in OCI image spec annotations - https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="Node Pod" \
      org.opencontainers.image.description="Image for deploy in Kubernetes and testing CICD" \
      org.opencontainers.image.created=$IMAGE_CREATE_DATE \
      org.opencontainers.image.version=$IMAGE_VERSION \
      org.opencontainers.image.authors="Raymond Chiu" \
      org.opencontainers.image.url="https://hub.docker.com/wmbone/node-pod" \
      org.opencontainers.image.documentation="https://github.com/wmbone/node-pod/README.md" \
      org.opencontainers.image.vendor="Lab" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/wmbone/nod-pod.git" \
      org.opencontainers.image.revision=$IMAGE_SOURCE_REVISION 

# Create app directory
RUN echo "App directory" && mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY app/package.json /usr/src/app/
RUN echo "NPM install" && npm install

# Bundle app source
COPY /app /usr/src/app

USER node
CMD [ "npm", "start" ]