FROM ubuntu:latest
WORKDIR /root
RUN apt-get update && apt-get install -y \
    apt-transport-https ca-certificates gnupg \
    vim
    # build-essential

# Networking
RUN apt-get install -y net-tools dnsutils iputils-ping traceroute curl

# gcloud requires python3
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends software-properties-common
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3.8

# gcloud
# requires apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-cli

# Postgres
RUN apt-get install -y postgresql-client

# GCP cloud-sql-proxy
RUN curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.1.2/cloud-sql-proxy.linux.amd64
RUN chmod +x /root/cloud-sql-proxy
