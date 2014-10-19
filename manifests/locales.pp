define freetds::locales (
  $date_format = undef,
  $language = undef,
  $charset = undef,
) {
  validate_string($date_format)
  validate_string($language)
  validate_string($charset)
  
  
  concat{"${::freetds::params::locales}":
    owner => root,
    group => root,
    mode  => '0644',
  }
  
  concat::fragment{"freetds_locales_${name}":
    target => "${::freetds::params::config}",
    content => template("${module_name}/locales.conf.erb"),
    order   => 10,
  }

  
}