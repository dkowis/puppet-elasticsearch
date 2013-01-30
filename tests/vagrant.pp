stage { pre: before => Stage[main] }

class yum_update {
  $sentinel = "/var/run/first-puppet-run"

  exec { "initial yum update":
    command => "/usr/bin/yum -y update && touch ${sentinel}",
  # run the initial yum update only if there's files older than our sentinal in the yum repos dir
    onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /var/lib/yum/repos -type f -cnewer ${sentinel})\"",
    timeout => 3600,
  }
}

# I think this will work even without yum update
class { 'yum_update':
  stage => pre,
}

group { 'puppet': 
  ensure => present,
  system => true,
}

class { 'elasticsearch':
}
