# == Class artifactory::config
#
# This class is called from artifactory for service config.
#
class artifactory_ha::post_config {
  file { "${::artifactory::artifactory_home}/etc/artifactory.system.properties":
    ensure => absent,
    source => "${::artifactory::artifactory_home}/etc/artifactory.system.properties",
  }

  file { "${::artifactory::artifactory_home}/etc/mimetypes.xml":
    ensure => absent,
    source => "${::artifactory::artifactory_home}/etc/mimetypes.xml",
  }
}
