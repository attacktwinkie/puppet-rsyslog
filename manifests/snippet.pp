# == Define: rsyslog::snippet
#
# This class allows for you to create a rsyslog configuration file with whatever content you pass in.
#
# === Parameters
#
# [*content*] - The actual content to place in the file.
# [*ensure*]  - How to enforce the file (default: present)
#
# === Variables
#
# === Examples
#
#  rsyslog::snippet { 'my-rsyslog-config':
#    content => '<Some rsyslog directive>',
#  }
#
define rsyslog::snippet(
  $content,
  $ensure = 'present'
) {
  include rsyslog

  file { "${rsyslog::params::rsyslog_d}${name}.conf":
    ensure  => $ensure,
    owner   => $rsyslog::params::run_user,
    group   => $rsyslog::params::run_group,
    content => "${content}\n",
    require => Class['rsyslog::config'],
    notify  => Class['rsyslog::service'],
  }
}
