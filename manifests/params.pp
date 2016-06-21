# == Class artifactory_ha::params
#
# This class is meant to be called from artifactory_ha.
# It sets variables according to platform.
#
class artifactory_ha::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'artifactory_ha'
      $service_name = 'artifactory_ha'
    }
    'RedHat', 'Amazon': {
      $package_name = 'artifactory_ha'
      $service_name = 'artifactory_ha'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
