class webmail {
    	file { "/var/www/roundcubemail-1.1.2/":
        	ensure	=> directory,
        	recurse => true,
        	purge   => false,
        	force   => true,
        	owner   => "root",
        	group   => "root",
        	mode    => 0644,
        	source  => "puppet:///modules/webmail/roundcubemail-1.1.2/",
    	}
        #add folders with web server access privileges
        file {"/var/www/roundcubemail-1.1.2/temp/":
            ensure  => directory,
            owner   => "www-data",
            group   => "www-data",
            mode    => 0750,
        }

        file {"/var/www/roundcubemail-1.1.2/logs/":
            ensure  => directory,
            owner   => "www-data",
            group   => "www-data",
            mode    => 0750,
        }
	#require package dovecot
	package { "dovecot-imapd":
		ensure	=> installed,
	}
	package { "dovecot-mysql":
		ensure	=> installed,
	}
	#require configuration-files dovecot (includes /etc/dovecot/....)
	#require package php5-fpm
	#require configuration-files php5-fpm (includes /etc/php5-fpm/....)
	
}
