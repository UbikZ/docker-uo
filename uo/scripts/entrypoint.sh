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

# Replace some files
cp -f RunUO.exe.config runuo-master/
cp -f Gold.cs runuo-master/Scripts/Items/Misc
cp -f BankCheck.cs runuo-master/Scripts/Items/Misc
cp -f DataPath.cs runuo-master/Scripts/Misc

# Add conf stuff within file and replace original after
sed -i -e "s/__UO_ADMIN_USERNAME__/$UO_ADMIN_USERNAME/g" -e "s/__UO_ADMIN_PASSWORD__/$UO_ADMIN_PASSWORD/g" AccountPrompt.cs &&
cp -f AccountPrompt.cs runuo-master/Scripts/Misc && \
sed -i -e "s/__UO_SERVER_NAME__/$UO_SERVER_NAME/g" -e "s/__UO_SERVER_IP__/$UO_SERVER_IP/g" AccountPrompt.cs && \
cp -f ServerList.cs runuo-master/Scripts/Misc

cd runuo-master && \
dmcs -optimize+ -unsafe -t:exe -out:RunUO.exe -win32icon:Server/runuo.ico -nowarn:219,414 -d:MONO -recurse:Server/*.cs /reference:System.Drawing.dll

mono RunUO.exe
