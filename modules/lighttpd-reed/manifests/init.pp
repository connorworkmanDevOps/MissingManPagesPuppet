class lighttpd-reed {
	package {
		"lighttpd": ensure => installed;
        "php5-cgi": ensure => installed;
	}

	file { "/etc/lighttpd/lighttpd.conf":
		notify	=> Service["lighttpd"],
		mode	=> 644,
		owner	=> "root",
		group	=> "root",
		source	=> "puppet:///modules/lighttpd-reed/lighttpd.conf",
		require => Package["lighttpd"],
	}

	file { "/var/www/index.html":
		mode	=> 644,
		owner	=> "root",
		group	=> "root",
		source	=> "puppet:///modules/lighttpd-reed/index.html",
		require => Package["lighttpd"],
	}

	file { "/var/www/otherfile.html":
		mode	=> 644,
		owner	=> "root",
		group	=> "root",
		source	=> "puppet:///modules/lighttpd-reed/otherfile.html",
		require => Package["lighttpd"],
	}

	file { "/var/www/cat.png":
		mode	=> 644,
		owner	=> "root",
		group	=> "root",
		source	=> "puppet:///modules/lighttpd-reed/cat.png",
		require => Package["lighttpd"],
	}

	file { "/etc/lighttpd/conf-enabled/10-userdir.conf":
		notify	=> Service["lighttpd"],
		ensure	=> link,
		target	=> "/etc/lighttpd/conf-available/10-userdir.conf",
		require => Package["lighttpd"],
	}

	file { "/etc/lighttpd/conf-enabled/10-accesslog.conf":
		notify	=> Service["lighttpd"],
		ensure	=> link,
		target	=> "/etc/lighttpd/conf-available/10-accesslog.conf",
		require => Package["lighttpd"],
	}

	service { "lighttpd":
		enable	=> true,
		ensure	=> running,
		require	=>	[ Package["lighttpd"],
				  File["/etc/lighttpd/lighttpd.conf"],
				],
	}

	service { "apache2":
		enable => false,
		ensure => stopped
		}


    file { "/etc/lighttpd/conf-enabled/10-fastcgi.conf":
		notify	=> Service["lighttpd"],
		ensure	=> link,
		target	=> "/etc/lighttpd/conf-available/10-fastcgi.conf",
		require => Package["lighttpd"],
	}

    file { "/etc/lighttpd/conf-enabled/15-fastcgi-php.conf":
		notify	=> Service["lighttpd"],
		ensure	=> link,
		target	=> "/etc/lighttpd/conf-available/15-fastcgi-php.conf",
		require => Package["lighttpd"],
	}
}
