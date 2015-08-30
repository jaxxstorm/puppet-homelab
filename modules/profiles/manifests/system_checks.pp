# Some base system checks
class profiles::system_checks {

  # TODO: is this the best place for this?
  package { 'nagios-plugins-all':
    ensure => installed,
  }

  package { 'sensu-plugins-memory-checks':
    ensure   => installed,
    provider => sensu_gem
  }

  package { 'sensu-plugins-cpu-checks':
    ensure   => installed,
    provider => sensu_gem
  }

  moncheck { 'check_disk_usage':
    command           => '/usr/lib64/nagios/plugins/check_disk -u GB -l',
    event_description => 'Check the free disk space on this host!'
  }

  moncheck { 'check_load':
    command           => '/usr/lib64/nagios/plugins/check_load -r -w 5,5,5 -c 10,10,10',
    event_description => 'check the load on this host!'
  }

  moncheck { 'check_cpu':
    command           => '/opt/sensu/embedded/bin/check-cpu.rb',
    event_description => 'CPU usage is too high!',
  }

  moncheck { 'check_ram':
    command           => '/opt/sensu/embedded/bin/check-ram.rb',
    event_description => 'The amount of free memory is too low!',
  }

}
