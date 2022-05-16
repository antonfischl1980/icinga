# Gentoo Overlay Repository for Icinga2 related stuff (mainly check plugins)
QA-Status:
[![repoman](https://github.com/antonfischl1980/icinga/actions/workflows/repoman.yml/badge.svg)](https://github.com/antonfischl1980/icinga/actions/workflows/repoman.yml)
[![pkgcheck](https://github.com/antonfischl1980/icinga/actions/workflows/pkgcheck.yml/badge.svg)](https://github.com/antonfischl1980/icinga/actions/workflows/pkgcheck.yml)
[![ShellCheck](https://github.com/antonfischl1980/icinga/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/antonfischl1980/icinga/actions/workflows/shellcheck.yml)

## Intro
in its current form this repo hosts ebuilds for a handful of icinga2 check plugins (and, if necessary, their dependencies) that I found useful for myself.
I will also provide command definitions for icinga2, if necessary (i.e. the plugin isn't already in the icinga2 [ITL](https://icinga.com/docs/icinga-2/latest/doc/10-icinga-template-library/))

In rare cases these ebuilds also include templates for icingaweb2-modules-graphite (see net-analyzer/check_haproxy as an example).

There are also a few icingaweb2-modules in category www-apps.

I try to have these ebuilds as current to upstream as possible. ~~In the near future I want to have a bot doing most of the maintenance stuff (like bumping ebuilds on new releases)~~ For this, I have build a bot that does most of the (unstable) version bumping

If you think there is an check plugin missing, please file an Issue or (much more appreciated) a pull request at [Github](https://github.com/antonfischl1980/icinga).

## Adding the overlay

### Official list

#### Layman

If you are using [Layman](https://wiki.gentoo.org/wiki/Layman), execute:

``` sh
layman -a icinga
```

#### eselect-repository

If you are using [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository), execute:

``` sh
eselect repository enable icinga
```

## using the profile

This repo provides profiles selectable via "eselect profile" for default USE-Flags and masking/unmasking different packages.
Take a look at ``profiles/icinga/ `` for details.
``` sh
eselect profile list
...
[xx]  icinga:default/linux/amd64/17.1/icinga (stable)

eselect profile select icinga:default/linux/amd64/17.1/icinga
```

You can also use this profile as basis for your own profile. (see [wiki.gentoo.org](https://wiki.gentoo.org/wiki/Profile_(Portage)#Creating_custom_profiles))
``` sh
# make new repository
eselect repository create <repo_name>

# we must use 'portage-2' format so 'parent' can be easily set to other repos
echo "profile-formats = portage-2" >> /var/db/repos/<repo_name>/metadata/layout.conf

# create new profile
mkdir /var/db/repos/<repo_name>/profiles/<profile_name>
echo 7 > /var/db/repos/<repo_name>/profiles/<profile_name>/eapi

# set parent to mix and match your needs
echo "gentoo:default/linux/amd64/17.1" >/var/db/repos/<repo_name>/profiles/<profile_name>/parent
# include icinga defaults
echo "icinga:icinga" >> /var/db/repos/<repo_name>/profiles/<profile_name>/parent

# make it known to 'eselect profile'
echo -e "amd64\t<profile_name>\tstable" >> /var/db/repos/<repo_name>/profiles/profiles.desc

# select the new profile
eselect profile list
eselect profile set '<repo_name>:<profile_name>'

# don't forget to 'emerge world' for the changed USE-Flags
```

## Submitting an Issue

### Ebuild error

[the issue tracker is located in my **GitHub** repository.](https://github.com/antonfischl1980/icinga/issues) If an ebuild appears to produce an error, please report it there.


# Contributing

I appreciate and encourage for contribution. If you want a specific package or want to create a package for me to maintain, please make a pull request.


## TODOs

* ~~automatically generate new ebuilds (marked as unstable) if upstream releases new version~~
* provide a meta-ebuild that installs haproxy/apache/php/mariadb/graphite/grafana with example config and documentation. The goal here is to provide an "easy" installation for a running icinga2 instance in Gentoo
