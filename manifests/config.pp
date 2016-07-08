# == Class artifactory::config
#
# This class is called from artifactory for service config.
#
class artifactory_ha::config {
  # Default file sould have artifactory owner and group
  File {
    owner => 'artifactory',
    group => 'artifactory',
  }

  # Configure cluster home
  file { $::artifactory_ha::cluster_home:
    ensure => directory,
  }

  file { "${::artifactory_ha::cluster_home}/ha-etc":
    ensure => directory,
  }

  # Create the plugins directory
  file { "${::artifactory::clusterhome}/ha-etc/plugins":
    ensure  => directory,
  }

  file { "${::artifactory_ha::cluster_home}/ha-data":
    ensure => directory,
  }

  file { "${::artifactory_ha::cluster_home}/ha-backup":
    ensure => directory,
  }

  # Setup cluster.properties
  file { "${::artifactory_ha::cluster_home}/cluster.properties":
    ensure  => file,
    content => "security.token=${::artifactory_ha::security_token}",
  }

  file { "${::artifactory::artifactory_home}/etc/ha-node.properties":
    ensure  => absent,
    content => epp(
      'artifactory_ha/ha-node.propertes.epp',
      {
        node_id         => $::artifactory_ha::node_id,
        cluster_home    => $::artifactory_ha::cluster_home,
        context_url     => $::artifactory_ha::context_url,
        membership_port => $::artifactory_ha::membership_port,
        primary         => $::artifactory_ha::primary,
      }
    ),
    mode    => '0644',
  }
}
