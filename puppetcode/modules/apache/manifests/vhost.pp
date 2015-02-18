define apache::vhost  ( 
$port ='80', $priority ='10',
$options ="Indexes MultiViews",
$vhost_name = $title, $servername = $title, 
$docroot = "${apache::httpd_docroot}/${title}"
) {
$docowner = $apache::httpd_user
$docgroup = $apache::httpd_group
$configdir = $apache::httpd_conf_dot_d
  host { $servername :

    ip => $::ipaddress
  }
  File {
  owner => $docowner,
  group => $docgroup,
  mode => '0644',
  }
  file {"/etc/httpd/conf.d/10-${title}.conf":
    ensure => present,
    notify => Service[$apache::httpd_svc],
    content => template('apache/vhost.conf.erb'),
    require => Package[$apache::httpd_pkg],
    

  }
  file { $docroot:
    ensure => directory,
    before  => File["/etc/httpd/conf.d/10-${title}.conf"],
  
  
  }
  file {"${docroot}/index.html":
    ensure => file,
    content => template("apache/index.html.erb"),
  
  }

}




