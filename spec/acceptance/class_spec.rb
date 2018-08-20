require 'spec_helper_acceptance'

describe 'artifactory_ha class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'will work idempotently with no errors' do
      pp = <<-EOS
      class { 'artifactory_ha':
            license_key => 'my_license_key',
            jdbc_driver_url => 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war',
            db_type => 'mysql',
            db_url => 'jdbc:oracle:sad',
            db_username => 'my_db_user',
            db_password => 'egpiqwgoq[hgewoiehf]',
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
