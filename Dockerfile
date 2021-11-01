FROM ubuntu:18.04

RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo

RUN apt-get -y install sudo curl openssh-server jq awscli \
    && curl https://s3.ap-northeast-1.amazonaws.com/amazon-ssm-ap-northeast-1/latest/debian_amd64/amazon-ssm-agent.deb -o /tmp/amazon-ssm-agent.deb \
    && dpkg -i /tmp/amazon-ssm-agent.deb \
    && cp /etc/amazon/ssm/seelog.xml.template /etc/amazon/ssm/seelog.xml \
    && adduser ssm-user && echo "ssm-user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ssm-agent-users \
    && mv /etc/amazon/ssm/amazon-ssm-agent.json.template /etc/amazon/ssm/amazon-ssm-agent.json \
    && mv /etc/amazon/ssm/seelog.xml.template /etc/amazon/ssm/seelog.xml

COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

COPY run.sh /run.sh
RUN chmod 755 /run.sh

CMD ["bash", "run.sh"]

