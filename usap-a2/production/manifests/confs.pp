# Implements Questions 2, 4
# This class pushes out changes to configurations
class confs {
  # Question 2, pushes a managed puppet.conf that contains the check in interval
  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/puppet.conf'
  }

  # Question 4b, 
  #  Create the website folder
  file { '/var/www/s3482043':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0777',
    require => Package['httpd']
  }
  #  Pushes a managed httpd.conf that contains doc root settings (and custom port as puppet is using 80)
  file { '/etc/httpd/conf/httpd.conf':
    ensure  => present,
    path    => '/etc/httpd/conf/httpd.conf',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/httpd.conf',
    require => Package['httpd']
  }

  # Question 4a, pushes a managed sshd_config that prevents root logins
  file { '/etc/ssh/sshd_config':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/sshd_config',
    require => Package['openssh']
  }

  # Question 4c, pushes a managed sudoers to make becca a sudo
  file { '/etc/sudoers':
    ensure  => present,
    path    => '/etc/sudoers',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/sudoers'
  }

  #  Question 4f, Mount titan home directory for becca
  #   Make mount point
  file { '/home/becca/titan':
    ensure  => 'directory',
    owner   => 'root',
    mode    => '0777',
    require => User['becca']
  }
  #  pushes a managed fstab file to more permanently mount beccas titan connection
  file { '/etc/fstab':
    ensure  => present,
    path    => '/etc/fstab',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/fstab'
  }
  #  Mount immediately though
  exec { 'mount_titan':
    command => 'umount /home/becca/titan; sshfs s3482043@jupiter.csit.rmit.edu.au: /home/becca/titan -o password_stdin <<< "%712Ao8@xM01"',
    path    => '/usr/bin/:/usr/local/bin/:/bin/',
    require => User['becca']
  }

  # Managed so that mariadb-server can be subscribed to the file later
  file { '/etc/my.cnf':
    ensure  => present,
    path    => '/etc/my.cnf',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/my.cnf',
    require => Package['mariadb-server']
  }
}
