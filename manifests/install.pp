# == Class artifactory_ha::install
#
# This class is called from artifactory_ha for install.
#
class artifactory_ha::install {

  package { $::artifactory_ha::package_name:
    ensure => present,
  }
}
