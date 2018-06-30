FROM centos

RUN yum install -y epel-release

RUN yum install -y \
	make \
	python34 python34-pip python34-virtualenv \
	sudo

COPY run_as.sh /usr/bin/run_as
RUN chmod 755 /usr/bin/run_as

ENTRYPOINT ["/usr/bin/run_as"]

CMD "echo 'You have to provide the command to run' >&2 && exit 1"
