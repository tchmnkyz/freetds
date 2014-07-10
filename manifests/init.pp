# Class: freetds
#
# This module will install and manage freetds
#
# Parameters:
# 
# [*version*]
#   The TDS protocol version to use when connecting. Currently accepting: 4.2, 5.0, 7.0, 8.0, auto.
#   Default: 8.0
# 
# [*port*]
#   The port number that the dataserver is listening to.
#   Default: 1433
#
# [*install*]
#   This will tell the module if it needs to install the freetds package or not. Values: True|False
#
# [*ensure*]
#   This tells the module to either what to do with the package it is installing. Values: installed|latest|absent
#
# Requires: see Modulefile
#
# Sample Usage:
#
# This will use the defaults for everything. 
#   class {"freetds": }
#
# To customize things you could do:
#   class {"freetds": version => "4.2", install = false, }
#

class freetds (
  $version = $::freetds::params::version,
  $port = $::freetds::params::port,
  $install = $::freetds::params::install,
  $ensure = $::freetds::params::ensure,
) inherits ::freetds::params {
  if $install {
    class {"::freetds::package":
      install => $install,
      ensure => $ensure,
    }
  }
  
  concat{"${::freetds::params::config}":
    owner => root,
    group => root,
    mode  => '0644',
  }

  concat::fragment{"freetds_header":
    target => "${::freetds::params::config}",
    content => "### This file is managed by freetds puppet module. ###\n### Please do not make any Manual Changes! ###\n\n",
    order   => 01,
  }
  
  concat::fragment{"freetds_global_${name}":
    target => "${::freetds::params::config}",
    content => template("${module_name}/freetds.conf.erb"),
    order   => 10,
  }

}