# Class: artifactory
# ===========================
#
# Full description of class artifactory here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#

class artifactory_ha(
  Enum['mssql', 'mysql', 'oracle', 'postgresql'] $db_type,
  Integer $db_port,
  String $db_hostname,
  String $db_username,
  String $db_password,
  String $security_token,
  Boolean $is_primary,
  String $cluster_home,
  String $license_key,
  Integer $membership_port                                                = 10001,
  String $yum_name                                                        = 'bintray-jfrog-artifactory-pro-rpms',
  String $yum_baseurl                                                     = 'http://jfrog.bintray.com/artifactory-pro-rpms',
  String $package_name                                                    = 'jfrog-artifactory-pro',
  String $artifactory_home                                                = '/var/opt/jfrog/artifactory',
  Optional[Enum['filesystem', 'fullDb','cachedFS']] $binary_provider_type = undef,
  Optional[Integer] $pool_max_active                                      = undef,
  Optional[Integer] $pool_max_idle                                        = undef,
  Optional[Integer] $binary_provider_cache_maxSize                        = undef,
  Optional[String] $binary_provider_filesystem_dir                        = undef,
  Optional[String] $binary_provider_cache_dir                             = undef,
) {

  $storage_properties_location = "${cluster_home}/ha-etc/plugins"

  class {'::artifactory_pro::install':
    license_key                    => $license_key,
    yum_name                       => $yum_name,
    yum_baseurl                    => $yum_baseurl,
    package_name                   => $package_name,
    artifactory_home               => $artifactory_home,
    storage_properties_location    => $storage_properties_location,
    db_type                        => $db_type,
    db_port                        => $db_port,
    db_hostname                    => $db_hostname,
    db_username                    => $db_username,
    db_password                    => $db_password,
    binary_provider_type           => $binary_provider_type,
    pool_max_active                => $pool_max_active,
    pool_max_idle                  => $pool_max_idle,
    binary_provider_cache_maxSize  => $binary_provider_cache_maxSize,
    binary_provider_filesystem_dir => $binary_provider_filesystem_dir,
    binary_provider_cache_dir      => $binary_provider_cache_dir,
  } ->
  class{'::artifactory_ha::config': } ~>
  Class['::artifactory::service']
}
