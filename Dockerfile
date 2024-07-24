FROM alpine:3.20.2

USER root

ARG HELM_VERSION="v3.15.3"
ENV K8S_VERSION="v1.26.15"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget git openssl bash \
 && wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_VERSION}-linux-amd64.tar.gz

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

USER jenkins

ENTRYPOINT ["helm"]
CMD ["help"]
