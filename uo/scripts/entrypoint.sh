#! /bin/bash

if [[ ! -f /srv/docker/uo/.runuo-distro ]]; then
	wget --no-check-certificate http://github.com/Nerun/runuo-nerun-distro/archive/master.zip && \
	unzip -qq master.zip && \
	rm master.zip && \
	touch /srv/docker/uo/.runuo-distro
fi

if [[ ! -f /srv/docker/uo/.runuo ]]; then
	wget --no-check-certificate http://github.com/runuo/runuo/archive/master.zip && \
	unzip -qq master.zip && \
	rm master.zip && \
	touch /srv/docker/uo/.runuo && \
	cp -R runuo-nerun-distro-master/Distro/* runuo-master
fi

cd runuo-master && \
ls -alt && \
dmcs -optimize+ -unsafe -t:exe -out:RunUO.exe -win32icon:Server/runuo.ico -nowarn:219,414 -d:MONO -recurse:Server/*.cs /reference:System.Drawing.dll && \
ls -alt