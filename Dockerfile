
# Started with the example from: https://docs.docker.com/engine/examples/running_ssh_service/
# Modified to build from latest ubuntu and include key authentication and installation of ping, dns utils, curl and socat

FROM ubuntu:latest

# Install cron & sshd access

RUN apt-get update && apt-get install -y \
    supervisor \
    cron \
    openssh-server \
    build-essential \
    wget \ 
    vim \
    curl 

RUN mkdir /var/run/sshd 
RUN mkdir -p /usr/src/app 

WORKDIR /usr/src/app

# For ssh key configuration use this
RUN mkdir /root/.ssh
ADD authorized_keys /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# For password authentication, do these two. For now I'm leaving them commented out
#RUN echo “root:IBMPC_313” | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV Author "Andres Gorostidi"
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
# http://stackoverflow.com/questions/36292317/why-set-visible-now-in-etc-profile

# ADD Crontab file in the cron directory
ADD crontab /etc/cron.d/sample-cron
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/sample-cron
RUN /usr/bin/crontab /etc/cron.d/sample-cron

# ADD Supervisor to run multiple CMD / Daemons at Docker Start
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Open port 22 for SSH access
EXPOSE 22

CMD ["/usr/bin/supervisord"]
