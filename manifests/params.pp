class freetds::params {
  $install = true
  $ensure = installed
  $version = "8.0"
  $port = "1433"

  case $::osfamily {
    'debian': {
      $config = "/etc/freetds/freetds.conf"
      $locales = "/etc/freetds/locales.conf"
    }
    'redhat': {
      $config = "/etc/freetds.conf"
      $locales = "/etc/locales.conf"
    }
  }

  
}