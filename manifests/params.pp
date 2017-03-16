# == Class: networker::params
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class networker::params {
  $service_ports = '7937-7999'
  $connection_ports = '10001-30000'
  $server = 'server.example.com'
  $nsr_file = 'puppet:///modules/networker/dotnsr'
}
