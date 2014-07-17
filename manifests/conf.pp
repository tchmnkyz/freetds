define freetds::conf (
  $version = undef,
  $host = undef,
  $port = undef,
  $initial_block_size = undef,
  $try_server_login = undef,
  $try_domain_login = undef,
  $nt_domain = undef,
  $cross_domain_login  = undef,
  $dump_file = undef,
  $dump_file_append = undef,
  $debug_level = undef,
  $timeout = undef,
  $connection_timeout = undef,
  $emulate_little_endian = undef,
  $client_charset = undef,
  $text_size = undef,
) {
  include ::freetds::params

  if ! defined(Class['freetds']) {
    fail('Before you can use this resource, you must load the freetds base class!')
  }
  
  if ! $version {
    fail("You must specify which version to use for this definition!")
  } else {
    $valid_versions = "(4.2|5.0|7.0|7.1|7.2|8.0|auto)"
    validate_re($version, $valid_versions)
  }
  
  if ! $host {
    fail("You need to specify a host for this definition!")
  }
  
  if ! $port {
    fail("You need to specify a port for this definition!")
  }
  
  concat::fragment{"freetds_block_${name}":
    target => "${::freetds::params::config}",
    content => template("${module_name}/freetds-host.conf.erb"),
    order   => 25,
  }
  
}