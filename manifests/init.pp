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
  String $jdbc_driver_url,
  Enum['mariadb', 'mssql', 'mysql', 'oracle', 'postgresql'] $db_type,
  String $db_url,
  String $db_username,
  String $db_password,
  String $security_token,
  Boolean $is_primary,
  String $cluster_home,
  String $license_key,
  Integer $membership_port                                                = 10001,
  Boolean $manage_java                                                    = true,
  Boolean $manage_repo                                                    = true,
  String $yum_name                                                        = 'bintray-jfrog-artifactory-pro-rpms',
  String $yum_baseurl                                                     = 'http://jfrog.bintray.com/artifactory-pro-rpms',
  String $package_name                                                    = 'jfrog-artifactory-pro',
  Optional[Enum['filesystem', 'fullDb','cachedFS']] $binary_provider_type = undef,
  Optional[Integer] $pool_max_active                                      = undef,
  Optional[Integer] $pool_max_idle                                        = undef,
  Optional[Integer] $binary_provider_cache_maxsize                        = undef,
  Optional[String] $binary_provider_filesystem_dir                        = undef,
  Optional[String] $binary_provider_cache_dir                             = undef,
  Hash $plugin_urls                                                       = {},
) {

  $storage_properties_location = "${cluster_home}/ha-etc/plugins"

  class {'::artifactory_pro':
    license_key  => $license_key,
    yum_name     => $yum_name,
    yum_baseurl  => $yum_baseurl,
    package_name => $package_name,
    manage_java  => $manage_java,
    manage_repo  => $manage_repo,
  }
  -> class{'::artifactory_ha::config': }
  -> class{'::artifactory_ha::post_config': }

  # Ensure Artifactory Pro is configured before Artifactory HA.
  Class['::artifactory_pro::config']
  -> Class['::artifactory_ha::config']
  ~> Class['::artifactory::service']

  Class['::artifactory_ha::post_config']
  ~> Class['::artifactory::service']
}
