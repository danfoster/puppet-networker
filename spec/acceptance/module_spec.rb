require 'spec_helper_acceptance'

describe '<%= metadata.name %> class' do
  describe 'running puppet code' do
    it 'apply manifest' do
      pp = <<-EOS
        class { '<%= metadata.name %>': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

end
