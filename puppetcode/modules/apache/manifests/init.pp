class apache ($docroot = undef,){
if $docroot {
$httpd_docroot =  $docroot
} else {
$httpd_docroot = $::osfamily ? {

'redhat' => '/var/www/html',
'debian' => '/var/www',

}
}
  case $::osfamily {
'redhat':{
$httpd_user = 'apache'
$httpd_groups = 'apache'
$httpd_pkg ='httpd'
$httpd_svc = 'httpd'
$httpd_conf = 'httpd.conf'
$httpd_confdir = '/etc/httpd/conf'
$httpd_conf_dot_d = '/etc/httpd/conf.d'
  }
  'debian' :{
$httpd_user = 'www-data'
$httpd_groups = 'www-data'
$httpd_pkg ='apache2'
$httpd_svc = 'apache2'
$httpd_conf = 'apache2.conf'
$httpd_confdir = '/etc/apache2'
$httpd_docroot = '/var/www'
$httpd_conf_dot_d = '/etcapache2/conf.d'

  }


  }


  package  { $httpd_pkg :
    ensure => present,
    before => Service[$httpd_svc],
  }

  File {

    ensure => file,
    owner => $httpd_user,
    group => $httpd_group,
    mode => '0644',
  
  }
  file { '/var/www':
    ensure => directory,
  }
  file  { $httpd_docroot:
    ensure => directory,
  }
  file { "${httpd_docroot}/index.html":
    ensure => file,
    content => template('apache/index.html.erb'),
  }
  file { "${httpd_confdir}/${httpd_conf}":
    ensure => file,
    source => 'puppet:///modules/apache/httpd.conf',
    require => Package["${httpd_pkg}"],
    owner => 'root',
    group => 'root',
  
  }
  service { $httpd_svc:
    ensure => running,
    enable => true,
    subscribe => File["${httpd_confdir}/${httpd_conf}"],
  }
} 
