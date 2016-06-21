# == Class artifactory_ha::service
#
# This class is meant to be called from artifactory_ha.
# It ensure the service is running.
#
class artifactory_ha::service {

  service { $::artifactory_ha::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
