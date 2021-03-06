#
#
define artifactory_ha::plugin(
  String $url,
  )
{
  # Default file sould have artifactory owner and group
  File {
    owner => 'artifactory',
    group => 'artifactory',
    mode  => 'a+rx',
  }

  $file_name =  regsubst($url, '.+\/([^\/]+)$', '\1')

  file {"${::artifactory_ha::cluster_home}/ha-etc/plugins/${file_name}":
    ensure => file,
    source => $url,
    notify => Class['::artifactory::service'],
  }
}
