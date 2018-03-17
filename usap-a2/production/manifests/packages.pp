# Implements Question 3.
# this class is where the various packages the system needs are definied
class packages {
  # include extra packages
  exec { 'RHEL-optionals':
    command => 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional',
    path    => '/usr/bin/:/usr/local/bin/:/bin/'
  }
  package { 'epel-release':
    ensure   => present,
    source   => 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
    provider => 'rpm'
  }
  # Install Packages
  package { 'openssh':
    ensure => present
  }
  package { 'httpd':
    ensure => present
  }
  package { 'mariadb':
    ensure => present
  }
  package { 'mariadb-server':
    ensure => present
  }
  package { 'tigervnc-server':
    ensure => present
  }
  package { 'tmux':
    ensure => present
  }
  package { 'dia2code-0.8.3-1':
    ensure   => present,
    source   => 'https://sourceforge.net/projects/dia2code/files/dia2code/0.8.3/dia2code-0.8.3-1.x86_64.rpm',
    provider => 'rpm'
  }
  package { 'lynx':
    ensure => present
  }
  package { 'gcc':
    ensure => present
  }
  package { 'gdb':
    ensure => present
  }
  package { 'cgdb':
    ensure   => present
  }
  package { 'vim':
    ensure => present
  }
  package { 'emacs':
    ensure => present
  }
  package { 'sshfs':
    ensure => present
  }
  package { 'tcsh':
    ensure => present
  }

  # Run Services
  service { 'sshd':
    ensure  => 'running',
    enable  => true,
    require => Package['openssh'],
    subscribe => File['/etc/ssh/sshd_config']
  }
  service { 'httpd':
    ensure  => running,
    enable  => true,
    require => Package['httpd'],
    subscribe => File['/etc/httpd/conf/httpd.conf']
  }
  service { 'mariadb':
    ensure  => 'running',
    enable  => true,
    require => Package['mariadb-server'],
    subscribe => File['/etc/my.cnf']
  }
}
