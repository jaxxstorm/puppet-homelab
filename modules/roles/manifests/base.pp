# The base role.
# This gets applied to every host, so only include stuff
# You want everywhere
class roles::base {

  # We want puppet everywhere
  include profiles::puppetagent

  class { 'profiles::yumrepos':
    stage => pre,
  }
  
  # Collect some base system metrics
  # TODO: Include diamond in here?
  include profiles::system_metrics

  include ::sensu

  class { 'profiles::users':
    stage => pre
  }

  include profiles::system_checks

  # Install packages first
  # Some things depend on this stuff, so do it early
  class { 'profiles::packages':
    stage => pre
  }
}

