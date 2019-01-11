FROM	fedora:latest
LABEL 	maintainer="markus.heene@gmail.com"

RUN	dnf install -b -y gcc make automake git\
	motif motif-devel libXpm-devel libXaw-devel \
	xorg-x11-fonts-misc openssl-devel 

RUN	dnf -v -b -y --refresh --allowerasing update

# pcb-rnd-hid-lesstif 

RUN 	mkdir -p /tmp/download/afd && cd /tmp/download/
RUN	git clone https://github.com/holger24/AFD.git afd
RUN	cd afd && ac-tools/bootstrap && \
	./configure --enable-ssl --disable-dependency-tracking && \
	make -j`nproc` && make install

RUN	useradd afd -p afd
RUN	dnf remove -y gcc make automake git

USER	afd

ENV 	AFD_WORK_DIR=/home/afd/local
RUN	mkdir -p ~/local && mkdir -p ~/data

CMD	afd -a && afd_ctrl 


