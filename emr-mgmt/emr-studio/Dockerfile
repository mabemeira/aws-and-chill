FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y wget unzip curl openssh-client iputils-ping

ENV TERRAFORM_VERSION=1.6.4

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN mkdir -p /emr-mgmt/emr-studio
VOLUME /emr-mgmt/emr-studio
WORKDIR /emr-mgmt/emr-studio

RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

CMD ["/bin/bash"]
