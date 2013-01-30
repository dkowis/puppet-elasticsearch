Puppet module for [elasticsearch] on Centos6.

There isn't an RPM shipped for elastic search on Centos, and we're
deploying to RHEL6, so I am building a puppet module for it.
This module roughly matches the behavior of the `.deb` file shipped with
elasticsearch version 0.19. I can't use 0.19 with the current version of
[logstash], however, hence this module.

[logstash]: https://github.com/logstash/logstash

## Prerequisites

* An Centos 6 system
* Puppet 3

## Installation

    cd /etc/puppet/modules
    git clone git://github.com/dkowis/puppet-elasticsearch elasticsearch
    cd elasticsearch
    make fetch # for default 0.18.7 download

## Usage

    class { 'elasticsearch':
      version      => '0.20.4',
      java_package => 'java-1.7.0-openjdk',
      dbdir        => '/var/lib/elasticsearch',
      logdir       => '/var/log/elasticsearch',
    }

All arguments are optional.

## Configuration:

The parameters to `elasticsearch` aside, you can supply your own
`elasticsearch.yml` and `logging.yml` files by making them available via the
Puppet file server as either:

* `site-elasticsearch/${fqdn}/*.yml` or
* `site-elasticsearch/*.yml`. 

If you don't supply them, the default content will be supplied by the module.

## Testing:

### Smoke Testing

* `make test` or `make smoke` to perform a simple [smoke test]

### Vagrant

* Install [Vagrant]

* Get the `centos6_x86_64` box (safe even if you already have it):

        vagrant box add centos6_x86_64 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-x86_64-v20130101.box

* Fetch the default version of elasticsearch:

        make fetch

* Launch the virtual machine:

        vagrant up

[elasticsearch]: http://www.elasticsearch.org/
[Vagrant]: http://vagrantup.com/
[smoke test]: http://docs.puppetlabs.com/guides/tests_smoke.html
[get in touch]: http://twitter.com/garthk
