# == Class: mailer
#
# Full description of class mailer here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { mailer:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class mailer {
	package { 'postfix':
	ensure => installed,
	}
	package { 'mailutils':
	ensure => installed,
	}

	file { '/etc/postfix/main.cf':
        source  => 'puppet:///modules/mailer/main.cf',
        mode    => 644,
        owner   => root,
        group   => 0,
        require => Package['postfix'],
    }

    service { 'postfix':
        enable    => true,
        ensure    => running,
        require   => [ Package['postfix'],
                       File['/etc/postfix/main.cf'] ],
        subscribe => File['/etc/postfix/main.cf'],
    }

}