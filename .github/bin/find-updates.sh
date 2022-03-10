#!/bin/bash

# only to be run via .github/workflows/bump-ebuilds.yml

# check packages hosted on Github
while read PLUGIN;do
	echo "xxxxxxxxxxxxxxxxxxxxx"
	echo "Checking ${PLUGIN}"

	REMOTE_URL="$(grep 'remote-id type="github"' "${PLUGIN}"/metadata.xml |head -1|sed -E 's#^.*<remote-id[^>]+>#https://github.com/#; s#</remote-id>#.git#')"
	echo "$REMOTE_URL"|grep -q "^https://github.com/lausser/" && continue # ignore repos from Lausser, he stopped tagging versions a few years ago
	echo "remote URL: ${REMOTE_URL}"

	REMOTE_VERSION="$(git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags "${REMOTE_URL}"|cut --delimiter='/' --fields=3|grep -E "^v?[0-9.]+$"|tail -1|sed 's/v//g')"
	if [ -z "${REMOTE_VERSION}" ]; then
		echo "No Remote-tags"
		continue
	fi
	echo "${REMOTE_VERSION} (version upstream)"

	LOCAL_VERSION="$(equery l -o "$PLUGIN::icinga" --format='$version'|tail -1)"
	echo "${LOCAL_VERSION} (version local)"

	if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ];then
		echo "bump needed"
		echo "$PLUGIN-$REMOTE_VERSION" >> /todo.lst
	fi

	echo "${PLUGIN}" >>/checked.lst
done < <(grep -l 'remote-id type="github"' */*/metadata.xml|xargs dirname)

#consol
while read PLUGIN;do 
	echo "xxxxxxxxxxxxxxxxxxxxx"
	echo "Checking ${PLUGIN}"

	REMOTE_NAME="${PLUGIN##*/}"
	REMOTE_NAME="${REMOTE_NAME##nagios-}"
	echo "REMOTE_NAME: ${REMOTE_NAME}"

	REMOTE_VERSION="$(wget https://labs.consol.de/nagios/${REMOTE_NAME}/ -qO -|grep -Eoi '<a [^>]+>'|grep -Eo "/${REMOTE_NAME}-[0-9\.]+.tar.gz"|sed "s#^/##g;s#.tar.gz##g;s#${REMOTE_NAME}-##g")"
	if [ -z "$REMOTE_VERSION" ]; then
		echo "Keine Remote-Version"
		continue
	fi
	echo "${REMOTE_VERSION} (version upstream)"

	LOCAL_VERSION="$(equery l -o "$PLUGIN::icinga" --format='$version'|tail -1)"
	echo "${LOCAL_VERSION} (version local)"

	if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ];then
		echo "bump needed"
		echo "$PLUGIN-$REMOTE_VERSION" >> /todo.lst
	fi

	echo "${PLUGIN}" >>/checked.lst
done < <(grep -l 'remote-id type="github".*lausser' */*/metadata.xml|xargs dirname|grep -v "dev-perl/GLPlugin")


# dev-perl/GLPlugin
echo "xxxxxxxxxxxxxxxxxxxxx"
echo "Checking dev-perl/GLPlugin"
REMOTE_VERSION="$(wget -qO - "https://raw.githubusercontent.com/lausser/GLPlugin/master/lib/Monitoring/GLPlugin.pm" | awk '/VERSION/{print gensub(/.*[^0-9\.]([0-9\.]+)[^0-9\.].*/, "\\1", "g", $0)}')"
echo "${REMOTE_VERSION} (version upstream)"
echo "${REMOTE_VERSION}" | grep -qE "^([0-9]+\.){1,3}[0-9]+$" || ( echo "${REMOTE_VERSION} (version upstream) doesn't parse"; exit 1 )
REMOTE_COMMIT="$(git ls-remote -h --exit-code https://github.com/lausser/GLPlugin.git master|cut -f 1)"
LOCAL_VERSION="$(equery l -o "dev-perl/GLPlugin::icinga" --format='$version'|tail -1)"
echo "${LOCAL_VERSION} (version local)"
if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ];then
	echo "bump needed"
	echo "dev-perl/GLPlugin-$REMOTE_VERSION" >> /todo.lst
	echo "${REMOTE_COMMIT}" >/GLPlugin.version
fi
echo "dev-perl/GLPlugin" >>/checked.lst
# Ende dev-perl/GLPlugin


exit 0

# CPAN
# setup cpan
echo | cpan >/dev/null
while read PLUGIN;do 
	echo "xxxxxxxxxxxxxxxxxxxxx"
	echo "Checking ${PLUGIN}"

	REMOTE_NAME="$(grep cpan-module "${PLUGIN}/metadata.xml" |head -1|sed -E 's#^.*>(([a-zA-Z]+::)+[a-zA-Z]+)<.*$#\1#')"
	echo "REMOTE_NAME: ${REMOTE_NAME}"

	# cpan -D DBD::Oracle|awk '/CPAN:/{print $2}'
	REMOTE_VERSION="$(cpan -D "${REMOTE_NAME}"|awk '/CPAN:/{print $2}')"
	echo "${REMOTE_VERSION}"|grep -qE '^(([0-9]+\.)+[0-9]+)$'
	if [ $? -ne 0 ];then
		echo "Keine Remote-Version (${REMOTE_VERSION})"
		continue
	fi
	echo "${REMOTE_VERSION} (version upstream)"

	LOCAL_VERSION="$(equery l -o "$PLUGIN::icinga" --format='$version'|tail -1)"
	echo "${LOCAL_VERSION} (version local)"

	if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ];then
		echo "bump needed"
		echo "$PLUGIN-$REMOTE_VERSION" >> /todo.lst
	fi

	echo "${PLUGIN}" >>/checked.lst
done < <(grep -l 'remote-id type="cpan"' */*/metadata.xml|xargs dirname)

# END CPAN
