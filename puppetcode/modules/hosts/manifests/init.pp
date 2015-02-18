class hosts {
host  { 'testing.puppetlabs.vm':
comment  => "testing hosts",
ip => '127.0.0.1',
host_aliases => ['tarun'],
ensure => present,
target => '/etc/hosts',
}
}
