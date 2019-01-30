FROM	fedora:latest
LABEL 	maintainer="markus.heene@gmail.com"

RUN	dnf install  -b -y gcc make automake git\
	motif motif-devel libXpm-devel libXaw-devel \
	xorg-x11-fonts-misc openssl-devel lbzip2\
	python2-2.7.15-11.fc29.x86_64 python2-pygrib python2-numpy \
	python2-matplotlib python2-basemap ImageMagick libxslt

# RUN	dnf -q -b -y --refresh --allowerasing update



RUN 	mkdir -p /tmp/download/afd && cd /tmp/download/
RUN	git clone https://github.com/holger24/AFD.git afd
RUN	cd afd && ac-tools/bootstrap && \
	./configure -q --enable-ssl --disable-dependency-tracking && \
	make -s -j`nproc` && make -s install



RUN	useradd -ms /bin/bash afd 

# RUN	dnf remove -q -y gcc make automake git

USER	afd

ENV 	AFD_WORK_DIR=/home/afd/local
RUN	mkdir -p ~/local && mkdir -p ~/data && \
	mkdir -p ~/scripts && mkdir -p ~/plotGRIB/data && \
	mkdir -p ~/config && mkdir -p ~/tmp && cd ~/tmp && \
	git clone https://github.com/buwx/meteogram.git meteogram

COPY	./docker-entrypoint.sh /home/afd
COPY	scripts/* /home/afd/scripts/
COPY	config/* /home/afd/config/

RUN	cp /home/afd/scripts/meteogram* /home/afd/tmp/meteogram/
RUN	cp /home/afd/scripts/prepareMOS.sh /home/afd/tmp/meteogram/



ENTRYPOINT ["/home/afd/docker-entrypoint.sh"]
CMD	["afd_ctrl"]


