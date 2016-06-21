# Class: artifactory_ha
# ===========================
#
# Full description of class artifactory_ha here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class artifactory_ha (
  $package_name = $::artifactory_ha::params::package_name,
  $service_name = $::artifactory_ha::params::service_name,
) inherits ::artifactory_ha::params {

  # validate parameters here

  class { '::artifactory_ha::install': } ->
  class { '::artifactory_ha::config': } ~>
  class { '::artifactory_ha::service': } ->
  Class['::artifactory_ha']
}
