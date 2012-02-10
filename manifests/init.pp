class resolv {
	define resolv::domain($server = false, $domain = false) {
		$t_servers = $server ? {
			false   => ["8.8.8.8"],
			default => $server,
		}

		$t_domains = $domain ? {
			false   => ["$domain"],
			default => $domain,
		}

		file { "$name":
			owner   => root,
			group   => root,
			mode    => 0644,
			content => template("resolv/common/etc/resolv.conf.erb"),
		}
	}

	resolv::domain { "/etc/resolv.conf":
		server => hiera_array('server'),
		domain => hiera_array('domain'),
	}
}

# vim: tabstop=3