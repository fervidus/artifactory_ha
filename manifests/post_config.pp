# == Class artifactory::config
#
# This class is called from artifactory for service config.
#
class artifactory_ha::post_config {
  # Add the license file
  create_resources('::artifactory_ha::plugin', $::artifactory_ha::plugin_urls)
}
