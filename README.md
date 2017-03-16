# networker

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module installs the client part of EMC Networker backup software on
Linux servers.

You will need to separately configure a suitable package repository to provide
the `lgtoclnt` package.

## Usage

Usage is straightforward. The only mandatory parameter is `server`. Only set
the service and connections ports if your site is configured differently from
the defaults shown below.

```puppet
class { networker:
  service_ports    => '7937-7999',
  connection_ports => '10001-30000',
  server           => 'server.example.com'
  nsr_file         => 'puppet:///modules/networker/dotnsr'
}
```

Unless an alternative is specified, the default the dotnsr file is deployed.

## Limitations

Tested on CentOS, may work on other platforms.


## Development

Pull requests are gratefully received.

### Testing

Beaker acceptance tests can be run using `bundle exec rake beaker`. You will have to set a few site specific environment variables to make the tests useful.

  REPO: A URL to a yum repo where the Networker packages can be found


Example:

```
BEAKER_destroy=no NSRSRV=anubis.bris.ac.uk REPO='http://packages.example.com/centos/$releasever/$basearch' bundle exec rake beaker
```
