package TrapFwd;

=head1 NAME

TrapFwd - Perl module to forward SNMP traps

=head1 VERSION

version 0.001

=cut

=head1 SYNOPSIS

  # within net-utils snmptrapd.conf:
  TBD

=cut
our $VERSION = '0.001';

use warnings;
use strict;

use Data::Dumper;
use JSON;
use Net::Syslog;
use NetSNMP::TrapReceiver;

$TrapFwd::syslog_facility = 'user';
$TrapFwd::syslog_host = 'localhost';
$TrapFwd::syslog_port = 514;
$TrapFwd::syslog_priority = 'info';

=head2 Methods

=over

=item C<process_trap>

Called from snmptrapd.
Accepts two arguments: 1) hash of trap properties and
2) array of [OID, value, type].

=cut

sub process_trap {
	my $trap_properties = shift; # hash
	my $varbinds = shift;   # array of [OID, value, type]

	#print STDERR "stderr RECEIVED TRAP\n"; # DEBUG
	#print STDERR Data::Dumper::Dumper($trap_properties); # DEBUG
	#print STDERR Data::Dumper::Dumper($varbinds); # DEBUG

	$trap_properties->{receivedfrom} =~ /\S+: \[(\d+\.\d+\.\d+\.\d+)\]/;
	my $trap_source = $1 || '0.0.0.0';

	my $message = { };
	foreach my $varbind ( @$varbinds ) {
		my $oid_str = "$varbind->[0]";
		my ( $t, $v ) = $varbind->[1] =~ /^(.*?):\s(.*)/;
		$message->{$oid_str} = $v;
		$message->{$oid_str . '_type'} = $t;
		$message->{$oid_str . '_length'} = $varbind->[2];
	}

	# setting these AFTER varbinds to ensure they aren't overwritten
	#$message->{snmp_community} = $trap_properties->{community} || '';
	$message->{snmp_version} = $trap_properties->{version} || 0;
	$message->{trap_source} = $trap_source;

	my $s = Net::Syslog->new(
		Facility => $TrapFwd::syslog_facility,
		Priority => $TrapFwd::syslog_priority,
		SyslogHost => $TrapFwd::syslog_host,
		SyslogPort => $TrapFwd::syslog_port,
		#rfc3164 => 1,
	);
	$s->send(encode_json $message);

	return NETSNMPTRAPD_HANDLER_OK;
}

1;
__END__
=back

=head1 AUTHOR

Doug Schaapveld E<lt>djschaap@gmail.comE<gt>

=head1 SEE ALSO

L<NetSNMP::TrapReceiver>

=cut
