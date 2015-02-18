class users::admins {
    group  { "_staff_":
      ensure => present,
      gid => 5000,
    }
    user { "_admin_":
      ensure => present,
      gid => "_staff_",
      shell => '/bin/csh'
    
    }
}
