FROM	fedora:latest
LABEL maintainer="markus.heene@gmail.com"
RUN	dnf install -b -y gcc make automake motif-devel motif pcb-rnd-hid-lesstif libXpm-devel libXaw-devel xorg-x11-fonts-misc openssl-devel git
RUN 	mkdir -p /tmp/download/afd && cd /tmp/download/
RUN	git clone https://github.com/holger24/AFD.git afd
RUN	cd afd && ac-tools/bootstrap && ./configure --enable-ssl --disable-dependency-tracking && make && make install
RUN	useradd afd -p afd
RUN	dnf remove -y gcc make automake git
USER	afd
RUN	mkdir -p ~/local && echo "AFD_WORK_DIR=~/local" >> ~/.bashrc && \
	export AFD_WORK_DIR >> ~/.bashrc && source ~/.bashrc
ENV 	AFD_WORK_DIR=/home/afd/local
CMD	afd -a && afd_ctrl 


