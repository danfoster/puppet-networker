require 'beaker-rspec'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    foss_opts = { :default_action => 'gem_install' }


    hosts.each do |host|
      if default.is_pe?; then install_pe; else install_puppet( foss_opts ); end
      on hosts, "mkdir -p #{host['distmoduledir']}"
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => proj_root, :module_name => 'networker')
    hosts.each do |host|
      # Install and dep modules, e.g. 
      on host, puppet('module','install','gbrown-yumrepos'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module','install','puppetlabs-firewall'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
