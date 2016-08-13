#! /bin/bash

if [[ ! -f /srv/docker/uo/lock/.runuo-distro ]]; then
	wget --no-check-certificate http://github.com/Nerun/runuo-nerun-distro/archive/master.zip && \
	unzip -qq master.zip && \
	rm master.zip && \
	touch /srv/docker/uo/.runuo-distro
fi

if [[ ! -f /srv/docker/uo/lock/.runuo ]]; then
	wget --no-check-certificate http://github.com/runuo/runuo/archive/master.zip && \
	unzip -qq master.zip && \
	rm master.zip && \
	touch /srv/docker/uo/.runuo && \
	cp -R runuo-nerun-distro-master/Distro/* runuo-master
fi

# Replace this stuff by sed to be more generic
cp -f RunUO.exe.config runuo-master/
cp -f Gold.cs runuo-master/Scripts/Items/Misc
cp -f BankCheck.cs runuo-master/Scripts/Items/Misc
cp -f DataPath.cs runuo-master/Scripts/Misc

cd runuo-master && \
dmcs -optimize+ -unsafe -t:exe -out:RunUO.exe -win32icon:Server/runuo.ico -nowarn:219,414 -d:MONO -recurse:Server/*.cs /reference:System.Drawing.dll

mono RunUO.exe
