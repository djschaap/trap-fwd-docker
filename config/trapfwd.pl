#!/usr/bin/perl

use TrapFwd;

sub handle_trap {
	TrapFwd::process_trap(@_);
}

if ( $ENV{RSYSLOG_HOST} ) {
	$TrapFwd::syslog_host = $ENV{RSYSLOG_HOST};
}
if ( $ENV{RSYSLOG_PORT} ) {
	$TrapFwd::syslog_port = $ENV{RSYSLOG_PORT};
}

NetSNMP::TrapReceiver::register("default", \&handle_trap)
	or warn "failed to register handler: " . $@;

print STDERR "TrapFwd: registered\n";
