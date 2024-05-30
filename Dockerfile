FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install curl gnupg git --yes
RUN apt-get install apt-transport-https --yes
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN apt-get install apt-transport-https --yes
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y helm kubectl
ENV HELM_PLUGINS /var/helm-plugins/
RUN helm plugin install https://github.com/chartmuseum/helm-push
RUN mkdir -p /var/helm-plugins/
RUN apt-get install wget -y
RUN wget -c https://github.com/helmwave/helmwave/releases/download/v0.21.1/helmwave_0.21.1_linux_amd64.tar.gz -O - | tar -xz && mv helmwave /usr/local/bin/
RUN apt-get install git-crypt -y
