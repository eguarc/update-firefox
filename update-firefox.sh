#!/bin/bash

download_dir=/home/ecostales/Downloads
firefox_parent_dir=/opt
firefox_bin=/usr/bin/firefox
firefox_arch=linux-x86_64
firefox_lang=es-US

/usr/bin/wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/ -O /tmp/list.tmp
release=$(grep release /tmp/listita |awk '{print $2}'|cut -c29-34|sort -h|tr -d "/"|tr -d "\""|egrep -v "(b|f|es)"|tail -n1)

cd $download_dir
/usr/bin/wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/${release}/${firefox_arch}/${firefox_lang}/firefox-${release}.tar.bz2

mv firefox-${release}.tar.bz2 /opt/
cd $firefox_parent_dir
tar xfv firefox-${release}.tar.bz2

if [ -f "firefox_bin" ]
then
  continue
else
  ln -s ${firefox_parent_dir}/firefox/firefox-bin $firefox_bin
fi

chown root.root firefox/ -R 
rm -rf /tmp/list.tmp
killall firefox
