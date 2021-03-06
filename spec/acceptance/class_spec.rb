require 'spec_helper_acceptance'

describe 'artifactory_ha class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'will work idempotently with no errors' do
      pp = <<-EOS
      class { 'artifactory_ha':
            license_key => 'key123',
            jdbc_driver_url => 'http://192.168.0.152/mysql-connector-java-8.0.12.jar',
            db_type => 'mysql',
            db_url => 'jdbc:mysql://192.168.0.152/test?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC',
            db_username => 'artifactory',
            db_password => 'password',
            security_token => '123security_token_4me',
            is_primary => true,
            cluster_home => '/tmp/',
        }
        end

      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('jfrog-artifactory-pro') do
      it { is_expected.to be_installed }
    end

    describe service('artifactory') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
