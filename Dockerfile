FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install curl gnupg git --yes
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update
RUN apt-get install helm
RUN helm plugin install https://github.com/chartmuseum/helm-push