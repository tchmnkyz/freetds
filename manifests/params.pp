class freetds::params {
  $install = true
  $ensure = installed
  $version = "8.0"
  $port = "1433"

  case $::osfamily {
    'debian': {
      $config = "/etc/freetds/freetds.conf"
    }
    'redhat': {
      $config = "/etc/freetds.conf"
    }
  }

  
}