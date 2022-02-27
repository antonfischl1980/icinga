# Gentoo Overlay Repository for Icinga2 related stuff (mainly check plugins)

## Intro
in its current form this repo hosts ebuilds for a handful of icinga2 check plugins (and, if necessary, their dependencies) that I found useful for myself.
I will also provide command definitions for icinga2, if necessary (i.e. the plugin isn't already in the icinga2 [ITL](https://icinga.com/docs/icinga-2/latest/doc/10-icinga-template-library/))

In rare cases these ebuilds also include templates for icingaweb2-modules-graphite (see net-analyzer/check_haproxy as an example).

There are also a few icingaweb2-modules in category www-apps.

I try to have these ebuilds as current to upstream as possible. ~~In the near future I want to have a bot doing most of the maintenance stuff (like bumping ebuilds on new releases)~~ For this, I have build a bot that does most of the (unstable) version bumping

If you think there is an check plugin missing, please file an Issue or (much more appreciated) a pull request at [Github](https://github.com/antonfischl1980/icinga). 

## TODOs

* ~~automatically generate new ebuilds (marked as unstable) if upstream releases new version~~
* provide a meta-ebuild that installs haproxy/apache/php/mariadb/graphite/grafana with example config and documentation. The goal here is to provide an "easy" installation for a running icinga2 instance in Gentoo
