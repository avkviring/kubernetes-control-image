FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install curl gnupg git --yes
RUN apt-get install apt-transport-https --yes
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y helm kubectl
ENV HELM_PLUGINS /var/helm-plugins/
RUN helm plugin install https://github.com/chartmuseum/helm-push
RUN mkdir -p /var/helm-plugins/
COPY helm-plugin-config-creator/plugin.yaml helm-plugin-config-creator/
COPY helm-plugin-config-creator/cheetah* helm-plugin-config-creator/
RUN cd helm-plugin-config-creator && helm plugin install .
RUN apt-get install wget -y
RUN wget -c https://github.com/helmwave/helmwave/releases/download/v0.20.3/helmwave_0.20.3_linux_amd64.tar.gz -O - | tar -xz && mv helmwave /usr/local/bin/
