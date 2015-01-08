# == Class: networker
#
# Full description of class networker here.
#
# === Examples
#
#  class { 'networker':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Dan Foster <dan@zem.org.uk>
#
# === Copyright
#
# Copyright 2015 Dan Foster, unless otherwise noted.
#
class networker (
  $service_ports = $networker::params::service_ports,
  $connection_ports = $networker::params::connection_ports,
  $server = $networker::params::server
) inherits networker::params

  $shortserver = inline_template("<%= '${server}'.split('.')[0] %>")

  package { 'lgtoclnt':
    ensure => present
  }

  file { '/.nsr':
    ensure => file,
    source => 'puppet:///modules/networker/dotnsr',
  }

  file { '/nsr/res':
    ensure  => 'directory',
    recurse => true,
    require => Package['lgtoclnt']
  }

  file { '/nsr/res/servers':
    ensure  => file,
    content => "${server}
${shortserver}
",
    require => File['/nsr/res']
  }

  service { 'networker':
    ensure  => running,
    require => Package['lgtoclnt']
  }

  exec { "/usr/bin/nsrports -s ${server} -S ${service_ports}":
    refreshonly => true,
    subscribe   => Package['lgtoclnt'],
    require     => Service['networker'],
  }

  exec { "/usr/bin/nsrports -S ${service_ports}":
    refreshonly => true,
    subscribe   => Package['lgtoclnt'],
    require     => Service['networker'],
  }

  exec { "/usr/bin/nsrports -s ${server} -C ${connection_ports}":
    refreshonly => true,
    subscribe   => Package['lgtoclnt'],
    require     => Service['networker'],
  }

  exec { "/usr/bin/nsrports -C ${connection_ports}":
    refreshonly => true,
    subscribe   => Package['lgtoclnt'],
    require     => Service['networker'],
  }

  firewall {'050 allow central backups service ports':
    port   => $service_ports,
    action => accept,
    source => $server
  }

  firewall {'050 allow central backups connection ports':
    port   => $connection_ports,
    action => accept,
    source => $server
  }

}
