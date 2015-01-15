require 'spec_helper_acceptance'


## Configure A yum repo if the REPO env varible is set.
describe 'yum repo' do
  it 'local yum repo' do
    baseurl = ENV['REPO']

    if ($baseurl != "")
      pp = <<-EOS
        class { 'yumrepos':
          repos => {
            networker => {
              descr => 'Repo containing EMC networker packages',
              baseurl => '#{baseurl}',
              gpgcheck => 0
            }
          }
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
  end
end

describe 'networker class' do
  describe 'running puppet code' do
    it 'apply manifest' do
      server = ENV['NSRSRV']

      pp = <<-EOS
        class { 'networker':
          server => '#{server}',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

end
