require 'spec_helper'

describe 'artifactory_ha' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "artifactory_ha class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('artifactory_ha::params') }
          it { is_expected.to contain_class('artifactory_ha::install').that_comes_before('artifactory_ha::config') }
          it { is_expected.to contain_class('artifactory_ha::config') }
          it { is_expected.to contain_class('artifactory_ha::service').that_subscribes_to('artifactory_ha::config') }

          it { is_expected.to contain_service('artifactory_ha') }
          it { is_expected.to contain_package('artifactory_ha').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'artifactory_ha class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('artifactory_ha') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
