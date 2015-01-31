FROM centos:6.6
MAINTAINER Kazuya Yokogawa "yokogawa-k@klab.ocm"

RUN yum -y update \
    && yum -y install openssh-server \
    && yum clean all

RUN mkdir /var/run/ssh \
    && sed -i \
    -e 's/^#PermitRootLogin yes/PermitRootLogin no/' \
    -e 's/^PasswordAuthentication yes/PasswordAuthentication no/' \
    -e 's/^#UseDNS yes/UseDNS no/' \
    -e 's/^UsePAM yes/UsePAM no/' \
    /etc/ssh/sshd_config \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""

ENV CREATE_USER_NAME yokogawa-k
ENV CREATE_USER_ID 1223
RUN groupadd -g ${CREATE_USER_ID} ${CREATE_USER_NAME} \ 
    && useradd -g ${CREATE_USER_ID} -u ${CREATE_USER_ID} -m -d /home/${CREATE_USER_NAME} -p "*" -s /bin/bash ${CREATE_USER_NAME} \
    && mkdir /home/${CREATE_USER_NAME}/.ssh \
    && curl -L https://github.com/${CREATE_USER_NAME}.keys >>/home/${CREATE_USER_NAME}/.ssh/authorized_keys \
    && chown -R ${CREATE_USER_ID}:${CREATE_USER_ID} /home/${CREATE_USER_NAME}

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
